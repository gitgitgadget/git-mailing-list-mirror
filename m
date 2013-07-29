From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] fsck: Replace deprecated OPT_BOOLEAN by OPT_BOOL
Date: Mon, 29 Jul 2013 18:45:54 +0200
Message-ID: <1375116354-14618-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 29 18:46:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3qa4-0003Sn-Oi
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 18:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757965Ab3G2Qpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 12:45:46 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:45317 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943Ab3G2Qpn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 12:45:43 -0400
Received: by mail-wi0-f174.google.com with SMTP id j17so2739306wiw.7
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 09:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=jG2iYehyE6AWPxeTLxuClMRI9oDQLui69BSpPJlK0No=;
        b=WfpynVa+/ZoqjN38R7oAjUxHbCjU30J/IUF9tOtwtdQj6wc0aG0GqG1tGPxcZdcyyt
         mjJ3nNavcAIM2GvfStXbEw4A6NF7O+8o3TrxDjkLviCchTvoB5FEdmQ64ys1jZ9PocbC
         4l1KwUgPwELBtyvu9L+N1mGrXJtkrKAdLulN93Q2ZA+PdrQmi15GsDOol3JSF7m5E3d/
         CcVl/eilMVYudnyCLS7SqDDeaugTnaKl/d0WLJkJOJ2BmR93vuZkjNLHXJ8ocaQ5Z1lB
         G26XrvpLZHHsdUiMvmLwAX30BaWU9hoTD/35SWymrFPUsBRaFC+nICpobMQ6P4KMb8A1
         OxOA==
X-Received: by 10.180.212.112 with SMTP id nj16mr7851519wic.31.1375116341893;
        Mon, 29 Jul 2013 09:45:41 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id jf9sm11541954wic.5.2013.07.29.09.45.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 09:45:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.1.g8f6a3e5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231299>

This task emerged from b04ba2bb4.
All occurrences of the respective variables have been reviewed and none
of them relied on the counting up mechanism, but all of them were
using the variable as a true boolean.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/fsck.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 9909b6d..39fa5e8 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -611,15 +611,15 @@ static char const * const fsck_usage[] = {
 
 static struct option fsck_opts[] = {
 	OPT__VERBOSE(&verbose, N_("be verbose")),
-	OPT_BOOLEAN(0, "unreachable", &show_unreachable, N_("show unreachable objects")),
+	OPT_BOOL(0, "unreachable", &show_unreachable, N_("show unreachable objects")),
 	OPT_BOOL(0, "dangling", &show_dangling, N_("show dangling objects")),
-	OPT_BOOLEAN(0, "tags", &show_tags, N_("report tags")),
-	OPT_BOOLEAN(0, "root", &show_root, N_("report root nodes")),
-	OPT_BOOLEAN(0, "cache", &keep_cache_objects, N_("make index objects head nodes")),
-	OPT_BOOLEAN(0, "reflogs", &include_reflogs, N_("make reflogs head nodes (default)")),
-	OPT_BOOLEAN(0, "full", &check_full, N_("also consider packs and alternate objects")),
-	OPT_BOOLEAN(0, "strict", &check_strict, N_("enable more strict checking")),
-	OPT_BOOLEAN(0, "lost-found", &write_lost_and_found,
+	OPT_BOOL(0, "tags", &show_tags, N_("report tags")),
+	OPT_BOOL(0, "root", &show_root, N_("report root nodes")),
+	OPT_BOOL(0, "cache", &keep_cache_objects, N_("make index objects head nodes")),
+	OPT_BOOL(0, "reflogs", &include_reflogs, N_("make reflogs head nodes (default)")),
+	OPT_BOOL(0, "full", &check_full, N_("also consider packs and alternate objects")),
+	OPT_BOOL(0, "strict", &check_strict, N_("enable more strict checking")),
+	OPT_BOOL(0, "lost-found", &write_lost_and_found,
 				N_("write dangling objects in .git/lost-found")),
 	OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
 	OPT_END(),
-- 
1.8.4.rc0.1.g8f6a3e5
