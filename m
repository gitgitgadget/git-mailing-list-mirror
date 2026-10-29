Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793308253;
	b=ruOpIPJA0zQ6Dn+wdKMamSQVDXeCQ2HzFBvg38JjuCcPnxYX5m3q6vbTjJllGMziaMla
	 x+EKtIdRd9lK2qT4BZfvMgIDLEau+kjv5PgxgcC+4S+HS5SZkuvPT8xl05tJBNRFAGims
	 puLnz9SPoJUOvIE1f184rjODhCYYIZnR50eg+KeE76V8blgrV76V5+2bs9r+Jnt9uMGJu
	 8uwVk3bE9XuYDGj7fSsZwV45X8mk4UUIpYPIgw1OvFZgUG81VUJAonbpKwn9wHNFZBqQL
	 hnI3/F01g2l6jD4Cv4NQ87wsjSfWbg4qYUyMhp0gagV6FKLYHZZZDnapRDhHO7Z+nSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=rqrLzfge747TN12URW4HEwXFKO6EuUR+UYSllmhO1m4=;
	b=XKBLYTi8P8dFfhKnwj+3QBHL1r5m1A1VRtlWqrnaZxPYC1CZ5r0NDvdldKiKLo45gZSE
	 WvFWGIsibT7C1qbwb6ZrSSU0IWG2vwD4gCHFKpTJ8oWRt+YyFX0djXfNMoYKI+J/YOAPD
	 x3HHps53W8YOYizH6GkkVqqHKI35Sf9PcTPQBFra9Q50fjfqiFdQJcRyPxWDrkRsILPjB
	 +g+5EeuqS5PTQdaq33MEZgMtXp9OTqUDERjK8Ustx7yyquicPNaWvS2whthRn6hxI067o
	 MMLgRyRtz5LM3uSINIYaMTFQp3yBjkG9Lkr2Ep/Tf8mgNuIjvk5jQpB9JF071B2WuYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R4zhDugY;
	arc=none smtp.remote-ip=209.85.167.172
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A4B606A31D
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 21:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97A4B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R4zhDugY
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-54cd7de2d42so31526b6e.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793308251; x=1793913051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rqrLzfge747TN12URW4HEwXFKO6EuUR+UYSllmhO1m4=;
        b=R4zhDugYfR2mN92NKZhL93cTDGr+LOq+7KAHbZhLDDhn/ZI9pxm4ARmkyA4yw6bMgN
         hWihl4HvG2uEXbPbQQYb9MGupvYukpeqpheli4iLNwGKrm59BBGiDztVR1H4jkjqZAig
         jqACeQWy8NFfc/HJvDt4Q+3aObeg5l5wC1/oOuObSBLucUfmFkMv5JeygQYWtfkmT8gs
         Dnhbp1Noj17Aue1GLBK2fiTiEJEhxWrFNXkUwE1qgauZAB6RwTkH2mHbH4toR67IcCBM
         kKmQ2b1/08Aymvp85PhgYxxFkwQJwFDb6J90UL8WgasBRB2NyEzueXnZN00mVko9YOBA
         nVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793308251; x=1793913051;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rqrLzfge747TN12URW4HEwXFKO6EuUR+UYSllmhO1m4=;
        b=oCC/esbIZYmxfwrv1WU/389dJ734lbTkAV9fEV7wMCmjCaR/95nTi/0799VGFMOFTf
         qnX9vFz2ED09ic4vm+8PVLOuDWCQ2rmivU9knFCw2My3TBF04LFyzhFSoMlkP+s7/U3H
         iK7zILA6pv0xkyPdt3UhZB+2Uhtu0iHGTOmq5792Yp4QeHBfNfUVEw7QmIqlw1pS5ESA
         zKUtasfdfKDhYeUc72GJjn/U+btjrpAHT4IquymY+qFErC9Ili1lAIBoJ0sqI0TGSHet
         PZ+eTAIi/mmNd+F11DRvXTLGPUJdzOP+xOBGxyboozNlRaRE82sNoz3WYn0AdocpUexr
         mGpQ==
X-Gm-Message-State: AFq9FYJxyx3eMWh48+MouPRnhkNomWj7ecTk59+V1Ihg54dyuGamo6ir
	DgiVvtLz9I498xMlRRWesGJE7pRgdKvK7xk7s3tx7iBZuIkTLDW4GvWn3+1wnw==
X-Gm-Gg: AYBFou0giuR8VveSJf6BJcNNiPiHXNPWLs6s7X6+czyWzPAqexvJLL61+/7Up0CbW9h
	ZJTs0caf5ZgVvTbtK95mqcCd/v8iF0JbPrt3E/Q4N3zwGPfpOd5Sst1+FDR6mp+zJ7uK7ypdvP2
	7bLiBlGR0tpYlzB7FliH2ZKgAFfEwnCesy9WvIDIl44fQjoDSTljTM/e5tEsZTcjngK3LjLcBm9
	tkAPC6DmYQ4Yie9K3e8mUpu7r9sGWFATC9Ht6LmDxgAEJvue6KUAzIe5m43b74ua9HK3QiIModM
	FVL+1+Rd1HNXN9oGoA8Mmpvovmfwhc46n+SoCnFS/1bPrwhVkEds5rSlTYCsRZewnYMeK1+O8zZ
	eUtuPoEdWGs5UlhneEVjGLob0Ahqig+NhBUXrNJmpyW1Xd83GReeUExRSIa6UqDdO2wseg+QYOK
	9zpqD2SByNSbngZWA5WiNxNzz9hiIpdizqUz/uZzEqq2uNAanJLSDUcjpP+zHToRvT8U6zHmxCB
	msI3TCNPTC0wcPp9wlcNMSyn5Zync2FUnmeSpw8PeWasogWxhwNqYDprzCzDrAAw/jiEdFW+pgB
	fwH7uxa15s2b6tGNsIqteV3gjrPNMYWUuhqFfks9XJMCrnCH4G6+qA==
X-Received: by 2002:a05:6808:1b0a:b0:500:5e36:3a9d with SMTP id 5614622812f47-5640de79ad3mr310543b6e.30.1793308251550;
        Thu, 29 Oct 2026 14:10:51 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fe45587sm61315b6e.15.2026.10.29.14.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:10:50 -0700 (PDT)
Date: Thu, 29 Oct 2026 16:10:48 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] loose: lift loose object index parsing logic into
 helper
Message-ID: <auO2H-RBiRB_vwVl@denethor>
References: <20261022234007.3081825-1-jltobler@gmail.com>
 <20261029002413.3291184-1-jltobler@gmail.com>
 <20261029002413.3291184-3-jltobler@gmail.com>
 <auL-W9Z2H9Ivn1RC@pks.im>
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
In-Reply-To: <auL-W9Z2H9Ivn1RC@pks.im>

On 26/10/29 09:05AM, Patrick Steinhardt wrote:
> On Wed, Oct 28, 2026 at 07:24:11PM -0500, Justin Tobler wrote:
> > -	if (inserted)
> > -		oidtree_insert(loose->cache, compat_oid, NULL);
> > +	if (inserted && cache)
> > +		oidtree_insert(cache, compat_oid, NULL);
> 
> Okay, so the `cache` is optional now. You mention that fact in the
> commit message, but you don't explain why that is. I assume a subsequent
> commit will make use of this.

Yes, this is used in the final patch. I'll update the commit message to
make this a bit more clear.

-Justin
