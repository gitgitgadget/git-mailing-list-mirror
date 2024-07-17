Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A7118757C
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250722; cv=none; b=PKHRo7cyeJDtOLqDlratVZR8lK6eQArNTsFdRuuxFns3M3spSTZIfk2q7usuSso53YKeuRnI/kCqlmtyVMTKa77GwiEhq3Th9NB5UvAZWOfMpb7r3Cr3BCzwsC2flvRgxM5meRY1iRlZa+zuR4T7xli9DhgycymoFqgoe3HKees=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250722; c=relaxed/simple;
	bh=y84aW8EgAuveV+ua5UA+7oj6bQOzKqIUEgy2hYB9/Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OG25b4/LIRvLy5LWxQRCicM2uhwiuw7Kc1yPthDH4v4d7BAshnUGRkwcpgnecx4dK8S+oyz1eMYWiLpx3z1lnWrHYiqRU9/g96ytDsLf7XpXrPRHlrKIpd+2cnnfLSsyrO1sNyvhofvyqZQHo1sQ/e1MFwPU6T1mwIRyPq6sY0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=U0+V88sn; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="U0+V88sn"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-65f852c82fcso902407b3.1
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721250720; x=1721855520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8otJcH7ov+/55pOZCRQmfzGpxZD5P+VPTXQntK3Mgrk=;
        b=U0+V88snjkvEFah5dOE4mk5SMExlrPgYG6+zVpyIlJV+4tqOxzY23ynsx0GjeEFlV8
         xoJXpLlZGy7JWRVlZBzXxCcRgJyZv2xvsDL+deqjHNnUHeZyVvKiSnW+WxNNmKxjbGIf
         OGrt8Ec8BLNyh1mrtZ2iUGiAGu8PP90D+GvGsLnDUQGcLAm60e+rEQOgfyB2pFPxC+tC
         /LRrh6vKdHUAYgtw8lo+YGMjxj8j+Liezw56vNcBGkdJRahZvhe74m7caWfpl2uR6EaY
         jsPdLeelmYXkvEk5Mwk0yVVXY/oAyrmRP//kDcmGOGv2c4oJBpSsxK/Cc8090VzgjJ3c
         H+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250720; x=1721855520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8otJcH7ov+/55pOZCRQmfzGpxZD5P+VPTXQntK3Mgrk=;
        b=dJGJSBa05+anh7cgeRbjVycid8/sMt82P1JDc9cbQR46IBfFmUuhxBZ5TEmiUHF9/I
         jgxk74k1k9J898scLQxzuRohR2b2pH3TqDsWS390vSczy9sOsnjQ1lmTIZUUVOso5giU
         SOdYK6BLzsG+tiNjajOOXyDJUL2xzfDboZRB7R1zy25WU+aFIEh9nhLqBwupcCGnirZB
         eeNH/C+E8YZl+ZqdPFFNfW/OZthQvolHI4ch53y3fyJQcKQm14C/DbuE3X6x89Oqjbvb
         M3iC86CbDHEYVwQZO5qoBpDaXQghAzkIf1w6kkdn9EXx75OJ//k00peRr66fc7/XIIZU
         pYBA==
X-Gm-Message-State: AOJu0YwGHKLcSmTuvctf9be9yoICZgFGIAn9zxhap04URFKXcchpmhh/
	YZdj28uKIwbKfRN/SsDmhl5pIlh5s+trhT1CDEVbakxmQdVufv1CragxgfXgsiyiHMIFlhQBLx4
	e
X-Google-Smtp-Source: AGHT+IFzjLaZG9WI+jrhJY37YITZ0XXOt7+De37HPp/y62UMeuNhBmWeX4qNUnUsadqsRvn7B3jluw==
X-Received: by 2002:a81:c309:0:b0:643:6087:efb8 with SMTP id 00721157ae682-664fd59ef69mr35511397b3.3.1721250719700;
        Wed, 17 Jul 2024 14:11:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-666038fc601sm763547b3.83.2024.07.17.14.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:11:59 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:11:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/19] Documentation: describe incremental MIDX format
Message-ID: <014588b3ecf2e32a6ab1af8e77234dfb2f9ea75a.1721250704.git.me@ttaylorr.com>
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
 Documentation/technical/multi-pack-index.txt | 100 +++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
index f2221d2b44..d05e3d6dd9 100644
--- a/Documentation/technical/multi-pack-index.txt
+++ b/Documentation/technical/multi-pack-index.txt
@@ -61,6 +61,106 @@ Design Details
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
+omitted from this series for the same reason as above.
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
2.46.0.rc0.94.g9b2aff57b3

