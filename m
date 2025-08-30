Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E511213774D
	for <git@vger.kernel.org>; Sat, 30 Aug 2025 21:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756589016; cv=none; b=mSvj5ZkEsF/Qv7qI8t/IZgpKPVw+Re2+thAotTjx7zIVl2AIGprfyvFIpMXLk+I9dzFKhuqUViZTQ0rR6nBEryQG9w23Ya/2+R3UoCBWbwBsGjzA+DIIB39P3jy7xYfA04ol/AAKpjye1HQdoeUGh7DC48t3jZN67fqxjLMuA90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756589016; c=relaxed/simple;
	bh=5WS07mlmA2lu/Cn9FAmKCbL8pCgvIUAHkJV5ztAjmbo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pvqTajDjsAXCgFsdPJ7diPNa9qCGTmRcl2UQLV9Ckcl8M2JDcJjRbwUcFArxKZphoffq5fIX+ierB6psE+PYorG4gW7Jb5GnjHLngNqT6KoXBh82zUR+ldVN+FAUhgwdzCtfFw1tM7yXGk02+1SEdAzXCszCRc2NlFweqS0IfXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPkVkm/l; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPkVkm/l"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e8704da966so201356585a.1
        for <git@vger.kernel.org>; Sat, 30 Aug 2025 14:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756589013; x=1757193813; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nU19w9CNexskRVaDNoPPO+mu8E3ygj/jMD9oEf9q+Gc=;
        b=FPkVkm/lyfSOdtNYxejK0SPiGP0WL4IlkyQYAjpawAkmFQ3dM7CNiIZ6QbhQGHDLom
         G0PbNUpK32ptLZ26IzDy/D0CnnRK/CZDQq9YgGBv5C6HUkjmMXGK0+Q6DC/olsgiXu9w
         NFqHpK5UMNtJaw6fx+davFjepZh0DiLWyflVNv02H+T9raoYgU8OmdMtcjDqhHjQpNpT
         lu1DhgbaHUTPhg17TtDu6zYnFuSJWAsO7hybc71AOc0/EweW65G9oWcjZGZb1qliSATJ
         n95sBkO90plm8Gveen5pkldHlWQsQp6VTQ/1p5exF/eCAEm8Tykmwr5rfSC34ryRy0bT
         pLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756589013; x=1757193813;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nU19w9CNexskRVaDNoPPO+mu8E3ygj/jMD9oEf9q+Gc=;
        b=OZdFq8FS7Im43AHL1541KN3tkfD3B5Fj0pCzU8/18cOtv1cz/igbwtbW3YKu3ield9
         OreomxqjJl7h+xM8NVlZLmu4pyQddP9GgSE/IaBc/DlicGOPkwAqmZwMkS8EdjgmjP3B
         er3W6UAi79PpnSIuI57dHzNEgBtlynrAdS7i+KMURsNy0ar9Z2tmk9B/Cq+Af8wUl6DB
         Ybn8lWRwX6a4jCsWH+ALngrvhnHqDe39KfA/IipZ8tMEWmsxNLmjVxSQFidb0Cr4zy+8
         2upWRFHzsxnx4BUDWneirppqrzpkGtjVMOI6ViYvdfn1QPzaAspfNTSO343DpB3q90yb
         TfzQ==
X-Gm-Message-State: AOJu0Ywlsuyg3x8V/PKAk6qbtkad685R7DQDy+nV7GLtLdTJBanUnr03
	FqJwI6Lc5nBHe3RbPAO9DrX5LAk9NL9UXZnV68DEzVhy7b9IYE4rq+1NDH0RvGq/
X-Gm-Gg: ASbGnctS/rYHEI2Lyouk99nb8JBczXahkgz9oL+Xr/zrAx4SjJvh5ao/qP1vo6JsE4V
	KXCsDc1nqp638MVTsEYZoukgSIhOXsn+5tfA5eqiSl/0Alm8nwfBfxDmzCDlBoFaqiqx+Uu5BrM
	02hKrCGrbrHKXxFv/Vg3u3BluhiqVy/atiF+TCCNzLfZiTYwFDDlOu7Deck5O1A9jJgYHoD/ahv
	1549m2/kqrxCfzDdelIVkeKT6p0YgzmveBzgFqFWkJLwGdReV/V/jinMA7mE+7m412RTY2lb0WR
	R2DhDE9MjAkd8GeIM9ah0n2qRVKchDEZO3/rJb2qcCnkB3nEwV9Y17X5oClhx6CQXg7psDLjkEW
	ZFCqWhpaMHPaGUHo7HYA8m4k/qOPDhL40bnmX
X-Google-Smtp-Source: AGHT+IHwJnOTFMX2dpkkQVxpp0NzrNQ76Yr8TbpjyRcN2YQ2/mQ4Ho9nRj/4zJzqnXVElA5lt8NLGg==
X-Received: by 2002:a05:620a:ab05:b0:7ff:f2ea:d37f with SMTP id af79cd13be357-7fff2eadbaamr290127885a.58.1756589013434;
        Sat, 30 Aug 2025 14:23:33 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.103.19])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b6e8f42sm35991991cf.48.2025.08.30.14.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 14:23:32 -0700 (PDT)
Message-Id: <c4f75cca094dd47c431de52e335ccaaf8b06355b.1756589007.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
	<pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 30 Aug 2025 21:23:24 +0000
Subject: [PATCH v2 3/6] midx-write: use cleanup when incremental midx fails
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
Cc: gitster@pobox.com,
    me@ttaylorr.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The incremental mode of writing a multi-pack-index has a few extra
conditions that could lead to failure, but these are currently
short-ciruiting with 'return -1' instead of setting the method's
'result' variable and going to the cleanup tag.

Replace these returns with gotos to avoid memory issues when exiting
early due to error conditions.

Unfortunately, these error conditions are difficult to reproduce with
test cases, which is perhaps one reason why the memory loss was not
caught by existing test cases in memory tracking modes.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 midx-write.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 0f1d5653ab..cb0211289d 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1327,13 +1327,15 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		incr = mks_tempfile_m(midx_name.buf, 0444);
 		if (!incr) {
 			error(_("unable to create temporary MIDX layer"));
-			return -1;
+			result = -1;
+			goto cleanup;
 		}
 
 		if (adjust_shared_perm(r, get_tempfile_path(incr))) {
 			error(_("unable to adjust shared permissions for '%s'"),
 			      get_tempfile_path(incr));
-			return -1;
+			result = -1;
+			goto cleanup;
 		}
 
 		f = hashfd(r->hash_algo, get_tempfile_fd(incr),
@@ -1433,18 +1435,22 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 
 		if (!chainf) {
 			error_errno(_("unable to open multi-pack-index chain file"));
-			return -1;
+			result = -1;
+			goto cleanup;
 		}
 
-		if (link_midx_to_chain(ctx.base_midx) < 0)
-			return -1;
+		if (link_midx_to_chain(ctx.base_midx) < 0) {
+			result = -1;
+			goto cleanup;
+		}
 
 		get_split_midx_filename_ext(r->hash_algo, &final_midx_name,
 					    object_dir, midx_hash, MIDX_EXT_MIDX);
 
 		if (rename_tempfile(&incr, final_midx_name.buf) < 0) {
 			error_errno(_("unable to rename new multi-pack-index layer"));
-			return -1;
+			result = -1;
+			goto cleanup;
 		}
 
 		strbuf_release(&final_midx_name);
-- 
gitgitgadget

