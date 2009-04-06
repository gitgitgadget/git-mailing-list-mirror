From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: Running 'git pull' from an unnamed branch
Date: Mon, 6 Apr 2009 23:05:27 +0200
Message-ID: <200904062305.28242.markus.heidelberg@web.de>
References: <3f4fd2640904051433u199587c3wc9bf080d138944e7@mail.gmail.com> <3f4fd2640904060042m438a3a8en2d2746a6216b2b95@mail.gmail.com> <20090406100305.GD20356@atjola.homenet>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Reece Dunn <msclrhd@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 06 23:08:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqw1u-00046O-IN
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 23:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758860AbZDFVFV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 17:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758853AbZDFVFT
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 17:05:19 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:37175 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbZDFVFS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2009 17:05:18 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 0E8C4FA0CBA3;
	Mon,  6 Apr 2009 23:05:16 +0200 (CEST)
Received: from [89.59.82.208] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1Lqw0J-0005oQ-00; Mon, 06 Apr 2009 23:05:15 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20090406100305.GD20356@atjola.homenet>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+nIpCzS7tnvz04lSLjd0k1v5Fd2eWsJt4K2Mak
	vlY/Q07S57szZGC5pW4RSv9R9sSVx0FGzM70EXylw8mWCaHqaf
	0xCZT9PXb8PFnd094yFw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115881>

Bj=F6rn Steinbrink, 06.04.2009:
> Maybe:
> You asked me to pull without telling me which branch you want to merg=
e
> with and as you have no branch checked out, I cannot look for any
> defaults to use.

Hmm, let's prove this.

> Please name which branch you want to merge on the
> command line and try again

Set the config options:

    $ git config branch..remote origin
    $ git config branch..merge refs/heads/master

Verify them:

    $ git config branch..remote
    origin
    $ git config branch..merge
    refs/heads/master

=46ine, the unnamed branch is set up properly for git-pull.
It _has_ to work.

    $ git checkout origin/master~1
    Note: moving to "origin/master" which isn't a local branch
    If you want to create a new branch from this checkout, you may do s=
o
    (now or later) by using -b with the checkout command again. Example=
:
      git checkout -b <new_branch_name>
    HEAD is now at fbdc056... Merge branch 'jc/name-branch'

Never mind. I can ignore this message, I don't need a real branch.
git-pull will work, since I set up defaults for the unnamed branch
properly.

    $ git pull
    You asked me to pull without telling me which branch you
    want to merge with, and 'branch..merge' in
    your configuration file does not tell me either.  Please
    name which branch you want to merge on the command line and
    try again (e.g. 'git pull <repository> <refspec>').
    See git-pull(1) for details on the refspec.
   =20
    If you often merge with the same branch, you may want to
    configure the following variables in your configuration
    file:
   =20
        branch..remote =3D <nickname>
        branch..merge =3D <remote-ref>
        remote.<nickname>.url =3D <url>
        remote.<nickname>.fetch =3D <refspec>
   =20
    See git-config(1) for details.

Hey, above I've made sure, that branch..remote and branch..merge were
set up properly.

Damn :)
