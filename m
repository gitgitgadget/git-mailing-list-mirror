Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB776EB7C
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130297; cv=none; b=DsDYNi4hr+vTGIkehp2Yr+nJA3bqeGTToDUk0uoUcnkBdE8T+b3UHe9PqgV5igNMXxNqlrNjbJZbtWPFd6O7G4NSyXQaR5EtTtVi0nDZobnNOv9tMOv9KOGJ+d0vAG4AXPjPT1Y/SKnyABMQQFS1375HtpCF+C82r740x1rHMI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130297; c=relaxed/simple;
	bh=giZOSQaaicN2icYxYpzSBgby9eHhjxzSw2wZ5PkEF5c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lpplzzG9dhE8IODAMFn5nVmojTyhkyScits/n2T+37RFokw64T8FkQBWFno3uQIpSyDZ4Tr8UFY0eIE70rQQWeREkeavWyVNgyZiCfctEiIV9osHdj+PdDul86tt+uOw2ZQj7BQHXEA+T54MqriuutS8RGKRDwb6xEpsBbpfZdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiuQrGiK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiuQrGiK"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42198492353so11139605e9.1
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718130293; x=1718735093; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/e400LHKdvhOuQ+OVWma9RT1Sfyor6/Vi4GK8onwiwk=;
        b=eiuQrGiKUMh1zx1ELFulH0rrb0NEjZdmAOd8c6aTHDc8goZqhF58dNoeVq/dH0J3qY
         8bnKc+5APAsaroJTu/AKlZ7lIn4NNLi3+zlewnOhgFFpAVZNZM5hA7uREkWvlfLflYCo
         +0lGtvi6VGptMxddm3/W/OxwGZcU01j96e0fLeqPijoHsJH+UMWaCjwvq+bTtm5g2vrq
         2mpAK/5AQjSGuMKSYa42p9F/16BMY3RR8U5FKprhMYSg4e5ySDuO0j4dLSX2KY0y33zI
         IdelIvj3JvbAIJTz8LQk2GXLNKEuGZcQsRi//E9gD0aZL8A8vKOfG2+wQtrsXrJ6OCi5
         MT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130293; x=1718735093;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/e400LHKdvhOuQ+OVWma9RT1Sfyor6/Vi4GK8onwiwk=;
        b=d4cT1CLsN/u9haEX1HSfN89UK5h85+13DaVkQo1JIRdTPFywCZab2upjlIAe5jOgP8
         Ds0P9A6l46fNXWEYD9IZDflQg0GYLEJwxv6BdIp5Oe1fl5382bpwEkNFa8pzwxhJEuEx
         nuwfXSQwRZiisitEZXC/J1PSdcceuUTyXBZugyrEcSVSe3PXEDilmu11JP/ZQtB3GlXV
         mloAD28oiD7wRr2lnk3/3MhmTb6u7aNOByEqmuz3FJmoLjyBoGN5WPGz5ebiEj/deNYL
         aVByGL3aLDHcHUs1TX80y209OQZZeCKxh+4/ND/6xB5/gM2k2G21aN6S0APSFNDQnyjy
         mvvg==
X-Gm-Message-State: AOJu0Yxngq5Q9ttd57WJbpR/Coa7l15ygrJ4tf9WqoNMWMm1IA6m63zt
	f1Kb86ZSkioZZcl+Tbghubqgn4s0p7di/sxddl9ZZMe8HI8Nt4nWHYfWGQ==
X-Google-Smtp-Source: AGHT+IGJYLXc+7S0WuObEK/42qJtKzvW/wPm51eHTuaL3CN7Z60Z7/eEzH51l8eRRvHmu6hu7+u/qQ==
X-Received: by 2002:a05:600c:3c83:b0:41c:13f6:206d with SMTP id 5b1f17b1804b1-42164a2e9d4mr117116145e9.25.1718130292609;
        Tue, 11 Jun 2024 11:24:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422048a40a3sm63984315e9.33.2024.06.11.11.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:24:52 -0700 (PDT)
Message-Id: <5ade145352f44b431c16a2ec29cd87de489e8032.1718130288.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 18:24:35 +0000
Subject: [PATCH 03/16] mktree: use non-static tree_entry array
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Replace the static 'struct tree_entry **entries' with a non-static 'struct
tree_entry_array' instance. In later commits, we'll want to be able to
create additional 'struct tree_entry_array' instances utilizing common
functionality (create, push, clear, free). To avoid code duplication, create
the 'struct tree_entry_array' type and add functions that perform those
basic operations.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/mktree.c | 67 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 20 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index c02feb06aff..15bd908702a 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -12,15 +12,39 @@
 #include "parse-options.h"
 #include "object-store-ll.h"
 
-static struct tree_entry {
+struct tree_entry {
 	unsigned mode;
 	struct object_id oid;
 	int len;
 	char name[FLEX_ARRAY];
-} **entries;
-static int alloc, used;
+};
+
+struct tree_entry_array {
+	size_t nr, alloc;
+	struct tree_entry **entries;
+};
 
-static void append_to_tree(unsigned mode, struct object_id *oid, char *path)
+static void tree_entry_array_push(struct tree_entry_array *arr, struct tree_entry *ent)
+{
+	ALLOC_GROW(arr->entries, arr->nr + 1, arr->alloc);
+	arr->entries[arr->nr++] = ent;
+}
+
+static void clear_tree_entry_array(struct tree_entry_array *arr)
+{
+	for (size_t i = 0; i < arr->nr; i++)
+		FREE_AND_NULL(arr->entries[i]);
+	arr->nr = 0;
+}
+
+static void release_tree_entry_array(struct tree_entry_array *arr)
+{
+	FREE_AND_NULL(arr->entries);
+	arr->nr = arr->alloc = 0;
+}
+
+static void append_to_tree(unsigned mode, struct object_id *oid, const char *path,
+			   struct tree_entry_array *arr)
 {
 	struct tree_entry *ent;
 	size_t len = strlen(path);
@@ -32,8 +56,8 @@ static void append_to_tree(unsigned mode, struct object_id *oid, char *path)
 	ent->len = len;
 	oidcpy(&ent->oid, oid);
 
-	ALLOC_GROW(entries, used + 1, alloc);
-	entries[used++] = ent;
+	/* Append the update */
+	tree_entry_array_push(arr, ent);
 }
 
 static int ent_compare(const void *a_, const void *b_)
@@ -44,19 +68,18 @@ static int ent_compare(const void *a_, const void *b_)
 				 b->name, b->len, b->mode);
 }
 
-static void write_tree(struct object_id *oid)
+static void write_tree(struct tree_entry_array *arr, struct object_id *oid)
 {
 	struct strbuf buf;
-	size_t size;
-	int i;
+	size_t size = 0;
 
-	QSORT(entries, used, ent_compare);
-	for (size = i = 0; i < used; i++)
-		size += 32 + entries[i]->len;
+	QSORT(arr->entries, arr->nr, ent_compare);
+	for (size_t i = 0; i < arr->nr; i++)
+		size += 32 + arr->entries[i]->len;
 
 	strbuf_init(&buf, size);
-	for (i = 0; i < used; i++) {
-		struct tree_entry *ent = entries[i];
+	for (size_t i = 0; i < arr->nr; i++) {
+		struct tree_entry *ent = arr->entries[i];
 		strbuf_addf(&buf, "%o %s%c", ent->mode, ent->name, '\0');
 		strbuf_add(&buf, ent->oid.hash, the_hash_algo->rawsz);
 	}
@@ -70,7 +93,8 @@ static const char *mktree_usage[] = {
 	NULL
 };
 
-static void mktree_line(char *buf, int nul_term_line, int allow_missing)
+static void mktree_line(char *buf, int nul_term_line, int allow_missing,
+			struct tree_entry_array *arr)
 {
 	char *ptr, *ntr;
 	const char *p;
@@ -146,7 +170,7 @@ static void mktree_line(char *buf, int nul_term_line, int allow_missing)
 		}
 	}
 
-	append_to_tree(mode, &oid, path);
+	append_to_tree(mode, &oid, path, arr);
 	free(to_free);
 }
 
@@ -158,6 +182,7 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 	int allow_missing = 0;
 	int is_batch_mode = 0;
 	int got_eof = 0;
+	struct tree_entry_array arr = { 0 };
 	strbuf_getline_fn getline_fn;
 
 	const struct option option[] = {
@@ -182,9 +207,9 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 					break;
 				die("input format error: (blank line only valid in batch mode)");
 			}
-			mktree_line(sb.buf, nul_term_line, allow_missing);
+			mktree_line(sb.buf, nul_term_line, allow_missing, &arr);
 		}
-		if (is_batch_mode && got_eof && used < 1) {
+		if (is_batch_mode && got_eof && arr.nr < 1) {
 			/*
 			 * Execution gets here if the last tree entry is terminated with a
 			 * new-line.  The final new-line has been made optional to be
@@ -192,12 +217,14 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 			 */
 			; /* skip creating an empty tree */
 		} else {
-			write_tree(&oid);
+			write_tree(&arr, &oid);
 			puts(oid_to_hex(&oid));
 			fflush(stdout);
 		}
-		used=0; /* reset tree entry buffer for re-use in batch mode */
+		clear_tree_entry_array(&arr); /* reset tree entry buffer for re-use in batch mode */
 	}
+
+	release_tree_entry_array(&arr);
 	strbuf_release(&sb);
 	return 0;
 }
-- 
gitgitgadget

