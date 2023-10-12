Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3DB3E473
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="n1kU9SS/"
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A314E1
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 14:09:34 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7c93507d5so16899597b3.2
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 14:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697144973; x=1697749773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcLh9qbfjxTXEYzJQLtfphbDYwtd321Gp2hF8Gr1cMg=;
        b=n1kU9SS/BLxfJQ0zYJ8mh6DiS2OxnGrJo38rlTEJzlD9kh7wTJm8JF6GD11/ILMFGr
         5XURTDF9qdfWQFwNYPCzfrnj3ik+X/33q9E0YRJf2pEiNuETS3WufGP0Vm5SUG+H5dxc
         exnUJewwNGhgKFD0/cp4XozJgPq/nGZVyOoFaRGcvOdSOgVErCUkkaNMuaz6yRt172dJ
         Sbqa2ZrCCl68aITkeGjawSjtt34SEdOVQnFruJJo4pmuiU5m/tODyNbD4F7LKCKznFPx
         aKJ26xlPXqcINw2XnJTH6uMhgDPYENlP/dHqgHXbbwUi+Mk2YXUA//rtG6gsS9BYdZZ2
         DJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697144973; x=1697749773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcLh9qbfjxTXEYzJQLtfphbDYwtd321Gp2hF8Gr1cMg=;
        b=AIb0gO8ffsgZ4owUrQvcdqAsiH5T/uyCz1e/H9JHbM//VMUnNDe5OQs/NtK0rVk/zn
         /K71ZyYO+3AP19B/qeDOSkURwjkUJalb+f7YTY6wxm5SgvFTdAUEUfN5b2L8L5/35UKK
         s8To29hVKNBJvgRJ+/SCOcUjWgiJNm5Iq6ueb3uglVXU4phxNqjGrRFDuhctcbjPVhnq
         94y41eZzTmLD2YJHIJd0G715Dbbfl9hAkbG0RrTdx+wipE1m+CPW38Y68nB9elA2OfrX
         91mFPMYRZsRS+7x8oBQ9McxaHgPG5ROqxLCRj+6m708wH97IOxU7Z+Pl+3hIkRlyb7uk
         2LXw==
X-Gm-Message-State: AOJu0YyIz2qiPSIHvhqHuoaOvUfQhxQ71HDOxIiAEBM/lbfEjAetj7Ud
	AsyzVGhtBx4EpjgeEi1+dr4EG5AX+FFBJtx5ibsv9w==
X-Google-Smtp-Source: AGHT+IHyyorpLaBFED0awuhNF3K9YiP6iIt4LiimAM8TLhxFpxfcawqSEmXTFKKGP0rnhcXJWqFAdA==
X-Received: by 2002:a25:b34c:0:b0:d9a:5666:7ab5 with SMTP id k12-20020a25b34c000000b00d9a56667ab5mr9029411ybg.10.1697144973082;
        Thu, 12 Oct 2023 14:09:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m15-20020ae9e70f000000b007671b599cf5sm94231qka.40.2023.10.12.14.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 14:09:32 -0700 (PDT)
Date: Thu, 12 Oct 2023 17:09:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 2/2] Documentation/gitformat-pack.txt: fix incorrect MIDX
 documentation
Message-ID: <af2742e05dff48c4ba0a9f36d58bcbfc052dca40.1697144959.git.me@ttaylorr.com>
References: <cover.1697144959.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697144959.git.me@ttaylorr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Back in 32f3c541e3 (multi-pack-index: write pack names in chunk, 2018-07-12)
the MIDX's "Packfile Names" (or "PNAM", for short) chunk was described
as containing an array of string entries. e0d1bcf825 notes that this is
the only chunk in the MIDX format's specification that is not guaranteed
to be 4-byte aligned, and so should be placed last.

This isn't quite accurate: the entries within the PNAM chunk are not
guaranteed to be aligned since they are arbitrary strings, but the
chunk itself is aligned since the ending is padded with NUL bytes.

That external padding has always been there since 32f3c541e3 via
midx.c::write_midx_pack_names(), which ended with:

    i = MIDX_CHUNK_ALIGNMENT - (written % MIDX_CHUNK_ALIGNMENT)
    if (i < MIDX_CHUNK_ALIGNMENT) {
      unsigned char padding[MIDX_CHUNK_ALIGNMENT];
      memset(padding, 0, sizeof(padding))
      hashwrite(f, padding, i);
      written += i;
    }

In fact, 32f3c541e3's log message itself describes the chunk in its
first paragraph with:

    Since filenames are not well structured, add padding to keep good
    alignment in later chunks.

So these have always been externally aligned. Correct the corresponding
part of our documentation to reflect that.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/gitformat-pack.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat-pack.txt
index d7153962d4..54000c9412 100644
--- a/Documentation/gitformat-pack.txt
+++ b/Documentation/gitformat-pack.txt
@@ -392,8 +392,9 @@ CHUNK DATA:
 	Packfile Names (ID: {'P', 'N', 'A', 'M'})
 	    Stores the packfile names as concatenated, NUL-terminated strings.
 	    Packfiles must be listed in lexicographic order for fast lookups by
-	    name. This is the only chunk not guaranteed to be a multiple of four
-	    bytes in length, so should be the last chunk for alignment reasons.
+	    name. Individual entries in this chunk are not guarenteed to be
+	    aligned. The chunk is externally padded with zeros to align
+	    remaining chunks.
 
 	OID Fanout (ID: {'O', 'I', 'D', 'F'})
 	    The ith entry, F[i], stores the number of OIDs with first
-- 
2.42.0.349.gf0c1128f8b.dirty
