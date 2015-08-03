From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v7 0/11] port tag.c to use ref-filter APIs
Date: Mon, 3 Aug 2015 12:52:31 +0530
Message-ID: <CAOLa=ZS1GkN3KHRk2NauC64gye9HOM_LLR0uvDHMDh--UWmrPg@mail.gmail.com>
References: <CAOLa=ZQG4Oz4aSGLNQxcRB4vNo3DQn_V96H-aCD=krSSoA9JGQ@mail.gmail.com>
 <vpqoaipbnpa.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 03 09:23:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMA5U-0004HK-P5
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 09:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbbHCHXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 03:23:03 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:36006 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbbHCHXB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 03:23:01 -0400
Received: by obnw1 with SMTP id w1so92628582obn.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 00:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7mrgQaSxh1oTGkIjZdAddWj0WSCLbx8fRaJFlJJyflg=;
        b=miTVsKFNXZacr6hOkw5jlXOV30q/Fxy9xOX+qdcwiivI8dMbaKcp45788RZnarAyyN
         Oh4RMwP9IVskDx+6yhk3NUkA2Ye5E5emsfd3AtrTS/T2mqjZe5JMaZxl5lRKIGMSGNjE
         L0qqhWcLrknz2e6a04GGLeWx9z6rOUS+wRG8QxKx5LhmAEfh8zvczp8yIK5yPIApIlGk
         got2F3kffygwDBnjQ1iQWQ4aw9sVFVKylsfQQJaCpAwhybF75AteXYONHNmkvlDzZTUo
         3+Mbu28Jwk3AjhNTR71eNHShC19PchqDfyT8opb3Lr+8gWNRySAW2BYAKw39toouptdn
         zaPw==
X-Received: by 10.60.177.195 with SMTP id cs3mr14830964oec.37.1438586580905;
 Mon, 03 Aug 2015 00:23:00 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 3 Aug 2015 00:22:31 -0700 (PDT)
In-Reply-To: <vpqoaipbnpa.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275156>

On Sun, Aug 2, 2015 at 11:02 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +test_expect_success 'no padding when `padright` length is smaller than atom length' '
>> +    cat >expect <<-\EOF &&
>> +    refs/heads/master|
>> +    refs/heads/side|
>> +    refs/odd/spot|
>> +    refs/tags/double-tag|
>> +    refs/tags/four|
>> +    refs/tags/one|
>> +    refs/tags/signed-tag|
>> +    refs/tags/three|
>> +    refs/tags/two|
>> +    EOF
>> +    git for-each-ref --format="%(padright:5)%(refname)|" >actual &&
>>      test_cmp expect actual
>>  '
>
> Nit: I think the test would be better with padright:15 for example, to
> show that some lines are aligned and some go beyond the 15 columns.
>

I've added something like this :)


-- 
Regards,
Karthik Nayak
