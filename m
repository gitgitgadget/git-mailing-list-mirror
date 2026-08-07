Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410FC17A309
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115514; cv=none; b=MenCx6iiP9pKO8TnJMcZp7F7hoKOM8Rg/0WjCPI5dYpbu3ALO1rfzr9VvdQsAPR3byfwhXJCrRwxp1rjdQ0ZeDccbwjLK8VSkhcA1l1S00zEg4YksO/1hNvFL2o0GI/O7BC4Hqgfij7hPSEHjBvq+OMxOfXymi/boLRGOESTMfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115514; c=relaxed/simple;
	bh=Ux9UQVg/Wc7Pl4SmMn3lPkEXSNGtMWYREK7lcc8QdWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYKPYSVKwQyZMDZ1xFVVc17TZR0zTYcmqFKDseTVcvQ+c69Zt+heHih4Ispb4UIqAmBBCYNSzfZ20KNB39gK7jsvMnxwqhFvq685M1LUdZucGMwq1FKZIFYBRTqUzuoA79NssnFW5lcGp4V/4X3guj/uQynnda4XrnM/FxClUTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ah1DjFWq; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ah1DjFWq"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6b026020b92so747243eaf.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 08:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786115508; x=1786720308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AEbq/wj+gMmgHonHnVQQ4D/ZeUtT+URVH8ZJ3vtHDUE=;
        b=Ah1DjFWqpIQ+rqF3yvJ5EI3X3L1OcVf5RL/i0UmmDTCHDg8PgzsFfD/BffweWOz/yC
         /SqSkChge8LSQnS0DIywn55AwoVsBteKJxIV5wrttVgNyL++CGN/1BoC9nnAB0CcQNLq
         hs5zz65hrKk1MpM1PuyVufCCLplxkmIqpeKAG17olsj8fxznwXB7qhU6Fa6eCf358EAe
         N+AQCna90bp28y358RcwRMtq/cfhyRCjIUbVTaSpiosTtqHyBzANvcW2SahOIy5NGJYz
         pcr3WVx1dGQO1xDoHLL+1Wi1AAxl6rOByUdO8gV8jU72pKFyjrvBWq02JQU2xHqTNwiR
         vNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786115508; x=1786720308;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AEbq/wj+gMmgHonHnVQQ4D/ZeUtT+URVH8ZJ3vtHDUE=;
        b=e015Fi0B/fq9r/FO/AIPef9TPRUZBflNksved/YyLWzyV5CFu3Hdfe+CYMLVRxS5/N
         ZvOLcP9kELB5R6ssaVKR2grsI9RqhTRgso+bpSrQhh+YAvzcYiuo+x7EtgC8QtZoiaE+
         GXwjgIGeGlzul4KYhZAimNlLlNDk/TN94nrLJFgU/M0+c8Z5HUFnGpNWQDBEuTMLy+Dl
         bOlx51ii0Z8oHAUBtzU0vOhmKUvTaGrH7GMvkKto28He7BhmEuA3xAsmgdH5sPNAZsYg
         jyNQuE9stzZjrNh7FUmxiP3+gwL9Fqi73bQte++obiszeFFu1GTPB8ZADIsWMTxgx92m
         dk+A==
X-Gm-Message-State: AOJu0YxQjUwi2uPiuBlzmnHnRxfXTksKgd1BjkzUWUhRYKtHzCccEKjb
	9caqsWivNGUTvuPVhc54bvgPDFxXxFBUAengK5tPW5SZ0uoCaS3CdsbKWW7ssg==
X-Gm-Gg: AR+sD120mqysVeeprc+WvKGF3R1HniNcTILhjc2Foq9+JQOW6GOkxxbgf7DMSGn2coy
	AebQe8v/LHnQlO/J5ETptPZEJmTzp1/2Pu1IzVyH7XrLFdNBpdxnWp/1YsXGuX1O7X/0pPw/uqk
	gSRuI2a7JvMkj5dPvCA+5UYA0yr7IbLxgoTj+GBIyeqroBXCno19gPSh4n8UUlSeqZkMOJ+o5uj
	rItsWTkaJNiTkPoFMRU6MCRkAvL48DhLj6Pz0W70g2EMlzp0Xjm9oWOeduPd6dcgzQu+tzAnPhm
	SGTME/da43aIRiNn9WOr7M8VxBMHWr7JxIhS08Bh1FcRoxY2UBKeyCpc1+0CS9Li6r/lVfB83dN
	ul0nlK4bSd5DqxyhGs/Wm/YPlws/hBWgx/1atDIDZLUFcoh2SOUC3xfiklPkw+TGaWDiTfLSO9F
	pd/om/y2zvt4QR5VpOF6+dTPBpSQdWkJG0Lue+J8MdkcSJr5f6fJA+FQ==
X-Received: by 2002:a05:6820:6ac4:b0:6ac:b5ae:65cb with SMTP id 006d021491bc7-6b02127098emr5215297eaf.14.1786115507647;
        Fri, 07 Aug 2026 08:11:47 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02bc25c74sm2568769eaf.5.2026.08.07.08.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 08:11:46 -0700 (PDT)
Date: Fri, 7 Aug 2026 10:11:44 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] odb/transaction: add transaction release interface
Message-ID: <anX0NDfcaKGFOTjS@denethor>
References: <20260806213859.816157-1-jltobler@gmail.com>
 <20260806213859.816157-2-jltobler@gmail.com>
 <anWDKwkRp1EK9NRi@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anWDKwkRp1EK9NRi@pks.im>

On 26/08/07 09:03AM, Patrick Steinhardt wrote:
> On Thu, Aug 06, 2026 at 04:38:54PM -0500, Justin Tobler wrote:
> I'm not a 100% sure whether I like "release" as a name, as it typically
> indicates that we release memory and other resources hold on by Git. On
> the other hand we also kind of release state in this case here, but it
> feels like the consequence of that is broader than it usually is.
> 
> How about we call this "finalize" instead?

Ya, that is fair. If we keep freeing the transaction and removing
lockfiles in the same lifecycle phase, "finalize" is probably a better
name. Will update in the next version.

> > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> > index 86933d8d7e..420de9aa7f 100644
> > --- a/builtin/receive-pack.c
> > +++ b/builtin/receive-pack.c
> > @@ -2714,6 +2714,7 @@ int cmd_receive_pack(int argc,
> >  		use_keepalive = KEEPALIVE_ALWAYS;
> >  		execute_commands(commands, unpack_status, &si, transaction,
> >  				 &push_options);
> > +		odb_transaction_release(transaction);
> >  		delete_tempfile(&pack_lockfile);
> >  		sigchain_push(SIGPIPE, SIG_IGN);
> >  		if (report_status_v2)
> 
> I think this here is the only caller that we care about where we release
> the transaction not immediately after committing it. This is because
> `execute_commands()` is the function that's responsible for updating the
> references, and thus we don't want to delete the ".keep" files before
> it.
> 
> It would make sense to single out this caller in the commit message.

That is correct, git-receive-pack(1) is the only ODB transaction user
currently that cares about this. At this point in the series,
`odb_transaction_release()` is not yet cleaning up any lockfiles yet,
but will later on in the series. I'll explain this in the commit
message.

> > diff --git a/odb/transaction.h b/odb/transaction.h
> > index 4cb2eafcbf..ec0b27c449 100644
> > --- a/odb/transaction.h
> > +++ b/odb/transaction.h
> > @@ -75,6 +82,13 @@ static inline void odb_transaction_begin_or_die(struct object_database *odb,
> >   */
> >  int odb_transaction_commit(struct odb_transaction *transaction);
> >  
> > +/*
> > + * Releases an ODB transaction, performing any deferred cleanup and freeing it.
> > + * Must be called for every successfully started transaction. Note that, if the
> > + * specified transaction is NULL, the function is a no-op.
> > + */
> > +void odb_transaction_release(struct odb_transaction *transaction);
> 
> Should this function be able to report errors? Cleaning up ".keep" files
> can fail, and I'm not sure whether we should simply ignore those.

Good point. Will update in the next version.

-Justin
