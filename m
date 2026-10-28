Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180128;
	b=cYkYw7J/FdSi/+yOuvT6OiZsJAeP+3WsznrW+U5ZPap4E0FMFpPsvgZqzg7tUBNKhlBl
	 +GdICq2CVo12qgWFyniEuGxDQ/8K5sAjrRq1Cor6WemGv6HC5bX/d7RrKLSqe8bfu5VFY
	 339uGaH1n7uYTFOWHCzpsGe136eOY+ux1B5o0JLMdGj1zAPx2Em8Q8Iziqyr5VdKYOkoe
	 UzFad5SGHkITTPejRFIrZIi64eoDal/QiFE4U1eJotaZqlvoEZ88tuKM2NcLz/zq/FqAj
	 7GssMgFp3Df9DznYcQtaE2JqV9zAsq8//qmTUkbRNgdD3xRFDVqvyXc9U20R6m4Twhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Or3YYZzodosQeezLXHhi1FfVFrtqB+mc1G15FNZqRkk=;
	b=Tx6djE0Qa7Jns6hghWBsG9yY65qpVoQxtWXUz0f4QYn9joNB1RJ2gQf2wiVbhJivjtSJ
	 SwYjMdosQZZfvxEC1GEkglMDjN01FbkWGw7XDM3z6Pq07dtjbf10LmXrzuuAafGU8Wt3l
	 dszSN5zs2ggemnM0ad9RbnKeya/uhNJvn3wo6fw+78jaqP99Um0NkHSE7Bzx2wVGSX4Cu
	 kmQB0hGaR9nwgU317JarxVaS/NrLcdc2udAunaVmQl8mpqdpKz6xDZWjorzMT9pu6lCxX
	 tulnBA466xolGn29mtWRjXxkEdcQ30c7za5q+/0Uqa/T8Daq2sa6MWqHa74a2LHS2uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hfmhd9wi;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C10606A320
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 09:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70C10606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hfmhd9wi
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso1226962a12.3
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 02:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180127; x=1793784927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Or3YYZzodosQeezLXHhi1FfVFrtqB+mc1G15FNZqRkk=;
        b=Hfmhd9wiwNAuiK+Y/3Wm3Y9MpOGsLMkT4S2+O+/RY4L9uYsTSZ5BQEaukYntfTV5tu
         NhEhXlizVQfkkimJg6SjxR1Tw9IDWFrOofuqzFmbgiKAoyOUjHr+hvSPpEKFVC2FPjQo
         T5UNEpsznx2zEfo2P1Qd9gc5rZYxY0GfS1PbtnO+hW26U+tb/ZdeRGDIHpGoarhhNjcW
         DzJgLhRXrq3CJMMAACS46nLNWlvklrzimhNQxmui7TL4N+KoNW46BXINECV0UdQR7eWZ
         27y4roPuYeKlxbqC8eJrgGUbEXwghKdkSAImxe3rNau1ewcZehPD0nMxHxiMKZ602gHU
         4swA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180127; x=1793784927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Or3YYZzodosQeezLXHhi1FfVFrtqB+mc1G15FNZqRkk=;
        b=15xrotry8onXKYkkZnB+R/CuFM3Iu4rFrYtYdiLp4OiOn9WB1nWss3Q+Ew1UUZ/481
         o527GMDpihWQaH0SSYsq614zwr6aXVYgmBSTZv01RqXw/Ok2V+fU8KCnpIht7ZJ5u2d9
         3Bhg45OlI0f0y2Um6T8Gmn4zC6fChzElKXRXt3mpaEtVMNWcVK3An1OhchNFEijq5dfT
         GOKnz8oqmA3hrj0lwJMxEs6h/dLZll8RN9VbQbGlCjHEm+nu0IPZs8ydG7twDG1IU/rH
         sCUWzT9UTpXd1sLnxVV6td5CdbOdfWdUVDBohhL+Cc6Buiaunu8hp0KSMVAy3yMkS6Co
         YqmA==
X-Gm-Message-State: AFq9FYJxOEYwg5/4tmoH/7mgvSOoEu42zYNiFjURTXf3Gqvpq2ifnPMj
	QU6FolUcMqvmjyXvRXTg6VC0sldT9qmOBl4kYeUk2Dby+nqPrWCSXRg7qn0cYxfbb0o=
X-Gm-Gg: AYBFou0Ueg71RitNW9v3PNog1aZ6LybSm27EzjCUFhL2ubYfLb6b61SX5tEfrhh/l9Z
	fXZSyvNN7sRj6GlWRqxEWFKHCqvU2neVBjjXAFD99aCo92Ca6kAzAQNnsYFTKZrVeBy2x6hOyoJ
	bT0V+1Tm0sCg35B2eJn94TADLQ8m/PKXFGwmatpfnpB99KUHsppwAgtv8Ya0oU4gpKsNCcLjQn/
	YNfVeddHadvzrv4QIVSUQi6EomLv/4mOq7JAEzWalyApoLeWPkQfRVa4rxCy516S82vCDHikTf/
	WqIAEVDUqsINvjqIV+LqxBSkeJl8YI7x1qzLopT1GyPCray71WkRPhpDiQGjuUgewFmUvgCnMGe
	P5PTxfRDufJKiSwMmF6VDp9DWyAB8gfyOUUT2/RqwUjXBNQ2PX4hCmVVsKJ1/3eflJA4mFrMjvx
	4ta7JZCOx7LFDRuf7TglbcxnSABHfDMOy2ww6Zs+64abiTmEH9dEy+QDelnArqIE8LBG2wL6hbU
	tEY+kxzm40VnDJcnnVR/3KbKCBeOexbI+V6ONwGJxmg+aOVg32MAlYficoqpaFnF2LF/N3tJpqE
	39b2c3+5Xqe4DS45xURpkUTNMjHQYz4PtXIxxkCLyqoHYzFUZCKruxN5LErH4fB6Jj1hn/WHWoK
	HQu+AZMiMmdnX4uw2s57IMeRkD4pTExTfqUzAEKIyD5vrUBt0dpq6JW9aoJUuTWw4AQx88Fd2Qh
	9pKrascXl0lptPF8uZ5m2r1QfXI7VAXApTAaYofYw02CR96NdaJw==
X-Received: by 2002:aa7:d152:0:b0:6b4:21b3:a407 with SMTP id 4fb4d7f45d1cf-6b49cbec0d5mr784068a12.22.1793180126521;
        Wed, 28 Oct 2026 02:35:26 -0700 (PDT)
Received: from localhost.localdomain ([104.28.251.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b496435c7esm1213185a12.29.2026.10.28.02.35.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 02:35:26 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH] bundle-uri: use the passed repository for refs and tracing
Date: Wed, 28 Oct 2026 10:34:55 +0100
Message-ID: <20261028093455.76247-1-okhuomonajayi54@gmail.com>
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

unbundle_from_file() receives r and unbundles the objects into
it, but reads and writes the refs in the_repository.
fetch_bundle_uri() also has r, but uses the_repository for its
trace2 region.

Use r for both.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
unbundle_from_file() still depends on the_repository through
fetch_pack_fsck_objects(), which reads fetch.fsckObjects and
transfer.fsckObjects from the_repository's config. I left that out.

 bundle-uri.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 2bb2eb99e4..0d612d92fe 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -448,9 +448,9 @@ static int unbundle_from_file(struct repository *r, const char *file)
 		strbuf_setlen(&bundle_ref, bundle_prefix_len);
 		strbuf_addstr(&bundle_ref, branch_name);
 
-		has_old = !refs_read_ref(get_main_ref_store(the_repository),
+		has_old = !refs_read_ref(get_main_ref_store(r),
 					 bundle_ref.buf, &old_oid);
-		refs_update_ref(get_main_ref_store(the_repository),
+		refs_update_ref(get_main_ref_store(r),
 				"fetched bundle", bundle_ref.buf, oid,
 				has_old ? &old_oid : NULL,
 				0, UPDATE_REFS_MSG_ON_ERR);
@@ -859,7 +859,7 @@ int fetch_bundle_uri(struct repository *r, const char *uri,
 		.id = xstrdup(""),
 	};
 
-	trace2_region_enter("fetch", "fetch-bundle-uri", the_repository);
+	trace2_region_enter("fetch", "fetch-bundle-uri", r);
 
 	init_bundle_list(&list);
 
@@ -886,7 +886,7 @@ int fetch_bundle_uri(struct repository *r, const char *uri,
 	for_all_bundles_in_list(&list, unlink_bundle, NULL);
 	clear_bundle_list(&list);
 	clear_remote_bundle_info(&bundle, NULL);
-	trace2_region_leave("fetch", "fetch-bundle-uri", the_repository);
+	trace2_region_leave("fetch", "fetch-bundle-uri", r);
 	return result;
 }
 

base-commit: 37b3475fb530c14109211faca33716a173db61ed
-- 
2.56.0

