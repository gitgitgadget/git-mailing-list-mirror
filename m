Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B316D3C09E5
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892612; cv=none; b=ooTDSgESv7pq+3QfEUMEPvV/sXHEtCBw0gXUluZiyf8BLNqI+yU0XIRUrkGrVna0jX5+PDo1U6r9vNiBW8LkqQfvCpOnnVrjQqEZH2XFaSs9f/7HYuboWMP8AuaSAGdwv7dfH/0uFl0DPmmoiZhg456pzb6M2YUvNX53pDBjrbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892612; c=relaxed/simple;
	bh=WDygkV6pw1ztwZi3dFqSXKUSPoTt3LXzt3yZi5lFrQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvnxdFJyqoAi+oQPJQeT9ByZ7mNhUTZH7kQXLLkstBhQmkEY8zQTzU/67lpbfaT5oNRUUz/2LjYDlb5G/SUAn+e4ZrHcOmMNLGm7ukTvrPcnkI6UK/4HroKt4U+NQsbRLW0EMefVFlq+nAIzHIxPJ17GXeXJt5VvYdUuoL4eSys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AncuMi+v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TOnPGBXm; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AncuMi+v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TOnPGBXm"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 06EDB1400042;
	Wed,  1 Jul 2026 03:56:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 01 Jul 2026 03:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782892611; x=1782979011; bh=yQDXgq3aRs
	SreOfL9iPi/72ICcF+wO5fmArvXUl7XVs=; b=AncuMi+vTqx41YNu4a7OXhDFIx
	gA8AHgzCqqYUuLRHhc3i3qdJ7EP6EsuSxLqdGwFAiYSeTp7XgBau/ytKJ9tn9Y8w
	AYSPapB3gcMv4k7xEGWStq2XquYV04Cvhwr5na2R4Y4OV+x2JcSTfv2SulGImwC7
	ReclqL//ZUDHh/kCtnoBbDUl5pi7J65nE/bKOvDBtfjwz6BLtu3aQGqxMuMDkSin
	mLeVOWGlw4V29+sJbP6CF8cLBzdhfD8us6P1V2K92yfsvV8vILVLRM+1LzTAr8XH
	uVI5mEpP4BG86Zqt6ncbMDJ5ChbbCM3rYArokeSWDRIEz98iJ8FW91AG2j9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782892611; x=1782979011; bh=yQDXgq3aRsSreOfL9iPi/72ICcF+wO5fmAr
	vXUl7XVs=; b=TOnPGBXm+F7EbIf6r78tJcL4Eu2tS3OvGl8pINqQe9RBI34vKIL
	VM5hJegKQb1uOBwuShKdC20+3W9VX8JAWuhdmI5AiwRW9eRpgQS7A0d841ELjrbG
	QJ/VQ/K36H58VELSxkctVsOKNhg7+hCpBOXQVouOvgUFlfn38yxioUW/ybdF5XrB
	MoQooz98OnG45/O0yCaNetefMU4o3d3osnbeYl7WOCgvnk5tlpluPtpPedu3Ijlj
	hODp1mDvos7ffOmPxZneSGByIJVe2fhyUgQeu8Kg/ljaRIsbm8qeeQkfsyeoa/XJ
	x/Bvyh/cNxmrkDtirt45T/3GIY07x7ZiPHQ==
X-ME-Sender: <xms:QshEasJl5EO3DHIwpQOcoEIBFzC-po0g7ZYhjaLmKLM3Sno3CYAn4w>
    <xme:QshEajmXVdgFAzb-bGvTHKqVjG4WfLQQYKrPXxeVTiDPBQRm6jChn28GAiww6ftxm
    Ujc0LdWaPUP_2sTrluS20DQy68cLSDVQvkLdjerjE-ObLiJHblfVQ>
X-ME-Received: <xmr:QshEaqGhWA0jXU6fEUR8BrWoLqGWxDVRqLOtAZXzKvrNasrIKvbrvpn2JbNpZ5qaHxrzdb9aM-p4BBBEgDhyC30246huSBSHR9Vk8VuK0aM>
X-ME-Proxy-Cause: dmFkZTEx2/Tpgugszdx3cqANsMdeLz2sgStOU/YZrKHnMLmJ1SrMlvve4gFx8sHmL8Zkls
    qkvo8niaL6JdzaJIBTnjlNI3jbiLNqMZQ68UqC4mPj7FrDr9qhEgS3yzqBVB0SJs09uqI+
    kkyTBzBMaY0vLeNE7Bh/E3f/ZuHYKXhAUyr0W+bb8jy4hVcNlQGFPG3pjdp7TWwOJVh5kj
    B+x+qoVgtSug0RoaTzaM5B285UhiBvzW/4aORCF2CJwl+KCgxUEv4atE0/OOcSe489J9FJ
    Quwx4l/plUyg1BOUVnhR5Xf1FUu94X856KTlI9WitY+D+ain7s5QMIleIbICigzvgCSNS3
    LiGXZLxsK9uAZGJA5jRytRVuc7dtqRQ5ASguWel4zInZtGGjhzFvMCNMLNXf+15i+qq7X/
    B51h+pMnY6jkrf992pOaYfEVxYZgMTc2oqB+sU3JHmn6ljrodWkPEbFiLijDHxXyDj8fbs
    DSMVMsQj4JoLlDdAJXDh3X+HDbgWz/5Io5lUvgPuq3oWJR3nlvJds5npoe2kCwMib3S2Jq
    kS8R8rTMxzPS+lfbGvddlEKpgkosRd1oAE9tdLd0qyfFT+Pd2sKEtBoOid/PLGflzQ/8Kk
    tl7Asmhy3p/z9nUScZR+HRWdF24KkOZ+4V8pRY2zKBWhUEMKLhE2oQU99ifA
X-ME-Proxy: <xmx:QshEajH7KdcnT3LBkox6RTG0blkxX79CwWjRQLqz_OVfuxttNBKlqg>
    <xmx:QshEanN1G87hG2Yc8g8h18D7Xp26FNondaQxOwBYyNtys1-QVrJy6w>
    <xmx:QshEaiHVy3eAsjVw_3_IJPfKB2hWXG78AlphQNN7myOyttV63Ly9PA>
    <xmx:QshEauNuhKlG6U9bGfNpKsnCSxRa3ObaFdHdU8k-QImNHYwGEH9-cw>
    <xmx:Q8hEaiGj2nSppoXwGCqD-S9Y_-mMAL5n8IBum2fs5_UwgiWyIVlxD43i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 03:56:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b32c5a61 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 07:56:49 +0000 (UTC)
Date: Wed, 1 Jul 2026 09:56:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 01/13] load_one_loose_object_map(): fix resource leak
Message-ID: <akTIAGKOS2uUcuZG@pks.im>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
 <17242c249f0beb387fd30634663f13ce42d34f79.1782889472.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17242c249f0beb387fd30634663f13ce42d34f79.1782889472.git.gitgitgadget@gmail.com>

On Wed, Jul 01, 2026 at 07:04:19AM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/loose.c b/loose.c
> index 0b626c1b85..47b7f5ec38 100644
> --- a/loose.c
> +++ b/loose.c
> @@ -65,6 +65,7 @@ static int load_one_loose_object_map(struct repository *repo, struct odb_source_
>  {
>  	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
>  	FILE *fp;
> +	int ret = -1;
>  
>  	if (!loose->map)
>  		loose_object_map_init(&loose->map);
> @@ -98,13 +99,12 @@ static int load_one_loose_object_map(struct repository *repo, struct odb_source_
>  		insert_loose_map(loose, &oid, &compat_oid);
>  	}
>  
> -	strbuf_release(&buf);
> -	strbuf_release(&path);
> -	return errno ? -1 : 0;
> +	ret = 0;
>  err:
> +	fclose(fp);
>  	strbuf_release(&buf);
>  	strbuf_release(&path);
> -	return -1;
> +	return ret;
>  }

Makes sense. There's no `goto err` before we assign `fp`, and when the
call to `fopen()` fails we return via a different path. So the added
call to `fclose(fp)` is fine.

Patrick
