Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091AC1527AF
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488185; cv=none; b=h4Gmg78nl/SVVvREhIHejx/9zQtQYlgI3TF8rjCwACdDdedeL2WkT/9aujPm6u3PiihJjXn649HeGXt93tnGGUlVIEX7wXx5M8lHvGMfY2ljEroZeDPEnx8c7OEhuZ0ifML5lWC/YO9Dl99opNdJwORsfJBCFisHMwbfHHz0EwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488185; c=relaxed/simple;
	bh=9J5Khqc3qoNnzy5UNadQo1+EWzYpyDQ7cp3e33edfUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQSFkp5LNt8b1mkLP9fHUmj6QXn/xeWuGE7HIdjrmVo1/3CMR1iWtjrarfpuhKTipZIZbjnqthYx7uhiKxHfRT7RWrstX9Sqioo6J2/pq3GQOjFK9AIO2QVHjMYnFNLBYy1rPqbATKAEAz5M54GTf0EO0cfbHDmr/63VHE3KzPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjISSPu0; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjISSPu0"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5afbd1c3ffeso804392eaf.2
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 07:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714488183; x=1715092983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0+SX4By2Hk0TGeBZ/Nj0Jjf+y4N4/zi6qtmt8eTWHM=;
        b=YjISSPu0b6BdCiTqm2OF+UHcbEsmt74jv4MHiCfyATH1VS9lXtcoDUgb620/ffLM/n
         Htlban/h3ZC7tul7aKDhUJsmpKTGwK2WIxfqFLH5T2s8bKocU/ShkK58jUPwAIA7zbaf
         CYjPE/ys2ATQEKNRiSNO74l/7HZigFLZ/eu9UX38IPF8pIzAqAPA6EvuzLS8aq/mFu0T
         aSg4rlPUs+HturCEhxaB7B3k8zTeRaFf5gjYYVvd9YtygKSTuNEHt1iRdyTtUZhYB4F9
         u9c2bD6W3QRExu0xVYO8XYf2ll3sQuk6/pMu4vSsNaPs7pXy8LfNrunjV0rqz03r1ISn
         cnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714488183; x=1715092983;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p0+SX4By2Hk0TGeBZ/Nj0Jjf+y4N4/zi6qtmt8eTWHM=;
        b=nikCKefWQc/DkfWNLLwM5cL/T8eSobXN1GV6apnHVF7Jume8MMlSoLyG8pJ5bQxXAi
         m1TsLyaCrdXlXupC7MAsOJ+BHMBWC4dgo0r7+8mSS6FFhFgZQtC5ZIhShBx2gEgpxfO5
         Wkvm6NGbxNiwsuOAvh1wMIqIJCBPA08Jh41f0S25mCu9GxGH0weDYO121A9UXMlxNYtb
         07US8d4x/4jcrh8/+l8G0xiOg7fKcJ1GugmC3b1JsNPr3awT8OLJGyzCiZ+GDGnp4tpR
         Mh2oZDuNlWySGUSI78j53QMNESJi3RkqEKWaQRqVs8GVDqJ1TWUwlOZNXpkyI2rArhZ1
         JLFg==
X-Gm-Message-State: AOJu0Yy5OO1wG/J6UDEfQX8mjeo3xHEoaCqZdS0nn06ZGkmogiwdedAe
	j4h9taJDQrPy/Axi/cgIrh05JFyQPTZnr5ytaWUCF225Ydd/IRJGPmBnz8pu
X-Google-Smtp-Source: AGHT+IEIk7LcLIWCHslcA79+dXOtRKw//hWMQ8aZ2zgnWofDZODnMFlmblJBr9bpRwq4QYWOJUeBwA==
X-Received: by 2002:a4a:ac08:0:b0:5ac:9efc:3b02 with SMTP id p8-20020a4aac08000000b005ac9efc3b02mr3316090oon.8.1714488182891;
        Tue, 30 Apr 2024 07:43:02 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id x15-20020a4aca8f000000b005aa4e48efc3sm3848071ooq.37.2024.04.30.07.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:43:02 -0700 (PDT)
Date: Tue, 30 Apr 2024 09:41:47 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] gitlab-ci: add whitespace error check
Message-ID: <l55hxxuv5ohtno3gfjgq6mu7cqakfohon4vd7r535ztzadarin@iz4fbuwjeeug>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20240430003323.6210-1-jltobler@gmail.com>
 <20240430003323.6210-3-jltobler@gmail.com>
 <ZjB77nSMou0ssu-V@tanuki>
 <zphrzgroei4civl7q2ls5cvabyzjbexfq6tjhdy476rmaqu6m5@ik3pedton6ww>
 <ZjD6xNuncrq9fSXZ@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjD6xNuncrq9fSXZ@tanuki>

On 24/04/30 04:05PM, Patrick Steinhardt wrote:
> On Tue, Apr 30, 2024 at 09:00:59AM -0500, Justin Tobler wrote:
> > On 24/04/30 07:04AM, Patrick Steinhardt wrote:
> > > On Mon, Apr 29, 2024 at 07:33:23PM -0500, Justin Tobler wrote:
> > > > To check for whitespace errors introduced by a set of changes, there is
> > > > the `.github/workflows/check-whitespace.yml` GitHub action. This script
> > > > executes `git log --check` over a range containing the new commits and
> > > > parses the output to generate a markdown formatted artifact that
> > > > summarizes detected errors with GitHub links to the affected commits and
> > > > blobs.
> > > > 
> > > > Since this script is rather specific to GitHub actions, a more general
> > > > and simple `ci/check-whitespace.sh` is added instead that functions the
> > > > same, but does not generate the markdown file for the action summary.
> > > > From this, a new GitLab CI job is added to support the whitespace error
> > > > check.
> > > 
> > > I still wonder whether we can unify these. Yes, the GitHub thing is
> > > quite specific. But ultimately, what it does is to generate a proper
> > > summary of where exactly the whitespaces issues are, which is something
> > > that your version doesn't do. It's useful though for consumers of a
> > > failed CI job to know exactly which commit has the issue.
> > 
> > Just to clarify, this new CI job still prints the output of 
> > `git log --check` which details the exact commit and file with line
> > number of the whitespace error. The difference is that it does not write
> > an additional markdown file with links to the commit and blob.
> > 
> > Here is a failed execution of the GitLab whitespace check job:
> > https://gitlab.com/gitlab-org/git/-/jobs/6749580210#L1289
> 
> Okay, fair enough. I'm still of the opinion that the infra here should
> be shared.
> 
> > > So can't we pull out the logic into a script, refactor it such that it
> > > knows to print both GitHub- and GitLab-style URLs, and then also print
> > > the summary in GitLab CI?
> > 
> > We can do this, but for GitLab CI there probably isn't a point to
> > generating a summary file since there is nothing that would pick it up
> > and display it. Having links though directly in the job output would be
> > nice. I'll give it another go.
> 
> Well, we could print the output to the console so that a user can see it
> when they open the failed job. The nice formatting may be kind of moot,
> but on the other hand it doesn't hurt, either. I guess most people are
> used to reading plain markdown-style docs anyway.

I'm thinking we can generalize the summary writing in some manner. When
run as a GitHub action, the summary can be markdown formatted and
written to `$GITHUB_STEP_SUMMARY` with no output to the console as done
today. When run as GitLab CI, the summary can be written directly to
console with links. All other runs just output normally to console.

-Justin
