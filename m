Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278B91DFE1C
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396737; cv=none; b=sCcuueN7/J1YM7qq6cJkdEFQlP3HRKiIQ7p2kSe4ApoNxWSeEfb8ISzivfEKBOCKqwfI4dT8qJORZaByWIZePrT2NX3Mh+ZF7cIbZm2IqSWN2ahB1Aqcrv+P0AlIdMesFLtW9Bp6Jt/YLe1EBogMMC+K5hJF8J4CyDjQ4xVzaZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396737; c=relaxed/simple;
	bh=3KG8xDFhZJUU4MovgpJBEUuP4N3yK1BTDVlV9VHiBPQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Bjv5pffaoik3vU14dART/51PJDZlVYDz2oSSg2A0WBTZp0oLFkasu6SVG9MK0kESgJFBGBzthxdBZhay9yJNjy/GiZnz8aiGg9S+X+AxnNnKTi9BpbZgq+SLfgdxDHTTriT1Ls6faOvYy0i7rrgF4UACljKCian3ddWhUV/vTLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPn0YPqr; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPn0YPqr"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2faccccbca7so47989741fa.2
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 07:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728396734; x=1729001534; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkHmyWoiMSddCJqaKc5Y1nrU9AE+aiKTBWZuJiNLgsA=;
        b=gPn0YPqrAi9v2jkznGia1pzf1cBihuJ0y0Thl3UqaL0Bs8+MSFrDnA2UOQg0+QQ6v5
         eFas4VJrRJ+vCgACKdSC/urFDBc9wWgwaUPqtwSCNkX8bObx5Tls0iJm/EAnNuWdOW9x
         0Ky4a8c4I0XzrByuoWdtx/DUVTXAoWUU4ENXdP4l7btlUTXnDFgi6IYmf6f9pUVRyqbo
         VrsaHxYj+SaHJWcVPiMr5BJ3txaJh3OhUdRozHhLbXT5bR94aXMtObenLo64+2LP9xDN
         i/dmMH6F6jrRsitgKQXYhsuMsCW67Rsje2fmwQ2GT4Rcu8zClJR3to19QuEfGy9tLOzw
         jKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396734; x=1729001534;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkHmyWoiMSddCJqaKc5Y1nrU9AE+aiKTBWZuJiNLgsA=;
        b=kY6j6d6rQYAOOCEdB/ac1a0f12bI+NeazXpNMYqkbkwTVyvJ+9wuHMkKJ902vsUhRT
         2znvNl2ibqPdMg5JpEYZji1b4ExhgnVfy0WRcJMLfN9af7995I8BdySqON6cqhMKZJTj
         jQLp6p68KM0SjRd5h4Ht33nJRpT2/oqbqBQaZUQL9WQhLceziMazZaJ1bQ7ZCYfesNKA
         LDRYfxaidDdKpSL4/0Agwu5hK9MKs7LBQRNg53MuX89BneuBU10Z92YuUybRro5nBo3J
         dnn1zinkhnmZbGDuIf/NJnbyRvxCuzaHULNd1UinC2N4NyBaQJO7hSxESqpUOQprizKI
         2oxg==
X-Gm-Message-State: AOJu0Yz5XpWb08WYdXxAXyZYlfNzCGQwfELsrFk5ivdGaIcjR1fMU00N
	ZsLX8LNtHuAL12riF+wVEt7Re5wBxyho1ziHRnyO80pzJNUXBwIgIkDHYA==
X-Google-Smtp-Source: AGHT+IH/UmpYMJhO1GMrTklbGK5yY+ZnOnOKFnbpRct6YcVv+HUjQtgVvkE6Q/xXAm5G4kjFHsKmGA==
X-Received: by 2002:a05:651c:220d:b0:2fa:e658:27b4 with SMTP id 38308e7fff4ca-2faf3c508f2mr99515901fa.4.1728396733700;
        Tue, 08 Oct 2024 07:12:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eb4b9sm4371676a12.75.2024.10.08.07.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:12:13 -0700 (PDT)
Message-Id: <eaeb40980f4049c790d477d4e6a9860c471c73b2.1728396724.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Oct 2024 14:11:55 +0000
Subject: [PATCH 09/17] pack-objects: update usage to match docs
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
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The t0450 test script verifies that builtin usage matches the synopsis
in the documentation. Adjust the builtin to match and then remove 'git
pack-objects' from the exception list.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-pack-objects.txt | 14 +++++++-------
 builtin/pack-objects.c             | 10 ++++++++--
 t/t0450/txt-help-mismatches        |  1 -
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index f2fda800a43..68d86ed8838 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -10,13 +10,13 @@ SYNOPSIS
 --------
 [verse]
 'git pack-objects' [-q | --progress | --all-progress] [--all-progress-implied]
-	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
-	[--local] [--incremental] [--window=<n>] [--depth=<n>]
-	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
-	[--cruft] [--cruft-expiration=<time>]
-	[--stdout [--filter=<filter-spec>] | <base-name>]
-	[--shallow] [--keep-true-parents] [--[no-]sparse]
-	[--path-walk] < <object-list>
+		   [--no-reuse-delta] [--delta-base-offset] [--non-empty]
+		   [--local] [--incremental] [--window=<n>] [--depth=<n>]
+		   [--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
+		   [--cruft] [--cruft-expiration=<time>]
+		   [--stdout [--filter=<filter-spec>] | <base-name>]
+		   [--shallow] [--keep-true-parents] [--[no-]sparse]
+		   [--path-walk] < <object-list>
 
 
 DESCRIPTION
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 103263666f6..77fb1217b2e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -185,8 +185,14 @@ static inline void oe_set_delta_size(struct packing_data *pack,
 #define SET_DELTA_SIBLING(obj, val) oe_set_delta_sibling(&to_pack, obj, val)
 
 static const char *pack_usage[] = {
-	N_("git pack-objects --stdout [<options>] [< <ref-list> | < <object-list>]"),
-	N_("git pack-objects [<options>] <base-name> [< <ref-list> | < <object-list>]"),
+	N_("git pack-objects [-q | --progress | --all-progress] [--all-progress-implied]\n"
+	   "                 [--no-reuse-delta] [--delta-base-offset] [--non-empty]\n"
+	   "                 [--local] [--incremental] [--window=<n>] [--depth=<n>]\n"
+	   "                 [--revs [--unpacked | --all]] [--keep-pack=<pack-name>]\n"
+	   "                 [--cruft] [--cruft-expiration=<time>]\n"
+	   "                 [--stdout [--filter=<filter-spec>] | <base-name>]\n"
+	   "                 [--shallow] [--keep-true-parents] [--[no-]sparse]\n"
+	   "                 [--path-walk] < <object-list>"),
 	NULL
 };
 
diff --git a/t/t0450/txt-help-mismatches b/t/t0450/txt-help-mismatches
index 28003f18c92..285ae81a6b5 100644
--- a/t/t0450/txt-help-mismatches
+++ b/t/t0450/txt-help-mismatches
@@ -38,7 +38,6 @@ merge-one-file
 multi-pack-index
 name-rev
 notes
-pack-objects
 push
 range-diff
 rebase
-- 
gitgitgadget

