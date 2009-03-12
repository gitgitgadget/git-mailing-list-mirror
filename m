From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/7] rev-list: make "bisect_list" variable local to
 "cmd_rev_list"
Date: Thu, 12 Mar 2009 08:51:11 +0100
Message-ID: <20090312085111.55de8341.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 08:53:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhfjW-00079b-LM
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 08:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633AbZCLHwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 03:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbZCLHwK
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 03:52:10 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:53251 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754020AbZCLHwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 03:52:09 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 5916081809D;
	Thu, 12 Mar 2009 08:51:58 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with SMTP id 3F687818120;
	Thu, 12 Mar 2009 08:51:56 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113013>

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
1.6.2.83.g012a16.dirty
