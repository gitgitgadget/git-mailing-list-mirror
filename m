From: Jundong Xue <tomxue0126@gmail.com>
Subject: Re: [PATCH] Can show relative date of the commit with future timestamp
Date: Fri, 6 Jul 2012 16:15:25 +0800
Message-ID: <CA+P7oHtGsBoRGsUzg4qqm7sZJ=+1Jh06Gmj1uw+k0-S9Gk+DXQ@mail.gmail.com>
References: <1341505087-13632-1-git-send-email-tomxue0126@gmail.com>
	<7vy5myqftw.fsf@alter.siamese.dyndns.org>
	<CA+P7oHuCbeJ5shfL5OVhSypgygzmQwn-RGPD8UvFUFuqnoV9fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 10:15:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sn3hT-0001to-Bj
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 10:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747Ab2GFIPc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jul 2012 04:15:32 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46536 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234Ab2GFIP1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jul 2012 04:15:27 -0400
Received: by yhmm54 with SMTP id m54so9115759yhm.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 01:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=qgGmfmNyQ/Tbry8IVr65q7cz10PaxvhG4sc1Bo7ExXA=;
        b=0qi34qTL5zVPMFDEIaS2LFe+DQmBXWlJpZCmz1a2krsdyNcrSkzz/q1S69haxhW+1n
         7LD1AkAQwFM5HSpmK+2EPyfd3g1MEJSirr0HfFFtVgs/oYKn8gEykoOifio5wJIPjONq
         WrMzka8jV3LrClQclPPUVSBcIx8jqTvQCVMYTtWEAwv0SgDAo5hlGXjH5nYG653j5ujO
         pd9I4NCc0FwRlkFzbhIykjSEV16ncWaZgfKAzDj6XAaf57OqmQrZsPIFbUulHxkWJE0Z
         bZkWYKKMSmCEK4kNKIncBb3vtXWG3L+z1Aei3vcwy0ezwO0/uLFf5Pg5XiN3m5JrNoze
         lkVw==
Received: by 10.50.154.233 with SMTP id vr9mr1940964igb.9.1341562525782; Fri,
 06 Jul 2012 01:15:25 -0700 (PDT)
Received: by 10.43.100.131 with HTTP; Fri, 6 Jul 2012 01:15:25 -0700 (PDT)
In-Reply-To: <CA+P7oHuCbeJ5shfL5OVhSypgygzmQwn-RGPD8UvFUFuqnoV9fA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201092>

I find an interesting and useful usage of git: todo/timeline.
=46or this purpose I just make a git repo and all the commits with
specified timestamp: some in the past, e.g. the date I was born; some
in the future, e.g. todo list.

I config my ~/.gitconfig as below:
[alias]
    lg1 =3D log --graph --all --format=3Dformat:'%C(bold blue)%h%C(rese=
t)
- %C(bold green)(%cr)%C(reset) %C(green)%s%C(reset) %C(bold white)=A1=AA
%cn%C(reset)%C(bold yellow)%d%C(reset)' --abbrev-commit
--date=3Drelative
    lg =3D !"git lg1"
    todo =3D !"git lg" | grep future | grep --color -E
'future|days|hours|minutes|seconds'

tomxue@ubuntu:~/mycode/life$ git todo
* d768da9 - (in the future: 3 hours later) Meeting with vendor =A1=AA T=
om
Xue (HEAD, master)
* 5fcd556 - (in the future: 12 days later) Take my personal holiday =A1=
=AA Tom Xue
* 9dd280b - (in the future: 11 months later) =B6=CB=CE=E7=BD=DA =A1=AA =
Tom Xue
* 4680099 - (in the future: 9 months later) =C7=E5=C3=F7=BD=DA =A1=AA T=
om Xue
* 59d5266 - (in the future: 8 months later) =D4=AA=CF=FC=BD=DA =A1=AA T=
om Xue
* b5308da - (in the future: 7 months later) =B3=FD=CF=A6 =A1=AA Tom Xue
* 3fe2e71 - (in the future: 4 months later) =D6=D8=D1=F4=BD=DA =A1=AA T=
om Xue
* 4fad90c - (in the future: 3 months later) =D6=D0=C7=EF =A1=AA Tom Xue
* 3dfec58 - (in the future: 7 weeks later) =C6=DF=CF=A6 =A1=AA Tom Xue
* f547a6e - (in the future: 7 months later) =CE=D2=B5=C4=D2=F5=C0=FA=C9=
=FA=C8=D5: 12-18 =A1=AA Tom Xue
* 5d4d240 - (in the future: 7 months later) =CE=D2=B5=C4=D1=F4=C0=FA=C9=
=FA=C8=D5 =A1=AA Tom Xue
* 5b165e7 - (in the future: 9 months later) Father=D2=F5=C0=FA=C9=FA=C8=
=D5: =D2=F5=C0=FA3-6 =A1=AA Tom Xue
* 7b73d53 - (in the future: 10 months later) Father=D1=F4=C0=FA=C9=FA=C8=
=D5 =A1=AA Tom Xue
* b6cd036 - (in the future: 6 months later) Mother=D2=F5=C0=FA=C9=FA=C8=
=D5: =D2=F5=C0=FA11-23 =A1=AA Tom Xue
* 97c5163 - (in the future: 6 months later) Mother=D1=F4=C0=FA=C9=FA=C8=
=D5 =A1=AA Tom Xue
* f96843c - (in the future: 5 months later) Brother=D2=F5=C0=FA=C9=FA=C8=
=D5: =D2=F5=C0=FA11-4 =A1=AA Tom Xue
* c4a5432 - (in the future: 5 months later) Brother=D1=F4=C0=FA=C9=FA=C8=
=D5 =A1=AA Tom Xue
* e1bfba1 - (in the future: 4 months later) Afei=D1=F4=C0=FA=C9=FA=C8=D5=
 =A1=AA Tom Xue
* b551e6c - (in the future: 4 months later) Afei=D2=F5=C0=FA=C9=FA=C8=D5=
: =D2=F5=C0=FA9-25 =A1=AA Tom Xue
* 0d7e644 - (in the future: 7 weeks later) =BC=D2=C8=CB=C0=B4=BE=A9=BC=C6=
=BB=AE=C6=F4=B6=AF =A1=AA Tom Xue
* 6e7ba31 - (in the future: 10 months later) Mother's day: 2nd
Sunday@May =A1=AA Tom Xue
* 4fc7701 - (in the future: 12 months later) Father's day: 3rd
Sunday@June =A1=AA Tom Xue
* 69a582e - (in the future: 10 months later) Dropbox 100G deadline =A1=AA=
 Tom Xue

And I take a screenshot of it, which is colorful and more impressive
=46YI. The link is below.
https://www.box.com/s/84b9cf402ea9419c7fe2

The link is just a picture and safe.

Except that, I think to give some accurate relative date of future
timestamp commit is also not bad.
If I make this kind of commit, I hope not only to see "in the future",
but also to see "how long/far in the future".

BR,
Tom
