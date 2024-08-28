Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4476C1AC433
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880228; cv=none; b=RGp0xOcXMpUZrbnQEfCoKlCDPwMEJyXHxU6CwBM+n8JEPHevZMC1fUWlKS8M4sQjBxksQAcNRTG6RPu8t78IuDprzLS1aL0G+wnQY6zzylI657Uyr/2SMBvy8p0ahpRi/3GX4QrucJgLrDw7Z21yWA7IqK/vVGif6ckKO5qik60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880228; c=relaxed/simple;
	bh=LsUh+7z3jiJPOVeWeVe+qWn1SIZD4ufhinSQQy8Hg8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9Cku/DivFQohCr5NEr6UESCiZDCU8MiOvb3QoKcHlgZongN0PQuvp2f+e59r2e7BqqRFxV05nOdac5M0/IlPQKFizqSJ1Kray1MnrjdmRlgy/Ot1GFVrGvch/67w/QFftIzHQz0aWHRBwx6hRq6OJEYO90hbZvThqv+QxjmlCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bxGLrrnY; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bxGLrrnY"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20260346ca1so64185ad.0
        for <git@vger.kernel.org>; Wed, 28 Aug 2024 14:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724880226; x=1725485026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnrdUkKL33X0LEPEtTnWY64Z+ymCaXf/E5LOjYNH7c0=;
        b=bxGLrrnY/a+3emIR8JS2KOzJMU8Gd+D1C2HORZqfLpkpG0CE2TRaCiALvbP5Bv0rIN
         wl7oiasaIWcV1vYkV1jVLpt9Xht+KbHJdN/u60PhcjFPMEJhbc2UI6m0DW+kjskWtYCa
         ezg+VT1r86TzjllVjiPdUc99JFf0p8uiG4J6j22SVTelazFkLJmFaTvVob1bF7UK2eQf
         DxGKCwm0SF3F4gVNZ4qWPIXhhV5eLCtbeRgnm0lmcz0KOqe2FclLLz7M4AvU8u6J/EZp
         kfwmWEYLjaT3MzhnSU1tjyk80keXQbM5MZ2sLAapKraXiowHjwF4mquuRBGv0Uh9tubR
         AyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724880226; x=1725485026;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnrdUkKL33X0LEPEtTnWY64Z+ymCaXf/E5LOjYNH7c0=;
        b=JXS6GcU0lbyQ0O+7sxFUBpFMla0POY3NjqvDz1sNUWuSXd+7OSN3tdOy+04xUf+6X6
         OwkpyX+MmluUugAgUx4SwR/gUT5E6LMtGibl+PXjOwWYKMD9JKIE/PGq+gncg9lRPMR4
         WebS7uOUS0aGXYGOsIoi6fHa09X8gfSUgORnQCnQCEDJZgH7/sT7ksQaRyM7OyUbrH8U
         nh5145rappNWrsTfygwJYpHCFAZ05LTFaOI14eH3le3CKqxhj5MMHlD7uoNBlNqSOH4p
         73E++eLE0JgPbZ/G2PxsSML4m95+hPJToJCMKI0lc9jo3Yvn+DU1c+pQFg2DsI6yoada
         El+A==
X-Forwarded-Encrypted: i=1; AJvYcCVS1tkisiH//JloC8wIrB3jV7My8YlM5ZccXPxviiON4LDMKxBp/FiOLv5BjeobhviF4z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzFjJfm5iaXcqMnn5qFgQvcnbipdQeF6MG60geRX4wx8qOEmQi
	wguJunexnO1Ph66yRnugf89vOBpvW4myNUIM87rFi15Wz9/1D9Dp/LbKCB4UIw==
X-Google-Smtp-Source: AGHT+IHquoxvdMkQE8A743MTzKV7qMKy1TQPKMjuWLepMfWvFlCpukyU0A1/mlKhzb58MR7z1y7itg==
X-Received: by 2002:a17:903:22c7:b0:1fa:fe30:8fce with SMTP id d9443c01a7336-20510b5500dmr223175ad.23.1724880225875;
        Wed, 28 Aug 2024 14:23:45 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:70f6:9fb5:f5d4:421a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e6eesm103306835ad.73.2024.08.28.14.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:23:45 -0700 (PDT)
Date: Wed, 28 Aug 2024 14:23:40 -0700
From: Josh Steadmon <steadmon@google.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/3] send-email: add --mailmap support
Message-ID: <yj7at3g36nr2c5gr4bywp5vnvbt7bkel5e7l2boakua5hez2au@pc2f4o5ahmpm>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20240827-jk-send-email-mailmap-support-v3-0-bec5ba9be391@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827-jk-send-email-mailmap-support-v3-0-bec5ba9be391@gmail.com>

On 2024.08.27 14:27, Jacob Keller wrote:
> I recently sent a series to enable mailmap support in format patch. The
> discussion led me to realize that the true problem we wanted solved is to
> map addresses at send time, so that we do not accidentally include a dead
> mail address when sending an old change.
> 
> Instead of worrying about what the formatted patch has, this series
> implements support for mailmap at the send-email, which will translate all
> addresses, and not just the author/commit addresses for a patch, but also
> the email for any trailers.o
> 
> Since v2, we now have a configuration option (sendemail.mailmap) to enable
> this behavior. In addition, I enabled support for email-specific mailmap
> files.
> 
> The intention of these is to allow a maintainer to map the known-dead
> addresses of former colleagues onto a current email for an owner within the
> team. This would be used to update the send addresses to avoid including
> no-longer-valid addresses when sending patches. This is intended for cases
> where the original author is no longer valid such as when they are no
> longer employed to work on the project. While sometimes pointing to a
> canonical public address of that person may make sense, in other contexts,
> removing them from the email makes sense.
> 
> I believe this version solves the use case we have of ensuring that we stop
> sending emails with invalid addresses, and may be useful for others as
> well.
> 
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> Changes in v3:
> - Edit description of patch 1 to clarify lack of validation of email
>   addresses.
> - Update tests for check-mailmap, removing the bogus contact tests entirely.
> - Link to v2: https://lore.kernel.org/r/20240819-jk-send-email-mailmap-support-v2-0-d212c3f9e505@gmail.com
> 
> Changes in v2:
> - Loosen restriction on git check-mailmap by default, rather than
>   introducing a specific --no-brackets option.
> - Re-write commit message for the send-email changes.
> - Add --mailmap-file and --mailmap-blob options to git check-mailmap.
> - Add configuration options to git send-email for enabling mailmap support
>   by default, as well as providing send-email specific mailmap files.
> - Link to v1: https://lore.kernel.org/r/20240816-jk-send-email-mailmap-support-v1-0-68ca5b4a6078@gmail.com
> - Link to previous "v0": https://lore.kernel.org/r/20240813-jk-support-mailmap-git-format-patch-v1-1-1aea690ea5dd@gmail.com
> 
> ---
> Jacob Keller (3):
>       check-mailmap: accept "user@host" contacts
>       check-mailmap: add options for additional mailmap sources
>       send-email: add mailmap support via sendemail.mailmap and --mailmap
> 
>  mailmap.h                           |   7 +++
>  builtin/check-mailmap.c             |  25 +++++---
>  mailmap.c                           |   9 +--
>  Documentation/git-check-mailmap.txt |  18 ++++--
>  git-send-email.perl                 |  20 ++++++
>  t/t4203-mailmap.sh                  |  42 +++++++++++--
>  t/t9001-send-email.sh               | 122 ++++++++++++++++++++++++++++++++++++
>  7 files changed, 222 insertions(+), 21 deletions(-)
> ---
> base-commit: 87a1768b93a67d0420255a43d9e07387b2e805ad
> change-id: 20240816-jk-send-email-mailmap-support-1a9e86867c72
> 
> Best regards,
> -- 
> Jacob Keller <jacob.keller@gmail.com>
> 

I'm not sure I'm competent enough with perl to review part of patch 3,
but other than that everything looks good to me. Thanks for the series!

Reviewed-by: Josh Steadmon <steadmon@google.com>
