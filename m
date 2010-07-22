From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Running git on Windows command line
Date: Thu, 22 Jul 2010 20:38:41 +0200
Message-ID: <AANLkTimXZtlRKlAVuFH5TzzQ1z19ddYazIRKIgGALMpZ@mail.gmail.com>
References: <1A9EA7E081C3FE46A0F446FFB66D10EB939B8A@FL01EXMB01.trad.tradestation.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 20:49:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc0px-0003sx-HO
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 20:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759977Ab0GVStU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jul 2010 14:49:20 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50235 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759605Ab0GVStQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jul 2010 14:49:16 -0400
Received: by wwj40 with SMTP id 40so3793295wwj.1
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 11:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=spUwk07RNfqcIm2l7ODciLxRJCBMSuTBSxAyMMPtXjw=;
        b=PizbBWThS5qlYb/1LMF/3zSk6LAetz8DhXCDDB1V51nOfsS9koYQ9BTYQUvUB9Hpu/
         VrlR1cfeqU64H7O8WdjvUVolmA3l3+KjSqC2dWij0Ow7EGSkCLNEHV+pceij+d16rQaI
         5O5I1FejzC+MbCbTqdOIzyETp8irj7Xvr+HLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=p5VmKo+YlrbpUokyhcV4R7hSqApxEMK3vdxV6PSYJr37CCtRXL23JnzmFZaPz6S7F+
         gf6rCrXTl0smcCxqNR6E/d1PKpbf7nFhuEtcvj9fNATEycA0Rs+a6ccs6KhF4nPr6V/J
         XEACGOkv/gVQXruAGb3um/FjVU4FXhpZ/ImMc=
Received: by 10.216.170.130 with SMTP id p2mr2234244wel.94.1279823921713; Thu, 
	22 Jul 2010 11:38:41 -0700 (PDT)
Received: by 10.216.70.67 with HTTP; Thu, 22 Jul 2010 11:38:41 -0700 (PDT)
In-Reply-To: <1A9EA7E081C3FE46A0F446FFB66D10EB939B8A@FL01EXMB01.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151470>

On Thu, Jul 22, 2010 at 6:31 PM, John Dlugosz <JDlugosz@tradestation.co=
m> wrote:
> In the "CRLF behavior" thread, I found that my command line was not s=
eeing the global settings. =A0This gave different results than the git-=
gui and naturally is a serious problem.
>
> This note is to record my findings and will hopefully be valuable to =
others using Windows.
>
> In Windows, users may be using the built-in CMD.exe, the Powershell, =
some other unix-like shell besides the one that comes up under "git bas=
h here", or others.
>
> I found that it worked correctly on a plain CMD shell with no persona=
l preferences loaded or anything, even though the HOME environment vari=
able does not exist. =A0It did not work right on my normal shell (happe=
ns to be TCC-le) which was set up about two years ago, until I added th=
e HOME variable to my initialization script.
>
> The plain command line adds "C:\Program Files (x86)\Git\cmd" to the P=
ATH, and the git command resolves to git.cmd in that directory. =A0The =
latest msysgit installer set up that path globally. =A0Perhaps an earli=
er version arranged things differently? =A0Anyway, the TCC command line=
 had an alias set up so git resolved to "C:\Program Files (x86)\Git\bin=
\git.exe", without searching. =A0If the situation changed with updates,=
 it did not affect my set up there.
>
> One of the things the git.cmd batch file does is set the HOME variabl=
e. =A0It also sets the code page and sets the PATH to include a couple =
things along the git tree. =A0Two years ago, I found that no such PATH =
was necessary once git.exe itself was launched; it apparently knows whe=
re everything else is. =A0One of the things it adds to PATH, %git_insta=
ll_root%\mingw\bin, does not even exist! =A0So this script may be dated=
=2E
>
> I'd be interested in finding out what the real story here is, if anyo=
ne knows more about it.

The msysGit (the development environment for Git for Windows)
installer does not modify the system-wide path, but the Git for
Windows installer does. Perhaps you've previously been using msysGit
instead of Git for Windows?

--=20
Erik "kusma" Faye-Lund
