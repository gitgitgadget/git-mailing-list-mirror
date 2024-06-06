Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BE513A3F1
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715070; cv=none; b=N8pTwCINqZ0PWXWpwin/jDm2lDfE0z6/d/qXAWvd0v3SnaiF8cVc9UrOEy5SqggKe9HEzJNHSCpinH6gTVkwI0BskkQ/XQT+YDcVelWCRxvkoE8DsRdcmnOY3Ug3TqvFI/PANviB3AzlVbS3RVcVPzV4LAxtriqoh+MvS/56N2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715070; c=relaxed/simple;
	bh=wmc1CedVA/kuRiNysYPzAKgToMkFKojZvSYewPyUlyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxKuY8buocaotqtNEQCfnAo+QJ1gUrfyymY/latN2BhJ4DrDdQQPaRXU6n2h80JKVuh0BDos+qxg7hEKii1ubmDXWDOfhOzn/tWBYCCZroC7cwanOSR1ISKvDitidY15l1mZ58V5nf4rrXEpEU9g9r0JEZD9omLqFYMPAqC22Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=eBDWaMiS; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="eBDWaMiS"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44026036ea8so7443571cf.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 16:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717715067; x=1718319867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ms/sbqYvdaFtTktSi0nsCL9HM3ughK0GKElkwM5WjN0=;
        b=eBDWaMiSfFtGzIGCAuoql6+JE/3P4LPUn9VDvkx0//ytDLLtS6UCRLsLZ6bAlvQ2Gf
         Ig2q0q5hJT1JlYiQ0vQr/MbjiDAuDapQIaqYhG5aGZAPmG2Ss9ItJX7qa+FvXrJKyR1F
         K6eR9LVfp8YkuvG+fbE4+IRqrzSpr4KpuOsg2X/StVoDe4nd4Ui7kwc0hPpGRRbmyt7o
         H6tTPW1YnQPDj3kdeAvx8l0iTHd46w1fzEpsKyw02y5B7qCJmHXIRhIr4nxW3VrF/Jrm
         +gv89oQdF4ZPml7nWlT94G0RZW1C+VERh4GVDh9loetxoBAtAuv5+TbdHolP33CwsCP5
         lxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715067; x=1718319867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ms/sbqYvdaFtTktSi0nsCL9HM3ughK0GKElkwM5WjN0=;
        b=DgTfUugkasppKL5PsysLO/xW9/xyxSJ4R5JVr904HVVbc/hDwoFRJyrqano8+ZoO7/
         TkGcfPPei1WaCgjY8xMZ11t5/aqx1gI3CNa/wjXBVYF2m+HOuFCaxh1HTTOdfZ15gpPJ
         epQQjDyDqukGHQ3Jq6zAVKmriMsZpO0mjXRIm7+fveQPMRKiFghjIMyUk9Qgpltz5vI+
         4TnWw2UuErGt9fOw1J8+034E36eFHqmchXmE1jCpBQfxKUvlE9muS9opSSyGrTG/o1UZ
         MuXHQDzwYe6FfYcLiXFimATHXkii44HBx8Qxa74zn0EVz7ToJSO6qwZhK1c2ZvEgY8yM
         kNYg==
X-Gm-Message-State: AOJu0Yxng4m5yoLAGoDRUdfde21xyZx+t46OG8j/x0B56cG7ZRBD+ZPh
	4hEsiX888tzmxuWWCSXnsMO2REHJ3cvnMNL2cUP8s58g3fgWt6f/gh9tH4cxvr5buavTclfvKP0
	MFVA=
X-Google-Smtp-Source: AGHT+IFrTNCktzRabGmGJXqnWilfVMehkKHxcEJvyo52wxTzlkKu0sc/VluAv07ItWFgYVFnGirCLQ==
X-Received: by 2002:a05:622a:107:b0:43e:391a:1a20 with SMTP id d75a77b69052e-44041c544b1mr13684361cf.15.1717715067067;
        Thu, 06 Jun 2024 16:04:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7953287548esm102847485a.64.2024.06.06.16.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:04:26 -0700 (PDT)
Date: Thu, 6 Jun 2024 19:04:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/19] Documentation: describe incremental MIDX format
Message-ID: <d3aaf18b0a8a17c16d111d93042af52268800989.1717715060.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717715060.git.me@ttaylorr.com>

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
2.45.2.437.gecb9450a0e

