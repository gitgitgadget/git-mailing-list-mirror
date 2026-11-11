Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437364;
	b=sWVC/PiukEk+oO3OaObxH9O3F5eHhTDKI1ZIuEUhXKN+FUEPFXyR+cE3Rjis8rDX8Ukt
	 +lb0MtaaXfkMlnwMy8UahnsO+R4+XB36fQ2YN8mVvBeXR2bEMdW+qYtYotGGGmBTKv6VZ
	 unf8ChdIcnp/N6hl3um458NQRJGar5yRl6Q0rMG5FAjPZ2RBC/mvh3oFzQ2e4YUnRGCVq
	 AuyZj3rc7iW1WSvc3h5aWHaEPcpv0WKNRAJIa3if2RBNw6LPUFqh7UAD2EjZI5EP0cmKY
	 jFp/kSjh5EXI77AwDunYCTp9xFBPpBRrawXVEnANLMkvc6V7zSyABAAFyrJRMr4ar9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=RDXTSRorkwwGKpfGvPjIEs9FY39cF/2a0R5Y5rHIouk=;
	b=OMIH1jYdeeI5lOA9v20Uiq0qG6BGJHfn6ZWWj0ry0KalvdIMkV/mp+4ampUYji/VtaFz
	 n8eBR7zvDnOM7pr5WKskWvseTggMHiepB1seQ+15qpoIE41TOxpQL7ouRBxxksHrL6611
	 wVRHkYmlEXAMtFLvdqT1k1Nqi3LE8Q7dLyNR30520mbkVbxrVQMZFioaV5HhzcvinQHLr
	 w+VeIC4G3zAR2Mo7mzY9auxQNkJtdc1jyrMIw7bgW+A5/ZAdBsaWfjvyWwNO71IJWvx+u
	 L/KOs2E/2hXPV03jwsnPOy7NJ2EFMMks+E5C9Pv/59X9974ftEBiBOR21T4PuVWDGsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iRLOXdqy;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5611D606AEF6
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 22:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5611D606AEF6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iRLOXdqy
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-854b6e2e41fso1897185a34.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794437363; x=1795042163; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RDXTSRorkwwGKpfGvPjIEs9FY39cF/2a0R5Y5rHIouk=;
        b=iRLOXdqy+jSJPrE45bIjIgQQTmuQbzZWmm8L+JQ2s3BNFRMmFPouI5zj5iE4tbnHJI
         ggshnQEjQDJz490aFm1mRvYdqd123PzfH3J495bO6FKLmLulT8DXu3ftHqi0YL+KRaP5
         pkClX6XCDPHv37g7J7WagLlfyLo5zZcvE17xuc/X3hqEnhq0oMuRqV2YsfstMCcHs5xL
         SO0uZv0szlMhCkZ8VqXICg44UatAANqyZJAMXY8WYEbPDUewO3gGDcyfUv3X4aBFvDxf
         C4sJCxK3aTsnDY8sevNEKHzDP0rjS00mkwnyPP2rBCGqYZTsj52AdgtkpAI0Q9o0h9zS
         RUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794437363; x=1795042163;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RDXTSRorkwwGKpfGvPjIEs9FY39cF/2a0R5Y5rHIouk=;
        b=s62O3UvR++nxaYuwM+IWO+dPwG0qEF6vFMqSAkk6hpAseCAItJ5jaoczxbg91p0dEM
         ryaMLmYyzCWXi1FHNjbsqBYuBlyE/VvLKMG2F1+CBI5A9vEFiEkFr/PwtATrVPuaRqMP
         2ymQlGNqHYduR0+LkaywUsO2an4JVIwyDwr73hDX9ipNBrYx2BYMTArNfw3fVlxVlqfT
         R6e5uiAoE2KlNNA/LvzwUqvbjVQ992bx/vTscypwxOIHZJGeyMFseHMYkREhF2fMd9Xs
         CBkIQ4ehsMxQhGQldzcqQDADmaDlwLLgDwMqfDqZ9tCGELNCRX3UJMiVi5VP8qeebqVK
         jsww==
X-Gm-Message-State: APuU4Z+/bOALw4z+SBs+RYQ1tTA1DXLg9afo4pFUPCS6wnRBFgN6nzE3
	Scvxe6+AmS8ueQXWRL1wxANDSfqmGUCrNy0MvJ3oJZC77heE78GLGyMXBtWPEA==
X-Gm-Gg: AYBFou0OrETqikBscVomMT2tr65Ahho16kfztTCzmWihdp8eHQq3ES7Vfqro5CzLg8k
	7tgIgf8xo8/fv7NTztyBxOOeJQD5eZbEdtwLH48UkYhP+IfYXfju4Q/+qwq9d0bH34rmjg7oqkd
	bmQGdlsUCquhcDFxbAmYND2DqF49WJ0CiqOcYhcIrO6JN9Sohq5imgrzoTQxHFtqomXSOxSMk0T
	UIir3PJh0ceTo7FYQ54iFS7MPmhm19pSuGg9WzQ1Zul47xlu5ymOOzfdtQQcpkqHnPB8VaLJrJo
	K2vNCYJbFnyaNi+sMSDW1WQrvZmufAXL9pgfWFEu1L40AP+aZQaU8AMod7aFcri4Q63tjzeaH8J
	AfGqkfuGXrbd35yKE+Vr9BvX1GUK/1QC3dSftDYcds2QetLfOsQKPSCwYjCGhbh8Tp91ntTF8hk
	Gk/4iAaexhXo6JHa2ZCxsEFMw4iU5vQvQHj4NsTQLVqnTsW3eASWvjJY67qNmaBqlwa6+coDQ4J
	isfrqQPU/ZfmK8Wgfk4Uelh24rqCLOxOO4vNnMfct5nb+KWP4WU5VfdzwL3gw9EDtaJOfQjDRx1
	RAfcQn1VgS4TiyFE9pEO0WJqNbl6y27Yhfn3OAbhYuy37w6OW11wpedC
X-Received: by 2002:a05:6830:7189:b0:85d:6045:52cf with SMTP id 46e09a7af769-860f28a81afmr3970602a34.12.1794437363268;
        Wed, 11 Nov 2026 14:49:23 -0800 (PST)
Received: from [127.0.0.1] ([130.131.199.169])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8615518d641sm318162a34.21.2026.11.11.14.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:49:22 -0800 (PST)
Message-Id: <c071e79d1122ddccfe941d241b9192d9c40774a0.1794437355.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 22:49:03 +0000
Subject: [PATCH v3 03/15] add-patch: handle NULL value for color slots
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Colin Hinton <colinlewishinton@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Miklos Vajna <vmiklos@collabora.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

With color on, a color slot without a value, such as
color.interactive.prompt or color.diff.frag, makes "git add -p",
"git add -i" and the other interactive patch modes segfault:
init_color() passes the NULL value to color_parse().

Read the slot with repo_config_get_string_tmp(), which rejects a
missing value with config_error_nonbool(), as "git diff" already does
for color.diff.frag and the other diff colors.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 add-patch.c                |  2 +-
 t/t3701-add-interactive.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index f27edcbe8d..ad581eb4ae 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -295,7 +295,7 @@ static void init_color(struct repository *r,
 
 	if (!want_color(use_color))
 		dst[0] = '\0';
-	else if (repo_config_get_value(r, key, &value) ||
+	else if (repo_config_get_string_tmp(r, key, &value) ||
 		 color_parse(value, dst))
 		strlcpy(dst, default_color, COLOR_MAXLEN);
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 6e120a4001..33050ccc53 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -815,6 +815,18 @@ test_expect_success 'colors can be overridden' '
 	test_cmp expect actual
 '
 
+test_expect_success 'a color without a value is rejected' '
+	git reset --hard &&
+	test_when_finished "git rm -f color-test" &&
+	test_write_lines context old >color-test &&
+	git add color-test &&
+	test_write_lines context new >color-test &&
+
+	test_must_fail git -c color.interactive=always \
+		-c color.interactive.prompt add -p </dev/null 2>err &&
+	test_grep "missing value for .color.interactive.prompt." err
+'
+
 test_expect_success 'brackets appear without color' '
 	git reset --hard &&
 	test_when_finished "git rm -f bracket-test" &&
-- 
gitgitgadget

