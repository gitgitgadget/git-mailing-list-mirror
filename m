Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920181;
	b=pyQkKVh7/eNOzkcKElyKqRhpUo/8vyeA6jIZHIdg6Zi9p0mHp7dXKPVObabn3v+bCmId
	 agU17BPvT5E+gXYhloiBLmOWoLNMtoreIOpKRpSQVSkJYbgJGJD03dfBRXZWYeayV9IhU
	 +TwSYCvRqo68kD5+CEdUHzefxgfx/VqYt1YTYh3KQt2cnk2EWUXQhrVfXFl/rNw+V/X4U
	 /HIwWvyiaJR0hykhEIxhCSIvC+yLVQ2ukIbbmi4eIqWln0KUhi/hggm+zY9NenRFq4hbZ
	 Lcm+kmFHYYDmSodLqAJGqpmSwMMrWvZZYSYPKFaRAw4urrmx+7Xo4aBfwOhyAw8YUOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920181;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=dX19/uNfQ/VAFqBxelZRqIk4I4vyBG37t2UaT9VMO4c=;
	b=FcBcwJjkdAxSOagpQgDzehU12syUkzmqgUSenQ5OAiEqSgwdZF6Hg8DXDSHF+A65+LbA
	 AWtGNayVYFT3xRBFwMBeCbhkUeP4km7ftY8+icp5u1xbwlYv02qr1xUhrtU40uH82B4mM
	 u/ZNuWoGLYEe1fQT5BuG7Djw+NuSpP6pDZHP8GTaJ9vgx8CUFlB10ZPB7rCLQyydcbqLa
	 sbMamGawhKLqlEItHCswMz7eH+HMRuVi0MSDDKqF9LOQ76/jAXv54rY7zzMyHZgTzMvKj
	 qRdnAQafhAyox/f8LyNy3Dvpf+nzbvf50Y/qtmc9dmYpwoL1E8dGo/q9+2Nk0Se6zfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=l1GplE20;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xbPMqYYn;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26256606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 23:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26256606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=l1GplE20;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xbPMqYYn
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 487BC1400123
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 18:09:40 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 05 Nov 2026 18:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793920180; x=1794006580; bh=dX19/uNfQ/
	VAFqBxelZRqIk4I4vyBG37t2UaT9VMO4c=; b=l1GplE20eBfChUdR1cGU3mPdAX
	rwK8EZvpKgTCXCGm77bWbNZjTFyF8aDsXHxAfNkP72G8yymOKqjJ/A1OzxtURubF
	zNVsvEGiMQs+laawXpJ3AzS/pVa0j9pjjvsIqskQa4HuEDS4cf9dkGNPPFke0ynS
	KVF1Lrsi51A7QxXd/JkW7x+ABF+Azq9OUeHcJu8Fb/ylpOeuyApzCcrSJgQDgqzo
	y//R28dcunE4VTAnAHzkf830FzgGpTgADpAnwNLqJgRqZ4rsxQyuA5AHvDgxhMEE
	CRG8OOCWYuNPSZP0uIIbRI9+vUe4/0NF+RLrpJCcBvHLnyeaC9PYe7QWmtfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793920180; x=1794006580; bh=dX19/uNfQ/VAFqBxelZRqIk4I4vyBG37t2U
	aT9VMO4c=; b=xbPMqYYnOGSknIdnoG+HJ1ahgYlLscHlj4FuNq28mmNtIOmGnNT
	n7oEAoEiIImqoa4jEGDcxh6Q2pWeFmm3siAcsQmrjgkdKSOYdC/PqqzhhHNzZzwq
	xvtQOhVA40w0Eh3gej2BZE8x5ACLVEP7VwAhAmDlvFNtjXZ6s/hltuf5CWuATemH
	6MX/QE7vvzcG6APvnQjIzr6fDSxRUzMaLGAkE7Q6mqUVlBZ7+sNCY4Z/b1+9+fVp
	LgEz3LaotbSYBfOFWyRrYsbFIMmEOkJh5c/L8e4Zo+HKKnnPGN0Whb7K2dzpIYnV
	yAOay7mOuCxas0cQYCQa+12X7j38jbbyQGQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793920180; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:G33HxDbBH9vetce1MbSTNXoCJzRHwfw/Sk5Ohe/WyxtpEfy
	IvOFprv35zKZKccSXaQov6JA5BpQDJmcv+5vADJvB7+V7vVksl07h4N3cCS6227Y
	CXewrtWJ4HtVsfzIdijphUbV98qIKEHc+70s22zGIWljQXnp54eWOMXZt+s7y+EL
	BXlIFkqYxoIWjeyLkNr7T4SJx2K5Kq0i5pJG21fa3kkjz+udwFMmUpfcYTyYyY5c
	r6I/jCan7fnf1AQKvEYoPtNwqGIVYf+Qfc0HnKMAs6DZPVmA2AOJY9IlYPfoBrCE
	aUZXvxrse7Idfx3SSOUcrmOptb4D23k8wAQwIxg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:8VAcAPVjx26pwdGnp8YsovQev+ECSS9bCLIn3qcu8EE=:3J+VDyXrZZZLgGlIpVOEljcrWBrMhUxtFgTjfUc7YBM=;
X-ME-Sender: <xms:tAztaoQIUhzoVTVsHpT2ybO301PzaIXnPiWdUD47MZ9dySKhKnsg7g>
    <xme:tAztapd5tQuqgsIkYfDwFG4ARn26qA_CxANhSFTMps6Rc-OK107_-aHpgKEsnBt5v
    yxfeS_ZdUSZtZT_WZRw6cxSPf0mIE2Oo8i55EOe3vYmND32shHiTHo>
X-ME-Received: <xmr:tAztavrJeVmOeE0g5z2y_7CZV0kc6VyvpHZ7WwrLx5Z6-ejcNYfO6Ar_QEXAEhDUOwNJ7ObYGHS7kMlyrVPxUg5QU4-FfPGQmO4H>
X-ME-Proxy-Cause: dmFkZTEwSCopI6+dRmDIec3hQ+eZlHvPxoZIgJnT4xSA2k/KWdCDItKw/QavyNq7zgQk/b
    wi39qfuhRvUbyyVgIYrBX1/0zPM4zuAlBu9GKvoLA/SpVO2vGDtohrT436/qEKz9NLRb/C
    IVYmt0J3AVJ0Xdy7ajpkKmnIbJn01XCwn1hF0hpsqoJe5xltmlTUVrbr4VfXiv8tn9URPX
    //IR3zPtQMQ0soIVM08wLF0vVVMnH02hB+Jd1QIPqI90YQaLJAb8ls0gw1DlGIdkk4tueD
    pybZQWl/+hH1ut3xrbEv/bR9o1tDXnwT1IXT9zpHEYHImLrxrdLsNSIXdz39poy0V+uKrc
    ywIJFlRUBbS9EH0dKG6XzCoukymF3lgmYRioTtfPdiXS+XTq85BRrE6eq1Im5YuQ7KbRYN
    Ip2yGbAoG0Wmlz8EyYjEr6rCXbqA12S7KTBgDkiM7fKssIyQHTOqigvNQRSHbfekOY4T7h
    v9fAdkJKNbgb8JP954jnuWKDNdUbMyvg7iJ7HEUi0bi+wDbz82CSZFNKbztr83JVZtP3Ks
    8+q0dW3RQ6AQk2dmEY8e/ijVZYzeSQg5didRZMieCz6dEfwjx9dpY7bZbpLww2XmlbfY4H
    xLypVzWkyswk/vu/uI21UUdoq9LG+LBAagqdk6ZuY53+oaYTdZLjkYwZij4Q
X-ME-Proxy: <xmx:tAztai8Lt2ZP76Sqj-aAe1jmuBqJuN3NZCpsoRlbX9PXPJOwFUSptw>
    <xmx:tAztajfMxaezPuLTv55aM_OO68Y0wxLQ79aJNo-Cc588gLDi_cGvXw>
    <xmx:tAztakJ8lajHTfMFmF_OYvkNu7qKFyxVeP6u8quKOnsRs66aYS_tyg>
    <xmx:tAztariqKey9CDSwWIxgaOh9ttnCipzDVSZBzkmfhsYnpXo8u2CdSg>
    <xmx:tAztah07nSSCbyEyPDdc0EcBLu4yvM8QRpRQqMnjWmg8potWItp9k31B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 18:09:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Yopa Nelly <yopatatchou@gmail.com>, git@vger.kernel.org,
  tangajoris@gmail.com,  kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy][PATCH v2] promisor-remote: honor
 promisor.fetchOrder when trying remotes
In-Reply-To: <20261105225223.1163975-1-yopatatchou@gmail.com> (Yopa Nelly's
	message of "Thu, 5 Nov 2026 23:52:23 +0100")
References: <20261104172434.691381-1-yopatatchou@gmail.com>
	<20261105225223.1163975-1-yopatatchou@gmail.com>
Date: Thu, 05 Nov 2026 15:09:38 -0800
Message-ID: <xmqq8q36q3il.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Christian, I thought you are the go-to person for promisor remote,
and if I am not mistaken, you worked on letting the server side tell
the clients which promisors to use first?  How would this mesh well
with that?

Thanks.

Yopa Nelly <yopatatchou@gmail.com> writes:

> From: Nelly Yopa <yopatatchou@gmail.com>
>
> When a repository is configured with more than one promisor
> remote, Git tries them one after another until the missing
> objects have been fetched. The order is currently determined
> only by the order in which remote.<name>.promisor entries appear
> in the configuration. There is no way to say "try this remote
> first" without moving config lines around.
>
> Add a promisor.fetchOrder configuration variable that takes a
> comma-separated list of remote names. Remotes named in the list
> are tried first, in the order listed. Remotes not named in the
> list are tried afterwards, in their original configuration
> order. The extensions.partialClone remote is still moved to the
> end of the list by promisor_remote_init() unless it is named in
> fetchOrder, in which case its listed position wins.
>
> The order is applied inside each of the two passes in
> lazy_fetch_objects() first the accepted remotes, then the
> rest so the existing "accepted before configured" behavior is
> unchanged. Within each pass, the fetchOrder order takes
> precedence over the configuration order.
>
> The parsed list is stored in struct promisor_remote_config and
> is re-parsed each time the config is read. Instead of sorting
> the linked list at fetch time, try_promisor_remotes() walks the
> list twice: once in fetchOrder order for the remotes named
> there, and once in the original config order for the rest.
>
> Signed-off-by: Yopa Nelly <yopatatchou@gmail.com>
> ---
>  Documentation/config/promisor.adoc |  11 +++
>  promisor-remote.c                  | 108 +++++++++++++++++++++++++----
>  2 files changed, 107 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
> index c1f3d766a6..ccc0925800 100644
> --- a/Documentation/config/promisor.adoc
> +++ b/Documentation/config/promisor.adoc
> @@ -31,6 +31,17 @@ This list has no effect unless the "promisor.advertise" config
>  variable is set to "true", and the "name" and "url" fields are always
>  advertised regardless of this setting.
>  
> +`promisor.fetchOrder`::
> +	A comma-separated list of promisor remote names. When Git
> +	needs to lazily fetch a missing object, it tries the remotes
> +	in this list first, in the order listed, then the remaining
> +	configured promisor remotes in their configuration order.
> +	The `extensions.partialClone` remote is tried last unless it
> +	is named in this list.
> ++
> +See linkgit:gitprotocol-v2[5] and the "Partial Clone Design
> +Notes" in link:technical/partial-clone.html[Documentation/technical/partial-clone].
> +
>  promisor.acceptFromServer::
>  	Controls which promisor remotes advertised by a server (using the
>  	"promisor-remote" protocol capability) a client will accept. By
> diff --git a/promisor-remote.c b/promisor-remote.c
> index 316d9950aa..c664a48f88 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -19,8 +19,11 @@
>  struct promisor_remote_config {
>  	struct promisor_remote *promisors;
>  	struct promisor_remote **promisors_tail;
> +	struct string_list fetch_order;
> +	int fetch_order_initialized;
>  };
>  
> +
>  static int fetch_objects(struct repository *repo,
>  			 const char *remote_name,
>  			 const struct object_id *oids,
> @@ -120,6 +123,29 @@ static int promisor_remote_config(const char *var, const char *value,
>  	size_t namelen;
>  	const char *subkey;
>  
> +    	if (!strcmp(var, "promisor.fetchorder")) {
> +		char *value_copy;
> +
> +		if (!value)
> +			return config_error_nonbool(var);
> +		/*
> +		 * The list is re-read from scratch every time the config
> +		 * is parsed, so start by clearing any previous entries.
> +		 */
> +		if (config->fetch_order_initialized)
> +			string_list_clear(&config->fetch_order, 0);
> +		else
> +			string_list_init_nodup(&config->fetch_order);
> +
> +		value_copy = xstrdup(value);
> +		string_list_split_in_place_f(&config->fetch_order, value_copy, ",", -1,
> +					     STRING_LIST_SPLIT_TRIM |
> +					     STRING_LIST_SPLIT_NONEMPTY);
> +		free(value_copy);
> +		config->fetch_order_initialized = 1;
> +		return 0;
> +	}
> +
>  	if (parse_config_key(var, "remote", &name, &namelen, &subkey) < 0)
>  		return 0;
>  
> @@ -157,6 +183,8 @@ static int promisor_remote_config(const char *var, const char *value,
>  	return 0;
>  }
>  
> +
> +
>  static void promisor_remote_init(struct repository *r)
>  {
>  	struct promisor_remote_config *config;
> @@ -180,6 +208,7 @@ static void promisor_remote_init(struct repository *r)
>  		else
>  			promisor_remote_new(config, r->repository_format_partial_clone);
>  	}
> +
>  }
>  
>  void promisor_remote_clear(struct promisor_remote_config *config)
> @@ -193,6 +222,9 @@ void promisor_remote_clear(struct promisor_remote_config *config)
>  	}
>  
>  	config->promisors_tail = &config->promisors;
> +	if (config->fetch_order_initialized)
> +		string_list_clear(&config->fetch_order, 0);
> +	config->fetch_order_initialized = 0;
>  }
>  
>  void repo_promisor_remote_reinit(struct repository *r)
> @@ -262,6 +294,8 @@ static int remove_fetched_oids(struct repository *repo,
>  	return remaining_nr;
>  }
>  
> +
> +
>  /*
>   * Fetch the remaining objects (given in '*remaining_oids', which
>   * contains '*remaining_nr' object ids) from the known promisor
> @@ -279,6 +313,24 @@ static int remove_fetched_oids(struct repository *repo,
>   * Return 1 when all the requested objects have been fetched, 0
>   * otherwise.
>   */
> +static int try_one_remote(struct repository *repo, struct promisor_remote *r,
> +			  struct object_id **remaining_oids,
> +			  int *remaining_nr, int *to_free, int depth)
> +{
> +	if (fetch_objects(repo, r->name,
> +			  *remaining_oids, *remaining_nr, depth) < 0) {
> +		if (*remaining_nr == 1)
> +			return 0;
> +		*remaining_nr = remove_fetched_oids(repo, remaining_oids,
> +						    *remaining_nr, *to_free);
> +		if (*remaining_nr) {
> +			*to_free = 1;
> +			return 0;
> +		}
> +	}
> +	return 1; /* all fetched */
> +}
> +
>  static int try_promisor_remotes(struct repository *repo,
>  				struct object_id **remaining_oids,
>  				int *remaining_nr,
> @@ -286,24 +338,56 @@ static int try_promisor_remotes(struct repository *repo,
>  				int depth,
>  				bool accepted_only)
>  {
> -	struct promisor_remote *r = repo->promisor_remote_config->promisors;
> +	struct promisor_remote_config *config = repo->promisor_remote_config;
> +	struct promisor_remote *r;
> +	size_t i;
> +	int fetched;
> +
> +	/*
> +	 * First pass: try the remotes in the order the user listed
> +	 * them in promisor.fetchOrder.
> +	 */
> +	if (config->fetch_order_initialized) {
> +		for (i = 0; i < config->fetch_order.nr; i++) {
> +			r = promisor_remote_lookup(config,
> +						   config->fetch_order.items[i].string,
> +						   NULL);
> +			if (!r || accepted_only != r->accepted)
> +				continue;
>  
> -	for (; r; r = r->next) {
> +			fetched = try_one_remote(repo, r, remaining_oids,
> +						 remaining_nr, to_free, depth);
> +			if (fetched)
> +				return 1;
> +		}
> +	}
> +
> +	/*
> +	 * Second pass: try the remaining remotes in their config order.
> +	 */
> +	for (r = config->promisors; r; r = r->next) {
>  		if (accepted_only != r->accepted)
>  			continue;
> -		if (fetch_objects(repo, r->name,
> -				  *remaining_oids, *remaining_nr, depth) < 0) {
> -			if (*remaining_nr == 1)
> -				continue;
> -			*remaining_nr = remove_fetched_oids(repo, remaining_oids,
> -							    *remaining_nr, *to_free);
> -			if (*remaining_nr) {
> -				*to_free = 1;
> -				continue;
> +
> +		/* Skip ones we already tried in the first pass. */
> +		if (config->fetch_order_initialized) {
> +			bool already_tried = false;
> +			for (i = 0; i < config->fetch_order.nr; i++) {
> +				if (!strcmp(r->name, config->fetch_order.items[i].string)) {
> +					already_tried = true;
> +					break;
> +				}
>  			}
> +			if (already_tried)
> +				continue;
>  		}
> -		return 1; /* all fetched */
> +
> +		fetched = try_one_remote(repo, r, remaining_oids,
> +					 remaining_nr, to_free, depth);
> +		if (fetched)
> +			return 1;
>  	}
> +
>  	return 0;
>  }
