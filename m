From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/4] start using sequencer code to port "rebase -i"
Date: Fri, 26 Jun 2009 23:08:42 +0200
Message-ID: <20090626205319.3885.91532.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 23:09:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKIfR-0000qR-Lc
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 23:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755298AbZFZVIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 17:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754997AbZFZVIu
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 17:08:50 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:56299 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753801AbZFZVIu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 17:08:50 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 2A68B8180A0;
	Fri, 26 Jun 2009 23:08:43 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A92E781805A;
	Fri, 26 Jun 2009 23:08:40 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122321>

This patch series create a new "git sequencer--helper" plumber
command to help port "git-rebase--interactive.sh" to C using
code from the sequencer GSoC project at :

git://repo.or.cz/git/sbeyer.git

In this series only a few functions from the sequencer are used.

Christian Couder (3):
  sequencer: add "builtin-sequencer--helper.c"
  sequencer: free memory used in "make_patch" function
  rebase -i: use "git sequencer--helper --make-patch"

Stephan Beyer (1):
  sequencer: add "make_patch" function to save a patch

 .gitignore                  |    1 +
 Makefile                    |    1 +
 builtin-sequencer--helper.c |  104 +++++++++++++++++++++++++++++++++++++++++++
 builtin.h                   |    1 +
 git-rebase--interactive.sh  |   13 +-----
 git.c                       |    1 +
 6 files changed, 109 insertions(+), 12 deletions(-)
 create mode 100644 builtin-sequencer--helper.c
