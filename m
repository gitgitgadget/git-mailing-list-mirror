From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 6/6] diff: shortcut for diff'ing two binary SHA-1 objects
Date: Fri, 15 Aug 2014 19:11:26 +0700
Message-ID: <CACsJy8CO-5+Nodh19kiWP-YEFChqptf7_nFs=zFvzNJ23HmOgQ@mail.gmail.com>
References: <1403610336-27761-1-git-send-email-pclouds@gmail.com>
 <1407927454-9268-1-git-send-email-pclouds@gmail.com> <1407927454-9268-7-git-send-email-pclouds@gmail.com>
 <xmqq38cz2ehr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Dale R. Worley" <worley@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 14:12:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIGMV-0005bd-V2
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 14:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbaHOML6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2014 08:11:58 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:38980 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbaHOML5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Aug 2014 08:11:57 -0400
Received: by mail-ig0-f182.google.com with SMTP id c1so1619022igq.3
        for <git@vger.kernel.org>; Fri, 15 Aug 2014 05:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=JnfZrlsihwVuDShIzBHZC7uY16AwstTk9yqPk1ToNY8=;
        b=W6s8Zm8ONw5ly0wI5Ucb6qi7U/jJm4yCBTXLzqQSzvETstYfQVPHaY/sN8U72zEfhi
         +MkGkpfzBrWiVA4Ue/YT8RkYFw44q2o43UEhSjO4PlXTk3hTaUS99+p1+OZJwl2jJq8M
         bcoHd6+2Drgx5YcLIWRK3BYymcg7I/hXQKMyCSaQBucNW2TWdhr4SDzI4/D2YSAOg8qY
         nR3kFvEAs3lQdz9xkNKLCZ8QiiQc1gJmga600kn9n0Mgu9/r0jpGEgE9IO9yOAL1tvPl
         6efy5J10YPueYCHMTduxIoFGKIa5x/o103hsVpEBaksHK4A05t8Bf24yDhB+5Doh/CPG
         z1RA==
X-Received: by 10.50.87.10 with SMTP id t10mr65074963igz.41.1408104717028;
 Fri, 15 Aug 2014 05:11:57 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Fri, 15 Aug 2014 05:11:26 -0700 (PDT)
In-Reply-To: <xmqq38cz2ehr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255286>

On Fri, Aug 15, 2014 at 12:00 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
>> index 711f22c..b294963 100755
>> --- a/t/t1050-large.sh
>> +++ b/t/t1050-large.sh
>> @@ -116,6 +116,14 @@ test_expect_success 'diff --stat' '
>>       git diff --stat HEAD^ HEAD
>>  '
>>
>> +test_expect_success 'diff' '
>> +     git diff HEAD^ HEAD
>> +'
>> +
>> +test_expect_success 'diff --cached' '
>> +     git diff --cached HEAD^
>> +'
>
> What are these checking?  No check for their outcome?

The first test in this file set $GIT_ALLOC_LIMIT and these commands
would not succeed without the patch. But yes I can check the "binary
files differ" too.
--=20
Duy
