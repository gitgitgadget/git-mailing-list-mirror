Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471DA403EA6
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203870; cv=none; b=LSEkYC8jqLBCvs20PqEtZO015biUYmYf2xSN5TemhTIcubE7LETZx2d+1Xl1T80QX2xWkKymkKqkCBdnf6U+GU7tqqwqfXWQKFRCKAl+BTbo3Iru8etNRsFynMWufN0qmPvTsnPROD/tH4JClTlkJB4bQ7DAn7UFNesI18dmP+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203870; c=relaxed/simple;
	bh=BohrYOaSPQMN0HnvjpNUwujYn8SIq/TTb0xiIqcgSzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLxk2sIygvDEqQIgZl+MxIBf3HSgtK5XTi3NYWtmavqTM5YNsrVAUM9QBQxoMsuOq4iOJbLYri6z2VvC39knhamrB1OkiLh743xvgpdC1dxlav3c+u/UCSRbAU71Cv0ciLchM2UqzzGTapCvkAJJhDm9O15iKxKu7IZaQZp4RSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGOCVaGz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGOCVaGz"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so25438445e9.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779203868; x=1779808668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SqQo+wLA8uhJ0+f4JjFIXjmhJke8zjTeIzfzeO8Mf3o=;
        b=hGOCVaGz3ZIMrPzxdokO8MvMB3FCLfxnudicyjXu/+qPf8sSrF3njFi5F1S53wWy9p
         o7BZ55axIh8St1VPOXFUzhS8m1oAgshog6qgiHiWnHuT7frqXkoZ7wrTNrHKNbr7MJZ4
         uzSyIev1mhQkKz/qvWvho0DTrHgQ/hgH2Do0KAdDPgbn7XC9+kCD9gB1kNp9IdjSUYXF
         J4h7QTWncrg5Hy52PcWN6qs+aL4NUgkieRveNUUgx3kFevITmSYtgtMnq+xiomwy4TWT
         osXlIzuwevB+OEq6HobEggFbMDcBoQcF3BJ14grtyx0KxbeGheer0K1EJT9FIVQ4P1mE
         O97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203868; x=1779808668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqQo+wLA8uhJ0+f4JjFIXjmhJke8zjTeIzfzeO8Mf3o=;
        b=XlaO+RcriHJeCjnMxzklFk3QxXMOcAt+SRDoXrFvvc1MJZimhlbtf+t92c+63V+zR/
         7cO6b5ruYQixTf+Hxy681NUHH8na0H7rwhjBKafVu/2cUhK1WR945Y1+tsE7atyroXTE
         ynjfvLHNIPYsRIIlTG2e89CB2udYKYfgjXkmAcRb3QJArzSE5xo7A2ndpt/NzjLTSrry
         3iIXu5KkTZeoLqCpOY5FxyDJHRvQWNHtxFQXmeyjbUxtom4Ir/XHBcgj2AKfr2MxF8xA
         pX1rGZFrvJ1eYOuHNEcFntsokp1y0R9dRCi2LnRuhIh/tzw2iwpXdTpltqgQJZunX5ad
         83Yg==
X-Gm-Message-State: AOJu0YzYLI3NnRd6+1eZ5enySkWb5EtlbOCrUBVi9KaEkc6pWBy+BkVC
	a+4m39xlXRkFiDoKFgeoQdkkurxkN5faTTDjGELAuol5iGza8HetxXOf
X-Gm-Gg: Acq92OGiIHaIt1WCxaDzyjz4FbAYoJ+LzjcWoqS2ghU4UYZYFEQqng0dKENvbo25PQe
	dh2bKZCnwvVtLJU/9jEMAGf1PWYqnySGs1SFZQvDOKUiDluvXtBxmmAxKT0foupXtmwKu2iyZX7
	2rDA9JwcGVelxb4r/mkbAja8w9mxp5mQ8lkb5bpU9TrHeyh9Dkmrzm0hV2gHNF6byjev0rLjV+R
	yP01g0iA+7Ad/q7iltb6wMmgIBFHiyCyZhwPw861NHE2R5phLl75kQw8fMawB32RiMkx1jP33E2
	exEsU7t+r1cGx9uDSZXU93X7V1RAtv530o0WiWNA5V6xuQuW55fdFoddkO3iAdnwvQbptXfv0ae
	U/RK3y6OA7TIkIcdqNkjlrvH1vjFB/BG9WUyuxp0z+s2CLCvZEUNgVhZ071ClaY9mEwEMbEu3F1
	X0SWETk4389eFlNRau72QW1yssNYYZ8BTTfrSrP0MylQgDUu/qtTmJMK4QBjSiGr8ng7C7D31u6
	SgjSXrwowuURdZvU7G4C45xJUGHDxW0PA==
X-Received: by 2002:a05:600c:8485:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48fe537fb70mr26367885e9.9.1779203867651;
        Tue, 19 May 2026 08:17:47 -0700 (PDT)
Received: from lorenzo-VM ([84.33.159.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4900c16c62dsm144677455e9.11.2026.05.19.08.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:17:46 -0700 (PDT)
Date: Tue, 19 May 2026 17:17:44 +0200
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Tian Yuchen <cat@malon.dev>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC PATCH v6 0/6] preserve promisor files content after repack
Message-ID: <agx_GPfBKpkSc3Gx@lorenzo-VM>
References: <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>
 <cover.1776384902.git.lorenzo.pegorari2002@gmail.com>
 <xmqqse7xm8av.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqse7xm8av.fsf@gitster.g>

On Tue, May 12, 2026 at 03:49:28PM +0900, Junio C Hamano wrote:
> Lorenzo, it seems that not many people are reviewing this final
> round, and then I noticed that the list of CC addresses lacks a big
> name in the promisor remote topic, so I added Christian to the To:
> line of this message.  Christian, you have no obligation to review
> these patches if they do not interest you, but just in case you
> weren't aware of this effort, I thought it might interest you; I am
> sure we all would benefit from your expertise.
> 
> Thanks.

Yeah, it does seem that way. This patch series is really messy, and
generated way too much noise, so I don't blame them, and I'm sorry about
that.

I still learned a ton, so I'm happy about that. In the mean time I will
stick to solving simpler issues.

Thanks for your patience,

Lorenzo
