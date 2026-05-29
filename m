Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A33F3BE621
	for <git@vger.kernel.org>; Fri, 29 May 2026 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780072282; cv=none; b=XbdZASngtUd3UmnRneUb1ahs8N00zE1Kgk3ULb3Esys0yJHWUykgNbbaGyzhZ1tHvpxcQKrLZnqgbi7RYIv0lVyV3nN/NHGMVnRrccg23mpp/rSCAIne0MSkUq0r/1T0FEH5E/afxBvjoPxcuCX9yfGuoKS96JZrWqqWb3a2rQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780072282; c=relaxed/simple;
	bh=sOPqVLq3w2tupFi3sK0aLVvzBrAy21zqGjrXsyQnUCw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LZ8n07IwGslafsI61zbobe3G/pA5etx8/ERXGHvcNJo1fxZtyfim/Ho9xCybJ7XFHPBzykpjwonNnC44MQggKG0wq83YC0+Cn/uRj2Knn1Vcljoow4zke98O7H45iRCPx+uaCSLT4wzG2XZRHxQbIjKlm1zDB885KfS5az2CBo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOWU6f6g; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOWU6f6g"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4903ff574c5so4984285e9.2
        for <git@vger.kernel.org>; Fri, 29 May 2026 09:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780072279; x=1780677079; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pedul+Bbu0I9bxuhxfhOlBFN0ZF5beO1meCWMgK6iwU=;
        b=MOWU6f6ggCGVN+CVqPnX8ykgmWnJu+DdC78RxwIEPpSpIXf+Qu0zyYogTdv+pk9Gnm
         BBKWzBFCAfHzgktebRKEVCt3J8lziW4J+EmQZB0aib3o7JaldVMmA8GETgz/k8M936rX
         WfFVh0Rhnr94x4Aq5LaBFomTVfMzmYKdK7/ic14Pl2qdqHZXC4XDwTxJXo0nYrSUKD9t
         y0GPp7ZmGVMuS7IrKryW/GP2PjR25VlYAN1MY1ZbkY3n1vZK7ytwGd6pHiADtuFYfwW4
         eODLn2y91uZym+AL/3/BFMSvlo/NuvSd3hcEBoO/SFc0G7U6SJmKKR2Q+XkxgBpt4whT
         v6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780072279; x=1780677079;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pedul+Bbu0I9bxuhxfhOlBFN0ZF5beO1meCWMgK6iwU=;
        b=q+jndCXDWfpErQ7PS4d4rtq+9FT4RxB7pWheXWnFMevxWcd2GiGSx6oMAXB3e+/BrE
         x7z9BevBAGnn8QCU7e6h7pyPRiz+hBO9T6dFVmUKgzQPQKPKByW8EeZF4DhVWWpRGD21
         +/gQ2i5HhZotRNZfNNHbNR48rKPiDybPVQVIMLbtj1gRfzE/xL2JrsjW2GuVXhZJ3zAJ
         dcD7LdH2LVCAgUPwnnuuV5+kcnTVlm+oO9B3tWnKXtZgQ9SPpyei2dyoeoq1oz0cjfSM
         6Wo+RIlQlJSVW8Z1n1fZpt4yUKTufVA/VwQLtxnnILPCsVkVfJPHwwHyHa2zKWFC6+XC
         eO1Q==
X-Gm-Message-State: AOJu0Yws3VTetNbhaasO8j5vOKKu/KqOn4TvrE0NRHmU3Z9Me7Dxrnkw
	jEXfSig+uVfxHUN+TmZR0xVGEsUAGXcedLa+EZrCprcnllCNJUCWYOj/O3CPNuCj
X-Gm-Gg: Acq92OHid/0Oihm3d3768PWJuAUrImK5H6mjSpHSjk5Hj6OzVF2ZBlOKRbNEsqk9Uv7
	9vo8jNGnczWPxmiYxzoBjQYpheeLfhw7lgXKmyIXrpENcHw4hqIbKqKXA5IYdM+Jg0hZ2tDFvBW
	IqAwh7TOzpki4kLBLhqf/egYkCRCMPVd9djGBTilJgDT99FMnB2q4KdWd5949D5CZaFo7qPPhRd
	QMiwEzY8+ln6pIF+Wu14SjYF/qQUrwCckKoEs+pb6uVOW2/Nn/tPktRfUNB5b+JHnCNnRjM7uqa
	NaaYyIkbOke0J7ml45rI2GenjBw3NV06R0lBxGYg3VafGJ+YwynsSBc0H9TdlKHcKw5AgqEQUTm
	azD5e9OnAPYvnHxK6iJkefnWiDCUGGd5WEalJXdUQwPOa+OUVkLR3Fywe1zyhXB0ruE8aDW09ZV
	6ezHePE8PejCFHuGDpgf4DnL4vyx+vbJBVe4z+E53lLtksqrVwtQo=
X-Received: by 2002:a05:600c:1d0c:b0:490:6e0f:2a10 with SMTP id 5b1f17b1804b1-490a294a76amr1804915e9.7.1780072278685;
        Fri, 29 May 2026 09:31:18 -0700 (PDT)
Received: from archP14s ([194.127.199.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a065esm4923716f8f.5.2026.05.29.09.31.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 09:31:17 -0700 (PDT)
Date: Fri, 29 May 2026 17:31:17 +0100
From: Matthew Hughes <matthewhughes934@gmail.com>
To: git@vger.kernel.org
Subject: Suggetsions for collaboration workflows in large repos
Message-ID: <20260529163117.z2auhbg4sdxxgmis@archP14s>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm looking for some git workflow suggestions to help cut down on unnecessary
fetching when working in a large repo with many (hundreds) of other devs and
thousands of branches. Specifically, if in this repo I use the common config to
just fetch all the remote heads:

    $ git config set remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'

Then I find I get a lot of noise from the all the branches being
created/updated/deleted as well as an increase in the size of my local repo due
to all the objects I need to fetch across all those branches.

To clarify the general performance of git in this repo is reasonable (shoutout
to `scalar`) but I am interested in cutting down on this fetching since when
working in this repo I'm generally only interested in a tiny subset of all
branches:

1. The `main` branch (that everyone merges into)
2. Any of _my_ branches
3. Occasionally, one of my colleagues branches, so e.g. I can check out their
   code locally to review (most reviewing I do in the web UI, this is
   GitHub)

I have a prefix for all my branches: `mhughes-`, so to sort out just the
first two points I can configure git to fetch `main` and references with that
prefix:

    $ git config set --comment 'fetch main' remote.origin.fetch '+refs/heads/main:refs/remotes/origin/main'
    $ git config set --append --comment 'fetch my branches' remote.origin.fetch '+refs/heads/mhughes-*:refs/remotes/origin/mhughes-*'

But then when I do want to check out a colleague's branch I need to explicitly
fetch the exact ref like:

    $ git fetch origin some-colleague-branch
    $ git checkout FETCH_HEAD -b some-colleague-branch

Which is ok (it's my current workflow), but it means I have to re-fetch the
exact ref if I want to bring in changes that they make after my initial fetch

I could add an explicit fetch of their branch like:

    $ git config set --append remote.origin.fetch '+refs/heads/some-colleague-branch:refs/remotes/origin/some-colleague-branch'

So that each `git fetch` also brings in updates to that branch, but in the
remote we delete branches once their changes are merged, so if I leave that
config I'll eventually (once they merge their change and delete the branch) run
into errors when fetching like:

    fatal: couldn't find remote ref refs/heads/some-colleague-branch

Does anyone have suggestions to make this smoother? Or alternative workflows
for achieving this goal? I'd also be curious to hear about other approaches
people take went working in large repos with lots of other collaborators.
Or am I just using git wrong in a repo like this, and should adopt another
approach?

I thought about doing something like tracking
`refs/heads*/some-colleague-branch` from the remote, since with the wildcard
`*` I at least won't the fatal error on the missing reference during fetch, but
that risks my config containing an ever growing list of such wildcards, or a
bunch of manual work occasionally cleaning up old ones (or maybe that could be
automated).

Thanks,
Matt
