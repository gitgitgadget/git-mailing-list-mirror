Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F90386C3B
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113603; cv=none; b=MKGLYz6oHDTr28KpsAkTA02bGB0rgOaWDQu6F/+t4lqFHv4bqcgK3efjGm3bCHXWstrg9u12tiW7T9nDDcsinWu4WLN8I6yg1BP0HGLxcysr/WuO1ocFsSAZwjEBBBKerkeBJSKE2lRzikx1K0Az58D/VuOBMT8psfI7jhKdRzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113603; c=relaxed/simple;
	bh=ZTYXBSBpDikLGwxxf87ly3uxkGY4rLa/eXJZ0dqBq7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzYB5uNAMHhT71hn/bZiznJNIxHSoDuEeFPX+7aTUMYTt9sRi7ZzKZ1dHJKN6n/K/go+IxwPt6uf9l27Sg3t0+srCDVvA1jzRYQRAWCiBKuIIFgweXSWIbZlS5OxcW7xkP7QNqS2oe48LLILYtDk9nf/JShz5zNpfbMfOKVlDJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HS5KONOM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HS5KONOM"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso3552075e9.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 00:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775113600; x=1775718400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcELi9e4XKfgaXq9BKyWbzNaqITrqXTilYvKv8VQJgM=;
        b=HS5KONOMi99TWmzqtCU6OxunguOgWz3iBV7N45RXkHC1KhjT9LBSO+XMCL2KgfrXqi
         yWhONxhNUjXTJN5+hnfjN3UAHA33m5yjZ9jR7ixVcTsS0UKqQc7Oxk3hCkwT6UwLvnQa
         Ltg4YHnk8EblsxK5HLzR6ZvP4KZe+VSbg3ITT+jVKVM+tV7KG1PR43vxeXDIqkiUBYEp
         ehUeD/2uAI+xuvc9iPtQMgRFrPbBhs9XCfGiXrdmH6d7ULbDMjUcGgxDiKQn2CaBVDFw
         BacSPl1JnZfq9aTryFfzWlV+EMTIUZAfMi6tOvAXjXmF87l/7AXs8RJCYXoP99dP5mPP
         IUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775113600; x=1775718400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IcELi9e4XKfgaXq9BKyWbzNaqITrqXTilYvKv8VQJgM=;
        b=tDz/ATx5dAVQqBT3qjvRWX0HLYIK4CKK1g6+akVfbGBJHAChS6oIuOgt3u7ctDGH/m
         2yyMSxquQ8d6Wg/+1LMjkywbE+keN88PImuHZ4oGjiL9J+H3030FEc6Ru+NpHs7xBw5m
         B35BIhk9iyi2i8oFzQgRLI5BvTXIW9y/rCm0zWA+5YeSEf2SREmygFiF7xroekgaTjoT
         6q6eqiGYJ7n7Vpihr9+hODdFGm8N88F1mGly7QPSkPOXy0lt+P1YoktVoecjoqGWx+mI
         dSnP1nJB6MEguEiA56a38iNzP/RhaCxEX7i7z0ArwwwSUtcHZbRBra2HDrLafdQ17aOV
         0niA==
X-Gm-Message-State: AOJu0YycCmHJKVdH+XMsI15kIRjdZUs4r4iQNgqAld+LgSBBBLgSKk8r
	/Cff44rTAQKWEnb/mpNzFQPSPFm6j0BLi9X31YR/o1obnw7bqdBv84vjRRM2KQ==
X-Gm-Gg: ATEYQzyr+KrF1yKs9LfTrGiL9OrX4VRkEOyZVMau1hzmqgkw6PrOK6zol/m1dbY4dRP
	1L6GsHeGtbzltamI9mwDJ3xKtWtJmLAHcwbJY2BCBNQHyw1FQVplpJ1mhmAN2IVHIYBLFCTfs5g
	HhMoyxtXiV/uzGIpxXad+flct8goo1LD9JrSmNM8LJ4cXdbqjZPpaO/GvuHqaeGAzobDDHx+z3v
	VhmaVDENbk32MvYGH2hDnroRC0pI1Htm4iHvO/sW/lRabs8fJybRrpiBqYnJoBnN8PEUKw2V28L
	jQey1drzg0h8ls/gn3rYR90UhKC40bsF1V1WS0sD4nheES1Xpw6NLmMOOjzLSmP+iLN5jih0ARF
	24qyttOhzKPL0tjeZaN3LEfKRatSNJvF/MuGZhXzeazdb+KL+9ABMPrqZdvG2Z6K4M8ij81AeiJ
	q+wDDytUtZ+Xm0XKSZ5wTazZyyRKzTi+I78E3onPC34cT9Wu6uw2SfeG9eEIlEFopuatmfP/671
	gHsAFsfVOMb/2GxfitT8Wlx8cAALAD6SbDEGAfUjJU4xp7Khw==
X-Received: by 2002:a05:600c:8484:b0:486:fe83:8621 with SMTP id 5b1f17b1804b1-4888b7864b6mr31321495e9.23.1775113599668;
        Thu, 02 Apr 2026 00:06:39 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8bc9dcsm101916335e9.6.2026.04.02.00.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 00:06:38 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 04/10] promisor-remote: reject empty name or URL in advertised remote
Date: Thu,  2 Apr 2026 09:06:07 +0200
Message-ID: <20260402070613.85934-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.765.g57b94de1f0.dirty
In-Reply-To: <20260402070613.85934-1-christian.couder@gmail.com>
References: <20260402070613.85934-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In parse_one_advertised_remote(), we check for a NULL remote name and
remote URL, but not for empty ones. An empty URL seems possible as
url_percent_decode("") doesn't return NULL.

In promisor_config_info_list(), we ignore remotes with empty URLs, so a
Git server should not advertise remotes with empty URLs. It's possible
that a buggy or malicious server would do it though.

So let's tighten the check in parse_one_advertised_remote() to also
reject empty strings at parse time.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 8e062ec160..8322349ae8 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -722,7 +722,7 @@ static struct promisor_info *parse_one_advertised_remote(const char *remote_info
 
 	string_list_clear(&elem_list, 0);
 
-	if (!info->name || !info->url) {
+	if (!info->name || !*info->name || !info->url || !*info->url) {
 		warning(_("server advertised a promisor remote without a name or URL: '%s', "
 			  "ignoring this remote"), remote_info);
 		promisor_info_free(info);
-- 
2.53.0.765.g57b94de1f0.dirty

