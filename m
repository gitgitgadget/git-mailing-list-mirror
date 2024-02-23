Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E530F5D461
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708682484; cv=none; b=YN7o9Tpz3He7WtkKJ0OFN7+enSoFSmU1gyz2vy/t6rLaHvmiU6286oOrbRDCKxyAWRrMCjP+70F+ZPyAxA3n8kPB/cNDSGzlN4VPnPGGO0K3Q/N5GEUrllH4ns9tB3QBR1/rRPWUBQAotIRVVXQTc5rx++/twFBZyDx/J4ZnpNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708682484; c=relaxed/simple;
	bh=fdMvcQ3ggkXZxLDXfELYFogbCnL4yMRk39ONX3bUV5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJRlVJJYBHtfxmUCIiZlskOOt8LhHO4Z/4xEiX8DQdsJs7Xt/7f4XQv9hlpBKUdgkW6Ry7i9eXr7CUczLMe/tXUADe4XDzfoVGmnxoPUCyN2VjUbgUIZZNcm8k6Dkl76qr+jAKMqi4fapHnk9GdL3hghgdE11hoX3gRgwC16ebQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiC/N76U; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiC/N76U"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3e72ec566aso82189366b.2
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 02:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708682480; x=1709287280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONUj48aF3C7y99NgU69gpZnZKZCfgGEoHsbwW5vy4ww=;
        b=LiC/N76UVcPslkxHnGdQWuosfu7jMlR7Nc9X1Ml0iFG+qZCjIRhwGO5r3A8mXD5pUZ
         qczg2EgdTcHq1x+K8zK4Gay8eWWm43GTwIXBrbchQSf4XwkU8HXLV/ubCuVxE7h/Tz+w
         dLKBwO8M3xskKGfzaF3chM1+wxImUCEwgXfuvmGhRUXNk+I4ejr58UJSyEgbwbj7iCXv
         0YKSULbJm24NaXuQSQgX8SNw9WI8aPrJTMYLAOLSf6Vtpb9Wvj9GfWFNctdxlh5+r1Qv
         BprFFtDmt1uY4OMi+U9PFmNOIpR5OE+OtbsHhQVT3MlnaYBK1TuSYZo/QXhAJHDrgD7B
         syIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708682480; x=1709287280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONUj48aF3C7y99NgU69gpZnZKZCfgGEoHsbwW5vy4ww=;
        b=wcHgz6EBLJTCxWolkFcWqN5GLGocLBtWjPnqML0Z2XE3d89TqQr/kc8a2rHzzknUk3
         b6aSSFkbCz3Wptq+jJv5wE8Kew0zxLFmmWhkp7G9r265pEVLb0ojFiodFOvZ/Z3lqRzi
         LvkGvYABf9G8aiLcRg9/rtlUi4gZzVzyxpLqRkKVPuswVwNt5iSdhQM/i9+D4cU6iJF7
         qcr8VpgPQGpN9D7geR6jYZGYwRVX0KExevBhw/1uAv+RnIP6aHBPufDNFb273P1K02ck
         oTaI3cq84oZDXHVTlyKCOEf+PjfCOkDKkm9A3s51JTpO/QeCT+GuyTGJ435vfobqAo91
         QBjw==
X-Gm-Message-State: AOJu0YyqxFBUOo2l/d9tzEfWxKrozvkkYmYDpME+JTPzRb+nPtxdErU2
	LuuG15PoszswwSyTQH4c7yf0g3dBo5FHLn/plJYwqesCHcKMc5mNq4uHdxOR6Uc=
X-Google-Smtp-Source: AGHT+IG/vxH9CDmXZU73Gd48Y9oBEW1V9sIQfbA+BOjBDoxZlk9dx8GfC8exV6vARtiJBhnWW8Ndsg==
X-Received: by 2002:a17:906:4551:b0:a3f:c114:9674 with SMTP id s17-20020a170906455100b00a3fc1149674mr841551ejq.12.1708682479592;
        Fri, 23 Feb 2024 02:01:19 -0800 (PST)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:660d:e728:4b64:50ff])
        by smtp.gmail.com with ESMTPSA id ha1-20020a170906a88100b00a381ca0e589sm6734917ejb.22.2024.02.23.02.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:01:18 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 4/5] ref-filter: rename 'FILTER_REFS_ALL' to 'FILTER_REFS_REGULAR'
Date: Fri, 23 Feb 2024 11:01:11 +0100
Message-ID: <20240223100112.44127-5-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223100112.44127-1-karthik.188@gmail.com>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240223100112.44127-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flag 'FILTER_REFS_ALL' is a bit ambiguous, where ALL doesn't specify
if it means to contain refs from all worktrees or whether all types of
refs (regular, HEAD & pseudorefs) or all of the above.

Since here it is actually referring to all refs with the "refs/" prefix,
let's rename it to 'FILTER_REFS_REGULAR' to indicate that this is
specifically for regular refs.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 2 +-
 ref-filter.c           | 2 +-
 ref-filter.h           | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 3885a9c28e..23d352e371 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -97,7 +97,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	}
 
 	filter.match_as_path = 1;
-	filter_and_format_refs(&filter, FILTER_REFS_ALL, sorting, &format);
+	filter_and_format_refs(&filter, FILTER_REFS_REGULAR, sorting, &format);
 
 	ref_filter_clear(&filter);
 	ref_sorting_release(sorting);
diff --git a/ref-filter.c b/ref-filter.c
index be14b56e32..acb960e35c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3047,7 +3047,7 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref
 			ret = for_each_fullref_in("refs/remotes/", fn, cb_data);
 		else if (filter->kind == FILTER_REFS_TAGS)
 			ret = for_each_fullref_in("refs/tags/", fn, cb_data);
-		else if (filter->kind & FILTER_REFS_ALL)
+		else if (filter->kind & FILTER_REFS_REGULAR)
 			ret = for_each_fullref_in_pattern(filter, fn, cb_data);
 		if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
 			head_ref(fn, cb_data);
diff --git a/ref-filter.h b/ref-filter.h
index 07cd6f6da3..5416936800 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -19,10 +19,10 @@
 #define FILTER_REFS_BRANCHES       0x0004
 #define FILTER_REFS_REMOTES        0x0008
 #define FILTER_REFS_OTHERS         0x0010
-#define FILTER_REFS_ALL            (FILTER_REFS_TAGS | FILTER_REFS_BRANCHES | \
+#define FILTER_REFS_REGULAR        (FILTER_REFS_TAGS | FILTER_REFS_BRANCHES | \
 				    FILTER_REFS_REMOTES | FILTER_REFS_OTHERS)
 #define FILTER_REFS_DETACHED_HEAD  0x0020
-#define FILTER_REFS_KIND_MASK      (FILTER_REFS_ALL | FILTER_REFS_DETACHED_HEAD)
+#define FILTER_REFS_KIND_MASK      (FILTER_REFS_REGULAR | FILTER_REFS_DETACHED_HEAD)
 
 struct atom_value;
 struct ref_sorting;
-- 
2.43.GIT

