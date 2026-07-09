Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A59244687
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609340; cv=none; b=eEaYlEZbI6hRhcof0LK/RSwpyWg0Dtxf5wqsMo+CRLb3MSALoOdYPlqDKzSaqA+ZD+DToFX0qG037kpBNLcBIMjVq/ZSqz+cbZDbxpQToY94jscj+p1hp6fq3ODabwBsIXyR0cfHAFa/lhX2Iw74UvZX77yTghn8qWnv28yvYuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609340; c=relaxed/simple;
	bh=/NTjsKW+6CL+vw9sah3VHXUmTBzWeqjYtVcDUc4keGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGAJWFQ5xrsfeBH3f8uPduLnKKL4+v/WSfM/0UB66TsslBGPRc/W+pqJ9Wamrag10DALvR2WG6lxvot7gV4YBmYzzk9B9EjuLW+HUhQfIMI7qA97h6cJxQUmhAVEKd2/n7H6w97zmGrunyCHm15cw0qideQ4O61RhYYDSqyIAnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV24voY0; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV24voY0"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-80814edb536so26840337b3.2
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 08:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783609338; x=1784214138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ykmE2DQP+N2GTeEMMwnFQkkVK0OnEAmLMjKIBdzR6yI=;
        b=YV24voY0FoO42+x0K3tiAUdln4Ox15OIoq9KKXlZjNHTOQjT5TvEyIVswCJJg5cGOQ
         a/FeK029YDiamrYrN7j94fovrfuLjeMowQ7EcJGAzW7ZpOK8/cv5MQim4gSBSooSMdwC
         95ZD9XlVjqr/27gs6O2rEqmal9NVwEKC6th5SJRPvUbBi0E917I/q2jS7dDteXRGqWk6
         pqzMddkHa5cc3k6CEGv2w7lWZQPsjemrPSRx9RqZy0/cWGkeMCHUtg6qXz4lboYHTZyO
         1OSPvWX574f7jZrF98Ew9sfzla3nR3jN+3cZ9T0lIfZquXcbe8qBLr99K6jBS7uTsJCg
         rSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783609338; x=1784214138;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ykmE2DQP+N2GTeEMMwnFQkkVK0OnEAmLMjKIBdzR6yI=;
        b=rYbBGetnAFI3hIATuH1sTQ1M7mhTzkJYKi04TqYO3FjJPKekMa12TNIUlrUf8GiW2C
         puhTvv2+Oo6wI3H9XB/W1EFc69sqMjtn+E3KG8YGmI56Xi57F6gGDon+88DBhMorOy/t
         MIFRWqmo/hEF8AgtSCAjfKGBMUnAZVw8VM1u7b026XXlvqKZ2o9t1aKY+6b3XydANcI2
         BBVERzwc8gSvqLSHYtDd5PD1bpn2AcqYWDI7StcHyW7mxX5+PW/py6W2qjxO6obu8Iu0
         pyP5AR0rAJEpYsPPKi5ZaH7C6ZrC4pFl23l+nn7MG+zGHOihWdptjmN0M4KFjUNLmvFq
         mbVw==
X-Gm-Message-State: AOJu0Yy+Cdl7lLwTmJDgQYbfL9httskUN6NVQ4yAZ1yv80VqTr1trWng
	jfFDxc4XlSJIAN8/3J9oxJWpFa2ETOtKJRqY84YKrmpkrlcmB4xUOOs6
X-Gm-Gg: AfdE7cm8EnkQze+E9zN5nfhIzaufBQH3tiHGYvSg7neysSvv3h1Ag6sYxsUGKWp9wZn
	fCCHnIfGGsRpIdQ53rIDxkVWb9PFlb7+npkSgd7c8tn1lnRtkxfIisGqYFViqurTTfJrki1akfc
	Tk8e90lt6Cr2cR68WNUqAGEivr0xCjjn0OnfvpsJmsojmXw5dbO9ejIT57p9yhTyrRZnZozo/+V
	YxhMm0cxF8EqexgcxxPanPM9DvjtUzGE3v0B4CgxPLFSNoTaOjj20DFZzIdg9fEKbomvK+M1CsE
	2Db9ZVMPS5JfBcvW1tNeZPTBIkIvW0DHeDZ1SwG3fFvt+S5SWeeiGChMyhAz1jByCFKHBB7QDx1
	p2EIfxr7gA6L3/2M3qKILB37YJOLMT2hjcukWbFA0Y5DZcuA7YkSTMtOn6HKo87OQXnUA+QYVrV
	Qh8EFEmw==
X-Received: by 2002:a05:690c:6c81:b0:814:5312:47bb with SMTP id 00721157ae682-81dc1e20a01mr55395377b3.69.1783609336754;
        Thu, 09 Jul 2026 08:02:16 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6bf653desm20564877b3.17.2026.07.09.08.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:02:16 -0700 (PDT)
Date: Thu, 9 Jul 2026 10:02:12 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v3 08/11] odb/transaction: add transaction env interface
Message-ID: <ak-vJ2hlAHLbg8Zb@denethor>
References: <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708235925.3992097-1-jltobler@gmail.com>
 <20260708235925.3992097-9-jltobler@gmail.com>
 <xmqqbjcgrg0e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjcgrg0e.fsf@gitster.g>

On 26/07/08 08:36PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > +static int odb_transaction_files_env(struct odb_transaction *base,
> > +				     struct strvec *env)
> > +{
> > +	struct odb_transaction_files *transaction =
> > +		container_of(base, struct odb_transaction_files, base);
> > +
> > +	odb_transaction_files_prepare(&transaction->base);
> 
> Can this fail?  The caller of us would not notice that something
> went wrong, and ...
> 
> > +	strvec_pushv(env, tmp_objdir_env(transaction->objdir));
> 
> ... happily ends up using transaction->objdir that may not be
> appropriate for it to use if it fails, no?

Ya, `odb_transaction_files_prepare()` can fail here. In practice,
failure results in no temporary directory being created which
`tmp_objdir_env()` does handle gracefully, but we should ideally still
be reported the failure back to callers. Will update in the next
version.

-Justin
