From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 00/13] more changes to port rebase -i to C using sequencer
	code
Date: Wed, 12 Aug 2009 07:15:38 +0200
Message-ID: <20090812051116.18155.70541.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 07:28:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb6Ny-0003mw-Oo
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 07:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbZHLF2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 01:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbZHLF2G
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 01:28:06 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:47708 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbZHLF2E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 01:28:04 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id BF1B68180D6;
	Wed, 12 Aug 2009 07:27:55 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A43FD818076;
	Wed, 12 Aug 2009 07:27:52 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125657>

These is just the current state of my work.
Some patches have already been sent but are not yet in pu.

Christian Couder (9):
  sequencer: add "--fast-forward" option to "git sequencer--helper"
  sequencer: let "git sequencer--helper" callers set "allow_dirty"
  rebase -i: use "git sequencer--helper --fast-forward"
  pick: simplify "error(...)" followed by "return -1"
  pick: rename "pick()" to "pick_commit()"
  pick: remove useless PICK_REVERSE => PICK_ADD_NOTE code
  pick: simplify bogus comment about commiting immediately
  pick: libify "pick_help_msg()"
  rebase -i: use "git sequencer--helper --cherry-pick"

Stephan Beyer (4):
  sequencer: add "do_fast_forward()" to perform a fast forward
  revert: libify pick
  sequencer: add "do_commit()" and related functions
  sequencer: add "--cherry-pick" option to "git sequencer--helper"

 Makefile                    |    2 +
 builtin-revert.c            |  293 +++++++------------------------------------
 builtin-sequencer--helper.c |  298 ++++++++++++++++++++++++++++++++++++++++++-
 git-rebase--interactive.sh  |   19 +--
 pick.c                      |  232 +++++++++++++++++++++++++++++++++
 pick.h                      |   14 ++
 6 files changed, 592 insertions(+), 266 deletions(-)
 create mode 100644 pick.c
 create mode 100644 pick.h
