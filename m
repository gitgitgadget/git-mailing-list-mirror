Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FDE2874FB
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588304; cv=none; b=i1p9mlNPXRoky/iPc7CrlPaS6qVf3jU1DkrpUpC0ykZo70s5VSkeSRYqvqTIHgORaMJ+x2DA/rl0iiwMpYHjIKNtITusifoYi5NZmIh6Vq0ONiX7iJek8B1Nz1aQhuI8Fce5OuGT7IMLdKS8CNMWTMkT0t33AxP9oCCUnUWVxng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588304; c=relaxed/simple;
	bh=WIxNZ7GGRNrJ9UlqA3RqLppeKSghXC+okMwrsA05lDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qvYmO9f1R92ScRLBKsH1As9cIpK/nA0zXHfqUwKX9WUtoamuCOmzfSGh30SEYoxl7ZHp1sTM3G/iIhTxcEGMyl7dtOYV/U9xTdHaynDDl5caa2CY6HyG9DcqAcPZDhsqBkx9IchKdXJrnVDTEkeK22hGGcElvt/IUAGiEO2hXfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNGDm3KM; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNGDm3KM"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42e2e5da5fcso886980f8f.0
        for <git@vger.kernel.org>; Mon, 01 Dec 2025 03:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764588301; x=1765193101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUEIiucLLAgj5KEN47cu77FlcE3S6DjH7KS/U66tBwc=;
        b=hNGDm3KM0MYoe3xgX83yG4Bqzh31xY0WIITMU/34exUKm6UIsNlEPevx/ot/pL1K38
         JHkH/7eEX7zkg34EvlrAowfxYbtUCGp2KzeD/ir6mYJw/qqi0hE5xyuSM3whtBq5KLRJ
         WVZRMEbLN56/GGhwx+kWrZbIEdlT0BW76g9JJYLVMqanRaZdK20bMP6ujs2S2XTDGdgS
         hak0z+KJR0IyNn5u/HdAjXA5TVg1/XUsuGoxDTx/rSJ4WvqWO4Gb0Kb8L03b7GH5Zqar
         dNuunftEHzvB3cX66iKfO3EWZG4shp3BJ6VyI1Ko3W2RrJ3SMfD4cZAnrskrHehQ6U1F
         RPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764588301; x=1765193101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LUEIiucLLAgj5KEN47cu77FlcE3S6DjH7KS/U66tBwc=;
        b=tIgCeT1li9d1JKRkUiL7vX+NqoCGxYxKZjV2pJ7qCd1U4UpK3syGbhzjcmUosx9qDA
         Hi2z7lgYtPrHQ534CFZTz3IaX05APivAoSgTp0LVsH6G6rzx5CiPTErH8Jjvxyn5KtFz
         TN/YuUScAC5NI8Qqto6z41jzQVgJtQpm5QPt1wQZqRSwbOxz1G8bWw75WrzcaO4ZvM3H
         Syl4OUBVrCTymXWcZZHdjUSiZwIAt00w1I2sOwtKr9xx6exOXS5FQpIoeTCI6NFu0SUu
         0HszHqmmZOak3TbC1cNixFK5LUCinTnVelURMcDuji1VH2OigXJqo+qhArsMPkMEV7Km
         dmjg==
X-Gm-Message-State: AOJu0YwsHinF3cAf70FHBZXk4MAeQCbMZygsN/KATOk9l3rseC+T6020
	CtFawFfEKNoKrBNWb5MJX2Xxki4p1R/vcmQq6QMepiQ+OBYkRmb72DmQ
X-Gm-Gg: ASbGncva7bykvQWH2nCn6tcKCONtBR0MkwJnRlXgh5LlANxO2Si2FhFaM40rQOURTQs
	aZYsKpvhXEX0hqVtffbk9MRANbkUwV7cQRNRLvr6TwJQLoeLtZj89J5Bi7eOGkqSabpl0iAYxBd
	IO9QSgSkDblxYySsibv6HsB3FXLubREgFGd+pgexmPDkaQw6rc8+qPVGLC+0l8UvRCwMF0UTlHs
	dRpcmGUr9Fr43bhkev3KGh8z0zONKKD5hU34lPQiyHza1FHkrJDyEozg2r7/204nWkTU8FxHpVk
	awGF1HIEjft8UOe070S1yV4kzlZ9kEpVBsdsrAXQnbdGyz87lpUOp0UMGN0JJA5NzK0rRxgOvbu
	BkYlMWJJN2/aTRnaboJDnCj3kznvgnNuC0RoXZsP8sRKHdUR6nMHulJkh7dZykT7LXYqx0kVf3N
	3Ac6vCidTTLYM=
X-Google-Smtp-Source: AGHT+IGEjClOJbhwola/t+woKy46uvWYFw6Sl+fFFPG9wCT7MAA/KPK1lIp3GNP/ol4upAPAUAV19A==
X-Received: by 2002:a5d:5d0e:0:b0:425:8bc2:9c43 with SMTP id ffacd0b85a97d-42e0f1fbd66mr25977831f8f.1.1764588301046;
        Mon, 01 Dec 2025 03:25:01 -0800 (PST)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca40945sm26395595f8f.30.2025.12.01.03.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 03:25:00 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 01 Dec 2025 12:24:58 +0100
Subject: [PATCH v3 1/2] refs: support obtaining ref_store for given dir
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-kn-alternate-ref-dir-v3-1-c11b946bc2fa@gmail.com>
References: <20251201-kn-alternate-ref-dir-v3-0-c11b946bc2fa@gmail.com>
In-Reply-To: <20251201-kn-alternate-ref-dir-v3-0-c11b946bc2fa@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, gitster@pobox.com, toon@iotcl.com, 
 sunshine@sunshineco.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=WIxNZ7GGRNrJ9UlqA3RqLppeKSghXC+okMwrsA05lDc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGktewv5UFv8kQabdHFS1elp3YGf5DpjpAagw
 MxRsAsj6yua04kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpLXsLAAoJED7VnySO
 Rox/s08L/jRrm3dNcC2P/RgaziR7y/nWjE7aW3YrPxp92w8zGlklyaSWggVIXQuJJmdE1IA8m+8
 tTSuyRrddgNbBoj0xsLs0BklkEJ0DUjg6r0NyAfMoI0jphROJSUD27X5LcbXz8HMxLUNMpTlpAQ
 WsTIZrqYkSMC3mu8dybWxuunOr9YshwN2cOfYUabtuTKxwdXQPHM+DoUUrohLH3Krqd8Aug4LRt
 akGzf+orYsz0nIwpAx959HRAc3wkD3fR+nrHpd/0ZnjTS7T/30yIL+hBeOUyRuSs+SCi2HDD1z3
 iC9jbAymTQm66SBJdr8EF8F9vcZ8JxSTy6Ec1IUoZFU/iDDRZt+Vthq3cEbZgtouzYBFXtKEtZU
 tyN5KIFzfczdrB0lHw0F1u9xCFYIScpKY5sB0STbdn3WgbQSpyT6vQCXp5qGZ7x+/pfJr325vO2
 P/JfLKLR3hlYX41hw8a9Os++GBB6SEywc66bMuuQiKJEIzkcqHnAgQ03f/1/zzWmAKkELI1OOO5
 do=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The refs subsystem uses the `get_main_ref_store()` to obtain the main
ref_store for a given repository. In the upcoming patches we also want
to create a ref_store for any given reference directory, which may exist
in arbitrary paths. For the files backend and the reftable backend, the
reference directory is generally the $GIT_DIR.

To support such behavior, extract out the core logic for creating out
the ref_store from `get_main_ref_store()` into a new function
`get_ref_store_for_dir()` which can provide the ref_store for a
given (repository, directory, reference format) combination.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 965381367e..23f46867f2 100644
--- a/refs.c
+++ b/refs.c
@@ -2177,6 +2177,15 @@ void ref_store_release(struct ref_store *ref_store)
 	free(ref_store->gitdir);
 }
 
+static struct ref_store *get_ref_store_for_dir(struct repository *r,
+					       char *dir,
+					       enum ref_storage_format format)
+{
+	struct ref_store *ref_store = ref_store_init(r, format, dir,
+						     REF_STORE_ALL_CAPS);
+	return maybe_debug_wrap_ref_store(dir, ref_store);
+}
+
 struct ref_store *get_main_ref_store(struct repository *r)
 {
 	if (r->refs_private)
@@ -2185,9 +2194,7 @@ struct ref_store *get_main_ref_store(struct repository *r)
 	if (!r->gitdir)
 		BUG("attempting to get main_ref_store outside of repository");
 
-	r->refs_private = ref_store_init(r, r->ref_storage_format,
-					 r->gitdir, REF_STORE_ALL_CAPS);
-	r->refs_private = maybe_debug_wrap_ref_store(r->gitdir, r->refs_private);
+	r->refs_private = get_ref_store_for_dir(r, r->gitdir, r->ref_storage_format);
 	return r->refs_private;
 }
 

-- 
2.51.2

