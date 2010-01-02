From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 0/5] add "--keep" option to "git reset"
Date: Sat, 02 Jan 2010 06:39:28 +0100
Message-ID: <20100102053303.30066.26391.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 06:39:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQwiR-0001zk-SL
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 06:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678Ab0ABFjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 00:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318Ab0ABFjv
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 00:39:51 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:53954 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081Ab0ABFju (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 00:39:50 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0B92681806B;
	Sat,  2 Jan 2010 06:39:40 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B3D67818019;
	Sat,  2 Jan 2010 06:39:37 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136016>

This patch series is sent to make it easy to test the changes in the
first patch by Junio of this series on a new "--keep" reset option.  

Christian Couder (4):
  reset: add option "--keep" to "git reset"
  reset: add test cases for "--keep" option
  Documentation: reset: describe new "--keep" option
  reset: disallow "reset --keep" outside a work tree

Junio C Hamano (1):
  reset: make "reset --merge" discard work tree changes on unmerged
    entries

 Documentation/git-reset.txt |   45 ++++++++++++++--
 builtin-reset.c             |   31 +++++++++--
 read-cache.c                |    2 +-
 t/t7103-reset-bare.sh       |   25 ++++++---
 t/t7110-reset-merge.sh      |  119 ++++++++++++++++++++++++++++++++++++++++---
 unpack-trees.c              |   19 ++++---
 6 files changed, 206 insertions(+), 35 deletions(-)
