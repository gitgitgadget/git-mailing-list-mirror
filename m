Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9530236D517
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 05:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774935076; cv=none; b=ihXaqDkaRvT3dASsG9Jv5bJm1QRmDLt0Ofpjl2DR4MoeV+Y/j6ORfRGpyTDJbB+tKKBQmp5mJoXXNcPBwFe2O7hbjXw2JWaBZgE1WvxAAadqf4ZWRGCHVI9YHBlb/k4I69nUuVLSNRViNunSf66hcddogdqp/1jEN/RsNP9E4co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774935076; c=relaxed/simple;
	bh=dG02wodvckat22CMwc0q5XgqghueReUBjo2Q2FoGwHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5A+bkuhahKQCaN1CZlmVX7qy/Z1icYgK9Ma0myQEaa/fwilGQjRP889jLC3fARU7SmLeF3Bj7WSd6pxrNUwzGTj+IOAVa9UGtEmuREZLCxHjIvcyX1iXZSRnKO/EOd/GcVYNZC/CG+rQQM/beRphLd6KsKxLwanJkuINIZpa0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ovOAYU3Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZJdVRCLT; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ovOAYU3Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZJdVRCLT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB0781400255;
	Tue, 31 Mar 2026 01:31:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 01:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774935074; x=1775021474; bh=bDVNmWuEGN
	Jmm2c+RAxlF1E64quR+S6ugtn0sdmYnIE=; b=ovOAYU3QZ487UT35qTD90UWwT6
	5JmXmiwfKf1xrwcl8W6gAPXcQ9mX6vjGsYljJ91s7+el4Uv22eVF2gdf1bE25bIC
	3yT/p49nxVoiCIjz1Z3W95uohUuvEkwPduZSgeSfDOXGNlSoYX7SejOd6toCggEu
	f+rno4DIa3o7eGbA1sww1JFhRzcNYZrVv+YrOKHEI+ZaC/ey7F3jY1uDsGVURWpP
	S7Gjaw6HMDdDhKmgCcK4CHNG83BmgweGz0cR6J41bxpcfUy5c0moK15POdcg5G0+
	t5TyYzJJUaxuaMgRnXrD8Yi6x051p0y3HlhV4O5wQWkYkm5ebw4cjdJV7e0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774935074; x=1775021474; bh=bDVNmWuEGNJmm2c+RAxlF1E64quR+S6ugtn
	0sdmYnIE=; b=ZJdVRCLTIiOx8rsUvpsEz8qSczmMaG9Q9YiByib5SGoG/5FYydN
	laCNE0KdLVs3G0Hq4yxrAuIdscjm8WKt34/2ntu17qvwzUcZMyD4q8r8oZ0B4Ex3
	tOXB2INHHj6FcNwBb0O32vlL+hfRm9JdgMqHV8Yz+b1/r0iS2eSzY+g9yPJmQDNc
	dMp5LwdsVAVlInMIGTJDsMLjGCjgalHYxwg59Gu9/ABdFnyGsU5T+bG7CfCr/MLg
	Q182eLm/IiFdoWsn2a2sjNtW9Mkzu2zXwVCFhkucN5W2BfpI6sLCduWtijiW8NiO
	ewCDjYZ6t+TUAxb2W3JnohLbVbWeowZhS9Q==
X-ME-Sender: <xms:IlzLabPDi1zO4zBPA4ON40ZJb2GpxjygiZ571PFP510F0s6BgP1pUQ>
    <xme:IlzLaZpmypPaz7Xhk29uXPAWmi6XScYsPKmbdlL_3Mkcf6rCeuDo_PvVHDGKPX6RA
    A1BPiIIkFBFD4if8BnIXFkxlpK8m76OGa9TWeA0-upjwshpaeZjbQ>
X-ME-Received: <xmr:IlzLaUFmFzC2Zqvdd9swSEH639tqtgoPTEF-e8CgM2iZ2qCr_aKeYKGFxSHYaH3vr5-txf2RtQbqwjcbiu6e7BP7cvtYYO_qwX7OUP7mJc4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedutdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgv
    rhesghhmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrg
    efudesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjhgrhigvshhhuggrghgrleelsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:IlzLaWpfrgUfPd1YVMEqumQRmpIaa-J_01GOeTykirNB1z0X01diQA>
    <xmx:IlzLaVarJV1bbeh_Tg0jG6JddSmzAIwchHnRcO_f4tR0fUvdx4-1vQ>
    <xmx:IlzLaXVWcZew-6seJyY-LEy8jwdgIAp9RK2suJIZMQffr4ZVpX_QCw>
    <xmx:IlzLaW9k04a448hZFz5jyCNzPbyfrr5wnJDgAWHr1eB8UkeD0QmptA>
    <xmx:IlzLacYovGMcBF3t8psDsiBt5mHZ9dIyOiPzjD1Of80C4dxR6T5uTubV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 01:31:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57487e25 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Mar 2026 05:31:12 +0000 (UTC)
Date: Tue, 31 Mar 2026 07:31:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jayesh Daga via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Jayesh Daga <jayeshdaga99@gmail.com>
Subject: Re: [PATCH] unpack-trees: use explicit repository in trace2 calls
Message-ID: <actcHT_ZHkb58ndi@pks.im>
References: <pull.2258.git.git.1774901607564.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2258.git.git.1774901607564.gitgitgadget@gmail.com>

On Mon, Mar 30, 2026 at 08:13:27PM +0000, Jayesh Daga via GitGitGadget wrote:
> From: Jayesh Daga <jayeshdaga99@gmail.com>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 998a1e6dc7..191b9d4769 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1903,7 +1903,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  		BUG("o->df_conflict_entry is an output only field");
>  
>  	trace_performance_enter();
> -	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
> +	trace2_region_enter("unpack_trees", "unpack_trees", repo);
>  
>  	prepare_repo_settings(repo);
>  	if (repo->settings.command_requires_full_index) {

The changes in `unpack_trees()` are a bit misleading -- while it reads
as if we don't use `the_repository` anymore, we still do because the
function starts with:

  int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
  {
  	struct repository *repo = the_repository;

So would it make sense to maybe have a separate patch where we inject a
repository as a parameter to `unpack_trees()`?

Once that's done we only have a handful of other places, and in all but
two cases we have a repository available via the index. Do we maybe want
to go all the way so that we can drop `USE_THE_REPOSITORY_VARIABLE` at
the end of this series?

Thanks!

Patrick
