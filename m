Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030118;
	b=BNbW0n1zF3veNVJLULjM6rNc204DC7OrzYINT13q0JUyTHefZ42IN92XD2BY3FQErJ8M
	 tr5PbhamU7t8wiXhOF8xIv0dThjPZYiTYqpSosqQMPw6X1cgQD+DgTHUKt6RQKFKwBvJl
	 BhVcP48YNf5gmxbeipDOqJ2gWmzuDeQKwZKqeX9VrvgCPQyfxyihtqwXRD3kuDP6RTLIb
	 Tmiz9li5/ewA2IbWEglPxAs6KguEu5TW36jNBwdsw7yfA5rONhJR+sF5GOfXJZOqpBIyF
	 1OhD437Dj6QGQPS2IzLhmW6uPMruc+qRQHQk6tyLEuJvpKfnDbRi7jabrc04g3dgLQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030118;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=OTbN7j13usX5JbG/Y+ycniioOjT7W0q2mHam58n6g3Y=;
	b=khNFylRdnZTPqWGgX/G6f/Y6QeJ50omR2wPZzXivvlHg91GCz/EmM6Y4BQDDjPVe3NA/
	 nDud//ETwk5ASO+U5JGsYe/iatzLtq6LxUil38kcstKLSIyOSnnatQblrr5r9uauRjDx6
	 dB750lZsadqcViv9PqkuZAj3thIQDZf/eSS1UXMVDKaMBIrGbD7WrslePNgPj8XuZFqiB
	 Ex8UgpIxLx3DyYfOIWhWTv3rGN51Jdd41sNdR/zNPR8ZgR1Cg9aU0goskuxMAIf9E1QtC
	 Ld6cGLCmg7EFu6ENQa/I9hlezvei8Xtqx4vun5S/2aolDgMZdp6/DBciSikOds9DifQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Tj5I9Xu8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Z1GsSikM;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E91960712AA
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 19:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E91960712AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Tj5I9Xu8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Z1GsSikM
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F08E8140012C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 14:28:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 18 Nov 2026 14:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795030116; x=1795116516; bh=OTbN7j13us
	X5JbG/Y+ycniioOjT7W0q2mHam58n6g3Y=; b=Tj5I9Xu82KOyjWDVIrTma3y9au
	0sHjEgFZtq30pg3bGdxl12uV6URoQoPXdBYKVXxSCU4yo7hrJnUYbgsF+aznfVaT
	aiqUwLpZYkmgbm/mwDcXJrrbYgeiFnIXIPwtppaB4FUjIFj8pi8Wfr2jJnVNkoK3
	2dC1aJenVstuDDjWOEf5umNN+4L22F3UObUKS/6SvCBg7MZoemwM3MS2XzoDN4KE
	3pM3FRxpOhzRdwhEF+06SrGAxsU6z5mjA9r4w0Ebk53YxqG+4jt/ACpkZIdJEYbE
	efqMwaG3ZEinhV9tX2daLj278eZ4podGAckY09Tn9Yeskf/bahfDZYWUhAcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795030116; x=1795116516; bh=OTbN7j13usX5JbG/Y+ycniioOjT7W0q2mHa
	m58n6g3Y=; b=Z1GsSikMBkTAG84n4MJ5S21ETmhgBJeeB0e95pzbt4iLphgZwrp
	6BM3wuyp2jrPk5Bj/NLPw9WFSD7Lh/paYTJ5QTReN0pmwITvV/RK8quYnkZiU/U7
	bC1NsX7K/aLgU0F9DBw1ha/YZEmzZVH9Xybf9nIN4NwSRMO7+0+Abnf9gUIgPGLK
	yA7059aHhluDgfakGJx+lZd8YpjC0PsPl3JNjpJE2AzsZDFFCmMzITmHLyXuujID
	lNcDFeCzCy1FjLZHZGvFoeE6Uz3wRqeKF+1Z6LqdqUnI4KaMWq36QHT5/ziy2VWT
	4oPVM4zySqVYe305jqhMFXlfaW4ORcsUObw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795030116; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:EvWDgr/4jpwqGoCR8suP+aOe0Z9I7AuTY226bvA2lcqSsGT
	qbug3A4huvakteQPKv6jFkpwl5kwJIFZs88Gfhh8wA9wPy577UC/o9DiTrW9bwBM
	B0SdU4PGqpWIuYpXldolWehDa2WVSDGj/RAoPQfjT57TaD70VrDlYKu/F0ipzzuA
	U39zBSQqCB9hZOK2zI15wzbDya5Ul6O84lQUboOxW2MpLy53NppuM+2KSiCBJkOe
	/gRLE1Md1A9cbYM1vcMiX0aUICYsCMSNjYFtFMHjt5g43PtLG3Yc2ExvlyUrYO3T
	v94lUuKDtiycKuD/Rt9CtsSbnhreMrn3MUESyBQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:WK1RNCHiZVLhhV2zAMZL2LPXp37lgPdykcYXEez8cl4=:LhIMWAWjckZcvu+um2ywAcXyYldreyXvBQQOT/EdijY=;
X-ME-Sender: <xms:ZPz9atcI0uj3PXlfGQRDm0bnjOXch7x4NpsPkvQJ2A54WgTm0CDOTw>
    <xme:ZPz9akhdgFF_tQpvHKYY_iwdAvP5mXqWgpFHywgZCcWH95HfXvhUIk-oFxTkRVCwH
    GcwfmzDrTD6Xm5jiGitHtW2Q7FKHcSKjoZfQhmVe0X5L8HdBbpJ8fg>
X-ME-Received: <xmr:ZPz9atw2TNynzl8nG47Id6dYHiNMQcDC0RutWZt3vfQ9l9l59S5TMIthO5GCWzix8cDnqXeJ_FMAkSvXlEkcX1doUVTFHevshpr3>
X-ME-Proxy-Cause: dmFkZTF67lkw4Elvbw9muKIZH6RcZ0P88QeFTS8dpExqptWwdWOPw1RYeqgzHqoPjacvrp
    88EzjOWA6Gw/hQpRhDZ+JQo447nvCeow4B9BQwj0c11L8/17cpqUpdUFOJSX+xYGaFIDnD
    2/l2o/MiL2qbrTpCiYIBFy0ABJwZcfKpO/jECO+c73T0FZpJFCbshIjQOzg4LclWi3gZtM
    S3PL4zWeDqCb7Q3WBnpRciQ2QqOb2Qo56yTDQF7eYYN/yBE58A+5bVIak8RQ2ouhUBE3xA
    2Tr2CPAcwpQESCgsnvBymf6fz+7QJlSQqDKO+DyTFbFt1t/aNbacBnEjOR2OsUKLRX9KBK
    y1ZpSeJx/y/LyD7UJJQd3Hc9Ml8D7j/yZQMfc4JgtblVjOj9DhqqCCzCRdPXEWPKzfpTUz
    6JQi1h+MzPGvEnJ6/jQDKQv/Lmp779cAaFNyGg8Q8/aovpuEfqzZkfxVvInKHZCBnINnAG
    vav5GEo/2mLSXoi5f/QncgdJZD0OrnlXlh/iwtlfCEvnWQya4BUn1mwfNabwfaHUDHRJ3E
    WfjVduHTRczH/eLSJND6D1UEZ9B+o9OOFAaHaWJHNjrEoWWPFe/13asrxkQ3OdNZfVLqk4
    y3jzBaMjUwYv1dYWiyqRe8U1cTc0LwmrSFozIeAXdv0culAcNHq+U5o2IFVw
X-ME-Proxy: <xmx:ZPz9aoMivS8MHu5CUKVjokskxnQ50b-p7Unzgy09bKiXK_Xgw-JcYg>
    <xmx:ZPz9amXaVbkFmV9Q22W1CO3rws4tjiXF04_1ST5FHJVFZs2O398kXQ>
    <xmx:ZPz9ak2_rvUvym5tZRHOXoB-g7RqNPKi5qYAai0NqIM8JDEKBRdzSA>
    <xmx:ZPz9asp9hqeJS1CxwTOedKAfimkSeCoOyWuezjEkSBI6-rmYUIHJiQ>
    <xmx:ZPz9ani4AuVEmBZz9OuF8d5m1Zq8ZD3EIIxl9sP4IFywEnLNhiYcc_4_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 14:28:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Andreas Wendleder <gonsolo@gmail.com>,  Phillip
 Wood <phillip.wood@dunelm.org.uk>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/3] submodule: only suggest submodulePathConfig when it
 is disabled
In-Reply-To: <20261118163249.1693361-3-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Wed, 18 Nov 2026 18:32:48 +0200")
References: <avuJBGlB3pRU3JU0@pampelmuse>
	<20261118163249.1693361-1-adrian.ratiu@collabora.com>
	<20261118163249.1693361-3-adrian.ratiu@collabora.com>
Date: Wed, 18 Nov 2026 11:28:34 -0800
Message-ID: <xmqqzev63pnh.fsf@gitster.g>
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

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> When a recursive checkout refuses to use a submodule's git dir, the
> error message ends with:
>
>   Enabling extensions.submodulePathConfig should fix this.
>
> This is printed even when the extension is already enabled, which is
> confusing: the user is told to turn on something that is already on.

The motivation sounds sensible.

> Move the suggestion into a separate hint, as submodule_name_to_gitdir()
> already does, and only show it when the extension is disabled.

Hmph, but submodule_name_to_gitdir() does

	/* validate because users might have modified the config */
	if (validate_submodule_git_dir(buf->buf, submodule_name)) {
		advise(_("enabling extensions.submodulePathConfig might fix the "
			 "following error, if it's not already enabled."));
		die(_("refusing to create/use '%s' in another submodule's "
		      " git dir."), buf->buf);
	}

which does not really check if it is enabled; it just hedges the
message by using "might fix ... if it's not" and lets the users do
the work themselves, which is not necessarily a bad approach to take
to simplify our job.

Similarly, builtin/submodule--helper.c:clone_submodule(), which is
another caller of validate_submodule_git_dir(), has an unconditional
"Enabling ... should fix this" message, which we may want to give a
similar treatment.

> Reported-by: Andreas Wendleder <gonsolo@gmail.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  submodule.c                                | 10 ++++++----
>  t/t7425-submodule-gitdir-path-extension.sh | 14 ++++++++++++++
>  t/t7450-bad-git-dotfiles.sh                |  1 +
>  3 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index d00d820d42..64cd8005f7 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2171,11 +2171,13 @@ int submodule_move_head(const char *path, const char *super_prefix,
>  
>  				free(dotgit);
>  				if (validate_submodule_git_dir(git_dir,
> -							       sub->name) < 0)
> +							       sub->name) < 0) {
> +					if (!the_repository->repository_format_submodule_path_cfg)
> +						advise(_("enabling extensions.submodulePathConfig "
> +							 "might fix the following error."));
>  					die(_("refusing to create/use '%s' in "
> -					      "another submodule's git dir. "
> -					      "Enabling extensions.submodulePathConfig "
> -					      "should fix this."), git_dir);
> +					      "another submodule's git dir."), git_dir);
> +				}

It is not exactly a new issue, but this makes an already too deeply
nested block even worse.  I wonder if the entire "if not dry-run, do
these" block should be moved to a private helper function to make it
a bit easier to read.

