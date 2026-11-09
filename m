Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231687;
	b=Dcj5k3xrMQvvf0jlRjtf2UUfQqchQeUx4zelQhCpv2FH71VPHSGFXYyP541rNasumvKF
	 JohdJ6WjvOPq9lROYL1cCBw3Xw9K8w8e3Kxz6ryJb8Wx3hM6Gmi+8tzirkAvEIb0PnT9M
	 B+RUTZfrvtJw06wPO8VGx8BJcQv31/i+vCSalIGZatPzPGLixdQOjLpRnamdYeWz+Cz4Q
	 QC6nKp98Yqp2DZ0NoW1PXolTU6lnz4F7pRoppXO2oMGroliDvfs2ZaYS4f6dbh0r+XXzp
	 IPFLSL05oqEQpk4zQcSraN8Rg7Pw6MxRw5MTAm/y0GQcTv8yOj5kF7ytgZFLih37B8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231687;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UGnqZeg4KMfimfybEXveL2Wflch3zT2Kgzzl6Lsseks=;
	b=RN6OW6c+oGvrEbCw7bPN1qhrvr10U11i0A15siXCiB22fYQyELEhaFlBmF59+eXEAS3n
	 yRhoqyJgJiFYABCF9RVh1U8u2J6XuJ+ab8MCjajiCoHOrCjr+HHkMkyeYz4pT9VJMLuQO
	 s2SCNRUGOdw/X6g3iA3OQmPGAZPK8m1vP8DQ6ovEJ5w1EjqSe04TKOFKxVLUZ/qpiqDHL
	 QEuNjDHdVAoRnZwFLyKndhoHIMTtvIriMrGGVWiRem58Llqqi7jXz3M8Qid1QXkob7PGP
	 9JTjxJ7u8YQ9zGnjf8G9zDTSuv0aIx5VgJj9lb0lhNSvg98bVfGLZxZF9uSq0fL3h5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="ef4/yatN";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mxn6Qkqq;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E6F606A321
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 13:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92E6F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ef4/yatN;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mxn6Qkqq
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A694F7A00F5
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 08:41:25 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 09 Nov 2026 08:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794231685; x=1794318085; bh=UGnqZeg4KM
	fimfybEXveL2Wflch3zT2Kgzzl6Lsseks=; b=ef4/yatN8XCym4DZQysj4ubT9b
	plA8mQy98D4hxgpTGA/b3lVMsW8kxofYeGFSdZKPbfvwA//FkJmjN4Z/Am64XKaw
	YHtuXlUhrVfo+j6JcIHHvoVPIUka8gmTJvRTCyrgXqdwFjRpmi+3urFmCT+qdfHr
	QYyGdUwXqj/0BDJl41WskZ+T38dOtN/zxTn+mozsHca33qtRrhS3Kn3QV7DTpJtO
	KQ27RA+R4fWkUsc5nDFj5KDUBWvo8x7cchasEgztpVZZViWxtSm/mTC4+z1KXwuv
	Lkb+OYhZrYx0H65dsBGrS1w75opP7TIsfAPKWJPgwZsfSZ8bw6ffrAAVo+hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794231685; x=1794318085; bh=UGnqZeg4KMfimfybEXveL2Wflch3zT2Kgzz
	l6Lsseks=; b=mxn6QkqqKzWNzAIEsNQzNAhSqWs72mv3bDUZieaMJnUwDCmS2Z7
	8PXyj+eH/qgCl9RBtj6IAgOsGc7H8Y6YKMaX0L98lwfsfQQVa93cimRjVKGNEWFC
	EA/8dteiiAMBigi+toHqS4JSujsXqKcOmVHQWm6vfABqUzzZ3L85+A/sqNvEDIZ+
	VHo3vwl3dt0+bZMHP/q/nlyN2d6tR7LbhJjZ5S1bMUDZk7MZrfDJaReKxgyS5Ryn
	cxke0JP5zTQ7i8qcfdqvPCJ07sykZEctdAJUb267reLNt7hu2T+SLEeRrQngLTiE
	4Ff0aWwzrPQdFDuBDprCYF8JFAWHz6jdzMQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794231685; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Vkv+cMjkdSD31fF+4eEgQ6MhFQzrGf4+/nJFDGY1DJ1a7tP
	phsfhYHlkPF62ROEoFuYRYvdgUVgnmE2q6QBqGyLoddNI2SDk6cmipqfKIks0LEb
	HfKrhmCH3y+/+88KDFV8QBsH4LfIicPBRVgiE02WFqUreauBMWJ2CD1hSfzn7ZLN
	AxlWdgQ6TA+5Lw2M1eNXPkMQc33LbqtlbV6MFoeZCuHhBTDhuHfA0UoGE9NN8B6w
	c7LUDCIkyAqBbcUabjbt3CX8Jym53bI/xz1sTkfZ+pGozhPhbJC4bsEFdQUYOHQZ
	/USL7gHOdfjxeF37DRy55kzdS1X2ENvgPz7q45Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Qn5TYqBUj8BH9t3kLJZIlHRdFYNmWgUjVKJPNGmiWjs=:UoNOiR6WrnYLInD/6yoYnr/9nv1wC9BtP46xVyw4meg=;
X-ME-Sender: <xms:hc3xaiz0pd-RGE151CpmJO2AC6V1NlnrJ25YEaoMYJqNebD9D_Kv_Q>
    <xme:hc3xaud04cexDk005YvYGdqbHA4AkP_kqV_vWA_N4FL6wlJnvCyo09BcJV3_I7bNO
    3zqv1eOokyZlrA29u-qcmInPtE1kw8dV-qeNynWD0oh5ysgp1gRnZg>
X-ME-Received: <xmr:hc3xamKZ1OgFI0E5pwdfd14WxX7-Ggk5sJO0kQXZqwg5Oz3A39tyz7BWLHdZLqql7mLb5MM>
X-ME-Proxy-Cause: dmFkZTFSkcgLAGTIz4eLsFdebQc85I+7lBH0kWJDKwzn8YhBbsTyPs1O9lrnhDhJuwIgmI
    wr4GqOyKkvBO+t8vpMvlCF04dbzsOmgPtBoCvQ/H5YGpFuewd4OEN0WPJDRyt2Sb12ySav
    8OQ9URcqT/wAaucZYAUA5inQLzzZzxuU6kE/dn1x+vqhQfMm7ci57AAw2rYF63WZ3rsQ3T
    fgJWKOVMO3eIcszQ9RY4C98qJzI+SBZS4TQ/MIDXaQhBxovZJel6Ugi7vfR+8KLvrIyWiz
    Bk0GnMHTy/jjmYsBxwbu3yZIcRqNJiUD46KR1yKw/uEJp57Zh8nEp2ndokkultEtCxB9gm
    0F6mjl5SCjAUNI4Rz4KUlDlN1T8cqgtrWXEMETJehY9XNRQKuS70LNCnFNnYi0/ih7E9+g
    XasfZAnZVS3eMWzGt+LwimNA8mG77mATh6P3T7pZhoOfqn7M4OUPYiiCAF+ZHmpyhn83hY
    yqD83mBrxuQK1Tv3R+noqRCQG1SX+HimXTL6+2JKjV2nCXPiAHQRCKnlqbxD5Djyczdfc/
    uQ7ByATZMI423NdbYJpaK1R0GfNIFgXuhsNN365WAV7PAX4AJu+oEh0XuVgmvsOqj5d7CJ
    Oqy1S6nRo1xmFvRYLEV68x9DGXPAOdeDQ3faqXy822Fk7eyor2vvyJBHtdhw
X-ME-Proxy: <xmx:hc3xanHYcXBrKhOAk5Fk-p24jUc_6T0jJsT6NbYch2NB0aSyIHdJOg>
    <xmx:hc3xaoqZskx6RNNkOQSl6VRmJqS4kA6S-4nPVHD4sqQMPk6DZh8e5A>
    <xmx:hc3xaoQOyjBQ9H_Oh1uyYeaY4dlPSOw1jsU78MEIrcSPgVP298XT1g>
    <xmx:hc3xatO9lNo7DP6gARVV7AtKadGDVQ5uknVcpc9TuqsngiWjksybZA>
    <xmx:hc3xahZewKFiP5ejjsM6RCsygyJxK8h6vLwJAth99_Sn-5P1AVCYv3tL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 08:41:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ec9ef189 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 13:41:22 +0000 (UTC)
Date: Mon, 9 Nov 2026 14:41:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] unpack-trees: lose USE_THE_REPOSITORY
Message-ID: <avHNf-aaxdsyim7g@pks.im>
References: <xmqqtsltbfdv.fsf@gitster.g>
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
In-Reply-To: <xmqqtsltbfdv.fsf@gitster.g>

On Fri, Nov 06, 2026 at 05:26:52PM -0800, Junio C Hamano wrote:
> This file defines a set of fairly low level functions to implement
> merge and checkout behaviour, many of which depended on and can only
> work with the_repository.
> 
> Two key data structures passed around in the code paths, "struct
> unpack_trees_options" and "struct index_state", both have a pointer
> to the repository instance, and we can use it to make it work on an
> arbitrary repository, not just the_repository.

Okay.

> In any correctly written clients of this library file, the
> repository instance that is pointed at by these two structs MUST be
> the same one.  For now, make sure that is the case (and otherwise
> BUG out) by introducing a unpack_repo() helper function that takes
> these two structures (when available) and returns the repository.

Fair. It's a bit curious of an interface to have this kind of ambiguity.
But as an intermediate step I think the proposed solution is okayish,
and I do like that we at least verify that it's the same repository.

> diff --git a/unpack-trees.c b/unpack-trees.c
> index d6a859420f..79341d7fa6 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1,4 +1,3 @@
> -#define USE_THE_REPOSITORY_VARIABLE
>  #define DISABLE_SIGN_COMPARE_WARNINGS
>  
>  #include "git-compat-util.h"
> @@ -82,6 +81,56 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_WARNING_TYPES] = {
>  	  ? ((o)->internal.msgs[(type)])      \
>  	  : (unpack_plumbing_errors[(type)]) )
>  
> +
> +/*
> + * Some functions in these code paths get unpack_trees_options, which
> + * has up to two istates, and some get an istate.  These istates can
> + * be used to find the repository to be used for this operation.
> + *
> + * As these are all working on the same repository, they must match.
> + * For now, with a super paranoid check, make sure all potential
> + * sources of the information match before using it.
> + *
> + * Once this proves working well, we could just use the first one we
> + * find in a production setting.
> + */
> +static struct repository *unpack_repo(struct index_state *istate,
> +				      struct unpack_trees_options *o)
> +{
> +	struct repository *repo = NULL;
> +	const char *camefrom = NULL;
> +
> +	if (istate) {
> +		if (!istate->repo)
> +			BUG("istate->repo == NULL");
> +		repo = istate->repo;
> +		camefrom = "istate->repo";
> +	}
> +	if (o) {
> +		if (o->src_index) {
> +			if (!o->src_index->repo)
> +				BUG("o->src_index->repo == NULL");
> +			if (repo && repo != o->src_index->repo)
> +				BUG("%s != o->src_index->repo", camefrom);
> +			repo = o->src_index->repo;
> +			camefrom = "o->src_index->repo";
> +		}
> +
> +		if (o->dst_index) {
> +			if (!o->dst_index->repo)
> +				BUG("o->dst_index->repo == NULL");
> +			if (repo && repo != o->dst_index->repo)
> +				BUG("%s != o->dst_index->repo", camefrom);
> +			repo = o->dst_index->repo;
> +		}
> +	}
> +	if (!repo)
> +		BUG("no repository for unpack_trees()?");
> +	return repo;
> +
> +}

So this overall surprisingly complex, but I think it's sensible to be
defensive.

> +
> +

Nit: two empty lines.

> @@ -345,15 +394,16 @@ static void load_gitmodules_file(struct index_state *index,
>  				 struct checkout *state)
>  {
>  	int pos = index_name_pos(index, GITMODULES_FILE, strlen(GITMODULES_FILE));
> +	struct repository *repo = unpack_repo(index, NULL);

This conversion here raises the question what we want to do in the case
where the caller has both structures available, but we don't end up
passing them to the pointer. This could in theory hide a bug where we
have mismatching repositories when the entry points don't verify that
property.

I guess that's ultimately not much of a problem. But an alternative take
could ensure the propert only at the borders of this subsystem, so any
externally-visible function. And internally, we'd then only ever pass
around a repository.

But in the end I don't really think this matters much, so please only
take this as me thinking out loud.

Patrick
