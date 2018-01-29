Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3B9C1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752194AbeA2WkE (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:40:04 -0500
Received: from mail-vk0-f74.google.com ([209.85.213.74]:56352 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752176AbeA2WiT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:19 -0500
Received: by mail-vk0-f74.google.com with SMTP id o202so1470899vkd.23
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=jY3pdQfhMIRgY3lBTlZ80VVGt/J12cbA8q4Q3UN+yk0=;
        b=UF6FXffrklpSDMk8oKV298YbIWXwLJ4MiF8Evb0wkNOmICPQ3XcmOrhol5THryetps
         VAb9HQez99t7YlB83eP3M+xkjKnh4XhFsqlqxKQAb9gyDRA4Nl9rejUsQGSLL22l95nZ
         IqBgVctcCtNtPaieRgvjI7W/5sbIcgxPPDkn6S/XGQxvLSYj7SF4n3ViLl1zWmuUvDR7
         3r7TOx+zsy0mk7z8c9f1sUboGX7OfoOhUMGXEkkOjMM3lZMme2BPJWzxCzJpfr3NqfQs
         y4AXltmMPqAflegGoJ1Br69UgDvzxFiSSnBe98/n7iXmA4YUBSr6JIWbI1tWcIbALJzi
         y6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=jY3pdQfhMIRgY3lBTlZ80VVGt/J12cbA8q4Q3UN+yk0=;
        b=dKSCiZpgCby4ovxOcWuIS21m4aMtsaZYL3Sr3LsOgGzCkk+cBolj50x6kgFxtGhVrW
         AO01Xxq2RSoG0Hrm1BU6AyfbxEpFypSHtXsqq+WSrhjVBSV3FDn0/RSlJ4965h4ppdFE
         0kqYSR049hO8+/GLmzZ+s7CYtGr9tLApmIkHO1YlLdof1j6jbEM4VFZJnM6EzGNOj+NQ
         gcjbY3rXvum5rwg75FVR+vXoRMo7q3WTU/VhdfRpuXs4NCQPxS0ISyjKDlx4oO+WTEjg
         tihf0QlgIV4wG4hO5mTrLRa6JeSupu8rt/o3YqR48YUt80NvGokHNCJWZh0Ev69oILQz
         tn+w==
X-Gm-Message-State: AKwxytf+kv1wiw8uchdpbxqD4X1FErZ2Sdx3eUIEUi3n8bPNztKZA6MF
        5bEIWDcAI56b2012PkXSvQaemWUVKiG5uGDGebPzi63gaGDV5j+flahqA0GuJN4r41W6QXSkPhY
        gho+VtTGItSHVIfAyMIokA1trIOdyzQ/sxfB4TI3vIZTGGUxKEOGwmwQCwA==
X-Google-Smtp-Source: AH8x225VMksEU94EbgRtHlUt2iWoD6S8mtYi+htRYEGRKcfSPLszTa5RTeGuYfObXamFkUfncuG5dA8FoDs=
MIME-Version: 1.0
X-Received: by 10.31.160.14 with SMTP id j14mr12507044vke.26.1517265498568;
 Mon, 29 Jan 2018 14:38:18 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:07 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-17-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 16/37] diff-lib: rename 'new' variable
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 diff-lib.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 8104603a3..46375abb4 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -302,7 +302,7 @@ static int get_stat_data(const struct cache_entry *ce,
 }
 
 static void show_new_file(struct rev_info *revs,
-			  const struct cache_entry *new,
+			  const struct cache_entry *new_file,
 			  int cached, int match_missing)
 {
 	const struct object_id *oid;
@@ -313,16 +313,16 @@ static void show_new_file(struct rev_info *revs,
 	 * New file in the index: it might actually be different in
 	 * the working tree.
 	 */
-	if (get_stat_data(new, &oid, &mode, cached, match_missing,
+	if (get_stat_data(new_file, &oid, &mode, cached, match_missing,
 	    &dirty_submodule, &revs->diffopt) < 0)
 		return;
 
-	diff_index_show_file(revs, "+", new, oid, !is_null_oid(oid), mode, dirty_submodule);
+	diff_index_show_file(revs, "+", new_file, oid, !is_null_oid(oid), mode, dirty_submodule);
 }
 
 static int show_modified(struct rev_info *revs,
 			 const struct cache_entry *old,
-			 const struct cache_entry *new,
+			 const struct cache_entry *new_entry,
 			 int report_missing,
 			 int cached, int match_missing)
 {
@@ -330,7 +330,7 @@ static int show_modified(struct rev_info *revs,
 	const struct object_id *oid;
 	unsigned dirty_submodule = 0;
 
-	if (get_stat_data(new, &oid, &mode, cached, match_missing,
+	if (get_stat_data(new_entry, &oid, &mode, cached, match_missing,
 			  &dirty_submodule, &revs->diffopt) < 0) {
 		if (report_missing)
 			diff_index_show_file(revs, "-", old,
@@ -340,21 +340,21 @@ static int show_modified(struct rev_info *revs,
 	}
 
 	if (revs->combine_merges && !cached &&
-	    (oidcmp(oid, &old->oid) || oidcmp(&old->oid, &new->oid))) {
+	    (oidcmp(oid, &old->oid) || oidcmp(&old->oid, &new_entry->oid))) {
 		struct combine_diff_path *p;
-		int pathlen = ce_namelen(new);
+		int pathlen = ce_namelen(new_entry);
 
 		p = xmalloc(combine_diff_path_size(2, pathlen));
 		p->path = (char *) &p->parent[2];
 		p->next = NULL;
-		memcpy(p->path, new->name, pathlen);
+		memcpy(p->path, new_entry->name, pathlen);
 		p->path[pathlen] = 0;
 		p->mode = mode;
 		oidclr(&p->oid);
 		memset(p->parent, 0, 2 * sizeof(struct combine_diff_parent));
 		p->parent[0].status = DIFF_STATUS_MODIFIED;
-		p->parent[0].mode = new->ce_mode;
-		oidcpy(&p->parent[0].oid, &new->oid);
+		p->parent[0].mode = new_entry->ce_mode;
+		oidcpy(&p->parent[0].oid, &new_entry->oid);
 		p->parent[1].status = DIFF_STATUS_MODIFIED;
 		p->parent[1].mode = old->ce_mode;
 		oidcpy(&p->parent[1].oid, &old->oid);
-- 
2.16.0.rc1.238.g530d649a79-goog

