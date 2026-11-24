Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531446;
	b=1gQ7poxh97txqHtc1QXP+lbekokyLSW3tv+f+uKsOKLnpBq/u+X1LbNVpg2ZErjwcaSj
	 pWkpZfNqwCtJ5L6+nodRAVcTpJq91wqYtPL68DWmRyVcU35R66G6vMXoTNNpMAimeq/W3
	 fnQqPeKpGbY8KJqC5mAijo+Q5JVQhPpxLykAQaAbfIiERav2Khzz+tim8AMlRh2b/3dBi
	 g4v1Hhnq/xP299upT/JHfx6tw6GiwbVL2rZLfzxOztAYcv2ZZ//H/0+54lPseoa3waip5
	 /KoC4mQSq9BF5qJ86LGUjqJJ4Y5zd4ZyIv6Zo1nVGiB10LBE57Gf2ZG8KodJG+sQSjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531446;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=4NyJtFQHlLPRrhZBzT4lNUOCiYB0O6nFnrZGB2eOZCE=;
	b=TMz+eKiL2VRA1cvpzE4Rmxd6fBO13YjpUN89efvRkHHmHwz6130S42tt+P3PwPRZ//bB
	 zmp4zLcxYyevMiBDgQmhqhHz/nLKWExrtC4KAxDlKK7KtjqlPKoLXREsJhOMZx6WvSNHY
	 B1GEczEfv3fZYJ2FLnb2ug4e33baWqpHKftFwxy3aeQjxXX/Z2NL+Wm2LIiczY0lykSuH
	 DVe+zsh+6ddhEvwF4CyYR9WyOaRt1wq01J1KuM72ibLktTWSKBevrKRt/GmYjyTWxkvqb
	 a++i8m9q7j0RSK+ju972BiUsnQEBWPBq3dSZGuqFPB03COaPeGW3aSSkO55h+iXlp/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=NkUp4si8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nGbLR+jM;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07737606A32C
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 14:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07737606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=NkUp4si8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nGbLR+jM
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id BC318EC09EF
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 09:44:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 24 Nov 2026 09:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795531444; x=1795617844; bh=4NyJtFQHlL
	PRrhZBzT4lNUOCiYB0O6nFnrZGB2eOZCE=; b=NkUp4si8p4SanKi61RRWyyTg7f
	NBWxlS6St8lXa25f36ytJNHQgllicNyIPCSzveT6WYjAqjw9aqGQNB5FgmlERKWf
	8hdp8LOUDkNnmQ/vi7UUisM02BSm8jpiKJFQlAf4VvVX2k+F866d5N+1ykJTvDdC
	E4uOD6cF8BximEDQ62wz2W+3FD0bioywyO9Bo7+wqlpQViKc5vTNGRlMR+5fKveP
	0GKViHR9Lur5DSf7fmVGu96xku7//eeM+S25s6opIVK+zQn6os3JFjmj820sJyfS
	EEPeej2iB8Ka4IkUm/3l7NN6Ar5OCGdeorPmWG17/kjH9Lwx8zt4d9rK8how==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795531444; x=1795617844; bh=4NyJtFQHlLPRrhZBzT4lNUOCiYB0O6nFnrZ
	GB2eOZCE=; b=nGbLR+jMdcLdig7887zJdNBjy9OiP7wV07oSCMnm6eeccfSKC8+
	Ln5L2TIOVe6v2FQohMVs0E/MBqRpb036cvNjyJGtaugNTNUfvXYZk5DS1iw/D0pT
	sqBtl0TNuzrxm00lnA49PVCPCLUGD4EAKMEurFYCIxjxO00WjHc6ucsO+KDxHcCG
	xA3FPmQc20EBiEg6sQmacVmENReJ5TVEoSnW6gLwBGbUMyDjUf5o1iLX/SLOn/hB
	sZG5D+NU9qVKHjHMS425FWT9c5QquKLxv6nh3U7KHgE2PfOPGWg8Re+QZirZsVA5
	mwUjTUO3Bn3a7MXpee28UgXMlQSAHsOwxvA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795531444; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:k6DVpJfWlQ9T8yVvDjjbaSTBNSDnDX/U57ZoEcy3ngYvl/c
	sfioU6y2vWRlbwGxQompfk2MikgxB+WegiXAmUhVGp6m1DPVIZxx0dgBE7pWXC7X
	DWB2VLTS/ZZW4QCNeRVO9A0tK7J7MWrotc6L8MckmyrJEUuIe8HA3A96a5o+mXev
	+3Q9ZDNwzogmXzZqrk5ktaAfjklBZkeFODXvBQdaoSDA9UAVQdznsmj6Xnsxqyop
	1ukUITrYtQr9zFcAnjvM5B35C6jUylsyt5DGk68Ua9V2UGk4oSSV44G4PNtmWdI4
	ZmDyA9tYzYKqZHb+gI+HPTVy68ohCBM2AGyu4BQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:xaDMyDJOpULWbpRXaABMvgWY8ABrDMkUKs6Rvoj+mh8=:/G1TurPCiLJ6a/wONtYHEHnsoGOg5eRsrHasfraz7G8=;
X-ME-Sender: <xms:tKIFaxIL3nK49_lV2LehHkLpquYWbUPjNvYr-Zq_--wryxVQDDoVkQ>
    <xme:tKIFa8PdfcUchG-_7A7m-N2fYE9GPeK4gbKVN4zmP-2ISv9484AiTuT-AWlcVzR9D
    JeqQ6m4n3VYBBKHMVDsQbPEje2PwUYfEotjCj1QPAOYLsAcg1xXw9I>
X-ME-Received: <xmr:tKIFa_5bJUl3AHQfba1m-akWeNbvIrH0twVtpNoqLVa0gSXtP01trpYC9MU8lsBYd0lxP14RupsZU879G6yS9zbiuVMsUysov1kqRNM>
X-ME-Proxy-Cause: dmFkZTFWqrFFRTRZWWMJG4LQzSREzBj+K+jj6Lz7SUrBZDa5Jnj6siferMWg3p61BuS5NN
    dx2t1Xi8/XIUsbVW7caV0POsT1CYPckekRz7qPccRxzzbIebsFXCgR3zZoVHQI997lmfNd
    nnV3t5eUtsii9hZ+VHZToJrFKJG3bersoNayVZ6OGTKIY9QeLjmGOYLHJf3s1kfBMbEcWU
    FYS8KpEuDJoQChsSbWFqyi08KzJplPUGpDItXDe5hTjiLFlq55ir+0LQRcJ1ITDzuVBj2e
    Q6T6kq5RJMMt16cMb1P3ofROcpMlfxMZsGzFn4Mk5Gv4wl0jnutpfnD4LEmoR/t/NP1cYD
    nvT8gx2GW9BQM6aeoddHevF+Ta0nimx0DbvEQnCW0k1eTAu2uVWXTjVc4Blj4SoYiur8G8
    P7R54rqkB7PHkk32gXsG8quKboOkB0DCIT/+ZBIn/bIfxQdFgYCGzA/xHAFWJzyXhHdshH
    gbtabiLPzW0jgaTq8KAi0vzadYLaS9LmSu/4dCgoFx1viMWbRSLFn/6Msmx+B442uXypGs
    w59Q7IxcC2YH6hMLiNMfM5Mli5Qd5SkCwRG0FPZAMnfYNpHpchRGprgGGF9r2/2+Knv7JL
    3yeZOZ7O0KVq16/coKJCNLle0yy8kJBs2jM1In4cTv0iaAlhQgrMa48cfaAQ
X-ME-Proxy: <xmx:tKIFa-58nzy9uh8aNmRZ-FPKjAwcAGnEKOS4epugVD5ooFthHnaXew>
    <xmx:tKIFa9GTzNGmDciPTNQb7PlSe87ycQrtgC3EaeX9Qt6pHFFcbCacPw>
    <xmx:tKIFa-WzTIQuBrt0H7joIFaAg6tD9XPZMeGVEaQgz1AIPggHkAUTpw>
    <xmx:tKIFaxWnJy6rEp2nZ7dKCnOaeEUjqJSktNvNfzDo6p1NQSd6Hek-9A>
    <xmx:tKIFa81SEHNcz8bCKIHRyU46C4G3rFFOCEvATWOvfU1MiiNKUpSbo30e>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 09:44:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Matt Hunter <m@lfurio.us>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v15 1/7] fetch: do not apply --refmap to a refspec with
 a destination
In-Reply-To: <02bffb6b357264afd84ea32ee2717fab8f7ac363.1795348644.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Sun, 22 Nov 2026
	11:57:18 +0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v15.git.git.1795348644.gitgitgadget@gmail.com>
	<02bffb6b357264afd84ea32ee2717fab8f7ac363.1795348644.git.gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 06:44:02 -0800
Message-ID: <xmqqld6iwaq5.fsf@gitster.g>
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

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> "git fetch --refmap=<map> <remote> <src>:<dst>" stores the fetched
> ref twice, once at <dst> and once where <map> sends <src>. That is
> harmless while --refmap has to be typed on the same command line,
> but the next commit lets a remote configure a default for --refmap,

Minor nit.  The configuration is added in 3/7, not 2/7.  Rephrasing "the
next commit" to a looser "a later commit" would be a sufficient fix.

> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
> index 47dea1de8e..327169cee7 100644
> --- a/Documentation/fetch-options.adoc
> +++ b/Documentation/fetch-options.adoc
> @@ -239,7 +239,9 @@ endif::git-pull[]
>  	specified refspec (can be given more than once) to map the
>  	refs to remote-tracking branches, instead of the values of
>  	`remote.<name>.fetch` configuration variables for the remote
> -	repository.  Providing an empty _<refspec>_ to the
> +	repository.  A ref fetched with a destination of its own
> +	(`<src>:<dst>`) is stored only there and is not mapped.

Tighten the wording to "A ref fetched with a refspec "<src>:<dst>" with
non-empty <dst> is stored only there and is not mapped".

With

 $ git fetch '--refmap=refs/heads/*:refs/mapped/*' origin \
	refs/heads/main \
	refs/heads/next: \
	refs/heads/seen:refs/remotes/origin/seen

 - "refs/heads/main" is a shorthand for "refs/heads/main:" so the first
   two are equivalent, the first one merely uses a shorter syntax.  In
   general, any refspec element always has <src>:<dst>, even though
   sometimes <dst> may be empty for fetches, and <src> may be empty in
   pushes.  That is why "if you have <src>:<dst>" is a bad condition to
   describe the new behaviour, as you would ALWAYS have <src>:<dst>.

 - "refs/heads/next:" does have <dst> but it is an empty <dst>.
   'refs/heads/main' and 'refs/heads/next' will be mapped according to
   the refmap.

 - "refs/heads/seen:refs/remotes/origin/seen" has nonempty <src> and
   <dst>.  This is stored only the specified <dst> and refmap exempts
   it.

> +static void map_refs_without_dst(const struct ref *ref_map,
> +				 const struct refspec *refmap,
> +				 struct ref ***tail)
> +{
> +	struct ref *unmapped = NULL, **unmapped_tail = &unmapped;
> +
> +	for (const struct ref *rm = ref_map; rm; rm = rm->next) {
> +		if (rm->peer_ref)
> +			continue;
> +		*unmapped_tail = copy_ref(rm);
> +		unmapped_tail = &(*unmapped_tail)->next;
> +	}
> +	for (int i = 0; i < refmap->nr; i++)
> +		get_fetch_map(unmapped, &refmap->items[i], tail, 1);
> +	free_refs(unmapped);
> +}

Because rm->peer_ref is NULL for every copied element, copy_ref() does
not recurse into peer_ref, and get_fetch_map() allocates fresh copies
into *tail before free_refs(unmapped) releases the temporary list.

In parse_refspec() and get_local_ref(), a command-line refspec with an
explicit empty destination like 'main:' also leaves rm->peer_ref as
NULL, so map_refs_without_dst() still maps it through --refmap (same as
before).  It is exactly what we want to happen, if the semantics is "a
non-empty <dst> bypasses refmap, but an empty <dst> triggers refmap".

Thanks.


