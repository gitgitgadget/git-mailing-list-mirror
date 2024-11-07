Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A08518D64B
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 21:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731015042; cv=none; b=U2c7Ctv3Ko5tB4Kg/X02KIuL5tq+UCcQakaB8y1ilzGQ780AwYjBMXmzPbtH11S1ZiUsc0JtJmg9mx3Sj5ZQ0GolGJ+RphBuDoEiUv/5+HpS/sHSeMenr9nJigyuWpD9xi5U503Hv2QL1zUuBtyrA71e4ORdo4otQzmUgqOodjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731015042; c=relaxed/simple;
	bh=z1LaV8NkawZsdbifxdgJVDLoXlZVJ+emctFNHORmJag=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZLSgKuLOF1/B6vKramf/yFhuZT2eDits4RRXB3rvvb76UH0SL5ixmte/R8Qrkd+NdjqMSEa+Fsn7OLe4IOaJWsBcItzJTluB4MPpgxhG3GHwKjfwT3Tcs5ebMtzOmBBtuXAJFgyb/QCbTiQwLrXodBFleJKsYRFi/RWWT/iKvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=x7ohWZxu; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="x7ohWZxu"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso1945798276.1
        for <git@vger.kernel.org>; Thu, 07 Nov 2024 13:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1731015039; x=1731619839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZbT1CBvYqx9A291MZE4duhHXGeSggTcu5gObcOymDU=;
        b=x7ohWZxuMIalS0tVctTSV25A9D23uSZrYlwLV/WA7iLYZcPeNq2nALJUl+35SeCEWh
         GXmONSKtFHg7LnDfTxCf4cVzro2nChfNiPaOwgustrt/ZqqBO2H7k0mmIGlqmKYZh4/O
         CGObsnWt1k4h7dpLCA71VjfPvtOHQjA5sYvsSYi6C+NCy6xyDDOWc6VSPsdOmoV0CJX+
         UxtTarCGcHqyBLIU09XxPpnJ7MMkR/8K1ZwPcAAa6DZYtlYbGNPz9XtUCfxbNSx+d776
         CC6o3Wm+gQw0kB9OkSRUbrwJhz+ikONMIJJyecr0g/Y4Hds6yB//pQ5zojTAUIPo1wma
         0pLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731015039; x=1731619839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZbT1CBvYqx9A291MZE4duhHXGeSggTcu5gObcOymDU=;
        b=S8fQa68Sk7TwRrB/AHISnszvaxu8Q7IHwTfrQYDfOdudF04TiitnT1u/c5DIy+1YLw
         2HUOSXw19Hi7pXNuJD/hW8eaRug3ZvNPbOTLIGqs1Dn74uH6K8PY2NDmH+BxaaDNaciX
         +3X362bb5jqNecWrT00oMYUd2zSYn0zd6cCp9EANcpD8uMfzG/YM5cXmdNDWgEQBON0Q
         kFLO3QSW70k4LISj7lBCCscDrzJLAixRo99htSsU+XU4iolmutpK8r3cq/K6eU7QttK6
         LMhcg17ydBfDiQhQQdcPCGKURet7zwcp8g1ihoQ0ZsBeWaa605KvDW/ComUDaik/Rzwp
         EHQA==
X-Forwarded-Encrypted: i=1; AJvYcCXVn099rd2LJDSqSmIQvJ5LCfppdJNfWNWP67+F+SeCT0M7PaEz46TNeyBH+gDI3XR7bVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUHiQ8T1c8sB4FkS2xaf74YoUAW7r814FP+8ZGROFYx9Nh0klI
	hXCEblitGMCtcCig9JbIKB6Y9sCltLVPXMZJyk2W2sboD+EDe9qiZ8qjZ4vK4aZ4/Brx+q4VONb
	FUcI=
X-Google-Smtp-Source: AGHT+IGZAYwkLUApK0nb2/q/ITr3ruFeL0Rp3EpVSpPGazMcUSxeZ5Pd36JrSYu5CESQQexZJAHnkg==
X-Received: by 2002:a05:6902:1791:b0:e33:67d8:654e with SMTP id 3f1490d57ef6-e337f8ffe43mr625023276.49.1731015039122;
        Thu, 07 Nov 2024 13:30:39 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336ee15319sm434226276.7.2024.11.07.13.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 13:30:38 -0800 (PST)
Date: Thu, 7 Nov 2024 16:30:37 -0500
From: Taylor Blau <me@ttaylorr.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/2] t/helper/test-sha1: prepare for an unsafe mode
Message-ID: <Zy0xfVqtOXhEVDQB@nand.local>
References: <cover.1730833506.git.me@ttaylorr.com>
 <0e2fcee6894b7b16136ff09a69f199bea9f8c882.1730833507.git.me@ttaylorr.com>
 <xmqqcyj9qgyf.fsf@gitster.g>
 <ZywOWn08cGBnBWM-@tapette.crustytoothpaste.net>
 <20241107013915.GA961214@coredump.intra.peff.net>
 <Zywcr2lMM_Ij8suu@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zywcr2lMM_Ij8suu@tapette.crustytoothpaste.net>

On Thu, Nov 07, 2024 at 01:49:35AM +0000, brian m. carlson wrote:
> On 2024-11-07 at 01:39:15, Jeff King wrote:
> > So I think you wouldn't want to allocate an enum or a slot in the
> > hash_algos array, because it is not really an independent algorithm.
> > But I think it _could_ work as a separate struct that the caller derives
> > from the main hash algorithm. For example, imagine that the
> > git_hash_algo struct didn't have unsafe_init_fn, etc, but instead had:
> >
> >   struct git_hash_algo *unsafe_implementation;
> >
> > with a matching accessor like:
> >
> >   struct git_hash_algo *unsafe_hash_algo(struct git_hash_algo *algo)
> >   {
> > 	/* if we have a faster "unsafe" implementation, use that */
> > 	if (algo->unsafe_implementation)
> > 		return algo->unsafe_implementation;
> > 	/* otherwise just use the default one */
> > 	return algo;
> >   }
> >
> > And then csum-file.c, rather than calling:
> >
> >   the_hash_algo->unsafe_init_fn(...);
> >   ...
> >   the_hash_algo->unsafe_final_fn(...);
> >
> > would do this:
> >
> >   struct git_hash_algo *algo = unsafe_hash_algo(the_hash_algo);
> >   algo->init_fn(...);
> >   ...
> >   algo->final_fn(...);
> >
> > And likewise this test helper would have a single conditional at the
> > start:
> >
> >   if (unsafe)
> > 	algo = unsafe_hash_algo(algo);
> >
> > and the rest of the code would just use that.
>
> Ah, yes, I think that approach would be simpler and nicer to work with
> than a separate entry in the `hash_algos` array.  We do, however, have
> some places that assume that a `struct git_hash_algo *` points into the
> `hash_algos` array (notably `hash_algo_by_ptr`), so we'd have to adjust
> for that, move the function pointers out into their own struct which
> we'd use for `unsafe_hash_algo`, or be careful never to call the
> relevant functions on our special `git_hash_algo` struct.

I agree that the approach suggested by Peff here is clean and would
button up the test-helper code nicely. It may be worth doing in the
future, but I agree that it doesn't seem entirely in scope here.

Part of the reason that I did not initially add a separate sha1-unsafe
struct is that while it avoids this awkwardness, it creates new
awkwardness when in a non-SHA-1 repository, where you have to keep
track of whether you want to use the_unsafe_hash_algo or the SHA-256
hash algo.

In that instance, it's not a matter of computing the same result two
different ways, but rather using the wrong hash function entirely. IOW,
the hashfile API would have to realize that when in SHA-256 mode, that
it should *not* use the separate (hypothetical) unsafe SHA-1 struct.

> > All that said, I do not think it buys us anything for "real" code. There
> > the decision between safe/unsafe is in the context of how we are using
> > it, and not based on some conditional. So while the code in this test
> > helper is ugly, I don't think we'd ever write anything like that for
> > real. So it may not be worth the effort to refactor into a more virtual
> > object-oriented way.
>
> Yeah, I don't have a strong opinion one way or the other.  I think, with
> the limitation I mentioned above, it would probably require a decent
> amount of refactoring if we took a different approach, and I'm fine with
> going with Taylor's current approach unless he wants to do that
> refactoring (in which case, great).

I think it does buy you something for real code, which is that you don't
have to remember to consistently call the unsafe_ variants of all of the
various function pointers.

For instance, if you do

    the_hash_algo->unsafe_init_fn(...);

early on, and then later on by mistake write:

    the_hash_algo->update_fn(...);

Then your code is broken and will (as brian said) either in the best
case produce wrong results, or likely segfault.

So in that sense it is worth doing as it avoids the caller from having
to keep track of what "mode" they are using the_hash_algo in. But let's
take it up later, I think.

Thanks,
Taylor
