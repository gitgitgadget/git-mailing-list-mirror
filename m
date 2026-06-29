Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1931723ED5B
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 19:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760517; cv=none; b=VpDEALUJV4QST5W++F9s1dpBUE3BhICIXXTygqkaQcRbXe2Evbqhkq+EVoSw4hlPN1oE6g9j0w3ghe/iR6njro71TBIZIWmYE3r3WhgDaL/pBer+IcHDgsk2sbD8laMGdseeqAHvbm8P2LmDQTh332/JToQrx6rqci50lqaF7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760517; c=relaxed/simple;
	bh=xaCY3COIQQown9utY8mLKzck8aPUHpKk5ZIhJszHwHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5AXXI5pYmxDH/blIHdmCRu4krKauXO+MA6p4khm09CG755soPwGo9yMR4oHaMSPrQqR5vVK7NYGNHKmZI2zq41OtCk/LwJI2cfash4z6YRQL13IiBUYdPB51rLs4AoRV4Yyc94ZSpiXtS6s8DxzWT5c1MDbQwl4tTdp2AxMN4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sPUBoAgY; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPUBoAgY"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e93f93ed01so2353508a34.3
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 12:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782760515; x=1783365315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qktEx/YlZVOGwRAfdoKJqG8O1Fc9Uf3CUZf2ej/v4JU=;
        b=sPUBoAgY3WPK7jjZMazzGRMKnJSjyQED5x0gbLjrQVeGMC0kwYnT3hdFjbwfM0wO4d
         XVhZSLEPHlv19abvrcoe/tJ5A+9LG3CMt4audYpo63z0WoCpmi6AfNPO45qHCIzSMZhX
         XbFhx7dZr2aoYZR4LgWpMtHklqWvvQr6QkXh6zbK5mWaSfala3KatqeiSU8j7wAXqV6u
         Ry48QJRzhKZ/h5zP+Keeafh0A8HoaOiKTExfOrYPIhIETjvGgwDiWyFogBEw9kH26rjt
         +e8y7+5HilXicUWo5aiTveOuyUe2+8DQPRWPnvN3KZFtemEghKZYobIDyfPm/9jcmFo9
         Z4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782760515; x=1783365315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qktEx/YlZVOGwRAfdoKJqG8O1Fc9Uf3CUZf2ej/v4JU=;
        b=k8d/RHhlUS56wLqJocXRK90n+6ktl/K/6b1cbODdpk6INiCtVMGmK3eAAcTZsjzOGQ
         Q2HG3AZbwBD0UOKXejOdED4cXdASi5ohMTZVTfTLkC3C1+G1yRarEgG7/+54iU2hIXMB
         Pw+mZE2hPl16+PA1kSp9aHJioRoE1oZufQO0UlIF0TO4dEH0wl52/qkKY+dWu9KQCX75
         qkFkDSRHZehGtItyqZJPF45h/AHCLlsQmq289fTkNGTI4TKETmetcORnoaWfyJy4jyyv
         cZyDgk9C89ezEeoSGmJnl8sq04UefrODToG4pV2YGzkSUKj1+UCUuXh40Alu9qow5iP3
         3y5w==
X-Gm-Message-State: AOJu0Yy6ntnjOhB/b/7+tCE7ZLRazNkG7sosLm9WCOfc/+edHNgP2unC
	asbphBYQl5DPuZ8lTIlWuwx1s++7enYRufbTqAlEbwtPvIO9PfYhuzah6HzeXw==
X-Gm-Gg: AfdE7ckrnkfpbEt3F3LKw3T7+aQnXP9MASID78DCtO/4Fb5NVJiqYPkuGh38/qL0w9d
	8aZL/s4jd0vTGIfA9oxoPAj36a+yKkEjH4MOLsjPQJJMr6xecDeuVY1bmkQC5xMaBmZx2h2DwRe
	zCg05zhQ8MIH7mgLEhZn9h+KAL3IHxVMcR/sj0H5dRxCEaczxGTSOL2dpZMj1xgT24KEVlEIKWc
	o+shhEhh4h+xcQfMQLg+P6AZYGDnD5+wT625hAcLK/CcYIEJf/Zoi+iTFjCkRpEdWkKDf5HtR5R
	lWRUgJCLQDP3TIQ12n3lAbWss2zgck1gqqyggsd0aNHktIcqpNqQ31OAEbBPMJiEVZm/vFJcReQ
	n/ZRavuhn5CZ6X0rCQ450+0F7Mqd0neh+VEFOKgNmB9rF+8iSS8zKIlNNu+KtbRe3ZZaQXEgYbL
	jWFFgaHw==
X-Received: by 2002:a05:6830:81f7:b0:7e9:e82e:e683 with SMTP id 46e09a7af769-7e9ec5958afmr645204a34.7.1782760514952;
        Mon, 29 Jun 2026 12:15:14 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ec34f898sm473563a34.27.2026.06.29.12.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 12:15:14 -0700 (PDT)
Date: Mon, 29 Jun 2026 14:15:14 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/6] odb/transaction: propagate begin errors
Message-ID: <akLDimUfWnCtRL6e@denethor>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260624041920.2601961-4-jltobler@gmail.com>
 <aju-8hUeuyL6gnNU@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aju-8hUeuyL6gnNU@pks.im>

On 26/06/24 01:26PM, Patrick Steinhardt wrote:
> On Tue, Jun 23, 2026 at 11:19:17PM -0500, Justin Tobler wrote:
> > diff --git a/odb/transaction.c b/odb/transaction.c
> > index b16e07aebf..d3de01db50 100644
> > --- a/odb/transaction.c
> > +++ b/odb/transaction.c
> > @@ -2,14 +2,20 @@
> >  #include "odb/source.h"
> >  #include "odb/transaction.h"
> >  
> > -struct odb_transaction *odb_transaction_begin(struct object_database *odb)
> > +int odb_transaction_begin(struct object_database *odb,
> > +			  struct odb_transaction **out)
> >  {
> > -	if (odb->transaction)
> > -		return NULL;
> > +	int ret;
> >  
> > -	odb_source_begin_transaction(odb->sources, &odb->transaction);
> > +	if (odb->transaction) {
> > +		*out = NULL;
> > +		return 0;
> > +	}
> 
> Hm. So we may return successful, but not set the `out` pointer to a
> transaction. And...
> 
> > diff --git a/odb/transaction.h b/odb/transaction.h
> > index f4c1ebfaaa..cd6d50f2e5 100644
> > --- a/odb/transaction.h
> > +++ b/odb/transaction.h
> > @@ -33,11 +35,20 @@ struct odb_transaction {
> >  };
> >  
> >  /*
> > - * Starts an ODB transaction. Subsequent objects are written to the transaction
> > - * and not committed until odb_transaction_commit() is invoked on the
> > - * transaction. If the ODB already has a pending transaction, NULL is returned.
> > + * Starts an ODB transaction and returns it via `out`. Subsequent objects are
> > + * written to the transaction and not committed until odb_transaction_commit()
> > + * is invoked on the transaction. Returns 0 on success and a negative value on
> > + * error. If the ODB already has a pending transaction, `out` is set to NULL.
> >   */
> > -struct odb_transaction *odb_transaction_begin(struct object_database *odb);
> > +int odb_transaction_begin(struct object_database *odb,
> > +			  struct odb_transaction **out);
> > +
> > +static inline void odb_transaction_begin_or_die(struct object_database *odb,
> > +						struct odb_transaction **out)
> > +{
> > +	if (odb_transaction_begin(odb, out))
> > +		die(_("failed to start ODB transaction"));
> > +}
> 
> ... we don't special-case that here, either. So a caller may invoke the
> function, not die, but it might still not have a valid transaction. That
> feels wrong to me.

Ya, the original idea for a NULL transaction to signal that there is
already a transaction in flight and nested ODB transaction users to use
that to determine whether they needed to start a new transaction or not.
I completely agree thought that this is rather ackward.

Instead we could just make the callers that are worried about
potentially nested transactions handle this explicitly. I'll do that in
the next version.

-Justin
