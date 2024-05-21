Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFBA58AB9
	for <git@vger.kernel.org>; Tue, 21 May 2024 23:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716335677; cv=none; b=bUSCGEXJ42FKXgO5+C3wFpmEFG9sjHdRvuOpJknrZt7MO8gRdvIPVB6qRYUeZXKXI+4yieO+wceKYZ9oYAczUigf+SSVNQNVeDN9ncggpeHS1ykYlxh1ZJFdhJWhLeYFLMZ2PKGa3uESh0w7ROJZWNFI0kb54fu0kTMEEJj9tuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716335677; c=relaxed/simple;
	bh=JIYXEIcnpDyUYj7Txwrz/0aYFO1fgG7NDyf4jIIWxhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEEh89os7kJ1M9AsCq5KDYjD5fJFvQz/SvJnTxI+AgvtZqvnhkq6nDZV2rV1oHE1qlt4LPnyUnK6py2eNGLQkCwNToi9wv6bs5UnpSR0yi5SUUytjD0wMnKObhnm2jo1ZWvRt6xjd33UdQwf4JVvWxthPtv7WkgCuTILrIvflDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9lYAlbc; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9lYAlbc"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3cabac56b38so663015b6e.3
        for <git@vger.kernel.org>; Tue, 21 May 2024 16:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716335675; x=1716940475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UThcF4OkS+R3+URvE/KJ7hU9XqZj6hfa2tsr8v9WXtk=;
        b=V9lYAlbccL92mT+OZbP33MkqlhKvVUDyTanXGVpBMbVgHsWlHaXRvG7resRisSC4Do
         9HtXMIkusBtNJ/wlnQZuojBwot/+8zTFa4H8XQsrBhkmQduIbJvXBZy0Y8Od3E/j+XEI
         Kit4vpYotZLVtlEAjpulm94xeg9nHcfZuqNsnSJYxdixR8Qo4jJLpBcXXBGdtayiOQJm
         003pZJ7N6gP3KdV0hl7fpeSymqp6olK7j/Juw+eDekNU6sqGZY9/DEZhrMvxINpbtZAb
         ndWXcUR2uG80oUz3BsWLEms/cstuIfdXkT/ghq/T3lOQgtHjiDZIrYPQoUAA4hTm1fj/
         7K8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716335675; x=1716940475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UThcF4OkS+R3+URvE/KJ7hU9XqZj6hfa2tsr8v9WXtk=;
        b=C3Mk/FVgf8u7OgThSnQpRNSxpLcXWGnM99Ip+jzzpEQMLo9UomOzw58ZvStDdp+5Gs
         GbuCke2m9NTY6sCNqZ33FM5ggwduBGP3TPR/YV3HfgcT8mSray5l23nCp/r0rcVGXHDy
         HfkSNUnkoykwsRdWb5CbxYO8i4TuOUYAgNzfipPDOenVirk4WywkBh+jGVnmFAxuVStb
         KwCrl3qjwnNdwSB1n+KQ82riKvSZY13J+DgvrOOkga4ktXYJqSGTtqmeGiTsmAd6FsLH
         EM4pl/1/xnrXRoIdeyo+lu1ra2py2vHQdIG3fcqnks4gfl4APiAFQ8WjR7SAhw5bjZdV
         s2Yg==
X-Gm-Message-State: AOJu0YxVP5TI6DIR6xezTGFoQwS/tRVgocQDaO7xRjyTiTmJXGOhObKE
	SLaatVHP91nx2Mgh9G+hChtGChZGFYmAoqazkO52ckwboJ4iTe7k
X-Google-Smtp-Source: AGHT+IFusnGg4jvIurx+KONtCUy4/0WCedYjckG3dMDujCQnGtnUuym2lWVHNZ6CSrg95oAelIuD8Q==
X-Received: by 2002:aca:1e02:0:b0:3c9:95e5:724e with SMTP id 5614622812f47-3cdb7f8ff15mr546626b6e.49.1716335675022;
        Tue, 21 May 2024 16:54:35 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3c9add62437sm3180223b6e.18.2024.05.21.16.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 16:54:34 -0700 (PDT)
Date: Tue, 21 May 2024 18:54:33 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/11] reftable: expose write options as config
Message-ID: <akuvjnvz43fzcggytbkyjhq6htljucucmexecel3h4eooqrcca@j5umyot7clwe>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715587849.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1715587849.git.ps@pks.im>

On 24/05/13 10:17AM, Patrick Steinhardt wrote:
> Hi,
> 
> this is the third version of my patch series that exposes several write
> options of the reftable library via Git configs.
> 
> Changes compared to v2:
> 
>   - Adapted patch 2 such that we now pass options as const pointers
>     instead of by value.
> 
>   - Removed a confusing sentence in the documentation of the restart
>     points in patch 8.
> 
> Other than that I decided to rebase this on top of the current "master"
> branch at 0f3415f1f8 (The second batch, 2024-05-08). This is because the
> revamped patch 2 would cause new conflicts with 485c63cf5c (reftable:
> remove name checks, 2024-04-08) that didn't exist in v2 of this patch
> series yet. Rebasing thus seemed like the more reasonable option.

Thanks Patrick! I reviewed this version and left a couple
comments/questions, but nothing that would neccessitate a reroll. :)

-Justin
