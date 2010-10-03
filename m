From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv5 07/16] t3600 (rm): add lots of missing &&
Date: Sun, 3 Oct 2010 13:37:11 -0600
Message-ID: <AANLkTinYkq+e5gPxRMSNHqk9zqyku+NPpUYXJMXL0R_0@mail.gmail.com>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
	<1286082644-31595-8-git-send-email-newren@gmail.com>
	<20101003142855.GC17084@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 21:37:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2UN6-0007BM-9y
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 21:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740Ab0JCThN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 15:37:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48664 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597Ab0JCThM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 15:37:12 -0400
Received: by fxm14 with SMTP id 14so1393854fxm.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 12:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3ZShJ3ySgSIHD34hPlIgNuU3AvG6q4SDqfYivJWOlFQ=;
        b=UPcFylbM6aECebpy+wPq2LaWRg//DYbOuu1wb8/RnBT9g3fIvLNuIbfj8kve7qr5v3
         26PXWZ7hYdWTQOpRNfjRhrK9+XKXedGfrKgNcjD1ZRhMrxz0QBKOG22AcNwseRReh4EM
         icTD51/btHSeRQwA+vKcBwwt/CrNyQ+EfhHcc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dQIxhZ2ikxWn8UpvDnLx8C6IoE/1Edq9+CmgRaMH4hDlHxok3+NB9Lj4yU0SDvmiZk
         Ci+iLkU12T3JGD3nY++z9JY4nWeR+/ZGqkRW8zgZqV3RJXNlz3SVZ71a4AljCFI+kLO+
         qu8hF0Fv2IZ9cPP4OwdjhY3XNOeQKBAu33owo=
Received: by 10.223.123.212 with SMTP id q20mr634663far.28.1286134631364; Sun,
 03 Oct 2010 12:37:11 -0700 (PDT)
Received: by 10.223.126.70 with HTTP; Sun, 3 Oct 2010 12:37:11 -0700 (PDT)
In-Reply-To: <20101003142855.GC17084@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157896>

On Sun, Oct 3, 2010 at 8:28 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
>> --- a/t/t3600-rm.sh
>> +++ b/t/t3600-rm.sh
>> @@ -38,37 +38,33 @@ test_expect_success \
> [...]
>> =C2=A0test_expect_success \
>> =C2=A0 =C2=A0 =C2=A0'Test that git rm --cached foo fails if the inde=
x matches neither the file nor HEAD' '
>> - =C2=A0 =C2=A0 echo content > foo
>> - =C2=A0 =C2=A0 git add foo
>> - =C2=A0 =C2=A0 git commit -m foo
>> + =C2=A0 =C2=A0 git checkout HEAD -- foo &&
> [...]
>
> Why not
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- =C2=A0 =C2=A0 =C2=A0 echo content > foo
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- =C2=A0 =C2=A0 =C2=A0 git add foo
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- =C2=A0 =C2=A0 =C2=A0 git commit -m foo
> =C2=A0 =C2=A0 =C2=A0 =C2=A0+ =C2=A0 =C2=A0 =C2=A0 echo content > foo =
&&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0+ =C2=A0 =C2=A0 =C2=A0 git add foo &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0+ =C2=A0 =C2=A0 =C2=A0 git commit --allow-=
empty -m foo &&
>
> ?

What advantage does using these three commands have over 'git checkout
HEAD -- foo'?  Perhaps I'm missing something, but I don't see it.
It's three commands to one, and the tests don't depend on foo starting
with contents of 'content'; just that foo matches HEAD to start.

However, I'm fine with this alternative as well, if others prefer it.
