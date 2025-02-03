Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0331EEA32
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569097; cv=none; b=AndgFeqPGoKuZTc3yrSA2sKUpUJMPtdHPfCB9DQcJkdverjJ9XTRtEH5Im5z6X2wA4NUirEp3Rl5SLP19d7JV+pFH0DMnEN8j1lAwP8GzGYSXzGf2Uwg0sXAT26LW0n2K5WHpo7JlNZBe/CWE/UMqd4WcAgknP9xhhAW5wCwBGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569097; c=relaxed/simple;
	bh=JR+08JVGYUWpt5RQSyrum9iLi6nFRVscWKxYn8alApM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ms4p8wxfnOEWlZkXaJ1cs4QdqV2qjzNyZ2twwrrrMZ+aU3CzC3GeR+nGPCnhfuoDjCw3wKkKFG8dh7NaAJ5TQjIVIB0CSKdrUgy1jK7t0th+nEUpvUKE5XQflkvAZ+V82j+TwmlfBt2lz4ULbboQ1NPLuPg2IpUgkHgWtzjNE+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NZ0I9mO2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=avIWT2WD; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NZ0I9mO2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="avIWT2WD"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7F13E11400AB;
	Mon,  3 Feb 2025 02:51:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 03 Feb 2025 02:51:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738569094; x=1738655494; bh=fnm2g1SnaX
	IQbyTnzffvO/24axKNHHNjZ8ap9XjNVbk=; b=NZ0I9mO2MpWg0DfOFUyZ7HteDe
	J5aAmyBlqkj9JTWOZKuRCo2kVeIzgsElLaaymM+4MKg9WiDmzlE/T4XtDLGBhJ0j
	Httml1uktw/E/quWsAoWQ6pPhk+mEN0GhNECAJznaHExgkSOUiyVdYl/yzziljFH
	jg62QgYs74ZUu0Zq9yXPY9/rDIqpaoTszC97hMVDcKpUwJB6MzLZ0UlaGwgsyJyE
	ITblkxGIbtgGRQ6k6FyjjNL1nqdgLr5OPbtyfQ5IJb9Inlh76RcxrgQOiGgUofkc
	1dGJFAiEGVUxUawnILP0ikC7nohsYp0p4Pq4sq+kUy4Gxkjf9hm0yjspgezg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738569094; x=1738655494; bh=fnm2g1SnaXIQbyTnzffvO/24axKNHHNjZ8a
	p9XjNVbk=; b=avIWT2WDUDtvtAMpk18k8Ox4jmCiloUfTsVQaOeZn2GZgjVL2Ul
	jXdc5SIJ5lIyklaPWhGMHlfHC6ph5DLIbze8u4AVDdDiMb7OK8AItUe7rvLMk5Wt
	VO9Gd+R508aNHuWYrMdphOR8ozJwOfsHu0kN5VlsxTyeEjCJcNZlTcDAvMi+EYsk
	yi/x0QcbCAuMyZm+J3lDkUAD7+FX/RFXJIP+UXZXkOAKSTay9ILKobtTUGCKYRJ8
	3GGjVOXkztJ64ZHYcUOHM5F/u/hYvB8BwwAPvFW3B0/zH6Vulo7xosyc3PPTMZb3
	HU5wRdNIOHbKYWF91SK+uUzoRCTwM5KT4Ig==
X-ME-Sender: <xms:hnWgZ5dUcoeQJL0EO_1vDsQvPZK3VxytB-0jjvBU4ZO4gCQnq3Iv2g>
    <xme:hnWgZ3PK15jtlNAxNqrlmPCGMy2L1cx0DxX_bTCmKD05vrAibup-zNYmQjypNCuTv
    HpQaDF-SyH7QzO4tQ>
X-ME-Received: <xmr:hnWgZyjdKEdKWsVzewNwHg4TmtHb0DrfK8bGYFf5936pQVxQzAqK-K1G2IrHUktxhx8fFjFiZfLm3iv00DSffaF3WiKtvuDMf58rR69-QKFUVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhsuhgthhgr
    nhgvkhesshhushgvrdguvgdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhn
    vght
X-ME-Proxy: <xmx:hnWgZy-G29he2K0SQ8M7IlBGfmOja2TdHdtPZMe758NDNpExq0WscA>
    <xmx:hnWgZ1sgnkGwqvCYcdmgr3fVBqi774FGszIBVbuEIcTl0FNhah-ZcQ>
    <xmx:hnWgZxElMEDInBqd9Ze1jC--xe8XHrRPC1vXRAAYnOA54EKudqzHSA>
    <xmx:hnWgZ8OfFvIoF9eA6jE5SbYVrKqeGZ-PFw9OLdVQnmomjirkfvfvDg>
    <xmx:hnWgZzVQ6np-NavChrD58xmlWZ8hEFfp1sVufZrLjJUsbzzZdwSMYaVC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 02:51:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8a1839c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 07:51:32 +0000 (UTC)
Date: Mon, 3 Feb 2025 08:51:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 5/6] clone: introduce struct clone_opts in
 builtin/clone.c
Message-ID: <Z6B1g1bkUpU78NUw@pks.im>
References: <20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com>
 <20250131-toon-clone-refs-v4-5-2a4ff851498f@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131-toon-clone-refs-v4-5-2a4ff851498f@iotcl.com>

On Fri, Jan 31, 2025 at 04:30:33PM +0100, Toon Claes wrote:
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 7ab156ac00240de89baca6533ed2541839286fc4..f92017c751dd31cb25a3ba31667b015d5766ce84 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -429,23 +436,27 @@ static struct ref *find_remote_branch(const struct ref *refs, const char *branch
>  	return ref;
>  }
>  
> -static struct ref *wanted_peer_refs(const struct ref *refs,
> -		struct refspec *refspec)
> +static struct ref *wanted_peer_refs(struct clone_opts *opts,
> +				    const struct ref *refs,
> +				    struct refspec *refspec)
>  {
> -	struct ref *head = copy_ref(find_ref_by_name(refs, "HEAD"));
> -	struct ref *local_refs = head;
> -	struct ref **tail = local_refs ? &local_refs->next : &local_refs;
> +	struct ref *local_refs = NULL;
> +	struct ref **tail = &local_refs;
>  	struct ref *to_free = NULL;
>  
> -	if (option_single_branch) {
> -		if (!option_branch)
> +	if (opts->wants_head) {
> +		struct ref *head = copy_ref(find_ref_by_name(refs, "HEAD"));
> +		if (head)
> +			tail_link_ref(head, &tail);
> +
> +		if (option_single_branch)
>  			refs = to_free = guess_remote_head(head, refs, 0);
> -		else {
> -			free_one_ref(head);
> -			local_refs = head = NULL;
> -			tail = &local_refs;
> -			refs = to_free = copy_ref(find_remote_branch(refs, option_branch));
> -		}
> +	}
> +
> +	else if (option_single_branch) {

Formatting: the `else if` should be on the same line as the closing
brace.

> +		local_refs = NULL;
> +		tail = &local_refs;
> +		refs = to_free = copy_ref(find_remote_branch(refs, option_branch));
>  	}
>  
>  	for (int i = 0; i < refspec->nr; i++)
> @@ -893,6 +904,8 @@ int cmd_clone(int argc,
>  	struct string_list server_options = STRING_LIST_INIT_NODUP;
>  	const char *bundle_uri = NULL;
>  
> +	struct clone_opts opts = CLONE_OPTS_INIT;
> +

Nit: There's a bit too many empty lines to my taste, without a clear
reason why.

>  	struct transport_ls_refs_options transport_ls_refs_options =
>  		TRANSPORT_LS_REFS_OPTIONS_INIT;
>  
> @@ -1343,9 +1356,13 @@ int cmd_clone(int argc,
>  	if (option_not.nr)
>  		transport_set_option(transport, TRANS_OPT_DEEPEN_NOT,
>  				     (const char *)&option_not);
> -	if (option_single_branch)
> +	if (option_single_branch) {
>  		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
>  
> +		if (option_branch)
> +			opts.wants_head = 0;

Makes sense. If we only want to clone a single branch, and we specify
which branch that is, then there is no need to fetch the remote HEAD.

> +	}
> +
>  	if (option_upload_pack)
>  		transport_set_option(transport, TRANS_OPT_UPLOADPACK,
>  				     option_upload_pack);
> @@ -1450,7 +1467,7 @@ int cmd_clone(int argc,
>  	}
>  
>  	if (refs)
> -		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
> +		mapped_refs = wanted_peer_refs(&opts, refs, &remote->fetch);
>  
>  	if (mapped_refs) {
>  		/*
> index bda10dd5c85ffd8988a6c3d39583e7b9701278b8..65d2de2c2051cf28def8b43fcca3fd5e1c86a0d8 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -219,6 +219,7 @@ struct ref *alloc_ref(const char *name);
>  struct ref *copy_ref(const struct ref *ref);
>  struct ref *copy_ref_list(const struct ref *ref);
>  int count_refspec_match(const char *, struct ref *refs, struct ref **matched_ref);
> +void tail_link_ref(struct ref *ref, struct ref ***tail);

Can we maybe add a comment explaining what this function does?

Patrick
