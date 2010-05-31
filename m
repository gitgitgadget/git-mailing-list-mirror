From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/8] revert: use run_command_v_opt() instead of execv_git_cmd()
Date: Mon, 31 May 2010 21:42:33 +0200
Message-ID: <20100531194240.28729.9964.chriscool@tuxfamily.org>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 05:04:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJHmA-0000OY-4D
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 05:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409Ab0FADEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 23:04:14 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:42005 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753260Ab0FADEL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 May 2010 23:04:11 -0400
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 7836881805D;
	Tue,  1 Jun 2010 05:04:03 +0200 (CEST)
X-git-sha1: 44c3bd68a1090167c81dac93abc0d8b5015cb938 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100531193359.28729.55562.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148061>

This is needed by the following commits, because we are going
to cherry pick many commits instead of just one.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 5df0d69..9085894 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -530,7 +530,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 			args[i++] = defmsg;
 		}
 		args[i] = NULL;
-		return execv_git_cmd(args);
+		return run_command_v_opt(args, RUN_GIT_CMD);
 	}
 	free_message(&msg);
 	free(defmsg);
-- 
1.7.1.361.g42de.dirty
