Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48FC30D41E
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959875; cv=pass; b=JLxXdWyyp7pms66dSs8lm1qk/5/psBzp/cgnyQedcrB1jZtazxrM3jXtMeFUiRWNgf/PFMh3j5BIN9mlJfKcaiJ00YyUdUz9NmDbRUvcpk3HUDLpVJwqFlXpvOOSqmkEc4uObPR7pN94OvJyHzkZ7DDmHb57BJM5XV3GUyxPQh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959875; c=relaxed/simple;
	bh=6DtT3wtGza/y2NRwK+dtp2BIFMWA0vYaaMknahxAbHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=du0KmbbEXphoUkadbiUAZzlPoEsBqhep75TScXyPXrHq8qHRsUyqjqtr3SEdRVnb6e+ZiuXAs6fqJB4suEOKKcsLtQf1j55ZJfQN4MYjhADVIU+qK43b1jYD/q/f0iOQUAj0rcqnqYu19ifsVcBFozyZvYvEvu+2DgITKpmpj3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/kHbs6t; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/kHbs6t"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69532288224so6175827a12.0
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 09:24:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783959872; cv=none;
        d=google.com; s=arc-20260327;
        b=H/Vy5Ff3CLkdGzxZ7YpH9W9+WmduulrlbEwA/Yp84gQWyvsIEDyumVDxeyRD/RJolV
         6dYaN5ISqodrd/ljgHWzsHk1FTny2l9eWHRHWmiphW4GSiXWWGCxGQqufZLIKN5RjGjG
         hkTVJ5UaWxrxbwH1K5ESGCz7AeP/+6P2Y04UUIfLmP0sT4A8TmeLRq6OtZ9+NAIfPSu5
         mUZSh5UfHUHzCYnmpuVprVDmWdjVI5ZdP9ZT5QVwo6Nt/u1OS6LOLomCEuEg2Yx9+tHx
         BD4pVSRrxaokkRQEoEhRJS81rv8bk9Hnss6nx7WMfccIS8PBhM0QxNzyjm+cOCVzMjEv
         2dtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6DtT3wtGza/y2NRwK+dtp2BIFMWA0vYaaMknahxAbHI=;
        fh=rZg5fef9hj2XxCfxqZET7T3GE1SLLMmSsLTDeU0HJBg=;
        b=MS7XhfVDMQXGauNSv7XI5vbc+xua9nVZkdqrpy+DgTU/4RSBdFQrDVxDkruNx6u1Em
         oc7Be06EabsbJGl8caEeLJdi/+zIsqqAyQ/NuqqXOlBMSuJRoRvSIXcIji5Z9M/mOv1R
         tA6FD8iXr0NyJh/AO72GZ2fHopf30wS6O4lxa94eSyV5NmrehMZXoJA0gYtwajvBoc4l
         RyNdvUHmxgZ21Nkod6uZf6Fuhx3W+CgfGMuB0JAlLPnmPbODGVSui0zaeWlAsvjXLu/O
         qklVNz6f6YZU28G5DBFyFKP95O5X/E6iQwJUSplVAI4nAzfBHrQHudg6AZKxwAVhSTOZ
         3Dow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783959872; x=1784564672; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6DtT3wtGza/y2NRwK+dtp2BIFMWA0vYaaMknahxAbHI=;
        b=F/kHbs6tBKaYqrgXN8Hh37XJewzeuLJjUL0B7Z81HRKmaFrSfUd06YpHV7E0XsbC9z
         ORCnhdR9Sl1PvgWSRG60lOa/ZzeacfC1HZ9/4CJkvGOV2ZySyQjk8F+EH7RvgejXYubf
         JvHaj+ryDu8mqraEBbO8YrjGv70r9ea2PUz4yvCjHKQ17AxqRtrqMJD3mAM5EgvW50yg
         4MdhvOLhClytWydXL/8GsT+RqpX9TSMixxclSWKLwiOHKmCz6ZnuV8nU5MKK7IByJIu3
         8W+/AYQoLeeaOwh7iETvDVVe8BO+9CQKLEQiB9A70ALP4bV424ak7GG0x3vp0VVE/gGh
         Hbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783959872; x=1784564672;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6DtT3wtGza/y2NRwK+dtp2BIFMWA0vYaaMknahxAbHI=;
        b=krS2ta3QBa/HjThpTexJ9vMBLGOmdgUqVQO4130DY6VfTAbcLUlyfrYkjKL464bYIR
         gNEWR+IdQ//5ZI9kZHXDMk7KMfkyrhXIeYTfFRNqXgW1JraT8qrGyu2dOtbAu3O6GdEA
         3elZDywNtBTith/WAej//kjos6w/xKhwyzZ9D/VE/C62cfys6RPqryCjA7Eetu2KprOq
         xL4Z7b3gPy+xl/ieZmXjXM6x/2ZYFgzqvwnxOfzzo/09KGE1MgwehimOV8zWXKray+cY
         0GXQBHeHeavjmR/f8PYyPhCK4t44nETCKvnQk7XTy0T5FiyVWlM82vbr6pE0X+LyMwpx
         rquw==
X-Forwarded-Encrypted: i=1; AHgh+RqSxdzNfxifF9dq2XpNTu1luj9/EAQYQCjL4ZiGqfDkvJ1c5oBQd3xHum1hGN5KrF4l2W0=@vger.kernel.org
X-Gm-Message-State: AOJu0YySDnRlqA+eTBODpmP6MpiQzcjpD4cDCur0QP4dOVtuGaS+b/PZ
	sySTpUYrHYVQtDCP6CPM9/ASvLW46PUoL03VZ87z0cKe3Q3pDw79ipdcQT/+sM/rD2dNEmCc/94
	4jr4oF+e9pz5+dMmBx+X49ULQIf0lglI=
X-Gm-Gg: AfdE7cnW+3O6UU5WOTTIOffWn3+Jc5DX/cyz2lN2yzpGtzx4Kb4XYVupOUl01Ds8ldt
	AlE7cCZT4EhdmxeO34oB/qm9e+fQ37oUrl3rZsDYxD8VHAHBYtpKIYFXrAFKQGo1a60u0AjyiEM
	aMxVdbHObyCpamMlQhDF7Qspkmra0EgzWYgdCTxB8MhGlbsoVCM+PzxW7dsmpmYx4DKNGdd0hGf
	N974uvc+QNyll+ZeIaRYNIn6znxxH8bhEz2qHJlT9CD+qYKtCf1TzI1uGTzw4TbPbwa3ge9
X-Received: by 2002:a17:906:f5a1:b0:c16:1579:762b with SMTP id
 a640c23a62f3a-c161f3b54ecmr408843866b.52.1783959872085; Mon, 13 Jul 2026
 09:24:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
 <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com> <8d0323f4b30cdfed134ff2840cc8a9ab32f9db53.1782338106.git.gitgitgadget@gmail.com>
 <278df7ad-caf1-40fa-b5f9-34d78f435fd0@gmail.com>
In-Reply-To: <278df7ad-caf1-40fa-b5f9-34d78f435fd0@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 13 Jul 2026 18:23:55 +0200
X-Gm-Features: AUfX_myRlzUfxIrG1hUzKmGB2zUD4Fn_7r623gknkwWruMUGpDgwl0VHjV0hZxE
Message-ID: <CAHwyqnWFzdH8e_Z+ZLpv7GYQS3TSwjBmMCRf6Csk841aK7+gbw@mail.gmail.com>
Subject: Re: [PATCH v18 7/7] branch: add --dry-run for --delete-merged
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

> This matches what we do without '--dry-run' but what use is '--dry-run
> --quiet' if it does not print anything?

Yeah, it's a bit weird. What do you suggest we do instead, reject the
combination or turn it into a no-op?


Harald
