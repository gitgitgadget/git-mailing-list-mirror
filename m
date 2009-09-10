From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/4] "git reset --merge" related improvements
Date: Thu, 10 Sep 2009 22:23:28 +0200
Message-ID: <20090910200334.3722.20140.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 22:24:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlqC7-0001fl-O4
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 22:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008AbZIJUYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 16:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753979AbZIJUX7
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 16:23:59 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49937 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753960AbZIJUX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 16:23:58 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 5135B8181A3;
	Thu, 10 Sep 2009 22:23:51 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0317A8181AD;
	Thu, 10 Sep 2009 22:23:48 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128144>

As agreed during private discussions, I am trying to refactor and
merge some interesting bits of code from the GSoC sequencer project.

So here is a first round about "git reset".

Patches 1/4 and 2/4 are using sequencer code to speed up "git reset" and
add some test cases for "git reset --merge".

Patches 3/4 and 4/4 are implementing "git reset --merge-dirty" and
showing the differences with "--merge". "--merge-dirty" is a really bad
name for the index reset option that is available using the "allow_dirty"
global variable in the sequencer. These 2 patches are for discussing
this feature.

Christian Couder (2):
  reset: add a few tests for "git reset --merge"
  reset: add test cases for "--merge-dirty" option

Stephan Beyer (2):
  reset: use "unpack_trees()" directly instead of "git read-tree"
  reset: add option "--merge-dirty" to "git reset"

 builtin-reset.c        |   81 +++++++++++++++++++++++++++-------
 t/t7110-reset-merge.sh |  114 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+), 16 deletions(-)
 create mode 100755 t/t7110-reset-merge.sh
