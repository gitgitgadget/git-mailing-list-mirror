Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05041DEFE8
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185955; cv=pass; b=doHwsdst8lEp+/OxEPzixwVpH4ua/LgjnMhJn8ZSNxaCxFNaNZRsj8sZ6ezhMOrti7FOvNO7Hq3l1avha5y5mSU69YWO9TqPI+VO7QlXBwfZJGvw7e3fBZdx/dfL1V/adq9PiVXZN+vdNy/W6qSOHMiAGa41je/tQAhq59vnFd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185955; c=relaxed/simple;
	bh=f/Yay6Hpg6TGMAUoV/StdAEQj2dPbb8TzfUoF02xDS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5szQB3pMgu2UJRW8/VUIMMmu1xr1ns5nkiS84lcZC689HzHKw4H/eKFBiW36z7FYmztZZn/USf4sf+JykMOMJxNwftHqZsgIMyADAIycINO9aZncer8m/1BR8QBb0BXr6s0zZFbN/wXEDmSjIaVjFrCbp0K/k7LoDW3y9WsMNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=NUy6bZu4; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="NUy6bZu4"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7ea6923cc94so83690697b3.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781185953; cv=none;
        d=google.com; s=arc-20240605;
        b=NlkK3WdH3ObpjYeGx15yhSGjiPgmLhGaearsyX/bMfPBCsQTxdqhuExqbA/ssNDANO
         Vbve3t8PnEp7xyRg1+CU32Cjf6nJ2pTkk4OmLDRt0xX3DD9lqFhhJglAT6PnNEDGTdHL
         O2Ubau3u4t91E471RlRH6pJD4kspQ3NaLridzZK4niSyBoTdvRJ/N7HDUxsAw3sYvkM1
         Av/6C2N4zounFWyTzUn0LtI0K0zC1wtMpRcATCfgzvMrhnGmk2nLFq1yIQhNdT3BWd2u
         ycfyljQc1WjCD8qct9uBZjRNliz1A4BhaWdDgZYV75ypHAEQSAWoLyDeJzTUqcqDNTyj
         YYeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f/Yay6Hpg6TGMAUoV/StdAEQj2dPbb8TzfUoF02xDS8=;
        fh=dihjdKYTUKh3psE+Y1nqQFhzCEvmIOdPmp29lTu4jSA=;
        b=jnx8Wy/WdkXgmNgQBytT2NqhJoo6Vt+FCqM5YatlFURfFeG3jCMskqCPR/iAccMjM1
         6RHk19PegYqRWGZZi4gusMUrFEXzzn/hU72qz5niivHccw0wdqxIbz0jTw2/gJPUeK+0
         0Z9UJAXFaRC7X/atMpbp4e74goSD/4pJnerPWwNsQ2SHv0Dn2TlFg9afAZOrSunpRd10
         rT7fvR6TuumL/Gtkt+wQAv/DQbKFB13Nd9WlGzgLmE8vP+6bZ0gAyO4/6ghlq8dIH425
         AU8/RDZXLPqNgaPQrzcfomMOKYVeh+BmVjns5WL1BGQOw4dAucscqwwtiuunQQIs1OGr
         dMEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1781185953; x=1781790753; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f/Yay6Hpg6TGMAUoV/StdAEQj2dPbb8TzfUoF02xDS8=;
        b=NUy6bZu4+/mQwG1Esx9vHWBnbRyxkFk0r/d9taQEfdLT6YbLt46W8Dbl47r/43Y87t
         //FLXWdnHJsRjuML4H2xdDgwHYv1hDPqcXqTZHxCtGeinlQ8FcVunivyrNpNH9RfcRVC
         KC9P6zDxHFJ9w4vBNY8MHfA3UQJCe437zzxBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781185953; x=1781790753;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/Yay6Hpg6TGMAUoV/StdAEQj2dPbb8TzfUoF02xDS8=;
        b=kjoYLBjlo52GHGmMMw4NMB/KzADKaoRUYxlMiRPbLwnxw2QPQzkkBuYX8JRauuyJed
         Pjj47298A7gmaK1jkb2k2hX9L8lFvW+Ciu36tXIOTs6poUaVsTH8krbrmrLHUuqO+UDL
         seAgILYjBy91lucdhQUzXe5HQl70UOHL8Jjx9prZvKiaoRlv66YdLTnzI8UpPY8cMowZ
         p4ShKIJnv5PvKL7TfevIXCaw/RHauDXSR0LhQWSoRK+ntMKjur8LH0C5n5sYbtvDSGZ8
         95FHuzJrVnfDXzO4VSbsOngul4ww7ZJT4vQ46w/noMyd45X6uiDQ9qszYjnv0IrdUT9T
         r/XQ==
X-Forwarded-Encrypted: i=1; AFNElJ/DaVTNyl4eRjYUCM4tMLxhvAPhM8i/DRN9Qo5ZHeTqAjQUxgm0jRWXK+yJQGoDUnpk7vo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs/4g/Gs5P2FWM0SsMEA+kdR/cEu6WjvhE+Nys3ZYwzY7UAfnk
	82g4PidO22OCyI+vrF98e5OWSEAxdO8tEyFXyHL0YZFLbLpeuZK90idoNuUcfrRPtEw82ruVSo0
	KFFUPbX3u+8t1FOeO9dIH+lMisLhhSJXidIWakbZp+VGMdPfpFB3+qbA=
X-Gm-Gg: Acq92OGCUjnVEzIVftfdb+DaRIjppdjG6TpP9xuBLXLHttEcwOmGU6ndpkSGGyFF5iC
	0Va5tBLXWorvzejNAOgnzidp4nuuP1C67LdlLRod1xsNIE3wkpo+2lYppIrXQtUxk8bbjmaJOJZ
	rV8LGltcgUwOn1vY6i0c2x4qf9BwvyOVisTAQ+q4WyK7kWdzrUbV+mUxALu1G/HeCGWNUfkfJud
	tmXPeUEXyVPFe03Q1wKba8GtmyLtc1XtFPv3TBDQg+pYBs4st9uzKhH8DPfAbHACdPs5q+l9YyD
	M3yJxKZYDJWB9aqT2A==
X-Received: by 2002:a05:690c:ec9:b0:7bd:a50c:4554 with SMTP id
 00721157ae682-7f6559e6d11mr29026207b3.17.1781185952698; Thu, 11 Jun 2026
 06:52:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2144.git.1781033285419.gitgitgadget@gmail.com>
 <pull.2144.v2.git.1781178567862.gitgitgadget@gmail.com> <ffaf26b1-c55e-43c7-84b6-f810a54f7717@gmail.com>
In-Reply-To: <ffaf26b1-c55e-43c7-84b6-f810a54f7717@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Thu, 11 Jun 2026 15:52:21 +0200
X-Gm-Features: AVVi8CfI5NfIVdlWnvptoDiv8uhlpeXa2UKP8kXUk_YkiPN9craU84mr8rkXdUs
Message-ID: <CAL71e4Nn8Lk87A5=t1Wu=SStQqzmFqad+pcyOw_Fu-PLpRMq_g@mail.gmail.com>
Subject: Re: [PATCH v2] commit-reach: remove get_reachable_subset()
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jun 2026 at 14:57, Derrick Stolee <stolee@gmail.com> wrote:
> Finally, a commentary: You seem to have a habit of responding to
> review feedback only through new patch versions, but I'd rather see
> some thoughts in the discussion thread as direct replies to the review,
> especially if you think you will change direction like this. Saying
> something like "Maybe I should update the method to have two walk modes"
> in a reply would have given me an opportunity to respond and perhaps
> avoided a new version that went in this direction.

That's fair, I apologize both for jumping ahead too quickly with a new
patch and also for evolving it into multiple logical changes
(both code removal and complex refactoring).

I will be more mindful going forward about letting the discussion
settle more before submitting followup patches.

I have no strong opinion on how to proceed - either park/abandon this
or go with v1 as-is. I think you're right that having two modes within
tips_reachable_from_bases is reducing the win here unless the mode is
truly seamless but the abstraction does leak through a bit.

Thanks,
Kristofer
