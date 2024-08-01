Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32441EB486
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722538842; cv=none; b=SyHe9k0+dG5yh5EedIWyiHyQsRtT24NglrvqQ/DB/nWh/6Kgc/d2ty6T96v3hwmIeM/6z/tECvErYK1LtxBs5lE8QlKc8Y1M4pLC1eO5w1fqQYaG5esQOJNVPceDYgK2h8OWBTAvGD2xUGpinF0uU0Zltak016pFSQeDZUGmzzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722538842; c=relaxed/simple;
	bh=awVs4Ha9mZipWpCvnHdUTtBNXDK0yHqCAEV9t0g+n1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKRshAMk5kjsmghmMiyZjUe2/olnhtAqzhVj8+gQzhOU9xJfYCPqGp5VefyMwBSOW5U7GMZHwnvgMPcDLr5hD1y+5BkxZ3jNy/oO27ucLiCWsh89D4usiusrZrkaVQ9XZt87un/zj/z/jvfSFCZZe09zMt/roswFdHhqNCB2EAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Mhxazogi; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Mhxazogi"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-65cd720cee2so56063547b3.1
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 12:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722538839; x=1723143639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OB97zDicFib9EEsZNqxA2Y5K0cVOTZ6PaJuvIj1GDzM=;
        b=Mhxazogis6/6kAq07o/ThkQV8TameIlI0yMt3DDhLHY+86xW9GfOxTb+wp6A3C9/iY
         GMgXb/ioOWVo7Ro52xclrEggN1b6RO6Sc9f/H4TGmk7WpTSHHyb8uFkG9P1671AkEKQg
         dK2jF16g/Lo0dJD15hv2QFxq1Q0yl0T27OA9vgge78HEB0+8e9BPJiWDe1h8/4QM93oX
         PHI3h21kcCd7akRtojpX8+96Wj7AY+i2jjOU24w6O/vNi34LAuZTk5trvIfsUevXxnZf
         WwYvWCyFsG8qo4vot9uF8vjh+58BazjjOV9RhEzV+A3WHw4V+BSvDe6oDCmKrlx5b4EE
         +1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722538839; x=1723143639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OB97zDicFib9EEsZNqxA2Y5K0cVOTZ6PaJuvIj1GDzM=;
        b=RoKRHXeyxHmRyZqJZwqUm1wG+lzI4nYZgXb+H8pkMrFAmOQOo9G9Z9kkJWgCI7JsJz
         TtQCmt1/7Nz3UPNyEunp1goRS/iclQD4/RoCJpDHvz3H1+0SenxfXB4/poqt/s2mjz/9
         NNlNnDNvlcyREBrO1rvTtJIUpEVNvD0sPp2KSXbBpQAhEIjEKNF4kzD0TyPlyzfDlJAK
         fKA5xSz1UMbso2UlvX6j3mdCT6dDw0CUUDxSdK4tnJo91IwQt3t2BR0kERJdFSfAIVhj
         773qv+zfgIfiThtdAqBqHLkekzl+emHKvUsU3YOYh7FHt55OmIlSVrr0abefhHlI+ILG
         fdMw==
X-Gm-Message-State: AOJu0YzXzmgN+s4i4Ua3hYjP4QFutiM6mj8tdZwoa443TGncK1a0tcOB
	pG8DO+iwjJq4BstUmqDQR+Q8Q7mc8q/NJr21enCJadp4nuuXXiuumxikDMDtnhY=
X-Google-Smtp-Source: AGHT+IGGqStFSFasmhVgz7chb8xXBoJgkz/iDqulsf1hbCPD0RdSGkEgPQW9/bGOw2kgnabcCSn81Q==
X-Received: by 2002:a0d:d2c2:0:b0:664:8d23:1211 with SMTP id 00721157ae682-68961606d12mr12315307b3.26.1722538839552;
        Thu, 01 Aug 2024 12:00:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-689b3bee26esm442417b3.120.2024.08.01.12.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 12:00:39 -0700 (PDT)
Date: Thu, 1 Aug 2024 15:00:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/19] midx: teach `prepare_midx_pack()` about
 incremental MIDXs
Message-ID: <ZqvbVQKW7lhtt0A+@nand.local>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <f88569c819292a824c78cdffd4e1fbc329f07f8e.1721250704.git.me@ttaylorr.com>
 <20240801093550.GD1159276@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801093550.GD1159276@coredump.intra.peff.net>

On Thu, Aug 01, 2024 at 05:35:50AM -0400, Jeff King wrote:
> OK, I'm adequately prepared for more global/local confusion. :)

Good, since there is definitely more where that came from ;-).

> I guess if you just reused pack_int_id for the local id, the diff would
> be much smaller (this part would remain exactly the same). I dunno which
> is better, but it was a little curious that the two patches differed in
> approach. Probably not worth caring too much about, though.

I meandered a lot about different approaches before I arrived at what
became midx_for_pack() and midx_for_object(). So I think declaring a new
local_pack_int_id was a relic from when perhaps the function returned
void and expected to have a uint32_t* to write the translated pack ID
to.

Later translations make use of the:

     pack_int_id = midx_for_pack(&m, pack_int_id);

pattern when they do not care about the global pack ID, and this one
should as well. I'll update the patch to do that.

Thanks,
Taylor
