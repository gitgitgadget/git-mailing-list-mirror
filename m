Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78E53E5A3F
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407562; cv=none; b=u9/9lNKJ0052cVoStp6XQQHoQmesmwgICa2zzKnR8Ju35Y9uBt2nAOvJsfjw7vVXUSfSAILWt1ts6KGFa3fyUuamRdiD19oxSIcVK1XTwFhhCnctTkKQfRFdTOpK1neif0gva9VWNMptZFhnXanU7GBnxNni0vS7S6A9okISG7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407562; c=relaxed/simple;
	bh=fHGMOoDw++CjDLWIafUwGriMuB1lJQBWmpefi8VSow0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Au3CXNH7LfU/k4t1X/wnzmnjAVluv8sI8vdcpjvRkyV1ya6Nu3vfKuZlTW/a9k7A1TsO2jK6dGG+LHaztyC3E3SNQWWjrpqCycIOgAkjFqYTZY7HxLxE5zDytCKEaI05KTA/tEFCMrAUMP7J7/Zv2XiFYduVwFYU/6STANBM27g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5jea6/o; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5jea6/o"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5174a1d78f8so23283121cf.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 06:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780407560; x=1781012360; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6kCO3AIxNtcZlKM2HaVjx1EtMusuxGJL2Oe24Wsut0=;
        b=H5jea6/odUDfHT7mwATa/ETDPdUdP6dSxi5U2qQ+twKuLS5ymIge3byQ8Sk4avY5kf
         ijr3uEyhwE3P/SovANLPVMimmwgCydH7D/bdV5ftdnwZvm6royn+inX3Ll1+rYYrTI2h
         40hisH9brN4zc2dY0XlGXQV8zin24KEHMjiZ8zgMWrC0GuNHU4KW3lCKiST+NBh0xGlo
         818rmn9xRxfdUyg/IFVgol7PrbgClWc35nymQv612lndKEtgQdehC5K9ECj4u3aICKDq
         1beVbHiiCluGx/V+Dkn1ugSbef17dh21+QINBhB/NcKltllr6Ost1K5ahnyX6c22r319
         WqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780407560; x=1781012360;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w6kCO3AIxNtcZlKM2HaVjx1EtMusuxGJL2Oe24Wsut0=;
        b=e7lbJFcfwSPBouKIW7EnpNinKiNT9HgLRcM2GgaIMKfVguc40X4eNyVOnPhcJUGWFj
         I0I5OEBaYkmjQH2U6nxG1YdCekPjYqIt7OvC7i8GXyiDUVHQ2ecxWCGxEc8QxGKLhjFG
         TYdu247bQ/D0qBwks4ioCtP15prXJ3z1GTfZU4RPf4K7uIU7OSXMcBI2EQuaXGXmtSdA
         BHQU1RM6DbyrluT7Idj09WDVL7S69wAFc3au08H8epculk9Ej0hzlo6HKwTwjESEVHCD
         I8Upnso16WPxHozgsmi8I4LRucgac2dTDCOeCIQUdeVfRRIsYCrH64KBpMR19p/Egk6N
         w5VQ==
X-Gm-Message-State: AOJu0YxElD2NFYtUdxPRiORBS1pZiJffOPkmFuIuEPtNm0NdaP5khrsj
	tcHcGUJBCYIxgNjffy8k3vPYh32nIN+qtm16/aevO+iUfkN4ErAsbZnLZpMdBA==
X-Gm-Gg: Acq92OHeNhd7KKAa8+DnddK6NV+l9CQ2F38HlM1CXvExiS7cC2cfa8lR4+4bbeGXjT5
	l7pZHEjWeDN87XAVapOZ3ibipXmD6HPlOebiSLSG4QLPXJ8uGfJEypKuuwtv9KpdyeUpf1HY8h/
	Fv9ogKHazzE5kkLFmgFUsERVRDLQssg63n4nMWOx3bYMOBy/9Q5TlK6JVTIa4NpqHZB9a47ak8b
	SA6+231CJUBpuysH+DHSHXJh9nHQQWtyqW4pR9Ok5LZpBQOidLL2NEjsAAhM9J96ofnr3SiFA7N
	uRCCJRoBSeue3L/z1qpLAwsUnAtq7iFOWeSz9OMJoZWgawx4cJTnWzbBnudFlOYkMlMkiwoc4vS
	gZlL5n7OP327ieDP1CQmUZubRz4fZsLX65+QgtgHCpWQQ/chY6t798oRaAPnRR90Ozdq6mwvtgw
	Cm8DGISivIxpkM5v04P3T9ahdDWycOG8UAPC0=
X-Received: by 2002:a05:622a:1186:b0:50d:a1c4:e154 with SMTP id d75a77b69052e-5173a8f1eadmr212262641cf.36.1780407559713;
        Tue, 02 Jun 2026 06:39:19 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.53.83])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea0425dfsm120943026d6.3.2026.06.02.06.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:39:19 -0700 (PDT)
Message-Id: <d938ebf95a817c00a415670c08b839747d711d29.1780407557.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2302.v5.git.git.1780407557.gitgitgadget@gmail.com>
References: <pull.2302.v4.git.git.1779823288005.gitgitgadget@gmail.com>
	<pull.2302.v5.git.git.1780407557.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 02 Jun 2026 13:39:16 +0000
Subject: [PATCH v5 1/2] config: let git_config_parse_key() validate quietly
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add a "quiet" parameter that suppresses the error() calls, and let
store_key be NULL to skip the canonical-copy allocation.  Existing
callers pass 0 for quiet.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/config.c   |  2 +-
 config.c           | 34 ++++++++++++++++++++++------------
 config.h           |  2 +-
 submodule-config.c |  2 +-
 4 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index cf4ba0f7cc..b3188cd8d4 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -555,7 +555,7 @@ static int get_value(const struct config_location_options *opts,
 			goto free_strings;
 		}
 	} else {
-		if (git_config_parse_key(key_, &key, NULL)) {
+		if (git_config_parse_key(key_, &key, NULL, 0)) {
 			ret = CONFIG_INVALID_KEY;
 			goto free_strings;
 		}
diff --git a/config.c b/config.c
index a1b92fe083..81b31c5155 100644
--- a/config.c
+++ b/config.c
@@ -536,11 +536,14 @@ static inline int iskeychar(int c)
  * -2 if there is no section name in the key.
  *
  * store_key - pointer to char* which will hold a copy of the key with
- *             lowercase section and variable name
+ *             lowercase section and variable name, can be NULL to skip
+ *             allocation when only validation is needed
  * baselen - pointer to size_t which will hold the length of the
  *           section + subsection part, can be NULL
+ * quiet - when non-zero, suppress error() reports on rejection
  */
-int git_config_parse_key(const char *key, char **store_key, size_t *baselen_)
+int git_config_parse_key(const char *key, char **store_key, size_t *baselen_,
+			 int quiet)
 {
 	size_t i, baselen;
 	int dot;
@@ -552,12 +555,14 @@ int git_config_parse_key(const char *key, char **store_key, size_t *baselen_)
 	 */
 
 	if (last_dot == NULL || last_dot == key) {
-		error(_("key does not contain a section: %s"), key);
+		if (!quiet)
+			error(_("key does not contain a section: %s"), key);
 		return -CONFIG_NO_SECTION_OR_NAME;
 	}
 
 	if (!last_dot[1]) {
-		error(_("key does not contain variable name: %s"), key);
+		if (!quiet)
+			error(_("key does not contain variable name: %s"), key);
 		return -CONFIG_NO_SECTION_OR_NAME;
 	}
 
@@ -568,7 +573,8 @@ int git_config_parse_key(const char *key, char **store_key, size_t *baselen_)
 	/*
 	 * Validate the key and while at it, lower case it for matching.
 	 */
-	*store_key = xmallocz(strlen(key));
+	if (store_key)
+		*store_key = xmallocz(strlen(key));
 
 	dot = 0;
 	for (i = 0; key[i]; i++) {
@@ -579,21 +585,25 @@ int git_config_parse_key(const char *key, char **store_key, size_t *baselen_)
 		if (!dot || i > baselen) {
 			if (!iskeychar(c) ||
 			    (i == baselen + 1 && !isalpha(c))) {
-				error(_("invalid key: %s"), key);
+				if (!quiet)
+					error(_("invalid key: %s"), key);
 				goto out_free_ret_1;
 			}
 			c = tolower(c);
 		} else if (c == '\n') {
-			error(_("invalid key (newline): %s"), key);
+			if (!quiet)
+				error(_("invalid key (newline): %s"), key);
 			goto out_free_ret_1;
 		}
-		(*store_key)[i] = c;
+		if (store_key)
+			(*store_key)[i] = c;
 	}
 
 	return 0;
 
 out_free_ret_1:
-	FREE_AND_NULL(*store_key);
+	if (store_key)
+		FREE_AND_NULL(*store_key);
 	return -CONFIG_INVALID_KEY;
 }
 
@@ -609,7 +619,7 @@ static int config_parse_pair(const char *key, const char *value,
 
 	if (!strlen(key))
 		return error(_("empty config key"));
-	if (git_config_parse_key(key, &canonical_name, NULL))
+	if (git_config_parse_key(key, &canonical_name, NULL, 0))
 		return -1;
 
 	ret = (fn(canonical_name, value, &ctx, data) < 0) ? -1 : 0;
@@ -1708,7 +1718,7 @@ static int configset_find_element(struct config_set *set, const char *key,
 	 * `key` may come from the user, so normalize it before using it
 	 * for querying entries from the hashmap.
 	 */
-	ret = git_config_parse_key(key, &normalized_key, NULL);
+	ret = git_config_parse_key(key, &normalized_key, NULL, 0);
 	if (ret)
 		return ret;
 
@@ -3001,7 +3011,7 @@ int repo_config_set_multivar_in_file_gently(struct repository *r,
 	validate_comment_string(comment);
 
 	/* parse-key returns negative; flip the sign to feed exit(3) */
-	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
+	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen, 0);
 	if (ret)
 		goto out_free;
 
diff --git a/config.h b/config.h
index bf47fb3afc..2c66d334c1 100644
--- a/config.h
+++ b/config.h
@@ -341,7 +341,7 @@ int repo_config_set_worktree_gently(struct repository *, const char *, const cha
  */
 void repo_config_set(struct repository *, const char *, const char *);
 
-int git_config_parse_key(const char *, char **, size_t *);
+int git_config_parse_key(const char *, char **, size_t *, int quiet);
 
 /*
  * The following macros specify flag bits that alter the behavior
diff --git a/submodule-config.c b/submodule-config.c
index a81897b4e0..a319956f7a 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -970,7 +970,7 @@ int print_config_from_gitmodules(struct repository *repo, const char *key)
 	int ret;
 	char *store_key;
 
-	ret = git_config_parse_key(key, &store_key, NULL);
+	ret = git_config_parse_key(key, &store_key, NULL, 0);
 	if (ret < 0)
 		return CONFIG_INVALID_KEY;
 
-- 
gitgitgadget

