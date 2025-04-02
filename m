Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE281EF37D
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592407; cv=none; b=HghyrWa2HGXo1C+e2GNd9m0QKabQHzZiXocmpEELPwMnUkFdPh5ZnctKkdaiYMZqIukEJeZBYix3UVggAkDI/oKDNlAhsJw68d4G1U6JN5GPq+eFE9EtCB28XPK9bJjaraZNXfLOG1FuQfGdli0xM7jaASPCr2OGqWMqCOD7TcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592407; c=relaxed/simple;
	bh=epWWk/UdFtJi0yv/X8ACKEg9xKZKNfttrmPzsrgu9Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkynzggdKrQvMJVHhIXYFXy0JDDCC5jTf0OFmT8GodUOrOzmOdVRXIoMvQfyR8KeXCyFV3L3nC+pC2j1K6e2ty4aLrzsEISqt760qwMJH2ULTBBvGM9J7gGJhqFJZ9Jp/uG20VKd59lxzXiPZP+EDrTcRV+lpU3gdqGqn0ABywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eDvAasDb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OMI3gR5a; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eDvAasDb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OMI3gR5a"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 4D17211401F8;
	Wed,  2 Apr 2025 07:13:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 02 Apr 2025 07:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743592404; x=1743678804; bh=hZzPWMRU1m
	lNXmODPhnQpPIrkFFAgn/Uuw0KRMcEcVE=; b=eDvAasDbeKEmBsA4FECnF3qdfK
	diVQ/oEyxHTlz9gw0cKiU5QF18SjuCUsQGZNkE7tkYYCnhlN4DO//74C7Uf4txkx
	y27aSpWyCVjSyErN+KCaOOMuvocFcM2HaLk7hTGZx6sW+dNyQj7LELyuUca/1G8D
	Qie0rL3jEsSJ65LzJ0Hr5HwdWuIYF76bUL/+iRLEh9hkyw0MMNQMEwXMpOH4NPUy
	2lz1zefc8DNY3LZmX0RyzmccPmZnigKbohVronGLyvRsfFhw9XgiorQeQkqCI1b2
	E8YlLAYjJqWrxArCgwLEnawdw5FsiCkQT3siGuj/kmkLLnT4eVzUoJEW3s2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743592404; x=1743678804; bh=hZzPWMRU1mlNXmODPhnQpPIrkFFAgn/Uuw0
	KRMcEcVE=; b=OMI3gR5ambF4Dlw1vV6JuB6LLDqC0ttuyEmU38X1f5HjX8jxuxq
	vYZGnxD+kcbcCuMBBIvYasdOPWitsudLWvVKxQXwSGqLdJaCfDL20a5i+BAwzt75
	27WmCpKixTGCmF3TWllu++5TCfCoOZP0xP8fxEm3rizyVqsnVuOfClwFr3Ksx49K
	PtEjmTbFSjbMN0HYkHpdZzzWmfBGM2PZGZf9YwFBz6OCuhlaNX9tursM3FXlOFsZ
	8/oYX/Pu1BibackuiRMMB7AafDsQXzE0pIzrQNAJoRTQgf+x7VHeCB2o8JhQ1B2T
	eS45ftJ3FPNkxgmKSZxXfwUlR2CWeFJt+iA==
X-ME-Sender: <xms:0xvtZxcbnbO0_DuOE2h5jMgCKURE51-uaA6Mr_Emq-mB9uTeT1UwFQ>
    <xme:0xvtZ_NOZdOiTPTRWMGsPU_mEztnuJUn52sHCPIYWkbGyff2vf72hQTLJKH2ehBgk
    -C9Qc86LiR6n90zjA>
X-ME-Received: <xmr:0xvtZ6hHdYAs-U_YuTv8qF3QzYGMbO3Em4M5JcJw0JjmYPBB0Pr0Ng4V5fiMMKBOt0_J1YTeSi8HfGLxr-BBx5ShYBDR4Zj3X8SqLo0cSv1qOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:0xvtZ6_eExTslvoNM40OKLWmPUYA4n3eKALQjaKV2CVax-mDetxqNw>
    <xmx:0xvtZ9vOHq7zjBpvmEMy9Fz-AslMlwzGpRUvbR5_QVMpRKY-WSDSfg>
    <xmx:0xvtZ5Fxwe1uEIzrmIpf5CrtqL0SpdTrPytIASfpfsMGAQl5cK7PuA>
    <xmx:0xvtZ0Myr-kkf9oXr5SgS22Z3FTarMDSTixFrGy2Xv53H8sZpVn5iA>
    <xmx:1BvtZ3Nc57AaktOT1Xl224YD2JyaL_LEykJheUn6Tc82wh_1FGo9xiIy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 07:13:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c20a613a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 11:13:22 +0000 (UTC)
Date: Wed, 2 Apr 2025 13:13:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/10] builtin/cat-file: support "blob:none" objects
 filter
Message-ID: <Z-0b0VI2f-rJbxxb@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
 <20250327-pks-cat-file-object-type-filter-v2-3-4bbc7085d7c5@pks.im>
 <CAOLa=ZR4YmfHvQGvs1mzdtRu5z+8XW-xY+t_wBAoTs1m+rrO9A@mail.gmail.com>
 <CAOLa=ZRjhqsSxA7JCPPU4e1HFJBeK0PFgCZwPc07emp+2pawyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRjhqsSxA7JCPPU4e1HFJBeK0PFgCZwPc07emp+2pawyA@mail.gmail.com>

On Tue, Apr 01, 2025 at 05:31:24AM -0700, Karthik Nayak wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
> > Patrick Steinhardt <ps@pks.im> writes:
> >> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> >> index 940900d92ad..e783dbbad58 100644
> >> --- a/builtin/cat-file.c
> >> +++ b/builtin/cat-file.c
> >> @@ -472,7 +472,8 @@ static void batch_object_write(const char *obj_name,
> >>  	if (!data->skip_object_info) {
> >>  		int ret;
> >>
> >> -		if (use_mailmap)
> >> +		if (use_mailmap ||
> >> +		    opt->objects_filter.choice == LOFC_BLOB_NONE)
> >>  			data->info.typep = &data->type;
> >>
> >
> > I didn't understand why we need to do this, below we only check for
> > `data->type`. The only other place we use `data->info.typep` going
> > forward seems to be `print_object_or_die()`, but that flow is only
> > followed for `opt->batch_mode == BATCH_MODE_CONTENTS`. We already have
> >
> >     if (opt->batch_mode == BATCH_MODE_CONTENTS)
> > 		data.info.typep = &data.type;
> >
> > in `batch_objects()` before this, shouldn't that cover this scenario
> > too? Maybe we can add a comment with the reasoning
> >
> > [snip]
> 
> After playing around more, I understand now, we set the pointer
> `data->info.typep` to point to `data->type`, so when the data is parsed
> in `packed_object_info()` or `oid_object_info_extended()`, that
> information would be set into `data->type`. So we can skip as needed.
> 
> All good here!

I've adapted the commit message to better explain this.

Patrick
