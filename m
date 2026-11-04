Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793794944;
	b=p03dng/AC2yTD1l0Ss0rhXv4KPTxg1kDB6sYRoCKiotzfXm24kUoo7vxrJ3KmXx8d17W
	 vCgkRkXkMQjrsyg2AdPk0vkCnWM8IncA3yCWA8ZXYymRuPsgrC0EmMLdFc5e16VSfFkY6
	 EYkrZt4mjv4LZrN/noMsSayCEyOawQ+jSoxWym0p8BhB7Q2NXy3twH3WjfAQuiIM4YilK
	 Xk0sVgaCrDlgzIhV33OHI9RB4VrPz4JBuieHQkzwjiisOekDrcxX2hK9Va/mTviEfgoXR
	 VngkNmC8yFrGAfTBlF0P8snRNiRUK/y/WWO5d7XyQgLz0oLpXpP3St2WVMkpLZcxIVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794944;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MG3VHagkHGGzQaDuw335Wz+F0vgTNl56k+S/3nOb83A=;
	b=cyL75sg02Wyb4usctvkZikhA5D/YW0PB8nUiq0gMv/K1rPFbFFLbgGFRSI4ubMgh2stx
	 GcZsXQ3GgDqExprQoO9fk61S8zAM2XdJhUc4zInC+rZg7bbyOul6Hgn74aZSagmFcX4wk
	 Tf8SZ3mrJUEhCfgnBWOayTNornPzX7bY55ovxahvf8jhfwkVctVlOLhyn7DwFQaxstt38
	 68k9sOVdjYcMZCpoleoI2PyGsuCStQ2SwpeI1S28Lf40JiUSciQ5VYYJzI+Y/5r+mvajx
	 a7weFJMMhEsemu0SpvGYgUVOppimhd4U7+pGQD4pzzR2bVyFwIquLM9ija6hajP457w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=xTTU8Yep;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UgqFu6HX;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D68E606A334
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 12:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D68E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=xTTU8Yep;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UgqFu6HX
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 78797EC00D7
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 07:22:23 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 04 Nov 2026 07:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793794943; x=1793881343; bh=MG3VHagkHG
	GzQaDuw335Wz+F0vgTNl56k+S/3nOb83A=; b=xTTU8YepVOlH+9h2kdmLm6+5IJ
	VukUVSEzsGs+iK5ZpLYfDpQfEh4SSd1926MH8mC7DbuyvQZ8tsFeHqYnd4U9eCt0
	Dg+WuUhzGH4BBqw84tHD05NwDNBhlGV1IwnYMh+FBIvOvDyWqUJv1VMZ/a4WJc0a
	goZh/qXEyQNMUjJ2n8Pv/q3Db81sU7aGqJwkXuNMLGq0L4qTXt8KH4VsN/m6hOYg
	+l+y932QLGjDixQnapMUbMUYdoTkeAjFi1HlIBmjYDuPUObHs8z0gOAmp8cUxv9Q
	jpw3NgxWQBeVerv4ghmnL78TTo2OkYcRcgtpu6f+cMl6G872l3dZD51Y2uhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793794943; x=1793881343; bh=MG3VHagkHGGzQaDuw335Wz+F0vgTNl56k+S
	/3nOb83A=; b=UgqFu6HX8krcbFQbyNA59QEk8IKuvOke/bNbNJdKcwKzDSiW0/0
	PRKFT+JRcvACRlKPCmRHzlaWab0ypLPByjRcQDJkLwZbUEnGR+am7r8HdEQIInS6
	OhAeIj+zs9Znhl4aAOBIxFWtSPbyRktCgu1/vy8oo+GxhTutWOu/nDeAiSFpHtET
	TLIf51Yc9CBqp0WXnhMUAKRHsh7lwCRf2zrRHVXO363pDxMnsUAmrZh+ttbWPoVJ
	GB5MOKqFA53ISDgG+NlyrC0EwUKfZyZvGjFMVOJigjGWdS+Ojy0ae7m1SyFoDwIC
	RSh6cbSA6d980dYFvkLnIRJfbcfWbo94juQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793794943; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:wq2Iy0cEYM1FFsNidC7Peahqc9J+cN0Ia8TKiQkT0RN+Qlg
	ED3/V+VbDz7QXhDaMAN+/MYoqXlk8Arzre9Gc7MjUhInOrznqiCmb7/EWUDl0Iu1
	Ww9QojisMQsZOD6Kb99qc4gGZ0Kp7xSSWNEt7RxOQM80FPwqwB6PgjgJlOZb5l37
	HgtmKxEfBBvoSrMsPikJa8kJBs0cEW4AS7uGU13mPPuF6PhqtdP2XtkToi6NA2kj
	wHzsQUkGGLd0kmqFKjgUSIvVRzWFf8gHJJlmpaeceGhZMPGsKOQTvBrBFCPgtCpM
	Rn6cf+EDtugDAQjDPIznLg5KK+1pFu2eTIYfX7A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:kyxp0OOY8CxevL71t17gI/vKAC9lnZGkG44YQlr6Vlw=:g+fVTDHd2mSXV7rexoteEgaq22y6hB4IicP4lJQI6GI=;
X-ME-Sender: <xms:fyPraoO2KCCxRVqdJp9IpPLmRZZNmRL3EtYFvW3ZDS0810GhAoDesQ>
    <xme:fyPral8oQoOaM-bjnLJXD6KuA8gweA84YHlaVeYidt4MhwthCbFScl1nI44a2otUE
    p97rClr1KibozW_WQYjgT7xiNYKHs145xiNhkHaonO0ebQODTQ53w>
X-ME-Received: <xmr:fyPrakSY7lqity6mZPgGVIwI1Dilp9HNDgpCttffAs04ZWgqBSKeislP7jUxlq9wDsfFqIg>
X-ME-Proxy-Cause: dmFkZTEBvXpQ/AaijNR10qGAiGRzsogqCmdrZiG1Xl3qfRn88I4yQ2XcVKjvgmd11ugF1A
    u6IUjUAd4mKhV7YMnZXLrMpR4PL4ovOI2TzGTztF1UpvZnplgZvitVbn8RWbq5r9DhEShE
    C4f3BujMubs6lS/leJ7RNaT15Ti/43N9sa7nGs/oAlizHxFtrG048uePeA05VYAZhVOFk1
    wBHGE7/0SZkp22rtVj0djzf+Q/zwZzvqjZc5CPLw6EcgRI8Spjr18eiwTz8WYQPL+dBi0Y
    n4qDH2RGbC9/vZUJio/ZTniUnozwQPgSG7X/Nkcxyc+S+zE7i49fuOnkYINqQf2B2rMsiX
    glTube8wCP1lkVNKJ8GSCKX6eZrs6lQ3H4UCl7fLFM0vAbTs/D9aoDxOHW6+ZsdMqPkip2
    OfaWWcBwBFPFNvLHjs9iWioUzWg+RaiXnDT1hpav1EnltS+lqvvH8sQfsnq+ZJ4E86Vyg/
    CcCbpg28qEmPqIvbcDOyW+rcWP3CPvyOezvedT9/hC9pnzHjkEgUfr8OM2rcJ+z3/Z5VRV
    wsNKAlWweNtgOGogsnCEqZuG9/3ejaRqjpQ6Xu8xWebN7D9UH308Bom/wX7S2v7ISmJpmL
    Mvt72ByMf3GJHhZ/nYsUpoRDyIs43u9V5V44ixy/JIobARYgBCkFpi0meU9A
X-ME-Proxy: <xmx:fyPravn6M0Sd_NZdtdaBQ1a5ju3q2xHEvejYJrihVdz5_wfNe_4t_g>
    <xmx:fyPrasTHarb5HTD_L7zb1w1ASj-ZhNN7P3RlGBgpsdmpAWU1y8ncYg>
    <xmx:fyPralN0Nwr5drYU3wIXt5aKTJxV-Ax1pfM4niOAd0HU_rhkMfuqZA>
    <xmx:fyPratUsjuqCkIw92BaREfLDmUTiW0UqLtG9eB44n9YnKX7EwcCc1w>
    <xmx:fyPrasT4pLRGgq9AEChmARkvQqn3Wx3WPMTt2KholuwxnpnPadLE23bk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 07:22:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 39ff8ae4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Nov 2026 12:22:21 +0000 (UTC)
Date: Wed, 4 Nov 2026 13:22:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: Kristofer Karlsson <krka@spotify.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Lazy fetch in partial clone fails with "not our ref" since
 5946a564 (odb/source: make read_object_info() pluggable)
Message-ID: <ausjegMf8AM-URB2@pks.im>
References: <yrjh1p92qc7w.fsf@pohly-mobl1.fritz.box>
 <CAL71e4MqMdGk5ryhNxvVNN6Z02+45B933ZfUuvj4hM92N5a6hA@mail.gmail.com>
 <yrjhld78q06y.fsf@pohly-mobl1.fritz.box>
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
In-Reply-To: <yrjhld78q06y.fsf@pohly-mobl1.fritz.box>

On Wed, Nov 04, 2026 at 12:56:53PM +0100, Patrick Ohly wrote:
> Kristofer Karlsson <krka@spotify.com> writes:
> 
> > On Tue, 3 Nov 2026 at 14:31, Patrick Ohly <patrick.ohly@intel.com> wrote:
> >>
> >> Hello,
> >>
> >> "git merge" in a blobless partial clone fails with "not our ref" while
> >> lazily fetching a missing object. This started to occur today in the
> >> Kubernetes CI, completely breaking the merging of PRs. We should have
> >> been using git 2.54.0, the affected version, for a few days at least
> >> without issues, so it can't be ruled out that this is at least partly
> >> caused by a change on the GitHub side. We are about to revert to git
> >> 2.52.0 to unblock the Kubernetes project.
> >>
> >> [...]
> >>
> >> I bisected v2.52.0 (good) to v2.54.0 (bad). The first bad commit is:
> >>
> >> 5946a564cddc0bf471f27ae4c3fe205441e3ef65
> >> odb/source: make `read_object_info()` function pluggable
> >>
> >> The parent, 3bc3177ad7 ( 2.53.0.185.g3bc3177ad7 ), is good.
> >
> > Thanks for the detailed report.  I think I have found the cause: I
> > can reproduce the failure with your steps and make it go away with a
> > small change to the loose object cache.
> 
> Any idea why this suddenly started to occur?
> 
> We were using 2.54.0 for several days without issues prior to the
> failure. For example,
> https://storage.googleapis.com/kubernetes-ci-logs/pr-logs/pull/batch/pull-kubernetes-cmd/2117551425255903232/clone-log.txt
> merged several different PRs for
> https://prow.k8s.io/view/gs/kubernetes-ci-logs/pr-logs/pull/batch/pull-kubernetes-cmd/2117551425255903232
> using
> us-docker.pkg.dev/k8s-infra-prow/images/clonerefs:v20261028-c06373a3e
> as environment. It contains 2.54.0.

The issue here depends on the actual objects IDs that you're merging.
You need to merge at least one object with the same first two hex
characters into a newly written object that same first two characters.
If so, you can trigger a stale loose object cache that makes Git think
that the object does not exist locally, and it then tries to fetch it
from the promisor remote.

I've sent a fix for this bug via [1]. Thanks!

Patrick

[1]: <20261104-pks-odb-loose-stale-cache-v1-0-a00d5cdb5e7d@pks.im>
