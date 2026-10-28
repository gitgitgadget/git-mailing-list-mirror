Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171517;
	b=DC9LKnVF2SZA5bh84dd9CrEHBES8Uw4Kv+66rv22iIc55JH+QJHfIPPeL0gpyXSyet3T
	 94Whb2XJ5meuyNwUA/xEs5CTukh00mKoIXTjvaO5YeMzv4IQsQcN2oq75XoiwTK3qwxq3
	 BQGlEGi127DuyouWozt9lFzpiiGXVkp29ozDUEnw2RE9TUVQzSYzjAct77DF791uXQyz9
	 Cj4jPvnSb9WmNIeUP8IAUYr4fYSHopMP/TISdWTIMQYkGfR8qgEBq9/xdIDy/fCOsP5ZS
	 ALKr7PTak2rki8wNQ26Z047yvKpJ2sT6dWc/CovsYv4pNR/XWpNdYwE23e01P1XZ8Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171517;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=h1pUUgMXaFrl5su7TyefUGZVea1GgtHy4S9EByNhP84=;
	b=vaYakzWwKpMv3g2KgMS/9vzz6NNzoWzVyUSBkGZhsfOBhocccdfxBf6lauX671YBMm0W
	 mVK1wboyi4SyqYp/ABSJok69VBudX4tRoHm/VHQ7Xnvf5hUcRxtPF+PXnxzMpNbYzu0Yq
	 gR/4xpA0ZFzy9rsifBIv5B07fU1JdgS1AvijNPDq8n6bmrdW0d4sM4e5wdc4oV2EkNBTx
	 4O/jx807COR55uFRjSRx0sX6glC1WTVeLLl8uEyrtJHJUfARyVDGbqXjU1vY9Vfiby57e
	 sEnIMK3mCzg9jLLN1EkAntm3Diz3hQR26VjPNeD4d29+aQMc0hXr8lWVSVDtWW9OEtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=eyoRorlt;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=DtYDacxV;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14FF606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E14FF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=eyoRorlt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=DtYDacxV
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 3AE7C1D00141
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 03:11:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 28 Oct 2026 03:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793171515;
	 x=1793257915; bh=h1pUUgMXaFrl5su7TyefUGZVea1GgtHy4S9EByNhP84=; b=
	eyoRorltVlTgpKXl7Enduw/UqZH4WPBna/CVa6UXVacn4ghPi7CjlH4T3URHXzWB
	hu6mvvfg0YUvYHG5sinRCB5st1jMSQx9S2y0IIa+oA5N00uYUku9ytnm1jUiKATY
	krXsl5rU6MpRYcYOnFEQBE+x4N8ijKq0L4iTKF2ZZxMeTFFYMJKqEJeeIMjjZCN0
	0blyJNIJvWFfod2LCH+hesiUK9Jnzx+HGYwznzCATlojzf+mei6eWeEq91AaRCJl
	W4On9wzaBjswf0Bq1gd83wMy7q87rPcwugXBfNTA/aerCv2K5ZRYPg/g5BdJeCst
	aOlF9BjoN6R/SJsE6O+TLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793171515; x=
	1793257915; bh=h1pUUgMXaFrl5su7TyefUGZVea1GgtHy4S9EByNhP84=; b=D
	tYDacxVGUYgCaqOzxzRguxWNHTiifVbvAlV1pMm24t//4PVSXlcKdV1ak/4PGklb
	FtoGGokz0dB7gfsBSV0MNtERXn0rL7YoWRPVbriGY7dJYpweRre59wjijvs/Ka0h
	q7oELiR7uT7PiU6jOWjBh51feyoIjDUDPPHv2JzfR85aIroX0unulIXzEtYXvjCf
	iExZd/TrZcjv7eAM3jmO11fRsKvEFVqDcb2+TnWRQYepHmnpRe5wA6q+n9TWsiS9
	xpjAq8psRFz9mU5goTeC5Oy6/2be8ciAF+q1LJtue5aq7eD4HYB3zLX+d02NPrQ9
	ls36BZcASJAKZO/keHHFA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793171515; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lADNDfm9SNLhVMMqhRSx1LXm6w64tD7aolexVwA2r60zOvk
	GNB9nHOP/slg0tbQ/5PUejRLwdXjUwz/PuW2PTtAZbeOc1+tgVD0tQ5NuuwF1Wn6
	ax0HwVzvhkqPR2s3sS7mYGUgyZm74k3IPLJqAOE/iz0OFdRxObrt5lS73iUOkx3k
	8RZ6nWr71WyIDu/II3MRo3Ugr1+6M+6rv5JZV9p5IzvFrhjw/jMkx/ln8TN1WK+k
	sfvwJ55v5rbTBMDpjghzSnAPYHFCaB4IhkhShVZpUTu8HpWkK8DvdtuUX/qVVpNn
	1FaCSm0Nj9ATyw7FhBL5exGzxo6DyFsrAlGBmqw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:mXme9z8Lgl30pC38lJmXdwgsJUbrLbRiQEr9R9nWnUs=:LLZ/o1u8AwE0/1eQ+Ptb31keX4wTB8GkAMZLYoLZxOE=;
X-ME-Sender: <xms:O6DhajFaUDGQVY3PTpJDXkYLN_-Z2scduJRa8rrTPGE41Rwz35DqWw>
    <xme:O6DhamUM_qun3uBKX-pMpb7xXxT5_gUqQNbuGmooXy7NRxr55_7so3dQTUrJj4p1e
    4Uxq9LwWlbqyVP6RvQJ2l2DO6EFjnMjKB1Yz1NUHxXINOXORynTVHk>
X-ME-Received: <xmr:O6Dhaiz7srHF9Ur8ELo24dsyClrn02ZM4IOeDJCfpMDICzpUiXAwFg>
X-ME-Proxy-Cause: dmFkZTGJn+tvXSM5aixDCnxnv/vI4/275NkNr7QOqtNTCubi1icyieGUXKU30EzEQkf4+x
    jvuU5cQOfRCZzeAHDK5hom+UCjNcn0pjfhPVFAFA801APwilip7V9cwpdipFXLx6TakXi8
    xG1amDJlufVNHzsb/pdbvNazGZ8eHv5r9NPQX0u+VGY56+1ubxIccXPLF7XpcyjUW9EJvS
    D8j14g1qFGoPxFV7R3NqxHlcWKMdnagJ3A1GZzCWGDvyzWOIX2DHxTVUx1IRRTPK5GK+hZ
    GCePLF8Wj6/TMAxxFVGGPei2wfadTrDBVW3tvz1V/0Na5rvfF5IBdS1abx52l92RzM37Iq
    r63UZ4e6mmtl9W5N9hHtb9DZm2v+pRz7YMP/CKwP12CypIpo49ApBXTtLLW5uEwLrr72y0
    f63drGvxoox4oKXMObUtiJk+wEVZl/SEmWJ2IKe83wiHl3mONPIDn3TIBTAQMcqTvZVPkS
    XvxKiv8xPoQFgTrU5bBOHqZB6LQwnCx7BqG5zhhIQDr3NWmZCJZ7IukpsEvNAFCeWUbzoR
    /5zX5PPtaR1g+y2qpZMTgfd3fJOfSmtZeVQmiUdMRRMOGFLaLXI/SgvJ07Mj0jP6u8fimH
    swDaWYX15bsYUHpHcsoet2H9rSjWaMbp731Ob9BNLjyM4oHBYcRUOoUFKcPw
X-ME-Proxy: <xmx:O6DhasPCSFNDKBGLWHxzcf6GxrBA54N18WtZLIy03dlIc3tmctq7bA>
    <xmx:O6Dhar6cgGTkwwmJdMJVLcOjuyFsDRVuwZmZSsmykD61iQCAAa8O4A>
    <xmx:O6DhalNcVTgO4K5ubzemLZhV5lannGwpV9KHXei2y9HWYRoEDYxaqw>
    <xmx:O6DhahmUY59aCB6NUu8wIckxxoQC9tIcgWahE1Qy9rYkEFEVaPTb1A>
    <xmx:O6DhaokX6uDvMMmwkHOsivi-eBjMjslgBopkNd_p-6VbWOjON0xAm5uv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 03:11:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9e2b366b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Oct 2026 07:11:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 28 Oct 2026 08:11:42 +0100
Subject: [PATCH v3 4/6] odb/source-files: simplify directory duplication
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
Message-Id: <20261028-pks-odb-files-reload-alternates-v3-4-011ddb64b626@pks.im>
References: <20261028-pks-odb-files-reload-alternates-v3-0-011ddb64b626@pks.im>
In-Reply-To: <20261028-pks-odb-files-reload-alternates-v3-0-011ddb64b626@pks.im>
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

Rename `dirs_paths_icase` to `dir_paths_iscase` to match the naming of
the newly added set.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 120 ++++++++++++++++++++++++-----------------------------
 odb/source-files.h |  17 +++-----
 2 files changed, 60 insertions(+), 77 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index d66949b7de5..8b63d0eff2b 100644
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
@@ -239,28 +194,57 @@ static bool odb_files_dir_is_usable(struct odb_source_files *files,
 	}
 
 	/*
-	 * Prevent the common mistake of listing the same
-	 * thing twice, or object directory itself.
+	 * Prevent the common mistake of listing the same thing twice,
+	 * or object directory itself.
+	 *
+	 * NEEDSWORK: we're using "core.ignoreCase" to deduplicate
+	 * alternates that _may_ be the same. This requires quite a bit
+	 * of boilerplate for dubious benefit:
+	 *
+	 *   - Duplicating alternates should really only lead to
+	 *     regressed performance.
+	 *
+	 *   - We don't properly resolve symlinks or mointpoints, so we
+	 *     may still end up duplicating alternates.
+	 *
+	 *   - The value may be lying, in which case we might
+	 *     deduplicate alternates that are in fact not mapping to the
+	 *     same directory.
+	 *
+	 * We should investigate whether we can remove this whole
+	 * mechanism outright.
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
 
@@ -365,11 +349,17 @@ static void add_alternate_recursively(struct odb_source_files *files,
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
@@ -1272,11 +1262,9 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
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
index 837e8903044..595a4e78eef 100644
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
+	 * source. This set is used to detect the case where the same directory
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
2.56.0.341.g393f52fd96.dirty

