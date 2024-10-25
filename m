Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D8C20EA55
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 19:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729886376; cv=none; b=SlyKPTEPtimu1rx9jTUCUDadKMvFAM5YImcz+l0xxuCbx1OPG8cpC47dhSiXzKP1eYqme4OMJLDvhoh0JhKYITyb9EHsToSxN+wrJ88hH3icIpAOysIXUD+RX9R/sFVC0KoNjMgtkP34yudkBduVb+pPKmVo4G1hbjWLh9Fn4tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729886376; c=relaxed/simple;
	bh=XUh4ZH2AmaoiOYF3nTfFOCiWfHpk/GkamBkBrov6MPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XztnsdsU4698xJkKqBuoxp04ORDEZwy04y9EbOOBZc8QibsFVr+QMRLVUlMYRpiwW/qpVKL4o1TFmQLKkedE2HHVsMKOliwhPROuGZW0LbSjwtU1Pz9fW69xBXTUVSqSE4Zcu0sXNjcSfG+DCTOACbPFk4ZEmjv8Vr3dS14TF8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BsLhSioF; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BsLhSioF"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e2e444e355fso2608317276.1
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 12:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729886372; x=1730491172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CrqDw4qMdE6fd+IWYxtU8lHXdRE0+zp9vq5U9zkUWhc=;
        b=BsLhSioFUu9YIoKBi3p3BTymS6q4TEsb0wxaAPQ4x3qSGrlhleCor3jGQ0/b8MVxvl
         3fpRwFJsCt7nI6JHK+1sK0CMoM//LQDCh2/H0AmjKeUrK3SaRhYUpu/Ne9hs6bytWmTb
         CE0RsyNQGNWeibrvCslgIfn1Oz43hzNAxtOJUE9RTwjfRRmkJBDrTazY6vvOcHZx3ndA
         p8tBAmci7Q9YlIi+EUOLtV78LRpVcI/AL09cMvPv8TzaQ1BdKtob/lxx9EAIPtsV6CjB
         wZmfp1DixsigAFs4XCq5tzBHXeENKXOrwzfXUSVGw2aUhoLcilTX8fDR0AP1r+adsF0b
         cqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729886372; x=1730491172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrqDw4qMdE6fd+IWYxtU8lHXdRE0+zp9vq5U9zkUWhc=;
        b=Du1BM5Nk9aoai7/kGtIJvAzp/T1syzF3ffUs0/2KjKZQp1Q4NLpbB1lVLfKO0ttTPt
         anDsiuVp53dtF1m0xe13+nl0WjbSrmG3nLPKHQeMIilHvxSmF+c0TWby1QD9BYUJouVV
         QV0GPg7vsjZZCLaC3eiJOy8VYK4Z0dMOKi8i3XJWP7ZwBv9b/UNgVhO2TUoTFzLw65Qf
         OfV1KG5nzwyJctC9g9bF1utS6Owczj2b2iNE0rFf4cF649M26scNop0CCJHIwttD7bqH
         VvD+zXrwi5exFiJ5LG5dH8MSEbPPMAT/giUGG7WNCnntoF6TeGEBjrfqO+/f4bTWf5Ap
         hXGg==
X-Gm-Message-State: AOJu0Yy9ze8/OXKCIpTbXfwa2XtIYC+Gddl3tg9eL6/+AeWROEcDapLk
	UwvuUVSJrJ8nACvFJ8TzF5aSTU9PVWHv8OzKJCj7wdom1s1cp6GqSystJxoU7+g=
X-Google-Smtp-Source: AGHT+IF4Fc40qNH117tFcwHShB9TUwdTHPWEqD30pTerMup6JEYtKB8QuL8wb+HGLD+ineWmXcCcPg==
X-Received: by 2002:a05:6902:178c:b0:e2e:447b:7048 with SMTP id 3f1490d57ef6-e3087266378mr741109276.12.1729886372455;
        Fri, 25 Oct 2024 12:59:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e3079d9af17sm369632276.32.2024.10.25.12.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 12:59:31 -0700 (PDT)
Date: Fri, 25 Oct 2024 15:59:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
Message-ID: <Zxv4osnjmuiGzy94@nand.local>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1729771605.git.ps@pks.im>

On Thu, Oct 24, 2024 at 02:39:43PM +0200, Patrick Steinhardt wrote:
> Hi,
>
> this is the fourth version of my patch series that modernizes our build
> system. It refactors various parts of it to make it possible to perform
> out-of-tree builds in theory and then wires up Meson.

I was thinking a little bit about this topic last night and wanted to
collect my thoughts somewhere.

I think that there are a couple of things that I'm not 100% clear or
sold on, which are:

  - What is the eventual goal of this series? Do we plan to transition
    the existing make-driven builds to instead be built with Meson? Will
    we have both? Something else?

  - What is the eventual plan for CMake, which is maintained currently
    in the contrib directory? Will it be deprecated in favor of Meson?
    Will we continue to support it?

Let me expand a little on each of those in turn:

== What is the eventual goal?

From reading [PATCH 17/19], it seems the main arguments in favor of
using Meson are:

  - Ease of use: easy to use, discovering available options is easy. The
    scripting language is straight-forward to use.
  - IDE support: Supports generating build instructions for Xcode and Microsoft
    Visual Studio, a plugin exists for Visual Studio Code.
  - Out-of-tree builds: supported.
  - Cross-platform builds: supported.
  - Language support:
    - C: Supported for GCC, Clang, MSVC and other toolchains.
    - Rust: Supported for rustc.
  - Test integration: supported. Interactive tests are supported starting with
    Meson 1.5.0 via the `--interactive` flag.

I don't think that when reading these any of them stick out to me and
compel me to learn a new build system. I understand and am sympathetic
to the fact that GNU Make has odd syntax and can be cumbersome. But I
don't think that incrementally modifying our Makefile over time is
difficult, and it has certainly worked well over the years.

Certainly there is ample support for IDE integration with Make.
Out-of-tree builds and cross-platform builds could be supported in
theory as you note within the existing build system. Another suggestion
you make is that Meson has better native support for Rust, which I agree
may be important to consider in the future.

But I don't think that any of those three (out-of-tree builds,
cross-compilation, or Rust support) are insurmountable challenges in
Make. Certainly there is a lot of inertia there, but I don't think
that's a bad thing. Contributors are used to the existing build system,
it has worked well for us, works across many platforms and has (IMO)
stood the test of time.

I admittedly have a hard time squaring the benefits and goals we have
with Meson with the cost of learning a new build system, and/or moving
away from Make entirely.

I am entirely open to the possibility that there is something that I am
missing here, and that Meson really is a better choice for Git given our
current direction. But I think if that's true, then the series needs to
explain that more prominently.

== What is the eventual plan for CMake?

From [PATCH 18/19], you write:

> If this patch lands the expectation is that it will coexist
> with our other build systems for a while. Like this, distributions can
> slowly migrate over to Meson and report any findings they have to us
> such that we can continue to iterate. A potential cutoff date for other
> build systems may be Git 3.0.

I don't view this is a good intermediate state, and is in my view making
an existing problem that we have worse. On the "existing problem": I
think that landing CMake support in contrib was a mistake. In my view,
CMake support should have either been a first-class citizen in Git (such
that we don't consider a change "done" until it can be built by CMake),
or should have been maintained out-of-tree.

But I think we struck a worst-of-both-worlds balance by landing it in
contrib. It's maintained in the tree, so people expect to be able to
build the project with it because it comes with a bog-standard clone of
git.git.

But despite living in the project's tree, it is not a first-class
citizen, and subjectively it seems that we get an awful lot of mail
asking why something doesn't build in CMake, etc. (To your credit, I
think you have been one of the main people to help with that, often
fixing those bugs yourself, which is greatly appreciated).

I don't want to see the project have to pseudo-maintain three build
systems. It seems like doing so would be cumbersome, and error-prone. I
am already probably guilty of breaking CMake builds when I add a new
compilation unit to the project, because of a combination of my lack of
familiarity with CMake, and the fact that we don't have a project-wide
convention of treating it with the same care as we do the Makefile. I
think that having three build systems (even if they only co-existed
until Git 3.0) would make that problem worse.

I feel that if we are going to pursue Meson over CMake and/or Make, we
should have a clear plan to either get rid of CMake, keep it up-to-date,
or something else.

== Conclusion

To step back, I want to say that I appreciate your work on this series
and am certainly not opposed[^1] to the idea that we may need to make
significant changes to our build infrastructure to support the project's
goals.

But I think that what I'm missing currently is a clear picture of what
goals we *can't* achieve with the existing build system (or could, but
only at significant cost/awkwardness), and why Meson is the right choice
to address those gaps.

If the project can agree that pursuing Meson as a replacement for Make,
CMake, or both, then I think we would need further clarification on what
we want to do with CMake (and more generally how we want to support new
efforts to add additional build systems to Git in the future).

Anyway. If I have significantly missed the point here, please feel free
to correct me. In the meantime, I think discussing these points would be
useful to clarifying the direction of the series.

Thanks,
Taylor

[^1]: Both in my current capacity as interim-maintainer, but also as a
  regular contributor to the project, who would (in both cases) be
  interested in evolving the build system we use in furtherance of
  project goals.
