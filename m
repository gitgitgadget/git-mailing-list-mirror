Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9F4C43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 15:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241188AbiFFP4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 11:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240974AbiFFPz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 11:55:58 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0232383DF
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 08:55:57 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56A5B12DD83;
        Mon,  6 Jun 2022 11:55:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=We4bVDh2Brl3M6pK5E0dRH04dxYRUgopELOcOL
        LyBCk=; b=I3DxgMRFoEGqmdGX9L0FjynqC+pg3GOpOO1Db+DBrF7lgR9vawLScf
        FybC00JqtLqCx0junqGycusQO0rXPEvGJHNDToHGokqPHzeom6UEFzymhaL01nWU
        6oIfolbvSijbsbp0caKvEhICdnaT1l/FoZfaAv1RfR3i4KpxmPpRQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D56412DD81;
        Mon,  6 Jun 2022 11:55:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A1AF812DD80;
        Mon,  6 Jun 2022 11:55:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Vicent Marti <tanoku@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/2] bitmap-format.txt: fix some formatting issues
References: <pull.1246.git.1654177966.gitgitgadget@gmail.com>
        <976361e624a3dd58c8f291358d42f4e4c66eb266.1654177966.git.gitgitgadget@gmail.com>
Date:   Mon, 06 Jun 2022 08:55:54 -0700
In-Reply-To: <976361e624a3dd58c8f291358d42f4e4c66eb266.1654177966.git.gitgitgadget@gmail.com>
        (Abhradeep Chakraborty via GitGitGadget's message of "Thu, 02 Jun 2022
        13:52:45 +0000")
Message-ID: <xmqqsfohbxbp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26564018-E5B1-11EC-A1E8-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> Cc: git@vger.kernel.org,  Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Identify those who may have input with "git log --no-merges" and add
them here, perhaps?

> The asciidoc generated html for `Documentation/technical/bitmap-
> format.txt` is broken. This is mainly because `-` is used for nested
> lists (which is not allowed in asciidoc) instead of `*`.

Are we missing another step that must come much earlier than this
patch?  It seems to me that Documentation/Makefile does not even
consider that we should feed this file to AsciiDoc.

> Fix these and also reformat it (e.g. removing some blank lines) for
> better readability of the html page.

Do these blank lines hurt very badly how the end-result is formatted
in HTML?  Does the extra indentation between the line with "The
following flags are supported" on it and the two bullet items in the
header make the output better in significant way?

These changes make the input text much harder to read, and are not
very welcome, so unless they are part of "fixing generated HTML is
broken", please omit them.  As evidenced by the lack of HTML output
in the build system, a lot more folks read this document in text than
in HTML, and readability of the source matters.

Thanks.

> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> ---
>  Documentation/technical/bitmap-format.txt | 96 +++++++++++------------
>  1 file changed, 45 insertions(+), 51 deletions(-)
>
> diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
> index 04b3ec21785..110d7ddf8ed 100644
> --- a/Documentation/technical/bitmap-format.txt
> +++ b/Documentation/technical/bitmap-format.txt
> @@ -39,7 +39,7 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
>  
>  == On-disk format
>  
> -	- A header appears at the beginning:
> +	* A header appears at the beginning:
>  
>  		4-byte signature: {'B', 'I', 'T', 'M'}
>  
> @@ -48,35 +48,30 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
>  			of the bitmap index (the same one as JGit).
>  
>  		2-byte flags (network byte order)
> -
>  			The following flags are supported:
> -
> -			- BITMAP_OPT_FULL_DAG (0x1) REQUIRED
> -			This flag must always be present. It implies that the
> -			bitmap index has been generated for a packfile or
> -			multi-pack index (MIDX) with full closure (i.e. where
> -			every single object in the packfile/MIDX can find its
> -			parent links inside the same packfile/MIDX). This is a
> -			requirement for the bitmap index format, also present in
> -			JGit, that greatly reduces the complexity of the
> -			implementation.
> -
> -			- BITMAP_OPT_HASH_CACHE (0x4)
> -			If present, the end of the bitmap file contains
> -			`N` 32-bit name-hash values, one per object in the
> -			pack/MIDX. The format and meaning of the name-hash is
> -			described below.
> +				- BITMAP_OPT_FULL_DAG (0x1) REQUIRED
> +				This flag must always be present. It implies that the
> +				bitmap index has been generated for a packfile or
> +				multi-pack index (MIDX) with full closure (i.e. where
> +				every single object in the packfile/MIDX can find its
> +				parent links inside the same packfile/MIDX). This is a
> +				requirement for the bitmap index format, also present in
> +				JGit, that greatly reduces the complexity of the
> +				implementation.
> +				- BITMAP_OPT_HASH_CACHE (0x4)
> +				If present, the end of the bitmap file contains
> +				`N` 32-bit name-hash values, one per object in the
> +				pack/MIDX. The format and meaning of the name-hash is
> +				described below.
>  
>  		4-byte entry count (network byte order)
> -
>  			The total count of entries (bitmapped commits) in this bitmap index.
>  
>  		20-byte checksum
> -
>  			The SHA1 checksum of the pack/MIDX this bitmap index
>  			belongs to.
>  
> -	- 4 EWAH bitmaps that act as type indexes
> +	* 4 EWAH bitmaps that act as type indexes
>  
>  		Type indexes are serialized after the hash cache in the shape
>  		of four EWAH bitmaps stored consecutively (see Appendix A for
> @@ -84,7 +79,6 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
>  
>  		There is a bitmap for each Git object type, stored in the following
>  		order:
> -
>  			- Commits
>  			- Trees
>  			- Blobs
> @@ -97,39 +91,39 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
>  		in a full set (all bits set), and the AND of all 4 bitmaps will
>  		result in an empty bitmap (no bits set).
>  
> -	- N entries with compressed bitmaps, one for each indexed commit
> +	* N entries with compressed bitmaps, one for each indexed commit
>  
>  		Where `N` is the total amount of entries in this bitmap index.
>  		Each entry contains the following:
>  
> -		- 4-byte object position (network byte order)
> -			The position **in the index for the packfile or
> -			multi-pack index** where the bitmap for this commit is
> -			found.
> -
> -		- 1-byte XOR-offset
> -			The xor offset used to compress this bitmap. For an entry
> -			in position `x`, a XOR offset of `y` means that the actual
> -			bitmap representing this commit is composed by XORing the
> -			bitmap for this entry with the bitmap in entry `x-y` (i.e.
> -			the bitmap `y` entries before this one).
> -
> -			Note that this compression can be recursive. In order to
> -			XOR this entry with a previous one, the previous entry needs
> -			to be decompressed first, and so on.
> -
> -			The hard-limit for this offset is 160 (an entry can only be
> -			xor'ed against one of the 160 entries preceding it). This
> -			number is always positive, and hence entries are always xor'ed
> -			with **previous** bitmaps, not bitmaps that will come afterwards
> -			in the index.
> -
> -		- 1-byte flags for this bitmap
> -			At the moment the only available flag is `0x1`, which hints
> -			that this bitmap can be re-used when rebuilding bitmap indexes
> -			for the repository.
> -
> -		- The compressed bitmap itself, see Appendix A.
> +			** 4-byte object position (network byte order)
> +				The position **in the index for the packfile or
> +				multi-pack index** where the bitmap for this commit is
> +				found.
> +
> +			** 1-byte XOR-offset
> +				The xor offset used to compress this bitmap. For an entry
> +				in position `x`, a XOR offset of `y` means that the actual
> +				bitmap representing this commit is composed by XORing the
> +				bitmap for this entry with the bitmap in entry `x-y` (i.e.
> +				the bitmap `y` entries before this one).
> +
> +				Note that this compression can be recursive. In order to
> +				XOR this entry with a previous one, the previous entry needs
> +				to be decompressed first, and so on.
> +
> +				The hard-limit for this offset is 160 (an entry can only be
> +				xor'ed against one of the 160 entries preceding it). This
> +				number is always positive, and hence entries are always xor'ed
> +				with **previous** bitmaps, not bitmaps that will come afterwards
> +				in the index.
> +
> +			** 1-byte flags for this bitmap
> +				At the moment the only available flag is `0x1`, which hints
> +				that this bitmap can be re-used when rebuilding bitmap indexes
> +				for the repository.
> +
> +			** The compressed bitmap itself, see Appendix A.
>  
>  == Appendix A: Serialization format for an EWAH bitmap
