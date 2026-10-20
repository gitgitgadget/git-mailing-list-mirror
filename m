Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502951;
	b=UschHpx4gbp5PgGMr87lcvFFFb3WUg+Szw2jH5ESss15aV/y9gTwhgwH5XRfmUHrq+YP
	 NLSsS97pJ76F2hiQNNHKQ5qWrMc9dSA/L72z5DOgjggT0j+hOSJxxtbnjsqomhBloHh7R
	 +O3e6v3Svop2Rg/FtWz8Rc1QKPacIU19hfTWXx38MNnplnorCoOBpc4lnpTOl6szSlPNX
	 CRxymlSiwh1akYpVVfdSHq9QiykdUflm4wtU04RwTgO/zMA9VWKyzK7rcPQZttSwVQ3Ra
	 3tZ+gGXAFJLUsUohC6z17gzbesf0A/Kqvsfu/ZOm+O/CVq/apvxTPXN9j5WoaxZQynQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9XABZq0Ng24cqCwSe44YEuAdjKVvWaINI5H7fTB73JQ=;
	b=qbRJu+TpJOUvp6II1UtHgv7YWbv/RuOgaJ/i+NnQt8MBQgThGsWBZ6Gfdt/D2g4yClAz
	 j3npgEpYUel6dk9ojKDkK2t+j8M5RF2cdDB4Mhkh+5p33QWdtZY98T2lBpEut5Yqew1vI
	 qBawWJCdOyWNtRfQWmwtZcYKYFaD9OIMSEkgDo35xfGnpmEipc+XM/jbc1A7W++Jk2qps
	 rYUhNeYXwemGTOAxeVDxIzVpl81RZVKQ1hKeZYzXP1BGMQvMoWjgh681L++rXE2GJZIxl
	 Xj3R5okMVeqbC9e+fymPkIKpOinoGdZ1RNvBcvxxNw9/EGAlO0+IRp1/85mLDfH978g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XeR8XCWV;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669B0606A324
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 13:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 669B0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XeR8XCWV
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6ddef424972so1990466eaf.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 06:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792502950; x=1793107750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9XABZq0Ng24cqCwSe44YEuAdjKVvWaINI5H7fTB73JQ=;
        b=XeR8XCWVqRF8AZuKtGJePCJtsJYEzvqCqIjdbw6QDSBCPGYuAKJJwhVAXgy/8scdmp
         VdGAR1clvxeIfnlyVXUorcTG8Ghpz2ODo4y3EqdxZUNNxhMzepyJaUt+LteIyMXpEECl
         /aBNT1KZAJBV+EMi9LkuC5OCt/fxP933OrfvnNX/BBtCpgdT9EBtERKGPr1ri9Ib8RRB
         B9OF2VWp1tz44jifRN4JxuDVek9iWex66SsO5e1/C1xLGPXR0JhepoymR+NiNmKVysyy
         7lXrYX2nYreZfNpYq5uLfAohIXi6pXZD9b21OdWoxeexRQmNW6Ef+WbeVhNb+l7qZ8XJ
         CxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502950; x=1793107750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9XABZq0Ng24cqCwSe44YEuAdjKVvWaINI5H7fTB73JQ=;
        b=0xCmiOgqcwbX+bh76XAqTbVqyXoLH7OP/RpQbQECjQpMfv0ev3ccpyAEPlooDGhed3
         kzirZA68ORtEB38bKGty0oC+a0tVif6gxMujq4gIdTfMLZcINy5djkZdSw+3aR+nSVMT
         oN3CP8EHxmmozhMdJ4dISPrmnonMGbicCXcGTRsSAWlakf570fk33e4FaKreESmDUtoh
         UDa2oBQk7g2++9aXPx/BjJRgZffuWgtkx9PbjNebToen9m1tXmSjTxWJrHkTc5kN32r1
         nT9ceYnol+TnvXDAVUXV0gnum6AKCP8oLxST2lwcIwj1axc4gkYH+4ozUoOInLcCE6CO
         fv+A==
X-Gm-Message-State: AFq9FYLI07LXhv5B9iTFMl5SkPsB1PuLK/Wd2BdU55EFPXOEbzEokfmI
	h260G2O42h4E/r32mvxi26T9fFgjNoLJu9JtbolIfnKiJuK94O7bEKwCrPcfiA==
X-Gm-Gg: AYBFou1Sip54nQ41xau2Ps5DrcTi+BXSRHgCP46lAHeSJZ1vRt4CkyFowVWnJ9J5hMR
	YcdkICYmsNGhAre+9oSA1HsqPCk4buOZV9Ya7Wvmx3fDIMKxq5otXyPQhd1Kk+fMdzlSLSU1ujF
	mcEuIu2Ni9VMp+zqSlbiZKWAhjH+LxcV73YrVwnycJUMjkWCajWPBwi2c2n1ektz59+kljQCESL
	KVt7dr8OAEsyzCrqu6h9PpmjTpZ1OD5mRvaTPAINKM1mU18lTCob8nwOOO7aARlEW5HX72Al1AB
	sfGNwn7xDYcjwnphPRfuYBsyGDcVFlLwjaLlubE7RTxEnFuH8GhtL1zMxuPDI/AZjY+u6gjTTlD
	fkK7qmKjdj+gupFGO4yxe819SMxCwjgFnd1rGffmDYWnuEOXpEjOUREmH6HEem/M+6PovE4PFP6
	TgN0OZzsjtkA7Llltr3JH17dxJDKAIdfybTT4K/urrohR/8ayvHzyJ1srb9aM276r+jidb6C2Zg
	fJ/XtntHSkbgogqa9Vx6bHeUgVs9mI8yt/CQg==
X-Received: by 2002:a05:6820:1354:b0:708:b419:488c with SMTP id 006d021491bc7-708b4195334mr284009eaf.84.1792502950239;
        Tue, 20 Oct 2026 06:29:10 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7018f2e0d89sm9973129eaf.6.2026.10.20.06.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:29:09 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 2/4] pack-write: lift and expose index-pack report parsing
Date: Tue, 20 Oct 2026 08:28:58 -0500
Message-ID: <20261020132900.1208343-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261020132900.1208343-1-jltobler@gmail.com>
References: <20261016213716.593278-1-jltobler@gmail.com>
 <20261020132900.1208343-1-jltobler@gmail.com>
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

Once git-index-pack(1) finishes writing a packfile, it reports the
hexadecimal name of that packfile on stdout prefixed with either "pack"
or "keep" depending on whether a ".keep" file was also created alongside
it. Callers that are required to manage the lifecycle of ".keep" files
parse this report via `index_pack_lockfile()`, which provides the path
to the temporary ".keep" file.

In a subsequent commit, the "files" ODB transaction begins creating the
pack lockfiles during transaction commit instead of eagerly staging them
in the transaction quarantine directory with the packfile. Extract the
generic parsing logic for the git-index-pack(1) output into
`read_index_pack_report()` in preparation for recording the names of
newly written packfiles.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 pack-write.c | 56 ++++++++++++++++++++++++++++++++++++++--------------
 pack.h       | 10 ++++++++++
 2 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index b1311c9923..2ed33448ba 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -469,11 +469,16 @@ void fixup_pack_header_footer(const struct git_hash_algo *hash_algo,
 	fsync_component_or_die(FSYNC_COMPONENT_PACK, pack_fd, pack_name);
 }
 
-char *index_pack_lockfile(struct odb_source *source, int ip_out,
-			  int *is_well_formed)
+int read_index_pack_report(struct repository *repo, int ip_out,
+			   struct strbuf *pack_name, int *is_keep)
 {
+	const int len = repo->hash_algo->hexsz + 6;
 	char packname[GIT_MAX_HEXSZ + 6];
-	const int len = source->odb->repo->hash_algo->hexsz + 6;
+	int is_keep_ignored;
+	const char *name;
+
+	if (!is_keep)
+		is_keep = &is_keep_ignored;
 
 	/*
 	 * The first thing we expect from index-pack's output is
@@ -482,24 +487,45 @@ char *index_pack_lockfile(struct odb_source *source, int ip_out,
 	 * bytes of prefix, `hexsz` bytes of name, and a trailing newline. A
 	 * "keep" prefix tells us that index-pack has also created the
 	 * corresponding ".keep" file.
-	 *
-	 * In the "keep" case, we need it to remove the corresponding ".keep"
-	 * file later on. If we don't get that then tough luck with it.
 	 */
-	if (read_in_full(ip_out, packname, len) == len && packname[len-1] == '\n') {
-		const char *name;
+	if (read_in_full(ip_out, packname, len) != len || packname[len - 1] != '\n')
+		return -1;
+
+	packname[len - 1] = 0;
+	if (skip_prefix(packname, "pack\t", &name))
+		*is_keep = 0;
+	else if (skip_prefix(packname, "keep\t", &name))
+		*is_keep = 1;
+	else
+		return -1;
+
+	strbuf_addstr(pack_name, name);
+
+	return 0;
+}
 
+char *index_pack_lockfile(struct odb_source *source, int ip_out,
+			  int *is_well_formed)
+{
+	struct strbuf pack_name = STRBUF_INIT;
+	char *lockfile = NULL;
+	int is_keep = 0;
+
+	if (read_index_pack_report(source->odb->repo, ip_out, &pack_name, &is_keep)) {
 		if (is_well_formed)
-			*is_well_formed = 1;
-		packname[len-1] = 0;
-		if (skip_prefix(packname, "keep\t", &name))
-			return xstrfmt("%s/pack/pack-%s.keep",
-				       source->path, name);
+			*is_well_formed = 0;
 		return NULL;
 	}
+
 	if (is_well_formed)
-		*is_well_formed = 0;
-	return NULL;
+		*is_well_formed = 1;
+
+	/* If there is no ".keep" file, then there is no lockfile to return. */
+	if (is_keep)
+		lockfile = xstrfmt("%s/pack/pack-%s.keep", source->path, pack_name.buf);
+
+	strbuf_release(&pack_name);
+	return lockfile;
 }
 
 /*
diff --git a/pack.h b/pack.h
index ada506b5c5..2f2ce97c11 100644
--- a/pack.h
+++ b/pack.h
@@ -106,6 +106,16 @@ off_t write_pack_header(struct hashfile *f, uint32_t);
 void fixup_pack_header_footer(const struct git_hash_algo *, int,
 			      unsigned char *, const char *, uint32_t,
 			      unsigned char *, off_t);
+
+/*
+ * Read the report that git-index-pack(1) writes to its standard output after
+ * the packfile is written. The hexadecimal name of the packfile is appended to
+ * `pack_name` and, if `is_keep` is non-NULL, it is set to indicate whether a
+ * ".keep" file was written. Return 0 on success and a negative error code on
+ * failure.
+ */
+int read_index_pack_report(struct repository *repo, int ip_out,
+			   struct strbuf *pack_name, int *is_keep);
 char *index_pack_lockfile(struct odb_source *source, int fd,
 			  int *is_well_formed);
 
-- 
2.56.0.173.gf57c9a7388

