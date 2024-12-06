Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8E618C932
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 03:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455741; cv=none; b=n8/nXuxA9BwxwJVfGYKARZwraNhU+2S6QxAOSa/6YoK+0X/HqICnIGlcHnuoM6FZIkrNQ9pUXcwy5q4e9ETiP87JC6Jktnwo0lOXLYMOE4o6LIx6KEGuO33wCoCXfoX0h33+acWgWSHGIqe/W71BAb/cd/NdVj/rP/7rxRQBVFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455741; c=relaxed/simple;
	bh=zVbiicYIwCQs0m8E9urVrVV2WSXpRBkt9Qfb/zto/R0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t09snFRrMtVU8CLi/xuDoFny4tNx7U+ff8PDwmlht1VfRwL4yU42FLFnXwEKwl1DxPqgZsbW0aJCxuvA8ujzvYBe1ap9U0qdVbCvhKOu/Hkgwfn1GL/ZFHAZ/PnlDsSCagAZyjaU8Y2MeD4GRYj3uXR2HasmS7JFfP6losG0/K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BDFA5tR5; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BDFA5tR5"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 891A11140114;
	Thu,  5 Dec 2024 22:28:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 05 Dec 2024 22:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733455738; x=1733542138; bh=XPPcsAENmrnuw/dVNnSHkx98Kq0thdqUsiK
	Z0qfxnCw=; b=BDFA5tR5484NHQociYHbgbxmDBD1uSnSqR4VbKbjkDdp7iPpmrx
	NcnWrGzdtvb4qNdAGjLNGRPkbYO/pUGR90md7JymNiPEvrLmkCN8EMMC5tPhTS6h
	0drjUevcQkArHzK/MG+8wtGfbcgqBTGXu1STwBDrNjfLDd7eo/iMuUAfGFkF/fIc
	x37hacW4he1f/EKiWkdxqUwi7qYPWfF1UtxtulvvO1lodea78JrUpeBJ3qzNqEVI
	FQT+aTs82uf7GprzNjy4Kj8GMkzKomRBw8UqmTwqFQMbmq2If5SDoiG4ssaVCiqZ
	N4lci9xjKYRzqS9wEntaHhgCVIqXQaS16TQ==
X-ME-Sender: <xms:eW9SZ2egxVeUvVULAqb1jlBbKwclDnVXuKvsEHdiZmV64WE1NDOy9w>
    <xme:eW9SZwPyK2Yq1EbtvgmKhA0NbpeJI4e9rV9ORySnDfsX4DLK_wmx-_q9LXm5gj2oL
    ELUXCcKz2mm9CvbMQ>
X-ME-Received: <xmr:eW9SZ3gVSaisXqRtK5OLczkkK14KScGSGMtr5Itnh-zKyUq2paA6fMc9CH6_tzMNVBYbY9wMZHGTl8KzT-JSUWkYbXItvj9YLIs2XyE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieekgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhledvheeuieegudefgefhkeefleevjeefledu
    udekgeevffefgfekffefvefgtdenucffohhmrghinheprhgvfhgpphhrvghfihigvghsrd
    hnrhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsg
    gvnhgtvgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdr
    fihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoheplhdrshdrrhesfigvsg
    druggvpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidr
    uggvpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mh
X-ME-Proxy: <xmx:em9SZz9g628Ukvu3gZMtomYAhxW8kx5kE26jyckYzbhNz1jA98Phtg>
    <xmx:em9SZytZCLj9UewBl0xtUKdVQe11soqZe3RIXEehlJDe3VJoNM9myg>
    <xmx:em9SZ6E1NdqrJuh_e2AfSN9m6V3hUT6xBn3iidIH-ohCflr2DgA8IA>
    <xmx:em9SZxMN4Dd3rLB2fcnUPqSQG5z1sPyPBZl8UNaA8n5vihWuRxbGIQ>
    <xmx:em9SZ6Hyd727f_eaSCiEHQ0Qd1fsK8iM_P9ttHs_WRNbiyjPv-MHiq_E>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 22:28:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  bence@ferdinandy.com,  phillip.wood@dunelm.org.uk,
  l.s.r@web.de,  Johannes.Schindelin@gmx.de,  karthik.188@gmail.com,
  me@ttaylorr.com,  ps@pks.im,  jonathantanmy@google.com
Subject: Re: [PATCH] Fix `git fetch --tags` in repo with no configured remote
In-Reply-To: <b41ae080654a3603af09801018df539f656cf9d8.1733430345.git.steadmon@google.com>
	(Josh Steadmon's message of "Thu, 5 Dec 2024 12:27:20 -0800")
References: <hpaekjhdpcovhdptdntdligp5jcdp7mygh5brnggu7itf5grzp@vl4l7uwnb3n7>
	<b41ae080654a3603af09801018df539f656cf9d8.1733430345.git.steadmon@google.com>
Date: Fri, 06 Dec 2024 12:28:56 +0900
Message-ID: <xmqqcyi5zdzb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

> In 3f763ddf28 (fetch: set remote/HEAD if it does not exist, 2024-11-22),
> git-fetch learned to opportunistically set $REMOTE/HEAD when fetching.
> However, this broke the logic for the `--tags` flag. Specifically, we
> now unconditionally add HEAD to the ref_prefixes list, but we did this
> *after* deciding whether we also need to explicitly request tags.
>
> Fix this by adding HEAD to the ref_prefixes list prior to handling the
> `--tags` flag, and removing the now obsolete check whether ref_prefixes
> is empty or not.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  builtin/fetch.c  |  9 ++++-----
>  t/t5510-fetch.sh | 17 +++++++++++++++++
>  2 files changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b2a36a5d95..e7b0c79678 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1699,15 +1699,14 @@ static int do_fetch(struct transport *transport,
>  		}
>  	}
>  
> +	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
> +
>  	if (tags == TAGS_SET || tags == TAGS_DEFAULT) {
>  		must_list_refs = 1;
> -		if (transport_ls_refs_options.ref_prefixes.nr)
> -			strvec_push(&transport_ls_refs_options.ref_prefixes,
> -				    "refs/tags/");
> +		strvec_push(&transport_ls_refs_options.ref_prefixes,
> +			    "refs/tags/");
>  	}

Stepping back a bit, do we even need to learn where HEAD points at
in the remote, when we are not doing the "opportunistically set
$REMOTE/HEAD"?  Your example is "in repo with no configured remote",
which by definition means that we do not use any refs/remotes/*/ ref
hierarchy to keep track of the remote-tracking branches for the
remote we are fetching from.  There is no place we record what we
learn by running ls-remote HEAD against them, so should we even push
"HEAD" to the ls-remote prefixes in such a case?

While this change may hide the breakage you saw in your set-up, we
may be now asking to ls-remote HEAD even in cases we do not need to.

> Fix this by adding HEAD to the ref_prefixes list prior to handling the
> `--tags` flag, and removing the now obsolete check whether ref_prefixes
> is empty or not.

And if we unconditionally add HEAD even when we do not need to,
especially with the loss of the ref-prefixes condition that was
there in order to implement "learn refs/tags/* hierarchy only when
we are doing the default fetch", wouldn't it mean we may learn
refs/tags/* even when we do not have to?

> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  builtin/fetch.c  |  9 ++++-----
>  t/t5510-fetch.sh | 17 +++++++++++++++++
>  2 files changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b2a36a5d95..e7b0c79678 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1699,15 +1699,14 @@ static int do_fetch(struct transport *transport,
>  		}
>  	}
>  
> +	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
> +
>  	if (tags == TAGS_SET || tags == TAGS_DEFAULT) {
>  		must_list_refs = 1;
> -		if (transport_ls_refs_options.ref_prefixes.nr)
> -			strvec_push(&transport_ls_refs_options.ref_prefixes,
> -				    "refs/tags/");
> +		strvec_push(&transport_ls_refs_options.ref_prefixes,
> +			    "refs/tags/");
>  	}
>  
> -	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
> -
>  	if (must_list_refs) {
>  		trace2_region_enter("fetch", "remote_refs", the_repository);
>  		remote_refs = transport_get_remote_refs(transport,
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 87698341f5..d7602333ff 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -189,6 +189,23 @@ test_expect_success 'fetch --prune --tags with refspec prunes based on refspec'
>  	git rev-parse sometag
>  '
>  
> +test_expect_success 'fetch --tags gets tags even without a configured remote' '
> +	REMOTE="$(pwd)/test_tag_1" &&
> +	git init test_tag_1 &&
> +	(
> +		cd test_tag_1 &&
> +		test_commit foo
> +	) &&
> +	git init test_tag_2 &&
> +	(
> +		cd test_tag_2 &&
> +		git fetch --tags "file://$REMOTE" &&
> +		echo "foo" >expect &&
> +		git tag >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_expect_success REFFILES 'fetch --prune fails to delete branches' '
>  	cd "$D" &&
>  	git clone . prune-fail &&
>
> base-commit: 3f763ddf28d28fe63963991513c8db4045eabadc
