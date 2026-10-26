Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003921;
	b=ZwvGW9MSyqC5IDwoGTtod/J1BtsO5GZOZJ5zSeK4eXIaGgaqmh+chUlQ/KAU+kgxCCPN
	 7cwBrNWLqspB4b7Pi23qN0rLTpC3uY0QkrP5QCwBbnAckQSCL7d8E0GH1MLvK/Hv7V88t
	 /oDhvp0jjdk916vV9RfSfRM3QDRcOCi6UMmcTmBAtdt4c6x+LCwzvjAtdSMYJJGSExPa7
	 hXcrdiLd3RuNK6DJEhFsWxxfMP7L2555TNqGSJDDC8YlY70awZnlYut/wEbW6J60axnrA
	 r9CzQYGLRz3IKYTQ99siuHY57r7bxc4c1mtdj77QuM5Nf1E64xv7wlqlQq0NePd3COw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003921;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wOrcYDgpnnnLLWEjaVLkIrRyXiqOeUmyTcHvklQBweo=;
	b=OFekNpcr46+TNBmeyRpQZwp7T8zop3g6Cf7IIMuMK7g4qgMFvHUTVmWP/6QkrfRioSfi
	 E1+FRRtaWGyIyFnltQdwchmo3QPWLCD9duuVhW+qacaiq8W8OnEBq+pU0q9VxrC9oQVtF
	 dtL1UJE0mhH04jny0ou2VUIM4QWcjiwoUmpkXfQauQEZViP40tfmgZ4OVBU4U89CMuLnM
	 ehH7/FOWcXD93wnhupCOALOPzokI4Hm4IWTM9WA8b6BDJNs1PbCtQSYsRitS/DhAMsV2j
	 TSTe6q9ejpUoR5ydJOx6C7Uimjl4+XaCjZAenIpVxRbS3v9tiy5G03JiveO8nUrNXzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=aI2dBcWa;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=y0b1yYr4;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FE5606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3FE5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=aI2dBcWa;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=y0b1yYr4
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 923681D001C7
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 04:38:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 26 Oct 2026 04:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793003919; x=1793090319; bh=wOrcYDgpnn
	nLLWEjaVLkIrRyXiqOeUmyTcHvklQBweo=; b=aI2dBcWadjs4yhZQ0h8AqWuB7R
	INxwktAZI2hQsVaFnHD+BqJjLO2mJA0kfLT6kSUhasL5xJ4nXw4PJVPFqdDeukvg
	N1cFc0sstPp4eiCoJcirsVq75fdQ5/7qEtnGqnfIdTJ0gTd5BmUI6pfM6PbCRn1U
	srV6+9bxN+1TqkMEZ0GApWbg2gi2Q7lx1JqRIguNDYZasSpBYbPDmVp6JNwA0Bjm
	IRvJ+2lWihpsBfIKzEWeEW8SMjFa5onHc5cNkyxTZNjMMINmrHdns56FM5+uF7BU
	tSCEcPbnBzzA2MvuhSjgg5L00Kr2e2ks10Dvob+RyhpIZG1eS3NOoo/RotbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793003919; x=1793090319; bh=wOrcYDgpnnnLLWEjaVLkIrRyXiqOeUmyTcH
	vklQBweo=; b=y0b1yYr4A1/Unh3iFu5lxz1EKVxANyGUYPeI4a051Nl/oVSlbaV
	8kH4cge8t+8AhQVJ98gvkOKcKKSVNxhb9LBYeUGB3SdDAfWsAGPx9u6ynLALL6XR
	ppffwskLSh/H4viOWfhugBL+UYnC8qaZ721Yyi+H9rNgk1pNppn50OxFZ8PkA8tn
	O/lJDrq+eIfIOgFvpKH0VNpT0eSY9EAhbdf9kzEFpuERdKC6eWRkfqAtXP+34qB3
	Af02feiw1glc5ddvvRhwCyzX5Yujr8HUpI0l/Ki69SeV/fLXw3w3hcNwYigxHtNF
	/ZO0vvVJpoSH9jLcVISrDvq6ACuyhdTUTXA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793003919; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:BSMVbjmz2Mv19p8BtgrPoB70q0jq4a0ucEHTnysot1Sbr1a
	RpnTR9XyvPKZGS9meskS8njS1EaA/Ff74KJzHfyPPQa3QemZtYg/PL/YCxMbSZUr
	59/TMKVuMfC/dLPFA0PxOUx7qGmO8LljFQcHMdt5/FOEgOzJFGY9BueC8aTR25bc
	RsnRUlVKZlEMALQbzg5VivyGgLTZos47la55YsdCiwseNCVYKFA8XpSMmKJcKuza
	cN9eCAzna0it/9DEPLU1UFpwkb7t8wwjmAbGf1JkSE0YMtTUq2B0jLB+0OIkDkxI
	u+k6PFr7lvV7MLLFAp2FYZccAZfLc1hTOs+WhbQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:2gjOAbZM7RkPglelUG6BYYy0w2drIM0hQMeje1x6th4=:IXWZ2c/DUW/Xq97Ei455uMwc93OJ0Ue7NnJjLHdxu6o=;
X-ME-Sender: <xms:jxHfasM8meHEQHTooHjhKP6P-DCo1DOAXGQjoybiIBgK8idnRjensw>
    <xme:jxHfaiAMA2czPzIM41DmvSYnwcJM6WvrfRviv33G2qkhorR1qcc7OaOrnmRZztycC
    hRoqFS4ppD20e_6ObS77sypy2Az_VzwsUGjQe9IpjiGP0ashYagcQ>
X-ME-Received: <xmr:jxHfapenPRom1K8SHiqJmTEuc0Nu7wpP9Aa31HySH3cqSmVgGHA00w>
X-ME-Proxy-Cause: dmFkZTFTXOCAeH9r/meAnRHRRrs5rlx0elb5k+QZdh5uP1zAM+7n8x+UJrhCNmfTCCkMzp
    LTBsJcvm6lH4RZmxsP2JYhNB6CLNdYhhha/4fFAtKVjQ/Bn09s4PfA9962mD9F6pYyhF4l
    reVKacZr9+N2E154acGCbXKczhCAeHlNQ/CkQQZpfc/i/qeKe2WfxuWN4Ygcdb6mWvLrqG
    YKEgXcikxASeNbUuzAlyavZ6Ox1uzJ0zrE1C4KY5WvEh+XBjhrfmd8AvkK+zKc32Te2bxU
    XIdNEelDMhZkwJ+Qvclihj3ZQDBq5DXeM6Ug517fywEj39YDYhlZ3IbPMzohECtCuJieij
    msuGiVToAJmh0a4YkWEaJPOb/FCmJY6YO++na5VgXxyTgYiVYK8PU5EpkdINvBNCTWW1lH
    IxZq31sWKiH3a4QU2thrzmAk3eOTIwyI6dfFMycIqGMo0OmBVBYBwx3+j/6aA9kDemRG2k
    G8ngtepT2WNd6Bt/P9UdpgF4fbmVJFxiH3eI8JhQJzjuCg2Rvoub9mckzuXR+qVMclcBvG
    QR2ADimait3YKOXteKmc111Q/TUAbwMI/vvCe9E7+DFpA5ZV0Y8gEbqsjVQQuFk7Zi+XZr
    uuljF88KlxkdFQSbfxyaxxStwtSigTwbU07VTkIF+v74Zv/sb6ctC/AcOTuw
X-ME-Proxy: <xmx:jxHfahMj73aH1qCOJbxAiQ2XoraylB3HIEHLBt7PnzDas35U-2xq-g>
    <xmx:jxHfapKPF3XKef5rpWKP3rLkZz0A9jGUFGbnxiDdHt1qxKDKjMUAEg>
    <xmx:jxHfahJLVd1CmPxBCHdvt1V44N-IC-mn0qzpNEz71JUIOwkEhUkUdw>
    <xmx:jxHfaj5zHjJfqJzOf6ru9ZVnYsBIThOJECQb5xGkLxfZ0mgmPS8JjQ>
    <xmx:jxHfajuTMQX-kNaEr2PdNa54TFSOGQ_GfTLrtfMD4ApH7qDAJDQ129XS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 04:38:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 60e2c5eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 08:38:36 +0000 (UTC)
Date: Mon, 26 Oct 2026 09:38:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Shashank S via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shashank S <shashu8660@gmail.com>
Subject: Re: [PATCH v3] prune-packed: remove USE_THE_REPOSITORY_VARIABLE
Message-ID: <at8RfoXGrC6s3km_@pks.im>
References: <pull.2266.git.1792341073005.gitgitgadget@gmail.com>
 <pull.2266.v3.git.1792833741913.gitgitgadget@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2266.v3.git.1792833741913.gitgitgadget@gmail.com>

On Sat, Oct 24, 2026 at 09:22:21AM +0000, Shashank S via GitGitGadget wrote:
> Range-diff vs v2:
> 
>  1:  6b583e1d46 ! 1:  0b474e3433 [Outreachy Patch] prune-packed: remove USE_THE_REPOSITORY_VARIABLE
>      @@ Metadata
>       Author: Shashank S Mogaveera <shashu8660@gmail.com>
>       
>        ## Commit message ##
>      -    [Outreachy Patch] prune-packed: remove USE_THE_REPOSITORY_VARIABLE
>      +    prune-packed: remove USE_THE_REPOSITORY_VARIABLE

Good.

>      @@ Commit message
>           to hold both of them together, and update the prune_subdir() and
>           prune_object() callbacks to read from this new struct.
>       
>      -    Update the builtins that call this function (builtin/prune-packed.c,
>      -    builtin/prune.c, and builtin/repack.c) to pass their local 'repo'
>      +    Update the builtins that call this function to pass their local 'repo'

Yup.

>           variables. We can safely remove the UNUSED macro from them because
>      -    these commands are all declared with the RUN_SETUP flag in git.c,
>      -    which guarantees that the 'repo' pointer will never be NULL.
>      +    while 'repo' may be NULL if the command is invoked with "-h", the
>      +    call to parse_options() will give the short help and exit before the
>      +    dereference occurs.

This still doesn't quite put the finger on what's important. What you
need to verify is that there is nothing between the `cmd_foobar()`
entrypoint and the call to `parse_options()` that may dereference the
NULL pointer. How abouT this:

    Update the builtins that call this function to pass their local
    `repo` parameters. As all of those builtins are declared with
    `RUN_SETUP` we know that they won't execute outside a repository
    and thus the repository parameter will be set. Unless the command
    was invoked with "-h" to print help, but all new uses of the `repo`
    variable are after a call to `parse_options()` which knows to exit
    early in case it sees "-h".

>      @@ builtin/prune-packed.c: int cmd_prune_packed(int argc,
>       
>        ## builtin/prune.c ##
>       @@ builtin/prune.c: int cmd_prune(int argc,
>      - 	for_each_loose_file_in_source(repo->objects->sources,
>      + 	for_each_loose_file_in_source(repo->objects->source,
>        				      prune_object, prune_cruft, prune_subdir, &revs);
>        
>       -	prune_packed_objects(show_only ? PRUNE_PACKED_DRY_RUN : 0);

Okay, seems like you switched the base of this topic. That's important
to point out as part of the changes to the previous version.

> diff --git a/prune-packed.c b/prune-packed.c
> index b6749b8d13..e02d5d7a01 100644
> --- a/prune-packed.c
> +++ b/prune-packed.c
> @@ -8,42 +6,52 @@
>  #include "prune-packed.h"
>  #include "repository.h"
>  
> +struct prune_data {
> +	struct repository *r;
> +	int opts;
> +};
> +
>  static struct progress *progress;
>  
>  static int prune_subdir(unsigned int nr, const char *path, void *data)
>  {
> -	int *opts = data;
> +	struct prune_data *d = data;
>  	display_progress(progress, nr + 1);
> -	if (!(*opts & PRUNE_PACKED_DRY_RUN))
> +	if (!(d->opts & PRUNE_PACKED_DRY_RUN))
>  		rmdir(path);
>  	return 0;
>  }
>  
>  static int prune_object(const struct object_id *oid, const char *path,
> -			 void *data)
> +			void *data)
>  {
> -	int *opts = data;
> +	struct prune_data *d = data;
>  
> -	if (!has_object_pack(the_repository, oid))
> +	if (!has_object_pack(d->r, oid))
>  		return 0;
>  
> -	if (*opts & PRUNE_PACKED_DRY_RUN)
> +	if (d->opts & PRUNE_PACKED_DRY_RUN)
>  		printf("rm -f %s\n", path);
>  	else
>  		unlink_or_warn(path);
>  	return 0;
>  }
>  
> -void prune_packed_objects(int opts)
> +void prune_packed_objects(struct repository *r, int opts)
>  {
> -	if (opts & PRUNE_PACKED_VERBOSE)
> -		progress = start_delayed_progress(the_repository,
> -						  _("Removing duplicate objects"), 256);
> +    struct prune_data cb_data = {
> +	.r = r,
> +	.opts = opts
> +    };

Indentation is wrong here now, even though it was correct in v2.

> +    if (opts & PRUNE_PACKED_VERBOSE)
> +	progress = start_delayed_progress(r,
> +			  _("Removing duplicate objects"), 256);
>  
> -	for_each_loose_file_in_source(the_repository->objects->source,
> -				      prune_object, NULL, prune_subdir, &opts);
> +    for_each_loose_file_in_source(r->objects->source,

Likewise, this is using spaces for indentation now.

> +		      prune_object, NULL, prune_subdir, &cb_data);
>  
> -	/* Ensure we show 100% before finishing progress */
> -	display_progress(progress, 256);
> -	stop_progress(&progress);
> +    /* Ensure we show 100% before finishing progress */
> +    display_progress(progress, 256);
> +    stop_progress(&progress);

Same here.

Patrick
