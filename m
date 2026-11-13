Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596368;
	b=Uw1l90hi+U8ZbqgaX+FEHw+agwayvEEFTGmFRdIJ3uxmH7LVTSNb2fj/exAKzcvyMJWR
	 TCoBUb86ngrR7YQQETfsTRdXpVoi1PCHjnyRK2SE1At2cCF9HqScq7r0flguCvq1x3Nl7
	 /RuT+nFTZFLZUnl0zQl2vqf/loHhvCIohIThe/1DRbUttwfHfjzQzBFanAsQwpEfIw9w4
	 vKRBxAUo8p0It1/AuIpJCrS5hnKA1V0VO5+6zO6TDPBDw7WkP8zzgsPCqoSGSX2BRS7Kb
	 zkBcaYxwa+1TZTAKMZilHRXuAH18kV7OfteEjQvcTYzyi0JB578V/sYRDrU3FFsnreg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596368;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ZYp5qElOhh4HDMy09vTig1qM0g9TNnSs60UP+k8dP2Y=;
	b=y8QvvblBJ6vO8sThlCFYbE0n8e+T+YypN2bf94Gi1f5g8BUom2s1zE6EhCIDdb42/cXO
	 SyL5FqCGp4zOYT3MB/XK+rQxxSVZB3bpYArUIBcr9l7o6flWmixf9QHm3H+UBT4HPvQRS
	 7Ugyj2xoqHvdmx4KrtkVsvB/j/Y1CqX9hB+VLWS3j9EAqmfw9/Ly12IYtEYiob5EMEYs9
	 +8qLfvpVHtJ3USM+bTxtr7xMIX2TwqJ1iidZdwTK0bsYH6IsJxG24ez3Y3Tf55uReMBVG
	 J38A/WX0I9u9FH2A2QMnzz8XMOAK84zzlRGILluRcIiwu5GDf+7UoYOJHXD0bWZcAWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=aYUvX1ba;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=znnUs+ty;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A44606B348
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 18:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0A44606B348
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=aYUvX1ba;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=znnUs+ty
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1286C7A00DE
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 13:59:27 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 13 Nov 2026 13:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794596366; x=1794682766; bh=ZYp5qElOhh
	4HDMy09vTig1qM0g9TNnSs60UP+k8dP2Y=; b=aYUvX1ba3oQp7JmQh+JifUsJ0F
	DM3ljti0IfCvPL1SgncDlXUzZZNHz04UdJJSazSs53ha/hYOClFurYGYH2GyM1ZE
	anwJSbwOH0aAxWG6TF+na4SZx8CA1j0sQvUq1xgDGQDZ3CBr/Hyp78CUD1CWfydM
	5nqXOlsglZbuXwaxck202AuOAfkGY8kVO8dCjBr7Bd0Cz+3O+ctIMQGdL4hQNuz+
	WEt6SDxs+x5qhiPMp5GqLbpgIjzAzfa6TeQIKq4CWrp0VylSkAAcdRWLTSM4p77o
	fe+KFv4Kavqsqy4m8pymLuJ5YW31mIGa4gwuS7C0vopHRuN5xFrI1NNOhMdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794596366; x=1794682766; bh=ZYp5qElOhh4HDMy09vTig1qM0g9TNnSs60U
	P+k8dP2Y=; b=znnUs+tycD8nEVtnpQkqRfX3WDNckdR4YLYC8oZY3QDMN1uWZsg
	BG4kjtWHM6bo4BL7Jt5HA4fD8xm9Pk3ThWLDScrzu51LIZZP8Iseb2ByJyXsUoG1
	hebs8h0nhdmLUFh1ujgd5R9nDB5aXg5lQXXmWPR/XBZ7QXNzsPv4lw+ANlbVb2lt
	2JtY/YH5N/yzAXEZuCAsyV5VE9efAxzaaj6VzN4okSuyB6m853Ug/c40E8ChKFxP
	2irRVYT8wLhxWf4sqD2APuhmnCxpLKxlXpL9H/6vzIq/kg2MLU3HcMZ8aFNAgjvk
	3clGnbEknEJP2A85f6JLARB93gD3kkRLO8g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794596366; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:PCDnsjO9O2U2thZOR8dGBUlvayRjy9R3twQWQvOIcKqHUuA
	hd4E+qWTh2qgZ4I1NhmapxXVALvc8s26aYmMfIshQRTR/pWr2jp1m0DZF34ltel8
	Ci3ytydNuzSAcZGSjirO5Xt3SUxz+XISgGBOiLBCpIGzwtuGavKp7qQ1VeHl3x1D
	0yngLJwjHKuK411tLapnyPTuSe5wkZUvQmCatglRyo6XyECvTZD2zVWRMvhwQ/2L
	MiobCL7CfpdtXLFrtfAxnf60C+1c+a1z1V3W3r9u3/tYcnKXO0loTImrQREn1cBI
	X9TKVycjUR2zCcCiQ3/tTdb84c7DRAUOaqROzdA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:pjEqL1gFlR5FYka2oROOP0XDs3/oUXCb65ec0iQUzfo=:sA2N6Nqm23Y5VTB+tgNYstxOPe/wvp1d+9v7yOx+30Q=;
X-ME-Sender: <xms:Dl73apkv5u8tM_rE3dgX2L8NVSDioLv3pq6uELH35GAjTuc8GkqcKQ>
    <xme:Dl73aj61OhEcNe6SFzVeFdr26yM01pDNnT9aDjsYD21f1Ok68c1y6gUaYgdJ4_f1l
    mYqzrqTavWaMyZ9Q9wGAp_Uek_WyqzQrIyr1hNYyOG24A6QT-TRWLY>
X-ME-Received: <xmr:Dl73al2diYGmUGrKrUs-B8mKgd9BRBrdRnnj-c-wUJ6ipdzra1UzT5tvBwe5K70PzzPqKoFsWsSmTdYKJ4Av5p43SFrN3Vmk50VA>
X-ME-Proxy-Cause: dmFkZTGaiJ9D2EqEKnlOBUo6aaf7GC3fr2VukjyAZcVx2Psjx9JUJKw7xVCoeK6wWIkQLm
    VrECz2H7I2fs9V2q7ZN5ax2XF+zHPQXF3AspvLQAq6bt8u1dayAEsI0p1NA3RW0RXIWE9d
    mMfBLnlzx3vk9SJGLWcGEGIlxUmPAAY622CiWhYm92FNImiXtTsrb2JjaBh1CnyqkjIfvh
    5oA3Z89LbYybfxD5stuYAU1vSDJb7nGMohkKCwPL7W29hESxq2IVK0/M8QM2eKUXskSxmI
    1i7MvU7IZneGf1O5mHR1lEcD+wFqNUkCH2ogT4mux3sW7X2s2zW5Lv+FkBCFS+3flDA5Uo
    0OEjOBIj46U/IipukY3FcYdzCV0XGJDBMXV/u6OXyRDbTtIMFLTk+HsC/RXm15K0iZXjPf
    Dvk34uIRE72vlR8Ao3Aa823BLO2oBH9Lk8qvO8sdGJ9Sz3iwosYvi6qldroakF7ffPYi/S
    /kjvtgMhHV+t8WAuRwec2TIhoClYH188spMlA143DtUP+gP2FEJDnO9hIuviZtQYdJ1VrB
    56fFOA7Z0OzGjQj36BtnNdx77uKrRR+eV1RdaUNhMhfntrK0JmBAfFiFdty0SGTL042qE1
    JqLOEWcc7XGo00QiIEUAO4JB6OplwZRTK4IgsakILn4KlD6R5msN+sMciBLw
X-ME-Proxy: <xmx:Dl73amGsnvetrgic9usxhfqZ29VcL8q-M7SdlHLdV1LjxI-kcQrYqQ>
    <xmx:Dl73asgZGS1H4MICnYLNGBsPtwcXe3CaPQJr_XjqZsQ5Ju6OI64W1Q>
    <xmx:Dl73ahCo8dXwm7xgLhiEyMW6toNiXvziy3tkKtkNAuWZIHhHwsOfjw>
    <xmx:Dl73amQ_ZoaVD9Srk8A6Kg7eCRztQCvT-0yqzQ7X2_03OYFwpetb2Q>
    <xmx:Dl73akN75K6DxpZ5gNlwFuqX0g3-GVqzulzaKKc4Togaus--2tkddYPU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 13:59:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jasper Mayone <me@jaspermayone.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  sunshine@sunshineco.com,  kristofferhaugsbakk@fastmail.com,
  ben.knoble@gmail.com,  haraldnordgren@gmail.com
Subject: Re: [PATCH v5 1/5] worktree remove: refuse a worktree in the middle
 of an operation
In-Reply-To: <20261111152811.99986-2-me@jaspermayone.com> (Jasper Mayone's
	message of "Wed, 11 Nov 2026 10:28:06 -0500")
References: <20261102182930.3511-1-me@jaspermayone.com>
	<20261111152811.99986-1-me@jaspermayone.com>
	<20261111152811.99986-2-me@jaspermayone.com>
Date: Fri, 13 Nov 2026 10:59:25 -0800
Message-ID: <xmqqld6wblrm.fsf@gitster.g>
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

Jasper Mayone <me@jaspermayone.com> writes:

> +static void check_no_operation_in_progress(struct worktree *wt,
> +					   const char *original_path)
> +{
> +	struct wt_status_state state = { 0 };
> +
> +	if (wt_status_check_rebase(wt, &state)) {
> ...
> +	if (is_directory(worktree_git_path(wt, "sequencer")))
> +		die(_("'%s' is in the middle of a cherry-pick or revert, use --force to delete it"),
> +		    original_path);
> +}

Having a central place like this is a very good design to keep it
extensible.  In addition to "git worktree remove", we have
protection against checking out the same branch in multiple
worktrees.  How should this check interact with the checks done in
that other code path, if any?

>  static int delete_git_work_tree(struct worktree *wt)
>  {
>  	struct strbuf sb = STRBUF_INIT;
> @@ -1461,8 +1494,10 @@ static int remove_worktree(int ac, const char **av, const char *prefix,
>  	strbuf_release(&errmsg);
>  
>  	if (file_exists(wt->path)) {
> -		if (!force)
> +		if (!force) {
> +			check_no_operation_in_progress(wt, av[0]);
>  			check_clean_worktree(wt, av[0]);
> +		}

In the longer term, I think it would make sense to create a single
helper function that checks if the worktree is in discardable state
(without dying.  Just return an error code instead), call it from
here, and have call(s) to die() here.  Then move everything below
the callchain to worktree.c one level up to libify.

Not in a scope for this change, of course.  #leftoverbits.
