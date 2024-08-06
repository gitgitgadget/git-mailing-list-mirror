Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE8917BD9
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958606; cv=none; b=FXeVLwnuuZTc7WRLm9l9RgRkPDT+56w5woN1L1tvJvrv5J6MTBqI5J3t64pkkMNNJ3LdfyeR03Blbah9laDH0yHXIGYk1rr/xkR2mEGm9rqPmTX608KRiK8JvSn6tACu5rXEtznif8b+/+GJ5kSm6++UT81pytpmHYZLhVHczqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958606; c=relaxed/simple;
	bh=+8q1ugDEV/tnnBF090tg6c121DuKfoi7HlXYjvqI11s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1Qi+BvOfDlVaoaPXaBQHYeZn5UOxz/FpcY6GxeW1y8KeSPjIFBqwx9iDDxwRvFv8vVMiCq+P/bP1xYfGTaGPrETBkWFgzkKYD+Oeg/EZnTuIegieaSDxUvHJf5NvZCs2vtscYg5/fa+IqQsFYErGZlNOCNhL41uhIFavmKaWRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=NxbY4wQZ; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="NxbY4wQZ"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6510c0c8e29so8133857b3.0
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 08:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722958603; x=1723563403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+BYfeeuZWteNS4zNSvLlmmyY5kI6hua9LVyJMTOfSYg=;
        b=NxbY4wQZoC3WR1Qo2sUI4tE69t7m6dNWZk88rmh/PJnO9mdqk5eQ4jrAMHkxGAtpI+
         b2ns5cJ9T6q8ZimOS5yGz8lVo42XGyWvLYRARuG4gvIK01xe/5ESquOhhztCgp/1ZzIC
         QblztpNPsurKTCAByByZss/Jike1Qor/KkGx1jbnuzZ4fLYbCwsVrBXtuvSBA+CVjg7L
         /2soGrFBkIMSO2JLGLTbr9qUio/B+u2UZn3ATj8Ty3KEUTBRzdzfiqJxSGqs8gJp0w8w
         ACZx6niEvE4eTrB+ZR0R729vfuBNpiDjH8EygZs+fQKNDHEMT8IlPQuWVtWUjMpGrr8O
         z9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958603; x=1723563403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BYfeeuZWteNS4zNSvLlmmyY5kI6hua9LVyJMTOfSYg=;
        b=B6+rt+57cR29MLdJaMLulpGr1VPlo8cueYkp2heB8aLYiG4g6V+LIdrIqQVLc1Z/fN
         g4o8bXmJUQakSnqAmwoyCqpiMKDtqMTS463jtNdwsCcM04WFukOal94oQQPyi2sUQjoA
         D1XYRmFA2lLpvmsWLo+COqERHESU1C8f0eD3W8mw+LBSIN1aQB+z9FfqnotPk5doJ0Tc
         NJgojPEN6QNc0iFNzKBFY/dPETRFx4AROUmexCfnpHbqrmYGwOS9Z200UHD/qxdMXpCD
         6GPlM5ssgA+FZbLmdL6T3AD4kHhmq9i+nr3wF47b4e0isZ6jSRYCGPjvScWH9lPbklWg
         kXvQ==
X-Gm-Message-State: AOJu0Yz4WDUmKdhmniZwyl7I750m3/YXg+U8WrcIBFMlDh+wUT/J86Fj
	Ru2irWbLpikynde4ci1xYUHD97N4GLpN4lW4Feh/kr8KM/2jBu1BpN6M4ZbN7DoTIH6YRrlBEr7
	n
X-Google-Smtp-Source: AGHT+IHut5q1Bc+j/056RMaTrZrsDSFB+nMNYnI15wO6oqN9yPluZ6YUH/vxZNokUO5hvPLO3hJLZw==
X-Received: by 2002:a81:5b02:0:b0:62c:f82b:553f with SMTP id 00721157ae682-68963706da8mr160537397b3.31.1722958602972;
        Tue, 06 Aug 2024 08:36:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a12d138e1sm15738147b3.87.2024.08.06.08.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:36:42 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:36:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 01/19] Documentation: describe incremental MIDX format
Message-ID: <90b21b11ed7ba11e58a3bfda2c70672f0d7fa16d.1722958596.git.me@ttaylorr.com>
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

Prepare to implement incremental multi-pack indexes (MIDXs) over the
next several commits by first describing the relevant prerequisites
(like a new chunk in the MIDX format, the directory structure for
incremental MIDXs, etc.)

The format is described in detail in the patch contents below, but the
high-level description is as follows.

Incremental MIDXs live in $GIT_DIR/objects/pack/multi-pack-index.d, and
each `*.midx` within that directory has a single "parent" MIDX, which is
the MIDX layer immediately before it in the MIDX chain. The chain order
resides in a file 'multi-pack-index-chain' in the same directory.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/technical/multi-pack-index.txt | 103 +++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
index f2221d2b44..cc063b30be 100644
--- a/Documentation/technical/multi-pack-index.txt
+++ b/Documentation/technical/multi-pack-index.txt
@@ -61,6 +61,109 @@ Design Details
 - The MIDX file format uses a chunk-based approach (similar to the
   commit-graph file) that allows optional data to be added.
 
+Incremental multi-pack indexes
+------------------------------
+
+As repositories grow in size, it becomes more expensive to write a
+multi-pack index (MIDX) that includes all packfiles. To accommodate
+this, the "incremental multi-pack indexes" feature allows for combining
+a "chain" of multi-pack indexes.
+
+Each individual component of the chain need only contain a small number
+of packfiles. Appending to the chain does not invalidate earlier parts
+of the chain, so repositories can control how much time is spent
+updating the MIDX chain by determining the number of packs in each layer
+of the MIDX chain.
+
+=== Design state
+
+At present, the incremental multi-pack indexes feature is missing two
+important components:
+
+  - The ability to rewrite earlier portions of the MIDX chain (i.e., to
+    "compact" some collection of adjacent MIDX layers into a single
+    MIDX). At present the only supported way of shrinking a MIDX chain
+    is to rewrite the entire chain from scratch without the `--split`
+    flag.
++
+There are no fundamental limitations that stand in the way of being able
+to implement this feature. It is omitted from the initial implementation
+in order to reduce the complexity, but will be added later.
+
+  - Support for reachability bitmaps. The classic single MIDX
+    implementation does support reachability bitmaps (see the section
+    titled "multi-pack-index reverse indexes" in
+    linkgit:gitformat-pack[5] for more details).
++
+As above, there are no fundamental limitations that stand in the way of
+extending the incremental MIDX format to support reachability bitmaps.
+The design below specifically takes this into account, and support for
+reachability bitmaps will be added in a future patch series. It is
+omitted from the current implementation for the same reason as above.
++
+In brief, to support reachability bitmaps with the incremental MIDX
+feature, the concept of the pseudo-pack order is extended across each
+layer of the incremental MIDX chain to form a concatenated pseudo-pack
+order. This concatenation takes place in the same order as the chain
+itself (in other words, the concatenated pseudo-pack order for a chain
+`{$H1, $H2, $H3}` would be the pseudo-pack order for `$H1`, followed by
+the pseudo-pack order for `$H2`, followed by the pseudo-pack order for
+`$H3`).
++
+The layout will then be extended so that each layer of the incremental
+MIDX chain can write a `*.bitmap`. The objects in each layer's bitmap
+are offset by the number of objects in the previous layers of the chain.
+
+=== File layout
+
+Instead of storing a single `multi-pack-index` file (with an optional
+`.rev` and `.bitmap` extension) in `$GIT_DIR/objects/pack`, incremental
+MIDXs are stored in the following layout:
+
+----
+$GIT_DIR/objects/pack/multi-pack-index.d/
+$GIT_DIR/objects/pack/multi-pack-index.d/multi-pack-index-chain
+$GIT_DIR/objects/pack/multi-pack-index.d/multi-pack-index-$H1.midx
+$GIT_DIR/objects/pack/multi-pack-index.d/multi-pack-index-$H2.midx
+$GIT_DIR/objects/pack/multi-pack-index.d/multi-pack-index-$H3.midx
+----
+
+The `multi-pack-index-chain` file contains a list of the incremental
+MIDX files in the chain, in order. The above example shows a chain whose
+`multi-pack-index-chain` file would contain the following lines:
+
+----
+$H1
+$H2
+$H3
+----
+
+The `multi-pack-index-$H1.midx` file contains the first layer of the
+multi-pack-index chain. The `multi-pack-index-$H2.midx` file contains
+the second layer of the chain, and so on.
+
+When both an incremental- and non-incremental MIDX are present, the
+non-incremental MIDX is always read first.
+
+=== Object positions for incremental MIDXs
+
+In the original multi-pack-index design, we refer to objects via their
+lexicographic position (by object IDs) within the repository's singular
+multi-pack-index. In the incremental multi-pack-index design, we refer
+to objects via their index into a concatenated lexicographic ordering
+among each component in the MIDX chain.
+
+If `objects_nr()` is a function that returns the number of objects in a
+given MIDX layer, then the index of an object at lexicographic position
+`i` within, say, $H3 is defined as:
+
+----
+objects_nr($H2) + objects_nr($H1) + i
+----
+
+(in the C implementation, this is often computed as `i +
+m->num_objects_in_base`).
+
 Future Work
 -----------
 
-- 
2.46.0.46.g406f326d27.dirty

