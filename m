Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1364716C694
	for <git@vger.kernel.org>; Tue,  7 May 2024 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715102863; cv=none; b=GFPxVNXyiSrwUIgld6rST+X3YIFuz1xUkXRB7uPUXFb0dIDHu2S7PVvuaAf7t7pQdWq9lG6ZFHEykzZmcECuA0+AYvWRGRQWMPKIG+f4ZlYb0PgtAaIXxtmd8zKh9Z0I65AOsYYcooK/vxqzmRE/q+vMtFHhJ0Bzk8r/N7Gazhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715102863; c=relaxed/simple;
	bh=YgVXucst8jBVZPYWTGNw6h+RNaVExXkZKOsqN7caOSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZMqgWMbx1mc85olgv8hnHh1eAgsxwwdAuNPeRREa4PQWUfZEyfiGx2DGjaqJS25sKWZjgeuhiD3EiU0UULp4Je6lmBmqD0yFplEFdC26qPM7ch9KuSkBRkm/OVStvW3mWubeIzBGO8OrQvYd+PgFfaMbr78I4WzQq4HGl3/QTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=AgEtVULG; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="AgEtVULG"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-61b62005f38so35937567b3.2
        for <git@vger.kernel.org>; Tue, 07 May 2024 10:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715102861; x=1715707661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=keFQaIPXbfAQe3qp7G9b40Glv3fgOAsXbXiz/57aDCA=;
        b=AgEtVULGqSuV2aNum/SZws8opJH8g21IFBn7IjgVwybtkTKGTAaLC8MTtxLaAgzIw8
         DUQwRZvRc1w/Uc9/GFWI6Qa/b+mOCuvg0EXy1vzRLgDdyFTNCVVrB7Su2W1TzNZ3InYC
         R7vuQt+KBVk9Swz13dPCzBGQO2oZPKM30cQJP7HJpWmuxSlWLsCtoJZQRfRutDDul6AY
         vuLBwdvmS3+mj6fIshc5fvdqDrQlfqZtEdkbl8ANyGy84NX5luhLvg3/db2ek7Y/r1oZ
         rJWWHXrvywV0zNihERBTKSBtbsa9k9zmUyPbdNr4zZS+kLN/Hj2Q86LgepoqooNhYafC
         D3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715102861; x=1715707661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keFQaIPXbfAQe3qp7G9b40Glv3fgOAsXbXiz/57aDCA=;
        b=njRoweFxUtTztcKVUygd0JGoY0sFc0Ql8KwDV6TeuMp1+1EWUIuW0xIGViCJMuEOjD
         2TR+G8tdnK340E3daSNB0UT2HK6zrFIOgpLcnL9z+3clTZjan+oSoj0QY43Jt8W2f/l8
         8KyroJvAoqQ0gOhsLHFGnb8F96+rBxrvnO8685ZepAzOFEoW5CyBoMwAY7NbL+D3FXzQ
         h7Fp3sHjaL+gIAHBohliGnliUHpZKXKWrjoqs+ozYC+yK/R7O/q8X27GKFQVjtcxQgg+
         LoqAS5h9NJl0DDb7yV3uuQXoyeRha3LhHXbkp/kWeLJsISGn6ubwJXC2j8p0+bQD7CYC
         BxeA==
X-Gm-Message-State: AOJu0Yw/i/ejSv65Q/hWvPkGTA1KTf5EYVG3tBoY/3jCNF4Usn1psfpT
	Y6W/G6qIQs4NFK5DPk17jvm9Okz4k9pIvMZuos2eEbrJXpy5cJIpaEoMYRdjYTU=
X-Google-Smtp-Source: AGHT+IFug+yNfU4Y4RRsynl+7cU/X8W5AnVAQs8WjGJgi3wkdhm07zUnK0AriU+x3VY6oRQq8+IOsw==
X-Received: by 2002:a81:6c50:0:b0:61e:ce2:c9f3 with SMTP id 00721157ae682-62085c5c064mr5723097b3.15.1715102859590;
        Tue, 07 May 2024 10:27:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z20-20020a81a254000000b0061bedb1e7d7sm2743304ywg.100.2024.05.07.10.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 10:27:39 -0700 (PDT)
Date: Tue, 7 May 2024 13:27:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, James Liu <james@jamesliu.io>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] refs: remove functions without ref store
Message-ID: <ZjpkhkYYE45QyFO+@nand.local>
References: <cover.1714717057.git.ps@pks.im>
 <cover.1715065736.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1715065736.git.ps@pks.im>

On Tue, May 07, 2024 at 09:11:34AM +0200, Patrick Steinhardt wrote:
> Hi,
>
> this is the second version of my patch series that aims to remove
> functions from "refs.h" that implicitly rely on `the_repository` to
> obtain the ref store.
>
> There's only a single change compared to v1. As discussed, we want to
> give in-flight patch series a bit more guidance when they add new calls
> to the now-removed functions. This is done in the form of a new section
> with ifdef'd function declarations for every removed function. These are
> easily greppable and trivially show the author of the series how they
> are supposed to adapt to the new world.
>
> Thanks for all the feedback!

Thanks for the range-diff, which is definitely helpful for reviewing
this round ;-).

Having followed the discussions in the previous round, particularly
Junio's comments about #ifdefing the declarations of the removed
funcitons, I think that this round is in good shape.

    Acked-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
