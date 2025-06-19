Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC8F28E576
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750375827; cv=none; b=S14COFfKwEjd0wNVe27e7L1h9TfUX9B5lQnRk/ut2poDz8YohNPjQeZ4GNSf00/H1GFpWs24xTTL6wxY8gsBgBWyM5yKKXeaY3SayhtuYYef+zAelryI7H6d41z0LG+i8vkyueNWfbo/bQnyaVaIWIEO1N8y7UXzd4ayqPEA1AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750375827; c=relaxed/simple;
	bh=PbtRjNyDKJ+1M+eonfDd0NVpTwi1oe9SlpTkreJHlrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7Qrsir/LsFR90DlBWyGTEN1HiEzA6Y0TqT6iQ1um8yNOCK1sOSBkpAHUdZRvUd3Xo57A0fAih4UlSt1AZMUYxc404dZLfFHi2zPG9C9+4UNcNCzhoAmnZk8owVZt3OVgviIwRflxUW8NsfC6qjTKUmyuBFzOUi35nxf2/wGSdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=GuZuKg/V; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="GuZuKg/V"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e7b4ba530feso1213000276.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 16:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750375825; x=1750980625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FShvGvKFDy7dBDsIO3QsLYYT5j84Z4OHIE/NrV9cjLc=;
        b=GuZuKg/VFU86GOmxly3vbxuZqC61jHJtGgmc/eWVao6PxVaOUNmPb9UWOSF6emfgQg
         0t+LaW6mUQzPioNpsN2m4ib08ouyx+8z9v3sWnmjX5VcGNxtWNVc6WwQn6P27e3a7pih
         kUSzKjUDN6I3esFqK0BLFw+MDTSgoWZNGQrpDrQHEryVTuBQzzIVD7xm8AuxkB2JkSYR
         Xpo9f7crGpea2ymlDZRF4q2k7X4+/XQy56luGi4C5Qu5Fylx4oUMHhH5CZh5oVdKL/qC
         R3M8BZCTtmHl3o71B7mZVZT43QhxexJ0bn2nKyYma8CjMqeEmRenCxIuPnhDVlXNXM9c
         5ksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750375825; x=1750980625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FShvGvKFDy7dBDsIO3QsLYYT5j84Z4OHIE/NrV9cjLc=;
        b=XpEH+PGAWU+s/NAXUqamLVEZwyCHRGm6Djo0gy3akdLpocMkrPdsrZpDfN7oNOZSHI
         liIMTGtJ18Fsf1xyuWOR0DEaWy1f1ET1CbvhDCQlOyNE7LW3KD+QcHeZl8SHHmnaAWMV
         +McGy0xTAXP++hAsmyFtgP2krSSu5dp72p3G9uBEWzT6biBBMfWIGcEAffPh4bIfgZU3
         EEsiSD99rKyz7sLONajtyPdZe6n0KnucyRH/EGevQytVnaUxkG+BPOxqrtwnFoftnI1U
         ujTLFutlQmUKTniVU4b02SKqxNYUyoSAc9DPrH9qKrjBDchAqZIRN8svgCNoeemkCeno
         FfGQ==
X-Gm-Message-State: AOJu0YyC/0RIv7B9c9sdtLL/sHOQlUU3vlqucLMVeaTt8rhyW1RPGh2q
	ayK0GmeIFmPJWOTFMhwd8UtYLlKgqVKM0FyID4lrz3y0D4zN9iUjnVvbl0x2nMvNrdXQHT4sGgt
	4L3zX
X-Gm-Gg: ASbGncvDDC02gzabC3qCdPLUZsD7VYln29P1Ry4j15zdJw4yyYU+STdcbqv7gQf2jOV
	GU2NMFoZOO2O4OPCJt7Tl12Rlj3r2SwvHID1kgTPl9NgHvxWOcIwtXCdbPWwiwf/7IuECpy89Pc
	lNxSpaDQ/C55oDKDgpnL8PPJnEDrJNWAjdoEYU7a/W8992tsVFxXNql60nxvabBhDnaOHbXTBhR
	yTnTeSf9ki9mU9bIygqwRxAxwNqcuTxSqZLuMfq1lAvzMveP0CJHZpSZiQfaK9ZADyAn5mvBj8H
	CwbQ7SpZ9gH3noQsJIPtaOiHDP7MugAetJapBmWZmcPsEQ3KL7JXbQmhFV8S7UKypxlV/p7VS6o
	pru7+h5yUenpkC684iFzdeKl33uuFj3yl+g==
X-Google-Smtp-Source: AGHT+IFX+R+dcf9ZVFNAxorrkdh9mFcg8XfAGf23gwngkZWZPbflPfb3pg7/C93hnBgySzAfkNKSYQ==
X-Received: by 2002:a05:690c:338a:b0:710:edee:74ea with SMTP id 00721157ae682-712c654c20bmr14556417b3.27.1750375824691;
        Thu, 19 Jun 2025 16:30:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c739b975sm1266247b3.63.2025.06.19.16.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 16:30:24 -0700 (PDT)
Date: Thu, 19 Jun 2025 19:30:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 6/9] pack-objects: fix typo in 'show_object_pack_hint()'
Message-ID: <bcbce75695f45cb64244bb5d5abb40ebfbe2e31d.1750375803.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1750375803.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1750375803.git.me@ttaylorr.com>

Noticed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3437dbd7f1..9580b4ea1a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3767,7 +3767,7 @@ static void show_object_pack_hint(struct object *object, const char *name,
 	 * would typically pick up during a reachability traversal.
 	 *
 	 * Make a best-effort attempt to fill in the ->hash and ->no_try_delta
-	 * here using a now in order to perhaps improve the delta selection
+	 * fields here in order to perhaps improve the delta selection
 	 * process.
 	 */
 	oe->hash = pack_name_hash_fn(name);
-- 
2.50.0.61.gf819b10624.dirty

