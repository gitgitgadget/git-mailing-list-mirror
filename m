Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793918471;
	b=pudYXZ2djilTH59R2gJEttxr1nAIWGS81rQZKpoeimxgFUvZPiluG5AmgLj/bN+Pl9T9
	 DiLlE4hjPgkIVfQ73s39litR41qUYXSap5jRtB2gZCA+ppxwztMoHaYrhXEnJ1GD2dczm
	 ImjbYRkB8OvMSUWBypRVtLyas7MNWtTA53uPmLLLgbxwaMtB2dycqo/lb9+t2e5bh50P3
	 ZAT2Icn10wfa/5kscgkXq2Ky+okmwfhap+zEsnnCEC2uMQhv8YMWdwxdLz3h3SIg9gFqU
	 SL2vFCn0TgNFvhIEeRu+GIv7bAKG96J6+qsZOepfqp5XUv1fxjwLEfjqXtrf/v26Dmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793918471;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=YXKS7LusyXXsOscBov/Q76lb49QoD82Lq9o/A8Xiyn4=;
	b=FIOqE6qZcKTzRtcLV3CGeZFJpgfWqOtqPDtN9r/RU0cxiAtuh3xk1EVE7xUQeP2tjAOr
	 fw5b++uv7+R5edFKQ91ZZ0/90XTsIat5mHJo7xTGeL+HP2BU2/9Y+vNoI9ktJUWlC1t4S
	 vIDl1KWbS39QzovjdkR4azLKC9Wx8jKKIpD4U9TD99oUOS9I8w6RAADXITjnJVClTrJ94
	 ct4c1HH3ZKh72L3dNPFDiTL/ljvfyvOEcHdImIIfr0FoVO2QuTye1y5PDlZpA6glA9bLM
	 Lfns93RrPd2ermPbv8QuILvhGEf3qsA4L5wfMIoeY/8ErC/oHYlLWxptTHyoXl5Kivg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=YrAi8dyP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LwrfRIV7;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7B9606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 22:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB7B9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=YrAi8dyP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LwrfRIV7
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id DDB5FEC0604
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 17:41:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 05 Nov 2026 17:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793918469; x=1794004869; bh=YXKS7LusyX
	XsOscBov/Q76lb49QoD82Lq9o/A8Xiyn4=; b=YrAi8dyPg8Ap8Fqn0Enar8MMnB
	+xRIrsgmsRU3mKezAXB8+vTlvs4d/tt7wvck0eH4jfmPnwb7PlfMTJvKCuRm+Xgj
	kT9ORAFIAyVEohzLzj5VILvp2zo2XKMRiLoI96Sezes/iyMn51ExMdebvXh7qM8c
	RjWiXceERkAUY2kwYrydZEJpdNkP/TcMj3BuI3C3Pa4IGqY1E840oKLJZ1jI+ZSm
	Hljb/2MyDG90g9akAAXY8fa4dW49TUR0aOy51ycmJQsggg2w0OTZD6jqTwtucYkm
	yDhgdUun37cOB1ms3bsE82EdhODdg8dy18lKuAYvAXDGReBDnzrluCqW841g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793918469; x=1794004869; bh=YXKS7LusyXXsOscBov/Q76lb49QoD82Lq9o
	/A8Xiyn4=; b=LwrfRIV7XmcgLkEWbX0OrRFsVPrdh6QKNujdJa0U9f/n5ALHtgV
	4/mngJgJjDCTQ7JRuw1EgeeVpwmfC7TZrOtbNDhH9oG4uZ960rUBvY6D+YYNVJi/
	FLst0122uzmQmvJ4bOKz5tKrXqzc+wWNx+9oXZbnYZ3It4TDhLSCNniv87H7yaGB
	H8xHCcD5W3hppci7GhtqObbk/HGda7bq1R+EVHobxh1yom/ePhcM/N91F9YjB3r2
	zcAgBaHbvnZUunx5kOZiZqQ6oK6u/JV08Hia1U7j3KCWfRyv1Gs05TvvJSDOgQ+r
	1GTQ1vRAc3WBZrQx2paxSfNNI6tGSnWIy4g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793918469; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:JwnG+Eofe+/KW21pZmd64eX/yFIhnrWH2UQ8d1uWWwko3NR
	f5EV0D3LuBYWdQotetEIeHjevAiyvcHSfp9wrxdPgJqrhKTf48a/fifabP+/RecN
	2oss/bw3tMta3JhygRjavut6ToRB+evXesGSS1ffrJlbszNEQ3fM1OJodY8z8nzw
	7BgX6n/sxUZBvd6GRncpUUDICxGKEJqFmyosv4ha/R8iFoP2yRNm1azQ/A8kIeCK
	8ubIfrzGSFtNjYMpRmeYp5ahcQSKtuTvulWqQSKW6uWTJmrHd8xtvXE6wsfyYVpk
	GZPykqHDvIVDrIrC38+HqeWrg93RxxkYRkDHKpA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:cWfZ/stGfJPWizJnfTfexyI1i+GgTdANZerU9MFf4ps=:hK3a+QjaTQtu1CUXo3GKy6ue6YR4VlWYTA1T5qImk6Q=;
X-ME-Sender: <xms:BQbtahnjJOQxkHDqaH_zajucER42qf7fOUNdR_Dyk1rg_onvbnaBXQ>
    <xme:BQbtakQfmwJ9EKm029LOZIfPdbvFT_x88z-GgQiKFWwbiNuI4KDHC_PeikqRpu2eM
    JpGvgDiHPuT6IURIZviKoAMw8G6n7onZX3HBkc9jVZc3qSI-3Pb8TU>
X-ME-Received: <xmr:BQbtalBwUXmBZwND6uVwWULJLtx3EKXFpcbJkijKcbRALEyGTESyZF2nUNDaC5kQXzuI0VUlp02qBAfeuNDyF-xwaD5Eu3o0telH>
X-ME-Proxy-Cause: dmFkZTEYVCCvquDF4fJUIqHLtC0lMczT/3alyhH92ct0nR1knhnkqetxfqFOKogtbE2Iag
    BaUJXJXcjE/cbEBqWX2EtWK+r0MjLmTIuB2osn2WhPlQNQeY31QeVEDpJV8T6mfuzmE5wn
    0ze7fOwwyuMRyFniUrgnmzjbZB6rIkjo6uCDcQvg3Guq53HzW8yavm1W4/CRJc3ZkMacvK
    GxNNu6Qj6L5IApxEOzTJwF+vIA6Gpwt6xDcT8Ax+NHeK14pf590U07nvR8/NtnQqiO1SYZ
    Kr9bpQZUbYSrRTAhcAYVJPV9d6saPyg+hv4khHiZ6JOfl8xfmweus3ZHMjf2RgoEs7rsHR
    NfwXh33/46YIEQCCrIKbmxpPwUTvVdpXa+rKzC7vjrTGGFXlLOn9P1ODvXcx+xyoO6u3PG
    4Y0tas2UcLjJiRvBcMI676zZMwaFx0ClTi22up7bXcHG6OgoVocX7OFReJL8irQJLd9H23
    orZOJ9azEIdSvvL0w+q52AYhyL/zmMdsdLjU8lfp/NOi4NJa6ihQfj1JrPziUNiildayjX
    ZxD5H5s9QHtNAkdFFrEU7hNeWYGTZDwwLGufHzawTkRszqWfhF9zoamxGXGNsM013sOBPH
    r5Se/em7Fovblc/waamTwwvCW4jb4eyXHYXyC696yuSfQm5USsFVqEbLr/iw
X-ME-Proxy: <xmx:BQbtarQ1H6WnwK0javqunc0agKdZpO_59UuAD9JhNebUzOF_02jkCw>
    <xmx:BQbtajoR21yDYJHNPR4H8FE4MC_QGMkHvTYA_4s0Up4wBjEBHFf1Pg>
    <xmx:BQbtatzyyZJ9vwB1Zca1xhFKoWCew9iU-CBITInN9mLyWMQYChSmGw>
    <xmx:BQbtaoIZ0QjBdVFOcl2GhPPtPYzjclCy6WW8OidieQo95q_UNgdzyw>
    <xmx:BQbtat7zhzUL_Wn40gKC-Gui6Vmy-r2dEyzRzodn3v-N8i3Fw71-DKaS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 17:41:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jon Simons <jon@jonsimons.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 09/12] remote: use strmap for match_explicit_refs()
In-Reply-To: <20261014031347.50433-10-jon@jonsimons.org> (Jon Simons's message
	of "Tue, 13 Oct 2026 23:13:44 -0400")
References: <20261009192953.81794-1-jon@jonsimons.org>
	<20261014031347.50433-1-jon@jonsimons.org>
	<20261014031347.50433-10-jon@jonsimons.org>
Date: Thu, 05 Nov 2026 14:41:08 -0800
Message-ID: <xmqqmrrmq4u3.fsf@gitster.g>
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

Jon Simons <jon@jonsimons.org> writes:

> Optimize match_explicit_refs() by replacing two linear refs traversals
> with strmap lookups.

Ahh, an obvious thing to do for performance.  And the ...

>
> Before this change, matching R explicit refspecs against N local refs
> and M remote refs in match_explicit() entails O(R * N) and O(R * M)
> calls to refname_match() for sources and destinations respectively.
>
> After this change, we build a strmap for local refs O(N), a strmap for
> remote refs O(M), and use them for O(R * rules) lookups of the refspecs.
>
> Refspecs are resolved using count_refspec_match_in_map() introduced
> earlier in the series, which issues one strmap lookup for each candidate
> rules pattern generated with expand_ref_prefix().
>
> The match_explicit_lhs_map() function introduced in a previous commit
> has now been recombined into match_explicit_lhs(): all call sites are
> now using the new strmap variation.
>
> Timings show benefit where one or both of the client and remote have
> many refs, and multiple refspecs are specified:
>
>   Test                           HEAD~1            HEAD
>   -----------------------------------------------------------------------
>   5516.3: empty:refspecs:1       0.13(0.07+0.10)   0.14(0.07+0.10) +7.7%
>   5516.5: empty:refspecs:10      0.17(0.10+0.11)   0.14(0.07+0.11) -17.6%
>   5516.7: empty:refspecs:100     0.47(0.41+0.10)   0.15(0.08+0.10) -68.1%
>   5516.9: mirror:refspecs:1      0.17(0.10+0.11)   0.17(0.10+0.11) +0.0%
>   5516.11: mirror:refspecs:10    0.23(0.16+0.11)   0.17(0.10+0.11) -26.1%
>   5516.13: mirror:refspecs:100   0.87(0.80+0.11)   0.18(0.11+0.11) -79.3%

... numbers do look promising.

> -static int match_explicit_lhs_count(const int count,
> -				    struct refspec_item *rs,
> -				    struct ref **match,
> -				    int *allocated_match)
> +static int match_explicit_lhs(struct strmap *src,
> +			      struct refspec_item *rs,
> +			      struct ref **match,
> +			      int *allocated_match)
>  {
> -	switch (count) {
> +	switch (count_refspec_match_in_map(rs->src, src, match)) {
>  	case 1:
>  		if (allocated_match)
>  			*allocated_match = 0;
> @@ -1239,24 +1239,6 @@ static int match_explicit_lhs_count(const int count,
>  	}
>  }
>  
> -static int match_explicit_lhs(struct ref *src,
> -			      struct refspec_item *rs,
> -			      struct ref **match,
> -			      int *allocated_match)
> -{
> -	return match_explicit_lhs_count(count_refspec_match(rs->src, src, match),
> -					rs, match, allocated_match);
> -}

It is a bit unsatisfactory that we lose the callers to the linear
count_refspec_match() in this file, but still need to retain the
function itself for external callers.  It may be outside the scope
of this series, but are these external callers also benefit from
having access to the _in_map() variant (which would probably need to
expose not just that function but the ref_map_init() machinery)?

