Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013214;
	b=C62+/BOHY2xtRcB/8Pajbxwwe43KLYveBsy3MqX90hweP6HjR4AAa70dZGFGgB0Ke+r9
	 iXA7b3zuHh24BDfvUAKlkaJoVynxxGw+mAZdVdKQzkvVZ6AGVxVUc5FrstCumm6657YsZ
	 nvVIbCrW4sC4x07g0vSVFBdJcLxz6PSbexI+AbmcJOow2mZGPLQaJTFg9lx3ejUJHEkvJ
	 P1+s0akXONFGi9dvwL1Esfv2HQp1fdsPu/WwQtmqnSPD+vV0EG71dxhQ4ezgmxy1FsuLr
	 Zjbev1a+0CeGDQn826r2Bc8XudZxZ/BFPoSSzTGwlL3D46R6jBzwEkGpZmzZTbBNNXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=pKlApkRP3CyfBtbXDXhxEse6qcFeWEHdw+7aUKIqaFw=;
	b=NV7MZrpMvi3DklKZOh2q5YZvvRCvBVMyfUAQ2fRKZWWLHaDGxvqdSEQdYj+4MJnOsiRl
	 TAVGhT3UDEikJpbOh1/7pY0fstHVQCU1ZOn9WwxRC3yFl0l3SLh99B3e3YzpPRE62a4U5
	 5JHUlqursUkamQCAbbStCzOxDQ1S+h+36VSz2IbpVHUCaKX7VUIMQ9/wLD3jSP3lD4YdQ
	 Dsh/TWZbachN3WeN96D8fhp4rY2mq8cNoqJ07SgtwSWhxevoRh/xLyFQdWeBgyoqFMSeY
	 qWodp2DBRRCGBpqEx0VhD1I28jc434YSWvRJ3Z0HZc+651LxPrm6naW7Jb7SMUkjXEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cEBTDUcH;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D440606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D440606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cEBTDUcH
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso1597658f8f.3
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 04:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013213; x=1793618013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pKlApkRP3CyfBtbXDXhxEse6qcFeWEHdw+7aUKIqaFw=;
        b=cEBTDUcHpw9TJo9qmRTGxxHwr7uvbG+Gk5fFzrfvcp9O6T3h34YgMIFir3ufo6c0+6
         EEWW2ASfM1/hCUfdQLEvreIXfXYUgJ1jLgrzcYqBvliEDo8rbktuoZ1EF66YA16ko1NZ
         kswcll6pVroqVgMnPrJ5jfmIbWzopUrT6U1eovBBxA7ROa3VVIMOjFXiGXt+xO0uHJaX
         0E9xti6kLHQcxOw+/kXhmjOsuL3LtQwan1a0NNZ5Y7g9zvs0bJEbZFbqfR+L3q+7GLDo
         JURWKDMb8QDWSk+5vXQihtMdGXEzZ8GU+hv7SV1nIyP1UJkioxpV4PdL2RcVe7wcoFzc
         rhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013213; x=1793618013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pKlApkRP3CyfBtbXDXhxEse6qcFeWEHdw+7aUKIqaFw=;
        b=hmuudJnXxFvC2v6MWcuQ1OniPAGi7R7X7M3LAXe7YZcqqH3YK/3UQ7cDSHe95QqmdQ
         tB+lgoctRIfbGWiRjrQHzGAMOb8j/h3+KjdglglyAlX9a+4HXsv62G+0uQ3Rdpvmlq4C
         fzp5QhlH/yY9BeZlTwy53oIJ7AHLB2mRgw0KPdrcQVqVlN3Z5AZPfLMpj6+dKbCy3rYi
         eJnPH/iDNnLJjmPGxu2DGjltuxMCnaXnMu8tGvr355rzAF2d5wt6ybAE/TRmAnfYmbbR
         0V+0u2n4onU2J1T+LQb4AAxXnPgPvTmWYlqdrktxxtsORwcvxJWRTfqoyHhCjXVWvwNi
         uwjA==
X-Gm-Message-State: AFq9FYI+nKRf9M1fTEZwhZfVFOIny8WZEbmCq3HVIBFxrfSBxAFF/qCY
	f8uu8cWBWXW3ETpy3r9eMwtJUDT8X8umBs9ZEku83oM8lk7OYtt/DgVzAchen7UdmkY=
X-Gm-Gg: AYBFou133SEwmFXeN0k3E/GXFHb9BBFjsz/lRU05Cvy7p1XfA4wAeY/9DPl1i3UCn6j
	m5WX+xsVdDkllZM75GEKAHCpIlM9lYh+IsL1XZY8pcNcjH5voG6I2utekNS6G7TMsXKfrIHKHPj
	XOqv2ZRmMccbEj5k/CgrZfK93+BZ96C/blO0nqPRjwiI44uSux++Q2Y5N1MNv18Yjoi6gugl68z
	TP1ySuKYeK0NIsRIsXb3JmgD7ihgseSNPzeS2KrOnIaH2xZjpCUGGyCehvJySXtQDYoK7TVlQhh
	r4X2ONLCOmUNa0SgkzMlmzvFd8pRLCoi25at36VwDgCQ28Zaya42ehfcA4ezwsOMpXiXKFznwv/
	p9kM0FTM+ceGjKPRi9cSB2K9Be5z/ltbcG5RmWrxGfAo2FwG0jFa/9gbU88MEUIsec0WLzAxbzq
	7DJm95psJWBdARw6EJoZli83VVcN8ELhewdzFthjIm+1MFmuPEdEd0HX8KuHOQZM9UGtVA9eGBs
	PCUkfw+PyRKCz8Flu3Vm6qkYMvdtETylweX14BSVFPjlxcGDOkTVYcNvZtr/i1p0xAKnb1wyJMg
	b79WVjNBR3iWYhFmp8GcjS2jWk0CCMJfs2Q9GwoREib693LmICcimX0H0ZukVi6+IY3mUtje90R
	txdAbXRy8r0fdWokERJhCsAo3kWQodpVNkkkvRiY8RxXtQvPgNm7J2e4+aFtvGgAw3C8Wqxf1do
	CT
X-Received: by 2002:adf:fd0f:0:b0:48d:ed96:e995 with SMTP id ffacd0b85a97d-48e3eb8c30amr9241845f8f.28.1793013212482;
        Mon, 26 Oct 2026 04:13:32 -0700 (PDT)
Received: from localhost.localdomain ([104.28.251.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc39a8sm16741032f8f.11.2026.10.26.04.13.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 04:13:32 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH] combine-diff: use the repository from diff options
Date: Mon, 26 Oct 2026 12:13:03 +0100
Message-ID: <20261026111303.92117-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
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

show_combined_header() and show_patch_diff() already have the
repository through opt->repo, but still used the_repository for
the hash algorithm, abbreviating object names and resolving
gitlinks. Use opt->repo instead.

The file still needs USE_THE_REPOSITORY_VARIABLE for
DEFAULT_ABBREV, which refers to the global default_abbrev.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 combine-diff.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 717d537688..9e7b05e6f8 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -927,7 +927,8 @@ static void show_combined_header(struct combine_diff_path *elem,
 				 int show_file_header)
 {
 	struct diff_options *opt = &rev->diffopt;
-	int abbrev = opt->flags.full_index ? the_hash_algo->hexsz : DEFAULT_ABBREV;
+	int abbrev = opt->flags.full_index ? opt->repo->hash_algo->hexsz
+					   : DEFAULT_ABBREV;
 	const char *a_prefix = opt->a_prefix ? opt->a_prefix : "a/";
 	const char *b_prefix = opt->b_prefix ? opt->b_prefix : "b/";
 	const char *c_meta = diff_get_color_opt(opt, DIFF_METAINFO);
@@ -945,11 +946,11 @@ static void show_combined_header(struct combine_diff_path *elem,
 			 "", elem->path, line_prefix, c_meta, c_reset);
 	printf("%s%sindex ", line_prefix, c_meta);
 	for (i = 0; i < num_parent; i++) {
-		abb = repo_find_unique_abbrev(the_repository,
+		abb = repo_find_unique_abbrev(opt->repo,
 					      &elem->parent[i].oid, abbrev);
 		printf("%s%s", i ? "," : "", abb);
 	}
-	abb = repo_find_unique_abbrev(the_repository, &elem->oid, abbrev);
+	abb = repo_find_unique_abbrev(opt->repo, &elem->oid, abbrev);
 	printf("..%s%s\n", abb, c_reset);
 
 	if (mode_differs) {
@@ -1058,7 +1059,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			elem->mode = canon_mode(st.st_mode);
 		} else if (S_ISDIR(st.st_mode)) {
 			struct object_id oid;
-			if (repo_resolve_gitlink_ref(the_repository, elem->path,
+			if (repo_resolve_gitlink_ref(opt->repo, elem->path,
 						     "HEAD", &oid) < 0)
 				result = grab_blob(opt->repo, &elem->oid,
 						   elem->mode, &result_size,
@@ -1068,7 +1069,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 						   &result_size, NULL, NULL);
 		} else if (textconv) {
 			struct diff_filespec *df = alloc_filespec(elem->path);
-			fill_filespec(df, null_oid(the_hash_algo), 0, st.st_mode);
+			fill_filespec(df, null_oid(opt->repo->hash_algo),
+				      0, st.st_mode);
 			result_size = fill_textconv(opt->repo, textconv, df, &result);
 			free_filespec(df);
 		} else if (0 <= (fd = open(elem->path, O_RDONLY))) {

base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
-- 
2.56.0

