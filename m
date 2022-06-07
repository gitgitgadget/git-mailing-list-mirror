Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BD0CCA48B
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 18:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349106AbiFGSHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 14:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350861AbiFGSB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 14:01:28 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E4E14CDF4
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 10:43:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u8so20831847wrm.13
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 10:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D6hD3m6PowZoAZL+Tm8S0b9XjLwEJNmoaRZAgDNrnbM=;
        b=KFvxivCi5UtO3DN2+Upc6EXqn9Nx7S6lq118WcrJmpEIJ0eGvxOlWe+26sRjJLNGly
         Ne9HEsb3oKlzZIL8ydcjoZYj0yO/2VyANsCI3FScA+L55JEKYjsd7Duk5T1J4opzbQvV
         AeHt4ajZA71pYlivb2rAOi319KZ2nzXsOpDOf9q7eaEx452XhFo6rUGdbnJV3OEByUMf
         aDky40LGJBDZe9iPu/wjoACpDKmAx3YN/NnqGTuQytRBR3kgvcIyImvzJ1lBl5Ry9NOj
         Tz7ie2BMl/SN3XuyYWrxQiiUpvMd11r12MbDP2m9zloVpNjxwSfJPQQW9aBAR9EzJKnV
         eM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=D6hD3m6PowZoAZL+Tm8S0b9XjLwEJNmoaRZAgDNrnbM=;
        b=7+21dGjiSwvpC2MFQxRRfuVI9g4vEzgtt5/uJFvDYLf/RLF1beAo2WBnapjl8w18oi
         2VgB2o4BoD18BdagcVBPnvP2tkF1tFLPbFe5hQUZ/IFUk0z8Z/8CH8X3yaa/1kcHOcZc
         oTWqQYUdRnM5TQDPQqDSd2LrlYLoDTPI2+W5k8uj3ptoXHbbAoJRi86LR1QqLra/quXL
         UaVIy7giB2OsBmTy71qUY6gwEOqZA/6MTXL58sKIC65T72vln4JDJtrCAQx6cvYv7JdC
         7Dc/UnUmTkm/d8dPzfj+tBAqN/wUlGtn7kf/wIZuleNr84/nkA9O+366aQ9GdKV19deJ
         NM2g==
X-Gm-Message-State: AOAM533r8tiJCDeao3KSJmSAIG2iSWz09TUOz+pZ1B+CzE1XKrDlrfkB
        hOxE5ah3eZ5i6ei3NzQlKmaNNJDhKLXt7KOC
X-Google-Smtp-Source: ABdhPJzseanFNrW5Kv/XBpRUAD0+dp3ePfXlnCpt3cxsMxu41av76Wg0VciacEnqo7s9NHNBAgsVJQ==
X-Received: by 2002:adf:f80b:0:b0:217:88ff:eb6f with SMTP id s11-20020adff80b000000b0021788ffeb6fmr14499770wrp.489.1654623816254;
        Tue, 07 Jun 2022 10:43:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c4fc500b0039c5a765388sm2950660wmq.28.2022.06.07.10.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:43:35 -0700 (PDT)
Message-Id: <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
In-Reply-To: <pull.1246.git.1654177966.gitgitgadget@gmail.com>
References: <pull.1246.git.1654177966.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 17:43:31 +0000
Subject: [PATCH v2 0/3] bitmap-format.txt: fix some formatting issues and include checksum info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Vicent Marti <tanoku@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are some issues in the bitmap-format html page. For example, some
nested lists are shown as top-level lists (e.g. [1]- Here
BITMAP_OPT_FULL_DAG (0x1) and BITMAP_OPT_HASH_CACHE (0x4) are shown as
top-level list). There is also a need of adding info about trailing checksum
in the docs.

Changes since v1:

 * a new commit addressing bitmap-format.txt html page generation is added
 * Remove extra indentation from the previous change
 * elaborate more about the trailing checksum (as suggested by Kaartic)

initial version:

 * first commit fixes some formatting issues
 * information about trailing checksum in the bitmap file is added in the
   bitmap-format doc.

[1] https://git-scm.com/docs/bitmap-format#_on_disk_format

Abhradeep Chakraborty (3):
  bitmap-format.txt: feed the file to asciidoc to generate html
  bitmap-format.txt: fix some formatting issues
  bitmap-format.txt: add information for trailing checksum

 Documentation/Makefile                    |  1 +
 Documentation/technical/bitmap-format.txt | 24 +++++++++++------------
 2 files changed, 12 insertions(+), 13 deletions(-)


base-commit: 2668e3608e47494f2f10ef2b6e69f08a84816bcb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1246%2FAbhra303%2Ffix-doc-formatting-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1246/Abhra303/fix-doc-formatting-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1246

Range-diff vs v1:

 -:  ----------- > 1:  a1b9bd9af90 bitmap-format.txt: feed the file to asciidoc to generate html
 1:  976361e624a ! 2:  cb919513c14 bitmap-format.txt: fix some formatting issues
     @@ Documentation/technical/bitmap-format.txt: MIDXs, both the bit-cache and rev-cac
      -
       			The following flags are supported:
      -
     --			- BITMAP_OPT_FULL_DAG (0x1) REQUIRED
     --			This flag must always be present. It implies that the
     --			bitmap index has been generated for a packfile or
     --			multi-pack index (MIDX) with full closure (i.e. where
     --			every single object in the packfile/MIDX can find its
     --			parent links inside the same packfile/MIDX). This is a
     --			requirement for the bitmap index format, also present in
     --			JGit, that greatly reduces the complexity of the
     --			implementation.
     + 			- BITMAP_OPT_FULL_DAG (0x1) REQUIRED
     + 			This flag must always be present. It implies that the
     + 			bitmap index has been generated for a packfile or
     +@@ Documentation/technical/bitmap-format.txt: MIDXs, both the bit-cache and rev-cache extensions are required.
     + 			requirement for the bitmap index format, also present in
     + 			JGit, that greatly reduces the complexity of the
     + 			implementation.
      -
     --			- BITMAP_OPT_HASH_CACHE (0x4)
     --			If present, the end of the bitmap file contains
     --			`N` 32-bit name-hash values, one per object in the
     --			pack/MIDX. The format and meaning of the name-hash is
     --			described below.
     -+				- BITMAP_OPT_FULL_DAG (0x1) REQUIRED
     -+				This flag must always be present. It implies that the
     -+				bitmap index has been generated for a packfile or
     -+				multi-pack index (MIDX) with full closure (i.e. where
     -+				every single object in the packfile/MIDX can find its
     -+				parent links inside the same packfile/MIDX). This is a
     -+				requirement for the bitmap index format, also present in
     -+				JGit, that greatly reduces the complexity of the
     -+				implementation.
     -+				- BITMAP_OPT_HASH_CACHE (0x4)
     -+				If present, the end of the bitmap file contains
     -+				`N` 32-bit name-hash values, one per object in the
     -+				pack/MIDX. The format and meaning of the name-hash is
     -+				described below.
     + 			- BITMAP_OPT_HASH_CACHE (0x4)
     + 			If present, the end of the bitmap file contains
     + 			`N` 32-bit name-hash values, one per object in the
     +@@ Documentation/technical/bitmap-format.txt: MIDXs, both the bit-cache and rev-cache extensions are required.
     + 			described below.
       
       		4-byte entry count (network byte order)
      -
     @@ Documentation/technical/bitmap-format.txt: MIDXs, both the bit-cache and rev-cac
       		Each entry contains the following:
       
      -		- 4-byte object position (network byte order)
     --			The position **in the index for the packfile or
     --			multi-pack index** where the bitmap for this commit is
     --			found.
     --
     ++		** 4-byte object position (network byte order)
     + 			The position **in the index for the packfile or
     + 			multi-pack index** where the bitmap for this commit is
     + 			found.
     + 
      -		- 1-byte XOR-offset
     --			The xor offset used to compress this bitmap. For an entry
     --			in position `x`, a XOR offset of `y` means that the actual
     --			bitmap representing this commit is composed by XORing the
     --			bitmap for this entry with the bitmap in entry `x-y` (i.e.
     --			the bitmap `y` entries before this one).
     --
     --			Note that this compression can be recursive. In order to
     --			XOR this entry with a previous one, the previous entry needs
     --			to be decompressed first, and so on.
     --
     --			The hard-limit for this offset is 160 (an entry can only be
     --			xor'ed against one of the 160 entries preceding it). This
     --			number is always positive, and hence entries are always xor'ed
     --			with **previous** bitmaps, not bitmaps that will come afterwards
     --			in the index.
     --
     ++		** 1-byte XOR-offset
     + 			The xor offset used to compress this bitmap. For an entry
     + 			in position `x`, a XOR offset of `y` means that the actual
     + 			bitmap representing this commit is composed by XORing the
     +@@ Documentation/technical/bitmap-format.txt: MIDXs, both the bit-cache and rev-cache extensions are required.
     + 			with **previous** bitmaps, not bitmaps that will come afterwards
     + 			in the index.
     + 
      -		- 1-byte flags for this bitmap
     --			At the moment the only available flag is `0x1`, which hints
     --			that this bitmap can be re-used when rebuilding bitmap indexes
     --			for the repository.
     --
     ++		** 1-byte flags for this bitmap
     + 			At the moment the only available flag is `0x1`, which hints
     + 			that this bitmap can be re-used when rebuilding bitmap indexes
     + 			for the repository.
     + 
      -		- The compressed bitmap itself, see Appendix A.
     -+			** 4-byte object position (network byte order)
     -+				The position **in the index for the packfile or
     -+				multi-pack index** where the bitmap for this commit is
     -+				found.
     -+
     -+			** 1-byte XOR-offset
     -+				The xor offset used to compress this bitmap. For an entry
     -+				in position `x`, a XOR offset of `y` means that the actual
     -+				bitmap representing this commit is composed by XORing the
     -+				bitmap for this entry with the bitmap in entry `x-y` (i.e.
     -+				the bitmap `y` entries before this one).
     -+
     -+				Note that this compression can be recursive. In order to
     -+				XOR this entry with a previous one, the previous entry needs
     -+				to be decompressed first, and so on.
     -+
     -+				The hard-limit for this offset is 160 (an entry can only be
     -+				xor'ed against one of the 160 entries preceding it). This
     -+				number is always positive, and hence entries are always xor'ed
     -+				with **previous** bitmaps, not bitmaps that will come afterwards
     -+				in the index.
     -+
     -+			** 1-byte flags for this bitmap
     -+				At the moment the only available flag is `0x1`, which hints
     -+				that this bitmap can be re-used when rebuilding bitmap indexes
     -+				for the repository.
     -+
     -+			** The compressed bitmap itself, see Appendix A.
     ++		** The compressed bitmap itself, see Appendix A.
       
       == Appendix A: Serialization format for an EWAH bitmap
       
 2:  ba534b5d486 ! 3:  2171d31fb2b bitmap-format.txt: add information for trailing checksum
     @@ Commit message
       ## Documentation/technical/bitmap-format.txt ##
      @@ Documentation/technical/bitmap-format.txt: MIDXs, both the bit-cache and rev-cache extensions are required.
       
     - 			** The compressed bitmap itself, see Appendix A.
     + 		** The compressed bitmap itself, see Appendix A.
       
      +	* TRAILER:
      +
     -+		Index checksum of the above contents.
     ++		Index checksum of the above contents. It is a 20-byte SHA1 checksum.
      +
       == Appendix A: Serialization format for an EWAH bitmap
       

-- 
gitgitgadget
