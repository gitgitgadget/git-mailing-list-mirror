Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794181392;
	b=Q+lVoPoCIJ2Fh71Rflw0961AYiRYmSk0P0r5wMyAlBbE8IBUJT3ySvVbOuopAKLYUfLq
	 4+HVVkMWab1gZ8TjIZAhbW879JUsfKc/onorhwXDMvHz8hhSRpSumiesGxbixol72lCTT
	 /J1STp0DwUATyMfaJNchxni7oTjJJhRvScUBHRHfSJh6hr4R901RsGiq5OcoJgVxQnEvJ
	 KJKhvXoErEBHvjTaahuY5qnzmvbmZLSBybAZmzZDiZIki3apaBhlT97MSvtb4rhr1djCU
	 5k8K9A2M3RNHk9Rwau60py6AISD8AKNGf05cwUKWReOdDXPMYiwt0MmAwxky07x2oFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794181392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WVKkrgzV7bS6MFNnWicO/bUSGkT51sbBZfaQOqXrB/w=;
	b=MJTp9gvt4Yxunvy/KlVp0qQskB0g73QmtQOTLo7Cke2q4vt8l6WS5EMJY+Ok56kWrKvR
	 ZDtZmSJ3SJzZSac84/allXNVZaY2YUzsbTfFhh8qDIVxwSgXgYsA6tII1MOiygQ3IEXed
	 QzHH5SRofHBVTyo1PYhBD1rRVAjisyuEsVotW8BD/qY7l2f+LZ8gzHg420G2MJ1Lwl1YD
	 /CxOS3sUr4xABH3ZpF21AP6BpQs3K0Ev2HddpdJ3Ta8JLSXhl5BnEiro16H7z/WQTgPOc
	 19jr+IbEIu0zqnFxcMrlJd3C+XOL8eJeHg4TEmNZCWdoe2C69zL+G3mKnJpDr1IQqNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UMCYHslo;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7335A606A31C
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 23:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7335A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UMCYHslo
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-49412eb1474so175413f8f.3
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 15:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794181391; x=1794786191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WVKkrgzV7bS6MFNnWicO/bUSGkT51sbBZfaQOqXrB/w=;
        b=UMCYHsloL5FfgvA0JTixnLp2K/g/MhkvmNVUV2OBG2pVtbFJTlnFvP7xIvuuSpsV6d
         c5INk2Gyj1U6t7wAtdeyoQmgxqH/E7B2CCorKEX+ZsiHewO1sGK+JAU0vMjGPbOXXC8h
         JMa+9fiRhXTct/5TFlVXvmmtojRmpClAQbOU32LMnKlNln3gqPNkPqirJLKeA/MB0aHi
         YXsjR3DFPR/0ci6fH4U5U4C7rTvopnIJ1w+bSQZPWEn3I3SlFmEdXvKww34/HRB1RQet
         1kzO89wmjBjzsDpEdUXLyzTjyY9Xn7Jlu4GsIdjg1oHFh8LShb7DWNS/EkZJHvP0T1O9
         L6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794181391; x=1794786191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WVKkrgzV7bS6MFNnWicO/bUSGkT51sbBZfaQOqXrB/w=;
        b=D4ugDDcxoV6eT3GJ4bBwOdQvI9eQ8aWYXfv0lBNKXqMoYwSRgoxY2nmpNdw5kLpu2P
         a6BsCqfyDy9eXJUj6JIP+kRZilYa6sjOBmaOi6ZxF/M0Zbuayy24+PZ3+ncmnVaV94d8
         fPCdPMBozzd1YJCf5dVEF0VCsthYmszt+m5zQWsTH0Npy4qD/rH/PtNBDfU+zHbzXvKN
         mEudX8PtnhmZ6lhKYIYttAQeW66qTvtV2jJgmsyyu/l//Y+HKvcFxsD/vsSMuV6IlcDM
         7OjI1NGmESVm3odxG2Oj0+abyMNiTtEUklM/XaNDNrza4NyVJu09dPgp1C++RRi62TW0
         aMLg==
X-Gm-Message-State: APuU4Z+alJGwqqW7ZtiapCuVdR/FTThLfebcT7lRTBrm+R/n36+iwLMS
	5v7sYMQNuDS9b2/EEMafeTCHP1SzulQrsKIRE/5ZLLAf0ETW/KqD/ddYZ73W0IYNbxc=
X-Gm-Gg: AYBFou1En3686Y9OIACr3cwmbZf0eYYWVXxcHcvGZqNpOBYo/1PtejZ8v2X2+C9bXab
	ayVsRhihi22ht9E9rt73OKBV6fGEkoEcC7CnmrFS5GPbum6WunoSS4Ysuq0K4FvC03V1zXjf8m5
	fojfZUs8G2uEb+tdnc/XTWrABEphFCh8LdrRpvg1WtI0UkwfU96oTxewo2P+aH849HPyYlL7s+/
	6jZVOhwCR8BW7u4AsOYbZYqJzwBYPvWlOCplNxQBSAPsYeQq2f29mt7cQ3Ud3xAmfACpnzMyXTF
	z423KZ43mDoFgt6wxRkDhBa1HNx6b38IAB2gQJ2aWrSHLVCY2q0mz6mz0z0sDkMmwI29sdoiLZr
	gBkKQ0hTWmODvRmqKCi8HF+onZq3iqq2b5ln9ECoMpo0JlIz1M/YmKdPPhDk73IKshzjmPnkuzU
	XPiBdalsPFHr9671kI8PeMxRTKbeis/dTth0wv71puw5qk2e+4SP1iYx7HbTMEpsCC8oExqNKIh
	GtozOV/hkEKHYRgQWJpYhgJN/5xjtP41dsP46B6BHqNxWX6r23eJwIgIp71dBOJBcywxeniizcY
	Vo8gVFO9MKCiYxOj0gMdf44EeIRGCSgDNvOEICI8jFtxAEkf1CxjJ7WNCFqFw7dEnrJIgWesbFg
	ws2XgAsgnkd1K2rABNNhWUQb3ZqC1QQQOIuWTRud0mA7REFl2kzorPD8=
X-Received: by 2002:a5d:5f09:0:b0:490:6327:96da with SMTP id ffacd0b85a97d-4957c404abdmr4630190f8f.0.1794181390789;
        Sun, 08 Nov 2026 15:43:10 -0800 (PST)
Received: from HP ([102.0.122.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959011c995sm6448619f8f.0.2026.11.08.15.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 15:43:09 -0800 (PST)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: andy.koppe@gmail.com,
	gitster@pobox.com,
	stolee@gmail.com,
	github@paulisageek.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy PATCH] read-cache: do not skip the hash of the shared index
Date: Mon,  9 Nov 2026 02:42:35 +0300
Message-ID: <20261108234235.1594316-1-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.388.g09a996e1ff
In-Reply-To: <20261107121119.2995843-1-andy.koppe@gmail.com>
References: <20261107121119.2995843-1-andy.koppe@gmail.com>
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

With core.splitIndex and index.skipHash both set, index entries are
lost when a new shared index is written:

  $ git init -q r && cd r
  $ git config core.splitIndex true
  $ git config index.skipHash true
  $ touch foo && git add foo
  $ git status --short
  ?? foo

write_shared_index() names the file after the shared index's trailing
checksum. With index.skipHash, that checksum is written as zeros. The
split index then records a null base, and read_index_from() treats a
null base as "no shared index". So the entries stored in the shared
index are lost, and "git status" can die with a BUG().

This has been broken since ee1f0c242e (read-cache: add index.skipHash
config option, 2023-01-06).

Never skip the hash when writing the shared index. $GIT_DIR/index
still honors index.skipHash, because it is written on every index
update. A new shared index is written much less often, so only those
writes pay for the hash.

"git reset" repairs an index that is already broken.

Reported-by: Andy Koppe <andy.koppe@gmail.com>
Signed-off-by: Tanga Joris <tangajoris@gmail.com>
---
A new shared index is only written when more than
splitIndex.maxPercentChange (20% by default) of the entries are not in
it, or by "git update-index --split-index".

Entries that the split index stores as replacements show up with an
empty name, so "git ls-files" prints "./" for them.

 read-cache.c           | 16 +++++++++++-----
 t/t1700-split-index.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index e40f290bb3..c48ea7b1e0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2818,7 +2818,8 @@ enum write_extensions {
  * rely on it.
  */
 static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
-			  enum write_extensions write_extensions, unsigned flags)
+			  enum write_extensions write_extensions, unsigned flags,
+			  int skip_hash)
 {
 	uint64_t start = getnanotime();
 	struct hashfile *f;
@@ -2841,8 +2842,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 
 	f = hashfd(the_repository->hash_algo, tempfile->fd, tempfile->filename.buf);
 
-	prepare_repo_settings(r);
-	f->skip_hash = r->settings.index_skip_hash;
+	f->skip_hash = skip_hash;
 
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -3147,9 +3147,11 @@ static int do_write_locked_index(struct index_state *istate,
 		return ret;
 	}
 
+	prepare_repo_settings(istate->repo);
 	trace2_region_enter_printf("index", "do_write_index", istate->repo,
 				   "%s", get_lock_file_path(lock));
-	ret = do_write_index(istate, lock->tempfile, write_extensions, flags);
+	ret = do_write_index(istate, lock->tempfile, write_extensions, flags,
+			     istate->repo->settings.index_skip_hash);
 	trace2_region_leave_printf("index", "do_write_index", istate->repo,
 				   "%s", get_lock_file_path(lock));
 
@@ -3262,9 +3264,13 @@ static int write_shared_index(struct index_state *istate,
 	move_cache_to_base_index(istate);
 	convert_to_sparse(istate, 0);
 
+	/*
+	 * The shared index is named after its hash, and the split index
+	 * refers to it by that hash, so never skip it here.
+	 */
 	trace2_region_enter_printf("index", "shared/do_write_index",
 				   the_repository, "%s", get_tempfile_path(*temp));
-	ret = do_write_index(si->base, *temp, WRITE_NO_EXTENSION, flags);
+	ret = do_write_index(si->base, *temp, WRITE_NO_EXTENSION, flags, 0);
 	trace2_region_leave_printf("index", "shared/do_write_index",
 				   the_repository, "%s", get_tempfile_path(*temp));
 
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 887e72a5fa..2517ac9eff 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -544,4 +544,45 @@ test_expect_success 'GIT_TEST_SPLIT_INDEX works' '
 	)
 '
 
+test_expect_success 'index.skipHash does not apply to the shared index' '
+	git init skip-hash-rewrite &&
+	(
+		cd skip-hash-rewrite &&
+		git config core.splitIndex true &&
+		>foo &&
+		>bar &&
+		git add foo bar &&
+		git commit -m initial &&
+		git config index.skipHash true &&
+		git update-index --split-index &&
+		test_path_is_missing .git/sharedindex.$ZERO_OID &&
+		test_trailing_hash .git/index >hash &&
+		echo $ZERO_OID >expect &&
+		test_cmp expect hash &&
+		cat >expect <<-\EOF &&
+		bar
+		foo
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual &&
+		git status --short --untracked-files=no >actual &&
+		test_must_be_empty actual
+	)
+'
+
+test_expect_success 'index.skipHash does not lose the first entry in split mode' '
+	git init skip-hash-first-add &&
+	(
+		cd skip-hash-first-add &&
+		git config core.splitIndex true &&
+		git config index.skipHash true &&
+		>foo &&
+		git add foo &&
+		test_path_is_missing .git/sharedindex.$ZERO_OID &&
+		echo foo >expect &&
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.56.0.388.g09a996e1ff

