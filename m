Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC6E571
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 02:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757991319; cv=none; b=h8G0DvEJR0nBmO9iqVCmEhSfc2jcNmBeN6KaMc2uWUQBDXTPPwxGmFu6R730IMaluvfX7xxzr0I87TmRXZqF1GZzh99Y4n7IvWuoOxc1E8jkqMqsGXPijCmrNEuCRfVXNcn69xHe88SsqAE1I5qRpyGOutGCBRCte0gPBTvtUg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757991319; c=relaxed/simple;
	bh=LofrMazJyvgK5N5Mkp4BEz7TEvLdAQDEzRD82XJ+P1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shehDVTZ6gT5INltJjp+WDQEWao7YRCOKtifmhaeIepA3U3Uvxdu8d/tT4kFaEYBiASzQzYAKAOPCeUDAwLW8HYlZf9zAOeWw9D4xySo/CFZcuNmS317gMs4jBoy8H8Odp57ZiQswvEfc0YfPHfp/UQUPUAW6WB0t1fWIs9ohDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJxx9arC; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJxx9arC"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-74a61973bedso4585106a34.0
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 19:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757991317; x=1758596117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PgqOIMvNebDyetlizG6Hn7KGujfCVFY3iBLuL3yYJgU=;
        b=kJxx9arCVFcuHfxzSq2vI2UlRjgEkKHYg96EOogJCQvSTd9bTuW835wWr0Ls89SmhN
         Fd0UpZx9+QoN5CqjTV3Ddhw8ifkMYbNHYhx6ju+vag3mKuA0dewvgvK1rs/m0+IHU9RN
         n9JAS+xtu+2Ca42RnV9zl//jowKh9KXiZ4m7X9Wcc7hJ0xgknxUH7lBY61nuU4xknsTT
         wsC9D1pQxOYZv9wWUJ3zr3VDjI6uiORxzCXuWYmnrdcvxY9WJeWkzXhSy/d9aXUi19kH
         qLj8kV3suciIS/IYPf7kg9EHEevDpZ9RAHIImZxYDZHwZ30j92AedlAOIla/6lfhH9n5
         KJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757991317; x=1758596117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgqOIMvNebDyetlizG6Hn7KGujfCVFY3iBLuL3yYJgU=;
        b=bDS7pV8oeP5LpmzJdD468RpZCPDCwg9Im/Zc6RmrECIfGgzjl/05ZC4QvUaJrC5KRX
         13iQ7lWTqgsX6bRJ5tq6ueiBioIZjFkFcN0DalxhBAXCZxbEicQKqUY7LyCSLLP5EEFH
         /dvwK3rJy6L0L0mGywh2qBeLNXbo56rW0IBF76xsZ70hle1scC7bHIVFYW1Xxqqn/5Kt
         ekoBvHAQfCNB7lYXa4E72sm0mTXGJM4nkwZKDTcxiupwiAxMkKoh0tK8qKOIugqCjDK9
         aTz1qOWqygaWRKgu+MB1kIihy0AoTWi6OVLu4VRs7h1+bWKgQMXt3CMmL2XuRz2aU8jh
         PdOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdGWU/+wn7EH3pQfKVhZTsMUFdzmcgFAdFOkLZMKbNH0IAnR96IgmbTFM1geoy/rsJruw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAY0VDjK1KMgtdCFFgE1J0YDtOAWs8kOqUXFbMcBdNr0IvTPaV
	UBPNG379b/+E0jXXv44750p/QhooRyKbJKPJT3qw4+GCXmOmlXjkOWSCozXEtQ==
X-Gm-Gg: ASbGnct2KqexpfNyE3b2jMq2wIgbNqG5GaLllWWdyExNf4CFKK5EYz7LCVcMfClRwKU
	0WythTer+/cVisca/qJkD0enq5Iamw886xsNMpr/n/SWproMZkqPsvjOoBwzbteKynn54PwA3aT
	S4c3HVnVRHk5AcaB1XOoApOLohuUD3L34e9cGweOe6YTMUKAslyqRxU3jceskTnKh13w3z3E7uo
	f4Ge8+qUkCHbCmLv2XCoYMNLDd066p2Fxd2ElNVxpL0H8FfXYhzLhEl3U1p2izXTgRSezbCNlGa
	Gb7INQ5eLhN5NdxwO7bUDf5DI+4j+cni5BS1pivZ2E3ddlPmR32RS5fEHOkYWC+s7Ge+leUDyL9
	MtbfgHGaYUrjnokyG
X-Google-Smtp-Source: AGHT+IFIss+7tDM2QLLVvjbgUVhNaNIJ/vh2ms2YZMoKYv6VP/QTni3ojSoX/MJjlvjXcj53GM0xtA==
X-Received: by 2002:a05:6808:3447:b0:437:e1b0:e969 with SMTP id 5614622812f47-43b8da3a65fmr7080435b6e.40.1757991316858;
        Mon, 15 Sep 2025 19:55:16 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-43b82a72657sm2675799b6e.15.2025.09.15.19.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 19:55:16 -0700 (PDT)
Date: Mon, 15 Sep 2025 21:55:15 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 1/6] bulk-checkin: remove ODB transaction nesting
Message-ID: <pk2cpihxk4j4ywgq3dtknybyzjeon7ajgmwq4yhknojjsfiqo2@q5dsygszdkar>
References: <20250909191134.555689-1-jltobler@gmail.com>
 <20250909191134.555689-2-jltobler@gmail.com>
 <aMJu4yoO5-Xp52oJ@pks.im>
 <aMijGE2CveYcQaWc@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMijGE2CveYcQaWc@nand.local>

On 25/09/15 07:36PM, Taylor Blau wrote:
> On Thu, Sep 11, 2025 at 08:40:35AM +0200, Patrick Steinhardt wrote:
> > On Tue, Sep 09, 2025 at 02:11:29PM -0500, Justin Tobler wrote:
> > > ODB transactions support being nested. Only the outermost
> > > {begin,end}_odb_transaction() start and finish a transaction. This is
> > > done so that certain object write codepaths that occur internally can be
> > > optimized via ODB transactions without having to worry if a transaction
> > > has already been started or not. This can make the interface a bit
> > > awkward to use, as calling {begin,end}_odb_transaction() does not
> > > guarantee that a transaction is actually started or ended.
> > >
> > > Instead, be more explicit and require callers who use ODB transactions
> > > internally to ensure there is not already a pending transaction before
> > > beginning or ending a transaction.
> >
> > I think one bit missing in the commit message is to explain what this
> > buys us. Does it for example enable subsequent changes? Or is this
> > really only done to have clean ownership semantics for the transaction?
> 
> In addition, it would be useful to hear from the commit message *why*
> this is safe to do. Justin's message suggests that nested transactions
> are noops, so doing something like:
> 
>   begin_odb_transaction();
>     begin_odb_transaction();
>       write_object();
>     end_odb_transaction(); <- object not yet added to the main ODB
>   end_odb_transaction();   <- now it is
> 
> only results in the object being added to the main ODB when the final
> end_odb_transaction() is called.

Yes, well said. {begin,end}_odbtransaction() operations on inner
transactions are effectively a noop. They simple manage an internal
counter to know when a new transaction should be started/finished.

> Instead it looks like this patch pushes us towards having callers check
> whether or not there is a transaction in progress before starting a new
> one. So it seems like this is safe to do only for callers that check
> whether or not there is an ongoing transaction before beginning a new
> one.

Yes, this patch removes the logic that manages the internal nested
transaction counter in favor of requiring callers to check if a
transaction has already been started or not.

> (I think this is what the second paragraph of the quoted part is trying
> to say, but I think it may be clearer to say "To preserve the same
> semantics, callers MUST ensure there is not [...]").

Yes, you are correct. Apologies for the poor wording.

> That's more work for callers, and at first blush feels a little more
> error-prone.
>
> Specifically, if some new piece of code is written that does not first
> check whether there is an ongoing transaction, it could result in a
> BUG() either at the time it is written, or worse, later on when that
> function is called in the context of an outer transaction.
> 
> So I am not sure whether this patch is making things simpler or safer.
> Certainly the bulk-checkin API is a little simpler, since we no longer
> have to keep track of the nesting level within an odb_transaction. But I
> think it pushes more burden onto the callers in a way that I worry could
> create the potential for BUG()s later on.

I've revisted this patch and I agree there is probably a better/safer
way to accoplish this.

The ultimate goal of this patch is make it so invoking
end_odb_transaction() on a transaction guarantees it is flushed. With
this guarantee we would no longer need flush_odb_transaction() and the
transaction interface eventually can be simplified to just
{begin,end}_odb_transaction(). This also avoids a potential class of
errors where a caller _thinks_ they have committed a transaction and
that the objects should be visible, but they actually are not because it
was a nested transaction.

The nice thing about the current implementation though is that nested
transactions are automatically treated as noops and the caller doesn't
have to check if there is already a pending transaction. This is safer
and less error-prone.

Thinking about this some more though, we should be able to continue to
have {begin,end}_odb_transaction() function as noops when there is
already a pending transaction and also be able to drop the internal
transaction nesting mechanism at the same time. To do this, instead of
erroring out in begin_odb_transaction() when there is already a
transaction, we can simply return NULL. If a caller wants to know if a
new transaction was actually started, they can just check the return
value afterwords. This removes the burden from the caller to explicitly
check if there is a pending transaction beforehand. Furthermore, since
an ODB only allows a single transaction at a time, it probably makes
sense for operations at the ODB layer to guard against this anyway.

This change would pair nicely with the change made to
end_odb_transaction() in version 2 of this series. In this version, when
end_odb_transaction() is provided a NULL transaction, it now functions
as a noop as well. If a transaction _is_ provided though, it is
guaranteed to be flushed with addresses the main goal on this patch.

> I think that takes us back to Patrick's question: what do we gain by
> simplifying the internals of the bulk-checkin API, and how does (or
> doesn't) that justify the added burden on callers? Looking at the newer
> version of this patch in [1], I see that you addressed what we gain, but
> I am still curious about how we justify the added cost.

Thanks Taylor for the thoughtful feedback. Much appreciated. :)

I'll plan on sending a followup version tomorrow that hopefully
addresses most of these concerns.

-Justin
