Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E068239099
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734058; cv=none; b=sMfEsxwyUbjrQilLd2MlrXPAcJe4lOkI7loT1SrJSZihBtRUgSzc9x7fPKlcatIucFvxdy6pfnYdI8SP5LPxqVYve4pFqz/jyAGM2W8DKk4wzFTYslQ9P8xUJ2hUY6TI4j/+X63F/AyfpA/p2I92zO+lK1jEtcBIVtrvSbC5HVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734058; c=relaxed/simple;
	bh=p+RO/nnBXFJi+Gp//slP6nYd+FLaz27MXx235tFWke4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WGp6cssW77P2ZiPZNYRYDRRHPavLZoDQZzExK1KJL/72tEkTFYWUIou30NhBcUWwe2qBelGXx5ItUF4Jts+6nNmuNPe1Ojkb3Orf5C2hFVjTUkKwBBYEilplFAchy7C5LrWdNhvHMYFNRyvP4Vis+qwgaEaAnraJF+Ue/dHM2fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZ/XwjmW; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZ/XwjmW"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0c571f137so926767066b.0
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 13:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753734054; x=1754338854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ey4RZRvdEGIbK5OLJViGNXbsgkIXKX/stwgaWH/MWY=;
        b=JZ/XwjmW5hyzXOt3jRQCvvpeg3aga2/jC1GSNuivXKhCOsfwtPvxZeIK9evPoFuqPo
         htWXKbG+bpU29EvxXWY+quIrox+rd9BU3HJoMeS6zMcYdeJKfTd5SDRIEfkfVwW8W16W
         li2kcO5MV0WHyugZQBFOgM7rxsRxG5RSeCbTurjpiNWIOn8E6FSbl9Khjcfrg0zoyO4n
         NJF9jAM83Pw83ZIRy2CInQaQvw6RYATN5sWBX3p4eIpQM/DvkUDQsN9zT1bBLlV71jaS
         KJCtyqFgr57EsgL1KDkO5tAvIU54uR5PQ20TagtRVY5UGv9FaX48qD/iQHI2LAmFw4W0
         GUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734054; x=1754338854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ey4RZRvdEGIbK5OLJViGNXbsgkIXKX/stwgaWH/MWY=;
        b=H0C1Xf8VLWqCKKBam5WtURBuxJLr6qX/OLgUUUJWO1XqrO5yMkF0WokY/Xy0R6kB/5
         xb9o98yer64uce3v4juWfKAATGQ1u1XzpCaTBkDxrECjLAlp/yrNfE/DRouafA4oiB6p
         nBGrxRSj/roSKAS2FFYzLi0n6VJlPLrTRkoYwuS8+zydOwh3wWUCqg4ZI42NRZo1iMJT
         yPfNjpVXEZWMy82k5TSzweyGOASGVYaZPeBfS+2Eo2VClY31XT2T5/K1S81UBo0SxHIl
         Ldz9ZA2e2gFfkI7HxQFUazlHu2OfSS1juoScLK8YaEcL82xwxHcc4qr+E0XhQrXMpo3G
         HSgQ==
X-Gm-Message-State: AOJu0Yxz40ZK9W3STUDaS998Yq19qdHdoklFNyQaS3Tc8MxQ8kYRobvC
	cfGEvyQX3ENPiKOYN4GOcLeaEoZxk2YlXQ0FmrVnrqcCGhulTYDhuvw3pzUjOJ4Q
X-Gm-Gg: ASbGncuNkcljGqzLXM/ZqAmh6bKiQELhKpgSEwzmMKj2ed9IGcf63LlrBePQEBUCEnA
	K9W9iZ2n5yPQ6qXbvOkcf6HnHQlFNG0uyOyRw8qwTdjyaC2syEKnpoH11ODx6k4Daz5W/p6x4Dr
	3GqG+3Ejy+kuDVvn7epNHBNxzd0T8ucMLG5vS3CCb3uOiSKRgU4rbhfTfF+fuN4WQBtfHd8fN/u
	heNgZ1uhcEWjEucqkguXE9KhCAig0rLWHXlhwyWsmotSSe0yejuFzcCvqvOcSiSCLL3LxMnPKob
	EH1iHicKELBzmwRxiguB1C70I79igP8y8f4LMGhB31iabl6JLaYj1JqrhKzaW22J/KerZ2k201T
	sstEzHhomLNCUG1M3tbiLtC0ivFZf
X-Google-Smtp-Source: AGHT+IF3J68uVq8kMBs4hGN3aKsk7rWirfMtqRgE6/D8QAneuc+P5jjVeqCJv2LO2RiV1oqyMDifpQ==
X-Received: by 2002:a17:907:961a:b0:ae6:c23f:3cf with SMTP id a640c23a62f3a-af617505eb1mr1523522166b.16.1753734054189;
        Mon, 28 Jul 2025 13:20:54 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:9706:c2d9:b21a:2042])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a62ab9sm475376266b.86.2025.07.28.13.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:20:53 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 28 Jul 2025 22:20:48 +0200
Subject: [PATCH v2 3/5] for-each-ref: reword the documentation for
 '--start-after'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-kn-small-cleanups-v2-3-d3021c8bf471@gmail.com>
References: <20250728-kn-small-cleanups-v2-0-d3021c8bf471@gmail.com>
In-Reply-To: <20250728-kn-small-cleanups-v2-0-d3021c8bf471@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2068; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=p+RO/nnBXFJi+Gp//slP6nYd+FLaz27MXx235tFWke4=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGiH26LgWTQvj7bSdYBjywLM9rsOStQlsvXw5
 FX17JNMoz6ySokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoh9uiAAoJED7VnySO
 Rox/IBQL/R8JTeKaujlvY6H88Yj3TL1yPs7+KiTOQgCvZ+iZbBJOwiKRQFCS+/jv344SKlCkBKg
 D08wQxMJ1os3P0FzMTlsnDguWHJOW4yBUeRe0bSR/95I43x8sjc3BwLASxNT5uRsOtvrXlUCM0T
 HRuqEqs6JRdRfKE0Wl4QrPfX76BJDGw+6v9MDzAeTRyFG5Edk9xBDDVbcO/KrVPvG0B+YMvQWHE
 ailpF1VMhoqi/G1BNg+FWDeS+PskurXeckk8pFl0ijtXj5qM6h4Rtip+BcTdBhfebFKxLhVQLw/
 6Z2S77JYjRQplrSvK07q0tsgGhQb+DAMXtCx4HK8jxfgFIni4yi1cW9sL8sjf6SD5FI2yf0h/tK
 pL3EYVW9jAaVH5nsy8diSXR649Ijx30g8dTurRXFVelJ3KCNOGjcv7oF/CnIdQcNi704tAxjWbO
 hugotGfjAq2X75jwO/4+ISlBpjOYh3ITMfUvI0y02Sz9rqQyoegKoJk1aeS9E+wFSy05wVrtO+7
 BI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The documentation for '--start-after' states that the flag cannot be
used with general pattern matching. This is a bit vague, since there is
no clear understanding about what 'general' means here. Rewrite the
sentence to be more specific.

While here, fix a typo in the 'OPT_STRING'.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.adoc | 3 ++-
 builtin/for-each-ref.c              | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
index ec3b10e14a..060940904d 100644
--- a/Documentation/git-for-each-ref.adoc
+++ b/Documentation/git-for-each-ref.adoc
@@ -114,7 +114,8 @@ TAB %(refname)`.
     deleted, modified or added between invocations. Output will only yield those
     references which follow the marker lexicographically. Output begins from the
     first reference that would come after the marker alphabetically. Cannot be
-    used with general pattern matching or custom sort options.
+    used with `--sort=<key>` or `--stdin` options, or the _<pattern>_ argument(s)
+    to limit the refs.
 
 FIELD NAMES
 -----------
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 3f21598046..79a79212c9 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -45,7 +45,7 @@ int cmd_for_each_ref(int argc,
 		OPT_GROUP(""),
 		OPT_INTEGER( 0 , "count", &format.array_opts.max_count, N_("show only <n> matched refs")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
-		OPT_STRING(  0 , "start-after", &filter.start_after, N_("start-start"), N_("start iteration after the provided marker")),
+		OPT_STRING(  0 , "start-after", &filter.start_after, N_("start-after"), N_("start iteration after the provided marker")),
 		OPT__COLOR(&format.use_color, N_("respect format colors")),
 		OPT_REF_FILTER_EXCLUDE(&filter),
 		OPT_REF_SORT(&sorting_options),

-- 
2.50.0

