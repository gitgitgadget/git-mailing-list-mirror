Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C198B373BE4
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774207140; cv=none; b=QyF1I/nK1kFjWciuBbhLFrNrEG4rk4tyYS428Nsfv4GuAbfdoijeIF8MgW/PXs8YiQ+wmAthHCapRG86cbmh6zUwXd/QBMgHlPzMeauQ6+0b74JMmMgbwlF9XPmbUH3IXxbOVcRxLki/ZfFhbox+WjO8wAH1Nc8yUhwUh23rvFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774207140; c=relaxed/simple;
	bh=heOGu3Rl0MDKosFg8Dd6jW1BUzByWx7l4ZFm7DLpVzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCyY7jY//1INy2YKgD+z3Akpe7IUSOvAFSqTtXoOLTNh35D+w63cD9wutFJI0pg8sBMhtViZlQ/uY1Awt9GpujMJkNdSwr/Bm7EjPLSffg0s6YkqLhhlnqBMZFBz7ECV4OmtTZYdf123AYlbivfnzhMa0bfM8oWsvE6WN0suSFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M09zNClu; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M09zNClu"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439d8dc4ae4so3060272f8f.2
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774207137; x=1774811937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pctDjFniBAEJnfg/tJuigs5Tad7zieyWuscxLukHvj0=;
        b=M09zNClukMBNazzEeeh/BhhjodEUVYhCulB057dKr47hNW9NIP3yy0tIBg4AuvF8+e
         wwq5SDOB1n5wrhFoM/BXFZVk1fZE7zswAL4SSrJ029Rtj9ZFL1NGpcEfp1JyTEcKbeYR
         N83Z9uR8dGuEJjFKLr5GWPcKRvFnOn/jbSR3nZjAA3Q6xrACluMIjhnURJy98ltf2IPh
         u0rXSA+3FwZ+wwASPCzVbMCfxKZrUyWxGDQhCVtdbL5ESHwKIPHSQNuJQsFh+EWRogVo
         aqBNSMtdNzcWSnTlOMaQXIahZRZHplbpb8mD/0J+obcN7JKnNxPtVgkJUjOi0ihCmpSE
         6OAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774207137; x=1774811937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pctDjFniBAEJnfg/tJuigs5Tad7zieyWuscxLukHvj0=;
        b=bvqw958P5p00b+ASZ/vLH8OEsV0a64de9UE6Ssi3BrlGeANWjEN+0rqdA4J8NFbUli
         Eqdrdn/QMfqaQjtOtj3S5e8ywILN7UC3/Ixway+kmtlHOe6zmqmLSoitQTbZQC1RqCWe
         gQT/SFgGzeMpBg/1lMl/0cEdMKgIJYdu580QJLUz0oatJmRzwIo7+BU5uZTlJxkcTyzX
         +FolLQwW7GHM1o6yxPYXTVlIPnLiF2Bs5gq7HPvoAa3J8eairK+yyYR44NiCsyb5ZAk/
         4FCW8KdcWrgSsNpSAZns+FP2vkt7virn3dn/lmO/DhpDKiEJ2BFewmD9sy+j5jd2yV0I
         drEQ==
X-Gm-Message-State: AOJu0YzRVjnY6sHuj2LhyrA24oTcJjkCfCovLpUlruD5SsyN/Q7rOCMn
	jvhPKBgh2V99B1KrWF2bc9rcptJ8z+8SH2KwiD66eP/AUlHGymvQBMlrnbUPpQWTzpg=
X-Gm-Gg: ATEYQzxP7QGkgBsGgpAM3BVZA7gxYfyAXtnwc05yrwNMbW9/oAQGPhQN6k1paaC5zyS
	kjMDWlKGLp58sbcYMn59UwP30l6brKiaFlM9Dn9HHtV6YJlFbKHh2hscuSfDH8ab8lpdvLTjxJK
	FDiFDfdcPBIj50ORqm9C3FgzGwJye+xmFk2C1MNmgKPAnY7OuLTQxpAX09TaG1VG2tTR2dmpoCm
	O7FJcGt7caqWMMOD+5Flh1rPMRd26u/2ohmzLAmWRcrgMmc2ri9AkYKYKGhRdQPUHUSdvzGVlY/
	SDKTCXUmjHhwQaAotuT1uVwN6tur/Y97isJa/s/6cMToKOl8OMZ+OS2eOY7cR0dIxSNSupZdBrk
	t912UVyjp0vu+ItSljZ7l5NkHdKY9OQR2+/c1O0Fghps3L2JYw31B7SpE4GQpbeKL56arrfVCvB
	/HFk8CdnzLAj4UWuvLsiWTIe+9yHePM0fDDJkglALs8Ls=
X-Received: by 2002:a05:6000:2484:b0:43b:4c6b:754a with SMTP id ffacd0b85a97d-43b6427b552mr15426586f8f.53.1774207136893;
        Sun, 22 Mar 2026 12:18:56 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470b243sm23873661f8f.26.2026.03.22.12.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 12:18:56 -0700 (PDT)
Date: Sun, 22 Mar 2026 20:18:54 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC PATCH v2 4/4] t7700: test for promisor file content after
 repack
Message-ID: <cb642d82258c35ea85e4c18459d09473f23de373.1774205661.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1774125871.git.lorenzo.pegorari2002@gmail.com>
 <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>

Add test that checks if the content of all ".promisor" files are copied
inside the first ".promisor" file created by a repack.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 t/t7700-repack.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 63ef63fc50..10187d5954 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -904,4 +904,16 @@ test_expect_success 'pending objects are repacked appropriately' '
 	)
 '
 
+test_expect_success 'check .promisor file content after repack' '
+	git init prom_test1 &&
+	test_commit -C prom_test1 temp &&
+	git clone prom_test1 prom_test2 --filter=blob:none --no-local &&
+
+	cp $(ls prom_test2/.git/objects/pack/pack-*.promisor) prom_content_before &&
+	git -C prom_test2 repack -a -d &&
+	cp $(ls prom_test2/.git/objects/pack/pack-*.promisor) prom_content_after &&
+
+	test_cmp prom_content_before prom_content_after
+'
+
 test_done
-- 
2.43.0

