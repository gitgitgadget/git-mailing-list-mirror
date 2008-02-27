From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 32/40] Windows: Use a relative default template_dir and ETC_GITCONFIG
Date: Wed, 27 Feb 2008 19:54:55 +0100
Message-ID: <1204138503-6126-33-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVS-00022R-Ay
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755673AbYB0Szz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755607AbYB0Szx
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:53 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40461 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673AbYB0SzM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:12 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 2C7F397658;
	Wed, 27 Feb 2008 19:55:10 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75271>

With this definition the templates and system config file will be found
irrespective of the installation location.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 7d4a591..15b13c0 100644
--- a/Makefile
+++ b/Makefile
@@ -548,6 +548,8 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	EXTLIBS += -lws2_32
 	X = .exe
 	NOEXECTEMPL = .noexec
+	template_dir = ../share/git-core/templates/
+	ETC_GITCONFIG = ../etc/gitconfig
 endif
 ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
-- 
1.5.4.1.126.ge5a7d
