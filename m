Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0984B199EA7
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485738; cv=none; b=BmF2e0m/azlIu8qOB+G38rKRja9XD0wMZv/wzfSnbSSpa9sYb9Ed04t3mlzO6pFKPqJngGh3AIBLtMPYxMD4ayU9uLrxN+1bqFUhFI0TsZOVghQI1tB5qUqe0TUt674vhBPf3ajVd2C773E1XUI87BSdrn8xgy22MjqPlD9EMAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485738; c=relaxed/simple;
	bh=2/EhJ6pnU7632TJRuqgL+lfqzteZ5CVYdWd60Y9rqlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f27eY2tWcVfa9lfi614Tlt6puIBc0BC88U9m/x0LuxujZOjAFvlL78tjlUQHWfsz1ilczy59ReuR9V/ip1ExLhqbK41911c5Lab3GgZYFs/5FWxicG/O/S2KDPT5KNriKGN0+hUB6iqJngUsLHoSRvylixIEbtY5P+nK9C8hLjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0axlanS; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0axlanS"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c86f066256so747025b6e.2
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 07:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714485735; x=1715090535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+JGHa5cmTDKLPyW21M7Ce+uWsJUFqoPGRK1byXgSLo=;
        b=j0axlanSLiFiypOwCtzkVTaqgy5zha/nhZjuGjJuyOtrkx1/+hHoJAHwfq6mo6Qybj
         DzF4KYaH/Mv/TRlqVUOWiuwHLgJWoO0ioxZoI+1wRNxQG8JKzFTjrC4C2hTK8wBVFVka
         INzc8d5Wa3rdHLILEyLatRIdMya71nCwLeyFpySQm6IsHkt4s30/y7119+mqCgk6m+Iw
         lFC/rlS1RfTl/v37nQ83T/r9AhDCgmIn3t/Cy+puKdDn6osucStLX75yHO18F6XIKEhE
         hB3caU2HMs9xJ+EOeSeji3lZY/N5OwxqqAq3+YCY8uJmIIgtnzk2gFtuGlMS2t7rPvrd
         ZWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714485735; x=1715090535;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+JGHa5cmTDKLPyW21M7Ce+uWsJUFqoPGRK1byXgSLo=;
        b=MK7Npg0V464NC3KTVjPeVx7Gc1RVxfUMKJzLBsRnOTfoPE2kNPnYl63/I7HU8A1rpZ
         UJ0GD+cN0QbA3CFVZpbWmNrOdA3BSMfwfDxHpsbijIqbR1BTmHSVY3qEXmzr05jRnrD+
         WnzxhTtqlw6YnRLugZkINGd0RazxaL9jNGENLx9SEGEMt+JBqjTCJA+bAA0TewAlkNSn
         c4hoBtk+9R5dinvTmY3jkK2R3etW/cWsbJGWZDYUruCkRrS1deHAEb79Ix5H9CYmV99R
         zKGgQxnKuYvy5XBbUot/iTcnD4js2PKmGzYWxftybz//HgWMDOFHt7jmYucqG4BsjCya
         jZPg==
X-Gm-Message-State: AOJu0YwIM6IPDy4HX4kP3Fc+Ut55rW+MV2BMxbbRTA/ayiwKcFobWohH
	AE1mi+ulXYPfoSdmOA8wxj4Rabgib7PCL6dDXkia168zm6+bW+PFAo9VmDy+
X-Google-Smtp-Source: AGHT+IFoKtDPghWY7GZsktEZf8APNsHlRrnKlAeoEAbMb1zZtamqmzZrZaaxH7SZlLXxEnEefI5HKA==
X-Received: by 2002:a05:6808:1187:b0:3c5:efef:935f with SMTP id j7-20020a056808118700b003c5efef935fmr3160226oil.52.1714485734794;
        Tue, 30 Apr 2024 07:02:14 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id cp22-20020a056808359600b003c60bc31ed9sm3652795oib.17.2024.04.30.07.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:02:14 -0700 (PDT)
Date: Tue, 30 Apr 2024 09:00:59 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] gitlab-ci: add whitespace error check
Message-ID: <zphrzgroei4civl7q2ls5cvabyzjbexfq6tjhdy476rmaqu6m5@ik3pedton6ww>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20240430003323.6210-1-jltobler@gmail.com>
 <20240430003323.6210-3-jltobler@gmail.com>
 <ZjB77nSMou0ssu-V@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjB77nSMou0ssu-V@tanuki>

On 24/04/30 07:04AM, Patrick Steinhardt wrote:
> On Mon, Apr 29, 2024 at 07:33:23PM -0500, Justin Tobler wrote:
> > To check for whitespace errors introduced by a set of changes, there is
> > the `.github/workflows/check-whitespace.yml` GitHub action. This script
> > executes `git log --check` over a range containing the new commits and
> > parses the output to generate a markdown formatted artifact that
> > summarizes detected errors with GitHub links to the affected commits and
> > blobs.
> > 
> > Since this script is rather specific to GitHub actions, a more general
> > and simple `ci/check-whitespace.sh` is added instead that functions the
> > same, but does not generate the markdown file for the action summary.
> > From this, a new GitLab CI job is added to support the whitespace error
> > check.
> 
> I still wonder whether we can unify these. Yes, the GitHub thing is
> quite specific. But ultimately, what it does is to generate a proper
> summary of where exactly the whitespaces issues are, which is something
> that your version doesn't do. It's useful though for consumers of a
> failed CI job to know exactly which commit has the issue.

Just to clarify, this new CI job still prints the output of 
`git log --check` which details the exact commit and file with line
number of the whitespace error. The difference is that it does not write
an additional markdown file with links to the commit and blob.

Here is a failed execution of the GitLab whitespace check job:
https://gitlab.com/gitlab-org/git/-/jobs/6749580210#L1289

> 
> So can't we pull out the logic into a script, refactor it such that it
> knows to print both GitHub- and GitLab-style URLs, and then also print
> the summary in GitLab CI?

We can do this, but for GitLab CI there probably isn't a point to
generating a summary file since there is nothing that would pick it up
and display it. Having links though directly in the job output would be
nice. I'll give it another go.

> 
> > Note that the `$CI_MERGE_REQUEST_TARGET_BRANCH_SHA` variable is only
> > available in GitLab merge request pipelines and therefore the CI job is
> > configured to only run as part of those pipelines.
> > 
> > Signed-off-by: Justin Tobler <jltobler@gmail.com>
> > ---
> >  .gitlab-ci.yml         |  9 +++++++++
> >  ci/check-whitespace.sh | 16 ++++++++++++++++
> >  2 files changed, 25 insertions(+)
> >  create mode 100755 ci/check-whitespace.sh
> > 
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index c0fa2fe90b..31cf420a11 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -102,3 +102,12 @@ static-analysis:
> >    script:
> >      - ./ci/run-static-analysis.sh
> >      - ./ci/check-directional-formatting.bash
> > +
> > +check-whitespace:
> > +  image: ubuntu:latest
> > +  before_script:
> > +    - ./ci/install-docker-dependencies.sh
> > +  script:
> > +    - ./ci/check-whitespace.sh $CI_MERGE_REQUEST_TARGET_BRANCH_SHA
> 
> Let's quote this variable.
> 
> > +  rules:
> > +    - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
> > diff --git a/ci/check-whitespace.sh b/ci/check-whitespace.sh
> > new file mode 100755
> > index 0000000000..1cad2d7374
> > --- /dev/null
> > +++ b/ci/check-whitespace.sh
> > @@ -0,0 +1,16 @@
> > +#! /bin/sh
> > +#
> > +# Check that commits after a specified point do not contain new or modified
> > +# lines with whitespace errors.
> > +#
> > +
> > +baseSha=${1}
> 
> Two nits: first, I wouldn't call it "sha" because it really is a commit
> ID that may or may not be SHA if we were ever to grow a hash function
> that is not SHA. So "baseCommit" would be more descriptive.
> 
> Second, our shell variables are typically written in all-uppercase. So
> that'd make it "BASE_COMMIT".
> 
> > +git log --check --pretty=format:"---% h% s" ${baseSha}..
> 
> Nit: there's no need for the curly braces here. Also, let's quote the
> value.

Thanks for the review Patrick! I'll address these in the next version :)

-Justin
