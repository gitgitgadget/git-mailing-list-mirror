Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDADC433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 05:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347612AbiFPFEB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 01:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbiFPFEA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 01:04:00 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8129C53712
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 22:03:58 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z9so126432wmf.3
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 22:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZXGCeNM2ifKyTfWQgVclUpK+LEPCYk/wXZgSgob49jU=;
        b=AaZ6/zVWf3Jtf/8iXNZlLmT/3UIAjzLRtVYZheGGgwCG6aildjU0EO0C89pME3fJbA
         e6GkXLnBTYA0bygpCg/fGG/jRhGkUw6TrOyloqX5JDTb4tygy/csw1vcNDNOw1QavZUe
         2QA4lHysjPn2+wwmamW1GJUgaLhcUJAIDzxAltDrqJEFyYKKldkT9sJjV8jgC+nLfe0N
         FbcDw2FIsPrw4Ajof13HG0iFx8sr+r5bbOGuLKnDDxrNrBYJjcFCrNt0WV1JIQxXzMfo
         g/FejCk1hS/y/fB1q6OEZk2nkF8edeIInD3D/ph3+yISFKzwiiJni/Qj47cMQ9/a2ygs
         cZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZXGCeNM2ifKyTfWQgVclUpK+LEPCYk/wXZgSgob49jU=;
        b=XjXEKmB9uwsMGU2uR3aXLVDiwN02ctjl+NP9YtABjgJCXo1JNFIqbEE4aPDVCCltr0
         X53itWLJAC8g80LhVc8DuIRDbbQajZKhEqHswROAP8/LZ+lkmzalpc87XuzdjtEGnJbr
         bYtp1z6cPF03oINL/okdRWuNvYAFZb8E3SvrxGdx1rtNmxN2mxdvv7ZzfUzO9eFBWzl0
         xl0eVtvWlgzbECdZCHcaFYlJyO4LQwrZwpMQ3IQOZhBxngP2/bPX6AJ+5q8m30zAn80E
         uEZRL3wXUYGuUtSLRgj8fNXK595TMEbYhxkl5blg8bAjgpMP5uf1dZXZbeMtK0FvqufE
         h4hA==
X-Gm-Message-State: AJIora//PGRlSc0LqxqA4BkCkKEkPOd19KiqJWTMQiHpaMiF7g2rB0AQ
        CtGNlTDTMoHfMEN2Giku6cT8VOPOKe8TvQ==
X-Google-Smtp-Source: AGRyM1smbxmk10upZIcXYkmDQwIBF3co/W5BY7BGiqctWQKcpXuuNvkEFCYZIodXSHVW0NU1Q7RuuQ==
X-Received: by 2002:a7b:c856:0:b0:39c:3b44:7ab0 with SMTP id c22-20020a7bc856000000b0039c3b447ab0mr2943945wml.117.1655355836415;
        Wed, 15 Jun 2022 22:03:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p124-20020a1c2982000000b0039c7dbafa7asm4562247wmp.19.2022.06.15.22.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 22:03:55 -0700 (PDT)
Message-Id: <pull.1246.v4.git.1655355834.gitgitgadget@gmail.com>
In-Reply-To: <pull.1246.v3.git.1654858481.gitgitgadget@gmail.com>
References: <pull.1246.v3.git.1654858481.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jun 2022 05:03:51 +0000
Subject: [PATCH v4 0/3] bitmap-format.txt: fix some formatting issues and include checksum info
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

Changes since v3:

 * spaces are used instead of tabs
 * fixed remaining <pre> blocks

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
 Documentation/technical/bitmap-format.txt | 203 ++++++++++++----------
 2 files changed, 108 insertions(+), 96 deletions(-)


base-commit: 5699ec1b0aec51b9e9ba5a2785f65970c5a95d84
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1246%2FAbhra303%2Ffix-doc-formatting-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1246/Abhra303/fix-doc-formatting-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1246

Range-diff vs v3:

 1:  a1b9bd9af90 ! 1:  494c1c1bd52 bitmap-format.txt: feed the file to asciidoc to generate html
     @@ Documentation/Makefile: TECH_DOCS += MyFirstContribution
       TECH_DOCS += ToolsForGit
      +TECH_DOCS += technical/bitmap-format
       TECH_DOCS += technical/bundle-format
     + TECH_DOCS += technical/cruft-packs
       TECH_DOCS += technical/hash-function-transition
     - TECH_DOCS += technical/http-protocol
 2:  c74b9a52c2a ! 2:  25512aa9c5b bitmap-format.txt: fix some formatting issues
     @@ Commit message
          Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
      
       ## Documentation/technical/bitmap-format.txt ##
     +@@ Documentation/technical/bitmap-format.txt: An object is uniquely described by its bit position within a bitmap:
     + 	is defined as follows:
     + 
     + 		o1 <= o2 <==> pack(o1) <= pack(o2) /\ offset(o1) <= offset(o2)
     +-
     +-	The ordering between packs is done according to the MIDX's .rev file.
     +-	Notably, the preferred pack sorts ahead of all other packs.
     +++
     ++The ordering between packs is done according to the MIDX's .rev file.
     ++Notably, the preferred pack sorts ahead of all other packs.
     + 
     + The on-disk representation (described below) of a bitmap is the same regardless
     + of whether or not that bitmap belongs to a packfile or a MIDX. The only
      @@ Documentation/technical/bitmap-format.txt: MIDXs, both the bit-cache and rev-cache extensions are required.
       
       == On-disk format
       
      -	- A header appears at the beginning:
     -+	* A header appears at the beginning:
     - 
     +-
      -		4-byte signature: {'B', 'I', 'T', 'M'}
     -+		4-byte signature: :: {'B', 'I', 'T', 'M'}
     -+
     -+		2-byte version number (network byte order): ::
     - 
     +-
      -		2-byte version number (network byte order)
     - 			The current implementation only supports version 1
     - 			of the bitmap index (the same one as JGit).
     - 
     +-			The current implementation only supports version 1
     +-			of the bitmap index (the same one as JGit).
     +-
      -		2-byte flags (network byte order)
     -+		2-byte flags (network byte order): ::
     - 
     - 			The following flags are supported:
     - 
     +-
     +-			The following flags are supported:
     +-
      -			- BITMAP_OPT_FULL_DAG (0x1) REQUIRED
     -+			** {empty}
     -+			BITMAP_OPT_FULL_DAG (0x1) REQUIRED: :::
     -+
     - 			This flag must always be present. It implies that the
     - 			bitmap index has been generated for a packfile or
     - 			multi-pack index (MIDX) with full closure (i.e. where
     -@@ Documentation/technical/bitmap-format.txt: MIDXs, both the bit-cache and rev-cache extensions are required.
     - 			JGit, that greatly reduces the complexity of the
     - 			implementation.
     - 
     +-			This flag must always be present. It implies that the
     +-			bitmap index has been generated for a packfile or
     +-			multi-pack index (MIDX) with full closure (i.e. where
     +-			every single object in the packfile/MIDX can find its
     +-			parent links inside the same packfile/MIDX). This is a
     +-			requirement for the bitmap index format, also present in
     +-			JGit, that greatly reduces the complexity of the
     +-			implementation.
     +-
      -			- BITMAP_OPT_HASH_CACHE (0x4)
     -+			** {empty}
     -+			BITMAP_OPT_HASH_CACHE (0x4): :::
     -+
     - 			If present, the end of the bitmap file contains
     - 			`N` 32-bit name-hash values, one per object in the
     - 			pack/MIDX. The format and meaning of the name-hash is
     - 			described below.
     - 
     +-			If present, the end of the bitmap file contains
     +-			`N` 32-bit name-hash values, one per object in the
     +-			pack/MIDX. The format and meaning of the name-hash is
     +-			described below.
     +-
      -		4-byte entry count (network byte order)
      -
     -+		4-byte entry count (network byte order): ::
     - 			The total count of entries (bitmapped commits) in this bitmap index.
     - 
     +-			The total count of entries (bitmapped commits) in this bitmap index.
     +-
      -		20-byte checksum
      -
     -+		20-byte checksum: ::
     - 			The SHA1 checksum of the pack/MIDX this bitmap index
     - 			belongs to.
     - 
     +-			The SHA1 checksum of the pack/MIDX this bitmap index
     +-			belongs to.
     +-
      -	- 4 EWAH bitmaps that act as type indexes
      -
      -		Type indexes are serialized after the hash cache in the shape
     @@ Documentation/technical/bitmap-format.txt: MIDXs, both the bit-cache and rev-cac
      -		Each entry contains the following:
      -
      -		- 4-byte object position (network byte order)
     -+	* 4 EWAH bitmaps that act as type indexes
     +-			The position **in the index for the packfile or
     +-			multi-pack index** where the bitmap for this commit is
     +-			found.
     +-
     +-		- 1-byte XOR-offset
     +-			The xor offset used to compress this bitmap. For an entry
     +-			in position `x`, a XOR offset of `y` means that the actual
     +-			bitmap representing this commit is composed by XORing the
     +-			bitmap for this entry with the bitmap in entry `x-y` (i.e.
     +-			the bitmap `y` entries before this one).
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
     +-		- 1-byte flags for this bitmap
     +-			At the moment the only available flag is `0x1`, which hints
     +-			that this bitmap can be re-used when rebuilding bitmap indexes
     +-			for the repository.
     +-
     +-		- The compressed bitmap itself, see Appendix A.
     ++    * A header appears at the beginning:
     ++
     ++        4-byte signature: :: {'B', 'I', 'T', 'M'}
     ++
     ++        2-byte version number (network byte order): ::
     ++
     ++            The current implementation only supports version 1
     ++            of the bitmap index (the same one as JGit).
     ++
     ++        2-byte flags (network byte order): ::
     ++
     ++            The following flags are supported:
     ++
     ++            ** {empty}
     ++            BITMAP_OPT_FULL_DAG (0x1) REQUIRED: :::
     ++
     ++            This flag must always be present. It implies that the
     ++            bitmap index has been generated for a packfile or
     ++            multi-pack index (MIDX) with full closure (i.e. where
     ++            every single object in the packfile/MIDX can find its
     ++            parent links inside the same packfile/MIDX). This is a
     ++            requirement for the bitmap index format, also present in
     ++            JGit, that greatly reduces the complexity of the
     ++            implementation.
     ++
     ++            ** {empty}
     ++            BITMAP_OPT_HASH_CACHE (0x4): :::
     ++
     ++            If present, the end of the bitmap file contains
     ++            `N` 32-bit name-hash values, one per object in the
     ++            pack/MIDX. The format and meaning of the name-hash is
     ++            described below.
     ++
     ++        4-byte entry count (network byte order): ::
     ++            The total count of entries (bitmapped commits) in this bitmap index.
     ++
     ++        20-byte checksum: ::
     ++            The SHA1 checksum of the pack/MIDX this bitmap index
     ++            belongs to.
     ++
     ++    * 4 EWAH bitmaps that act as type indexes
      ++
      +Type indexes are serialized after the hash cache in the shape
      +of four EWAH bitmaps stored consecutively (see Appendix A for
     @@ Documentation/technical/bitmap-format.txt: MIDXs, both the bit-cache and rev-cac
      +There is a bitmap for each Git object type, stored in the following
      +order:
      ++
     -+	- Commits
     -+	- Trees
     -+	- Blobs
     -+	- Tags
     ++    - Commits
     ++    - Trees
     ++    - Blobs
     ++    - Tags
      +
      ++
      +In each bitmap, the `n`th bit is set to true if the `n`th object
      +in the packfile or multi-pack index is of that type.
     +++
     ++The obvious consequence is that the OR of all 4 bitmaps will result
     ++in a full set (all bits set), and the AND of all 4 bitmaps will
     ++result in an empty bitmap (no bits set).
      +
     -+    The obvious consequence is that the OR of all 4 bitmaps will result
     -+    in a full set (all bits set), and the AND of all 4 bitmaps will
     -+    result in an empty bitmap (no bits set).
     -+
     -+	* N entries with compressed bitmaps, one for each indexed commit
     ++    * N entries with compressed bitmaps, one for each indexed commit
      ++
      +Where `N` is the total amount of entries in this bitmap index.
      +Each entry contains the following:
      +
     -+		** {empty}
     -+		4-byte object position (network byte order): ::
     - 			The position **in the index for the packfile or
     - 			multi-pack index** where the bitmap for this commit is
     - 			found.
     - 
     --		- 1-byte XOR-offset
     -+		** {empty}
     -+		1-byte XOR-offset: ::
     - 			The xor offset used to compress this bitmap. For an entry
     - 			in position `x`, a XOR offset of `y` means that the actual
     - 			bitmap representing this commit is composed by XORing the
     - 			bitmap for this entry with the bitmap in entry `x-y` (i.e.
     - 			the bitmap `y` entries before this one).
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
     --		- 1-byte flags for this bitmap
     ++        ** {empty}
     ++        4-byte object position (network byte order): ::
     ++            The position **in the index for the packfile or
     ++            multi-pack index** where the bitmap for this commit is
     ++            found.
     ++
     ++        ** {empty}
     ++        1-byte XOR-offset: ::
     ++            The xor offset used to compress this bitmap. For an entry
     ++            in position `x`, a XOR offset of `y` means that the actual
     ++            bitmap representing this commit is composed by XORing the
     ++            bitmap for this entry with the bitmap in entry `x-y` (i.e.
     ++            the bitmap `y` entries before this one).
      ++
      +NOTE: This compression can be recursive. In order to
      +XOR this entry with a previous one, the previous entry needs
     @@ Documentation/technical/bitmap-format.txt: MIDXs, both the bit-cache and rev-cac
      +with **previous** bitmaps, not bitmaps that will come afterwards
      +in the index.
      +
     -+		** {empty}
     -+		1-byte flags for this bitmap: ::
     - 			At the moment the only available flag is `0x1`, which hints
     - 			that this bitmap can be re-used when rebuilding bitmap indexes
     - 			for the repository.
     - 
     --		- The compressed bitmap itself, see Appendix A.
     -+		** The compressed bitmap itself, see Appendix A.
     ++        ** {empty}
     ++        1-byte flags for this bitmap: ::
     ++            At the moment the only available flag is `0x1`, which hints
     ++            that this bitmap can be re-used when rebuilding bitmap indexes
     ++            for the repository.
     ++
     ++        ** The compressed bitmap itself, see Appendix A.
       
       == Appendix A: Serialization format for an EWAH bitmap
       
     +@@ Documentation/technical/bitmap-format.txt: implementation:
     + 	- 4-byte number of words of the COMPRESSED bitmap, when stored
     + 
     + 	- N x 8-byte words, as specified by the previous field
     +-
     +-		This is the actual content of the compressed bitmap.
     +++
     ++This is the actual content of the compressed bitmap.
     + 
     + 	- 4-byte position of the current RLW for the compressed
     + 		bitmap
 3:  b971558e1cb ! 3:  dbb86dca205 bitmap-format.txt: add information for trailing checksum
     @@ Commit message
       ## Documentation/technical/bitmap-format.txt ##
      @@ Documentation/technical/bitmap-format.txt: in the index.
       
     - 		** The compressed bitmap itself, see Appendix A.
     +         ** The compressed bitmap itself, see Appendix A.
       
      +	* {empty}
      +	TRAILER: ::

-- 
gitgitgadget
