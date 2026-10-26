Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793033851;
	b=XlfaVlECUPWsA69VzEx1wT2wpVPMkSwontgTvIhQYeHQ5ZpRJkmJRoiclMgLtgUeFaEB
	 +YJ77LAzhU6ye7pPk7eFVsu0OKcjzGzfYtHgkv2VsTNTJitGdtJrY/RRaHHotAfUtmwDj
	 kFOsiwVTNLTaUi+n6MXGrPunRalCeYJ17CAg/1Ud5XhNNc5Iu9hVU/IPR57cX825E9uPu
	 C+eDR3FfZWH9ltK1e8mCG2OHlKHaCU+j4TQ3YqmplzVWwHApo9FhCCIkbpQJMlCh+BHl7
	 D5hTbiVQ7TItQmXVfKW2cN4mh4BpvmpVpI5zsB3lTu7TM/1gSi+sdCM/2Wv0iT5Whow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033851;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=a+6EdSi2LCKkoSoNe55hv1GT7ANSu+aIMD2ss3kn9QI=;
	b=Z8eVdBXuq7rWx+P3j79+3Vx/TmF1cUJXNXQtv9fIMwh5GRz6Fmf3eDgEUJhCfpB6rfBQ
	 ZY5KaCvVNSD5uKCXvQEhbi+cSrpk4OERPTKB3wkZpkC3zmhVaX5JVjQLXCWYw2J3x7d5I
	 QoW2CosbqcRjqB1JWjqzES9hInfyaft/F/1cDggA/RT1C5jxzAP8cwy8A3DowQS1jdRnC
	 T3Pm4ndkWrI7tu5kr4j6069qqA+QxhMgnKLA31auiQKLFfGzbJy9UWpbfLHcm0pJNyXT6
	 xwp61TtNYXNWJAZuZkmD47v/O7q8Gg52rq963pP9qN3jvw3QIA3dAFwCcZbS+SLzM+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=f+a8Bi+q;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yPLP7MKr;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2759606A31E
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 16:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2759606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=f+a8Bi+q;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yPLP7MKr
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0EC667A03C8
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 12:57:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 26 Oct 2026 12:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793033849; x=1793120249; bh=a+6EdSi2LC
	KkoSoNe55hv1GT7ANSu+aIMD2ss3kn9QI=; b=f+a8Bi+qg+70M3sPfJmmm38y8N
	fEPWBOPlY4dE1sEE0X1V9EQI9t93lyF+jcOH/sWvEmBHnGlgS9GX7fZuWgDM+wE3
	gPglCUKdc20q4JHCEoA+Ps83pA5JIVIlAzlXCXkYoe6WXK9pJNztMzC+6wR/YwNU
	bs/luB5954oEIhuP5ftp+YsXQVZu1EQFND1pqlyeqO++RCTItYs+ubb0m523mVxa
	Q/i8iHuJepyHODIosu7ser8Ca6H1O8HRgNCrQE7ye5KUUxiZ4aeBwHaVV2k0Hd2f
	/AdkI0taEb21/rbFLomZUzPovGyBfeohZmcKCMgzPsWfPBarNbgW/7FyoECA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793033849; x=1793120249; bh=a+6EdSi2LCKkoSoNe55hv1GT7ANSu+aIMD2
	ss3kn9QI=; b=yPLP7MKrdhgXf+GkJKXjx+AyCb+dqsut+yjR8ixEZ9prGuZqNnK
	UGX8+Cg7MduBAnxNy0qTTsQbKaPzx1ctalh1VsHbWirEdwZzZffctwH8f6fqKZo1
	SdS8C27yFUqNO9fb8ScMW1qQSF6xCw98NtV8IdKejdb0JdRJLJUDhgD+9AoPnkLr
	9KI32qaJXd4DSAXg/Y1A2s+D5dQZkJp7DWkXzk6IfAF8xj+/OCm2YGH926nwLwoR
	9QcxE6/6JtR0WZqbhB1BuQOibvZ/tbJ1Pwam3NLtfVv+qm3P1JpoHI7L3I7kYoyg
	yygY4SQypoSmzXJNiAzXjJLG6IAOarvVD4A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793033849; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Q1bdxih1Ikp6va8wI/8KR1RwoFK58Hsr7TBQIvMphB2E02B
	a4AgQ4SqFhSpxRl62yMw8QfJfl7IYp2xw03OC4p9AVnfjWDPlydoy1MOioHWcrPb
	F/t+Dymgbiy+Zb43lwR9JtieLIhiSFl8+eVD8hnX1vFnzKN1vBLoA/aqBufV66nY
	0JDVbGMxpnrs7rXcEP6UZ660+IeeqTkhE6rhr7vNsz57ecFYz3/sgsZEnPEarmme
	R30zhAPG6UpLz1I1mBAEjeoyNkWkHOb6qfVx5O5baHNQdZloCCU14lLhLsluPAQp
	eDO2eNxDUu7QsIwCqGMdwcZNjul+D6TXJflZW3g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:lC18twUxDRmGD7EbIcw26Cx78VGIWHlT7u6cIhsIQw0=:NdwRDO6QUCV1W9TpDuqV6euGRRRoJtmkB7glWvuIlWM=;
X-ME-Sender: <xms:eYbfatpNE0FvFBkQx3-SxA4IuT--emVLNBHdKgyb0Pj0Eq2HcCSK-Q>
    <xme:eYbfah4G8NxEidX_EY6W7hF3nG8geXRGOdTDaP2XP55YDWVExnpPsDjNlLmVWHT8W
    BbXVx46H-Mi7AsA-UvhYQfSPlJnezO0VmIljWoyK536FNYjnJC_Mw>
X-ME-Received: <xmr:eYbfasdqnUoFSz3QSAfdXx8inXcEkITUT8hU_yXVlDtVcbNSSwgYoTOdFE8E1rsaB0Xsy738cfvUyY4A0tuBiB9dgWt9tc0tP1M0>
X-ME-Proxy-Cause: dmFkZTEhUHzylGszXmEH23ThIOKn0woUdxVXHh66ai0qTXnJ5Gm7En/NUrt0PjMLnPJDEy
    g4bSW20cG3dHctBd8iRGAu4J63GgfWJyHTJi/F+wRjHulXHmuHsDjsjCZuihXppOZobCOi
    46DAzta0wmCpKZZc8+JeKwQS/Rfcvtht+jUWgSWMX3F+NgtFXCl2O1Q5Y+5Pi3JMVE2HJC
    nxzyLIiaVcUVTwGVdNa93qgpTKb1Zp1nombuWBUjklfd03tpHoWRhEVTUb51GPVzaRuzQt
    a5mP59MU5qoRTC5mnluPpoJEByqT+HJBXx3KAk3n1KBmA8yIaVy/X67k4AXWxlwaT7WDPA
    t44Env+BViTYAwBWVeVR13eacQnj2TEqhHcFSemmFJRY872JxyRbtI0MY3J9jOoH8Hm98i
    X5Qt48SE/OaVWVcMMluKY0fH70ZFMnDxC2MFW8OA0Df4N9CuT8zeKwfnH/em/Ahf4Pf9Sm
    7asooa005Hva8DFsZFnM4jQtRkCuN8GlH6oTaDIM44fOSUNHT6H7tXh7rPVYoq8A5Q5Lb1
    gsxHdwY6ro6EiksQvKwAXea8iIJDiRLZxxBGqYQHH8zzRLhNnz6SG2Q64YuHN05fSIsEbh
    mntdze4X0N/Tn94v4okH0LnJSnQzfh4bzOUNC6xrGwRwrJpJqWAeg7cX7MHQ
X-ME-Proxy: <xmx:eYbfau6uGMMGsXhtGOS8Ac7S6wQ6jKRh6ZQF8cegQY0LsyVrrn5sQQ>
    <xmx:eYbfarsjyS0LFqAtiYUUArym39MEgtb6X4gCvxKcnbWcInouD_VFIA>
    <xmx:eYbfamiYb6FkcuQL-Z6632lLq0RTC7ox_376N1yxFYTb7z6VTNsIrQ>
    <xmx:eYbfauqvKyN_BWejBqBEkBH2sJ3NENsjfvA24JKhFJRo3Vd2XQ7XmA>
    <xmx:eYbfaqvenWIjbhpcMDcH9F-zACGJ0_Bum2c-1HgCglqxqUgSlXZV2XkU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 12:57:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH] notes-cache: read the cache ref from the
 given repository
In-Reply-To: <20261026102603.32377-1-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Mon, 26 Oct 2026 11:26:03 +0100")
References: <20261026102603.32377-1-okhuomonajayi54@gmail.com>
Date: Mon, 26 Oct 2026 09:57:27 -0700
Message-ID: <xmqqo6cgs8lk.fsf@gitster.g>
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

> notes_cache_match_validity() already receives the repository as
> r and uses it for the commit lookup. The ref read still used
> the_repository.
>
> Pass r to get_main_ref_store() so the validity check reads the
> ref from the same repository.
>
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
>  notes-cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/notes-cache.c b/notes-cache.c
> index 74cef802bd..ccc071ebd0 100644
> --- a/notes-cache.c
> +++ b/notes-cache.c
> @@ -20,7 +20,7 @@ static int notes_cache_match_validity(struct repository *r,
>  	struct strbuf msg = STRBUF_INIT;
>  	int ret;
>  
> -	if (refs_read_ref(get_main_ref_store(the_repository), ref, &oid) < 0)
> +	if (refs_read_ref(get_main_ref_store(r), ref, &oid) < 0)
>  		return 0;
>  
>  	commit = lookup_commit_reference_gently(r, &oid, 1);

This is straightforward.  The function does not seem to call
any function that implicitly relies on 'the_repository' either,
making this a trivial improvement.

Thanks.
