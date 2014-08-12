From: Panos Rontogiannis <p_ronto@hotmail.com>
Subject: git-status rename conflict with a few git-adds following a git-mv
 (git for windows 1.9.4)
Date: Tue, 12 Aug 2014 12:48:53 +0300
Message-ID: <DUB121-W21E71C6BC416DC373C068388EA0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 12 11:54:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XH8mR-0007r9-3S
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 11:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbaHLJyF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Aug 2014 05:54:05 -0400
Received: from dub004-omc3s8.hotmail.com ([157.55.2.17]:62262 "EHLO
	DUB004-OMC3S8.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbaHLJyE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Aug 2014 05:54:04 -0400
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Aug 2014 05:54:04 EDT
Received: from DUB121-W21 ([157.55.2.9]) by DUB004-OMC3S8.hotmail.com with Microsoft SMTPSVC(7.5.7601.22701);
	 Tue, 12 Aug 2014 02:48:53 -0700
X-TMN: [RgDyPOcYy9sUI4pO/RHoeEU5PV55U3P0ofJkkA5J7uA=]
X-Originating-Email: [p_ronto@hotmail.com]
Importance: Normal
X-OriginalArrivalTime: 12 Aug 2014 09:48:53.0577 (UTC) FILETIME=[A084FB90:01CFB612]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255146>

Hello all,

I noticed a weird rename conflict after doing the following steps:
=A0=A0 1. Changing the extension of a file using 'git mv'.
=A0=A0 2. Editing the file and staging the changes.
=A0=A0 3. Creating a new file and staging it.

Here is the Git Bash output showing the issue. The previously mentioned=
 steps are highlighted with asterisks.

$ git --version
git version 1.9.4.msysgit.0

$ git status
On branch master
Your branch is up-to-date with 'origin/master'.

nothing to commit, working directory clean

**** STEP 1 ****

$ git mv src/documents/contact.html.md src/documents/contact.html.md.ec=
o

$ git status
On branch master
Your branch is up-to-date with 'origin/master'.

Changes to be committed:
=A0 (use "git reset HEAD <file>..." to unstage)

=A0=A0=A0=A0=A0=A0=A0 renamed:=A0=A0=A0 src/documents/contact.html.md -=
> src/documents/contact.html.md.eco

**** STEP 2 ****

$ git status
On branch master
Your branch is up-to-date with 'origin/master'.

Changes to be committed:
=A0 (use "git reset HEAD <file>..." to unstage)

=A0=A0=A0=A0=A0=A0=A0 renamed:=A0=A0=A0 src/documents/contact.html.md -=
> src/documents/contact.html.md.eco

Changes not staged for commit:
=A0 (use "git add <file>..." to update what will be committed)
=A0 (use "git checkout -- <file>..." to discard changes in working dire=
ctory)

=A0=A0=A0=A0=A0=A0=A0 modified:=A0=A0 src/documents/contact.html.md.eco


$ git add src/documents/contact.html.md.eco

$ git status
On branch master
Your branch is up-to-date with 'origin/master'.

Changes to be committed:
=A0 (use "git reset HEAD <file>..." to unstage)

=A0=A0=A0=A0=A0=A0=A0 deleted:=A0=A0=A0 src/documents/contact.html.md
=A0=A0=A0=A0=A0=A0=A0 new file:=A0=A0 src/documents/contact.html.md.eco

**** STEP 3 ****

$ git status
On branch master
Your branch is up-to-date with 'origin/master'.

Changes to be committed:
=A0 (use "git reset HEAD <file>..." to unstage)

=A0=A0=A0=A0=A0=A0=A0 deleted:=A0=A0=A0 src/documents/contact.html.md
=A0=A0=A0=A0=A0=A0=A0 new file:=A0=A0 src/documents/contact.html.md.eco

Untracked files:
=A0 (use "git add <file>..." to include in what will be committed)

=A0=A0=A0=A0=A0=A0=A0 src/partials/address.html.md


$ git add src/partials/address.html.md

$ git status
On branch master
Your branch is up-to-date with 'origin/master'.

Changes to be committed:
=A0 (use "git reset HEAD <file>..." to unstage)

=A0=A0=A0=A0=A0=A0=A0 new file:=A0=A0 src/documents/contact.html.md.eco
=A0=A0=A0=A0=A0=A0=A0 renamed:=A0=A0=A0 src/documents/contact.html.md -=
> src/partials/address.html.md


Note here that the renamed object is wrong. Also note that I haven't co=
mmited the changes to the repo.=20

The repo is cloned from "https://github.com/prontog/elm".

Regards,

Panos
  		 	   		  