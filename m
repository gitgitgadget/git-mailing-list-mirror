Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9202232F
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="aXdURaxE"
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84855DA
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 12:24:13 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-66d17bdabe1so41308636d6.0
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 12:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698780252; x=1699385052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QV3MfU+4pZ9NCMCn3YWPZ/3pv6aBO4+VZTyDwmW4+Ec=;
        b=aXdURaxEtipiVMth1bMJWBlGp1RqOWrsJuikN0uhiAlkhgO/vjhex6mEfZff4eVwxU
         QHacOG0OdPC/2zPrvZUsPZMbtubw4fibY5GHjIcrrGYOrlkh9peTG3zDtENWMFRS3OmE
         TsOm1KY4w/ljDc9Tmtwb7bkElAhAixUMsm/ZLF3UkarPcPTkzMVFWB2dQ2SChgr0gIZO
         CDH+WmlpVEQqibkWNzilW7W5ePXLhAfV4uJj13L8l6zG4KyqxCJKG4rjWAJL630ANdls
         YqX3GwzzeZZq8eYrCr759UMss37jJ7xAxjDuNeqQeT2L9rkjyxo+KqSJFzAnhnCVjBpe
         LFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698780252; x=1699385052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QV3MfU+4pZ9NCMCn3YWPZ/3pv6aBO4+VZTyDwmW4+Ec=;
        b=sIGR2+dG3dMnSZVShAqza254dQSeud9UgZ9u82b2dud4os5X6HKyiRfxKQMxyS0+sn
         Fs2IhOqv6b9on9pxLu7pbGmkm56SoYfY+m7TSzd8zJk7ax5qJE9OuOppQTneOC660kXB
         zFYsBgWM9QNQsOhP6Ac6Chgc7qkqbE5FLMEMKOjh2gtRKM/wKc3Hhw9AjL8FlTXj5Fki
         3IrYXzpgHORfoFDVmWVQFaueRUn5b6ehVUOUm6Cq3/A6YjKJd1fG436ODGBOf7ilGxh8
         5qSIAxv4ujKDxuACgos8M+qjBbQJo2csSnGEkrpchVYDB4CwCyD+plpwDASfovjtdw0B
         LJFg==
X-Gm-Message-State: AOJu0YwBlnjccQ2Q6E53qYm0ybWxYzxOnZnqH+aHO/RIZrlU2IMbST19
	B6zk6v2s4XLoOn51BMLulWqAMgGOqynzHXs20GHveg==
X-Google-Smtp-Source: AGHT+IEmfDkCG2onlCmUZzaJqMwbp5CnHmY61902sL6NGtiTVdzvC63eddQ9zYiCQ/3NQwOGbX6GXA==
X-Received: by 2002:a05:6214:2508:b0:66d:3f8b:fd93 with SMTP id gf8-20020a056214250800b0066d3f8bfd93mr16374085qvb.2.1698780252329;
        Tue, 31 Oct 2023 12:24:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i26-20020a05620a145a00b0076e1e2d6496sm754840qkl.104.2023.10.31.12.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 12:24:12 -0700 (PDT)
Date: Tue, 31 Oct 2023 15:24:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] Documentation/gitformat-pack.txt: fix incorrect MIDX
 documentation
Message-ID: <c149be35a1da66c5e1bbc1dd82839e32a52ace36.1698780244.git.me@ttaylorr.com>
References: <cover.1697144959.git.me@ttaylorr.com>
 <cover.1698780244.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1698780244.git.me@ttaylorr.com>

Back in 32f3c541e3 (multi-pack-index: write pack names in chunk,
2018-07-12) the MIDX's "Packfile Names" (or "PNAM", for short) chunk was
described as containing an array of string entries. e0d1bcf825 notes
that this is the only chunk in the MIDX format's specification that is
not guaranteed to be 4-byte aligned, and so should be placed last.

This isn't quite accurate: the entries within the PNAM chunk are not
guaranteed to be 4-byte aligned since they are arbitrary strings, but
the chunk itself is 4-byte aligned since the ending is padded with NUL
bytes.

That padding has always been there since 32f3c541e3 via
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

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/gitformat-pack.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat-pack.txt
index c4eb09d52a..9fcb29a9c8 100644
--- a/Documentation/gitformat-pack.txt
+++ b/Documentation/gitformat-pack.txt
@@ -390,10 +390,11 @@ CHUNK LOOKUP:
 CHUNK DATA:
 
 	Packfile Names (ID: {'P', 'N', 'A', 'M'})
-	    Stores the packfile names as concatenated, NUL-terminated strings.
-	    Packfiles must be listed in lexicographic order for fast lookups by
-	    name. This is the only chunk not guaranteed to be a multiple of four
-	    bytes in length, so should be the last chunk for alignment reasons.
+	    Store the names of packfiles as a sequence of NUL-terminated
+	    strings. There is no extra padding between the filenames,
+	    and they are listed in lexicographic order. The chunk itself
+	    is padded at the end with between 0 and 3 NUL bytes to make the
+	    chunk size a multiple of 4 bytes.
 
 	OID Fanout (ID: {'O', 'I', 'D', 'F'})
 	    The ith entry, F[i], stores the number of OIDs with first
-- 
2.42.0.527.ge89c67d052
