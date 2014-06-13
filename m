From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 1/2] remotes.c: update calls to new signature for repack_without_refs
Date: Fri, 13 Jun 2014 08:51:05 -0700
Message-ID: <1402674666-6634-2-git-send-email-sahlberg@google.com>
References: <1402674666-6634-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 17:51:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvTl7-0003hR-3Z
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 17:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbaFMPvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 11:51:13 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:53632 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbaFMPvK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 11:51:10 -0400
Received: by mail-vc0-f202.google.com with SMTP id id10so336273vcb.1
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+6aDt1oXhuDzdmLzoGCfDthQjYKo2mCKwDQltiOUE3g=;
        b=YaBwF7ctMoF/cGo6ruvU7BWaqzGHF/bQN/Ln6bWfhCPokKn/SEozZlF83S+VGjBKZe
         tbZMPeKEaJYs5KuS9JKzjIwRT3BaMwkkPdhx0VRdPKk7BVGr6pcvsEpXTEiO1U9l0oTl
         j6WKIeClo97Tq/+i+lik8jJdKI89VnEzdtbfTbHKDfnMaXySID1z4jM3HLTJmPV2HeVR
         WofYtzp/ywRdOlmSUJmSY7I8d+q5cjbPB0bVAFHaDjUY+tUQakP+8YjHuw0vTNrz3f+0
         f/tgaE7yIFvG1neLB77RQ15GSzEmfuLMFafSmS/KP7S379IqV98/kJvyObM3T34sP8zQ
         XU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+6aDt1oXhuDzdmLzoGCfDthQjYKo2mCKwDQltiOUE3g=;
        b=hKZiig6Sg9ewol44WqqGtsVJNFpPQd5zLydDctvdHGOqRtOXCOEMbIBmOqDvoAMWj2
         WfP1rkrAbSK6Mi0MOoLmEZmkmQoYMO0EQfUOAS22aadM6yIGvZfu3jAMJcVGHTpZ6W2s
         9za57Y7wvyGqF/Yblf5Q2ZCdAdzrDCs6tXo/MDSK7rMe2KdVhXd/MQ3QsVJ3c4WtuLeg
         fwD3YyyqzXoxaeotd2Eru1Z3M+v4fnFYVpIxzI3aSJLW1XTbiitJfIB8PdYkwlveWprB
         leut5r+HtZKZiJ1QHjvlN4uy2HtlBHES7cYvG6NQERQE2nrlQywvPgrnZhucmqXiCGSO
         X9NA==
X-Gm-Message-State: ALoCoQle+Oi3KzV7eGuXBvvOsveO8BdPv3gwEzp1JCBDVixvywIEP9VYZRowjJzeqRx7azmtJ/pY
X-Received: by 10.58.182.137 with SMTP id ee9mr911881vec.37.1402674669210;
        Fri, 13 Jun 2014 08:51:09 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si333399yhp.6.2014.06.13.08.51.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jun 2014 08:51:09 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0D9E431C867;
	Fri, 13 Jun 2014 08:51:09 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B1AC6E090F; Fri, 13 Jun 2014 08:51:08 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.415.g8cd8cf8
In-Reply-To: <1402674666-6634-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251602>

This should be merged into patch:
00c74db refs.c: add an err argument to repack_without_refs

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/remote.c | 5 +++--
 refs.h           | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index c9102e8..401feb3 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -755,7 +755,7 @@ static int remove_branches(struct string_list *branches)
 	branch_names = xmalloc(branches->nr * sizeof(*branch_names));
 	for (i = 0; i < branches->nr; i++)
 		branch_names[i] = branches->items[i].string;
-	result |= repack_without_refs(branch_names, branches->nr);
+	result |= repack_without_refs(branch_names, branches->nr, NULL);
 	free(branch_names);
 
 	for (i = 0; i < branches->nr; i++) {
@@ -1333,7 +1333,8 @@ static int prune_remote(const char *remote, int dry_run)
 		for (i = 0; i < states.stale.nr; i++)
 			delete_refs[i] = states.stale.items[i].util;
 		if (!dry_run)
-			result |= repack_without_refs(delete_refs, states.stale.nr);
+			result |= repack_without_refs(delete_refs,
+						      states.stale.nr, NULL);
 		free(delete_refs);
 	}
 
diff --git a/refs.h b/refs.h
index 1b236f7..db463d0 100644
--- a/refs.h
+++ b/refs.h
@@ -162,7 +162,8 @@ extern void rollback_packed_refs(void);
  */
 int pack_refs(unsigned int flags);
 
-extern int repack_without_refs(const char **refnames, int n);
+extern int repack_without_refs(const char **refnames, int n,
+			       struct strbuf *err);
 
 extern int ref_exists(const char *);
 
-- 
2.0.0.415.g8cd8cf8
