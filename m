Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553217;
	b=GiSC1nyhp1YmiBSSZ2f22FGXR1BdqmEykHUefl0h4Yf0LvejmfKs+M14mUi4+j+Tq9tB
	 XWnRd3WXmsX7EmHy6OtMcPEdpEEVMkH2IUxeu//KTW/WFlRhn9eglcdV0/91crACh3Vdf
	 j3tcklnO7OBv5KFRw3VRdI4oao4Us7B/lvDNW5Pxo5MfQe//WSzchS5V3XleBLWlAvEJJ
	 MmnPdM3LSPFjhfhht8ZCFqgFlx6KHe43+U1ANjEXpMsfcdaiOYRQ7sM/rLhQ3gHIbZibx
	 GnDMWedCsPgsoi8SMkUSH2F2VJhZNnQAJOzKGLcqkLK9vQQLZXdRoJ+o4IQoEk1UjhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553217;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EHRsWTy2RRwQeAvyT2SkCHisZnVxly3Wgrg43/Zh9jc=;
	b=AguWSnBTqRCR110ATZ9fCuyN8moQbT0SKYi8K7bMFTrqFbke9s/lSuirJH7CguFhR+mU
	 VpqoBbhNLwAD8qAhPuu+syN1aS0OPJN8npYtU+r9p9wA+zpjjAeKUOsEeWVC5V5VSFJZN
	 XIM38HfPL19knAKUmu47s7bXfS9oi/21ZnpOz9EY/hbmPrlGvtFodv/dYGxQHUzAxz0JR
	 gScUozLYpq7fgCqYbcXNLhHFbF4FPDhp1DEW9BPh98yYaXQfqfpXPAy1Go2VyaOMoUgNO
	 sWXkb/085bzRfY54+tLIDSZQwjCRihRrJQVdzIqwDd6KF+2Z61i3BGIv9aYiOzUwh0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Z4QT9lcG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SZVyRtH4;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4084F606A31C
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 07:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4084F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Z4QT9lcG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SZVyRtH4
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 332527A0387
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 02:00:15 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 13 Nov 2026 02:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794553214; x=1794639614; bh=EHRsWTy2RR
	wQeAvyT2SkCHisZnVxly3Wgrg43/Zh9jc=; b=Z4QT9lcGWJMv+mNCvxA6dYkD1j
	PfqPAGQhq7Oklkfln0+NVxx8SE4NuiVRC8jVPLfANvZfuZ8mrCaOxUXehH4KCeTx
	cjwFB4m9Q3HwgD9peF4GN1efVVFU4SgMuDgIHWvQ6p1JnTWLoPHzQw2TbYvAWp//
	EjeNslvf1OQiEo5DAgTu8ufN0esXKCw9oiAtAO1KS3Il7Ht0EIBTbZn30ngernD0
	cTXu1DQ74KIXpqQTH8YKSJWJnJPMwwzNs15mrmQ5I3lBnp+8DTxtqBJY979jjJ4u
	XtfxR/SuBcblfqd5mChc/RFbar946iXZ7hXv/ezr5wm+dDkPFpf/b0Dl9bLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794553214; x=1794639614; bh=EHRsWTy2RRwQeAvyT2SkCHisZnVxly3Wgrg
	43/Zh9jc=; b=SZVyRtH4rwstrbRaW1weSpwpcUuNGXj9xSmW1BoFedbL7u2bA/B
	X9kv3Ld5FYxI8M34h3PrsaMC/sgfFk+yOFQJmtEz9lcPBzKahoHtDRphO1fCVfNH
	vK+tj6RUn/koVef4T95awOcluWmnkxvY9PaQwpuKcJ9RRqCAoyQOXOFv51JuXZiv
	BQ4w68Gu8uTF7eBofY7H/MeTHYYNC5cXM0VVm9FIESCZV/vSjCbbqvQbfxUHdEm4
	OpC+mNndjQEXRecgZD+4wg6T5x+Mvp/cfw3FRgOfLc6y4ESWxMviUwbsFy3FgHNb
	Ws+7DNvN24z+wF/fsKza1Ur2h4s+a3lbjRA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794553214; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:mzc6P271/yQIYyj5pbTIcwBEqxd9u6hDwkv1tmsm/CyWhi0
	VJBPj0NYuRdryGJJTKE8rclLrca8d0q/9q8p+8T/TinUM07X0GreDBQKy4mounBi
	kA4lQYek6ait3CNDV9pkc90em2h6RIRVCRmLOxtgoYxc67dJRQ2WZiBDLCu59Xb+
	ohFl02jTMG6AVKb+0awlxLw6rMsDBxr2wbwJ5Nm7soVDxGUae8bclLUaxk+Sg8fB
	0EI/k8nBHIMC+ko/b/mZBg/ljl73/2bcCgvHFBG81VshsE5+lQeOK159eoMoAZvt
	Z0HxwEUNLXJGYO9qQnvTK53k2SsUyNoSiMli3Xg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ZmKIJQactKXJIHY7vdCEddyk/8Mcl5V3um/Bwxm72qM=:ndoB74Ml0Q0mKQTLOxLShSC5RfWfNgw2iQC2uHwtYnw=;
X-ME-Sender: <xms:frX2ajq320jf4Gsc6KwWB4I5UUpnoRpKjmgyv-4gZDJ5R2wMmoc01g>
    <xme:frX2akgG0Lw2lQJde_k419qrdXXErEjT-UlA3YlxTBRcnkZ2c9p53XA-bucHYAvPr
    Ikcb8e8ymY3I7avwxjm9CSTSmtrOxaYDM656XrgVNKCg48_T3WYaQ>
X-ME-Received: <xmr:frX2aojvqSeY0iudjjFGH_ZciyKSEB_2bEZpQz62q2X4s_2MulQJbA>
X-ME-Proxy-Cause: dmFkZTEYN+CxyhlaeaE7gONuO1x2Lc8lX7jzb/8zjhjzOft9RDL03c37EMmXzXXe5mz7zA
    Sawynr1mHJ3mNWsL65q8tSyPLsAxYdUhwSe93KFH71ql29Zy/3/gHMx4lJWfowd71PsmnC
    hBaQ1qw7tgUx5ahrERl/Pfl2B9G7KSXz+D0dk8ZTZeBhFnQGoRpCRAv8G54gipQf/vCo5N
    GvGNMhsVJb3InwIv0hmUBz6B0wlXOhD6uSfQSWMmfECnuJEZcvw4/JO70sv1n0VLWn5Gov
    E5rxrwGQHfRpcyGbtI4/Ec4CKemz1ROUGsVPKvoqi9aYZQqTtr7npyD90oZcEGiMpqS/ot
    AAqcCMXb3RPeVU++LMbcG6S1KAaQYwbuHgEgPW0dBBet/tIP2ct/dxSBZi3dbl/n6zkJg4
    kuFyayIx3M9kDMSWUOOMYfV7eDKVKcpN57pVh55ccFQYexz/0S1fppnGR60UPv2rBl6PRj
    LYv7Q2k/byuw4h2IseMMz0Ri4tIXkSz/qsCQwpTdmPdtFGKQ2vQB5eRY5E6CFRjymfJ9C+
    Tp2vUlJ6VwmoX9ME8VCsDDkF6FTvDiHRiFnFCXabtyPnRTfD5tYGk8RR1V3iVxScLu0X+0
    o/CUeDGHGosB1SiR2Ae6XvdsHKKwQ27M1hBHHK8XPcxe7LyMqT4p9Eq+3aXw
X-ME-Proxy: <xmx:frX2aihXkNepbK4XG0_SBQsG664oMp0vfHLbdcv889uPcz2HLrvonw>
    <xmx:frX2agLJuLSFODYz-byBdxG4HvCokj07jkgblYupBv7gyMso0wGXfg>
    <xmx:frX2apG7GQVwNCy4MXYZFAQHt_ilvPu-HDHsGelz3JXBDNJcGDeglA>
    <xmx:frX2asRqXkgNkdDDVTxAYFh01R4g_TvvQBYyTSt4lAs3XqigBPxGMQ>
    <xmx:frX2ah76CXJz9suqcooVk7e1HsYdZbON3Ye0RTCMhrEJnJ0XkFka5dWc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 02:00:13 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cc2bcd19 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Nov 2026 07:00:10 +0000 (UTC)
Date: Fri, 13 Nov 2026 08:00:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Miklos Vajna <vmiklos@collabora.com>
Cc: gitster@pobox.com, jltobler@gmail.com, szeder.dev@gmail.com,
	git@vger.kernel.org
Subject: Re: [PATCH] log: make --follow following renames for non-linear
 history optional
Message-ID: <ava1ax5UFfcvkU_d@pks.im>
References: <avRtsm5VQpC_g9yN@pks.im>
 <avWBQ_10mHUNQcFi@collabora.com>
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
In-Reply-To: <avWBQ_10mHUNQcFi@collabora.com>

On Thu, Nov 12, 2026 at 09:05:07AM +0000, Miklos Vajna wrote:
> diff --git a/Documentation/config/log.adoc b/Documentation/config/log.adoc
> index f7dfce69b5..72a3486a73 100644
> --- a/Documentation/config/log.adoc
> +++ b/Documentation/config/log.adoc
> @@ -53,7 +53,9 @@ This is the same as the `--decorate` option of the `git log`.
>  `log.follow`::
>  	If `true`, `git log` will act as if the `--follow` option was used when
>  	a single <path> is given.  This has the same limitations as `--follow`,
> -	i.e. it cannot be used to follow multiple files.
> +	i.e. it cannot be used to follow multiple files and does not work well
> +	on non-linear history.  If `merges`, `git log` will act as if the
> +	`--follow=merges` option was used.
>  
>  `log.graphColors`::
>  	A list of colors, separated by commas, that can be used to draw

I'd think we should also document here that "merges" is expensive, same
as you do for "--follow[=merges]".

> diff --git a/builtin/log.c b/builtin/log.c
> index 350b35c556..db707877f6 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -505,7 +508,10 @@ static int git_log_config(const char *var, const char *value,
>  		return 0;
>  	}
>  	if (!strcmp(var, "log.follow")) {
> -		cfg->default_follow = git_config_bool(var, value);
> +		if (value && !strcmp(value, "merges"))
> +			cfg->default_follow = 2;
> +		else
> +			cfg->default_follow = git_config_bool(var, value);
>  		return 0;
>  	}
>  	if (skip_prefix(var, "color.decorate.", &slot_name))

I think we should use `git_parse_maybe_bool()` here, as we otherwise die
with "fatal: bad boolean config value 'bogus' for 'log.follow'" in case
it's not a boolean. Then we can die with our own error message.

> @@ -814,9 +820,14 @@ int cmd_log_reflog(int argc,
>  
>  static void log_setup_revisions_tweak(struct rev_info *rev)
>  {
> +	/* If --follow is not used, use the log.follow option. */
>  	if (rev->diffopt.flags.default_follow_renames &&
> -	    diff_check_follow_pathspec(&rev->prune_data, 0))
> +	    !rev->diffopt.flags.follow_renames &&
> +	    diff_check_follow_pathspec(&rev->prune_data, 0)) {
>  		rev->diffopt.flags.follow_renames = 1;
> +		rev->diffopt.flags.follow_merges =
> +			rev->diffopt.flags.default_follow_merges;
> +	}
>  
>  	if (rev->first_parent_only)
>  		diff_merges_default_to_first_parent(rev);

I assume that this change here is done so that "--follow" overrides
"log.follow=merge". Makes sense.

> diff --git a/log-tree.c b/log-tree.c
> index 83a3c4bf9b..93cc61af2d 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -1277,7 +1277,8 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
>  	opt->diffopt.no_free = 1;
>  
>  	/* Any recorded path for this commit? If so, restore it */
> -	if (opt->diffopt.flags.follow_renames) {
> +	if (opt->diffopt.flags.follow_renames &&
> +	    opt->diffopt.flags.follow_merges) {
>  		const char *stored = recall_follow_pathspec(opt, commit);
>  		if (stored) {
>  			const char *current = pathspec_single_path(&opt->diffopt.pathspec);
> @@ -1300,7 +1301,8 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
>  		show_diff_of_diff(opt);
>  
>  	/* Record what path each parent of this commit should use */
> -	if (opt->diffopt.flags.follow_renames) {
> +	if (opt->diffopt.flags.follow_renames &&
> +	    opt->diffopt.flags.follow_merges) {
>  		struct commit_list *parents = get_saved_parents(opt, commit);
>  		if (parents && parents->next) {
>  			struct commit_list *p;

Okay, and these two changes here disable the logic where we record the
changed paths on all parents, and that should get us back to previous
speed by default. Good.

As far as I've seen we only ever set `follow_merges` when
`follow_renames = 1`, so it feels redundant to check for both. But on
the other hand that's a bit more defensive, so maybe that's not a bad
idea.

Other than those nits this patch looks good to me, thanks!

Patrick
