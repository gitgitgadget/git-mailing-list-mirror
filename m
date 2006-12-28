From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [ANNOUNCE] qgit-1.5.4
Date: Thu, 28 Dec 2006 10:23:03 +0100
Message-ID: <e5bfff550612280123t5139e2e7w683f3961704065fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 28 10:23:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzrTg-0003VN-MG
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 10:23:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWL1JXF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 04:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWL1JXF
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 04:23:05 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:16245 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964991AbWL1JXD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 04:23:03 -0500
Received: by py-out-1112.google.com with SMTP id a29so2478622pyi
        for <git@vger.kernel.org>; Thu, 28 Dec 2006 01:23:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=liZ9pM3Gl2p9igQpDRpR0Lpr4ZocZHTDb0tpbWsJhuSnoCJOXGCeFMa/VD4T/LD5HH+nabhBBrdvuG5Yi33sE5Jtxby+lrkZXC/znjwIylIrX4koa1r62LdJz1Nvw7Tav+BFtZqo++vBfXQhd2j2uUaVs1MQ+PIPMj1HGQozFkc=
Received: by 10.35.18.18 with SMTP id v18mr11745244pyi.1167297783049;
        Thu, 28 Dec 2006 01:23:03 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Thu, 28 Dec 2006 01:23:02 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35550>

This is mostly a bug fix release. Plus a (big) performance increase when
loading a repository (warm cache case).

Data exchange with 'git rev-list' is now based on temporary files
instead of Qt QProcess class, this leads to a 40% increase under Linux
with a tmpfs filesystem mounted under /tmp, as is common with most
distributions. In case of portability issues it is possible to
fallback on a standard QProcess based interface. To do this uncomment
USE_QPROCESS define in 'src/dataloader.h' before to compile.

NOTE: qgit now uses faster 'git show-ref' instead of 'git peek-remote'
to read the tags so git v1.4.4 or later is required.

NOTE2: qgit is now compiled with -frepo option to remove redundant
template instantations, this leads to a little longer compile time and
some messages from 'collect' tool at the end of compilation. Don't
worry, it's all ok ;-)

Many thanks as usual to Pavel Roskin for help and patches.

Download tarball from http://www.sourceforge.net/projects/qgit
or directly from git public repository
git://git.kernel.org/pub/scm/qgit/qgit.git

Please refer to http://digilander.libero.it/mcostalba/ for additional
information.

	Marco


ChangeLog from 1.5.3

- improve load speed of 40% using a temporary file to read from 'git rev-list'

- fix many typos found by aspell, mostly in the comments (Pavel Roskin)

- increase to seven the number of recent repos menu entries

- fix a possible NULL dereferencing spotted by Klockwork K7.5

- fix a warning on 64-bit systems (Pavel Roskin)

- show also load speed as MB/s in status bar

- read file names cache after repository has been loaded. Good speedup 'feeling'

- allow to tag the same revision more then once

- mark with light green tag only current branch

- remove current HEAD from startup tag list. Spotted by Toralf Foerster

- use faster 'git show-ref' instead of 'git peek-remote'. Requires git v1.4.4

- complete rewrite references reading and handling: speedup and cleaner code

- be more user friendly when creating a new action

- quit if unable to parse command line arguments

- fix display issue when commit title length is less then 4

- increase file history list browsing speed

- resolve links also for an abbreviated sha in revision description pane

- fix tree view not correctly updated in rare cases

- fix an issue in file history with revisions that delete a file

- hide tag marker for HEAD also when is under refs/remotes

- compile with -frepo flag to remove duplicated template instances
