Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85682236E3
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 03:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770953867; cv=none; b=rOA1VTyLI75rb/5XJWT6Lps9eLHQEpmv4jgIsa4hYIKAFhwGjqxLpJCHSrNbWddAIQUNgmg5NBt3MrPHh7WD/2zzwBx+SunSPIUmsFI5Dr53NwIv0ol3gCS7FZjMwP4mR8ts7rDZtvVmpIuD6+O22Civb3I9mdbE7oSTfQwvfI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770953867; c=relaxed/simple;
	bh=2hSrQhs/Gdiy8H8jb0zbC99GB7VXtxWxQtnWFj4bW/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AElUKfsE3i/MFcIzm3TJVqiqYsKU7t1FkXxH8DFE20SqTEOW3mj/ddchO3jVFvs3uXQdLbCGzI/IAr7n+q7Ypkourx4Su0KJsRgJPOAk8sOwlg2ai99lOhQNrY6qPLIiMQzhnASkcGiiGJq9qUAIUSTwZdBiYGTbIa7D67G4Sfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPxgFeJY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPxgFeJY"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48371bb515eso2631855e9.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 19:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770953864; x=1771558664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xDNt/Zzqe2QM8rAhpnCYGapE0/IbHgkzT1igj6kHuQ=;
        b=EPxgFeJY6sxQLvJotHdR8lUP1+HQK9+u2N3yosYVHBHaq2snV+2/DrRxg4b5aI11sj
         J9DpQk6yVrOfL6AIrBBs5TCDtlLPHf6pN82Fh2RKOQiw4ixBbYoh6I2hf1napr2hl0FB
         Z1/mGjZlp8PoA/da4Lq8Nm0ABsbme11X+CbPKEqgoQru/Pr0rLXs0ZrEK6leFzX2gg3B
         y+litWwe76Jfuo6Ky0nBfjJS/8EPFwwgq49+nUtVnbwVqzsM5Ce7ig9OrmaWRTKRDbqd
         rXPVgnBtDYjrJ4sbij3Vcb7yehN+M83zpZ86FxHJmNGWpZOnVw0dqPfLxovY7jWQzX6N
         2iKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770953864; x=1771558664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9xDNt/Zzqe2QM8rAhpnCYGapE0/IbHgkzT1igj6kHuQ=;
        b=d3Hb8DTk6ivxvAHAWEasZR6y6f1yMiCp7tnQAw2wGaabsi3kF/oqGYjU7ePH5oYsQp
         XTeCuZUOtup6VL6k7I6lEAHhWuzLdSGvfNmaNt9+a7zMftvpDmApwMxY+9/rgdhoqTxD
         V2GdjLeOTjoEMxl/vhjKZewpbvlLwhfD9Bi0iOk2XEFef0Eim4OgFgdyEw5IUJtLqKbZ
         IC2IRDuSxK27QomAxHCbYAJHmOcizTUse8ukYe7CkshpVjbHYnTS8MS0n4ThINBgBT7m
         w3yi0zK20eK1p5FIto7w3TNPDJGV4T+20rgRyz4KtKcldtOVllMPfwzGgQUBfDvk7ZSC
         H2Rw==
X-Gm-Message-State: AOJu0YxzXNbtIhBpVUMJBofA7cHfp8phho2gaE/EgE6p8b5zqOJno9oq
	aTvvCWh+0HI1ujfUNWYHc2osPQ0iBDeNJzG+wOdv8j6+fbf5zfFin2dBIzhvUA==
X-Gm-Gg: AZuq6aL3KTVkqfvQmgD6ZfR2S2udmfqKMCrTIBiaRHyzlruSw8rWeYXZii7NDnQcmME
	yNISXU9WV3q1SZss500zlE8FEg1uQPru1+74hzRYA6i59Awqlu7Tpu6NzedjdJfGWHQbEmK1BHo
	0qk74W+vRo3VdknnNK1v5DrrpWXcjlzT+V46b1Jl0/KIJw/1a31z9GAJrCYMsu+PnGu/0lN0Nnj
	5F8BtYx1g1K6o8BxgB5pq1vGVVIY3NPW/o9idEN1vhhQL+tbLdXcsEbN4rHjM/U8+RU1fWiLePr
	HO648Ysait/EgCLRE+lJ3c7rx6EQ9mlAL7mg/8N401FIIpDaldBr0xNGG6cxNQJfhgEybhHMasL
	XHFIwcTqA36n5xnoYIpioLjSueNbSr7lD369jcdb7hLgj0saajgg3dgVh0iLeoCzjWdEeIAF01H
	06RJTgRhZaVcl8hki7/aGGkQ/YGxqYXZHHUZiN/oYWJEjDZQtTf5vtUREwF9JjMMPBXkfoN/MyV
	AW2TQo=
X-Received: by 2002:a05:600c:3d96:b0:480:f27c:6335 with SMTP id 5b1f17b1804b1-48373a66552mr4899245e9.25.1770953863554;
        Thu, 12 Feb 2026 19:37:43 -0800 (PST)
Received: from localhost.localdomain ([115.98.235.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d7e50casm226933515e9.8.2026.02.12.19.37.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Feb 2026 19:37:43 -0800 (PST)
From: Amisha Chhajed <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	stolee@gmail.com,
	peff@peff.net,
	avarab@gmail.com,
	amishhhaaaa@gmail.com,
	Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>
Subject: [PATCH v2 1/2] sparse-checkout: use string_list_sort_u
Date: Fri, 13 Feb 2026 09:07:28 +0530
Message-ID: <20260213033729.50208-1-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212041017.91370-1-amishhhaaaa@gmail.com>
References: <20260212041017.91370-1-amishhhaaaa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>

sparse_checkout_list() uses string_list_sort and
string_list_remove_duplicates instead of string_list_sort_u.

use string_list_sort_u at that place.

Signed-off-by: Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>
---
 builtin/sparse-checkout.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index cccf630331..34e965bfa6 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -94,8 +94,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
 			string_list_append(&sl, pe->pattern + 1);
 		}
 
-		string_list_sort(&sl);
-		string_list_remove_duplicates(&sl, 0);
+		string_list_sort_u(&sl, 0);
 
 		for (i = 0; i < sl.nr; i++) {
 			quote_c_style(sl.items[i].string, NULL, stdout, 0);
-- 
2.52.0

