Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E69A469D
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 00:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732235952; cv=none; b=PhWBIA15VoYC+UUXTc4ZtBqVpZ66+FnBB/FH9LK+q5maUflt13Cbog15rOYQj932p040XTbwhtN8wUZZy4P50K4Has6ZS7ZesrGCr8IMX2j16IOWWC2m/NgESNVIejK102iejK9Sr9NSlUY4Xg+xfITMsCC3m/NVIkZTssZDbyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732235952; c=relaxed/simple;
	bh=RcSvIjryfz0GtdveFJ/FGmHHT2Pd7ixEyx2n/MD9K5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OnPpKcvyzBzzq8190LEFRrw0LHGf+jkXzA2Btxq8eO2Nv2E8gzd9o4GAQPI+s9U4A0VgSTfGIIGx9tB7iinoMD14IIPeMVstIcRGiuDxzOIPBP8Ck+yL+vXLcnX3zblkgnAJdMjvni4PdtpCDmoqyjDhmwaDdsEg9UxbugHJKtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TIl9nBuv; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TIl9nBuv"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A53821380267;
	Thu, 21 Nov 2024 19:39:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 21 Nov 2024 19:39:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732235949; x=1732322349; bh=Ef3GGAkt17NUePrp1qtq1TeNTW7uEXe2NJR
	/wjQnq1I=; b=TIl9nBuvDJsa872AX7fmw1vw/kPVD5DGFawVAHLBedwNmPL2l5s
	v2U01j5DLyqTHqL2Wn9i7llh+w882Ykcy8HypJBNS9bYISxxguThMOwkcuCwoUjq
	ENgrHQLAEIzISaEWAsYdFPRQtL0muUHkXR4d0c+9U4PDG2gtLA0nUDnlqp69Mr3J
	rt4hjULRPa7J9XOtoroz/kxdei6FHI+zOMrWRUPbkw0g/g/eftj6x/2iBXNys8rH
	VcvHs5yXVV8FLMNM3+1gEDB+zVGYZzNcwnUFmApz1Dgs9VePM7NCtU2X+94rkUlh
	bn604ifunAdEO3RsBa4ghQzA0dOlr2mKvfw==
X-ME-Sender: <xms:rdI_Z_q0a0Z_xWrwJ8iWxULFJJAdNNItOOsEdJ1a2yJ7UEL0cPXDaA>
    <xme:rdI_Z5rG4qqj9_1uRrwMDbRs4pwJh2x_mAOU4WTMWMBVcXt1g44Fdk9Ue0wHQqxwT
    ssLBOHVtePoHleZ7g>
X-ME-Received: <xmr:rdI_Z8NDVRooMtc55uDRqIyQYOf-PMzDfBhizMDTHtwqkPzx4_AQDEvOpeh2wohJiycQdh5ryLWI3lel_X_QZmRXIqO0dXFlTxHv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeejgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rdI_Zy541qcDLBcJp_TmlCgvCMSqZ4DIIR23C-OzCgjomw3AcQz6uw>
    <xmx:rdI_Z-5D9hBl4YjK2JPTh1Zxv6dKwZLyto1o_fmaDToxgNjZQuJG3g>
    <xmx:rdI_Z6hcMf4nw1KEpDrwcmW6V7SLoC3b8YTzknTH5H1tG4gSfldDZQ>
    <xmx:rdI_Zw71wCEUrRe9z1gN5TpYa_Qz83-Kt8ju46a-_ySTNfy6FfnVGA>
    <xmx:rdI_Z53XCqRL4UwMUovumMcyGQVUD-U2zozOH_k6Px72l_4mt_xwcXTT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Nov 2024 19:39:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-bitmap.c: typofix in `find_boundary_objects()`
In-Reply-To: <cf49115db4e8dcd406a17c946659c2eef3ec6045.1732229420.git.me@ttaylorr.com>
	(Taylor Blau's message of "Thu, 21 Nov 2024 17:50:43 -0500")
References: <cf49115db4e8dcd406a17c946659c2eef3ec6045.1732229420.git.me@ttaylorr.com>
Date: Fri, 22 Nov 2024 09:39:07 +0900
Message-ID: <xmqqiksgdrv8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> Fix that by correctly assigning the value of 'revs->tag_objects' to the
> 'tmp_tags' field.

Makes sense.  This breakage would make no difference in practice
right now, as {type}_objects members of the rev_info structure have
always been all flipped on together since their inception at
3c90f03d (Prepare git-rev-list for tracking tag objects too,
2005-06-29), so the original value of the tag_objects member is
always the same as that of the blob_objects member.

A possible alternative "fix" for this typo could be to unify these
{type}_objects members into a single .non_commit_objects member in
the rev_info structure; given that we (as far as I remember) never
utilized the "feature" that, say, we can ask only for trees but not
blobs for the past ~20 years, nobody knows if the apparent "support"
for that feature is subtly broken in multiple ways (and one of them
you just fixed with this patch) and the "feature" may not be worth
keeping.

But neverhteless, this is a correct thing to do unless we decide to
rip out the support for individual types.  Will queue.

Thanks.



>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> Noticed while I was looking for an example of this pattern somewhere in
> the codebase and was surprised when I found this typo ;-).
>
>  pack-bitmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 4fa9dfc771..683f467051 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -1270,7 +1270,7 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
>
>  	tmp_blobs = revs->blob_objects;
>  	tmp_trees = revs->tree_objects;
> -	tmp_tags = revs->blob_objects;
> +	tmp_tags = revs->tag_objects;
>  	revs->blob_objects = 0;
>  	revs->tree_objects = 0;
>  	revs->tag_objects = 0;
>
> base-commit: 4083a6f05206077a50af7658bedc17a94c54607d
> --
> 2.47.0.237.gc601277f4c4
