From: Stefano Zacchiroli <zack@upsilon.cc>
Subject: rfc on a svn -> git wrapper script
Date: Tue, 18 Mar 2008 16:24:27 +0100
Message-ID: <20080318152427.GA2219@takhisis.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 22:58:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc6IY-0000n1-Ij
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 22:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761199AbYCSV5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 17:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S939400AbYCSV5Z
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 17:57:25 -0400
Received: from fettunta.fettunta.org ([67.207.129.222]:55592 "EHLO
	fettunta.fettunta.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S939397AbYCSV5X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 17:57:23 -0400
X-Greylist: delayed 4999 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Mar 2008 17:57:23 EDT
Received: from aquarium.takhisis.invalid (unknown [10.17.0.10])
	by fettunta.fettunta.org (Postfix) with ESMTP id 2D23A18129
	for <git@vger.kernel.org>; Tue, 18 Mar 2008 15:25:16 +0000 (UTC)
Received: by aquarium.takhisis.invalid (Postfix, from userid 1000)
	id E12B112550A; Tue, 18 Mar 2008 16:24:27 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77566>

Hi all,
  I want to convert a medium-sized subversion repository [1] to several
git repositories. In doing so I've a couple of extra requirements which
are not directly handled by git-svn. The main ones are:

- get rid of old .orig.tar.gz tarballs which have been commited in the
  past to the repo
- get rid of the git-svn metadata as the conversion will be one-way and
  will happen only once
- make the repository bare
- convert old subversion tags to real git tags
  (BTW, I'm quite surprised git-svn doesn't do that, but I understand
  that there are no guarantees that tags on the subversion side have
  been used as such ...)

As a side goal I need all this to be made easy for people which know
potentially nothing about git (they will start learning when the
conversions have been done).

Hence, to automate the above stuff I've made a helper script [2] (with a
companion of him, which is way less interesting [3]).

Since I'm quite new to git, and given that some stuff (e.g. removing the
tarballs and ensuring their space can be reclaimed back) is quite
tricky, I was wondering if someone can have a look at the script to
check if I've overlooked something obvious or not ...

Comments will be very much appreciated,
Many thanks in advance!

[1] svn://svn.debian.org/pkg-ocaml-maint/
[2] http://svn.debian.org/viewsvn/pkg-ocaml-maint/trunk/tools/svn2git/svn2git_alioth?view=markup
[3] http://svn.debian.org/viewsvn/pkg-ocaml-maint/trunk/tools/svn2git/svn2git_pkg-ocaml-maint?view=markup

-- 
Stefano Zacchiroli -*- PhD in Computer Science ............... now what?
zack@{upsilon.cc,cs.unibo.it,debian.org}  -<%>-  http://upsilon.cc/zack/
(15:56:48)  Zack: e la demo dema ?    /\    All one has to do is hit the
(15:57:15)  Bac: no, la demo scema    \/    right keys at the right time
