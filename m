Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD341803A
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958663; cv=none; b=FW9fuTqPWLtUO4sBywecjx7pZ+uRV/VVjDPirfPxf/yGACAClYBSp/4Y/6FlmXDqJ1Basf6wtcLBN3OgSVmIDtaSczJMUneQkler2DJECkPQuonphBOb4jUYShURXvgfBwSZHViExuO5dQiA6mtbeo03eer2WfdLYR/J4trtF98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958663; c=relaxed/simple;
	bh=qsYnqXwjxFjNfNwEdrkzSO/piUuRMHat11xsmBQNsr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9bk79tb/hGgVTNC8Pd5ZxAnj/cDz4HLmHqILV2mvtP76DMni4jeW3stZ5r9Zl91fEdbneLM74Rwc4FlNWVHIeKKIchZ75jFSUmQgOuerGDQFeG8XqDuU6a/BZHW0mI+MHc0MCgposVeuPvjS2GFKatYdDirWAf5wD8Qx7p/1uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TJc8YVMP; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TJc8YVMP"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-66a048806e6so8491077b3.3
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 08:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722958661; x=1723563461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qXwVg+Rh+XXZCGzotaQzx5Q3ZfXbxqhxV7KNyAmkvuI=;
        b=TJc8YVMPGRTb5WBQHw6Am20mVf4L+54+O/X8SHBbLvlaAOxWYFnPNtloTpHjC7P81q
         CvKYUKb3P/oZttc5iRpPJi7rZLGSe4VM8VO+PqySeVoD4f0BMsz0IF5WztiEAnGi6SAp
         ODzKfHWOyRiEP97Uv2Q0FHOH58G0wiX8usqeqbWxASXitqdx+VLvz3Dly/E6ryoLE0Rh
         rOpOKme6f3RLNaz3HpYMRZmVYyyqviT5lAWkc0Ed+0t/RAGo1y+c8ixv+XKA02Clo2fA
         DomaCQV4CHnU9mqezYaLIY/2jaOyuxrbI1AsVXnqedoTbDZQXTCgj0Jw6lEQlQMHueZO
         LrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958661; x=1723563461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXwVg+Rh+XXZCGzotaQzx5Q3ZfXbxqhxV7KNyAmkvuI=;
        b=ZamVhRsgum+cC7r8+fiCFpyjiC/Qu7tQH2bg9ei9piJP+HNUD07Ga+tq/jMW8UMXMq
         aPZw80gWeIeHgTdRJS3bZ8wVx9V5r/+IK9ZbO7GI/T+utzhs1PCpbI64f0zQ+uvVaaFQ
         C7l2Imcb3z6o9X27SEw50hyiBH4uXKpNN7Xd5lfG81hgGxEstQ/ogZ4bArM7nvQwSjbj
         e9AbD2He9hMJ8jqVkk/Bb5NAow0czgGTAnDX4u+mOwJA3W6hZj6Vp0OR2loVIT6ScQLa
         33O+Pwj+Z3cBkaz/G4wJNz6qqDdenGPUaL5WLbXkMMiy5DApaCG7ugE/GhtHSvXSXVqq
         xTTg==
X-Gm-Message-State: AOJu0YwBEbfP+xn4NqeysFp8LMju8367SirFwVVZ8rN8o5Z40xoWxo0M
	ZSv1r8hiNe9wu0m5cDQ+l9Mo7gEahfZyDlyftnU0BGnz9OqhfatDzYHXOQkcZYyGvlI3XVtL2Sj
	e
X-Google-Smtp-Source: AGHT+IE/gkeCnsJqGFoctH1O3JaradulARg3f3BbrXWnFBDS8orVwYlXAE2lriqyKxveSTRF93XnJw==
X-Received: by 2002:a81:c213:0:b0:65f:ca0b:451c with SMTP id 00721157ae682-6896122b7famr172390287b3.21.1722958661321;
        Tue, 06 Aug 2024 08:37:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a0fdb3b9fsm15959077b3.53.2024.08.06.08.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:37:40 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:37:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 10/19] midx: teach `fill_midx_entry()` about incremental
 MIDXs
Message-ID: <8366456d29b870533b5a788a372375b11103b8c7.1722958596.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1722958595.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1722958595.git.me@ttaylorr.com>

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
index 346e58dec7..5e4e6f9b65 100644
--- a/midx.c
+++ b/midx.c
@@ -407,14 +407,12 @@ int fill_midx_entry(struct repository *r,
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
2.46.0.46.g406f326d27.dirty

