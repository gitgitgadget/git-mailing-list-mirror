Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ED140D57F
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760609; cv=none; b=LysAjC5kpK/l0dDl/6w/Njbtz2kT8nHjQ+9C+tg4n6bca8vDGA1izKfwWTDr47iKtU+XhbRDM9kszmiw4pxVo656PEDEV6P6mEg9DLNTAsEpY/GbbTLifdAuCIhq3or0fFLckANz3LVay3UJwMIW2Ao8LuEaN/yG54Ipe03AeGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760609; c=relaxed/simple;
	bh=gbqNYGuCPyRQpzNbqNcyU25W6R7aPyG1zgT4KIsq/fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pj2EwNl9SRhngPhgEXTDFXhksEdvSwz+17jWlT5gxE3X69UX/vaFSnyCn6p/Pn3xerv9wkTXYbe3vH/6MQWde9Orr0V2dg5DhSnctmxv3GWW3nMJquKSGR89BKODDLP3icZL3ke+JqwGOSa6bnqSrrkty0L0ZoE536MU7ONCG3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O23oYD0r; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O23oYD0r"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e6b5c374e5so3221685a34.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 12:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782760607; x=1783365407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QaG174s5PBLAQx7Ys7yDqyxK7/j4IcKJ+m3GnrTVO7c=;
        b=O23oYD0rzWAObzFFZWSBKGK5n3ouHMmbU4g/lXcLWylnIU0hI/sbOUmCNfe2Vp/kxY
         nmSMkxOoqMGgsOpusGIw5Ifz9+vb2Iy6xeg/gzmmD4FxX0cpLHPqWE0N6iVLjb3bexiF
         6+zCGPqCccA4tfUAW+vNrNpH8+CNNlTt2L4YxIHa9sW0hcaPt+FOHVDKLncWtHm/Iy90
         ehANRnpnmlo21SPCTUYVRpr8f9yxxS47UwcQhHAwag4pQSJ4kW69v1W/+CpnwIMU1GOq
         0HQBvyQVNu+XZ/7XiOD7b4k/aiiiQwUYjMA56FVGXknSc/rcvry2bk3lw3MuriKyVyeX
         LQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782760607; x=1783365407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaG174s5PBLAQx7Ys7yDqyxK7/j4IcKJ+m3GnrTVO7c=;
        b=sqaPGVdZr1XzSMykzMOAdlxUekjYHB32J9x4g3kgLWocn17wf/tBazRQKrJ2EIe/gI
         z3rYq9BcFbZo5fXYL5JTMkE2CSpujPVWF72kK24eRVK17I9PTlilBvSCdihAGq6xmR55
         cv8tNkoYLUL+1IKHLWPKxbsUzAQAw4+zpLPo7XTwOccDRCqDI5XmnHWZDWaTLCSTgrnc
         9DGKRBj+ekaGQ6GlBXqUI+9ALyqynj+7g9pFHb1vIZJ3NCosJFZv7ND3S5HyM+lrdlCh
         hB9CZoFgl5T5U24sT03a+A0rcROpLOQGa9d4pXiTuVWfZ1o9szLjx8hpZSZ17hXj1ztB
         uvKQ==
X-Gm-Message-State: AOJu0Yz9LQlkXmxEONNpGTy9fU064ga2pJ5XiPw+Ld3s3uu1z+0ZqVB4
	Vky6ywjbJoW/siJdZ+pVQPKAmaSPSZu8qiKpICDNU7uQ27TFK7xG2JKE
X-Gm-Gg: AfdE7cmrMPzSbhGPakNtx4Q3Pdb07IH7nzMMyW1YkdqGF5cQPydaUKn4q0XnYeRKKv4
	1kbq+vbqcOPWebsCGHNGPqxZNDZ+L21g2CSgBZG4siR9gUUVtMlq0t0ENuHrsKEXAWqLQLlAQta
	J1A3uqXuXNIhnxIEEdxJmMm+R5qcazFT6VVnkbSiIpFMZFXjlQeMkNVETZDb1XCaWZ5YNEFaOKf
	1UFxbrjfg4vzr7gYdC0/fRuD/qwscejxKTJn8x1qU1t2hEE29Mhd19fdtACozpJzaV2bufOSvbj
	J8HVnuLhv1bHnRxngLUmtFISthPA1Yls3ACDXzNVmJOYamBaqs0OHPbZoMLqCh6AxAHEzzKNQrN
	+MQ0xcMf6CIi5zguFzjM6XRYy6bfVvlxwpNjxp9GCi6nATZA6hqn/8o0HjpZWHLISaSYZepLZWN
	mmiD9cqw==
X-Received: by 2002:a05:6830:6aaa:b0:7e9:b4ea:2ef4 with SMTP id 46e09a7af769-7e9ed22c381mr327407a34.14.1782760607236;
        Mon, 29 Jun 2026 12:16:47 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ebf891casm505842a34.5.2026.06.29.12.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 12:16:46 -0700 (PDT)
Date: Mon, 29 Jun 2026 14:16:46 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] odb/transaction: propagate commit errors
Message-ID: <akLEigsjg3TaIEcb@denethor>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260624041920.2601961-5-jltobler@gmail.com>
 <aju-90Uayxwsevm7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aju-90Uayxwsevm7@pks.im>

On 26/06/24 01:26PM, Patrick Steinhardt wrote:
> On Tue, Jun 23, 2026 at 11:19:18PM -0500, Justin Tobler wrote:
> > diff --git a/odb/transaction.h b/odb/transaction.h
> > index cd6d50f2e5..7898770071 100644
> > --- a/odb/transaction.h
> > +++ b/odb/transaction.h
> > @@ -54,7 +54,7 @@ static inline void odb_transaction_begin_or_die(struct object_database *odb,
> >   * Commits an ODB transaction making the written objects visible. If the
> >   * specified transaction is NULL, the function is a no-op.
> >   */
> > -void odb_transaction_commit(struct odb_transaction *transaction);
> > +int odb_transaction_commit(struct odb_transaction *transaction);
> 
> Should the function comment be amended, as well? We should definitely
> point out that calling this with a NULL transaction also returns
> success.

Will do in the next version.

Thanks,
-Justin
