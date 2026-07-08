Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFC1242D9D
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783531452; cv=none; b=jh2tjExSLYOLOgYnQK9J5gjyI/AWm97KZJtPP1w/x5yo27cIPZVj1E2AUdOK4c0mlP9GyXN2/ojnkwMD4ZqiDLpvA7y7uZNaio2cpPOKxLdmKUi2QyzqJZtrU9yrYHRDuHu4jahvIIgZNhAdmH6dsa3FtLn/930UhdfjsP/BWcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783531452; c=relaxed/simple;
	bh=vAq/zhm7z4q0sxTih+Npmnb2n10v4J71bcCYjMKPK7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4mBRiF2egntAKdW7DolvDvrAxBPWvldBvoDdwG/b69Rju5oYXieITYVjkG2bVBuWOa2ktKvZ2bMPeAF3c5LSPqL2v1hUXMW2SKHZlLuTY2wwzyaVJnqa4Fj20MCSJ7Gr5VhjyJT2tPKo3q+TBvczoYOkCbxAV/3tLRlwT+wnyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZO6cxmI; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZO6cxmI"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-44cf70de986so380241fac.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 10:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783531451; x=1784136251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eytUUEiyvGOtYx3Itkol4Sw3mDbFBJatXI38N6a/l78=;
        b=SZO6cxmI5E6yaFg/nsutj0Dcfb/kEPgSc+3A08c0Rj42PPIV9kWmmVe1UpyBi3wB2o
         v18E0ucsb7HDW+qrDy5yOqfo9F1iifOB4D5gpnLy42Fm3PeL8tYBunJjD7sK8qMxik0z
         hn8kSpTsEMLq17Ui0lcRZNyEJW8yg4+u0s7eZRgz6Y8hd9l0rBtnqmlbDYyz6qaIdybe
         N0hA/FNYXm+bAx5hCrBpmRMfSNPXM2aNCpRVpvnYDuGSFbg5aY8CaoyyY0t8BT7fM5IL
         UkEoh69LHLFnXYYZyDGV5z7fnvL57P5tgueeNaHPrY8hSa/ASe0ZIkS9Ox+KAe0qDxdG
         9+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783531451; x=1784136251;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eytUUEiyvGOtYx3Itkol4Sw3mDbFBJatXI38N6a/l78=;
        b=B4r0cv1P9KekPmu4yk4dJuuv4qundM/OFbz+NmcrfTLfh+fa8V4UJbC8CJdL73Oi4+
         qR0BDpbBgh9CDMV1ArkdSGP1EoJT81MGw/3Z4YYg4tZJcITRRL4+5Aoz+hff6sehWBZP
         3yZj7hJxtt1kex7j/kCFFD+sNQ8HkkbuD/BS4TbVgHD1lfOoLCewfrHf0jd5q3NDKTTB
         tTqN/nlc36oQ7tVpIMof0lnDnxfmUu7TUAnKgIfR49FJWw4V+GJujMPI08YDZeqdTnIq
         Yfx4Hs183cyyY/8EaNCpp/FEvYd5btf40hKgocBgfBsXL5tHOVKRUV5O3ZUxiD1FWp5g
         Mw3g==
X-Gm-Message-State: AOJu0YyAVWuVlP197751XCuL6bIt4JX7+khG/ES9VbpqFXUg8oaz5mOZ
	m98Dm7xWhVAt+x9juLvzRF9/NM0lR+vUjdMAxSsyH1AiK9w3VIwgynPy1/jTMg==
X-Gm-Gg: AfdE7ckxZNEtLPjb4Xm01v0iOdP3AcACJcrl1MivmW8NI8Fc3ebglqyoqAQPQPTBkH8
	0b2sCyQxVXdT2r/7avDVkc6MYBL26FAOGoKeGe7xPlr3CYfTx3biV6AGFVAFZOIcA13Lmj2wkSr
	BchY4Xj09OCsZaUu0je5lBj1rZyB41yHjBFkxxcBt0XYlHMLv/iKTffFAPFOkPGHsOY/ES9DUEE
	3BDarAPhJYJM1nFL33erWOuN52ByhVCZBXUoQBN2RnmRVV+nP8u4L+chqL6GPLUi9AgVHe6Hqnf
	PWSyruj8ego54CAnwV4iL1VY/jGMT5sDgwSgRl/dGEfp+a0PTT+Qq16M0xOqHhQny6uyTh0zRak
	KF2EaZtaQtn0PZDevIbiAq4MU9NGxl4/e5OXWOQ7SyGkAAsey6SUZxkQ9OBknLudhpBRqdnP+9x
	nN8rst2w==
X-Received: by 2002:a05:6870:2150:b0:449:bccf:bb6e with SMTP id 586e51a60fabf-451637bc19bmr2189139fac.7.1783531450518;
        Wed, 08 Jul 2026 10:24:10 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb13d624sm17201625fac.1.2026.07.08.10.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 10:24:09 -0700 (PDT)
Date: Wed, 8 Jul 2026 12:24:04 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 07/11] odb/transaction: propagate commit errors
Message-ID: <ak6FHKdfPyi4_DLX@denethor>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708041412.1157499-8-jltobler@gmail.com>
 <ak3xKlQTPP5OXYRn@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak3xKlQTPP5OXYRn@pks.im>

On 26/07/08 08:41AM, Patrick Steinhardt wrote:
> On Tue, Jul 07, 2026 at 11:14:08PM -0500, Justin Tobler wrote:
> > diff --git a/odb/transaction.c b/odb/transaction.c
> > index df4275151b..51af2c9a61 100644
> > --- a/odb/transaction.c
> > +++ b/odb/transaction.c
> > @@ -16,19 +16,26 @@ int odb_transaction_begin(struct object_database *odb,
> >  	return ret;
> >  }
> >  
> > -void odb_transaction_commit(struct odb_transaction *transaction)
> > +int odb_transaction_commit(struct odb_transaction *transaction)
> >  {
> > +	int ret;
> > +
> >  	if (!transaction)
> > -		return;
> > +		return 0;
> >  
> >  	/*
> >  	 * Ensure the transaction ending matches the pending transaction.
> >  	 */
> >  	ASSERT(transaction == transaction->source->odb->transaction);
> >  
> > -	transaction->commit(transaction);
> > +	ret = transaction->commit(transaction);
> > +	if (ret)
> > +		return ret;
> > +
> >  	transaction->source->odb->transaction = NULL;
> >  	free(transaction);
> > +
> > +	return 0;
> >  }
> 
> Doesn't this cause a leak now?

Good call. Ya, if odb_transaction_commit() fails, we don't free the
transaction. In the next version I'll go ahead and clear the transaction
if we fail.

> I think this interface here is doing the same mistake that our reference
> transactions did, where we automatically released the transaction on
> commit. That caused multiple lifetime issues with references all over
> the place.

Ya, it probaby makes sense to introduce a separate
`odb_transaction_release()` function to make this explicit and update
callers accordingly. I have another series I working on that introduces
`odb_transaction_abort()`. This might be a good place to add it in too.

-Justin
