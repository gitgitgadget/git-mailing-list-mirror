From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 0/4] implement "git cherry-pick A..B"
Date: Sat, 29 May 2010 06:40:39 +0200
Message-ID: <20100529043738.569.85482.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 29 06:41:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIDra-0007PG-MI
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 06:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890Ab0E2ElO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 May 2010 00:41:14 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:56228 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789Ab0E2ElN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 00:41:13 -0400
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 5211B818043;
	Sat, 29 May 2010 06:41:06 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147955>

This an RFC patch series to implement "git cherry-pick A..B" and
"git revert A..B".

There is no documentation yet, and there is no way to continue or
abort the process when cherry-picking fails.

Christian Couder (4):
  revert: use run_command_v_opt() instead of execv_git_cmd()
  revert: refactor code into a do_pick_commit() function
  revert: allow cherry-picking a range of commits
  revert: add tests to check cherry-picking a range of commits

 builtin/revert.c             |   97 +++++++++++++++++++++++++++++-------------
 t/t3508-cherry-pick-range.sh |   65 ++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+), 30 deletions(-)
 create mode 100755 t/t3508-cherry-pick-range.sh
