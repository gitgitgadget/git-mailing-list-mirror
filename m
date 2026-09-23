Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F5A3A5E87
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 21:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197502; cv=none; b=dbMFXzhXVKcQFl1pEUVpjvrxaJrCzW/U9g1XCjyxmhlL5O0nB95KN8VEx0hciUZb4DJA4jQfCA/CiLyW9Cu3vzjWLucDkfOkfVSS45YT1QgwLmy4vjd+72uJk/caHR032GUheS9uQII4POM3K4BJHssqPl8LNpEFQsBAyy44PFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197502; c=relaxed/simple;
	bh=RtNiwGk/IzCNGuJvxPIKJL/wk/uji0k6qMsnsUu5KMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLFemEE2faX03EkyyN1sB35N+fokDcHhJKkF+KvdbrOnDLTQgBczsQxk4VQK+Lw7lELyRti9bhPgnDhurV9f0uwLpHh8XzAu1zA70MxPqlA5Og/bcAH8q4pcqMvrWyKfAIHOY1jFQ4SBCd4pMwC9To61S87OCZPbq1BFI3nJ9Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/RiZ3Qo; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/RiZ3Qo"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-80032c08611so1092061a34.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 14:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790197499; x=1790802299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Iep/20jMJ8s6v68gGLWQv5mdllUXZWnzJixdNgS5KSQ=;
        b=Z/RiZ3QolJ+vGOAqN+J2tXREtU9lQRk4i6/7qs9PKTY5ktKK82dCdmrq81XFemNHT7
         CPTBGctegAikIApouDsgbL3S7ZPlt5JeOY8iFi5lXUGMlDNYMuXIj13aRaXbb9KVPrxJ
         h7AYYRv9HTVQcotr7+s6QyluVYfJEn9424rvYXwc6HHUq6Uj3DRYzQ630P+vpKYey8n2
         +qvPB++YR7r1bX3QHUE0c47YSgBS4AHu3MgGTdOsjI+NO6f9eJUFr1qUxJ806MiLn8nG
         q4Pv+SfumKJLXwOMI2KVFc8K5va+C50Zwz7EMrUhyK6HMnWFFRdVAJKLNY5/0fbhdx8A
         yM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790197499; x=1790802299;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iep/20jMJ8s6v68gGLWQv5mdllUXZWnzJixdNgS5KSQ=;
        b=HS8VpEQd5HuPKiKpvrsH+29WNKC+c3jjVANs39DAlkboV3x0cwvMBo6EZqZEgm6SsG
         Psu9aZEyQsQAkB7xtRbVB3paVdq87dJwf4k5t9sZTCq7e9dq/tamSs+dp1ymLbczeuHT
         Qq9GUn62cJWaTNdpLC9zpVkSHKueDXhcN+IafhBxZD7TgyQuSfk+1NHrYheWqi6gf/ag
         mVmdRetaAjd5UcoMD+5oAlIgmzR9tKMYlnRPr3rpz4GiuGDhsSsE9zCllpVdY/2JUWSr
         EptlRLrIRryKHXAT4Jxrxjup9YfnIyDTm1VUI2PH8gjKolSLnFqUgBA+fS+fh8rlgvcm
         GOnA==
X-Gm-Message-State: AFuF++k8AtyaFVvXm2KpVS2S46tFK4cy1zjfTHVOvXZ/5Wq0uMq50rdU
	D3fBsK5csw5kM/37gdztu+T5eHOJ0D8QC8yrBHxA4VzSQYKYVPLL5mi2ehqqBQ==
X-Gm-Gg: AYBFou35bK+TSh2pNPmW9VeLEIfC3/FWQP0geQcu8svAwEmCU6+sSmu5kk5GyUmgX9p
	6nwQWF0gQMoLE2SBixkiBkAoO6jJQiFfEkdLTN11tDi0pdD55OuM9cC5NqofA7AOYApq5z9BKCJ
	9GvtRjZPKLFQz6YSqpXA0ugV6eyogipSEgMC/C+zVdJ5qclW1N/Rc20ZBigvI8FwhskICGwDzby
	GIxGnQ8TLJQZks3Ezi0ipDE22cgl9AMoP9Ftja+thOn4ehOG4LqmsmPKAnClCk7TVN1mP/wW4xj
	qCUP5gKS3t5i4G1Kp86AVMCptH92LAiwq+0yZaW9s51mwHaftK83mzYX/1iyXaohsOCQqx/nWYn
	QAaAQHWTtq8swusIzAouIfJx6FE55XTWv91kqcIAlWh6Vd1Jq2y3d2csqlavbYm19gqo2PAUAiE
	WtV8FhMLunxGWwtzDHi8DJVgd/+qJxvyIEB0VfC/KeMqRT7+7U5k9TdY9e1pDtZfzjUOTd+AMaL
	hDCApsBsMoIgtaraPy8v48=
X-Received: by 2002:a05:6830:660d:b0:817:bb8:cb7d with SMTP id 46e09a7af769-81782b845acmr515843a34.18.1790197498851;
        Wed, 23 Sep 2026 14:04:58 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81603ad13f7sm3918294a34.7.2026.09.23.14.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:04:58 -0700 (PDT)
Date: Wed, 23 Sep 2026 16:04:55 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] object-file: lift ODB reprepare out of packfile flush
Message-ID: <arQ8nsUzg9atdCeD@denethor>
References: <cover.1789328612.git.jltobler@gmail.com>
 <cf14416f224f48475dfc9f79d8ec62756b9fdedf.1789328612.git.jltobler@gmail.com>
 <arPQrtYHen3UAvdk@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arPQrtYHen3UAvdk@pks.im>

On 26/09/23 03:16PM, Patrick Steinhardt wrote:
> On Sun, Sep 13, 2026 at 03:26:21PM -0500, Justin Tobler wrote:
> > diff --git a/object-file.c b/object-file.c
> > index a4cbf8b081df..0f123b79fad1 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -909,8 +907,10 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
> >  	 * to zlib compression and is sufficient for this check.
> >  	 */
> >  	if (state->nr_written && pack_size_limit_cfg &&
> > -	    pack_size_limit_cfg < state->offset + stream->size)
> > +	    pack_size_limit_cfg < state->offset + stream->size) {
> >  		flush_packfile_transaction(transaction);
> > +		odb_reprepare(transaction->base.source->odb);
> > +	}
> >  
> >  	CALLOC_ARRAY(idx, 1);
> >  	prepare_packfile_transaction(transaction);
> > @@ -1260,6 +1260,7 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
> >  {
> >  	struct odb_transaction_files *transaction =
> >  		container_of(base, struct odb_transaction_files, base);
> > +	int have_packfile = !!transaction->packfile.f;
> >  
> >  	if (transaction->objdir) {
> >  		struct strbuf temp_path = STRBUF_INIT;
> > @@ -1293,6 +1294,9 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
> >  
> >  	flush_packfile_transaction(transaction);
> >  
> > +	if (have_packfile)
> > +		odb_reprepare(transaction->base.source->odb);
> > +
> >  	return 0;
> >  }
> 
> One thing that I'm curious about: we don't have any error checking for
> flushing the object directory at alll. So there is actually a change in
> behaviour here, where we now also reprepare in case flushing has failed.
> It probably doesn't matter much, but it does raise the question whether
> we may want to start checking for errors.

Regarding the behavior change, I'm not entirely sure I follow.
`flush_packfile_transaction()` only returns early in the case where
there is nothing to flush. In both of the above call sites,
`odb_reprepare()` is only invoked in the same circumstance.

I do agree with the sentiment that error handling could be improve here
as most errors are simply handled by die()'ing in place. I'll probably
defer doing that as part of this series though.

Thanks,
-Justin
