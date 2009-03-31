From: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
Subject: [PATCH 4/4] Header Includes Cleanup Part 2
Date: Tue, 31 Mar 2009 02:45:21 -0700
Message-ID: <1238492721-92484-5-git-send-email-nathaniel.dawson@gmail.com>
References: <1238492721-92484-1-git-send-email-nathaniel.dawson@gmail.com>
 <1238492721-92484-2-git-send-email-nathaniel.dawson@gmail.com>
 <1238492721-92484-3-git-send-email-nathaniel.dawson@gmail.com>
 <1238492721-92484-4-git-send-email-nathaniel.dawson@gmail.com>
Cc: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 11:47:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoaZ8-0007cn-LQ
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 11:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351AbZCaJpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 05:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbZCaJpi
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 05:45:38 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:64362 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbZCaJpf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 05:45:35 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2938874rvb.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 02:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ysJzVKH8kK3WM89nyCeGZenv4K09gbgfieAdJlCIR1A=;
        b=j9a/2zYXrmGMaIfL4mYjfWfmD6UFevty7d08hwAisdJHAe7Z5k3p/+P4hk23ovy4jW
         hxUCqT1CdfyEIZ3LoxNVtjDt0v9oESB28BHMitIKsqk3ry+k52UGZHlQa/MS7/B4+EUB
         JhnF6Tud3abrk4BxxxernRf6Z6o+BVpDNJ2no=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hbwAPzdFGWPhOqkG3YK0/qpTLFvM1fKmCwN2qSLl8a5DM8LswA1GxaJxTIVwITSaj8
         JCpQviy5BXr2x7LUEnJA9fsm22uiJ7nI3yxPC5W5YX16QChkhD7VtyswNFs0HZwbcFam
         RI3sFseCcsORRQAK9uMcHG4BmbIObI/Of0J6g=
Received: by 10.141.14.17 with SMTP id r17mr1613364rvi.297.1238492734181;
        Tue, 31 Mar 2009 02:45:34 -0700 (PDT)
Received: from localhost (ip68-98-113-49.ph.ph.cox.net [68.98.113.49])
        by mx.google.com with ESMTPS id f21sm16427244rvb.35.2009.03.31.02.45.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Mar 2009 02:45:33 -0700 (PDT)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1238492721-92484-4-git-send-email-nathaniel.dawson@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115243>

Deleted includes of cache.h where reflog-walk.h was included since
reflog-walk.h includes it.

Signed-off-by: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
---
 log-tree.c    |    3 +--
 reflog-walk.c |    3 +--
 revision.c    |    3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 9565c18..0433e61 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1,10 +1,9 @@
-#include "cache.h"
+#include "reflog-walk.h"
 #include "diff.h"
 #include "commit.h"
 #include "tag.h"
 #include "graph.h"
 #include "log-tree.h"
-#include "reflog-walk.h"
 #include "refs.h"
 #include "string-list.h"
 
diff --git a/reflog-walk.c b/reflog-walk.c
index fd065f4..9198500 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -1,10 +1,9 @@
-#include "cache.h"
+#include "reflog-walk.h"
 #include "commit.h"
 #include "refs.h"
 #include "diff.h"
 #include "revision.h"
 #include "string-list.h"
-#include "reflog-walk.h"
 
 struct complete_reflogs {
 	char *ref;
diff --git a/revision.c b/revision.c
index 18425d6..b9d2aed 100644
--- a/revision.c
+++ b/revision.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "reflog-walk.h"
 #include "tag.h"
 #include "blob.h"
 #include "commit.h"
@@ -7,7 +7,6 @@
 #include "log-tree.h"
 #include "graph.h"
 #include "grep.h"
-#include "reflog-walk.h"
 #include "patch-ids.h"
 
 volatile show_early_output_fn_t show_early_output;
-- 
1.6.1.3
