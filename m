Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F9E180A63
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 21:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250750; cv=none; b=uuK1puIqGOC7kaaBq3CguWmcL7vrq5OXfUCVYaeEX51xAijkTX2URbnKo41iWtGMKjFrWn6wIsS3wIxbfXlBriKf8Iduch5maVQDvg03J8p+qdTu3jMrBVdgXGns8V/agyPREJv7qcVFVllbBdap2HfglvCj8rSlrTL4KE+jWXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250750; c=relaxed/simple;
	bh=/tHMJPmK6xpqPyULfzyADIx0MY37StOQKNC4IV283bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlL61fC+ggkeO7yoikGN43sX24Eh30H+NrEV3EToX6rjcX240HktwulPoVgEoorkheYgckLx1GecxrqwX762jar6itoVtqUBzqSNgyWsZQxCUIuZPi4qL8UP6CZHMoojbE98V2bldv2bPHVthKf8FfBClJq3jhl2mTsC8nexIt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=UZNSauJg; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="UZNSauJg"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-661369ff30aso618077b3.2
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721250747; x=1721855547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MiMFM/estUwkAhNM3IuW0HwUUZc7GFqkIj+rnivbj4A=;
        b=UZNSauJgLo08dTmFq2zdtiak6sOiA5Z5+3w6IrmfxAt5EHG3GXkRnZcsaWkOhVR13W
         vtwP/XgpuE7fyH0/U+On1zrNdsxjSrmexEQizO75iIOtSuK9wRoOZb1cELU4jLW4Bgei
         IVM+xZVDZnniuv7PVVrKHFB/0l3JjLMFaaNWp8APKE/BW+Dl6fDBIZAFE12MLAEgfAHJ
         +mt2Wmgoxt5uxYetSa2W+EXUZrTnsz3UJeYu+kDqUmhq/yQiahyzQsT+vFG49vJsio1N
         HbHn7Mpwqf27XlZS118xeov/r06FnLR+A4/QcSMBsTdoBztT0IYimXdp6daRvGa6OpOR
         gTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250747; x=1721855547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiMFM/estUwkAhNM3IuW0HwUUZc7GFqkIj+rnivbj4A=;
        b=bpUJ/EEiHIi3qzmMCl6j9jSmlcoo/ZnTcdCISbxu4YLZ8wHdKGHpsd/Cs7Pl5upWph
         usvfoGyssfWJRp+F2jDzgAEGdrVX6cOjh9ml5rZgwiO+6PBkYB7dWoctziKacdKjdSyr
         C4p1sNjnz7cJixN607ffCcFyWCWA8WB9pc5laUg5Io+G4Kg5nQ12sVfIZA2Kb7Di+9uM
         yHVjkXCDFSd135qWaKMc+Pg1v4I0DuU6wieZ2/t9Y6rDdLs9BdY7sy3b+lv03oybT3k8
         nZjB5OICagegGOx5h5MwYqAhSaNeQ1FPMHQOW2iqsCcPacDlOkC2wjA5I7FOejNmaUhe
         eFbA==
X-Gm-Message-State: AOJu0Yz0TY3MnJSCoPh+1PjGgwHO+nu2co0/7e+ieZMvr4p9VgVAkOcw
	AIvamlmO/+kcZ9UGHxdks+yfkI8Eww2VLlmczuOEh4Txvy0dpLAkmnLDwLA4EBVXO4n81lB3vQL
	s
X-Google-Smtp-Source: AGHT+IE0ZLOqamqbn08movONf9Oe4thegCBtSBxNvoLaFAM9Yix5a92Z5dSs5QnnCthWi8x3BZfVKg==
X-Received: by 2002:a05:690c:2c93:b0:64b:9f5f:67b2 with SMTP id 00721157ae682-66603510ff7mr7178347b3.31.1721250747458;
        Wed, 17 Jul 2024 14:12:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-666042bea3csm747937b3.136.2024.07.17.14.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:12:27 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:12:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/19] midx: teach `fill_midx_entry()` about incremental
 MIDXs
Message-ID: <2b335c45ae7832b886ef9adccc2530e4ca53d267.1721250704.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1721250704.git.me@ttaylorr.com>

In a similar fashion as previous commits, teach the `fill_midx_entry()`
function to work in a incremental MIDX-aware fashion.

This function, unlike others which accept an index into either the
lexical order of objects or packs, takes in an object_id, and attempts
to fill a caller-provided 'struct pack_entry' with the remaining pieces
of information about that object from the MIDX.

The function uses `bsearch_midx()` which fills out the frame-local 'pos'
variable, recording the given object_id's lexical position within the
MIDX chain, if found (if no matching object ID was found, we'll return
immediately without filling out the `pack_entry` structure).

Once given that position, we jump back through the `->base_midx` pointer
to ensure that our `m` points at the MIDX layer which contains the given
object_id (and not an ancestor or descendant of it in the chain). Note
that we can drop the bounds check "if (pos >= m->num_objects)" because
`midx_for_object()` performs this check for us.

After that point, we only need to make two special considerations within
this function:

  - First, the pack_int_id returned to us by `nth_midxed_pack_int_id()`
    is a position in the concatenated lexical order of packs, so we must
    ensure that we subtract `m->num_packs_in_base` before accessing the
    MIDX-local `packs` array.

  - Second, we must avoid translating the `pos` back to a MIDX-local
    index, since we use it as an argument to `nth_midxed_offset()` which
    expects a position relative to the concatenated lexical order of
    objects.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/midx.c b/midx.c
index f87df6bede..dea78474a2 100644
--- a/midx.c
+++ b/midx.c
@@ -406,14 +406,12 @@ int fill_midx_entry(struct repository *r,
 	if (!bsearch_midx(oid, m, &pos))
 		return 0;
 
-	if (pos >= m->num_objects)
-		return 0;
-
+	midx_for_object(&m, pos);
 	pack_int_id = nth_midxed_pack_int_id(m, pos);
 
 	if (prepare_midx_pack(r, m, pack_int_id))
 		return 0;
-	p = m->packs[pack_int_id];
+	p = m->packs[pack_int_id - m->num_packs_in_base];
 
 	/*
 	* We are about to tell the caller where they can locate the
-- 
2.46.0.rc0.94.g9b2aff57b3

