From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: git stash apply segfaulting when called in subdir
Date: Wed, 25 Jul 2007 23:23:11 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070725212311.GA13325@cassiopeia>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 25 23:23:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDoKI-0001NN-59
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 23:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756220AbXGYVXT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 25 Jul 2007 17:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756182AbXGYVXT
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 17:23:19 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:39234 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754179AbXGYVXS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jul 2007 17:23:18 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IDoKC-0000U9-Q2
	for git@vger.kernel.org; Wed, 25 Jul 2007 23:23:16 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l6PLNEsB028419
	for <git@vger.kernel.org>; Wed, 25 Jul 2007 23:23:14 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l6PLNEla028418
	for git@vger.kernel.org; Wed, 25 Jul 2007 23:23:14 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53722>

Hello,

I did not do much testing and didn't look into the issue yet:

zeisberg@cassiopeia:/tmp$ mkdir repo; cd repo; git init
Initialized empty Git repository in .git/

zeisberg@cassiopeia:/tmp/repo$ mkdir dir; echo one > file; echo two > d=
ir/file

zeisberg@cassiopeia:/tmp/repo$ git add file dir/file

zeisberg@cassiopeia:/tmp/repo$ git commit -m tralala
Created initial commit 265b7d7: tralala
 2 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 dir/file
 create mode 100644 file

zeisberg@cassiopeia:/tmp/repo$ echo three >> file

zeisberg@cassiopeia:/tmp/repo$ git stash
Saved "WIP on master: 265b7d7... tralala"
HEAD is now at 265b7d7... tralala

zeisberg@cassiopeia:/tmp/repo$ cd dir; git stash apply
error: missing object referenced by '696146c2a44d7fc4d5ae4a71589c4c0d84=
f59789'
/home/zeisberg/usr/bin/git-stash: line 111: 13618 Segmentation fault   =
   git-merge-recursive $b_tree -- $c_tree $w_tree

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D1+newton+in+kg*m+%2F+s%5E2
