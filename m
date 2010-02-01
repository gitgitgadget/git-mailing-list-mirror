From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 0/6] add --ff option to cherry-pick
Date: Mon, 01 Feb 2010 08:55:35 +0100
Message-ID: <20100201074835.3929.11509.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 08:53:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbr5k-0005Tj-RC
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 08:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240Ab0BAHw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 02:52:57 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:49811 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171Ab0BAHw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 02:52:56 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 60C8B81816B;
	Mon,  1 Feb 2010 08:52:47 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0AAC1818078;
	Mon,  1 Feb 2010 08:52:45 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138586>

The goal of this series is to add a --ff fast forward otion to cherry-pick
and use it in "rebase -i".

There is no documentation yet and the commit messages are too short but
this will be improved if the series looks worthwhile.

The first patch in this series is a refactoring patch that is not really
needed, but as it looks like a good refactoring/cleanup anyway I left it in.

Christian Couder (5):
  reset: refactor updating heads into a static function
  reset: refactor reseting in its own function
  reset: make reset function non static and declare it in "reset.h"
  revert: add --ff option to allow fast forward when cherry-picking
  rebase -i: use new --ff cherry-pick option

Stephan Beyer (1):
  revert: libify cherry-pick and revert functionnality

 Makefile                   |    2 +
 builtin-reset.c            |  175 +++++++++++++++------------
 builtin-revert.c           |  293 ++++++++++----------------------------------
 git-rebase--interactive.sh |   15 +--
 pick.c                     |  218 ++++++++++++++++++++++++++++++++
 pick.h                     |   13 ++
 reset.h                    |   10 ++
 7 files changed, 407 insertions(+), 319 deletions(-)
 create mode 100644 pick.c
 create mode 100644 pick.h
 create mode 100644 reset.h
