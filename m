Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24AF5335B7
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955180; cv=pass; b=Jz7bisL+5OzZN2U9V0ZFVgaP0R1HfN/lbtY1WDNGCfvOv9kwgDeg0SYM6kkGNHSiMsmyr8nDBQ2yRJMwcHN9u5Lv2SJ866zQxeFTwIPCjYMUo0CGWl8+UYM8iZxQOtVNnOt9ZNtCvlPLKY3eRJ5Ps+8PZdHz3YxPXfLKiOj3YXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955180; c=relaxed/simple;
	bh=1BzPN7fe5I94y6SGACRlFWrn/q1uBX21AE8s64keeoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oic8FW2XYbS9ojxhazUFa7MB0ssb6y2mqnYudYFXsttIgszinWY2QtRhmOtigJC899vfqryYudzbNL/xYm7Csul6Xc09PBq+PteGLj8pIckWR+2J2cxhq5RmEiHXgXUpZmm7bz3wj88+rVa1n+Kd1XfRuI/Wwxxsi7YD2tgGCxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REerg2LF; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REerg2LF"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so91968a91.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 04:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788955178; cv=none;
        d=google.com; s=arc-20260327;
        b=oyoXdaL+jG1L/KZKPr8noh2A8VFzUbsP+bOF1LuRE/uj4vW4I0Twz8XSxqRsnfBebi
         rcy3rOC8ODn1/hqUJQl5SyfATSbBdJpzIJ80//dky8y/haOVZvShrr8PQ2xgsFmd9chK
         teMmwfsnE7TW645wr0fj3RnpcGo9uWAWV1CrZ1bKKQXVHEPpEDPP9tSyDJFDH2Uybnu2
         UTbvM/LexZgkM3mwQm1buClD71pjewY3zBn2W9Bf3KiE60t3G5W0vBv2MrhcV1iqCofq
         /9mXtJPQ5ikTv+NLA77SE6k0i1s6feRVBXVlXQzI+w47g1FPZIJkQ61J7BaAfIzrRRB7
         NQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cGUTn7vRlsLD55NVIWyy+E1n87xfH5JfjWoNYyZw5xs=;
        fh=7SnmKOQODkq4e20rl3LLSfm6mhdBKxnqqO99/bzjX3U=;
        b=pl6hnRczyEASEnojL/nEaELYDk1dT8UJD3d3RYKVIo5/QnjoVyeQdilaSt9Yq90x8C
         W3kQdg5j8T9SpbogqTzqHIM3LfH10XBZi2R2SnVXRyXD3JRBooZcK4+un5hcg8Q+qOTv
         RXkqmsQSy4lUuZv+h5qF2FTVl0JJdIFkZjH5fqp7Yqj7ZECzF8Gcw+DfPRLyuy9F020t
         XcfCxsmEZNcC04WxPO6/cMq2m2w0hptZ2CvkgunXW1Bl6j3a2oh2gooLuRC81RWOMffD
         YGhtrnTC2/iduS6CuHX1DA79o9yWSd1cO81GxXk4sQWzUXyXU7RtrP5250F8YR1Jy3a+
         jm9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788955178; x=1789559978; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cGUTn7vRlsLD55NVIWyy+E1n87xfH5JfjWoNYyZw5xs=;
        b=REerg2LFAbmdL/aW/Y2MTKaLsIEYNkSxzyukhfbRugkC6XU4oQ6pomdg8I3FgFp8pS
         E1D5rJsX+FCvVVuEtSPfJl/piNzcf7ydDQUn/lE/Be5IQp3txhhLy6SmwuvoT7+xundN
         7Q3/19ejc4DQlSatJLfyUrSuIr7EAq/o6hNQW5zlUng4kr7MniIwKdW2dM+aEOC/EiXv
         nvBZ1Hcge+o7PFGtRnP4y3aEPEbJk8TX67VMlglCajLf4riwt94JmUHqvx2MM4ifUjQT
         iJmTMmBZHEMB6yigXE2iddhmWHFm/JOYv2fbwoj31xAdW5+1VYRZKsGVgN7GHWrtpDVK
         dCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788955178; x=1789559978;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cGUTn7vRlsLD55NVIWyy+E1n87xfH5JfjWoNYyZw5xs=;
        b=h+dSCvzp5e/Q7p1j52OzZKIjZInCspdF8e7XF1GW+n3vLsjJlHBh8CkkV+/pxKxdCg
         2gmDFRI5dq4+5Y4b/q55KEQCV9UpJUSjTLkl8hxLuqOi63r8cvONpuW8ihfCiVbPBeUN
         ztApM7lYzamoMjouVN9zhloKi1G4GiaX7Zx9rruXU+5/meoHuiYYyDI6lZn+I0bRxGn5
         qCSKxM4EfueFbcXTX4nnRaoYyIy1G8Sv5BvDudYlWkyMKcHjSmplSQsazC5oA83W/kEd
         2WRw1k89WZGQljBLsGXamSFOyVwRRfPWkG7w9bfRLs4mNaO07D1OymMiZfhGKmAT04gl
         DbBA==
X-Gm-Message-State: AFuF++kStYAz75ZQeckIPBIiZsrzWRvQIb5wIV209Qxigs1Fesla0s3V
	loKplNQOTNEU+EXQ5NdD7vJKJycL/JIGB1PwtZ1EAF47TKL+mtGrpneErsGF+RW9UaXW7WIfKfS
	LDBruJAki8tWfrm9Xz+zhYg+o4mld1uQ=
X-Gm-Gg: AYBFou2H5DJx3RpHrRz//bmrc2rbJyNen6zfo58U6BIuQuBHqXLXXMcCRj/BLQ6x/ol
	wu4g+OWWjdMRdq3kRv2BZCkm+65awGJpnb7E/OC3+2LqVAqE2ZmTKU1MdxtHVw+mAQlCnor040O
	CaM7qCgjF/9e/drAWCpPypubYXPNxtb+bOvFOGFFENqvTtiQoPyJQB/leaH+yNYdaAHD1KlzQA8
	NUHI6q6PhlfGhxzlfCqHENRl9yteyW84UmwrAZo4c0eYN7DOa9CKsoZ3uK+ZdhrjfQGG4Dwb3ZL
	tvJ4/ZO0VfJKt7GpNOA8QZRSJg0EyXGMW6oKkbjahrBZOkGQdZ821CjN6yPot+fE5mpPVzhLu7l
	h4eGTWy1R2pu8qqpUagf4mkGXWWQtjeCdc2jGqxSRf1W45R8+MU5g6N4qiP88keHVAwbEE0qBBO
	NmBLjeTtNP
X-Received: by 2002:a17:90b:4d86:b0:38e:6aa7:68ad with SMTP id
 98e67ed59e1d1-39d70980956mr556576a91.5.1788955177907; Wed, 09 Sep 2026
 04:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904210122.431757-1-tyler@tylercipriani.com> <20260908222056.1150748-1-tyler@tylercipriani.com>
In-Reply-To: <20260908222056.1150748-1-tyler@tylercipriani.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 9 Sep 2026 07:59:26 -0400
X-Gm-Features: AcwNN1XIP7H6LqPa7ITcMoB5POcZLtzG78i_OZf3ztrHif0Bgub3GJ4_muA7VCg
Message-ID: <CALnO6CBY32FpDoN5hTA_NK9eRKV-rVJ6BS=+8H1GEz_wNbHbYA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] push: fix --force-if-includes consulting wrong ref
To: Tyler Cipriani <tyler@tylercipriani.com>
Cc: git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, 
	Stefan Haller <lists@haller-berlin.de>, Phillip Wood <phillip.wood123@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 6:21=E2=80=AFPM Tyler Cipriani <tyler@tylercipriani.=
com> wrote:
>
> Changes since v1:
>
> - Clarify in log message 1/2 that --force-if-includes will reject a
>   detached HEAD today (when the same-named local branch lacks the remote
>   tip). And note that this change makes it explicit to always reject
>   the detached HEAD case.

Thanks!
