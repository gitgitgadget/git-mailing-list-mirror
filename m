Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB56A1EE002
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810841; cv=none; b=aP7D5+B6r7r2JAluQ4vKmRFhPaFjBZPOtGe9PSlsUDOK6bHyKZ5JfTnatJsIJDbzlnBa57DhHjuXW4nCtVNAvWVaS/h77WfVF46VV89i7FbgLl1FXIlZZU+k0ArydI4yCgZhNMyfrihO5/XDE2pRMeCfk1nJR9LneIg/fpCTOXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810841; c=relaxed/simple;
	bh=QQURTNcJXovYOltMZyMHc60lQbxEeHqaHR/zmNUEQQk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Iv5xRZGk9TPi/kLepNSNdPN7hlLTU4zGU/Zo+9JIty5TCpVNVnXAi1XbA6MhespEORxCTL2cIx2u6eyzcr0a/l0EOuomHDH3gpkoxGOjKq9C9IY6OmktPdTz1lr8xQxjdsZlApDI5UF0FfTJX7HnDGHL3uuOXJJmNyCj07NsJOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMUPolD2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMUPolD2"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so516329a91.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 13:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741810839; x=1742415639; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzC/L8pnaQ5JIlYyvN9iApFo62xImtcPnZAuPXaBjTU=;
        b=BMUPolD2Ot7gktGkc7hmSgwBQTosAnzE78GxE48NudgjNWLgKEd3TUIubBrZKp/yLs
         Ry7ut7282D+jgivGR+6vZ1NdTgSt2dJVS1Sr3ybKcyzRyFoZXJR3BjMaPcsEwAiGrtWE
         +4NGiw+S464t8997IBrs/xglx8vz+DYq3zr+ifDknI1dlA0r7mUAJA6ANn8lCG1N+rbN
         KU7TcbF/V+PTdOg1Uo9X71cy4WrxhBHaGHvfaPGDHFhIc26giu9/jM9qlZT/PIlM+Jda
         OmdktSn+cc364uG14Tm94vccH2VdHUNQnYWdyJPMPk8hRqCkyBa5Q+3ajhbE4cKM6XVb
         f0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741810839; x=1742415639;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WzC/L8pnaQ5JIlYyvN9iApFo62xImtcPnZAuPXaBjTU=;
        b=WBwLR9f1zC7tQOpYW+J0FbVm/+2KLvwZ1J3YITn03Il731dgrOPA2CYavkSrGo4ZhZ
         Y/bsXTTuIbkgb8+Modm+LiM/y3OQxdQf+iUgwgqDaU6uE9pHijrhcGgFw77kj1xYLCM6
         PmN96uuBPLIAXa43aakNYyTBeZkvqETTC1Nhk7Y8AlEGRX1ayk7BZ6lExgoq0anaKNEi
         l3jkOALPom6X61484pZMZtZOwvcQXsD38XU8/IGGzbxLr3r7g/2dkcPCQC+J01Qwm8Td
         MZkgz0fLPrKNCpqmkxhJdxQrzv8S+UbVDXzNoTXEEoUwiVuvBMiHwpepExA2KuUe8wgZ
         iLSQ==
X-Gm-Message-State: AOJu0YzBkjdbcM1/XnGfM8Ft4MFiy6I0M4i18UJ4nwu4sNRXiO/CGKCJ
	BRoZ5a2gBLTPaJRYw0SlMqYbVFbG49mR3C96Gn1dnCN5Q/28Tp5EyyMSxg==
X-Gm-Gg: ASbGncvuddC0zAX9rDxJ24OZGlNBKyQayIfmQ9+nzPGob1TrkGa5oCJhdxQWw2VoGq/
	LpvZmjOHYqJZ/7gCo/SmEnGuWkOGCvNwd/pc/x+jNgHTOTW+lyIUtMuAYtxGRgPGRe5ZB71Nu02
	dyUeubesfHedP9AznzQR3x+zifoCWM0HDrGmlwece68fGk15Qx+roWbEJ3SJ2JJU+QiUH/61Ecl
	lsDFuPGIzT4E+JrW/6exI41kxMLs/qrW6alO/wqQnWkNo1eoDBG8UEgEyd2nNSD9dgJ+l1uqMYT
	noNz6/RyeCtlNpaqf8pfVJfFGCsJMg2hpMry/txKA6gDrfTtxw==
X-Google-Smtp-Source: AGHT+IEnXW8EhgY3tui6tacItk5gFnqKbgixKBOxzw2T1AXjjKFxI47cW3Weja1MFo1HQKlpNsKgLA==
X-Received: by 2002:a17:90b:53ce:b0:2ff:4a8d:74f8 with SMTP id 98e67ed59e1d1-300ff0a93demr10976223a91.6.1741810838919;
        Wed, 12 Mar 2025 13:20:38 -0700 (PDT)
Received: from [10.61.60.205] ([103.21.124.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301027187c4sm4388609a91.0.2025.03.12.13.20.37
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 13:20:38 -0700 (PDT)
Message-ID: <a3aa5f99-63ce-4be5-8d64-fb6e226b3bf9@gmail.com>
Date: Thu, 13 Mar 2025 01:50:35 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Arnav Bhate <bhatearnav@gmail.com>
Subject: [GSoC PATCH] pathspec: fix sign comparison warnings
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There are multiple places, especially in loops, where a signed and an
unsigned data type are compared. Git uses a mix of signed and unsigned
types to store lengths of arrays. This sometimes leads to using a signed
index for an array whose length is stored in an unsigned variable or
vice versa.

Replace signed data types with unsigned data types and vice versa
wherever necessary. In some cases, introduce a new variable, where both
signed and unsigned data types have been used to store lengths of arrays
in the same function, where previously only one variable was used to
iterate over both types. In cases where this is not possible, add
appropriate cast. Remove #define DISABLE_SIGN_COMPARE_WARNINGS.

Signed-off-by: Arnav Bhate <bhatearnav@gmail.com>
---
 pathspec.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 89663645e1..fd7dfdfd84 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
@@ -36,6 +35,7 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 					enum ps_skip_worktree_action sw_action)
 {
 	int num_unmatched = 0, i;
+	unsigned int j;
 
 	/*
 	 * Since we are walking the index as if we were walking the directory,
@@ -48,8 +48,8 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 			num_unmatched++;
 	if (!num_unmatched)
 		return;
-	for (i = 0; i < istate->cache_nr; i++) {
-		const struct cache_entry *ce = istate->cache[i];
+	for (j = 0; j < istate->cache_nr; j++) {
+		const struct cache_entry *ce = istate->cache[j];
 		if (sw_action == PS_IGNORE_SKIP_WORKTREE &&
 		    (ce_skip_worktree(ce) || !path_in_sparse_checkout(ce->name, istate)))
 			continue;
@@ -78,7 +78,7 @@ char *find_pathspecs_matching_skip_worktree(const struct pathspec *pathspec)
 {
 	struct index_state *istate = the_repository->index;
 	char *seen = xcalloc(pathspec->nr, 1);
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
@@ -130,7 +130,7 @@ static void prefix_magic(struct strbuf *sb, int prefixlen,
 	if (element[1] != '(') {
 		/* Process an element in shorthand form (e.g. ":!/<match>") */
 		strbuf_addstr(sb, ":(");
-		for (int i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
+		for (unsigned int i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 			if ((magic & pathspec_magic[i].bit) &&
 			    pathspec_magic[i].mnemonic) {
 				if (sb->buf[sb->len - 1] != '(')
@@ -341,7 +341,7 @@ static const char *parse_long_magic(unsigned *magic, int *prefix_len,
 
 	for (pos = elem + 2; *pos && *pos != ')'; pos = nextat) {
 		size_t len = strcspn_escaped(pos, ",)");
-		int i;
+		unsigned int i;
 
 		if (pos[len] == ',')
 			nextat = pos + len + 1; /* handle ',' */
@@ -354,7 +354,7 @@ static const char *parse_long_magic(unsigned *magic, int *prefix_len,
 		if (starts_with(pos, "prefix:")) {
 			char *endptr;
 			*prefix_len = strtol(pos + 7, &endptr, 10);
-			if (endptr - pos != len)
+			if ((size_t)(endptr - pos) != len)
 				die(_("invalid parameter for pathspec magic 'prefix'"));
 			continue;
 		}
@@ -400,7 +400,7 @@ static const char *parse_short_magic(unsigned *magic, const char *elem)
 
 	for (pos = elem + 1; *pos && *pos != ':'; pos++) {
 		char ch = *pos;
-		int i;
+		unsigned int i;
 
 		/* Special case alias for '!' */
 		if (ch == '^') {
@@ -564,7 +564,7 @@ static int pathspec_item_cmp(const void *a_, const void *b_)
 
 void pathspec_magic_names(unsigned magic, struct strbuf *out)
 {
-	int i;
+	unsigned int i;
 	for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 		const struct pathspec_magic *m = pathspec_magic + i;
 		if (!(magic & m->bit))
@@ -803,8 +803,8 @@ int match_pathspec_attrs(struct index_state *istate,
 int pathspec_needs_expanded_index(struct index_state *istate,
 				  const struct pathspec *pathspec)
 {
-	unsigned int i, pos;
-	int res = 0;
+	unsigned int pos;
+	int i, res = 0;
 	char *skip_worktree_seen = NULL;
 
 	/*
@@ -845,7 +845,7 @@ int pathspec_needs_expanded_index(struct index_state *istate,
 			 * - not-in-cone/bar*: may need expanded index
 			 * - **.c: may need expanded index
 			 */
-			if (strspn(item.original + item.nowildcard_len, "*") == item.len - item.nowildcard_len &&
+			if (strspn(item.original + item.nowildcard_len, "*") == (unsigned int)(item.len - item.nowildcard_len) &&
 			    path_in_cone_mode_sparse_checkout(item.original, istate))
 				continue;
 
@@ -860,7 +860,7 @@ int pathspec_needs_expanded_index(struct index_state *istate,
 				 * directory name and the sparse directory is the first
 				 * component of the pathspec, need to expand the index.
 				 */
-				if (item.nowildcard_len > ce_namelen(ce) &&
+				if ((unsigned int)item.nowildcard_len > ce_namelen(ce) &&
 				    !strncmp(item.original, ce->name, ce_namelen(ce))) {
 					res = 1;
 					break;
-- 
2.48.1
