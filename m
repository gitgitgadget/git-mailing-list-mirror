Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119C81EE7A7
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 21:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814074; cv=none; b=X7tI/W766vl2O6MCgDKsX90H2M6RLDfvIYkHAUDZgpOVu7AA/Y0yNXN0Yu8ifATQmLkSx7gV41w9mkWFbNg6z33Tih02c5A6268w0G7kwUla+T1jmSXqvrZjlwSytug/xOyb4915hLO2uill5Jl77IVIHc9TanR4HPKFagXRlVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814074; c=relaxed/simple;
	bh=DXwxrGtqFECOSdLZDhoVY+rop7WTBWHWJ6UhC3Ul7WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrHXVYad5oV7B8CzNcAbrMqdV2FlyXGjn1nR0vKHzyVYqs8KmOtFAvJzZgM3OuyuzZiLyqJnRffPRez15IVNqR8oXBsGhGhUefRvTJowiK4Y61jc1RT8mE4XX5b1ca3iVvO9bi2dc2uA3eQll2ON0YCkyScbtKEAMFZdFlcUnP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=hqr5xT+F; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="hqr5xT+F"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6fd8be1e534so3164577b3.3
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 14:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741814072; x=1742418872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PC/hOQAZ8a8OvuYwc/DcZR9vXV66zEPQb0ocdiUsd60=;
        b=hqr5xT+F6YwbWz6DJyhHEgzupOO30qCJj6lRyHgDFsHlyiKcID1bUvPyyKuHamcBOS
         XDIV3ynqVZ5hvg/F5kOtStJ+zL0+p2lNZ0KNKDslL1pW1FR1nxSYbaHxcFMMZ27CFMDo
         J0dl4bPBB+QpPPgk+qK+cr4+b/Ni+o5FNTne1H7Yws7trzxs2azIU+DR+do/0oFHlj7C
         suFwUH1Yy7WahyBN/wsg34WUUr1GoUV+Qc9uuwtdS+vzSXm3p/5tFXxFjYChpg3x+lYU
         94oX/nHVSUGTBa88KHY3dPKcsaZjWF6XX9MPxBs47uo3dH2whebcct1YDKfnnxUB00CQ
         y/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814072; x=1742418872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PC/hOQAZ8a8OvuYwc/DcZR9vXV66zEPQb0ocdiUsd60=;
        b=osoNdM/4jM8uj6BNJyIBgTkgFixfo1znBMMMmOR7g3YyYK5kQsUE5IOEfgzAulM25v
         BwUijmgE0UhQnH+KPn41JRLsdloz/VHsN9m5W8ury3QK822waPb9UkS13ZAv1PK+k6md
         9YEHTseTVeUYYbzGgLFLCi7hPPcRD5vgfBvPC5F6fr34YXyx9f3MQjiQB6qn23LYr0+w
         RcmtdnJxD21DDQn6x2LOLQf54krpSySlysBD2Gkgs+qlbLJlIzNIMV0Invg/gpQ5V0R/
         Je3p4Tzr/MC8rJwtQ1XlzWTUnQKgC0MkMrZhuXoc4mbO5MlOHegwZrTO/Kek2kl18mFN
         G0gQ==
X-Gm-Message-State: AOJu0Yw/Q37ktOAWmawZiN+BaHeMcc93W6iB2ZrI3eivqxCwU2nQFlLe
	Ka22z/PyQa7s8wIagPQ3gv1+6ot8nZXBgG53Rivm+voXw9O0s/rvJjzZtog5aho=
X-Gm-Gg: ASbGncv7+kzt/Rlbno7I2sLkotX4ZKD9DJU7Yx6l8fuZ0fOvry42gt6mVSgl2NqAdo3
	CDsjPTynH3JhgS8mGj+aVfnjsspX1mwXKgPv18+s+g4+nO7ifYt3BCOB9qiTTGYH0nrg7X8kRgz
	BHt8Xj/Wq9rKwL8QPXb8UWinAqfYKc+Iqdl0E22kK+klni2hwDkuUg8TXXB4kU18RHPa/Mtktt+
	oR8gSk8FoxSsfF6VsdJwESl40jWMnMDG05msIeB+BRXkr8g0j80PlXxnvW7kY1TgbJSDYKUdWCq
	SBdORLy6sTVARjmdd7GOiHnKi9PFXnn/BQS/tfdQIGaz8GEGUqKPFtQg1bug/L0MIAqPERHy5jT
	wQQbrST9U82BO3KC7
X-Google-Smtp-Source: AGHT+IGZmic7b9AA2FMQBaqFJYjPskodou4NBGOc2jdnwGfZHIpavgwc6QEWdySyr/gOg9/oO6yACw==
X-Received: by 2002:a05:690c:6089:b0:6fe:b7ed:9715 with SMTP id 00721157ae682-6febf2d423dmr356544237b3.11.1741814071988;
        Wed, 12 Mar 2025 14:14:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2a517f1sm33435207b3.31.2025.03.12.14.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:14:31 -0700 (PDT)
Date: Wed, 12 Mar 2025 17:14:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net,
	ps@pks.im, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 03/13] pack-objects: update usage to match docs
Message-ID: <Z9H5Ng3niRodVp9T@nand.local>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <bc678acb109c34ac96c641c5e6fbfb418e447010.1741571455.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc678acb109c34ac96c641c5e6fbfb418e447010.1741571455.git.gitgitgadget@gmail.com>

On Mon, Mar 10, 2025 at 01:50:45AM +0000, Derrick Stolee via GitGitGadget wrote:
> ---
>  Documentation/git-pack-objects.adoc | 14 +++++++-------
>  builtin/pack-objects.c              | 10 ++++++++--
>  t/t0450/adoc-help-mismatches        |  1 -
>  3 files changed, 15 insertions(+), 10 deletions(-)

Thanks for cleaning these up.

Thanks,
Taylor
