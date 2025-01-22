Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE6084A3E
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737585432; cv=none; b=stGCA5J2r8cRUJzHvd7yj5FZ4OtuBlf9HtZIxc9iTrOXIU5ho6PzHy1szKpa8JablTYdbRvzFC2cmogK865Fnixrc/HQWiJgwG9P27d7aN49x5/oGXQGO11RqCIDx8zDehb8g+mzyXoK3p+ObwLC74bPxXEBxQQMTCkf+yulaUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737585432; c=relaxed/simple;
	bh=aGITzI4u7YIPIdKJZxKbx2RKiPyJyZ9xbi27do9fI8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHXwofcvRpfpD/gNdIdI2SSLPtaT7nTHqIHNFOUc4FGCYD4rPZsEx+kAy7MGRjAt5QgpETO7ltpkObQKUwxoDrH/Aaqo7SrBTe4CcmK/7IvCZ43gre+qGcYZSy8YYnXIWMgahiV6fVct5H6U//rQLhMfLZueLJZ5xAdDxKTxSXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=3ETX6cDQ; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="3ETX6cDQ"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e53537d8feeso442457276.0
        for <git@vger.kernel.org>; Wed, 22 Jan 2025 14:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737585429; x=1738190229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XT/Bj6dZ3LLNRrEA6rPy3WFjX/ogalKCG/mtoC9t00g=;
        b=3ETX6cDQDcjd51mVsUMFdo+ID3ChBxF5AmK0oJaHTLrKA0kVr67oN6VDyCQ/x5CmSB
         ZPqkDNtvgTVlJA6fkf2hT4fsnKlkilQTIvsj1LQboLbvG4oBo2XNlupDfDG+3TXI2utd
         dP4fmuaGRpIpsIM9ONg2Xtaw5diKqoApl5wk0pHNESwn+5juUF7CtSirQgkyhEl7rtxy
         1khzodk7tUlDwiZd60tiMYDlea+jsZ+g02pHdw04z4gJHlOLHxM8k9gBAf69pY76WZQz
         ifrA5Zw3NU7AaSUD2Dl+SC7nNliJ01q0ETVdWLjk8KZkOmlIKdAK6GTLHo3Z13sMBH2X
         5y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737585429; x=1738190229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XT/Bj6dZ3LLNRrEA6rPy3WFjX/ogalKCG/mtoC9t00g=;
        b=dFK/AO/mZ2a3fuBVehSvA1X3/KqptZSnOcW2JReiEZ8sQmgu7X9VYcK4QcgxmIH8I4
         D7p3371KeSzfylVKJ9IDDXaaVwmFomDsvmZzND9N8tQBTA0CE1ul002n0M+0MZKs2jwM
         e7mKMAI37MsaAGgrcJ2W9F73SbpThoeATFmybcovwEje8n0BXovsjZoEy1LRm8LRRTiN
         E06RAGHl+FPrSTyJtVTz79zh0Dx85maal/HQih8K4EOMk10zee22Jlomch0hrmTqFQdO
         vF00id7LZU4ZmApAToCPjRTLt/M193VxISpHureKoUkwc8EGlafRj/WIskj2opZFMopT
         pmww==
X-Gm-Message-State: AOJu0YxPuKjcXUQ3f1zMZ3ruUOynC6EENA/lLZDkT+1SxNBJ1Yb8bSw4
	51iiljp88wKyn50CQIaSWhkYq4/BLm6p5bFs9AZ2vbaF0OOVBM8ZFezcsxSldXk=
X-Gm-Gg: ASbGncsft/sNV2lZMuiOznwio4Ruoz9fTdtDpOVcwuoy8Ucsra1eyBq3wGMAY4ckDhm
	+213oCPhWb6jCj2oJCk6nntXTd89XjJG+3W8+92/KelGJQl95dS1hAUMTQLOeI2fUEg+ipt5Uoo
	qkoeBYWuo68yzXXEtxhbK5THiLWNvPu8nPzd7mQ2Nxe6cnl0uc8yi+1oysvCxEm/Cd3Rj4h2Xes
	7WDUR6p8bqY06QboZiQlMuP9r7qxnolSQ3qyJytQdvJ7FAk3BXE0m+jn8x5OH0JbbdVxek7g1ru
	yGvIsssnKU4FemfVzNdZ7rmo3ALUaPp2eFpaRawcKQ==
X-Google-Smtp-Source: AGHT+IGqmiUt2i/BuTY+x3/iBvI4PSejV0uUJinXleCf1TEEJn24M5ElQOsxmxuOrPlgyOMil0Z3Wg==
X-Received: by 2002:a25:d314:0:b0:e58:835:a7b0 with SMTP id 3f1490d57ef6-e580835a8f7mr5414618276.37.1737585429490;
        Wed, 22 Jan 2025 14:37:09 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e57ab2e7dc4sm2319166276.21.2025.01.22.14.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 14:37:09 -0800 (PST)
Date: Wed, 22 Jan 2025 17:37:07 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	jonathantanmy@google.com, karthik nayak <karthik.188@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 8/8] pack-objects: add third name hash version
Message-ID: <Z5FzE1XpBlEyhK2T@nand.local>
References: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
 <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
 <3d63954f318e5133630b1f579a399a123e434cf8.1734715194.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d63954f318e5133630b1f579a399a123e434cf8.1734715194.git.gitgitgadget@gmail.com>

On Fri, Dec 20, 2024 at 05:19:54PM +0000, Derrick Stolee via GitGitGadget wrote:
> Create a third name hash function and extend the '--name-hash-version'
> option in 'git pack-objects' and 'git repack' to understand it. This
> hash version abandons all efforts for locality and focuses on creating a
> somewhat uniformly-distributed hash function to minimize collisions.
>
> We can observe the effect of this collision avoidance in a large
> internal monorepo that suffered from collisions in the previous
> versions. The updates to p5314-name-hash.sh show these results:
>
> Test                               this tree
> --------------------------------------------------
> 5314.1: paths at head                       227.3K
> 5314.2: distinct hash value: v1              72.3K
> 5314.3: maximum multiplicity: v1             14.4K
> 5314.4: distinct hash value: v2             166.5K
> 5314.5: maximum multiplicity: v2               138
> 5314.6: distinct hash value: v3             227.3K
> 5314.7: maximum multiplicity: v3                 2
>
> These results demonstrate that of the 227,000+ paths, nearly all of them
> find distinct hash values. The maximum multiplicity is 2, improved from
> 138 in the v2 hash function. The v2 hash function also had only 166K
> distinct values, so it had a wide spread of collisions.

I had a little trouble reading this section of the commit message. I
think the framing makes sense (v2 has collisions which can impact pack
generation time and/or size), but this section explains v3 I think one
level too deep.

This comparison (and the one below it for v3) shows a reduction in
distinct hash values and the maximum multiplicity (I'm assuming for
colliding hash values, in which case I might suggest renaming it as
"maximum collisions").

But I imagine that many readers will primarily care about the effect of
the new hash function on pack generation time and size. You show that
below, but I think that it should potentially appear earlier in the
commit message.

Alternatively, you could consider leaving the time/size table alone
where it is, and devote an extra sentence or two to explaining the
impact on repacking time/size that the two metrics above (distinct hash
values, multiplicity/collisions) have on the repacking time/size.

> A more modest improvement is available in the open source fluentui repo
> [1] with these results:
>
> Test                               this tree
> --------------------------------------------------
> 5314.1: paths at head                        19.5K
> 5314.2: distinct hash value: v1               8.2K
> 5314.3: maximum multiplicity: v1               279
> 5314.4: distinct hash value: v2              17.8K
> 5314.5: maximum multiplicity: v2                44
> 5314.6: distinct hash value: v3              19.5K
> 5314.7: maximum multiplicity: v3                 1
>
> [1] https://github.com/microsoft/fluentui
>
> However, it is important to demonstrate the effectiveness of this
> function in the context of compressing a repository. We can use
> p5313-pack-objects.sh to measure these changes. I will use a simplified
> table summarizing the output of that performance test.
>
>  | Test      | V1 Time | V2 Time | V3 Time | V1 Size | V2 Size | V3 Size |
>  |-----------|---------|---------|---------|---------|---------|---------|
>  | Thin Pack |  0.37 s |  0.12 s |  0.07 s |   1.2 M |  22.0 K |  20.4 K |
>  | Big Pack  |  2.04 s |  2.80 s |  1.40 s |  20.4 M |  25.9 M |  19.2 M |
>  | Shallow   |  1.41 s |  1.77 s |  1.27 s |  34.4 M |  33.7 M |  34.8 M |
>  | Repack    | 95.70 s | 33.68 s | 20.88 s | 439.3 M | 160.5 M | 169.1 M |

OK, now we get to the chart that I demonstrates the effects of each hash
function on the most externally visible effects. Are these measurements
taken from the fluentui repo, or somewhere else? In either case, it
may be worth mentioning.

> Here, there are some performance improvements on a time basis, and the
> thin and big packs are somewhat smaller in v3. The shallow and repacked
> packs are somewhat bigger, though, compared to v2.
>
> Two repositories that have very few collisions in the v1 name hash are
> the Git and Linux repositories. Here are their stats for p5313:
>
> Git:
>
>  | Test      | V1 Time | V2 Time | V3 Time | V1 Size | V2 Size | V3 Size |
>  |-----------|---------|---------|---------|---------|---------|---------|
>  | Thin Pack |  0.02 s |  0.02 s |  0.02 s |   1.1 K |   1.1 K |  15.3 K |
>  | Big Pack  |  1.69 s |  1.95 s |  1.67 s |  13.5 M |  14.5 M |  14.9 M |
>  | Shallow   |  1.26 s |  1.29 s |  1.16 s |  12.0 M |  12.2 M |  12.5 M |
>  | Repack    | 29.51 s | 29.01 s | 29.08 s | 237.7 M | 238.2 M | 237.7 M |
>
> Linux:
>
>  | Test      | V1 Time  | V2 Time  | V3 Time  | V1 Size | V2 Size | V3 Size |
>  |-----------|----------|----------|----------|---------|---------|---------|
>  | Thin Pack |   0.17 s |   0.07 s |   0.07 s |   4.6 K |   4.6 K |   6.8 K |
>  | Big Pack  |  17.88 s |  12.35 s |  12.14 s | 201.1 M | 149.1 M | 160.4 M |
>  | Shallow   |  11.05 s |  22.94 s |  22.16 s | 269.2 M | 273.8 M | 271.8 M |
>  | Repack    | 727.39 s | 566.95 s | 539.33 s |   2.5 G |   2.5 G |   2.6 G |
>
> These repositories make good use of the cross-path deltas that come
> about from the v1 name hash function, so they already had mixed results
> with the v2 function. The v3 function is generally worse for these
> repositories.

I appreciate you sharing some counterexamples as well.

> While the fluentui repo had an increase in size using the v3 name hash,
> the others had modest improvements over the v2 name hash. But those
> modest improvements are dwarfed by the difference from v1 to v2, so it
> is unlikely that the regression seen in the other scenarios (packfiles
> that are not from full repacks) will be worth using v3 over v2. That is,
> unless there are enough collisions even with v2 that the full repack
> scenario has larger improvements than these.

This is the paragraph that I thought most about (both while reading the
above sections, and then again after seeing my internal thoughts written
down here).

It seems like the general conclusion is that v2 is a strict improvement
on v1 in almost all cases. v3 appears to be an improvement on v2 in some
cases, and a regression (as you note) in others. But I think more
importantly (again as you note) is that the improvement from v1 to v2 is
so pronounced that it's unlikely that the regression from v2 to v3 will
matter or even be noticeable in most cases.

Are there easy ways to detect when v3 would be an improvement over v2?
If so, then I think exposing those detection mechanisms to users (either
as an automated tool or through documentation, perhaps in
git-packing(7), which is perfect for this sort of discussion) would be
worthwhile. Then users could make an informed decision about which hash
function to use for their repositories.

But if there isn't such a mechanism, then I wonder what would drive a
user to choose v3 over v2. I suspect the answer is that curious users
would try repacking both ways, and then stick with whichever one has a
bigger impact on the metric(s) they care most about.

If that's the case, I suspect that v2 will be the dominant choice,
especially if we consider changing the default from 1 to 2 at some point
in the future. Given all of that, I share your feeling that it may be
worth dropping this patch entirely. It is true that some cases will be
worse off (at least compared to v2) without this part of the series. But
it gets us out of having to support v3 forever, or go through the
process of deprecating it. I'd like the project to avoid both of those
if possible, especially if we don't anticipate many users will select v3
over v2.

Thanks,
Taylor
