Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FE17711D
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489192; cv=none; b=VGi0NOWLi/xaWlBZchVpgu4QBLIck6dojCmXQdrm2xaWAw9YqEY2rbGPhWj9/+P2sW29ftanRwOsBaw9XxAFqdAdjW0ntbHQZxTG4KX9xgRpXiccN4aIhd1YlYap+lVKI65qUpVOrTuKyRASi/Jtvu4tdPsgNaeo5TVMSv8af9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489192; c=relaxed/simple;
	bh=HRWTk5dXLZui27URVKFZmO+AQAhvWcNg6fDNQ/08WJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXFX1/RSCJk6bRuvvLRGI7996ocZw6nYdmJLRBQIsHn0YoJ0u1v3iQav78rUmC7Vs238bby8DWTenIsA9+1/zeSnQ2kjSKfirMZuTLxxoaKtm6AozjDBdJIulaSvFEMeokD/na4z3KKUZzkYvDWAG50I1YD5wLHzZqFHXhntzNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=au0ffQFS; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="au0ffQFS"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c7513a991cso3916092b6e.1
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 07:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714489190; x=1715093990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4RfJW17lt+yEsPYYCG6+aBOs9vxkKSU8429NnUWxC4=;
        b=au0ffQFStdMm3aq7fhOhW6ikzMabe7norlOJwfbHpNgIuReNh5RTWjPAHenL2XCs7V
         bI3pGEdeICe6z3wD/W9zSVDuV+BELYsN4r6zgRAGlZUm9IWmcobVM7165Dj/bCnj2QNl
         ZByPG7t9VL9VctWaBG7w7irx/9bO7aZc3BBFG/GAxOLhpWG74M2aBpv18FrMRZ8OuuAT
         jrxlD3Bx3x2SvEtomtVcG5Dr00xCrKcz/zcy/EfzxPp5iREbthAJUrpvXJLKLzZ9y86t
         9YWY+7k6EPAVHHooO3ZjSf1B1iaEJT+cNX7yYuxthSEYoI8rnCPa6TVvMbxnrgRrpXfU
         3U6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714489190; x=1715093990;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4RfJW17lt+yEsPYYCG6+aBOs9vxkKSU8429NnUWxC4=;
        b=nSxGTisQBjX2iRNsaDA3m8xA1XzSpZ1FLadCmYW46d57Zg837eU0cBzQm+nJcSVa7Q
         YT3GZ9ZZZ3qwJw8/akz+pChBMGKoMyCYylQrQB9GVm6qMnLs+qtBWOwJAllNutDx04XI
         NhgkNDTxdsP+S0zYdglEmyXiXpq+bnyCEVqNpkcK2lIGgw61OnuVShbcRy1o5+XLxSfx
         ixPNmu/4IyujgWe70ZQLceBZjWYPzBEm0KKthjTwfYuefcaoXzU8RD/GfZl7QWP1hdhU
         cKzChZ0GmK5DLqO+0LJU7k1tOi5XbY+kbjh7diCu0qfWTsGusfYkoTOSRlwW4bcbA8gD
         2uVg==
X-Gm-Message-State: AOJu0YzpFDlOW9cOvg1YhtbrMH13Gv2TLam5o1iCsO9B0uaN86ChVot9
	PA9WBFyYl045TplrX9F/uZ7jDGFDj5diMXbOjjILEoHWIM5X4IZ/
X-Google-Smtp-Source: AGHT+IEGUJ+1cOY2toVTzH+vJxgOIOLvv6gscCXz2SjA58q1/A89tiOJewfPkPA7G3QiQLA9roD/Rw==
X-Received: by 2002:a05:6808:1aa8:b0:3c8:42ee:6075 with SMTP id bm40-20020a0568081aa800b003c842ee6075mr12829133oib.52.1714489189901;
        Tue, 30 Apr 2024 07:59:49 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id 17-20020aca1011000000b003c60263d3f5sm3632795oiq.56.2024.04.30.07.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:59:49 -0700 (PDT)
Date: Tue, 30 Apr 2024 09:58:34 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] gitlab-ci: add whitespace error check
Message-ID: <nroeeqyqav4pxye7s4o3fa763btsjhbsmggw6pqh5f7vgcjuym@mxcz4cbmsqvs>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20240430003323.6210-1-jltobler@gmail.com>
 <20240430003323.6210-3-jltobler@gmail.com>
 <ZjB77nSMou0ssu-V@tanuki>
 <zphrzgroei4civl7q2ls5cvabyzjbexfq6tjhdy476rmaqu6m5@ik3pedton6ww>
 <ZjD6xNuncrq9fSXZ@tanuki>
 <l55hxxuv5ohtno3gfjgq6mu7cqakfohon4vd7r535ztzadarin@iz4fbuwjeeug>
 <ZjEEF-5xGl6tjOAG@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjEEF-5xGl6tjOAG@tanuki>

On 24/04/30 04:45PM, Patrick Steinhardt wrote:
> On Tue, Apr 30, 2024 at 09:41:47AM -0500, Justin Tobler wrote:
> > On 24/04/30 04:05PM, Patrick Steinhardt wrote:
> > > On Tue, Apr 30, 2024 at 09:00:59AM -0500, Justin Tobler wrote:
> > > > On 24/04/30 07:04AM, Patrick Steinhardt wrote:
> > > > > On Mon, Apr 29, 2024 at 07:33:23PM -0500, Justin Tobler wrote:
> > > > > > To check for whitespace errors introduced by a set of changes, there is
> > > > > > the `.github/workflows/check-whitespace.yml` GitHub action. This script
> > > > > > executes `git log --check` over a range containing the new commits and
> > > > > > parses the output to generate a markdown formatted artifact that
> > > > > > summarizes detected errors with GitHub links to the affected commits and
> > > > > > blobs.
> > > > > > 
> > > > > > Since this script is rather specific to GitHub actions, a more general
> > > > > > and simple `ci/check-whitespace.sh` is added instead that functions the
> > > > > > same, but does not generate the markdown file for the action summary.
> > > > > > From this, a new GitLab CI job is added to support the whitespace error
> > > > > > check.
> > > > > 
> > > > > I still wonder whether we can unify these. Yes, the GitHub thing is
> > > > > quite specific. But ultimately, what it does is to generate a proper
> > > > > summary of where exactly the whitespaces issues are, which is something
> > > > > that your version doesn't do. It's useful though for consumers of a
> > > > > failed CI job to know exactly which commit has the issue.
> > > > 
> > > > Just to clarify, this new CI job still prints the output of 
> > > > `git log --check` which details the exact commit and file with line
> > > > number of the whitespace error. The difference is that it does not write
> > > > an additional markdown file with links to the commit and blob.
> > > > 
> > > > Here is a failed execution of the GitLab whitespace check job:
> > > > https://gitlab.com/gitlab-org/git/-/jobs/6749580210#L1289
> > > 
> > > Okay, fair enough. I'm still of the opinion that the infra here should
> > > be shared.
> > > 
> > > > > So can't we pull out the logic into a script, refactor it such that it
> > > > > knows to print both GitHub- and GitLab-style URLs, and then also print
> > > > > the summary in GitLab CI?
> > > > 
> > > > We can do this, but for GitLab CI there probably isn't a point to
> > > > generating a summary file since there is nothing that would pick it up
> > > > and display it. Having links though directly in the job output would be
> > > > nice. I'll give it another go.
> > > 
> > > Well, we could print the output to the console so that a user can see it
> > > when they open the failed job. The nice formatting may be kind of moot,
> > > but on the other hand it doesn't hurt, either. I guess most people are
> > > used to reading plain markdown-style docs anyway.
> > 
> > I'm thinking we can generalize the summary writing in some manner. When
> > run as a GitHub action, the summary can be markdown formatted and
> > written to `$GITHUB_STEP_SUMMARY` with no output to the console as done
> > today. When run as GitLab CI, the summary can be written directly to
> > console with links. All other runs just output normally to console.
> 
> The script can probably be generalized to take a file name as argument.
> For GitHub we'd then pass `$GITHUB_STEP_SUMMARY`, whereas for GitLab we
> pass in a temporary filename that we than simply cat(1) to the console.
> That'd allow us to move the CI-specific bits into the respective CIs
> whereas the script itself remains generic.

This sounds good, I was also considering this. We will still need
CI-specific bits in the script in order to generate correctly formatted
links. That is, unless we also want to pass these as arguments, but that
might start to get a little messy.

-Justin

