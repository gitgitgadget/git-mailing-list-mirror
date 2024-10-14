Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5461CF2AF
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728945347; cv=none; b=kVRrdQiL0a+tHV8yRDGpHKYvdVgECjByeN8o5U3m9EBs6NCy78/Mh+PFI0zUHsIwpeitymkDmxXjrFNWeYu9QV+PR2dTwP8C0ZhuzkJUg3LC2fs0H+fpfxONw9WSNN/ndEoBWrMtYivAxIljd9x4VXdCAu9il4ScQ2EXUvwt0RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728945347; c=relaxed/simple;
	bh=QO9OZLsbRhTwg5zJFU/IyLHSnYtcAv8a14i8QMtrTGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaBGPtc1w9nI0Hqmsp1oQaDZILhfJw//r4vMNsaB+NdDvzqoNqzzo7tUAi9g+syrN9h5RCryewQpK8oWA7EUPmadOvUBdwgpL9qT1hnFKdRZWDQiiGTVnXP9EIq71o/q9mur812t+q6c8Ux6oYrqh9R1qHCfE9POr0pGDrWpUC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=s5SmClxU; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="s5SmClxU"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbc28f8e1bso39291256d6.0
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 15:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728945345; x=1729550145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XkpUuq1tYkt7b8tic/XnOpYripD346/J8L08VNHpXVc=;
        b=s5SmClxUpqtvvElc1YL2AnPD691wm/Oi2cBAwUNnuW7bjR/EJMaJUPZHZs/dCADaL/
         LcsxVctjoB+mvlweRLp27USm8nDHYpeUlMu4aKiqgEvDxPW+40sClOGAEIzKxMcKIdUh
         ZDpuRRcTVN4Em2S1Hogn9puou6tbD1hPC6yXNb3RsfCkOK6YKgbJ8T4/GJLnJfjzJIQ3
         V8uP+c82vsJYFN9aq3Fy4txKiIfy4hdGq0zcsPdM7yrjqcYusbgf/ZuMmJO/OHZC2X+9
         dJtiW9iC6KJWJgSvyhaQmtZtYNAa9Dm8YOHW+bOMQSG0ZhcJDDfKlEMxUEYhSOog9axC
         qR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728945345; x=1729550145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkpUuq1tYkt7b8tic/XnOpYripD346/J8L08VNHpXVc=;
        b=JjW1uTt530VZzcrIgIxKk1eNTCzFvJ+D/f6M1CGYwJXK61kAmKjnQSeF32ezIto9Zk
         gpQNTcLvBC0w9YRJk3sGSgjRCJkmhA1fbie9wPmjzgXCGpNS2r+4dhfkV21pnU/bKP+p
         eLQBe8XScVn94NJ5X4tG2rjB/ZkDIN8pZDAU08Mt7HlOSKPD8VrAsMnesKGT0nJdeet0
         dierX8xcvMezvddUSygngNP9r4+ayo7gVth1UMq/jnR8j08ZTMUdxgx6Q/Ek8FcbDdru
         N6SCuI9jCYJVsvVxWtKspFsDT4UMEyaizYRErggP71qqmgrL1H0jfJuFrNWxBevFAJCz
         SC5g==
X-Gm-Message-State: AOJu0YzMIo2a0y7oP5FmFOjX7eoe8Mm7N/Ab9Qjxb2GBa/H16VuMIq+Y
	H8IW0gIxUnO8Tcfwu/ryEx6Xwu9NnBjnyixg60fT3OKt7LdOk1Wqm9g0I1Xs+b0=
X-Google-Smtp-Source: AGHT+IF/rH0hFyhHnw/+YSTCPwjzM8ZSc9wwZm0GthFGlc7sshSvLt7V1z7eX5kR8FGdzo4VWjJdzw==
X-Received: by 2002:a05:6214:458a:b0:6cb:e9da:bd6 with SMTP id 6a1803df08f44-6cbf0009929mr177435646d6.35.1728945344973;
        Mon, 14 Oct 2024 15:35:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b378b80sm188851cf.73.2024.10.14.15.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 15:35:44 -0700 (PDT)
Date: Mon, 14 Oct 2024 18:35:43 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 04/10] reftable: convert from `strbuf` to
 `reftable_buf`
Message-ID: <Zw2cv2G6ITf0aTkZ@nand.local>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
 <e1ff1af1f302490f8d79301a73f7cd48314477ba.1728910727.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1ff1af1f302490f8d79301a73f7cd48314477ba.1728910727.git.ps@pks.im>

On Mon, Oct 14, 2024 at 03:02:27PM +0200, Patrick Steinhardt wrote:
> Convert the reftable library to use the `reftable_buf` interface instead
> of the `strbuf` interface. This is mostly a mechanical change via sed(1)
> with some manual fixes where functions for `strbuf` and `reftable_buf`
> differ. The converted code does not yet handle allocation failures. This
> will be handled in subsequent commits.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/basics.c                   |   2 +-
>  reftable/basics.h                   |   3 +-
>  reftable/block.c                    |  34 ++++----
>  reftable/block.h                    |  14 ++--
>  reftable/blocksource.c              |   6 +-
>  reftable/blocksource.h              |   3 +-
>  reftable/iter.c                     |   6 +-
>  reftable/iter.h                     |   8 +-
>  reftable/reader.c                   |  16 ++--
>  reftable/record.c                   |  80 +++++++++----------
>  reftable/record.h                   |  21 ++---
>  reftable/stack.c                    | 120 ++++++++++++++--------------
>  reftable/system.h                   |   1 -
>  reftable/writer.c                   |  66 +++++++--------
>  reftable/writer.h                   |   2 +-
>  t/unit-tests/lib-reftable.c         |   4 +-
>  t/unit-tests/lib-reftable.h         |   7 +-
>  t/unit-tests/t-reftable-basics.c    |  16 ++--
>  t/unit-tests/t-reftable-block.c     |  42 +++++-----
>  t/unit-tests/t-reftable-merged.c    |  26 +++---
>  t/unit-tests/t-reftable-reader.c    |   8 +-
>  t/unit-tests/t-reftable-readwrite.c |  92 ++++++++++-----------
>  t/unit-tests/t-reftable-record.c    |  74 ++++++++---------
>  t/unit-tests/t-reftable-stack.c     |  90 ++++++++++-----------
>  24 files changed, 371 insertions(+), 370 deletions(-)

It's an awfully long patch, but was relatively easy to skim visually.

Thanks,
Taylor
