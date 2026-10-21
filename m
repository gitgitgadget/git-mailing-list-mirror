Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572597;
	b=gQE1Tmf0VodpaO0QzsNNMy9J3uksfJOAP17gsqApUALCLdcTPC1HxF7AG6Avl7WAPD3w
	 xnjzha988wEFHCYOs9PxOYo0O1dRn4fzgkDQLbXQQicv/+zYcU7MDub2pdtkSaoxPEUCH
	 KQ8mwOcsnOMJ8nnFxkeWztDCn4Z+ONNwN4YTBRFUOXUz7SEzIBzl+RTKVSaET8Q/NuMVm
	 LfRRA7+oREnglOMVoCR09mQanQ4vllRo2vONoyeaSVToXoLGS9FaD4vabaaOVzB4Qx/3B
	 4Hb/RCUBYGfsT3lFlTClx4dNU0PZu31+vRnOdce/XY/farrsScoPPCsK9ByEaPkxitQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572597;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TLiK9/0VFJ+lTN7n6NkE83JVSpJMHAuCD3zLfKAvJYg=;
	b=EK4DWYR5eUCkAcwemRNKg8pXjjRCdNw8DjSIj/vF5CJh57F9A6EeqKu8N1FuWLsbVRgD
	 BiNcdA5OZ6oO9QVy5i+AKnB1n9fUVlfDPT28edPE5kpm6htmHOLvcm72VOtMB9PhO2aFR
	 8I0pwffCRgXy557z6yzDgq+/ddLKyz5JOh2L3l7l0hX+e1hz8ix/oohYfwwEYvwwoP1VU
	 GPF5Cn+oaeh+UTiGdYdrraogOAsvGeFnx68v3/kozAUuPzg3HtExTkfDUZbot0jQJ+4aW
	 JULNzmq6/GJEoQAkYT04ezEcd4Eyf6goX+omy1SAa/zBWeXRn3hTgu1eT6OD/U7Zpfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=DadJxys+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=pvWlcgn3;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13FD606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 08:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E13FD606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=DadJxys+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=pvWlcgn3
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 13F8F1D000B3
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 04:49:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 21 Oct 2026 04:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792572595; x=1792658995; bh=TLiK9/0VFJ
	+lTN7n6NkE83JVSpJMHAuCD3zLfKAvJYg=; b=DadJxys+05YSMD7lRSCsvLCP1l
	VMzSP9aRTK5Six7TCRqDure/pD8lmCa96u87D9emfsnTKiMMl17Dlahls0lTzRBQ
	WwleroBKoe+qS/2IzjWQ3Sxit+H1t1/q0E6OIz/nfknBoKWbJ8j2vF8KSNozNE1f
	NcTAIRQjnZ8DgdFTlmuwIoCO8m6RpvKqq9z/yA1r9cJZLvJCM9m2w6vtyDmFK1s/
	hshaXZFVi9ezV3f/TcIKZwz+KZ5t33EHAjS2DOzso824x05NFM9Hd0F2at4BbSjY
	PdwUsMDRMSmRKt9FqBg5pRkWZxoFl+TveaVZ8Im9tXTiVGsq6Tz6ICdEa4Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792572595; x=1792658995; bh=TLiK9/0VFJ+lTN7n6NkE83JVSpJMHAuCD3z
	LfKAvJYg=; b=pvWlcgn3EyaVUiBvRa4G3MzkTCIZKyhe1HzK3O2nzHQPPEozq3e
	yfIEVSZGG559nhvf36Th0i9voHK8GaXEVJKK06o7CuMPV338AT7aX21rJyThzd4y
	CeOWKH6CF5r4z7d2HBClGuIUUiKVtO23tkcdMbPeOb+UW+KkQqLh+i78BZOF9w59
	7APhn9ybj7yM+Gcc1FJ9OWCX2nMziJmndgbEF9bhIcA1EPoL19NrydJgX589+4aB
	EaaSdGFKwWTAIHDrLRSfmv/zcW51N3vrLs6LG3WGHw3XNMdYP1O2ciqseYhI1TOX
	VlxoBMAoZ7PoZ4hQh9IhJXZsJNOgsRIMFRQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792572595; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:JZekkLB3rVydpLONG2I6pcbml5VFEjOY9Tfdn7m9oiujZpR
	TtPDIWu4CaytogcCuPsn4euH8MwfvO4Z4iCL7ItDYSrVXUWS85RaQZMBZbj28NoL
	jk14DafjfaLpsrS5NoMAl6hi/DARL/kOf/SQMc8NFxZSr28caWKyFLdz0QT+zMOG
	+oIRrkJSeiiCye7oX4AiBsj4dQ+hyupC/0Upr3zqA+sInGIUfQmmv0W48ReHMC+T
	xzFfX2hDKpLI3TsAlI7T853/7n8VOhHlPCdpVNDLHr6nweKURcKoM1A9e5ebMdpn
	bKuIyvij8uVGL6gKXEU1DQNbJ//ybamDO32qBIg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Xwz3tKRa6MO1SXZZ0tSjPDj9QoO0smOZQ8PlwCl+800=:AQaL5/D/AfCZRVEMD9mvbJZDlfPOcSzK3+O3ioXNRUQ=;
X-ME-Sender: <xms:s3zYapXjSMe6egmRZ0f14mvBNxHSmS2f9LDrkbmb5y_8dWl0mJGu5w>
    <xme:s3zYavljcDIgmoqwMN0fb2SGDak875CstGqVXIBQJ-uy27io1EnyQvg1EM2KQe__b
    alFxXa-F_kd6jGZ9gaVhL37YaHJaANKyKKDTJE3PLZhLivd4s-bIg>
X-ME-Received: <xmr:s3zYajA9gb8MUH_Fiup_NyAIk_6qh39qdfjny-mAjQWCjq0mB-PvEA>
X-ME-Proxy-Cause: dmFkZTGb8JeBnf8U4y5GF/5ZLDx4F2ySY5w682G59R/aHv23/APb3/DIE4Aa2h4Iu38LkQ
    EsogqLY0HDgsVn2ASVRSG1KXKE7hkyXMIE/gvW14k/9m3O1oo8MQPhg5bDzy53Nru9NcWC
    kUcUNRYItcwZuNB2bMAcODbeoay4ZIt9QmIBbqg33rVISRgGxOQqqcqujEBiOuckgxmryN
    iJ9CdkmTqqqvgBKMCS6roMokCGjwfLQD9iRfW9hNUzyBRKF9ZqtBCPVKFZtUs9PVKPoidm
    QIN0IquR3oHd1LYB6mbXMtSRgMe9aCmsOy0TceRpnvZuLWMGly4o07cMgl6uvxa2IoEuAs
    /HxTulbPf2+jvsyX4NNUOQ8vLbbKvN+/5Wf2qNVfUP+fhOLFaSpZmOIURnEL5PlBZugCKU
    OTHUCarB1seQRULUfdOK2bzkE5HJQrKHtR/s512Vl63X3imak4cN5WRl+sd8lU5ktQVNKd
    kcevh9Bs5lAGK3M7vk6K7un8Uzc42ZZDFSSfGnviaVIbNb8STjU9OX8UEZeqvsajB6+6N7
    bliqrNFpzARZF9A5EvZq5rsvBlB8IYU2FGYf6d7tWhW14TgsvnnOA8B4+1oWPLH1e91j0E
    7fMpPd6Mxj1cfXnSPRZSMXClWwlkvJpFqVIUJimGnnX8pWLp0oobNrxe/Iig
X-ME-Proxy: <xmx:s3zYand2GtdCwJee6dCEAwOGmhP8MTLJ9NS0iRam6Uhd-1UKXq9nkQ>
    <xmx:s3zYamLYLa7c7-mLkdTJNgB3w5qPTMCJcXQ_AQ6QVt1ZQwA2C1H-VA>
    <xmx:s3zYaicZ3W35T-QTLxixdwf33FGcG50dY3eHCwRqPzuW94NWE2lqgw>
    <xmx:s3zYal1yRUnLN6paWR__EedMaqu-eJb1F02DaszK8Sk9A4Y_eu_-7g>
    <xmx:s3zYaktgyAZmbDhAlljre2Jdw1VY0c-m5VvSeArN_NOWOxNjPnyY91WO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 04:49:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f0cc4705 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 08:49:53 +0000 (UTC)
Date: Wed, 21 Oct 2026 10:49:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] MyFirstContribution: clarify that "reviewing" is
 a discussion
Message-ID: <ath8r6RX0u2Uq4x_@pks.im>
References: <xmqqa4o94e0r.fsf@gitster.g>
 <20261020232242.2217109-1-gitster@pobox.com>
 <20261020232242.2217109-3-gitster@pobox.com>
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
In-Reply-To: <20261020232242.2217109-3-gitster@pobox.com>

On Tue, Oct 20, 2026 at 04:22:42PM -0700, Junio C Hamano wrote:
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index 682c797e3c..3fd6587e5a 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -1314,56 +1314,42 @@ previous one" patches over 2 days), reviewers would strongly prefer if a
>  single polished version came 2 days later instead, and that version with
>  fewer mistakes were the only one they would need to review.
>  
> -This consideration applies not only when going from the initial patch to v2,
> -but also to later iterations of the same series. There is no fixed rule for how
> -long to wait before sending a new version. A useful default is to send at most
> -one new version of the same patch series per day. This gives multiple reviewers
> -time to comment, gives reviewers across time zones a fair chance to
> -participate, lets you batch feedback together, and gives you time to think
> -through the comments you received. Knowing that you should not immediately send
> -another version also encourages you to review the patches more carefully before
> -sending them, catch small mistakes such as typos and off-by-one errors
> -yourself, and let reviewers spend more of their attention on design,
> -algorithms, and other substantial issues.
> -
> -The right timing depends on the topic and the feedback. Larger series usually
> -need more review time. If the only comments so far are minor, such as typo
> -fixes, it often makes sense to wait a little longer in case deeper reviews are
> -still coming. If the comments call for substantial rework, do not rush out an
> -updated version before you have reviewed the larger changes carefully. Instead,
> -reply to the review that prompted the rewrite, say that you are preparing a
> -substantial rework, and mention which parts of the current series will become
> -obsolete so reviewers can avoid spending time on them until the updated series
> -is ready.
> -
>  
>  [[reviewing]]
>  === Responding to Reviews
>  
> -After a few days, you will hopefully receive a reply to your patchset with some
> -comments. Woohoo! Now you can get back to work.
> -
> -It's good manners to reply to each comment in the mailing list discussion
> -instead of letting the next version of your patch be your only response. Tell
> -the reviewer whether you plan to make the suggested change, keep the original,
> -or pursue a different approach.

This is a sentence we lose in the rewrite, but I'd say that it may be
useful information to retain.

Other than that I don't have any significant things to add, thanks!

Patrick
