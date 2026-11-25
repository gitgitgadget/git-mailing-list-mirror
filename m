Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795568046;
	b=lw9tzJgZuJV3tQWGAVS75LujyjsMWKIpC8ni3b3wPlmsBrjwq3X1Yxf/xgwqf7YIArXB
	 yRH2lJJIhr1Cb0+sSLwO/DdztkjWFlq2r0HwTagRs9hjYa3SECR2rw2Qb4Xbo4q7BLG7p
	 Dyk9B6xF4931RMiJOwK3HcbuGghKRjS706qMUnvIS2AKYFiVcwQXexLSllZ+dEx3cUVvd
	 jgwZKfYiCgDE+HyntYRllm0BPyy3+4cOxqleRaKQ0Zb2M3WFWby8xMTbH08wtUb7RU0ul
	 /sqWBxZlOaz9zEAmDGiadubzaiTDl/HQ8GnS2yP5Ei68T+a9xZDekSvmkEBNzwyMxWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795568046;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=wfv25KCTWdQAduN+fx+djayMxY7UmBvUq42XwmuMTcU=;
	b=fVyCPiJVKG2slco1Q1zczCoJTBGX8/7ZJWDMOd+HA45YIFsvOA7WOajZir3gwRp2wDY5
	 O//tly5DqtWKhn9/woPclcPj7lqNdYUOEKCbd8iy3vc8h5MKm4TvGMwk/tHaXxc9B+g+g
	 3g/QQ9HPtQU9IzIXsISAjvPqWEB92/hfH5spVAx8XcT/mg/V+5MmmkawIPtSYNWJ8hfSh
	 FXllnuRb7FRquXyiowYyRG+Bp7OHpbjBLdGDKJ+SfCN9F5mNf5yy9yeuxn7lczYG6GHJg
	 x/WEa1OR4zUW+4g9skItUotDK9iBCL07I4y93wtAiovgs8GDnfsLmvt4F6bxhMs2V4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Ryw0syio;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sO1dYtWG;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6C5606A336
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 00:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB6C5606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Ryw0syio;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sO1dYtWG
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2B3097A0607
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 19:54:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 24 Nov 2026 19:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795568044; x=1795654444; bh=wfv25KCTWd
	QAduN+fx+djayMxY7UmBvUq42XwmuMTcU=; b=Ryw0syiooc4J9bvtA2m+VbZofW
	UbyMdmZiMTc3GSYSpfZ887Q0Y7ASv7/AnhgyKsXX36eiWoo0YY/GDPlXd48aw9cj
	ZVl3D0cenVxORRBXG1DB+RZoQsiXEZCdCYIsJCtehClWEdKkBe2ThQDuiMz8BxxY
	+j9ch9jzqFJlsVOKSE+GzhQieCeoVBFRJBizs3LRyG2oXrR25dEUies6XukCBLxV
	srYxTgwLCx5Ywhd+lDUxpJFGKnQ5R76U9dW/BTy2Q1YoPjWoIXKRtS9ZLeOOyc/x
	iT5VKRT84HmcggNNBnMsqbf7e6TzCPCnnfOLFYs49PnG23qejFQihmohKuog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795568044; x=1795654444; bh=wfv25KCTWdQAduN+fx+djayMxY7UmBvUq42
	XwmuMTcU=; b=sO1dYtWGALxEb/J8wArmJWOcHY+E77k3IRS9A+waSRd40EATgJS
	AGPtu/VkFnv0vJqbgjjE55Rr0dEr0WNs9rXxcMP9S+2cps80nB4wBN6Ciqv8SFN0
	dgTZNjZMSJLiZW86LWvpKmG56l4xgQLoCm9gxKTBqOeKXEQPDONHNQoa5oY/4hqq
	UCzAbUf/HCjB3yqLGQqJpkfuIlimGNR7oL1PQP4K8U/M6epjjvWx5WFqHDRWw42c
	VU3+dohj87fkC2CsU8Sks/fA0/OGxxPAO9cwRS3Gu5fNW0wo9R2g8Za3clqsppYo
	6Q8YqSnfATLE1892lx4hZJzK9KO86QNGZKg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795568044; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:O+nx7JOurkSedckHkjGhpN5sL3FB5HcmtdAtrysawqtNcOl
	wK2N5+r+WmKiDF223WF0GAC6TvcdCOQVNEJ9yEgy2MQLGkk8vUBpKyUM4kuf9LBh
	ox9QoJFi+qkFvA+4+C/40xcy761t1Ct54QtsTyP5OexiSwj1/+jq+1LRq9e2p25g
	OxAo3ex4HJkgGUn66mXkLIqefeb99HQLRN7B3zrSUKzvXUM6PaJEDij6MsqkYTsr
	J5f7qJomuooxeXLAKrIqt5TcRTfST9xxiBm3hV8o5MkL6X8rdEO08PwbnIPMHYoV
	IRRURUjZoq09+pXWjyuPcrptvnPqV9AnA6Hxs6g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:sWJ7eFKrHu6KC60D7t7TiIBqMmW38DNtDrxvrqIcmSI=:NskK4KMLF93Wt47+vtAQyFTVPjkf7cPklZDsW3uc2jw=;
X-ME-Sender: <xms:rDEGaxS934IzFBfU7HHSbNBgpYK-KvUvbBopEJ4fPrM-_ConYTXi6w>
    <xme:rDEGa510_PFOIeI_ugu5DMe7ThLPoiHjxfRl-3GeEeo7oAQQQfD-JtFwfM-lAWG7e
    O7j1YAY5UjD0Qrdi-Q3dLtgffaSSQsRlO5mToSu1BxO3iVU5SPgA0pc>
X-ME-Received: <xmr:rDEGa9ByixMuBs8mdJzdRLGNnSXZdGXd6PpfBDK4My_P_GE71DINDcwDPZxeCm6EEZAXlsEw5yN-sUb4rXmL3sl9y56z2EIIskkDhJc>
X-ME-Proxy-Cause: dmFkZTEPnxVkhRdJnXIvkJQVLPODhtUcy3X9FPNuYm6DB6jGA+NCB9BdO9rVl2fTFBLih1
    WLEY+t2d31f7TwvMKTPdLcdyU0EBgS79+4jzcSyQt18CY2VbO6cgsXXDZscB087U+adpI3
    690TamyYvkPUHu6on/jkV0o0SXGvmL0GyxJrgdjB5ZU0wcJw9jgc4hTJvTjyE2kiDd42NV
    V8exLpat82rkL3ms3KKeUoz1G/nOdDF9r/Bphsz1qwjlRhAOLmqtmrOf12Qa5zeYycrqlD
    w5sxSjLOXfLnebOzrH3DnKa5KFXYNLtqW9LW/BFJwaxqJ2puCZJhlqGdAUNri5U7V3XeiZ
    QnPAxlEdUHnc0PavNif2yyomxEEDscBFTgRQTjStQxc5yelXRzQAsL2pW9dzF1xAq+n/iC
    slakx/E+TPz1VK9jpj3QljN5EfNMEBbPXWe4MVtE+mV2XGH/GTdaWY6rsWwwScW3dicMQD
    7da1HJbfSMMwOtfLneBM0+sXIyLcCHXAfR5hUtg7CxiQviyAoptnL6qs4N2ZvKnktRvEsE
    AY5cZh5Ba984LEAXQI1Sehg0bv+W7jKY04EbXSnDTk0APk2oGYycdIJd5uhh3jeUaM85v8
    e8QsW0K33hSVxN/u0CfnQdJZDOMyPYxH69eyU1nrTNdoPpkAyytkPfQOXIkQ
X-ME-Proxy: <xmx:rDEGa1jgL0jIcltLBRXR33nGrebPdb-cMgfr-hn5tWlRtE69c_jNdQ>
    <xmx:rDEGa_MjUAlf02k_y3JLfIDsv6UE4z4KVWtKanEfZa17OqBV5LOkOw>
    <xmx:rDEGa1-eJ7aK_zdYlyF6gm9c8fFyf_C7Glu0FbKD6x7pJFZ5SxyhHw>
    <xmx:rDEGawcZfwvJvVHueHkSd_PbTbSv-TZXNrvI4_ceOKocM8H02-SQRQ>
    <xmx:rDEGa0TuRur0gZuFjkcZW0Iql4atff_2tDLsHL-4RmjhMIDJzX_0-LMV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 19:54:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v2 3/5] notes: use the tree's repository when writing
 and pruning
In-Reply-To: <20261124172146.18330-4-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Tue, 24 Nov 2026 18:21:44 +0100")
References: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
	<20261124172146.18330-1-okhuomonajayi54@gmail.com>
	<20261124172146.18330-4-okhuomonajayi54@gmail.com>
Date: Tue, 24 Nov 2026 16:54:02 -0800
Message-ID: <xmqqy0ahg28l.fsf@gitster.g>
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

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> write_notes_tree() writes the notes tree into the_repository,
> and prune_notes() looks for missing objects there too. Both
> already have the notes tree.
>
> Write through t->repo. tree_write_stack_finish_subtree() takes
> the repository, passed down from the tree. prune_notes() hands
> the repository to its callback in a small struct.
>
> copy_note() also writes through the tree, by calling add_note(),
> so it uses the tree's hash algorithm for its null object ID.
>
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
> ...
> @@ -1368,7 +1379,8 @@ int copy_note(struct notes_tree *t,
>  	if (note)
>  		return add_note(t, to_obj, note, combine_notes);
>  	else if (existing_note)
> -		return add_note(t, to_obj, null_oid(the_hash_algo), combine_notes);
> +		return add_note(t, to_obj, null_oid(t->repo->hash_algo),
> +				combine_notes);
>  
>  	return 0;
>  }

Unlike prune_notes() and write_notes_tree(), copy_notes() does not like
to be fed a NULL as 't' and use the default_notes_tree as a stand-in.
The function begins with a call to get_note()

        const struct object_id *note = get_note(t, from_obj);
        const struct object_id *existing_note = get_note(t, to_obj);

so they can give you note and existing_note back to you safely, but t
copy_note() has may still be NULL, if the caller gave it a NULL.
Dereferencing t->repo->hash_algo here would probably be wrong in such a
case.  Instead, this function probably want the same

	if (!t)
		t = &default_notes_tree();
	assert(t->initialized);

dance as the others have.

Together with the earlier review on [2/5], if we were keeping
default_notes_tree support, we probably would want to tighten
how t==NULL is handled by each function on the call graph before
moving forward, I am afraid.
