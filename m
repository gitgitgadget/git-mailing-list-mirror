Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759698;
	b=ODcznm3s2wqtysWfXoijV2goaVuyXMDm64v/OX7+eY+EOlTD3fgmVqzIWu64x1rzxPaK
	 ueVLFT61ZECVmae9gtQg6iJ7WaKCqHJjh8a0olwQzsIR3aXfyuKcyaqKG21PNrT0wp46C
	 AQH9xFC5HoemCqf4EIASvNn4dsVyyuJvq8ugp3QKP70W5gMc7PgGuOD6Yk8DzsvFcEi8k
	 pHKEMKsD31WDw8p+9geBMqTZ6iQHXXZLAYovuYHrLRlOiwdhKA4pIiScwHmLiUprImZfw
	 VblY3KeWS/LGOjs8JlvHhTGH2XSql+5E28+lH49cKRbvOjnISpkAb4MaiwI6RuLWIzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759698;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=vGGtWvY40o5wo06A/WAx5TMBs3145aXcazyhC2HbKSI=;
	b=LjsR1bQL+9Dd0oaouImV4S428/PpefxCDMkAElEDFNmfoh0Uqe56nb9llN5BxaW8Sw9d
	 RWUCoFAj3E6r2FLMcwcGZjeORCQNJmKdC/ascuu6esZ+Mpo3v6shOJjVOfCbrradl5B7/
	 BA21kY4IoaU2Uda7HQO/6ycR54VouQLJoApTL4dQCtoiejfh2I8+58rU8VGux9sktcS4w
	 7VbdoZKxvj3/Dzp4zzbLQMzeEKER/YDsVr5IcmmfS+H5O6FUjKw1AJGEv8RRKPgZkFvxL
	 S9lRwA0P4iWDlO0/q+qvTO7nRBE+9OfdWesIMKi4fovthxR9vFPtr5bLDmbBzNjQ7CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=p7sQUTbV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RF88etiP;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A97606A31E
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18A97606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=p7sQUTbV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RF88etiP
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 776487A024D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:48:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 23 Oct 2026 08:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792759697;
	 x=1792846097; bh=vGGtWvY40o5wo06A/WAx5TMBs3145aXcazyhC2HbKSI=; b=
	p7sQUTbVZRaMfT7Cf02pDygOKEKDnuexIWSHHIG5cvtFik3e94/r2iFybMytjpMz
	C1iqE9zPZCn/BGl6quAZYYs/Gj5SYBatLR62WdPCfPfU5y5kKvBnyAL5GOrz6b8y
	0hnquDHgHlvuF6SDLiSlculA7ZN6W87GI5Zowe6hWrefEgec1X6+b5zWrAOatIxt
	olj28e6Pmat4so+cqoCBDtnLgbs5ZKiuKd2URnbPHk2rnE0zPE9TZE0Due/I/63A
	dNJW2Uav8EvwtVvzxJjwSdsu7+Fw5DdmCET/Lk6v72Wff9bD5AXI+aWBeNJ/cmdW
	DdH7uDIXO3MQ04xqcWNBug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792759697; x=
	1792846097; bh=vGGtWvY40o5wo06A/WAx5TMBs3145aXcazyhC2HbKSI=; b=R
	F88etiPG5FdBCzfGRrfa9a72aps1sBu8zUgmt4BmrANUA3ZqZ6C6OEqDP61LN/3x
	ln2OXYuQz1U3Lm2X5lCqGQHmvdoKZJ7R5TCNDFoE0oaj2dka2c1KEJybF/YMzgPv
	oFoxJG+SikVHsoibGji0wzCYTNIoSlQ70tmm3x9qvRkB5MoXX4f3oa2VHEf6iggI
	mwRPpb5NzaQIxgtL4rnwW6MelRu1ldn5V7RBu6KrhTss2ZH0XHv/hDZz6UfhV5Ql
	PmxYZzxZWFy51QXSpYoTHsGj0DSIl5DbWgeQavH3MaZV35SDGsOeQsBYz/S1t+3m
	TBXkBotFWQu4x7fs2PlDA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792759697; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:MkGl3pNBwZxZnSa1AheYAqUvVvBeAVubPNONPULDdFDeD/M
	rsj3/6Z1VCh/TB3NTKjvpT+b/XNjNIVlAQ+MaMgklUAOG5UsfVKlO7nrqdkx1PhJ
	QypzPZVsggOGsHWTa08rLZRjxY9G1KSD/YXA0qRYh48eWI77/i2cfZfxb8I792jj
	7nj4vvOYBADaacge+fytERx6U/xEUp1Ufp/rFxE4a2kNGmpuqXflm9tLggfUm6a9
	oke5dPNnfiMJU4BU8mIBn7tHqsDE+CA4zvr91v+in9d7l0HWPMncbMRZVdprSczn
	bwZ8+dt4XcUCZPquNUPpEWZQJZ6GR0mYhL4kEjA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:rCEL4cG7zTvu074hF3ujCAZOP2m50PAp34/d9fpyO8g=:eiMznaphW8o0y/24E9O+C4O6iFgiH16ImaGV+0A284s=;
X-ME-Sender: <xms:kVfbavb_VOz37dovB1npLafM9TmhdBfVdz4nNuPqbXK3MrMSD-fWzg>
    <xme:kVfbakafgyEumiUAWbmo3NLnRJRwChOGiE2HmE2q4AqDU2jKnU-REiUDInHZk0tPJ
    N7Mj-uks5opbnovwSbFMuj9c_mgppZxjNrOXQT3vy8TA1NMDB5AbPY>
X-ME-Received: <xmr:kVfbavmq9EJNTROPlTHhpsSpU8fDklfrDl1odvRV-BBqrIne0PdGTClDU_tlojm1UFOplA>
X-ME-Proxy-Cause: dmFkZTEpXyUGV8VdRoUkBMU1XHm0oNamOq9jVO1h+1Eoo8PulSnlm3AVUtSQCFmWt9sHN+
    LzV0PEBi6QsQ7rEXgJ3XMyIXVoiPaf0KF6R2smdSzcrFnQippswLqvPo6IV65Jwau8SPi3
    dtRii7+m2vVob7I6OXp0abDh79D9Z7pcXSgVWvUi1qCmpQXC3eEXRRX/oD8fImIJ4pFVD5
    ZOcTGf8Rye79CKVXNKz60ny04MDreqQynrF3l8KwW6K3hI4Ahw6UzpXrf6AIt6dk45HmVu
    PdZpKly2q0CxCCwQOPJH8oyl/Jp1FLlyjYtbo23O1cPGnO5LLXtxuBmDw6841JPC00eEtZ
    alxRKGwK3kz+nNqC7LJP2hjHJlfSXVa8TbmR/pyKLfS3gIuxng2Idmxqvgf9VFJ0NFFDpk
    N45kZ5KNOxN43LSgGm8REqFtnOaorB1eGSoZrVGyKsxStuN9GHs/QoKq6kU8qO68u7Wg9l
    7dhDczPx3MAQEVQgtmVP5c5Mv+H7i28jH/Oa+sXVgAYhKJbZ3sb6KRPuypVMWVybCXPtkc
    yShDKiDmt2v+nr3IWntLBZM+s/HFs4yWMqbSlvCZh8+kWEcdEAJh6BnFWSnyxjqIIYGAty
    L+Cc7UI/o1vKdD1x9cQJBNoTUFyFiJNONf+H2dEvpjduRI9UOH+WUrBR5/oA
X-ME-Proxy: <xmx:kVfbagzLLgfjNKrJA81ZqsVwB607H0FBOgxvy0-qgvxAzd2XSA_JrQ>
    <xmx:kVfbatO5L5opfXeW9At9SFMHxTEUYWaqCdTVpkxgSA60QkQCirQ_9A>
    <xmx:kVfbakScYW0IDTlGvxs_NnVgS8khmyxswjJ-M3h5dztepGXkt4vieQ>
    <xmx:kVfbarZTOSczbJi1FfzwD28mVD9dqn1QQUCtHUrCDbGoCBmsW2JdqQ>
    <xmx:kVfbalKKaG-4iP-XdjPI6zsKbK2DcmJpiO_wfpe_CNEehi1Dpug5_fVP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 08:48:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1a616d4b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 12:48:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 23 Oct 2026 14:48:03 +0200
Subject: [PATCH v2 4/6] odb/source-files: simplify directory duplication
 detection
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261023-pks-odb-files-reload-alternates-v2-4-30559d7ff43b@pks.im>
References: <20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im>
In-Reply-To: <20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>
X-Mailer: b4 0.15.2

When loading alternates it may happen that we try to add the same
alternate multiple times, either because "info/alternates" contains
duplicate entries or because one of its alternates matches the primary
object directory. We try to detect such duplicates via two mechanisms:

  - We have a hashmap of `struct odb_files_dir`, mapped by their
    absolute paths. If the path of an alternate is already present in
    this map we skip it.

  - We have another, explicit check to check whether the path of an
    alternate matches the primary object directory.

We can simplify both of these mechanisms by turning the map into a
strset, as we never access the values of the map. On the one hand this
gives us simpler interfaces to access the set. And on the other hand
this allows us to add two entries for the primary object directory: one
for the real path, and one for the absolute path.

Note that there is one gotcha though: when "core.ignorecase" is set then
the expectation is that we deduplicate alternates case-insensitively.
But we can also make that work rather easily by downcasing all paths we
add in that case.

Despite being significantly simpler, this also gives us a speedup
because we don't have to resolve the realpath of the primary object
directory on every call to `odb_files_dir_is_usable()` anymore. Using
the same benchmark as in the preceding commit:

  Benchmark 1: ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd~) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    289.0 ms  ±     2.2 ms     285.8 ms  …   295.1 ms
    Memory         5.6 MiB ±     0.1 MiB      5.4 MiB …     5.7 MiB

  Benchmark 2: ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    183.8 ms  ±     1.2 ms     181.5 ms  …   186.9 ms           -36.4%  (1.6x faster)
    Memory         5.6 MiB ±     0.1 MiB      5.3 MiB …     5.7 MiB           -0.5%

  Benchmark 3: ./git -C /tmp/repo cat-file --batch-check (rev = HEAD~) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    293.2 ms  ±     2.7 ms     288.8 ms  …   299.7 ms            +1.5%
    Memory         5.9 MiB ±     0.1 MiB      5.7 MiB …     6.1 MiB           +5.0%

  Benchmark 4: ./git -C /tmp/repo cat-file --batch-check (rev = HEAD) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    266.5 ms  ±     2.8 ms     262.6 ms  …   276.7 ms            -7.8%
    Memory         5.9 MiB ±     0.1 MiB      5.6 MiB …     6.1 MiB           +5.1%

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 103 +++++++++++++++++++----------------------------------
 odb/source-files.h |  17 ++++-----
 2 files changed, 43 insertions(+), 77 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index d66949b7de..22e96828d2 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -72,7 +72,7 @@ static void odb_source_files_free(struct odb_source *source)
 		odb_files_dir_free(files->dirs);
 		files->dirs = next;
 	}
-	hashmap_clear(&files->dirs_by_path);
+	strset_clear(&files->dir_paths);
 
 	odb_source_release(&files->base);
 	free(files);
@@ -176,60 +176,15 @@ static int odb_source_files_create_on_disk(struct odb_source *source,
 	return ret;
 }
 
-/*
- * NEEDSWORK: we're using "core.ignoreCase" to deduplicate alternates that
- * _may_ be the same. This requires quite a bit of boilerplate for dubious
- * benefit:
- *
- *   - Duplicating alternates should really only lead to regressed performance.
- *
- *   - We don't properly resolve symlinks or mointpoints, so we may still end
- *     up duplicating alternates.
- *
- *   - The value may be lying, in which case we might deduplicate alternates
- *     that are in fact not mapping to the same directory.
- *
- * We should investigate whether we can remove this whole mechanism outright.
- */
-static int odb_files_dir_paths_cmp(struct odb_source_files *files,
-				   const char *a, const char *b)
-{
-	if (files->dirs_paths_icase < 0) {
-		int icase = 0;
-		repo_config_get_bool(files->base.odb->repo, "core.ignorecase", &icase);
-		files->dirs_paths_icase = icase;
-	}
-
-	return files->dirs_paths_icase ? strcasecmp(a, b) : strcmp(a, b);
-}
-
-static int odb_files_dir_by_path_cmp(const void *cb_data,
-				     const struct hashmap_entry *entry,
-				     const struct hashmap_entry *entry_or_key,
-				     const void *keydata)
-{
-	struct odb_source_files *files = (struct odb_source_files *)cb_data;
-	const struct odb_files_dir *dir = container_of(entry, const struct odb_files_dir, by_path_entry);
-	const char *path = keydata;
-
-	if (!path)
-		path = container_of(entry_or_key, const struct odb_files_dir, by_path_entry)->abspath;
-
-	return odb_files_dir_paths_cmp(files, dir->abspath, path);
-}
-
 /*
  * Return non-zero iff the path is usable as an alternate object directory.
  */
 static bool odb_files_dir_is_usable(struct odb_source_files *files,
 				    const char *path)
 {
-	struct strbuf normalized_objdir = STRBUF_INIT;
-	struct hashmap_entry key;
+	struct strbuf buf = STRBUF_INIT;
 	bool usable = false;
 
-	strbuf_realpath(&normalized_objdir, files->base.path, 1);
-
 	/* Detect cases where alternate disappeared */
 	if (!is_directory(path)) {
 		error(_("object directory %s does not exist; "
@@ -239,28 +194,40 @@ static bool odb_files_dir_is_usable(struct odb_source_files *files,
 	}
 
 	/*
-	 * Prevent the common mistake of listing the same
-	 * thing twice, or object directory itself.
+	 * Prevent the common mistake of listing the same thing twice, or
+	 * object directory itself.
 	 */
-	if (!hashmap_get_size(&files->dirs_by_path)) {
+	if (strset_empty(&files->dir_paths)) {
+		files->dir_paths_icase = 0;
+		repo_config_get_bool(files->base.odb->repo, "core.ignorecase",
+				     &files->dir_paths_icase);
+
+		strbuf_realpath(&buf, files->base.path, 1);
+		if (files->dir_paths_icase)
+			strbuf_tolower(&buf);
+		strset_add(&files->dir_paths, buf.buf);
+
 		for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
-			hashmap_entry_init(&dir->by_path_entry,
-					   strihash(dir->abspath));
-			hashmap_add(&files->dirs_by_path, &dir->by_path_entry);
+			strbuf_reset(&buf);
+			strbuf_addstr(&buf, dir->abspath);
+			if (files->dir_paths_icase)
+				strbuf_tolower(&buf);
+			strset_add(&files->dir_paths, buf.buf);
 		}
 	}
 
-	if (!odb_files_dir_paths_cmp(files, path, normalized_objdir.buf))
-		goto out;
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, path);
+	if (files->dir_paths_icase)
+		strbuf_tolower(&buf);
 
-	hashmap_entry_init(&key, strihash(path));
-	if (hashmap_get(&files->dirs_by_path, &key, path))
+	if (strset_contains(&files->dir_paths, buf.buf))
 		goto out;
 
 	usable = true;
 
 out:
-	strbuf_release(&normalized_objdir);
+	strbuf_release(&buf);
 	return usable;
 }
 
@@ -365,11 +332,17 @@ static void add_alternate_recursively(struct odb_source_files *files,
 	*files->dirs_tail = alternate;
 	files->dirs_tail = &(alternate->next);
 
-	hashmap_entry_init(&alternate->by_path_entry, strihash(alternate->abspath));
-	if (hashmap_get(&files->dirs_by_path, &alternate->by_path_entry,
-			alternate->abspath))
-		BUG("object directory must not yet exist");
-	hashmap_add(&files->dirs_by_path, &alternate->by_path_entry);
+	if (files->dir_paths_icase) {
+		struct strbuf path = STRBUF_INIT;
+
+		strbuf_addstr(&path, alternate->abspath);
+		strbuf_tolower(&path);
+		strset_add(&files->dir_paths, path.buf);
+
+		strbuf_release(&path);
+	} else {
+		strset_add(&files->dir_paths, alternate->abspath);
+	}
 
 	/* recursively add alternates */
 	read_alternates(alternate->abspath, &alternates);
@@ -1272,11 +1245,9 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	CALLOC_ARRAY(files, 1);
 	odb_source_init(&files->base, odb, ODB_SOURCE_FILES, object_dir);
 
-	hashmap_init(&files->dirs_by_path, odb_files_dir_by_path_cmp, files, 0);
-	files->dirs_paths_icase = -1;
-
 	files->dirs = odb_files_dir_new(odb, object_dir, true);
 	files->dirs_tail = &files->dirs->next;
+	strset_init(&files->dir_paths);
 
 	files->base.free = odb_source_files_free;
 	files->base.close = odb_source_files_close;
diff --git a/odb/source-files.h b/odb/source-files.h
index 837e890304..8695b6ee91 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -2,6 +2,7 @@
 #define ODB_SOURCE_FILES_H
 
 #include "odb/source.h"
+#include "strmap.h"
 
 struct odb_source_loose;
 struct odb_source_packed;
@@ -18,12 +19,6 @@ struct odb_files_dir {
 	/* List of alternate object directories. */
 	struct odb_files_dir *next;
 
-	/*
-	 * Entry in the files source's map of directories, keyed by this
-	 * directory's path.
-	 */
-	struct hashmap_entry by_path_entry;
-
 	/* The two sources derived from this object directory. */
 	struct odb_source_loose *loose;
 	struct odb_source_packed *packed;
@@ -55,17 +50,17 @@ struct odb_source_files {
 	struct odb_files_dir **dirs_tail;
 
 	/*
-	 * Map of object directories, keyed by their respective paths. This
-	 * map is used to detect the case where the same directory is
-	 * registered multiple times.
+	 * Set of directory paths that have already been linked into this
+	 * source. This map is used to detect the case where the same directory
+	 * is registered multiple times.
 	 */
-	struct hashmap dirs_by_path;
+	struct strset dir_paths;
 
 	/*
 	 * Whether directory paths shall be compared case-insensitively, as
 	 * determined by "core.ignoreCase".
 	 */
-	int dirs_paths_icase;
+	int dir_paths_icase;
 };
 
 /* Allocate and initialize a new object source. */

-- 
2.56.0.307.g5fe7bd680c.dirty

