Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4AA171AF
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442937; cv=none; b=thHTImEEXGZlSpOzHEvuI5qzeBUabhN0Tz8XWdvAIdCsMNvnNB+qUWu6PexID/CfU+nUEhEBrXBU27oMEY/rQxQnRuPIgbLfsEk4psl5I5ygyGplnjX7QfrQmyLI0Tm31sX+NGrqJUFkc4pbBoSRCCY7OKiu5+ZA/djs+GFIpMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442937; c=relaxed/simple;
	bh=lupL1WMAPe5h3dmc/Y3JfymRP4bcygryGou/WYWycH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vgc/PqRigy+oyeRsZjvKrqDmFYgJv/ekKCBhrKycUiXnZvmfX+twNa0AJMVLguZJA0JYAEBw+cj6VrOl1EcN5n0l+mArMAo6USQAismmqpXtV4hQVykGc+NhURgJ3neFaubBSIu+Xx65Lm1rT38m4hkShdtRj837DjwnWPv7zbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ObmUh4Uc; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ObmUh4Uc"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a1d436c95fso359610585a.3
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 09:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722442934; x=1723047734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y20wTPVfTpEVZL2ngAe9S5xCvT8gcLXp6UNH37ss/pk=;
        b=ObmUh4UcYvc3dQDJ8ePgnyCHeQNsoa1qDPEPwaZtKLNutHxcpGJK8EyrUZWFUYoCOP
         HdrMUIA8i6LzHbAC+lKlLb4LKut05qrCGn5qX1ZuYQRAsnuoLs/v6CAlgD7YAXhFNS0W
         0zebRx3AcTBufjOduiult2vEx1qPO46Ur34rHrN0ZxJnzSvLlb4XrpG+smOqG55jdjXR
         RbXNqStSQ19Ul8jrxCK59AKnI5pwyUGFAl81YIX7/jhVcN8RT0TYyHNB9nmu7cXFR6E/
         wk+fUPoehulvc0Oll103t5aBVEEA95hSbkijLpzh9abYdRWXC8yFjY9YepPRdX6JUy07
         1gwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722442934; x=1723047734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y20wTPVfTpEVZL2ngAe9S5xCvT8gcLXp6UNH37ss/pk=;
        b=r+JWmkVi0Q9bxvnGUSq9vKwkigKcK9IJ2Ze13o+eUZIyKH98iH0hWRDnEVDsjbxIhd
         5sQpmlM8lM2X4dbE9/vrDgYmV6kxu1Bs3WMsJO6b0loPBEgoI2OTUjjXZS2HelkZoCTK
         uc3Iu14WnfajSch04KRvQJQnlsAQBwtrlgPIrAZsBocnieL4hiqIvnkkL1RzBTEbagq5
         iqu7T7phAZp7EzPgw9hnssAQssSATUFly1ZRrdMiVPk0xlg4TjjuiFkBz42N4kaXRroe
         V1GPGwLEpVIztUrYjqfBrBsKFdZlQ1YMRTzVhNPyS0zjVdBZ4e5vfHklcl+054JSEmAU
         Rizw==
X-Gm-Message-State: AOJu0YzV3kcVu4I7ZGTyhIND0Bl+zJU6RMTyPUitAoq1KV+gVxuDAW+A
	g5rYJrdqK9TRkAaTegYIUBTBEoj4MnzeuEdGNanulcK3+1MEH2+WjLBt+VMLtM5LrSzmJHmqcCw
	z
X-Google-Smtp-Source: AGHT+IG+Y9p8faABRh49/lSf8Opn0Eh95zZYfUK34Cez7hI7yhtZNyfXtq97IMi2Ii6yhbIDhR0GDQ==
X-Received: by 2002:a05:6214:c6b:b0:6b5:b29:82d0 with SMTP id 6a1803df08f44-6bb55adf3damr150735466d6.49.1722442934370;
        Wed, 31 Jul 2024 09:22:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8d8412sm75475226d6.11.2024.07.31.09.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 09:22:13 -0700 (PDT)
Date: Wed, 31 Jul 2024 12:22:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/23] builtin/replay: plug leaking `advance_name`
 variable
Message-ID: <Zqpks6Oi7I4TAk2f@nand.local>
References: <cover.1721995576.git.ps@pks.im>
 <dd044eacc2b20c3e426f5825fdc30f4db6618052.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd044eacc2b20c3e426f5825fdc30f4db6618052.1721995576.git.ps@pks.im>

On Fri, Jul 26, 2024 at 02:13:59PM +0200, Patrick Steinhardt wrote:
> The `advance_name` variable can either contain a static string when
> parsed via the `--advance` command line option or it may be an allocated
> string when set via `determine_replay_mode()`. Because we cannot be sure
> whether it is allocated or not we just didn't free it at all, resulting
> in a memory leak.
>
> Split up the variables such that we can track the static and allocated
> strings separately and then free the allocated one to fix the memory
> leak.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/replay.c         | 20 ++++++++++++++------
>  t/t3650-replay-basics.sh |  1 +
>  2 files changed, 15 insertions(+), 6 deletions(-)

I had to read this patch a couple of times to make sure that I
understood the flow into and out of determine_replay_mode(). But after
reading it a couple of times, I agree with the change that you made
here.

Thanks,
Taylor

