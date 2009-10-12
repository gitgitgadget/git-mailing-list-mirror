From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Let --decorate show HEAD position
Date: Mon, 12 Oct 2009 11:01:51 +0200
Message-ID: <4c70c935ab67266684aa14e38e276795cf1776db.1255337211.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 12 11:04:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxGpY-0007XQ-HU
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 11:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150AbZJLJDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 05:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754890AbZJLJDk
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 05:03:40 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:21712 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754747AbZJLJDj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 05:03:39 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 12 Oct
 2009 11:02:51 +0200
Received: from localhost.localdomain (129.132.208.114) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 12 Oct
 2009 11:02:30 +0200
X-Mailer: git-send-email 1.6.5.61.g35405
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129996>

'git log --graph --oneline --decorate --all' is a useful way to get a
general overview of the repository state, similar to 'gitk --all'.
Let it indicate the position of HEAD by loading that ref too, so that
the --decorate code can see it.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 log-tree.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 1618f3c..f7d54f2 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -43,6 +43,7 @@ void load_ref_decorations(int flags)
 	if (!loaded) {
 		loaded = 1;
 		for_each_ref(add_ref_decoration, &flags);
+		head_ref(add_ref_decoration, &flags);
 	}
 }
 
-- 
1.6.5.59.g76726.dirty
