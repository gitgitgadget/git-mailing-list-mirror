Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EDB1E008D
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396740; cv=none; b=siAebdpMxfOLf/EEdhDFXsBkjoCoWLLY9wEEWnx+K8fdb/y9Tbb83UL7detpiPuTAwY6syGHW2nfozNUowItmW4EJX14HpWA5FPVwW/wY6yjC6um1l5H97v2Sw6HEESKUCAJogGXSZbfUBs184BCOYi5KVVaciiBB9m2W3djAM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396740; c=relaxed/simple;
	bh=nwkY5OI0HH7Cs9FA1wEWNBXEa68F2cUg0znCVfElnyI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BR3EDLWg3dm4t0yJ5mVYArGhJZNxhU9LVfKPRE6Mr7Nd5fnXlAtyJxzrvfNCGRIvQYHYVvU0ezKf57yEiZ8n2+walh5xbZJhYahssieJfRFmeXkJ3krQ9YdqBes7yS6YRneJpxvIA9AvigHHKhGurbjHqOErwP214WFv7nw2H8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auiuc0yA; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auiuc0yA"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fad100dd9fso81274571fa.3
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 07:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728396737; x=1729001537; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPioBOD00J+cmRqzjQDezJ/4LSeWLk7OvKmHjCC+7Ao=;
        b=auiuc0yAuSlVznVkCcIdOICdDHU/V4nujDxPQpHy6GZUjVMQVKKPcWnGHqy282uw3m
         dB4xA6p8iXwon5NOvgOuQ6ZdnzA1RyLT/9p6P9gBCYYW7d1oBVxo03BMF6hONtES0Tsn
         Xk0kh95iCiCiiBNA4ve5vqXfABtY8zVdXRse9zEcjiuGL0IvE1ibg3AuXCjC1xMy3Um0
         cZ6SrYWnOn/IhX0RiUVxbGqYQ6aPqbT7ed7pNF2wv+YUqDvSEiII6OhKbyYe4/9uMix6
         yuiM13FUtAEFzJEx6vK5Yfny56GkK8MuNBg8MV7pbh4n4Gnp22dilT0jhRMkuzmeweQy
         kxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396737; x=1729001537;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPioBOD00J+cmRqzjQDezJ/4LSeWLk7OvKmHjCC+7Ao=;
        b=A3RIMSsMmyO6sdVV8tfeJGY4KVnwFDKwvXVY3emTVuipuNxTH+TfGiRv2yDgflW6DP
         948RNle1gsWhfDNjuaPqX7W+CJiCPFc7vRVdLSeW0v9Vzq69beirSQjrUzGGeLTV939o
         6PBkWuHThnHLYt0QomIPz43/GX6gqL7tNJdnBOLCpNFLWpGyRaLBaoRYIxScssAhKHEA
         bsmmohlqNHN1R6WOAbrILbbAUgPHdwoqVFgUbhqXGopag64x8uhCu4vV0eUqXcIVHxVa
         fKPBmVP92+AHBhts4+5uPnph66VHR6FRBCQA7Njt9bGTIL1tbqAUtaSyAQ0c/2KCpy1e
         VC/g==
X-Gm-Message-State: AOJu0Ywyce3xZFbgS3fJTzcYfJYkIiIt0D4Td35SDLBkrqfar5BGe+xN
	coFMcgwU6ey6QiciOvzZxsrj2V8Llef+qIS36A94LY/3Ds37QiPO2CRXgg==
X-Google-Smtp-Source: AGHT+IGQ4azHr0YF2szZCzHzkt4AUTlViq0bhk/D1Z54F/GDavpLJcIXQjN0B+H/wCaB8I3x6oyiXg==
X-Received: by 2002:a05:6512:220d:b0:538:9e1e:b06f with SMTP id 2adb3069b0e04-539ab87d8camr11218698e87.27.1728396736822;
        Tue, 08 Oct 2024 07:12:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7b19b8sm514132866b.154.2024.10.08.07.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:12:16 -0700 (PDT)
Message-Id: <eae96e8214fc87cbc02e55f0957d6f2bd2eba472.1728396724.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Oct 2024 14:11:59 +0000
Subject: [PATCH 13/17] repack: update usage to match docs
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

The t0450 test script verifies that the builtin usage matches the
synopsis in the documentation. Update 'git repack' to match and remove
it from the exception list.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/repack.c            | 2 +-
 t/t0450/txt-help-mismatches | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index af3f218ced7..50f208b48b4 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -41,7 +41,7 @@ static char *packdir, *packtmp_name, *packtmp;
 static const char *const git_repack_usage[] = {
 	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
 	   "[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]\n"
-	   "[--write-midx] [--full-path-walk]"),
+	   "[--write-midx] [--path-walk]"),
 	NULL
 };
 
diff --git a/t/t0450/txt-help-mismatches b/t/t0450/txt-help-mismatches
index 285ae81a6b5..06b469bdee2 100644
--- a/t/t0450/txt-help-mismatches
+++ b/t/t0450/txt-help-mismatches
@@ -44,7 +44,6 @@ rebase
 remote
 remote-ext
 remote-fd
-repack
 reset
 restore
 rev-parse
-- 
gitgitgadget

