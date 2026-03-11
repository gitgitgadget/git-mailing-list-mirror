Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C303B2FF0
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 07:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215065; cv=none; b=sVYnRNnh5VZB8tNMe3akFDssYT0ogeIwERWq6GLaWuQV2gA29H1pnVvYnEH/hOocwHQwIAF0tekUx05OK4KXLKmw4zpGZf3JAwAaY7Qn/ZNReL+2W9H2L0urpip3jeLmqAy4UVdJ8Sqcq57avujGZf2mkbsb2v+toT4m7Mhr/pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215065; c=relaxed/simple;
	bh=Zhu1PO4Kn0FydsshYmqEYnGnKakHrljtEHHLKFB/EPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rl1y+tMMPbeNrrHNuSrF0Q0nJDxMLwtE7q/9+yomb5YO5WHSLbZS4XS/RIeQ/4yzkjL24x8cA3/dVd/4vb85fKM38VF1LyonR7fgjgPVN3mv/Fq6Vv9DZO9iN6/WUPXSBnqj9zINbVTdlJbF3ycyLpcs6AfU2eo+Wj2WohqpJpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cAId/B3l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T2HKRzsc; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cAId/B3l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T2HKRzsc"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ADF127A012F;
	Wed, 11 Mar 2026 03:44:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 11 Mar 2026 03:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773215059; x=1773301459; bh=J4ERzlXdHT
	myxS8LBYIv5vrDGtUChozOyaPJiB9/6Ac=; b=cAId/B3lnT0VsT6hZJp+X3xrwp
	87wBo6UuyUlK66OnbH/QmegENuFoRIpPKvu3uKRkwLnQho529YghuQ1U0Gba774u
	ftJWhUEbdULXkyKeF5Pc1SbGWo0EOUtTlugBU3gd9GKqll5JjV3SW/JylDsh2X6W
	Hvj0+QeKTs+x4tl7rUZcJ+bphaojEqp4aRLfkCkjLAsE1U4eslU43qQjOBfQupCm
	NWPQ4IENuRwe4HKXqwi0KFqOZSyAbX10ZNZL/QjUmYbIWo5HcIrrLscnmudBl5eb
	3p8Q+llwRL4s/vnB58RQ4tkirEaIVJCxpcGmqPEefBn22YeWjgSex3Fys4kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773215059; x=1773301459; bh=J4ERzlXdHTmyxS8LBYIv5vrDGtUChozOyaP
	JiB9/6Ac=; b=T2HKRzscEmcSiJsoJv6YKcO8DEmD69j7Pd+ngqIO1tEe8DqA+N1
	ooKoZKtYpBFeBpjBdgGd32zdgQWzvkfNr9vA0WMd6UAg2ciHIVHvVe1XtBew7b8y
	2RoVvyqtDFQzHAoNsW8YsypzASzXzWChwtDDu+qN6F+35l/khs/A7OoUAxTbHC/H
	/RAdlkEPbKc/+9/mn5RVOHC0WAgzB+ZpAyHAP6ZL/HBLMKX6wbXMUzq55MW8rNoW
	+pxRNzEBsiLruAo76a6yuQtqcJVTGOC494h8WQ3leQY9OsKNZAvtO7/LL3Dffw1m
	Rtjqz4K9hGtZ9HjE4jGBzIKmSMMbq2dINBA==
X-ME-Sender: <xms:Uh2xacuxAnGm3is0jGJObrpcMBpw8_Ix7JRQCpSCSMbzgW9UekzlWQ>
    <xme:Uh2xacD1ua39OqvdV-9IevRJi9F8_y6trwleMycJpWtZzYF_UV9v4gnWDnHcS0Q1b
    m1VJmwclUBz_qrFu4ZgwN-KU8tZgUpjPNRhGNMSg2koMPbadnA>
X-ME-Received: <xmr:Uh2xabb3FZ-TgHC42K_h45c4OXsm-j_UcR5v8_dmaxJr5mdiG8EOg7mXMFgB-RWbRcIAvNNGTSOyb4jVKRGkS6M3NooWmFFLwRK40P1Hrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeffeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteduhfethfeuteehkeelfeehveelteeuuefhhfejtdevgfekleefveeihffhjeefnecu
    ffhomhgrihhnpehthhgvmhhoshhtshhpvggtihhfihgtuhhrlhhmrghttghhfihinhhsrd
    ihohhupdhgihhthhhusgdrtghomhdptghorhhprdgtohhmnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtg
    hpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhoth
    hhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheprghlrghnsegsrhgrihhthhifrghithgvrdguvghvpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhhtrg
    hnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Uh2xafWxPLaQC0uf0GFVUhnTCN0gzkt1lsWck0pVN8SVi0YTWZ_vNw>
    <xmx:Uh2xaSMTFiVUdsKZe9E35UJiZkmz0fbdWMTQUiUOSFRX6KgkCX-48A>
    <xmx:Uh2xaRZOfa8mwLpS8dqlcNah9-oqcdXQzaf_YSq_RYCd0SjB3JGl7Q>
    <xmx:Uh2xaZ__0CWrxe_cI9Eimn3orj5eHgBrGhIxGxEGzC1CU2N1eUME_A>
    <xmx:Ux2xaZ92jccS-Mp6h-iCzOLkFfQwXgIxCmXN2rnAbAs7iDOrxga8ZSud>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 03:44:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 79d343c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Mar 2026 07:44:15 +0000 (UTC)
Date: Wed, 11 Mar 2026 08:44:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Alan Braithwaite via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	jonathantanmy@google.com, me@ttaylorr.com, gitster@pobox.com,
	Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Alan Braithwaite <alan@braithwaite.dev>
Subject: Re: [PATCH v5] clone: add clone.<url>.defaultObjectFilter config
Message-ID: <abEdTQrRtAveH1rB@pks.im>
References: <pull.2058.v4.git.1772833649843.gitgitgadget@gmail.com>
 <pull.2058.v5.git.1772847236966.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2058.v5.git.1772847236966.gitgitgadget@gmail.com>

On Sat, Mar 07, 2026 at 01:33:56AM +0000, Alan Braithwaite via GitGitGadget wrote:
> diff --git a/Documentation/config/clone.adoc b/Documentation/config/clone.adoc
> index 0a10efd174..1d6c0957a0 100644
> --- a/Documentation/config/clone.adoc
> +++ b/Documentation/config/clone.adoc
> @@ -21,3 +21,37 @@ endif::[]
>  	If a partial clone filter is provided (see `--filter` in
>  	linkgit:git-rev-list[1]) and `--recurse-submodules` is used, also apply
>  	the filter to submodules.
> +
> +`clone.defaultObjectFilter`::
> +`clone.<url>.defaultObjectFilter`::
> +	When set to a filter spec string (e.g., `blob:limit=1m`,
> +	`blob:none`, `tree:0`), linkgit:git-clone[1] will automatically
> +	use `--filter=<value>` to enable partial clone behavior.
> +	Objects matching the filter are excluded from the initial
> +	transfer and lazily fetched on demand (e.g., during checkout).
> +	Subsequent fetches inherit the filter via the per-remote config
> +	that is written during the clone.
> ++
> +The bare `clone.defaultObjectFilter` applies to all clones.  The
> +URL-qualified form `clone.<url>.defaultObjectFilter` restricts the
> +setting to clones whose URL matches `<url>`, following the same
> +rules as `http.<url>.*` (see linkgit:git-config[1]).  The most
> +specific URL match wins.  You can match a domain, a namespace, or a
> +specific project:
> ++
> +----
> +[clone]
> +    defaultObjectFilter = blob:limit=1m
> +
> +[clone "https://github.com/"]
> +    defaultObjectFilter = blob:limit=5m
> +
> +[clone "https://internal.corp.com/large-project/"]
> +    defaultObjectFilter = blob:none
> +----
> ++
> +An explicit `--filter` option on the command line takes precedence
> +over this config, and `--no-filter` defeats it entirely to force a
> +full clone.  Only affects the initial clone; it has no effect on
> +later fetches into an existing repository.  If the server does not
> +support object filtering, the setting is silently ignored.

This all reads good to me.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 45d8fa0eed..1207655815 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -757,6 +758,47 @@ static int git_clone_config(const char *k, const char *v,
>  	return git_default_config(k, v, ctx, cb);
>  }
>  
> +static int clone_filter_collect(const char *var, const char *value,
> +				const struct config_context *ctx UNUSED,
> +				void *cb)
> +{
> +	char **filter_spec_p = cb;
> +
> +	if (!strcmp(var, "clone.defaultobjectfilter")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		free(*filter_spec_p);
> +		*filter_spec_p = xstrdup(value);
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Look up clone.defaultObjectFilter or clone.<url>.defaultObjectFilter
> + * using the urlmatch infrastructure.  A URL-qualified entry that matches
> + * the clone URL takes precedence over the bare form, following the same
> + * rules as http.<url>.* configuration variables.
> + */
> +static char *get_default_object_filter(const char *url)
> +{
> +	struct urlmatch_config config = URLMATCH_CONFIG_INIT;
> +	char *filter_spec = NULL;
> +	char *normalized_url;
> +
> +	config.section = "clone";
> +	config.key = "defaultobjectfilter";
> +	config.collect_fn = clone_filter_collect;
> +	config.cb = &filter_spec;
> +
> +	normalized_url = url_normalize(url, &config.url);

`url_normalize()` will return a `NULL` pointer in case it cannot parse
the URL. We need to be prepared for this, otherwise we might segfault.
I guess the best route is to simply ignore the URL in that case --
otherwise, we would always error out in case the remote has a weird URL
configured.

> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index 1e354e057f..1254901f3e 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -722,6 +722,124 @@ test_expect_success 'after fetching descendants of non-promisor commits, gc work
>  	git -C partial gc --prune=now
>  '
>  
> +# Test clone.<url>.defaultObjectFilter config
> +
> +test_expect_success 'setup for clone.defaultObjectFilter tests' '
> +	git init default-filter-src &&
> +	echo "small" >default-filter-src/small.txt &&
> +	dd if=/dev/zero of=default-filter-src/large.bin bs=1024 count=100 2>/dev/null &&
> +	git -C default-filter-src add . &&
> +	git -C default-filter-src commit -m "initial" &&
> +
> +	git clone --bare "file://$(pwd)/default-filter-src" default-filter-srv.bare &&
> +	git -C default-filter-srv.bare config --local uploadpack.allowfilter 1 &&
> +	git -C default-filter-srv.bare config --local uploadpack.allowanysha1inwant 1
> +'
> +
> +test_expect_success 'clone with clone.<url>.defaultObjectFilter applies filter' '
> +	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
> +	git -c "clone.$SERVER_URL.defaultObjectFilter=blob:limit=1k" clone \
> +		"$SERVER_URL" default-filter-clone &&

Do we want to "test_when_finished rm -rf default-filter-clone" here and
for all the subsequent tests?

Patrick
