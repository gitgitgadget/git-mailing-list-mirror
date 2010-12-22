From: Michel Briand <michelbriand@free.fr>
Subject: FIX/COMMENT: git remote manual page
Date: Wed, 22 Dec 2010 02:15:46 +0100
Message-ID: <20101222021546.4b24c4e9@eana.kheb.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 22 02:16:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVDJ9-0006Zv-Ad
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 02:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193Ab0LVBPy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Dec 2010 20:15:54 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:39141 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943Ab0LVBPy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Dec 2010 20:15:54 -0500
Received: from eana.kheb.homelinux.org (unknown [82.234.51.186])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 3BB944B0070
	for <git@vger.kernel.org>; Wed, 22 Dec 2010 02:15:48 +0100 (CET)
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164066>

Hello,

I tried the example given at the bottom if the manual page of git
remote.

=B7   Imitate git clone but track only selected branches

$ mkdir project.git
$ cd project.git
$ git init
$ git remote add -f -t master -m master origin git://example.com/git.gi=
t/
$ git merge origin

It works like it is written.

But it seems this does not work with my special setup:
- I use GIT_DIR and GIT_WORK_TREE to specify another location for my
  repository, and to work from another directory,
- I name my remote with a custom name (not origin).

It fails at the last command :

    fatal: <my name> - not something we can merge

But if I try the command :

    git merge <my name>/master

the error message is different :

    fatal: This operation must be run in a work tree
    fatal: read-tree failed

I cd to the work tree and issue the same last command.
Then it works.

I suspect the first error message is related to the remote name. And
the second to the work tree not being the current directory.

Cheers,
Michel
