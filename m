Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792591158;
	b=e/eOm+tX747h4YJB+NOESb8IfiRCh4hZERvIcD+2sXsgJ0PuAYM61GNfYIYwqaV9gTda
	 qSRo8yJjIGlhWfjKND7PLmTGr4vxUGz5SJNceIHILurEec7o6h4GOgbskRWOou/RVoaow
	 QyVf6Guzk2OPPN4aM+ttJHjaf+XaXmD1ObG/kZWDhBAPCWZkOeicSYgslx5P3RVHkKlv0
	 AKEuxpXD4SOG5ZovZSFEhhnObDJvx0/l2yC/y0nb4BQA8y2TIsPhBTJoywWaPsmw7suQ5
	 f3FO9H0osb8oeqMa77V0T1YXUZsoyZTI/APVoLh71AK1jNYLlP0x4Tlf16oZqPO9OhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=4DaitzTVW/r9yDAq57Y31QJEJ/ksJDjrm3bTKgPTl7A=;
	b=cr+emICDGrJlzdEp46JFmSmSZwj2n1hvNQDVMU5QUUo8e0tYplEnog5XnN1JVfRizXFu
	 nLDyelXHVLIzDkEgQV7AeS8aSt6YJLbzkfsDyNNeGUNNWZnj8EVqAHacn3nofDQfXbiM7
	 ViuSoq6GIe/Wp5BTws6bhOR/cUlSdYPvdzZVONwOFNOxe4bB7bq1AN/nTlmbJArLfYIzO
	 fFKtu4PflY7hRsujTQIJU3/5mEaqfYXJOf+VNtxE8Bke+GP5ZvciKMoXqzsVMnPaUjH0N
	 T1/4JS3T/1xcDCRhfgBrSgjuMFtmzyOzy1eIqOkvttfMj/MgDHNFipCN0SVuz+BhJog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZlqfusEB;
	arc=none smtp.remote-ip=209.85.167.170
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E621606A31D
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 13:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E621606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZlqfusEB
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4b28d9537bcso506901b6e.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 06:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792591156; x=1793195956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4DaitzTVW/r9yDAq57Y31QJEJ/ksJDjrm3bTKgPTl7A=;
        b=ZlqfusEB2LCTQK6n3WR3FoBfBTylCGDKsrplnUWvn7sYXVSRx8pyD1ToCn8XUPRuIY
         rNR4SxuFpEhGcjAbqR9hgaAKQRGPWEKoejWcUguaY3awx+hTwujsCCb8MkSTNu+n0uiW
         tCYTRIM+aDvZfA4AKksntQtarxNmK/j6UyncGaOXCvqezE5/3fqicSG98D9ZhTJTyDxh
         UHtW2t+PnyA0vMkGwAkvw1SczikiG2lntJ6+tT2berLv2b9NFwY37doTrTfrSs1NKr+B
         DDZymvjofns7X9Au8grVaycQIUTJKv5E7UtbObsbDjO3kJVF7f8v6peAa52sfbQlSt/w
         Owng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792591156; x=1793195956;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4DaitzTVW/r9yDAq57Y31QJEJ/ksJDjrm3bTKgPTl7A=;
        b=sQLYgrJq0YB/24MFJDCdn9mo5xZuurZpFt7XqSuBPPnd/0OwpvOQxNDXmrKIxgwtdz
         Om5ZKvhGqkisDSHFivhE/Ak9sqbQ69xNUJH85Rhf3rgRijFIYdoel/SwE2NRKD5v6aIM
         NsdbzLOS+J61f99Qn+7wxdRC7xB372vQfeh/jHADUDAwdLuKSduaI4b5zPuJrmeO0AQf
         Ahhij4cxhfSAKHyPK+eAyt0bDx9w2iwj7z1cTNcqpROuWKpiP5o3hmUFBzRuPujYwOQZ
         w0C/1bPgQEopCx7SJE9sO2q2sBjwXogq6i9/ycz3vb/Qax/ZfLP4V6R2krY5aN+lDeaT
         btgw==
X-Forwarded-Encrypted: i=1; AKwUvByjJ2qOmYIP+v0RDHwG+ygKtSpoNoRpZBuQqv70gfh162dAckh0/biDpclB/drSRGmRB7A=@vger.kernel.org
X-Gm-Message-State: AFq9FYLaNu9ar6ZJDvLI3vTrGRlUYa0JM7y7w9m8SYcxDRLwCyCRMtvg
	oS6qk13v/OW4fb7spBofi2uGf/Pf2wqJlyegkIBSerbhVHXW/ADVlGnZzh61tw==
X-Gm-Gg: AYBFou1FKDxel9Nx9Gizw4EM2JM73/w4VuV33YqYxrtFdl4urBUup5aCQ7mBfq0va+u
	o/kcryx4mWjMxMDPeRL6SMLWScd6OyLYYsJRFUZ1+DxpPkMBguO+A8W/b+uIUsJI46gpgxG9A4k
	oeATFlOjhm1TQ4xayzpoIispkQMJrNOLErdYEW4IfsGgEh+B7UDs9JJzb2FeU8bW9jRnumDRiBQ
	uKBoQUuDrKg/5bIZxsXSbkvqYMOZTHmEWbeJsMABhrRdER1o8qMkkFLCj0r8SKJKXGeuz6VegKh
	J2eQ1GF1QzFs2LYuGUtLRpfdhGpAheu0x8ZNpQf8yS/D1zIWC3waCObc+yIFG7Kvl5J5+J/E022
	ti5wHy2pMLMJjMlAfCHRpPgK2RLbxFb7AF/F0Yaq4fxqiHc/N1RZ7gesKWbxV8GPSrD29RtDRkn
	QCPUehguW9AUnbCQFbsQTjB3pU+a0O5uTPQrZMCQXXjG2Z10mLL287y7CCXlGH0OpiNeI1Fqp5+
	Ekr9INY6nKpW8NUO4usfPjZY05Q6liuIdqMmxYNoZYPHIWSFaEIhglXBozSBoxKTGIRquixoHCp
	7lWP
X-Received: by 2002:a05:6808:1509:b0:495:ce6d:7d48 with SMTP id 5614622812f47-553538afa22mr1110729b6e.9.1792591156516;
        Wed, 21 Oct 2026 06:59:16 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-552b400da15sm2075061b6e.3.2026.10.21.06.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:59:15 -0700 (PDT)
Date: Wed, 21 Oct 2026 08:59:13 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, gitster@pobox.com, 
	Mitja =?utf-8?B?QmV6ZW7FoWVr?= <mitja.bezensek@login5.org>
Subject: Re: [PATCH v3] fetch: commit references fetched before backfilling
 tags
Message-ID: <atjAS1qQ7HyDYbxh@denethor>
References: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
 <20261015-799-shallow-fetch-with-tags-v3-1-90b6e38b98d2@gmail.com>
 <atftdOihoUHTdvfu@denethor>
 <athd_dTKZYOv01UZ@pks.im>
 <CAOLa=ZQ_sgz9e4JFWj61HNnKXx+pTvTYhENbbtRu+ATUbXxS9g@mail.gmail.com>
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
In-Reply-To: <CAOLa=ZQ_sgz9e4JFWj61HNnKXx+pTvTYhENbbtRu+ATUbXxS9g@mail.gmail.com>

On 26/10/21 06:01AM, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Tue, Oct 20, 2026 at 06:05:22PM -0500, Justin Tobler wrote:
> >> Naively, I think it would be nice if it were possible supplement the
> >> backfill fetch "haves" with the non-committed references in the pending
> >> transaction directly. That would avoid having to commit the references
> >> in the middle and probably also fix it for atomic fetches too, but I'm
> >> uncertain if that would be a simple or reasonable thing to do.
> >
> > Hmm, I think that's a sensible idea. We should know about the ref
> > updates we have already scheduled into the transaction, so in theory we
> > could use their new object IDs in the negotiation. If that's possible it
> > would definitely be a much better fix.
>
> I'm a bit wary of going down ad we'd be exposing un-committed references
> which could fail as 'haves' to the server. This doesn't seem to be
> conceptually correct as we now expect GC to not clear the objects needed
> by relying on the .keep lock instead of durable references.

I'm not quite sure I follow why this would be conceptually problematic.
Should it really matter in this particular scenario whether the tips the
client advertises are committed or not? The required objects should
already be present in the repository from the initial fetch.

Regarding the continued use of ".keep" lockfiles to prevent newly
fetched packfiles from being GC'd, that still sounds reasonable to me.
It is expected that the ".keep" lockfiles remain in place until the
reference transaction is committed any way. To me, conceptually all we
are doing is allowing the current inflight state of the transaction to
be used to affect another operation being performed within the very same
transaction.

> But seems like we have negotiation_include_tips in the transport
> structure which seems like the right fit?

At a quick glance, this seems like it could be a good way for the client
to advertise to the sever the tips of the uncommitted references it has.

-Justin
