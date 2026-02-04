Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F062EDD62
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227433; cv=none; b=CXWOGERBx0ttT9tumOiaJGNnfwvQA4/txAkDkpGJ7+kO1ju8U09rRk2vUa84WZdEdcyDRTa7ehPuseiFbWSqNksfgOHHZhUUQCi2eIZsiytttr1WNrLDo4C1VCl1v2RgOBpcRmtH2ce52K1E9ZFK4GFguG33G2Oj5aJP84WZgz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227433; c=relaxed/simple;
	bh=vwybE5O2NcV/YHNBah6aIEXxhsEt0gqP8E3nj4GRRVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xpr+EXeb7ShpkgH/Vp+S8Pdr7F5oOPGzEp8tZlPeUcE2iBBYC9O7VpOKYEHNdDrWPWkIl/DF5tEt3FB4j7XBOQ+aDc+xFw1VruWxOZe1v8eY9ZZHeQky8E7iOK7yZyin2PcFFJGHs9k0SneVqIIRT6BdEjTMDoPG8yK1wxG3Ij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8+owR3t; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8+owR3t"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d1916d1e24so42062a34.3
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 09:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770227432; x=1770832232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NTLjgNdvbh7MIf9N8RHbgnts4sbNPAt7oZgF0Sy89y4=;
        b=Y8+owR3tjYa77MlUw+PvuglTlG3hTI20pNbOuvGgJEJdUNUJRYNxLGWWqXLg8B4YT9
         QZQn0/C2YJIOmyid0iT0lvfkj4FV7Z+vYzth79Je/XRSQzBu5jnxrWB6pWXtKxD5975k
         UCAd8ZuauMGCLNh/2pOQAWo1W7O+6kBpzjMLUbvr1mHllsK3QUhqEbFADrsDVho+hH9u
         lFT/Jqf+ev7nEP/dP/c/azwFYOrV2pfVsfwMrMLpBq5zhVm+QoPAao4NRMWYfDumWvlR
         HDukhTaTpQEcjI8WH4S9MhkX/xOdOHw6qbS/ICK5aLXNh1S43yYjY9Kvc3rr89rsoqkO
         IReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770227432; x=1770832232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTLjgNdvbh7MIf9N8RHbgnts4sbNPAt7oZgF0Sy89y4=;
        b=lZNQ8J3PlaQuBvVoureE66vvj+sExvIBDOJpDtosmtSYz/xsYQnNeD6EK67CEld3Lg
         6JOhGcULbeNOmQtHDCyVdXuN+FEs/qW7hmb9Fvp0gTz3Jmb7HjN30chNLsdfvdDjVY0R
         osJDBp3uzfCDVwTnrRHR8ivPjykf4UYTtTBfN1SSdznDKuLnl5m/t4ctz8yTBkSJDSRt
         Gfiy2PGtol3k9nGfxTg4NAHCUbd8bFenznQvMTULr5cHpoRGrno+RQ/XnSc5bH4a+MZV
         rGxtGgSerXpXVCVVpaiu/E3kgoz7AUNPdl2B6fTejb31YHFAerk4SFkCGmLpe+YdAnJx
         BajA==
X-Gm-Message-State: AOJu0Yw6slIF27IZg5EIGx3lWo1RCkha8bP0W5gqfhoj3zHjMorsxLt0
	Vv+nZrpoxFUDHtydJqzXxPsQBiHdThdKKaQWDrfzr4zILHDF7wgd/Fuu
X-Gm-Gg: AZuq6aLVPC6WBe5fdmtWB8iiNZ+e8tr4XaBXjjb34ZujF9aYVDSiMAurLURq9ou4rt1
	GcYkG/TRlYV8kllnxPKj5brHmWaF/MGapze9RYFaNZ2OR7Sp4HP5iFxIBQBCBNiw5LE2UvDKISc
	3hVZ/3YH4FyAB8neGTnB1jDrZO/9gLR2hiVX7SflEl9XFlJiGBYvB+bFqPfuFSsEuE5Lhhfiuar
	5LqNKVXMcwuM+6+Su52F4FYerBLDKI0x73T8zZ7fk404rcr3XdFAx8leMWXOke34AF9pIY/APAX
	k9MYfVgVOb5Wu3rmNLJs76yHTFoAw2VRYpyv1S8do3S74EtXJqLyt9KB9khoLvzkTQgCCowkdLh
	7NET3JOULogD3xXi7uhGxLfKxeAlTOKi3PCC+i6sdtE+XpBKuWcNSYGFLFXQ1maEK94YT7D+UQd
	onJdmd
X-Received: by 2002:a05:6830:488c:b0:7d1:956f:355f with SMTP id 46e09a7af769-7d4489a4c1dmr2221672a34.9.1770227432110;
        Wed, 04 Feb 2026 09:50:32 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4490f3c06sm2053236a34.2.2026.02.04.09.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 09:50:31 -0800 (PST)
Date: Wed, 4 Feb 2026 11:50:29 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com
Subject: Re: [PATCH v2 4/4] odb: transparently handle common transaction
 behavior
Message-ID: <aYOEQUIPXPIYeCw-@denethor>
References: <20260128234519.2721179-1-jltobler@gmail.com>
 <20260203001002.2500198-1-jltobler@gmail.com>
 <20260203001002.2500198-5-jltobler@gmail.com>
 <CAOLa=ZT_7o_YquQ_mAg6sn=gq0Rx4Tga4vNsVsPt3jCUh=3tzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZT_7o_YquQ_mAg6sn=gq0Rx4Tga4vNsVsPt3jCUh=3tzw@mail.gmail.com>

On 26/02/04 10:34AM, Karthik Nayak wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > A new ODB transaction is created and returned via
> > `odb_transaction_begin()` and stored in the ODB. Only a single
> > transaction may be pending at a time. If the ODB already has a
> > transaction, the function is expected to return NULL. Similarly, when
> > committing a transaction via `odb_transaction_commit()` the transaction
> > being committed must match the pending transaction and upon commit reset
> > the ODB transaction to NULL.
> 
> But isn't this merely a limitation of the current implementation of the
> files transactions? Couldn't a potential ODB source support parallel
> transactions where this might no longer hold?

Just to clarify, this limitation exists per Git process. For the time
being, we only support writing objects to a single ODB source so a
single transaction for object writes seems reasonable for now.
Furthermore, the current "files" transaction backend relies on the
tmp_odjdir subsystem which means only a single temp odjdir may exist for
a Git process to write objects to. 

-Justin
