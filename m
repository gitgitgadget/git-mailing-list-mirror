Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B48E25EF9C
	for <git@vger.kernel.org>; Mon,  5 May 2025 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462181; cv=none; b=FFoupucVfw0qe34M2PWRei+sqXZRs2I0Tm4h6K6FRDC8nL5CcrumcuuVzea4BRoqD0eR+tKk+wJw7mbKVXkjXWnBbah5vLua02AL7xeX/2rB4Yx7WKzvveiuxk3KISDLHFRhuZxK8YJ8dKI9h1ApzhrL/ghRn+ZbdzXcjmz4dB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462181; c=relaxed/simple;
	bh=ZsxQ/+Bf4uWzfQ8DXpeWbcmvFOJ8JeSKdsSOFF6UBtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEWP6J1bU7yNTRsraXhXa9PlQGO1WtURZq1qBvk/k5MQHGYmK8XM3DaUjl0FvoPA8QJoSKDwsuOPAPxV8QwQJ7xi9yELeyYZupkatNCQLd9bcMBJhffYSF/n0MueqHuhn2g8Rj1q9wUfc3Nol0b7FQ8fFfHk+HSybeXg4k2uiS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+YuYZX6; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+YuYZX6"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-400fa6eafa9so3454285b6e.1
        for <git@vger.kernel.org>; Mon, 05 May 2025 09:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746462179; x=1747066979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7qts45gHNjjCaIGOhiJXGsireJzdFsO9P42cFgc03U4=;
        b=Z+YuYZX6MMmFjv15wZ6bC7lnIpTa0pYoaKAGw9T3gcLzuRn3UlmZ/3wU3qQ+56Tbuy
         vj6uJYQzJUgs669aWAM059zXPuChtqdHNyT8cYK9FLWIS8rwktUnspiZlPPn5yWyIAwl
         nYNSeGCDKjsdy4OUTT7J4xRN1FL96hHOaTpg+7xY+MnTSkRQULwpcXFzgW0hI+t50KLH
         /GcROe3mmY9KPVufiW8IW/Hb6BZ1OySm59TnjZPzSTBoLxqooIJr2UfZIGbtEt1Qka3o
         p0nVQxGjkfACDuzIXkpdHKi+rEI09N98LXu5YxV4DtrK2kI4vyIu9HFovZIhQkkv1pDU
         WlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746462179; x=1747066979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qts45gHNjjCaIGOhiJXGsireJzdFsO9P42cFgc03U4=;
        b=u6Gs1TChWaoIjKUDbXsp4tvw6zNWWpr+isGxWqnz3/uJxO3pMpqW4cP6aDL02sFftw
         N4m63s4SqmNYTSSjLaDjk6f3BehLPjpUlOPBq+KPHA9Iz8ENWE5ofhi4FjiCzG5fGrr8
         Q7lq/vmCP51zvFzWulaFjjYnU/Rv50QVWWrZjlgAVeeGShEvobeXzZlGZhJmGVMmu34y
         9zU/rnQ+bz9lCZ0MfiNYFtrC4uGZYv0Gj9u3PqxpdOaPbPss20nHrvxJeGm0V/Jia+fp
         roSAaM8hjUMYD/bheSmwFeQgdiKmJ2ptDdUsrpaDkfKA57QnUXu6xlO6o6KaaBsiVQ2M
         Fvcw==
X-Gm-Message-State: AOJu0Ywm9InqQoPzWxuYFE8sycz1AxtVML7M3wqLes9XY2CIjQGMIAVe
	hIHYpy4rWXhkhT1/CMPhHudIvLmCCnXyenDKSMV+SuEYJAMP9vidQ/txkuGV
X-Gm-Gg: ASbGncslN+eYLClXsgNXC+sj8Q8l/i5G2mNwDuv1URnFZdgNqu5Hrk66797zNYSVlvK
	ENl5klvqBS3c8TUAvPiHqIe0jsI+upKdKTfIJy3Axc7GicpMEdT3XxxvLYjA421PY3bJ+DrWWAf
	8Z3F9/8BBYJG1ROAML1h+GDx1C9NAWTwNa9w/Lusk213NzPoH2i7PkmIxLhtQ/JRPb8u6tcG8g1
	ZjTvjHmroVOMcPyadJglfh2I1o0X2uXnos+7mwmcsj4btu8z6WajwKgQR+Ys/0TD5gLCkmTsYII
	N/gBkEi9dVXtKtgqRHNqBv0LLa4C1SttZg==
X-Google-Smtp-Source: AGHT+IEq9gFI0AbPpax02alYur/LZZvFm31Y8y7MnBNxtWO2eCByzPFayXxRoVjqh9+Z/jLJ0LC7uw==
X-Received: by 2002:a05:6808:3389:b0:402:11c4:bceb with SMTP id 5614622812f47-40341a0cb7fmr9294958b6e.19.1746462178856;
        Mon, 05 May 2025 09:22:58 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-4033dae4323sm1924227b6e.22.2025.05.05.09.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 09:22:58 -0700 (PDT)
Date: Mon, 5 May 2025 11:18:36 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Akash S <akashs@commvault.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, 
	Adithya Urugudige <aurugudige@commvault.com>, Abhishek Dalmia <adalmia@commvault.com>
Subject: Re: Incremental Backup of repositories using Git
Message-ID: <2dz3cema2mr5mrlvuroemnyeqyrglxfmusfdz2kaghv6rvj3ro@ti2dhu45fdmr>
References: <PH7PR19MB70252D42F5D04FFC0331AB63C08E2@PH7PR19MB7025.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR19MB70252D42F5D04FFC0331AB63C08E2@PH7PR19MB7025.namprd19.prod.outlook.com>

On 25/05/05 02:35PM, Akash S wrote:
> Hi,
> 
> Currently we are backing up repositories using the "git clone -bare" command and save it to disk. If we want to restore, we just run git push -mirror from the repo that was saved during the backup.
> 
> Currently we are running full backups (run git clone -bare) everyday, which is taking a lot of disk space and time.
> 
> Are there any possible ways to backup only the incremental changes of a repository? And somehow construct the whole repository when we want to do a restore from the incremental backups?

You could look into using git-bundle(1) to create incremental bundles
using exclusions. Examples:

  # Creates a bundle containing the last 10 commits for main.
  $ git bundle create inc-backup main~10..main

  # Creates incremental bundle based on time for all references.
  $ git bundle create inc-backup --all --since=7.days

These bundles can then be "unbundled" into a repository as long as the
repo contains the required prerequisite objects.

-Justin

> 
> Thanks,
> Akash
> 
