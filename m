Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA444A05
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 00:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720484600; cv=none; b=MrawztfeD+LVqF54in0WRawvokjbihWv70s+736sh6GV8AOfsYn8KQlOe5Sti2RZ1wHfjHJrHaurbmt88xo74vXZzjWucxo71yx4JmueRLsRX9GMVMkyZyxQFZB88L5/0+e7SH9/yAeNR6Ij9eF1E39Z/xF8gtYQrKxa9Ojih+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720484600; c=relaxed/simple;
	bh=gYMnrtx4PUqX1jwraWc8a2sSIU/wdrgj80ke2p4fmwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxivsIRs3WQYR3VdKSXj/bjL5/WOnsBt2dYaDhj2NO4o18WOyMXKhzxPN6kchXrH3Tk132H24NHe728Nod/aEkSPC8awESQuYgUZXd2ECR4QeucVc3df07Jo+MuBOFzrjE3PH59ANQ+YQi3k5uNz9+sjclOaTB4IxUEJ3nfZA/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcWzYpdw; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcWzYpdw"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d925e50f33so1600599b6e.2
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 17:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720484598; x=1721089398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gxzX78q+MKAW10DGwMCmJz/lL1kuViDbcpNfy+Hcj+Q=;
        b=jcWzYpdwwupcNSA6LkexApPxK60HVzUPBHLT3+U6qJVrgd71ohIUsjSZpnUfk2nMqm
         6uq0R7EOE58bvVmvu48Pnod3IBxNidmoAdNh0q2UdI8PVlw8IXRjj0NNFUbzBTvHGWfZ
         Uc4RLZ2wmqLNs49Qz42clO7EFVnXUHZx5gk0EkbCLQDc4aAgoqPxQI4537SawwSmEuK+
         jbU1S9isbl8kyy+9TUgsLaTUQwRFrFkZ7ZhzJsow7L1F64aT8PfZmnCmZ4KRJKNaQFBX
         iqxtVVh0gHJ3sXfy5xbExe00N33HI3BBfjhublv06Ky42TAcVhquMFpRZF8/0yCMjDp8
         tgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720484598; x=1721089398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxzX78q+MKAW10DGwMCmJz/lL1kuViDbcpNfy+Hcj+Q=;
        b=miR8MRMOEc6SoGGlTPF0QiYGZxfsF7Ka2UOZHF68PXQ2S/IN05wHlpxRPtE0egntlh
         trEoc707H6nztA6tLEEnx06ID79eSmkB/hqcEm05NZp3ydFDvAnXApRHRe/NWuE2DfUT
         1Veoxj331kw1c2B68YnZYWCIuZrBgNOfrS6cOLwg0aT6LaXaYtPR54Z19zALBav5QBbT
         w9c9HhetI+/JKjQ7IwLtSFY9HaztI6O8lNWbz8PN3qla7/pnCZZmbUZkxMsmb6Du51J5
         6l1PO+ZhfJHnBIOSGuuWknmAAVN4Yp0HmPfD8qgxp+1Ya7Nk5a5iys27d+5JnMU/MuJ0
         2CeQ==
X-Gm-Message-State: AOJu0Yz00ilZOcEueY9vOYr2eh6oHKtO+ssJw1OQ+UXT3WTrWMCD76FY
	LEmqese/FuVwKBUwzrT7O4Is8CfFqNpmEWvCIDILxpwoyyo8pLOH
X-Google-Smtp-Source: AGHT+IG/RhvAPqr+nSugu6SRKC3Dw1EDMUKT7MOvSC2N84dn/UcFEMvYZR8t+oXv+Tj9LLFQMVURlg==
X-Received: by 2002:a05:6808:3007:b0:3d9:31ab:fae1 with SMTP id 5614622812f47-3d93c002f85mr1109033b6e.18.1720484598056;
        Mon, 08 Jul 2024 17:23:18 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d93ad27557sm199469b6e.28.2024.07.08.17.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 17:23:17 -0700 (PDT)
Date: Mon, 8 Jul 2024 19:22:48 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org
Subject: Re: [PATCH 7/8] ci: run style check on GitHub and GitLab
Message-ID: <lu7o24bwwh5ntarnpfjkmceuvzxs6rdykcrojonqkhfcvq7vka@7h3rev4n7wxr>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-8-karthik.188@gmail.com>
 <7wc2ucdbirqgtrxgij3i4eqwfib334kdogbfxtiyifje6clsat@3p3xnqkoj3ic>
 <CAOLa=ZTuBziBPY1B0P3gTWMhqThuyFsFW1aWtwUconYN4gH+aA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTuBziBPY1B0P3gTWMhqThuyFsFW1aWtwUconYN4gH+aA@mail.gmail.com>

On 24/07/08 02:16PM, Karthik Nayak wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > On 24/07/08 11:23AM, Karthik Nayak wrote:
> >> We don't run style checks on our CI, even though we have a
> >> '.clang-format' setup in the repository. Let's add one, the job will
> >> validate only against the new commits added and will only run on merge
> >> requests. Since we're introducing it for the first time, let's allow
> >> this job to fail, so we can validate if this is useful and eventually
> >> enforce it.
> >
> > [snip]
> >
> >> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> >> index 37b991e080..65fd261e5e 100644
> >> --- a/.gitlab-ci.yml
> >> +++ b/.gitlab-ci.yml
> >> @@ -123,6 +123,18 @@ check-whitespace:
> >>    rules:
> >>      - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
> >>
> >> +check-style:
> >> +  image: ubuntu:latest
> >> +  allow_failure: true
> >> +  variables:
> >> +    CC: clang
> >> +  before_script:
> >> +    - ./ci/install-dependencies.sh
> >> +  script:
> >> +    - ./ci/run-style-check.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
> >
> > One downside to using $CI_MERGE_REQUEST_DIFF_BASE_SHA is that for GitLab
> > merge pipeines, commits from the merge that are not part of the MR
> > changes are also included. This could lead to somewhat confusing
> > failures.
> >
> 
> I'm not sure I follow.
> 
> > Example failure occuring on this patch series:
> > https://gitlab.com/gitlab-org/git/-/jobs/7284442220
> >
> 
> If you notice this job, it points to the commit: 1c6551488, and the
> parent commit of that commit is: 614dff2011.
> 
> The parent commit [1] is a test commit I added to check the failures. So
> isn't this working as expected?

Ah ok, I misunderstood the setup of that CI job, but the problem is
still present. Here is an example CI job I've run demonstrating it:

CI - https://gitlab.com/gitlab-org/git/-/jobs/7291829941
MR - https://gitlab.com/gitlab-org/git/-/merge_requests/174

For the MR that spawned this CI job, This patch series is the source
branch and the target branch is a version of master one commit ahead
containing a clang format error. Because this is a merge pipeline, using 
$CI_MERGE_REQUEST_DIFF_BASE_SHA will include changes from either side of
the base commit. This means it would be possible for the CI job to fail
due to commits ahead in the target branch, but not in the source branch.
For the check-whitespace CI job, I specifically chose 
$CI_MERGE_REQUEST_TARGET_BRANCH_SHA for this reason.j

> 
> > It might be best to use $CI_MERGE_REQUEST_TARGET_BRANCH_SHA instead.
> >
> 
> I actually started with $CI_MERGE_REQUEST_TARGET_BRANCH_SHA, it didn't
> work, because the value was undefined.
> 
> See: https://gitlab.com/gitlab-org/git/-/jobs/7283724903
> 
> This is why I also decided to fix and change the whitespace check.

I'm not seeing $CI_MERGE_REQUEST_TARGET_BRANCH_SHA as undefined in the
job. Here is a modified version on the check-style CI job printing the
environment variables:

https://gitlab.com/gitlab-org/git/-/jobs/7291792329#L2470

Do you have an example of the check-whitespace job failing in GitLab CI?
Maybe I'm missing something, but I don't see a problem.

-Justin
