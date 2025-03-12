Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18C6258A
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 20:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812461; cv=none; b=fH2YCL2MvAEaf3kFbLkMYv5/WPyKRmvRtBxzzhNguXd05NchhnIjDJFX6I3kTkd3m8wCw4/A9hScANx4XBmLxzUwdUKPWVwSeAX9E0vry9PjcUh41qne/DP6P84Q87vg2K1q1OEs35b9pC7Y2qB3nWjL6IMeeIn56dZ9m5DmPBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812461; c=relaxed/simple;
	bh=D4MiNIS8+GRoy8E1rjoPqNSFnwFJPIIDf4oJk2qY2hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFSg332mRk7EyZjnovwfbJfgZqITvebieqjMH1RSMbu3uOvwhuSENQbX46dkTFQzOoXpiW4E3ueT5cvAM7Lmd+S6hIP3bwF95NC07eRB2FOkGn0GUlqHrqTwPt70YGfFg0tsV4rwD5eIgPiXCmQ0THnxzycqHNhwFipB2DHQVew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ckKc0k7S; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ckKc0k7S"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6fd80f30ba5so1761867b3.3
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 13:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741812459; x=1742417259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K2AVa4Sb8gDItBjLn9wVIMULuvPg+AAtZoxVmf0djvM=;
        b=ckKc0k7SmCPDl/4v4s6YvR4G8EROSm7LFke/ad6ziW0j+BbJkdbQ8NuOZnMafSO1hl
         OG7jBh4oSiiy/Ejxu9ocpYUrBBBGqXlcIUVz9icDfCtsViXcVuxbC6d19RS7GnhPyjY1
         u7y9sJLPQHXg70VuJ/ZaOmCxx/nJ0FiMCTgEVLmZC0OkB/5qXyJ43UP70Z72C9vepuIX
         SkVJ4mah1EmBUtG4x9KJjECyuIV753/rh5BIbNMAIxWv4EvZuT6FZ3GQOB1QxgIkqdhl
         Xxycv2TCYOd+WjLVs1vQWGDrY2O+ClxG84MY92RwQHvgo5YB2/eWAt4GFw98+FI2Faoy
         v+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741812459; x=1742417259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2AVa4Sb8gDItBjLn9wVIMULuvPg+AAtZoxVmf0djvM=;
        b=lmvJJaxSNW8kY9KIBnNIEKwrSAAdWePFk2kFblwpZHqU4s/LIF7+A8ul4weJMParOs
         JgaUpsbm4UWEAuLKlUUrF/j7rkuhbDlFZdhlmqh9q56cTx/X7Y6Fc2SPSX/GE1wi6kzM
         P+CEtsNgGdXuLsZW6cJdX4yH1qtDN+v7M7lFQHFw5lSXc2/GY794O2Ys4ZSxoqD5a0E2
         9CEFIlbBZCDQhF9PtuRjYzbeMnPtPkEajld5FtIfBjyLJX+9cIonyFbJHkjmYgFCuN9E
         TzGbUnVwJv+57GbL/6QkPRpkDyHn7QoODb8fPWXzrEjQTUSLItbFCfTAXH0MtG4hKbAy
         oADw==
X-Forwarded-Encrypted: i=1; AJvYcCVHaPwEIPv67Mne65byO5ODUfiUCNytwyLG48X4KG+fVIsseCKaBhxMhTsUZceWlF2u6NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCBWsDKOgosVtcqs78Px4GqX2UAAqHniEt2Ek4OgFBVbO31swh
	XZPtp0LGzbLqfSMXukSBMHzIQx5SbRzruXJ/5qhrHqV9tRxdCMl1SozppkQevcg=
X-Gm-Gg: ASbGncuwHKSCVgGtAYsZF0xslcJgf5qvz20s6tirSsTikwFXn8l6uuJpvCzF58cU5/5
	cUm+uZZfOeePBwl9IhJjQIDjOHHvLRVZCpUT0iODLpanfam7FcCkCBX6sK/6hosVjlviuXYQj7w
	nFqEEBuB4sta3tj+9Cj50+Qvo8PxCDBSvpjuWmVBuHWDkPtEfUIrNxSFm9FcN50TcF0q8/SfzsG
	B8Di55GGi+tkFk1XojqgEPs4dfMf3zFRSldJo48RR0KPEUvHSJF/IUg9D/bHrPXCxFO62Eiu6Vw
	gzfIpolTUtpw+BN48JGnGUbkdpxO93tx4wFqST7uPywp5prhpPtMYoONhCoOi5zzkTZLYt7mifS
	/78Q8caqhX2KjBC1q
X-Google-Smtp-Source: AGHT+IGWgQsJDsAAFcmxpnfWKMkfZFw7czlQqXrl7KWw6sbEdoRRrPpdRjkrt/pDmA36RCEoiPSLAg==
X-Received: by 2002:a05:690c:2c07:b0:6ff:1fac:c502 with SMTP id 00721157ae682-6ff1facf983mr38263717b3.6.1741812458661;
        Wed, 12 Mar 2025 13:47:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fed779da21sm23245037b3.107.2025.03.12.13.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:47:38 -0700 (PDT)
Date: Wed, 12 Mar 2025 16:47:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, christian.couder@gmail.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net,
	ps@pks.im, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 00/13] PATH WALK II: Add --path-walk option to 'git
 pack-objects'
Message-ID: <Z9Hy6Yk2XM1RCsNC@nand.local>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <xmqqwmcw7q2x.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwmcw7q2x.fsf@gitster.g>

On Mon, Mar 10, 2025 at 10:28:22AM -0700, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > ... deltas across path boundaries. This second pass is much faster than a fresh
> > pass since the existing deltas are used as a limit for the size of
> > potentially new deltas, short-circuiting the checks when the delta size
> > exceeds the current-best.
>
> Very nice.
>
> > The microsoft/fluentui is a public Javascript repo that suffers from many of
> > the name hash collisions as internal repositories I've worked with. Here is
> > a comparison of the compressed size and end-to-end time of the repack:
> >
> > Repack Method    Pack Size       Time
> > ---------------------------------------
> > Hash v1             439.4M      87.24s
> > Hash v2             161.7M      21.51s
> > Path Walk           142.5M      28.16s

OK, so microsoft/fluentui benefits from the path-walk approach in the
size of the resulting pack, but at the cost of additional time to
generate it.

> > Less dramatic, but perhaps more standardly structured is the nodejs/node
> > repository, with these stats:
> >
> > Repack Method       Pack Size       Time
> > ------------------------------------------
> > Hash v1                739.9M      71.18s
> > Hash v2                764.6M      67.82s
> > Path Walk              698.0M      75.10s

Same here.

> > Even the Linux kernel repository gains some benefits, even though the number
> > of hash collisions is relatively low due to a preference for short
> > filenames:
> >
> > Repack Method       Pack Size       Time
> > ------------------------------------------
> > Hash v1                  2.5G     554.41s
> > Hash v2                  2.5G     549.62s
> > Path Walk                2.2G     559.00s

OK, so here the savings are a little more substantial, and the
performance hit isn't too bad.

> This third one, v2 not performing much better than v1, is quite
> surprising.

I'm not sure... I think Stolee's "the number of hash collisions is
relatively low due to preference for short filenames" is why v2 behaves
so similarly to v1 here.

> > The drawbacks of the --path-walk feature is that it will be harder to
> > integrate it with bitmap features, specifically delta islands. This is not
> > insurmountable, but would require more work, such as a revision walk to
> > paint objects with reachability information before using that during delta
> > computations.
> >
> > However, there should still be significant benefits to Git clients trying to
> > save space and improve local performance.
>
> Sure.  More experiments and more approaches will eventually give us
> overall improvement.  I am hoping that we will be able to condense
> the result of these different approaches and their combinations into
> easy-to-choose-from canned choices (as opposed to a myriad of little
> knobs the users need to futz with without really understanding what
> they are tweaking).

In the above three examples we see some trade-offs between pack size and
the time it took to generate it. I think it's worth discussing whether
or not the potential benefit of such a trade-off is worth the
significant complexity and code that this feature will introduce. (To be
clear, I don't have a strong opinion here one way or the other, but I do
think that it's at least worth discussing).

I wonder how much of the benefits of path-walk over the hash v2 approach
could be had by simply widening the pack.window during delta selection?

I tried to run a similar experiment as you did above on the
microsoft/fluentui repository and got the following:

    Repack Method       Pack Size       Time
    ------------------------------------------
    Hash v1              447.2MiB      932.41s
    Hash v2              154.1MiB      404.35s
    Hash v2 (window=20)  146.7MiB      472.66s
    Hash v2 (window=50)  138.3MiB      622.13s
    Path Walk            140.8MiB      168.86s

In your experiment above on the same repository, the path walk feature
represents an 11.873% reduction in pack size, but at the cost of a 30.9%
regression in runtime.

When I set pack.window to "50" (over the default value of "10"), I get a
~10.3% reduction in pack size at the cost of a 54% increase in runtime
(relative to just --name-hash-version=2 with the default pack.window
settings).

But when I set the pack.window to "20", the relative values (again
comparing against --name-hash-version=2 with the default pack.window)
are 4.8% reduction in pack size and a 16.9% increase in runtime.

But these numbers are pretty confusing to me, TBH. The reduction in pack
sizes makes sense, and here I see numbers that are on-par with what you
noted above for the same repository. But the runtimes are wildly
different (e.g., hash v1 takes you just 87s while mine takes 932s).

There must be something in our environment that is different. I'm
starting with a bare clone of microsoft/fluentui from GitHub, and made
several 'cp -al' copies of it for the different experiments. In the
penultimate one, I ran:

    $ time git.compile -c pack.window=50 repack --name-hash-version=2 \
        -adF --no-write-bitmap-index

, and similarly for the other experiments with appropriate values for
pack.window, --name-hash-version, and --path-walk, when applicable. All
of this was done on a -O2 build of Git with your patches on top.

So I'm not sure what to make of these results. Clearly on my machine
something is different that makes path-walk much faster than hash v2.
But on your machine it's slower, so I don't know how much I trust the
timing results from either machine.

In any event, it seems like at least in this example we can get
performance that is on-par with path-walk by simply widening the
pack.window when using hash v2. On my machine that seems to cost more
time than it does for you to the point where it's slower than my
path-walk. But I think I need to understand what the differences are
here before we can draw any conclusions on the size or timing.

If the overwhelming majority of cases where the --path-walk feature
presents a significant benefit over hash v2 at various pack.window sizes
(where we could get approximately the same reduction in pack size with
approximately the same end-to-end runtime of 'git repack'), then I feel
we might want to reconsider whether or not the complexity of this feature
is worthwhile.

But if the --path-walk feature either gives us a significant size
benefit that we can't get with hash v2 and a wider pack.window without
paying a significant runtime cost (or vice-versa), then this feature
would indeed be worthwhile.

I also have no idea how representative the above is of your intended
use-case, which seems much more oriented around pushes than from-scratch
repacks, which would also affect our conclusions here.

Thanks,
Taylor
