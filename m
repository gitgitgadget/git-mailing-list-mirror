From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 02/10] rev-list: make "bisect_list" variable local to
 "cmd_rev_list"
Date: Thu, 26 Mar 2009 05:55:17 +0100
Message-ID: <20090326055517.20f5097d.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 05:58:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmhfJ-0003jA-CB
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 05:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbZCZE4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 00:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752304AbZCZE4U
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 00:56:20 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:50804 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137AbZCZE4T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 00:56:19 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 5295A81803B;
	Thu, 26 Mar 2009 05:56:08 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with SMTP id 3E531818068;
	Thu, 26 Mar 2009 05:56:06 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114726>

The "bisect_list" variable was static for no reason as it is only used
in the "cmd_rev_list" function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-list.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 40d5fcb..28fe2dc 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -52,7 +52,6 @@ static const char rev_list_usage[] =
 
 static struct rev_info revs;
 
-static int bisect_list;
 static int show_timestamp;
 static int hdr_termination;
 static const char *header_prefix;
@@ -618,6 +617,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	struct commit_list *list;
 	int i;
 	int read_from_stdin = 0;
+	int bisect_list = 0;
 	int bisect_show_vars = 0;
 	int bisect_find_all = 0;
 	int quiet = 0;
-- 
1.6.2.1.317.g3d804
