Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0075E1B976
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 08:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708677275; cv=none; b=TmMRS+L8oKxtTueb0x5dKn44xH8IJTsZ28clXBjxz8FpIR6THmnw1ADk2CRD4bg5GYDLyYHedQFHvALRq5d+ZVVbedagvFUekIrKPwcMZAigdtDvG9WHBQdEB1Nv3NULED2TWTzCM2a4NkfLV0P2P+HtpNjyXXvx58uxPJ0AEi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708677275; c=relaxed/simple;
	bh=QSb/Qh/k/jtO5PpkL3y6lTEdSq/J5NWkFsE0nmeVhaY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BjbOiZI/4PZVxxrgW9jfmyG2D7CFkJszZilmN5To/lkbm5M9NjOGGZpVHYEOmf5FQrQPbqKRPqrQ/TeB1Bie1Fq7hFlg1P/07LUXLuCS0DrKLBalaxPVdgR6p4YJE6676okBYHZjpxlko1DUu9lUGinckNTJBfYVSSdexrnNIYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCrv0TZJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCrv0TZJ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41296dce264so339075e9.3
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 00:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708677271; x=1709282071; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2HklqQzwQdN85hogz+D0Bk5KjHPdNYbw/bviEKo8cw=;
        b=hCrv0TZJt5+/2pWqKZy6Rl66j/TcSmGEIqTyAytHO8+EKrqxyIIVBMKNQ2gjUb8xN1
         1vE6h1CIkaxzh7eIL9Dt2+dKwmQCQvFLXXaiUjE5zFCALkuepGoGxfEleCgOqxskkXe3
         rWSIJL51+TAOidYk77VEzWZ2T5QMfRJVqGmRPev2githbFfXHkvjgV8AWipyRAS2K7rN
         4W9xFfPDIqDPTl9u+lR3hu/wi/U2IMwvomd7FZsBusKJwUWCaWtGCAOM9p6fppkErUHR
         WqfzvbmOMfaKo+9ZsZGKyYz3NKjAvRElt+m0WtA9EfNGCO4TkLb0Im2dj0J5QsDau6lm
         hLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708677271; x=1709282071;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2HklqQzwQdN85hogz+D0Bk5KjHPdNYbw/bviEKo8cw=;
        b=h9bc9Ij1yYENOqRiRS3yDneTBhJyrls3Q4MScLljnQP62Ol/fLJssb3xaRSHvDXYpu
         jqvySfZC/yWP0IQ/tePlAaXvmVKUo6tTh19OGP8j2dG9zC4UJY+UU88NHOtK7mTP2Ajk
         D7Qk/4ADq1HbgbbfJvPxzmfBj7ALmj36aqOb59m9ERiaGNi0KP/LCrawqjVYUo2eWtw1
         Wcl37O/q+KCwF6nBXvMeb+R8GgH4Bkgi63sgu7aL+ohP/LhqGFYg3p1DtpGjoEoLMLfz
         lT39LoJ3cRD5PN02vI/9DYUv2h7L3nrlnNGhHtQ0/40u0baX8OXd4lvq8E1eb5wIP0h4
         zwqg==
X-Gm-Message-State: AOJu0YxoGtUc4+OLM7aQj47RUvdRRxVWZHGDjZSSl0oP95O24vupbw9m
	ciaF5TiPBwjM89334tZbegod6Gh9z4XbWZbRjBfPY2h88xdGasyQ5d2R7GK9
X-Google-Smtp-Source: AGHT+IGGVf+1KMnMv8hrgHdULWXq+IipQqbFh4eg4NrYr7KWam0Lge3NXZDRSB46HopoHYMT0h29Mw==
X-Received: by 2002:a05:600c:4451:b0:40f:cf69:3e1a with SMTP id v17-20020a05600c445100b0040fcf693e1amr576866wmn.39.1708677271696;
        Fri, 23 Feb 2024 00:34:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k18-20020adff5d2000000b0033d4dab14a8sm1920478wrp.22.2024.02.23.00.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 00:34:31 -0800 (PST)
Message-ID: <7e5e84a4e7c5733c7f229a7713713d44406ad573.1708677266.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1651.v4.git.1708677266.gitgitgadget@gmail.com>
References: <pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
	<pull.1651.v4.git.1708677266.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 08:34:24 +0000
Subject: [PATCH v4 5/6] cache-tree: avoid an unnecessary check
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The first thing the `parse_tree()` function does is to return early if
the tree has already been parsed. Therefore we do not need to guard the
`parse_tree()` call behind a check of that flag.

As of time of writing, there are no other instances of this in Git's
code bases: whenever the `parsed` flag guards a `parse_tree()` call, it
guards more than just that call.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index c6508b64a5c..78d6ba92853 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -779,7 +779,7 @@ static void prime_cache_tree_rec(struct repository *r,
 			struct cache_tree_sub *sub;
 			struct tree *subtree = lookup_tree(r, &entry.oid);
 
-			if (!subtree->object.parsed && parse_tree(subtree) < 0)
+			if (parse_tree(subtree) < 0)
 				exit(128);
 			sub = cache_tree_sub(it, entry.path);
 			sub->cache_tree = cache_tree();
-- 
gitgitgadget

