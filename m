Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7962620E0
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829784; cv=none; b=PNXhkBLsD2yB3FDYf3EgRmdYcMlNPJxX1YLgHII9BzOllEOxqIg7rHYqos/7OSM5KftcLBdiMVHRMP6c5/2ASHbmzlcCSB2nrmsOsSzUO9qdU6y8whNu1yL2EDJ+np5wVkZyauZGVs6ykQUK573noneyJZc+ELUyoRZbzYvJfc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829784; c=relaxed/simple;
	bh=QXSFG2qXO/mvjS+wkdI6Xoo5NJIVuKHMAN2mVrVklz0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I018O+fCevyriObVm55oyod/G8eMv3MZegMNL9IEufuXlL4KguxcAwbBUVCdHmsVkOiK7QG8NpzOr82d+2Z8euqgI7zCkDOFvySBGI/NQKXo6w2SCTJ0S3TYHr1fsWEguFtCfmUvVH440BhYjjjb1pyefmAB4Z47zyTC5wzPoyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgyrhGpI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgyrhGpI"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso20573935e9.3
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 08:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742829781; x=1743434581; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/eGGOZ1MVQ3Aa7LEyzHAhvSe7KJMa3QIegDMdZ8sBM=;
        b=lgyrhGpIyfiXosuctQ58dw6I5HGiLlWBXb6awNGskYM5ptsmtNpOlmsuYF3eUrycCo
         gOyukvfO9zLZqZSYp3tQ84cUhrh8reXtx+3ah9EptnTrvc9rPBmTiAKh9JOrWhgY8Kiw
         JjOeDdS1ci3ybL3DM8t213kk/DbzDhTD0HxUgETx/vOjaPl49ywwrFqE2jlnTZVSYzbT
         DxIAxHQSYqVQK1JpVSyZhJN0PJF5H3ptr6hRVTRh2wMn/YGTvEE9Oeh/Ocu7HLB4FNKJ
         unq/94bV9w0NyvidtaA3/63U9qfI4N1VZWSMlg7G2WHsAxcUVv2G+O1dCrAWJ0enjhAJ
         7fwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742829781; x=1743434581;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/eGGOZ1MVQ3Aa7LEyzHAhvSe7KJMa3QIegDMdZ8sBM=;
        b=Y5mJ7DtkYKRWZwT6EKL8ZwBjtSTn7EKHM2pTDc6QOWu4TJcIS6/aSoe4TBRWxiJTfW
         6/wjxaNCNsta4XkVQk44A5uKiC0hOA7vWgKw3/JQzqhrsKgGH9KzgTIfP21j9yN2jpqn
         WSuvloGDpxZ2pVcLMaPnjaQMoxWSWxpo0fV+bFzr4pE+BNr89Rffst4wl1gENRIp6+vd
         /WFCGiDUl7NcDOGofY/4qLHtB9yYvPm5+RojXV9p/bNF6vyEOg5UQjKEcS+/Hsu0b13y
         SC71DzWgnZFMRKpPIBMAS8e3G5ZzaSrleQrQkxJvGb++Dx3uiHtYPic6I+KPayBdyxUK
         MMsg==
X-Gm-Message-State: AOJu0YwP89o6hKrxxwRjH9uZ9yXs/gxD+Ft/qWiL1BwzyL5IG/F4+QxS
	z+0+PybJxiI6rO+xoLo0FJ6l5wOsCpK9jFTp7Cy9BBE7aLkJh3XLnUW8Nw==
X-Gm-Gg: ASbGncv7PApLsIua/Qkva6n39J8AtDyjUppvUSoRIKAZXvqwvpQ2aY7pUhX4HNN73bd
	IjaIB5op8nCLR+zItk0fniszl/CkjtvW0EHKQ2skWQgj1CFZ1yoQZcGKK7LvwxlS98JU0p/QzQl
	i+BzTZiQ7lHQMj7jTMWW4/IwfcF1mAnD6u4Lc8iN8sChOwJj5hF2fVoVmVqCTOYvS21hOw1WsiN
	JmNu58NywxJXIVbwQpLtvWHEo6tAIDgD5Nr0M4povBcjngF/FFEIDnMjfMx3qHjQTEkiSIE1XWa
	YIKYIdjePtOhGUkpGwRPUof4Tw2VzCrNj8j/zNBoHc7StnuqQFiTULTS
X-Google-Smtp-Source: AGHT+IE6BHa8y9qc7YCSPekJPa7iU1UOXHfPxymkuawG9zMrD/VAPMGhcZg/jAmDh8MAggrKBIiUEA==
X-Received: by 2002:a05:600c:1913:b0:43d:36c:f24 with SMTP id 5b1f17b1804b1-43d509f633dmr121287055e9.13.1742829780977;
        Mon, 24 Mar 2025 08:23:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d3bc88eb9sm106369895e9.1.2025.03.24.08.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:23:00 -0700 (PDT)
Message-Id: <e5624c379d5804bf4fc44163c14a85ef55f89c97.1742829770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
	<pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 24 Mar 2025 15:22:45 +0000
Subject: [PATCH v2 09/13] scalar: enable path-walk during push via config
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Repositories registered with Scalar are expected to be client-only
repositories that are rather large. This means that they are more likely to
be good candidates for using the --path-walk option when running 'git
pack-objects', especially under the hood of 'git push'. Enable this config
in Scalar repositories.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 scalar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scalar.c b/scalar.c
index da42b4be0cc..bf638fa34b8 100644
--- a/scalar.c
+++ b/scalar.c
@@ -170,6 +170,7 @@ static int set_recommended_config(int reconfigure)
 		{ "core.autoCRLF", "false" },
 		{ "core.safeCRLF", "false" },
 		{ "fetch.showForcedUpdates", "false" },
+		{ "pack.usePathWalk", "true" },
 		{ NULL, NULL },
 	};
 	int i;
-- 
gitgitgadget

