From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 2/4] builtin/commit: remove unnecessary variable definition
Date: Fri,  2 Apr 2010 14:27:19 +0200
Message-ID: <1270211241-10795-3-git-send-email-markus.heidelberg@web.de>
References: <1270211241-10795-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 14:26:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxfx1-0003SR-7V
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 14:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244Ab0DBM0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 08:26:04 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:51506 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487Ab0DBMZo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 08:25:44 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 476EC15B2B6E8;
	Fri,  2 Apr 2010 14:25:43 +0200 (CEST)
Received: from [91.19.8.199] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1NxfwV-0001ud-01; Fri, 02 Apr 2010 14:25:43 +0200
X-Mailer: git-send-email 1.7.0.4.300.gc535b
In-Reply-To: <1270211241-10795-1-git-send-email-markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX197gMNC1TvsE7r08KVt+0zfUpLCuPQx9+47rV9P
	YCVQfHFF1lP6aLjMl43ZwViXIfXCJjQ/uQaCvXUqab367nJldl
	wmaaRzZxmxECNZ9tBrgQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143813>

The file descriptor is already defined at the beginning of the function.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 builtin/commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8cc9293..c5ab683 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -307,7 +307,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 	 * (B) on failure, rollback the real index.
 	 */
 	if (all || (also && pathspec && *pathspec)) {
-		int fd = hold_locked_index(&index_lock, 1);
+		fd = hold_locked_index(&index_lock, 1);
 		add_files_to_cache(also ? prefix : NULL, pathspec, 0);
 		refresh_cache_or_die(refresh_flags);
 		if (write_cache(fd, active_cache, active_nr) ||
-- 
1.7.0.4.300.gc535b
