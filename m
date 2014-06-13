From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 2/2] receive-pack.c: add missing xstrdup
Date: Fri, 13 Jun 2014 08:51:06 -0700
Message-ID: <1402674666-6634-3-git-send-email-sahlberg@google.com>
References: <1402674666-6634-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 17:51:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvTl6-0003hR-1X
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 17:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbaFMPvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 11:51:12 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:43087 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbaFMPvK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 11:51:10 -0400
Received: by mail-qa0-f73.google.com with SMTP id m5so422476qaj.4
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h7aWrMX06BXWsb49IXCBm93wltlIcgB9KphoYojlfKI=;
        b=AgtHGo8UMmpEDp66pq+pQaB/8GJYQjx1X8dlW8okXQMkRZfOP6q92An+N2AKwP/WeI
         uH8f0gDmui/bdxFiPy1a4gfVLN1UmED++GGa8aK3YR+zEj+uN+NREtB/95FCVcBMR5fJ
         YzBTKLBaLlx3LB2wVVXdUSvvQh9beAwXc2W76nHk70ORlZfzsc06AIfCB3LP9he0ylhQ
         7+p3Vk8iCVJ2cd1Sh/+TipvxpvhV4Kvx5NHB3AXIrsgdTsLwTlN/DngYxQrrtU14CU61
         f7qk2XCRzdqfpsf39osHcIYRk8Hq6Aqbn3r8W91aWMEG7Q0JfUv7VS16qJGCHI3ixSOV
         yhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h7aWrMX06BXWsb49IXCBm93wltlIcgB9KphoYojlfKI=;
        b=PGbHPyInMtvUFzdGcL5cAFxgg3yqoBAgLIYk92xUUMs/wf0QCnPOicrzeKzr5O4Gv3
         vS/E7ueFSKSF8q3602HzoJdpasjobbRBrXdBWBz/mScRVXF4pOEzmZ+7Z4vkPb0ZabOu
         V+LspPN3UWg2jpQaD6JJnHiYRvYzfKGTVzLvLzWz14ULuaUY/kKRlEKWPxNPZb+L65Ty
         j4H/vBZLLjqhJ24rFcThHM1scOCSXce44tlaoZlxlYVLyp+ID7IivAPI3UNlwGXfSAZ8
         AEzmXv38dOBVDBrRVpy5bM2Y1g1kdhKH/pdN7VoCXHOZdhhRcaw5Y2F1xhhBu0SQH8Af
         NfRg==
X-Gm-Message-State: ALoCoQnTunoVEj7dKM47CIZvdZau/FaUos0wVpHVPP2r8hV0Af+llWv5F2/daSyhNunVPU7XQrmf
X-Received: by 10.236.126.79 with SMTP id a55mr1284422yhi.4.1402674669337;
        Fri, 13 Jun 2014 08:51:09 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t4si335341yhm.0.2014.06.13.08.51.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jun 2014 08:51:09 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1E34231C868;
	Fri, 13 Jun 2014 08:51:09 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BE027E095A; Fri, 13 Jun 2014 08:51:08 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.415.g8cd8cf8
In-Reply-To: <1402674666-6634-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251601>

This should be merged into patch :
1685d87 receive-pack.c: use a reference transaction for updating the refs

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/receive-pack.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2575d06..64d54f8 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -479,7 +479,7 @@ static char *update(struct command *cmd, struct shallow_info *si)
 	/* only refs/... are allowed */
 	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
 		rp_error("refusing to create funny ref '%s' remotely", name);
-		return "funny refname";
+		return xstrdup("funny refname");
 	}
 
 	strbuf_addf(&namespaced_name_buf, "%s%s", get_git_namespace(), name);
@@ -497,20 +497,20 @@ static char *update(struct command *cmd, struct shallow_info *si)
 			rp_error("refusing to update checked out branch: %s", name);
 			if (deny_current_branch == DENY_UNCONFIGURED)
 				refuse_unconfigured_deny();
-			return "branch is currently checked out";
+			return xstrdup("branch is currently checked out");
 		}
 	}
 
 	if (!is_null_sha1(new_sha1) && !has_sha1_file(new_sha1)) {
 		error("unpack should have generated %s, "
 		      "but I can't find it!", sha1_to_hex(new_sha1));
-		return "bad pack";
+		return xstrdup("bad pack");
 	}
 
 	if (!is_null_sha1(old_sha1) && is_null_sha1(new_sha1)) {
 		if (deny_deletes && starts_with(name, "refs/heads/")) {
 			rp_error("denying ref deletion for %s", name);
-			return "deletion prohibited";
+			return xstrdup("deletion prohibited");
 		}
 
 		if (!strcmp(namespaced_name, head_name)) {
@@ -525,7 +525,8 @@ static char *update(struct command *cmd, struct shallow_info *si)
 				if (deny_delete_current == DENY_UNCONFIGURED)
 					refuse_unconfigured_deny_delete_current();
 				rp_error("refusing to delete the current branch: %s", name);
-				return "deletion of the current branch prohibited";
+				return xstrdup("deletion of the current branch "
+					       "prohibited");
 			}
 		}
 	}
@@ -543,19 +544,19 @@ static char *update(struct command *cmd, struct shallow_info *si)
 		    old_object->type != OBJ_COMMIT ||
 		    new_object->type != OBJ_COMMIT) {
 			error("bad sha1 objects for %s", name);
-			return "bad ref";
+			return xstrdup("bad ref");
 		}
 		old_commit = (struct commit *)old_object;
 		new_commit = (struct commit *)new_object;
 		if (!in_merge_bases(old_commit, new_commit)) {
 			rp_error("denying non-fast-forward %s"
 				 " (you should pull first)", name);
-			return "non-fast-forward";
+			return xstrdup("non-fast-forward");
 		}
 	}
 	if (run_update_hook(cmd)) {
 		rp_error("hook declined to update %s", name);
-		return "hook declined";
+		return xstrdup("hook declined");
 	}
 
 	if (is_null_sha1(new_sha1)) {
@@ -570,7 +571,7 @@ static char *update(struct command *cmd, struct shallow_info *si)
 		}
 		if (delete_ref(namespaced_name, old_sha1, 0)) {
 			rp_error("failed to delete %s", name);
-			return "failed to delete";
+			return xstrdup("failed to delete");
 		}
 		return NULL; /* good */
 	}
@@ -580,7 +581,7 @@ static char *update(struct command *cmd, struct shallow_info *si)
 
 		if (shallow_update && si->shallow_ref[cmd->index] &&
 		    update_shallow_ref(cmd, si))
-			return "shallow error";
+			return xstrdup("shallow error");
 
 		transaction = ref_transaction_begin(&err);
 		if (!transaction ||
-- 
2.0.0.415.g8cd8cf8
