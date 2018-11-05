Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 541D81F453
	for <e@80x24.org>; Mon,  5 Nov 2018 19:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387983AbeKFEmZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 23:42:25 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33875 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387962AbeKFEmY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 23:42:24 -0500
Received: by mail-lj1-f194.google.com with SMTP id u6-v6so9161066ljd.1
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 11:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G+Nek8bHEs/aURWlpIkOGWZN9CRGpbaRdFIg4gA2GUk=;
        b=OQt1waf6BjYptp/bNpngwAMD0m0rNRgFIUKDmCd3Ax60WHObYSzGcx3FPm0OR5ONYu
         f1nS2/Mi0GTEfacGA+VNNbt/vThi362GCoVN3mB84QKZHHs3yR422MUeupHGyCoETOKQ
         LMh4Mb9SSMU3W1Mo1kFIGlgbIqFjanlnz5ckUsufdg39jUmbvjS9OC8I+WxgZrO10y+9
         ZwHEXMEDL8Y7ZTMi2eXo0BNsySVaQ0ApQp4MQai/0TlXlF3GUv3VC5EDqnZsTY/x3KWY
         bTiuxsXWIGDYBatpLv1NGeFB8kOF/OCeDNv8AKj//2rMoHs0HhWGyBJU7ZqHeJbUe9Wv
         vnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G+Nek8bHEs/aURWlpIkOGWZN9CRGpbaRdFIg4gA2GUk=;
        b=s5drDcTWZkjeRIFQ6EQz/BjQjllX8difczNbwpqf1Cu/A8FxFhussraObCYYK3QIRU
         l0/cQ6TWyEkMThM14R32bHBBuGSdT/MPbjKpKWaAcGPGBmolzVNT8INj0vXVReDWu39B
         6af56qOAPf7G8klSln+SB9TkM7JdRTCTbr0al0+TtrPvWWmenOEPsM2mXY9iuyVJyvhT
         0UErUux3Wd17DqpFPw7HjUAE793HrZkHQPZkKAfG/Qf0tEELtk8lRAcf2W2+dqXOJ/D0
         UTxnISj00i4X9QLp7tV+L6e+M2dP/7QVVq0UtnPr30aluhwEYjk/+3MPISNxO0OjbREw
         xOeQ==
X-Gm-Message-State: AGRZ1gJ71pPvGkWMW2mqgjDls2J/IWS/LkD01jhC/B8FYR31wxiBt7RY
        5z9cO3TGMS+Khi68k4Bx+wM=
X-Google-Smtp-Source: AJdET5ebHny1zNOBcVm5N7wQ9ge2Asho/x4Wq3vGlb7y3xwGYUbWGZi3e43eQ94Vbb1beJU6Z6It2g==
X-Received: by 2002:a2e:50d:: with SMTP id 13-v6mr14967343ljf.85.1541445673214;
        Mon, 05 Nov 2018 11:21:13 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x5-v6sm3591056lfe.58.2018.11.05.11.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 11:21:12 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 06/16] read-cache.c: mark more strings for translation
Date:   Mon,  5 Nov 2018 20:20:49 +0100
Message-Id: <20181105192059.20303-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181105192059.20303-1-pclouds@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
 <20181105192059.20303-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a couple other improvements on these strings as well:

 - add missing colon (as separator)
 - quote paths
 - provide more information on error messages
 - keep first word in lowercase

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c    | 57 +++++++++++++++++++++++++------------------------
 t/t1450-fsck.sh |  2 +-
 2 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 0c37f4885e..858befe738 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -672,7 +672,8 @@ static struct cache_entry *create_alias_ce(struct index_state *istate,
 	struct cache_entry *new_entry;
 
 	if (alias->ce_flags & CE_ADDED)
-		die("Will not add file alias '%s' ('%s' already exists in index)", ce->name, alias->name);
+		die(_("will not add file alias '%s' ('%s' already exists in index)"),
+		    ce->name, alias->name);
 
 	/* Ok, create the new entry using the name of the existing alias */
 	len = ce_namelen(alias);
@@ -687,7 +688,7 @@ void set_object_name_for_intent_to_add_entry(struct cache_entry *ce)
 {
 	struct object_id oid;
 	if (write_object_file("", 0, blob_type, &oid))
-		die("cannot create an empty blob in the object database");
+		die(_("cannot create an empty blob in the object database"));
 	oidcpy(&ce->oid, &oid);
 }
 
@@ -708,7 +709,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		newflags |= HASH_RENORMALIZE;
 
 	if (!S_ISREG(st_mode) && !S_ISLNK(st_mode) && !S_ISDIR(st_mode))
-		return error("%s: can only add regular files, symbolic links or git-directories", path);
+		return error(_("%s: can only add regular files, symbolic links or git-directories"), path);
 
 	namelen = strlen(path);
 	if (S_ISDIR(st_mode)) {
@@ -763,7 +764,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	if (!intent_only) {
 		if (index_path(istate, &ce->oid, path, st, newflags)) {
 			discard_cache_entry(ce);
-			return error("unable to index file %s", path);
+			return error(_("unable to index file '%s'"), path);
 		}
 	} else
 		set_object_name_for_intent_to_add_entry(ce);
@@ -782,7 +783,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		discard_cache_entry(ce);
 	else if (add_index_entry(istate, ce, add_option)) {
 		discard_cache_entry(ce);
-		return error("unable to add %s to index", path);
+		return error(_("unable to add '%s' to index"), path);
 	}
 	if (verbose && !was_same)
 		printf("add '%s'\n", path);
@@ -793,7 +794,7 @@ int add_file_to_index(struct index_state *istate, const char *path, int flags)
 {
 	struct stat st;
 	if (lstat(path, &st))
-		die_errno("unable to stat '%s'", path);
+		die_errno(_("unable to stat '%s'"), path);
 	return add_to_index(istate, path, &st, flags);
 }
 
@@ -818,7 +819,7 @@ struct cache_entry *make_cache_entry(struct index_state *istate,
 	int len;
 
 	if (!verify_path(path, mode)) {
-		error("Invalid path '%s'", path);
+		error(_("invalid path '%s'"), path);
 		return NULL;
 	}
 
@@ -844,7 +845,7 @@ struct cache_entry *make_transient_cache_entry(unsigned int mode, const struct o
 	int len;
 
 	if (!verify_path(path, mode)) {
-		error("Invalid path '%s'", path);
+		error(_("invalid path '%s'"), path);
 		return NULL;
 	}
 
@@ -1297,12 +1298,12 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	if (!ok_to_add)
 		return -1;
 	if (!verify_path(ce->name, ce->ce_mode))
-		return error("Invalid path '%s'", ce->name);
+		return error(_("invalid path '%s'"), ce->name);
 
 	if (!skip_df_check &&
 	    check_file_directory_conflict(istate, ce, pos, ok_to_replace)) {
 		if (!ok_to_replace)
-			return error("'%s' appears as both a file and as a directory",
+			return error(_("'%s' appears as both a file and as a directory"),
 				     ce->name);
 		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
 		pos = -pos-1;
@@ -1676,10 +1677,10 @@ static int verify_hdr(const struct cache_header *hdr, unsigned long size)
 	int hdr_version;
 
 	if (hdr->hdr_signature != htonl(CACHE_SIGNATURE))
-		return error("bad signature");
+		return error(_("bad signature 0x%08x"), hdr->hdr_signature);
 	hdr_version = ntohl(hdr->hdr_version);
 	if (hdr_version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < hdr_version)
-		return error("bad index version %d", hdr_version);
+		return error(_("bad index version %d"), hdr_version);
 
 	if (!verify_index_checksum)
 		return 0;
@@ -1688,7 +1689,7 @@ static int verify_hdr(const struct cache_header *hdr, unsigned long size)
 	the_hash_algo->update_fn(&c, hdr, size - the_hash_algo->rawsz);
 	the_hash_algo->final_fn(hash, &c);
 	if (!hasheq(hash, (unsigned char *)hdr + size - the_hash_algo->rawsz))
-		return error("bad index file sha1 signature");
+		return error(_("bad index file sha1 signature"));
 	return 0;
 }
 
@@ -1718,9 +1719,9 @@ static int read_index_extension(struct index_state *istate,
 		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
-			return error("index uses %.4s extension, which we do not understand",
+			return error(_("index uses %.4s extension, which we do not understand"),
 				     ext);
-		fprintf(stderr, "ignoring %.4s extension\n", ext);
+		fprintf_ln(stderr, _("ignoring %.4s extension"), ext);
 		break;
 	}
 	return 0;
@@ -1767,7 +1768,7 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 		extended_flags = get_be16(&ondisk2->flags2) << 16;
 		/* We do not yet understand any bit out of CE_EXTENDED_FLAGS */
 		if (extended_flags & ~CE_EXTENDED_FLAGS)
-			die("Unknown index entry format %08x", extended_flags);
+			die(_("unknown index entry format 0x%08x"), extended_flags);
 		flags |= extended_flags;
 		name = ondisk2->name;
 	}
@@ -1840,13 +1841,13 @@ static void check_ce_order(struct index_state *istate)
 		int name_compare = strcmp(ce->name, next_ce->name);
 
 		if (0 < name_compare)
-			die("unordered stage entries in index");
+			die(_("unordered stage entries in index"));
 		if (!name_compare) {
 			if (!ce_stage(ce))
-				die("multiple stage entries for merged file '%s'",
+				die(_("multiple stage entries for merged file '%s'"),
 				    ce->name);
 			if (ce_stage(ce) > ce_stage(next_ce))
-				die("unordered stage entries for '%s'",
+				die(_("unordered stage entries for '%s'"),
 				    ce->name);
 		}
 	}
@@ -2149,19 +2150,19 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	if (fd < 0) {
 		if (!must_exist && errno == ENOENT)
 			return 0;
-		die_errno("%s: index file open failed", path);
+		die_errno(_("%s: index file open failed"), path);
 	}
 
 	if (fstat(fd, &st))
-		die_errno("cannot stat the open index");
+		die_errno(_("%s: cannot stat the open index"), path);
 
 	mmap_size = xsize_t(st.st_size);
 	if (mmap_size < sizeof(struct cache_header) + the_hash_algo->rawsz)
-		die("index file smaller than expected");
+		die(_("%s: index file smaller than expected"), path);
 
 	mmap = xmmap(NULL, mmap_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (mmap == MAP_FAILED)
-		die_errno("unable to map index file");
+		die_errno(_("%s: unable to map index file"), path);
 	close(fd);
 
 	hdr = (const struct cache_header *)mmap;
@@ -2243,7 +2244,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 
 unmap:
 	munmap((void *)mmap, mmap_size);
-	die("index file corrupt");
+	die(_("index file corrupt"));
 }
 
 /*
@@ -2255,7 +2256,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 static void freshen_shared_index(const char *shared_index, int warn)
 {
 	if (!check_and_freshen_file(shared_index, 1) && warn)
-		warning("could not freshen shared index '%s'", shared_index);
+		warning(_("could not freshen shared index '%s'"), shared_index);
 }
 
 int read_index_from(struct index_state *istate, const char *path,
@@ -2290,7 +2291,7 @@ int read_index_from(struct index_state *istate, const char *path,
 	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_oid_hex);
 	ret = do_read_index(split_index->base, base_path, 1);
 	if (!oideq(&split_index->base_oid, &split_index->base->oid))
-		die("broken index, expect %s in %s, got %s",
+		die(_("broken index, expect %s in %s, got %s"),
 		    base_oid_hex, base_path,
 		    oid_to_hex(&split_index->base->oid));
 
@@ -3076,7 +3077,7 @@ static int write_shared_index(struct index_state *istate,
 		return ret;
 	ret = adjust_shared_perm(get_tempfile_path(*temp));
 	if (ret) {
-		error("cannot fix permission bits on %s", get_tempfile_path(*temp));
+		error(_("cannot fix permission bits on '%s'"), get_tempfile_path(*temp));
 		return ret;
 	}
 	ret = rename_tempfile(temp,
@@ -3222,7 +3223,7 @@ int read_index_unmerged(struct index_state *istate)
 		new_ce->ce_namelen = len;
 		new_ce->ce_mode = ce->ce_mode;
 		if (add_index_entry(istate, new_ce, ADD_CACHE_SKIP_DFCHECK))
-			return error("%s: cannot drop to stage #0",
+			return error(_("%s: cannot drop to stage #0"),
 				     new_ce->name);
 	}
 	return unmerged;
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 0f2dd26f74..90c765df3a 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -754,7 +754,7 @@ test_expect_success 'detect corrupt index file in fsck' '
 	test_when_finished "mv .git/index.backup .git/index" &&
 	corrupt_index_checksum &&
 	test_must_fail git fsck --cache 2>errors &&
-	grep "bad index file" errors
+	test_i18ngrep "bad index file" errors
 '
 
 test_done
-- 
2.19.1.1005.gac84295441

