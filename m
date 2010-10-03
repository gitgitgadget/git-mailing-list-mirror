From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv5 15/16] Add missing &&'s throughout the testsuite
Date: Sun, 3 Oct 2010 13:39:45 -0600
Message-ID: <AANLkTin3vtqGJDC4hrmKpFZ6e+Sw5OP15QPjO16cxgkx@mail.gmail.com>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
	<1286082644-31595-16-git-send-email-newren@gmail.com>
	<20101003144650.GE17084@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 21:39:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2UPY-0007bH-Rn
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 21:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760Ab0JCTjr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 15:39:47 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58645 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754711Ab0JCTjr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 15:39:47 -0400
Received: by fxm14 with SMTP id 14so1394348fxm.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 12:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SPoNmNV5oXCUy0INNl3hT+2WJlncbrBtwXgtiAih45U=;
        b=MrIkvibUD0fyHLxu7RCHzVce3P0CExR3p1AvWI6ZeKb3wD/K58op47fTN0wi4hZ7Zq
         gCjbSSTe5JPzfdaHe7z/HquiwYEmTWgCaQcmdtJBcbvD6uQWwois7/kWmnfGpIDCimAz
         hjLJY1k9og7dEGkPbLd2NrkLxL2isulSRb3Mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=R0CAPP5sZffg2XQcbreebOQSvvD3d/SNG5qBRXE8hZN6VhZ/dOGKLNOsLNp2xHPmZO
         dCjLiBfE/5UO2e1g17u8Fq5MXP11JGH8ORnUEWNOZOP+BLQm94BKjtOXSzJcV/NzlP3K
         z7iq0JkpTUxUjYw4Wdfb3ifBLjkI6S9hzENs8=
Received: by 10.223.101.18 with SMTP id a18mr8057938fao.19.1286134785976; Sun,
 03 Oct 2010 12:39:45 -0700 (PDT)
Received: by 10.223.126.70 with HTTP; Sun, 3 Oct 2010 12:39:45 -0700 (PDT)
In-Reply-To: <20101003144650.GE17084@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157897>

On Sun, Oct 3, 2010 at 8:46 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
>> --- a/t/t1509-root-worktree.sh
>> +++ b/t/t1509-root-worktree.sh
>> @@ -232,8 +232,8 @@ say "auto bare gitdir"
>>
>> =C2=A0# DESTROYYYYY!!!!!
>> =C2=A0test_expect_success 'setup' '
>> - =C2=A0 =C2=A0 rm -rf /refs /objects /info /hooks
>> - =C2=A0 =C2=A0 rm /*
>> + =C2=A0 =C2=A0 rm -rf /refs /objects /info /hooks &&
>> + =C2=A0 =C2=A0 rm /* &&
>
> I'm worried that this would fail:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ mkdir foo
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ cd foo
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ >bar
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ mkdir baz
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ rm *
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rm: cannot remove `baz': Is a directory
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ echo $?
> =C2=A0 =C2=A0 =C2=A0 =C2=A01

How about replacing the two rm commands with a simple 'rm -rf /*'?

> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_expect_success 'did not use upload-pa=
ck service' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0! grep '/git-u=
pload-pack' <"$HTTPD_ROOT_PATH"/access.log
> =C2=A0 =C2=A0 =C2=A0 =C2=A0'
>
> This way, (like before) one would get to see the git-upload-pack line=
s
> when the test fails while running with -v.

Make sense.

>> - =C2=A0 =C2=A0 ln -s docs/manual.txt src/part4.c
>> + =C2=A0 =C2=A0 ln -s docs/manual.txt src/part4.c &&
>> =C2=A0 =C2=A0 =C2=A0 git clean &&
>> =C2=A0 =C2=A0 =C2=A0 test -f Makefile &&
>> =C2=A0 =C2=A0 =C2=A0 test -f README &&
>
> Missing SYMLINKS prereq?

Indeed.
