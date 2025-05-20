Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA51242D95
	for <git@vger.kernel.org>; Tue, 20 May 2025 19:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747768753; cv=none; b=MV1CVMYPx5B28STnV+cmJK5i0ApGdEDP7mhtIPh9nbZkHmCr2bHrHHV0SzsIvYoxfJ7J7FIA8SZwpfytggVEdUQbPb+dlJkI5bRNMISbQ/v3x1/k4wkkq9V4aSibamp+SBao1cVjNqK4bpKgiLms07oH4sAZQKC+DD60GTjLsOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747768753; c=relaxed/simple;
	bh=8yg1NXk6lM2Ifi2NLLtK+LlJf1bKBRAvypK/K3qKt6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BDXSWU/TyU8D0dRE6Ip4BLlN/CCxw4698JPJIth1diDG7vz9YKC6NQFzrhIvh4HwvrDUqQ9DMxrcvg67sjZW7Kzm8KYuIriRS//4/mWRrCeOQJxHthNaQMkhWq6bIzKalp6pi+iQHQKsmuNFLgzQGOsoeMNJnqDFa/fqHcUiJ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYUVuiA4; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYUVuiA4"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7086dcab64bso56224287b3.1
        for <git@vger.kernel.org>; Tue, 20 May 2025 12:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747768749; x=1748373549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CkIAj+wiTOLWXHPxmJ8fDMLO8glkKvpQpKR/X86Vge4=;
        b=PYUVuiA48QIeNaTHIfh4RLZMpRy/musouEewp5yegCZhmOrkAY3k2Pj4kTVwQJ8+5Y
         FkDFTF0cKYczVfzPVqoIOAHjebYPNu8IPDCO6zRZ67m5ZEBL4ORjDVUvGHW4/oDR7sRQ
         t6mzHOkMA2jZ+tkCkm2I/Zgot2RN1yBjBKIr8BbObJI/SHCf+l05pfjInO5Oans8a47e
         BgW13kAn7CdqLY4F8uneZKo82ZmnRTQ1I97DXwZZrSwShhrxA0Jur+tZoOWltrdR/psn
         GOikOgUwFG/MxbSQ7k78tvrO5yZLSunNWwwDKUVQmlRnKvBadhJ1+t0Yc06gYu/vVs1f
         Z0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747768749; x=1748373549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CkIAj+wiTOLWXHPxmJ8fDMLO8glkKvpQpKR/X86Vge4=;
        b=vD7/S7mNY4hf6bPVbDyR1tmmZ/F/Qy7mlTpRQq00PH/nXfvJCIuujPY/ONrnW4/cyn
         NG/PC7w/TRGTekiew0tcGxTFI5UHqKk648K7yzHD9PhE3U3hrzI5pR83ji4lxQ0jmkf9
         DIQHau3yC+wZnGuOcE4wgoGEmBi/+3saUDx00JgNkZmzE5zGw2Nf+pSjJ523Hm6XODL/
         AudRzDxGyAzNVvAFxII/wNd0UOBM2j8GqlSw2g9a1GOdGltDolZ38mT2BJbfvp+0c3mr
         NfVQgxScSi1pste2n6FEDelKHdeXjR7xVP66L8oUj58sz80AZOhTxIdzt+k3s4MBWln9
         T+Wg==
X-Gm-Message-State: AOJu0YxirTzAWERE3R83Hs1TyKDNUG1YlQap/PwvzbQu0xAgbm3D3PN2
	GLP1kcPao1keaE7j3vW+QdJAf+hFd+kXHyW7sWyQK7NRR28DbxHWcwzz4IloMPO1
X-Gm-Gg: ASbGncuqBnTFMCV+/xnpUDth519rGEa+2unAUNrgSyerZgvuJJJ31ywJ6GcB/rHct6r
	8Gn0EigFHpxXbvF1L5C+tyPX5Mjegua5FlN6jG+sa+ikexcasGR34rqD8hFg2zZSly4nJyMU+bb
	LLgUZSRn9h6IwPWgBUwIOaf/EKk7nO3Z+146iSMkvEk3V0P0O85s8uuDqnLPp0AjIzdGWjDpVGa
	cxnfxH86ZfxFebH2af+qkJPjHcjYY9q2R6MsXn7NxBIFI63q4TkxMftJZ47Q/ey8XVuuc5/gSb7
	u8GEgQW4dfP/QNs64gsDq1nTAlScwbhExCn+c7+nq1rCpI+8LmNOphQO3ZUMZzySd3+S10KQXrn
	g4U9xzJSrjfCsSg==
X-Google-Smtp-Source: AGHT+IGJpFGgh7KB1pAnqTulTKaCOjPAqFjJiv8qR1W6QI64lcnvH3GkyNZrrDJuDbgWhZtU2ZTzaw==
X-Received: by 2002:a05:690c:6f85:b0:6f9:e609:6a4b with SMTP id 00721157ae682-70ca7b8a042mr247732367b3.23.1747768748629;
        Tue, 20 May 2025 12:19:08 -0700 (PDT)
Received: from eijiuchiyama-Dell-G15-5530.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70ca8530d51sm23710547b3.115.2025.05.20.12.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 12:19:07 -0700 (PDT)
From: Lucas Eiji <lucaseiji54@gmail.com>
To: git@vger.kernel.org
Cc: Eiji Uchiyama <eijiuchiyama@github.com>,
	Lucas Eiji Uchiyama <eijiuchiyama@usp.br>
Subject: [PATCH] /: [FirstTimer] Remove DISABLE_SIGN_COMPARE_WARNINGS from file add-interactive.c
Date: Tue, 20 May 2025 16:18:59 -0300
Message-Id: <20250520191859.136798-1-lucaseiji54@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eiji Uchiyama <eijiuchiyama@github.com>

This is an initial contribution to git, based on the SoC 2025 ideas
for microprojects. It removes the DISABLE_SIGN_COMPARE_WARNINGS macro and
solves the warnings generated by running make DEVELOPER=1 -j4

Signed-off-by: Lucas Eiji Uchiyama <eijiuchiyama@usp.br>
---
 add-interactive.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 97ff35b6f1..3a0c44c47f 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -1,5 +1,3 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "add-interactive.h"
 #include "color.h"
@@ -213,10 +211,10 @@ static ssize_t find_unique(const char *string, struct prefix_item_list *list)
 	else if (index > 0 &&
 		 starts_with(list->sorted.items[index - 1].string, string))
 		return -1;
-	else if (index + 1 < list->sorted.nr &&
+	else if (index + 1 < (long int)(list->sorted.nr) &&
 		 starts_with(list->sorted.items[index + 1].string, string))
 		return -1;
-	else if (index < list->sorted.nr &&
+	else if (index < (long int)(list->sorted.nr) &&
 		 starts_with(list->sorted.items[index].string, string))
 		item = list->sorted.items[index].util;
 	else
@@ -244,7 +242,7 @@ static void list(struct add_i_state *s, struct string_list *list, int *selected,
 		color_fprintf_ln(stdout, s->header_color,
 				 "%s", opts->header);
 
-	for (i = 0; i < list->nr; i++) {
+	for (i = 0; i < (long int)(list->nr); i++) {
 		opts->print_item(i, selected ? selected[i] : 0, list->items + i,
 				 opts->print_item_data);
 
@@ -385,7 +383,7 @@ static ssize_t list_and_choose(struct add_i_state *s,
 					to = from + 1;
 			}
 
-			if (from < 0 || from >= items->items.nr ||
+			if (from < 0 || from >= (long int)(items->items.nr) ||
 			    (singleton && from + 1 != to)) {
 				color_fprintf_ln(stderr, s->error_color,
 						 _("Huh (%s)?"), p);
@@ -395,7 +393,7 @@ static ssize_t list_and_choose(struct add_i_state *s,
 				break;
 			}
 
-			if (to > items->items.nr)
+			if (to > (long int)(items->items.nr))
 				to = items->items.nr;
 
 			for (; from < to; from++)
@@ -859,7 +857,7 @@ static int get_untracked_files(struct repository *r,
 	add_pattern_list(&dir, EXC_CMDL, "--exclude option");
 	fill_directory(&dir, r->index, ps);
 
-	for (i = 0; i < dir.nr; i++) {
+	for (i = 0; (long int)(i) < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
 
 		if (index_name_is_other(r->index, ent->name, ent->len)) {
@@ -939,7 +937,7 @@ static int run_patch(struct add_i_state *s, const struct pathspec *ps,
 		return -1;
 
 	if (unmerged_count || binary_count) {
-		for (i = j = 0; i < files->items.nr; i++) {
+		for (i = j = 0; i < (long int)(files->items.nr); i++) {
 			struct file_item *item = files->items.items[i].util;
 
 			if (item->index.binary || item->worktree.binary) {
@@ -972,7 +970,7 @@ static int run_patch(struct add_i_state *s, const struct pathspec *ps,
 		struct strvec args = STRVEC_INIT;
 		struct pathspec ps_selected = { 0 };
 
-		for (i = 0; i < files->items.nr; i++)
+		for (i = 0; i < (long int)(files->items.nr); i++)
 			if (files->selected[i])
 				strvec_push(&args,
 					    files->items.items[i].string);
@@ -1018,7 +1016,7 @@ static int run_diff(struct add_i_state *s, const struct pathspec *ps,
 			     oid_to_hex(!is_initial ? &oid :
 					s->r->hash_algo->empty_tree),
 			     "--", NULL);
-		for (i = 0; i < files->items.nr; i++)
+		for (i = 0; i < (long int)(files->items.nr); i++)
 			if (files->selected[i])
 				strvec_push(&cmd.args,
 					    files->items.items[i].string);
@@ -1146,7 +1144,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 	ssize_t i;
 	int res = 0;
 
-	for (i = 0; i < ARRAY_SIZE(command_list); i++) {
+	for (i = 0; i < (long int)(ARRAY_SIZE(command_list)); i++) {
 		struct command_item *util = xcalloc(1, sizeof(*util));
 		util->command = command_list[i].command;
 		string_list_append(&commands.items, command_list[i].string)
@@ -1183,7 +1181,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 		struct command_item *util;
 
 		i = list_and_choose(&s, &commands, &main_loop_opts);
-		if (i < 0 || i >= commands.items.nr)
+		if (i < 0 || i >= (long int)(commands.items.nr))
 			util = NULL;
 		else
 			util = commands.items.items[i].util;
-- 
2.34.1

