From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile git)
Date: Mon, 6 Aug 2007 01:41:30 +0200
Message-ID: <e7bda7770708051641h15bd38abo659e74322e6232c0@mail.gmail.com>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site>
	 <460B6BF8541C4D9B916F02A12E0576F5@ntdev.corp.microsoft.com>
	 <46B2D4D9.4020103@trolltech.com>
	 <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com>
	 <Pine.LNX.4.64.0708031334530.14781@racer.site>
	 <E3C81783E0454702B1F38D0B68CE1AC0@ntdev.corp.microsoft.com>
	 <Pine.LNX.4.64.0708032231320.14781@racer.site>
	 <e7bda7770708031716i61f80d89o8970b3236a961613@mail.gmail.com>
	 <Pine.LNX.4.64.0708040123560.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>,
	"Marius Storm-Olsen" <marius@trolltech.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 06 01:41:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHpj6-0003N4-1c
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 01:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756933AbXHEXlc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 5 Aug 2007 19:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755792AbXHEXlc
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 19:41:32 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:65020 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754AbXHEXlb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 19:41:31 -0400
Received: by py-out-1112.google.com with SMTP id d32so2188261pye
        for <git@vger.kernel.org>; Sun, 05 Aug 2007 16:41:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z/oCFdnPZrCkrGMS+VQfg9gUbK8Cu0xMUgzTxK1gGM3VIXRu+3rBI9/c27INAvOdB5hQhjMskDgtjTc7FGkYmJyKmhKx5jKIBw4IBl+yvJ/IO7ZlwTwxCBGrknjjUbuJW6iB+Ij74omBX/bOeS5g07JuVgqe5CI5URhqrjR2hPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JfnAMe6cIWZBsTIKKthDFw3/eT03BepdHdniLbGg+3RUsEZ8aqKwUBFCD3AHwVskZGFyxFPv9xWYmYKi87AP1YB0kRcQY37M2rkZj0qPa9Q9MAzUGaVNeCUuRu1+ZYoIOOJbIBYmfhBsmdFC7SNHLs5h0IWUIYcXkjymVqQqApE=
Received: by 10.65.61.5 with SMTP id o5mr7870755qbk.1186357290517;
        Sun, 05 Aug 2007 16:41:30 -0700 (PDT)
Received: by 10.65.141.5 with HTTP; Sun, 5 Aug 2007 16:41:30 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708040123560.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55085>

On 8/4/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>

Hi

Thank you for your reply.

> > 1. Unpacking in a folder that have space in it's path gave various
> > errors of this type (here, msysGit is unpacked on the desktop
> > C:\Documents and settings\.... ) : make[1]: C:/Documents: Command n=
ot
> > found
>
> Good point.  Did you fix it?  If so, where is the patch?  Or even bet=
ter,
> what is your account on repo.or.cz so I can add it, and you can commi=
t
> your fix yourself?

I didn't. I bypassed it (unpacked to C:\). I found the bug however
(missed quoting):

$ diff -urN msysGit msysGit-fixed
diff -urN msysGit/git/git-gui/Makefile msysGit-fixed/git/git-gui/Makefi=
le
--- msysGit/git/git-gui/Makefile        Fri Aug  3 15:00:16 2007
+++ msysGit-fixed/git/git-gui/Makefile  Mon Aug  6 01:22:53 2007
@@ -4,7 +4,7 @@
 #

 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
-       @$(SHELL_PATH) ./GIT-VERSION-GEN
+       @"$(SHELL_PATH)" ./GIT-VERSION-GEN
 -include GIT-VERSION-FILE

 uname_O :=3D $(shell sh -c 'uname -o 2>/dev/null || echo not')
diff: msysGit/git/gitweb/test/M?=A4rchen: No such file or directory
diff: msysGit-fixed/git/gitweb/test/M?=A4rchen: No such file or directo=
ry


I'll make an account and send you the details when I get an public
SSH-key, haven't done that in windows before. Can I share private key
on both windows and Linux box?


> > 2. rxvt-terminal had some freezes
> I did not experience those.  Could you research further?

Some observations:
"git log" on mingw archive trigger this every time for me (hangs on
different places each time).

"cmd" terminal (msys.bat) seems to pipe "git log" to less while rxvt
terminal outputs lots of text very fast (msys-rxvt.bat) and freezes.
Output:ing lots of text itself doesn't seem to be an issue ("make -d"
doesn't freeze and outputs _lots_ of text)


> > 3. "gitk --all" said "Error reading commits: fatal: write failure o=
n
> > stdout: Invalid argument"
> I did not even bother testing gitk...  Any idea what is going wrong?

The fconfigure -blocking command seems to be not supported under
mingw. This patch makes the error go away. Another issue that is
probably related to this is that gitk doesn't list all commits. I
don't know how to solve this properly.

diff --git a/gitk b/gitk
index 43d88ca..69e5149 100755
--- a/gitk
+++ b/gitk
@@ -147,7 +147,7 @@ proc getcommitlines {fd view}  {
        unset commfd($view)
        notbusy $view
        # set it blocking so we wait for the process to terminate
-       fconfigure $fd -blocking 1
+       #fconfigure $fd -blocking 1
        if {[catch {close $fd} err]} {
            set fv {}
            if {$view !=3D $curview} {


$ grep '\-blocking' gitk | wc -l
     10

(all sets blocking to 0 except for the one in getcommitlines above)



> > 4. Mouse-wheel didn't work to scroll views in gitk
>
> Again, no idea why.  Could you please investigate?

Tough one since I didn't take the tcl tk debugging class. Doesn't work
for me in cygwin either. I don't know if it's implemented at all. Does
it work for anyone else?


//Torgil
