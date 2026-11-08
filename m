Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794173916;
	b=RZYxzzYPFxQwLwGwdtuCtcl3CQV1yqHD0jF+sUckDxyil3Co3zfXRaV0DRB+NjZWHWwN
	 iNfZANRnYeJhiLpO3v6ZI6+UvfdW3FaYcZy1GNiZESxx2z3BMJc0vnl9wWK3QyywtG4C8
	 OVqur1QBflHkJajbtImiVSa2Z2xYpcl/g0ugZztl+Yvnbl1KKaSi7Lj1I9jLxOtwxah4L
	 DMF98vhzOFJ09a1R4Wyf9xNH5TAkyzYrsWrvgNf/7OB2GzHorTN7Iw41p1TEiNEPYqTkE
	 tO0Ivs2LKgSVlVB17FlUzBE6Ajt+vH42Wx3sZWbZGU7Wd/2Bop1PS0lJAXtwlBPx4mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794173916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pGYWut4f7Iguaf0huuXB6v2/Nzu5BshnHi38p8vDaeM=;
	b=f74SIMqZ1XaT49DJaXKdaHcLgh0wQoL2CeQPiZi5ejnlkzrxQZWkv6+DWhvezOjnkQTI
	 u2pqXW6VmXW1KTSlCxsFJwnotoCoXoUjlrAYmmwC55b/24iJWt6O5QWGtUvt4/EsuwPA8
	 RE/KF9jlfJOSBaeENWM/qbjRTywoJAL4WtQdYCYEP5TW5Z34uVHjHaCJ8N1YRg+/aLmHp
	 vStz+HK19Cf6PuaJzOdeLgH/MZzl20t47bdn4Bj/qYbDJVEv2PhvfsxBbuxBTqsS6SLU0
	 BJfMK5csXcMF2uH1hWLqGbcoxkqmfpId411Rz/sCGTLK13AfwMwWr+4UX+BAB6AxQGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="s/qFzUYK";
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B56F606A31C
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 21:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B56F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s/qFzUYK
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1aefd1bf74aso195689c88.1
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 13:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794173915; x=1794778715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pGYWut4f7Iguaf0huuXB6v2/Nzu5BshnHi38p8vDaeM=;
        b=s/qFzUYKBvEIZ7CiCPB9AXiqMkJS4NRsziwOvZs9UcpIf83gOrZhZM0rcN0z4TQg0Y
         GdA4f9xEslFl9MCEwDUKo3xO8w83T+/lgR0B+E9jgg8PgDfbAUjiO0DRB7A0zLw5si07
         v9eui/dcsuuZnE/lT8V/OuoCevXlxLvBWtOgsFMn2kBBTJ03UsDR5K1g5RD/sAYhFCJA
         vInTI7VdTBkSqVb8pRfarNj2hS8buGKDQqqZ84T0WiRS8xqylshpjVLp+ECh8WcUleGc
         kY6tw+aSe4fL0jqk29XhrtvQ4tCg3RPzLOIyVt2t/pXWYL0FoKTxBUcR71KrcBVYyLg1
         0KBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794173915; x=1794778715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pGYWut4f7Iguaf0huuXB6v2/Nzu5BshnHi38p8vDaeM=;
        b=WBGjDeKh5Fd6TlwKy5tQI0zYzw6PqjMzQlXeE8pLRnLWeKrFSLxiboD8GvntjkPxP4
         ca0VC7jZZ1eCx+v/Uj6UnyTabgIc2CapVan9IJRk9Z+B1qDHblS+sg6kGT5+t+mpL+Yw
         HnVnJ6PuXYsSLOoPL3gqq2rpFZLPeVkJ6yeU4b8UG/e20iq2vVQQsV35epyYgpw4LjXD
         Ofac7Vt+Yf0ML8evQ17XFPcrVHqW8ak4qfj/Vd9vRyeQ8OL1un4SxuvHxwYQonPyMWb4
         YJ0JTJnx2VJTa+RAmfXybJ5IWOt9EyU5OSjngek7TDteSXXjAf8IuVmnHCnD/mmPXYiV
         dGSw==
X-Gm-Message-State: APuU4Z+3PqHEcPnVYB38w0fayaW2R4wLo8+q1iBn8+s4vAW0CBMVh6kY
	RAFu/yfOgJvjlnrKav1huwtKO6DohqiIggAdJTaCizdH3G6e133oXVBd
X-Gm-Gg: AYBFou075gWDD82WngBMisdQ2OD5+BPhJT94GO0vAnYkB0pSKWlyEvdnKn8T72zqd6e
	FYc+UAy6OsZl84DuQdIlIrEjzOOFrUHDA34n1mFcUqHU4MTX2mMCKSTi+vL7UOhhZkrqKTLF9/u
	3oX0tgh+eDPyeGnAFPrSP5z6wHh362ybFwv/n82CQ6XsWDoZq/FM788J4X2ULaYNJkY0gmZldSV
	cQbxQFtreJFpxQnmiynfqwcigrijAaZb4lJrkiqag4t8h8jSguNkqgamuXXgs8yuCE3k8jD0P36
	CESdnqU1dORzhhjGr0JWRWKTiMBupd1IXNb+7dh1XjAza5VOXvC4MWStGI3tXKC+7/r5e3oQzHY
	jluj4HAC5G6RR9dMnI7gifIPGL4APURBFn3evWMqs16x96OmEewQrkPjX5gOLVDoUB56R3b7ymL
	+jpeZNHYnj0aV+098rpW868x3z4lVoy+ORG3hN0/6BW5RG6laICHXgmQgI1y8Jmy3KlmjdTgP+y
	co2jIMabkLQxgZNvWsGgnVLqGyN3s7zPxi6X4avN2QZXQrMBjjcfD/NkkAXpUkk+1LCnqEBpbZ6
	BUwTz/cvFPUu/xNpzaogrSk+vyULmoQ+5Som1inDpKNr4LY5hpk=
X-Received: by 2002:a05:7023:e41:20b0:1b2:5ecf:9bd1 with SMTP id a92af1059eb24-1b269af173fmr7584418c88.7.1794173915092;
        Sun, 08 Nov 2026 13:38:35 -0800 (PST)
Received: from Anonymous.localdomain ([223.181.58.0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3771e8de2sm6974378c88.17.2026.11.08.13.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:38:34 -0800 (PST)
From: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	christian.couder@gmail.com,
	Hussain Sitamouwala <husainsitamuwala21@gmail.com>
Subject: [PATCH] environment: move assume_unchanged into repo_config_values
Date: Sun,  8 Nov 2026 21:38:14 +0000
Message-ID: <20261108213814.151202-1-husainsitamuwala21@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqo6bz2kxd.fsf@gitster.g>
References: <xmqqo6bz2kxd.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move assume_unchanged from global state into repository-specific
configuration to avoid sharing the setting across repositories.

Add a repository getter and update the callers to retrieve the
value using the appropriate repository instance.

Signed-off-by: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
---
 builtin/update-index.c |  2 +-
 environment.c          | 11 +++++++++--
 environment.h          |  3 ++-
 read-cache.c           |  6 +++---
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 018b78d6bb..65e9858457 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -431,7 +431,7 @@ static int add_cacheinfo(unsigned int mode, const struct object_id *oid,
 	ce->ce_flags = create_ce_flags(stage);
 	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
-	if (assume_unchanged)
+	if (repo_assume_unchanged(the_repository))
 		ce->ce_flags |= CE_VALID;
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
diff --git a/environment.c b/environment.c
index c83cf44839..17398c36d0 100644
--- a/environment.c
+++ b/environment.c
@@ -42,7 +42,6 @@ static int pack_compression_seen;
 static int zlib_compression_seen;
 
 int minimum_abbrev = 4, default_abbrev = -1;
-int assume_unchanged;
 char *git_commit_encoding;
 char *git_log_output_encoding;
 int fsync_object_files = -1;
@@ -152,6 +151,13 @@ int repo_has_symlinks(struct repository *repo)
 		: platform_has_symlinks();
 }
 
+int repo_assume_unchanged(struct repository *repo)
+{
+	return repo->initialized
+		? repo_config_values(repo)->assume_unchanged
+		: 0;
+}
+
 const char *repo_excludes_file(struct repository *repo)
 {
 	struct repo_config_values *cfg = repo_config_values(repo);
@@ -371,7 +377,7 @@ int git_default_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.ignorestat")) {
-		assume_unchanged = git_config_bool(var, value);
+		cfg->assume_unchanged = git_config_bool(var, value);
 		return 0;
 	}
 
@@ -775,6 +781,7 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->protect_ntfs = PROTECT_NTFS_DEFAULT;
 	cfg->ignore_case = 0;
 	cfg->trust_executable_bit = 1;
+	cfg->assume_unchanged = 0;
 	cfg->has_symlinks = platform_has_symlinks();
 	cfg->use_nanosec = 0;
 
diff --git a/environment.h b/environment.h
index 49c86e8879..bff7a7f911 100644
--- a/environment.h
+++ b/environment.h
@@ -147,6 +147,7 @@ struct repo_config_values {
 	int protect_ntfs;
 	int ignore_case;
 	int trust_executable_bit;
+	int assume_unchanged;
 	int has_symlinks;
 	int use_nanosec;
 
@@ -200,6 +201,7 @@ int repo_protect_ntfs(struct repository *repo);
 int repo_ignore_case(struct repository *repo);
 
 int repo_trust_executable_bit(struct repository *repo);
+int repo_assume_unchanged(struct repository *repo);
 
 int repo_has_symlinks(struct repository *repo);
 
@@ -242,7 +244,6 @@ int have_git_dir(void);
 
 /* Environment bits from configuration mechanism */
 extern int minimum_abbrev, default_abbrev;
-extern int assume_unchanged;
 extern unsigned long pack_size_limit_cfg;
 
 extern int grafts_keep_true_parents;
diff --git a/read-cache.c b/read-cache.c
index 1d2b97c429..990bcc32c4 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -194,7 +194,7 @@ void fill_stat_cache_info(struct index_state *istate, struct cache_entry *ce, st
 {
 	fill_stat_data(&ce->ce_stat_data, st);
 
-	if (assume_unchanged)
+	if (repo_assume_unchanged(istate->repo))
 		ce->ce_flags |= CE_VALID;
 
 	if (S_ISREG(st->st_mode)) {
@@ -1415,7 +1415,7 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 		 * is not marked VALID, this is the place to mark it
 		 * valid again, under "assume unchanged" mode.
 		 */
-		if (ignore_valid && assume_unchanged &&
+		if (ignore_valid && repo_assume_unchanged(istate->repo) &&
 		    !(ce->ce_flags & CE_VALID))
 			; /* mark this one VALID again */
 		else {
@@ -1450,7 +1450,7 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 	 * (i.e. things to be edited) will reacquire CE_VALID bit
 	 * automatically, which is not really what we want.
 	 */
-	if (!ignore_valid && assume_unchanged &&
+	if (!ignore_valid && repo_assume_unchanged(istate->repo) &&
 	    !(ce->ce_flags & CE_VALID))
 		updated->ce_flags &= ~CE_VALID;
 
-- 
2.53.0

