Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80261C433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 10:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347791AbiFJK5X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 06:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345363AbiFJK5A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 06:57:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC00205F99
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 03:54:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id z17so8882988wmi.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 03:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oxPudypLo8W8JBRgR2SHpxvtjum2xj1XA12AWI+kbys=;
        b=AVAlylC+41zo181yQq8HQoQ/9l45gMrs27smKHI0P+67bUgWeIz5wGEVoxdHma89A/
         xvyUzXAVKCF8xa5h8xZbDbg6DMSbbidDbDFTblp1tn7kWe9ECzhbBWB8YeSknBf6gzl7
         JJo1N2OweiwRB5N9W0S45K6dGblWoaURkPEtDQnGnpOlLgnjfV1OkNtsocCtO2pADIme
         y65ENH09XOl37ZSNRjtxM/KT5rTxwes+1NLxqoaW4S4uzxTAgqke5TpTjnicSf7cOneO
         NklrDgG8CFPaDoVBJ3zhsPq561R0mMSHMlmkd8uodH4EGz5xvYo86NPpZEM0psfhvxw6
         SUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oxPudypLo8W8JBRgR2SHpxvtjum2xj1XA12AWI+kbys=;
        b=Ub7Q3gkQ5e0c0yLuTIFnF04imzg6zauWDPH42lFzuYzT7aRydz3f5C9LTKmkqXjzVs
         uE9cMxK+3iIwYooNwR9JFFDVqK12MFX8OLJagDJaZzNdZRwHjK6MwM63DONLjKNAErF6
         zQFG9jtDM9yKq8zX1HZ4L3YoZNMPoi4FOIdbL/mm+Kp18tBsujauIt7Srl5ZFgtMuBan
         4y7Qs0jV18bZLSywFnRYJ6TrIkDT12Hs3FOdZTf5ITe2beJj/ZrS5BrV47VpDMYEnnIK
         kenQaCRpm+sP+UbgSKMylLe+DiHy4QauYoVQCEfa7FYq7ov4jvdgVDrD+2i65aT5x+Bj
         HrPA==
X-Gm-Message-State: AOAM531d+0CltR0VUbAPypwGn9DCmNTqc6xzZU4iN8mBTXibRe2E06kQ
        doTDm+qSNichTmkqMtbD2rsg8vuI82FdPg==
X-Google-Smtp-Source: ABdhPJzS7qTYxMH7G45vDPYCbV+2Cyv4eannRQi33517Mu/fG0NJFjcuPckgNItiEVcXV9+n527mRw==
X-Received: by 2002:a05:600c:1d2a:b0:39c:5355:3395 with SMTP id l42-20020a05600c1d2a00b0039c53553395mr8098263wms.121.1654858482934;
        Fri, 10 Jun 2022 03:54:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a22-20020a1cf016000000b00397243d3dbcsm2511327wmb.31.2022.06.10.03.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 03:54:42 -0700 (PDT)
Message-Id: <pull.1246.v3.git.1654858481.gitgitgadget@gmail.com>
In-Reply-To: <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
References: <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Jun 2022 10:54:38 +0000
Subject: [PATCH v3 0/3] bitmap-format.txt: fix some formatting issues and include checksum info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
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

Changes since v2: The last two commits are updated to address the
suggestions. These changes are -

 * previously omitted blank lines are re-added. In the updated commit, use
   of <pre> blocks are decreased. Description lists and + are used instead
   to add more than one paragraphs under lists. Readability of the source
   text might decrease due to the use of +. But other documentation files
   (e.g. git-add.txt) also use it to connect two paragraphs. So, I hope this
   is acceptable.

 * Information about trailing checksum is updated (as suggested by Taylor)

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

 Documentation/Makefile                    |   1 +
 Documentation/technical/bitmap-format.txt | 113 ++++++++++++----------
 2 files changed, 63 insertions(+), 51 deletions(-)


base-commit: 2668e3608e47494f2f10ef2b6e69f08a84816bcb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1246%2FAbhra303%2Ffix-doc-formatting-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1246/Abhra303/fix-doc-formatting-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1246

Range-diff vs v2:

 1:  a1b9bd9af90 = 1:  a1b9bd9af90 bitmap-format.txt: feed the file to asciidoc to generate html
 2:  cb919513c14 ! 2:  c74b9a52c2a bitmap-format.txt: fix some formatting issues
     @@ Commit message
          format.txt` is broken. This is mainly because `-` is used for nested
          lists (which is not allowed in asciidoc) instead of `*`.
      
     -    Fix these and also reformat it (e.g. removing some blank lines) for
     -    better readability of the html page.
     +    Fix these and also reformat it for better readability of the html page.
      
          Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
      
     @@ Documentation/technical/bitmap-format.txt: MIDXs, both the bit-cache and rev-cac
      -	- A header appears at the beginning:
      +	* A header appears at the beginning:
       
     - 		4-byte signature: {'B', 'I', 'T', 'M'}
     +-		4-byte signature: {'B', 'I', 'T', 'M'}
     ++		4-byte signature: :: {'B', 'I', 'T', 'M'}
     ++
     ++		2-byte version number (network byte order): ::
       
     -@@ Documentation/technical/bitmap-format.txt: MIDXs, both the bit-cache and rev-cache extensions are required.
     +-		2-byte version number (network byte order)
     + 			The current implementation only supports version 1
       			of the bitmap index (the same one as JGit).
       
     - 		2-byte flags (network byte order)
     --
     +-		2-byte flags (network byte order)
     ++		2-byte flags (network byte order): ::
     + 
       			The following flags are supported:
     --
     - 			- BITMAP_OPT_FULL_DAG (0x1) REQUIRED
     + 
     +-			- BITMAP_OPT_FULL_DAG (0x1) REQUIRED
     ++			** {empty}
     ++			BITMAP_OPT_FULL_DAG (0x1) REQUIRED: :::
     ++
       			This flag must always be present. It implies that the
       			bitmap index has been generated for a packfile or
     + 			multi-pack index (MIDX) with full closure (i.e. where
      @@ Documentation/technical/bitmap-format.txt: MIDXs, both the bit-cache and rev-cache extensions are required.
     - 			requirement for the bitmap index format, also present in
       			JGit, that greatly reduces the complexity of the
       			implementation.
     --
     - 			- BITMAP_OPT_HASH_CACHE (0x4)
     + 
     +-			- BITMAP_OPT_HASH_CACHE (0x4)
     ++			** {empty}
     ++			BITMAP_OPT_HASH_CACHE (0x4): :::
     ++
       			If present, the end of the bitmap file contains
       			`N` 32-bit name-hash values, one per object in the
     -@@ Documentation/technical/bitmap-format.txt: MIDXs, both the bit-cache and rev-cache extensions are required.
     + 			pack/MIDX. The format and meaning of the name-hash is
       			described below.
       
     - 		4-byte entry count (network byte order)
     +-		4-byte entry count (network byte order)
      -
     ++		4-byte entry count (network byte order): ::
       			The total count of entries (bitmapped commits) in this bitmap index.
       
     - 		20-byte checksum
     +-		20-byte checksum
      -
     ++		20-byte checksum: ::
       			The SHA1 checksum of the pack/MIDX this bitmap index
       			belongs to.
       
      -	- 4 EWAH bitmaps that act as type indexes
     -+	* 4 EWAH bitmaps that act as type indexes
     - 
     - 		Type indexes are serialized after the hash cache in the shape
     - 		of four EWAH bitmaps stored consecutively (see Appendix A for
     -@@ Documentation/technical/bitmap-format.txt: MIDXs, both the bit-cache and rev-cache extensions are required.
     - 
     - 		There is a bitmap for each Git object type, stored in the following
     - 		order:
      -
     - 			- Commits
     - 			- Trees
     - 			- Blobs
     -@@ Documentation/technical/bitmap-format.txt: MIDXs, both the bit-cache and rev-cache extensions are required.
     - 		in a full set (all bits set), and the AND of all 4 bitmaps will
     - 		result in an empty bitmap (no bits set).
     - 
     +-		Type indexes are serialized after the hash cache in the shape
     +-		of four EWAH bitmaps stored consecutively (see Appendix A for
     +-		the serialization format of an EWAH bitmap).
     +-
     +-		There is a bitmap for each Git object type, stored in the following
     +-		order:
     +-
     +-			- Commits
     +-			- Trees
     +-			- Blobs
     +-			- Tags
     +-
     +-		In each bitmap, the `n`th bit is set to true if the `n`th object
     +-		in the packfile or multi-pack index is of that type.
     +-
     +-		The obvious consequence is that the OR of all 4 bitmaps will result
     +-		in a full set (all bits set), and the AND of all 4 bitmaps will
     +-		result in an empty bitmap (no bits set).
     +-
      -	- N entries with compressed bitmaps, one for each indexed commit
     -+	* N entries with compressed bitmaps, one for each indexed commit
     - 
     - 		Where `N` is the total amount of entries in this bitmap index.
     - 		Each entry contains the following:
     - 
     +-
     +-		Where `N` is the total amount of entries in this bitmap index.
     +-		Each entry contains the following:
     +-
      -		- 4-byte object position (network byte order)
     -+		** 4-byte object position (network byte order)
     ++	* 4 EWAH bitmaps that act as type indexes
     +++
     ++Type indexes are serialized after the hash cache in the shape
     ++of four EWAH bitmaps stored consecutively (see Appendix A for
     ++the serialization format of an EWAH bitmap).
     +++
     ++There is a bitmap for each Git object type, stored in the following
     ++order:
     +++
     ++	- Commits
     ++	- Trees
     ++	- Blobs
     ++	- Tags
     ++
     +++
     ++In each bitmap, the `n`th bit is set to true if the `n`th object
     ++in the packfile or multi-pack index is of that type.
     ++
     ++    The obvious consequence is that the OR of all 4 bitmaps will result
     ++    in a full set (all bits set), and the AND of all 4 bitmaps will
     ++    result in an empty bitmap (no bits set).
     ++
     ++	* N entries with compressed bitmaps, one for each indexed commit
     +++
     ++Where `N` is the total amount of entries in this bitmap index.
     ++Each entry contains the following:
     ++
     ++		** {empty}
     ++		4-byte object position (network byte order): ::
       			The position **in the index for the packfile or
       			multi-pack index** where the bitmap for this commit is
       			found.
       
      -		- 1-byte XOR-offset
     -+		** 1-byte XOR-offset
     ++		** {empty}
     ++		1-byte XOR-offset: ::
       			The xor offset used to compress this bitmap. For an entry
       			in position `x`, a XOR offset of `y` means that the actual
       			bitmap representing this commit is composed by XORing the
     -@@ Documentation/technical/bitmap-format.txt: MIDXs, both the bit-cache and rev-cache extensions are required.
     - 			with **previous** bitmaps, not bitmaps that will come afterwards
     - 			in the index.
     - 
     + 			bitmap for this entry with the bitmap in entry `x-y` (i.e.
     + 			the bitmap `y` entries before this one).
     +-
     +-			Note that this compression can be recursive. In order to
     +-			XOR this entry with a previous one, the previous entry needs
     +-			to be decompressed first, and so on.
     +-
     +-			The hard-limit for this offset is 160 (an entry can only be
     +-			xor'ed against one of the 160 entries preceding it). This
     +-			number is always positive, and hence entries are always xor'ed
     +-			with **previous** bitmaps, not bitmaps that will come afterwards
     +-			in the index.
     +-
      -		- 1-byte flags for this bitmap
     -+		** 1-byte flags for this bitmap
     +++
     ++NOTE: This compression can be recursive. In order to
     ++XOR this entry with a previous one, the previous entry needs
     ++to be decompressed first, and so on.
     +++
     ++The hard-limit for this offset is 160 (an entry can only be
     ++xor'ed against one of the 160 entries preceding it). This
     ++number is always positive, and hence entries are always xor'ed
     ++with **previous** bitmaps, not bitmaps that will come afterwards
     ++in the index.
     ++
     ++		** {empty}
     ++		1-byte flags for this bitmap: ::
       			At the moment the only available flag is `0x1`, which hints
       			that this bitmap can be re-used when rebuilding bitmap indexes
       			for the repository.
 3:  2171d31fb2b ! 3:  b971558e1cb bitmap-format.txt: add information for trailing checksum
     @@ Commit message
          Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
      
       ## Documentation/technical/bitmap-format.txt ##
     -@@ Documentation/technical/bitmap-format.txt: MIDXs, both the bit-cache and rev-cache extensions are required.
     +@@ Documentation/technical/bitmap-format.txt: in the index.
       
       		** The compressed bitmap itself, see Appendix A.
       
     -+	* TRAILER:
     -+
     -+		Index checksum of the above contents. It is a 20-byte SHA1 checksum.
     ++	* {empty}
     ++	TRAILER: ::
     ++		Trailing checksum of the preceding contents.
      +
       == Appendix A: Serialization format for an EWAH bitmap
       

-- 
gitgitgadget
