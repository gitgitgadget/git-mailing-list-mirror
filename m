Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659F6A94F
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 22:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752791128; cv=none; b=pyw2YpIF16PSqDz4A3/dgDa7VylkQ++cCAa5mx9iHRI65x55dDP2K8vcd3GV+Z80irUVqg9zvdh9ajIceUCkPh2e8bfmHQe1eyPP/V2bW/1W8/SFptOWBL3JB7LrPBSn9PXqNsyiY7ONh8P/aeQU/vaDE8/eJ/MYCOfhrKAJx7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752791128; c=relaxed/simple;
	bh=lMgY2FvNJS8+8MwXZDBJsxCzMH7skDEeo6PaNjgGbEo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kw2s27umVhy4FlmcKr9tA19roNYXeuRnfi6er6rO/JltBaPigCvh6LtcHgtNxS28OfBxoe0p56/qMJeVN5eg77xknmdRMFUEU5WzmFaaQ44lCTABVh5dfpKporFs7TW03XZqHo/HXC4s2YuRB78MCI8pVzwwllclTU89wWoPSwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=IBLI1rEt; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="IBLI1rEt"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-70a57a8ffc3so14173477b3.0
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 15:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1752791125; x=1753395925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+u1V+VDBQs8e8VDODKYBP+pRgLDSC2tKYM3d6UF0YmA=;
        b=IBLI1rEtyvpYiGCiYAzrUA5fTiptC3612ufhJT1Gr/x+9rHVzKJBXTwBNmhrnM/WC8
         ZBLcuKhPymQfzFjnQa8B5nJn44dMaUnwh3h4KobnbdBlj6j5/y84da+XNQVdJCzjGjGo
         VSZJZGQiI3z2hqSHTH1Iq5DCFeFE1KeiPLyqhKNSeqec53vRdZ0ABoJsyLsTh5NEAAMz
         7KR7MCh/lPaY0q2wa8auWN1AVv5Bs7SwM78sY9Bx+Jp6NjQZYcfa8/apac8Yhjco55Zw
         9e/1R7NEor3Om4SQc+7I9jK/2+9LT1XliCc+6otMGk80SgM4m9niVKJdYgn7P2KiuxKq
         ml0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752791125; x=1753395925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+u1V+VDBQs8e8VDODKYBP+pRgLDSC2tKYM3d6UF0YmA=;
        b=E9g4oML5AhGv66eL8Qa5PGzmXJ985F1qL0q3FrVGAi/yu4iTlMUWRiKkdhKm0MogkA
         TfCLP7GKSWsVvG9g1WVDk7TfMnSOdaMiFJLyp9WBvCTVqH5DVhf6Ic+RuC+1icXgRIDb
         X4sOvNM1ip37y9jD+XZCIGYo7CaaQ0Vv9u9pHx8gfctZROzCLMeIn7fB5MeHTNHPZirQ
         iQ5ZVkrQ3BNEsxS8DG9m7lukxHBtmt51vYWtn+FZWSwSw6UyhL/S6FArWE2nCmwzPb7k
         +Ht8ruMc4PV0jJSjR5xTaxawvds621bohLoUB3AgEjOCNyekG3yQQrm7MTaVmPwavojm
         bQbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcABYocCHn4aYibJuZOrCmRNeDaW7N2MNXxB49PF5kLuTp642siBv8H9IpMgw7YbWrsbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC51khzRS0mQgWBWiH1THEiHEfgXfjJtK+GBP+zsfacCvJQa+O
	E6O8NA4O3tgLjvggtHNAhbdJIynFOo1S0Kwf0vQCHn7DQLqDnQeUOkQXx253NNrBJcU=
X-Gm-Gg: ASbGncty00XIxggVsqFg9mv2zlfSvaJQVBNw3FF+K/9V2rZCmwPLi8C9zfJpP0eDc/9
	mjuqhfpa4jEE3k/ouieQz/qmV3C+fAKkC3mrzBZKOd2bjWbLG4972liEVlppT3OoADgFzky1aj7
	vSed5BwhT8IJrI/L00yzthPaM/dvNxVtUuDLPRMoomcnsXTgcGJzDK9OFUumnxDRzR5EeOok1wI
	5YlqCaP4C2eB596AcaXdkQ98QZr5RbOVJNGBL5y5D3bJcoFyRAbBhTnGj4HEZlaWUDMHI2H1fAv
	gvbxZXTQsdbtRLJpL31KFENbt/fqmL6xis6RduufpFb1SkgSm0JVBIYbzFe9C4m+9RMMhlnJDk0
	d7Ln9zyUwaklwnl7mcpEKSduGNGXyPAMbI2/xpmT66M3xRFfdY7/5jepQ3RRLIL+4jRvzcw==
X-Google-Smtp-Source: AGHT+IHo1qshvT7LrGxenkbKmVNvA8zaEsi7USjblOU86Yq/fmsfJ+yZaRZManBwHuafl9iq8DYrEg==
X-Received: by 2002:a05:690c:3707:b0:711:9770:161f with SMTP id 00721157ae682-719521605abmr7702267b3.2.1752791125093;
        Thu, 17 Jul 2025 15:25:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71953141cc5sm401797b3.38.2025.07.17.15.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 15:25:24 -0700 (PDT)
Date: Thu, 17 Jul 2025 18:25:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
Message-ID: <aHl4U98BBvpA5eKF@nand.local>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <aHlwZPbiKnakMN75@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aHlwZPbiKnakMN75@fruit.crustytoothpaste.net>

On Thu, Jul 17, 2025 at 09:51:32PM +0000, brian m. carlson wrote:
> On 2025-07-17 at 20:32:17, Ezekiel Newren via GitGitGadget wrote:
> > This series accelerates xdiff by 5-19%.
>
> That's great.
>
> > It also introduces Rust as a hard dependency.
>
> I think that's fine.  We already discussed doing this at the last
> Contributor Summit in Berlin and everyone was in favour.  While we did
> not have every contributor represented, I think that unanimity of the
> contributors present is a compelling enough reason.

I agree. I don't think that there is ever going to be a "perfect" time
to introduce a hard dependency on Rust, and I don't think that should
hold the project back from adopting it.

I am far from a Rust expert, but I think that a more modern, memory-safe
language will attract newer contributors who may have a fresher
perspective on the project, and I think that's a good thing.

The alternative, of course, is to continue to use C and not take any
dependency on Rust. I think there is a middle-ground in there somewhere
to be able to build with (e.g.) "make" or "make RUST=1", but I would
really like to see the project take a firmer stance here.

I worry that having build support for both "with Rust" and "C only" will
create a headache not just at the build system level, but also in the
code itself. Having a patchwork of features, optimizations, or bug fixes
that either are or aren't supported depending on whether Rust support
was specified at build-time seems like a worst-of-all-worlds outcome.

> I realize that that means that we will lose support for some platforms.
> I ultimately think that it's up to the porters and maintainers for a
> platform to maintain appropriate toolchains on that platform and that,
> while we should be cognizant of the requirements for adding new
> platforms or architectures, that shouldn't prevent the inclusion of
> important new tools like memory-safe languages.

Agreed. Of course, I think we would all like Git to be able to build and
run on as many platforms as is reasonably possible. But we cannot
support all platforms for all time. It is also not the Git project's
responsibility to ensure that every platform is Rust-friendly.

Hopefully the platforms that we currently support but won't after this
patch series have niche enough workloads that they do not need the
absolute latest-and-greatest Git release at all times.

> I would like to see a change to our platform policy and a policy on Rust
> before we merge this.  I know your series adds support for 1.87, but
> because distros don't run the latest toolchain, we had discussed in the
> past targeting Debian stable's version plus an additional year after the
> new release.  This means we'll support a Rust version for three years,
> which is a reasonable amount of time for a toolchain and allows distros
> to easily backport security fixes.
>
> If you would like, you are welcome to use my proposed policy as a basis
> for this, or I can send that out as a separate document if you don't
> want to write one or revise mine.

Yeah, I think that this is the most interesting part of the discussion
here. I am not knowledgeable enough about Rust's release cadence and
platform compatibility to have an opinion here. But I trust brian's
judgement ;-).

Thanks,
Taylor
