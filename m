Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E82741D22E
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375898; cv=pass; b=tIOnpI3L/K6VYFWijE4peH86f2qGN8TqxcNovuwpINF7Wqk3DSiFmXaBYz+BfUzXpCar66bIY55P1C7RUE0EfY9UIrNJxpYGe3I9zkmtTLn1zZX/9CIO6da5WIoMb6NTvsl2jm6DwvpM8jYnyubClc4AV4NbHzmyqITWYzrmMW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375898; c=relaxed/simple;
	bh=kagAgD62/LYveFlHE4IspH3QeFGQ5yjMz1hzTimylzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYRb0UwYJqiuCR/3+qj0cm4S/N+Z6e+dHDRcxiwX4OFfpri2hPWwHSPoP0kUTouQbibyRtNjU9VqOUogr0TcBWbTQwCgY8JzipgIeO3nC0fZ8llDi84XOmaOtXAzZC/zFA5eIPO4eVscYpeLwL5huj6JDbO9vhgUXw1VNw/cOFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSyTlqsQ; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSyTlqsQ"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a60591ae54so3528987a12.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 01:51:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789375884; cv=none;
        d=google.com; s=arc-20260327;
        b=qwUaCxoFkzpqbv+SkV7wMUkByyaaEs2CFu0mX+JqmMDavRlR5eI8AgsG5k3xNtGGl2
         eA4ByyFZCA/TLAZbotoV5BeA7pIWUKS7m4RP9jp+4TpNJHzppEqo4iVdIkC0aV36Sdng
         W7DitZQupYfR4Ti46ZqvD7wje3twVtfudgbAi4rE8791xdHVwH92u7AHMQ/sXUDTUQqA
         JCyWSBtbCcWZeDDU/3k1Ab0Ytp5/oruNI0slo4uPjtZALPkIY3CB7MvzvrMVsxTjirlv
         3LIVh/0kTV8jlEW9xUJAGNYudkmm2L49TpsCisFN4EeH64J58qBiZLW6iPDKOc1Ath3Y
         hHgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kagAgD62/LYveFlHE4IspH3QeFGQ5yjMz1hzTimylzM=;
        fh=eFCyRpiUlcaDfQVPSzqiiojE6GLwlEUvPRoj7lAcAhU=;
        b=nRTED5c3WwvggQcy+NFmBvBVbpF8R35/dS7eDI4jqq8w3ZkDl0hu1DcZaV9U5MiNDy
         YVl6D9dPb46sl9oV2EgBWFy4Von9lBDi8At97wo8lF4cCYjpUJJyM/8evXfA5Pntyz9D
         ufvIdV63zBFrCRozxKr1qZtSbODhotFZkk1vwoCgShZriMm4ZIPNUDuUtpkx9V+zSdpM
         bgPQDHJRqkcb8Zu9dG6wygoJ/z8I86Cbi8srtTDj0vzXPeiaaFwo+MU/0ZuL3pkwZt43
         NdOF+BdANe09Oe3eJv9hD10ClTSHbOwiGxVNhVRg1uU2f4nbvNM0NAMTPFCTtVPzkg3f
         KsQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789375884; x=1789980684; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kagAgD62/LYveFlHE4IspH3QeFGQ5yjMz1hzTimylzM=;
        b=kSyTlqsQ46/A3oUr5PBxEwGUGIbabO5nIOeCrEbaFbyIjB+HWLImu0R5X5L8JMww99
         nM/0Bn51XVFqsCP8+jYm0s3rEhr4UpWeX+vxooUsjEA10BUNeRWI63WLuZJVgAAhfAb9
         tZc6n6hI/GzAG5K/dSAXkw9a8DfRF0HzilRtNG/ZPqGwPdnVtieP+ujBT+pnMrAYTm6K
         3KvoWpaJ2GwVw9IF0UF+p1LBvFEFyV2xKzFKBg+I1bierQi6G9Cj+7X7mNRDIHOWmHTy
         ZPAz0Om0bmz83UPAsi/qPWt76okVapoUExIqEbGgT1Rf1Lj9gkgtW6B2dZaMjS+JL4/r
         SZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789375884; x=1789980684;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kagAgD62/LYveFlHE4IspH3QeFGQ5yjMz1hzTimylzM=;
        b=GUIX1a+SqoX1tAd5aATVcny8HUD3URyT3wISkLpTDKbJ5LeQ3Eo/CdoBn3bm8ISYQV
         c2bv+9iHiuBJwQh1JXrlpu9vJUyyACRFFxVhXmnqdUYwHv4UyUK8HyTe+VTdEaz4L6TT
         BoQ9L4DzdNkFjYGLGiPtcyXZR6ERVT95W3yq9ImoZn5+32/HGN6YJcY4cPuQ7AgwmfSf
         OueVRMxVU9JeFwoB97jDZnMtq7ZzfiF9uSBiy4f6zZFOQOqgCKKeJtFZCx1KaYzIldj9
         sMXZy+KHRqQxerLE3gh+KaX+Fb7kuNy6Ip/0CjRu8nJtD5yD9tNQWYnLvj2zCyyIygk8
         WH2w==
X-Forwarded-Encrypted: i=1; AKwUvBwvy0mIC3MzlEECFJba+VIDoL80DzTgF1YGNaFUYLZDwn9Dg7jj+/dKMhuSX6IOIJ4LSBU=@vger.kernel.org
X-Gm-Message-State: AFuF++miR3rWUWTxVppdH+Gc7Z2UDoAIh8O19W5znCmGs8ElP7onb04A
	qoZ5/bGXQyamDocjyqrTEZbVj/u+4/9xhTS8VIpkQVOqsLj638xMzJ7BhkruB175azgWX8W32Kd
	GMIbqdxUqMEs4rSKnA8kBjqWsCPIjPeo=
X-Gm-Gg: AYBFou1y/zFD0RY4+4nbzZ7wn8ylHI7zyrcaEIqeZpwkEcl5DOYZvhp713NxqX/bUWW
	SD/6fM6U84yUalNpO3xZw5to2XAznz83CCnS+ixSfMxbhOeJAXTL2Q163A7YCUhyaYbMIfMqjyD
	uFPTH6hptSLikLa9rnGpio3i8wuAec7v2m3fEPJPmDMmBW16tlUMsy/q4spBKJUW4wikJLuqOyq
	IiZKUs6deFeqLcXxc6lvefKGgmGIy2x1ezSfEDUbdj1EcaOY75JzG7rltKZd0fBHILmzVKs2vwV
	fFPmu/W0SPJRBWNGogVU0qSjEbWauQQP8IyM9iSqsbevFcBeKxmZnV8=
X-Received: by 2002:a05:6402:24d3:b0:6a9:a281:ca8a with SMTP id
 4fb4d7f45d1cf-6a9f6379705mr1768305a12.20.1789375883564; Mon, 14 Sep 2026
 01:51:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2402.git.git.1789199739368.gitgitgadget@gmail.com>
 <aqeTas30Vs3aGE9D@pks.im> <CAHwyqnUG_ta=m5e7rk-35D0Dve+GeQX3eNuFf_U4kSd5+Sqy+g@mail.gmail.com>
 <aqen3lVdecDqo89w@pks.im>
In-Reply-To: <aqen3lVdecDqo89w@pks.im>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 14 Sep 2026 10:50:46 +0200
X-Gm-Features: AcwNN1X_aw9mOPN1nOoh8EIeFyQI8gQ2IKNstqOB08U3LTd4GAAqEH3ZqCpNqfU
Message-ID: <CAHwyqnUESiKcfrUM_vrOGY0EKgcurM3bG0wSOtboB4Bkh-cfUg@mail.gmail.com>
Subject: Re: [PATCH] ci: drop no-op gettext link on macOS
To: Patrick Steinhardt <ps@pks.im>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > It passed on GitHub: https://github.com/git/git/pull/2402
> >
> > I'll take a look at the rest of your comments as well, thanks for the help!
>
> If you look at the pipeline though you can see that almost all of the
> jobs were skippped. And in particular, macOS wasn't tested at all.

That's after I pushed to update the commit message, it didn't
re-trigger because the code was the same I think.

Here is an earlier test run when macOS tests were successfully run:
https://github.com/git/git/actions/runs/34655661080


Harald
