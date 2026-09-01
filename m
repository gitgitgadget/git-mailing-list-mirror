Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30F3372ED0
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252697; cv=none; b=QxSfh4isxnGt/DCTilgc1IlYQBNEOi9y9rOHcMpet060ozcFvXdH4eJi7CqBnN9M1y2wW8I/fUKeqCcmIZ9qxCmbEymKO6f7dA6QkMB75np+dlpCo46GfRvJ8h3Xv1DI04Ld5ffLNTfRr8dUFBamyq+kNs58e41RlktuO5yA69A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252697; c=relaxed/simple;
	bh=YVoDuACe51Ds+mwxv1oT+U1mksh4lQvKs6EVFLUOLhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTEj37V7a+fAlMb+9HDFkBVHWqsk4JEjLUTwNGdhjYoU0VTlcnSrb6pNIAWw4pbcgrrxYceQgWZ+F44fMkQsOtix5rt63vNayMvUw5fMAq9Spn+BYsxyGJcYkIhR3xb2swUPjKs6XgGeb/QjiCgU3CZ8Kb9HjXkXBrSw74TyHj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BKKHBPUP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cspjqVkB; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BKKHBPUP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cspjqVkB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CC9F1EC00D2;
	Tue,  1 Sep 2026 04:51:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 01 Sep 2026 04:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788252694; x=1788339094; bh=/YU6wtqce5
	ayw+d0Vj7qOh59Rf/5GCrREon8gKy86Ig=; b=BKKHBPUP9iVzqmdHbCgjhtjNn3
	iLWCkRbv9Q/4UJgddQiQVg8ULp6wPt1mBU8U6KyT/oUJXXigxSNW2nK3MUYjQ54q
	WEDqT3YgZfYa3Slcjmytx0xSj5fTRFPqqIV5Oo6Vm0tBkpH3ZTCaHHBYNbvXjF7G
	TW0r2bCFbbdQLeibqT4QffFdMDGbjQplOjPOHAidMnl3dAx4knNc6GnrhUilOBPm
	wcGfl14nHVzXtG7gU2MO1caDxO9FAGDqQRGk19HINVTqGYyWlTvcGzE5Roi0U8nd
	rk2+6o9icopNa21TLJhir8dnNIdFHOfngowdM+2D/XHdERy7I5u7ZKewbyNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788252694; x=1788339094; bh=/YU6wtqce5ayw+d0Vj7qOh59Rf/5GCrREon
	8gKy86Ig=; b=cspjqVkBFI5XRRaoo5P1okTm4B3zFOYlZ5Htbf460D8PVM7XC5+
	GB9748lYWwoPRSzNixeNWm+kEd9I0pMbu9hRN00SmrceGlKzpUzqB2SYlRZfUBhj
	xiQEnrGBWIy/eD1jP1rvW0g9xoiaFUNTzCGjenXxtBJD+PghMWOjyjAAzu4HBGTR
	zLso6LcG/rUMib7CSf8h7FLFawajCVnHslql6k9wOyPsxgKtQLiBlz8dL6Zoja7J
	dNieR7VHnom3rxFGV5/y18Y6jUcs3x0Tk1XM+Nk2ucbrd5+E+fg7nkGgXw/yxMek
	Kjg2BlXGFXSu44AyPsRrdAm1wU/WXy0lpag==
X-ME-Sender: <xms:FpKWauAdXEWJC5VxGexjk02MmucKZ1FdbfjWKE602R79WgsX4vOUrw>
    <xme:FpKWarwADkqpJ5AyiHkPNqrg_lLPA3dQXjF5N-D-9Fk5wyg1aUVqIqkhyqpgqtVQt
    q_AsljwP01pOk9kQ83-KLhPrppJ2AWdCbllNJDSf60YWaWOls6Vgg>
X-ME-Received: <xmr:FpKWarC7ubpDa7_VdfmELv7V4j51zKkcBLPBRKpSLQPPup0fPiwu6A>
X-ME-Proxy-Cause: dmFkZTEmV5+JWGQf5qahhWVEHXFOW/AewsYwyqy0z9bzFwKSswbdW15wjkdpbScARm6i06
    NPAHAfX/fx2YyOokArlSZCOQhQVmU5VToUSc9TBoxNpXeM9SdC5uuiVXBM50boiafVSzhI
    aYJj6NNVOiq0L2G/FcMvSnn2SRh/zO5QqGf1d58tXZyu7Rk/OTTkLmIHYoJsx+IOf6BYv7
    GbkJp+Va9CJ4vqzvp8MhsDoG8x6YbFVVVjfBhHP16kSQMUQHEnl+fCf6yuGqDH2FtW69bG
    zC1EPsRWlkt91djl0Pa0SbttX8Z3lj/Wk7vzBvI9Ihr1fu4aei7aFUYxTKDskYoXfcFAOm
    O3aWOt4Rt1sg9pqDJRLibZBJLfsqXi/DDtKqm12ETJFkitMXi87b2/VylnZpX4keq1kPnQ
    /IoyEBoNWhgjJe7OWpgJeCCkmQtmhqdmnuLZ7gc83goLs7yGli2GsrQEpRz8yZigRmboJZ
    paipoV+ybWm0pZBtPEnCpBupEY1gLfOxi4K9ZljvHkbGkw/8DcEed9zHp/FW64EpluXb5e
    xZ6nLEanC8ZkvjhO04MoT1BZ5bqriy9AZYB+fzPWhLkGAFNz/5fXJ8YLfaU+h5IOdOQme6
    6pCTOQgrwbThOywKoetyIducDYS7fgWvqIfeZPQbUhD6dxY9aAIUNBfXfQYw
X-ME-Proxy: <xmx:FpKWaoaFVnDY_Ms_rq7uoEQ5_N2GjeMkq8SJAF2oZr77dgeYT6OCLQ>
    <xmx:FpKWaji_5ubtnYeqlT55VT36MNW6O697Xi1O7YeD083-TGScbD3t8Q>
    <xmx:FpKWaq7EfuWR6_m61IWQXhenecr6f1skaCPJFrCmPUdfl-WYUGdwfw>
    <xmx:FpKWaq7SRDMUL65udR07DYd2uGhB_GQD8GtoqPpkfjeMPx-D12p-Ug>
    <xmx:FpKWavZRFZwXV1q1TYi3T-zKHjKZmhbalruP8kn8WAAl7CbwuJAQkXBd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 04:51:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 17eb2e6c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Sep 2026 08:51:41 +0000 (UTC)
Date: Tue, 1 Sep 2026 10:51:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Nicolas Le Cam <niko.lecam@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] revision: hang on to "freed" argv elements
Message-ID: <apaSDqIEyc82Q_zE@pks.im>
References: <20260830215555.2660035-1-niko.lecam@gmail.com>
 <20260901062815.GC1075462@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901062815.GC1075462@coredump.intra.peff.net>

On Tue, Sep 01, 2026 at 02:28:15AM -0400, Jeff King wrote:
> On Sun, Aug 30, 2026 at 11:55:55PM +0200, Nicolas Le Cam wrote:
> 
> > The prefixes are replaced by fragments of unrelated heap data, and the
> > value changes between runs of the same command:
> > 
> >     $ git stash show --src-prefix=a/ --dst-prefix=b/ | head -1
> >     diff --git Uf.txt Uf.txt
> >     $ git stash show --src-prefix=a/ --dst-prefix=b/ | head -1
> >     diff --git Vf.txt Vf.txt
> > 
> > On other versions the garbage is recognisable as pieces of other
> > strings live in the process -- "ributes" (from "attributes"),
> > "bjectmode" (from "objectmode"), "4c/" -- which is what suggests a
> > use-after-free rather than an off-by-one.
> 
> Thanks for a clear and thorough bug report! The cause is indeed the
> related to the commits you found. The explanation (and fix) are below.
> 
> -- >8 --
> Subject: revision: hang on to "freed" argv elements
> 
> In setup_revisions() we rewrite the incoming argv array, losing
> references to the strings it contains. For a synthetic argv array
> constructed from heap strings, that traditionally meant we leaked those
> allocated strings.
> 
> We fixed the leak in cd43948798 (revision: manage memory ownership of
> argv in setup_revisions(), 2025-09-19). Now callers can tell the
> revision code that argv entries are allocated and should be freed, which
> it will do before overwriting them.
> 
> But this introduced a new bug! The overwritten entries go away as soon
> as option parsing is finished, but a few options may actually create new
> references to those strings. And once we free the strings, those stale
> references become use-after-free bugs. For example, running:
> 
>   git stash show --src-prefix=foo/
> 
> demonstrates the problem:
> 
>   1. The stash command generates its own synthetic argv (because it has
>      to treat the stash specifiers specially) which it then passes to
>      setup_revisions().
> 
>   2. Parsing will create a reference to the partial string "foo/" in
>      revs.diffopt.a_prefix.
> 
>   3. When setup_revisions() finishes, we rewrite argv to throw away
>      parsed strings. This frees the entry holding "--src-prefix=foo",
>      at which point we have a dangling reference in revs.diffopt.
> 
>   4. We generate an actual diff, accessing garbage memory via
>      revs.diffopt.a_prefix. The output is usually garbled, but ASan also
>      detects this reliably.
> 
> One obvious fix here is to allocate new strings when we pull data out of
> the argv array. But doing so is error prone (every string option must
> remember to do it or risk a subtle bug), and creates more questions
> about memory ownership (e.g., some callers assign string literals
> directly to a_prefix, and we would not want to free those).
> 
> Instead we can fix this centrally by delaying the free() calls. We'll
> collect any "freed" strings in a new array, hold on to it for the life
> of the rev_info struct, and then release it at the end. We can easily
> use a strvec for this, since it handles growth and cleanup for us.
> 
> This fixes the prefix case above (which is now tested in t3903), and
> should fix any other stray cases. Though I could not find any; we use
> OPT_STRING only in the prefix diff options, and very few revision opts
> store strings. Those that do (like --format and --encoding) already make
> a copy of the string. They do not need for us to hold on to the memory
> longer, but it does not hurt them if we do.

So the fix could've been as trivial as you mention above, where we
simply perform a copy of the string for "--src-prefix", and everything
else works just fine?

In any case though, your approach is more defensive and makes it way
harder for such use-after-free bugs to be introduced going forward, so
I'm in line with the proposed patch.

> diff --git a/revision.c b/revision.c
> index 50dc8b1991..7aee96bd8e 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2307,9 +2307,27 @@ static timestamp_t parse_age(const char *arg)
>  	return num;
>  }
>  
> +/*
> + * When asked to free argv strings, we should not do so immediately. Some
> + * option parsing may have stored a reference to the string (either the whole
> + * thing, or a substring inside it). We should keep it valid until the rev_info
> + * struct itself is freed.
> + *
> + * Note that we take a const str for the convenience of callers (who have the
> + * usual const argv array, even when opt->free_removed_argv_elements is set).
> + * We cast away the const on their behalf.
> + */
> +static void mark_argv_for_free(struct rev_info *revs, const char *str)
> +{
> +	if (!str)
> +		return;
> +	strvec_push_nodup(&revs->argv_to_free, (char *)str);
> +}

Hm. Doesn't this mean that we take ownership of the string and then
eventually try to release it when releasing the vector? I wonder whether
this could introduce subtle lifetime issues where the caller passes a
non-heap-allocated string.

I don't think it's that bad when seeing where we use these. But I feel
like hiding this fact by marking the parameter as `const` is a bit of a
weird design choice. I'd much rather prefer we force this onto the
callers so that they are aware of this, but I haven't seen the end
result of that. So maybe it's just too ugly.

Thanks!

Patrick
