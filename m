Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3826F21106
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137696; cv=none; b=iuROMU3DAfhJtmaKzprt4lK8LoUY2vEpNBFND61Q2WfbncxOB6GEADBX5uSryYvS8TE3Hxul0tuxRFZDFipDcZDAfmrN7te1WI8+kMYwYF/OjSOLbtWH+TI2RX+2zeAp7/xQzWP9creqZ9P3EPALIl6oY7KUorxuQwcBmaS05fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137696; c=relaxed/simple;
	bh=daPO0DEObFwZVWyhnjcEAQW3ZMZNSLeUrORSyBSwkiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5hb4bZTaI9HR1w9KLvC5+DQgKstbditkz/ucGiY515iBQoo6GbFAJI9eimiNEN6opuWfzZeN5nRTcLHFimZNxmIRKbWClvQBfw1yUTzJfVtk8Ve/PL7FHRpy/EUdIOu1HoGeywlHhV6fjrm07C7hbEcBqDu8nKmCjECNsCjN3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=QP1nbXO1; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="QP1nbXO1"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e38fa1f82fso41140047b3.1
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 10:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730137693; x=1730742493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=daPO0DEObFwZVWyhnjcEAQW3ZMZNSLeUrORSyBSwkiM=;
        b=QP1nbXO1hYaXlJmYU7N/KEVKz1WTELiYVsGbKpDQF56HTYSMCVVMj0ji0R1M+0m4Py
         143vK+JeKKwbysEcEEtagUEeie8rkDVfl2ZqHcASk0AB6vku54E5v0pgxiH/a8HijzLr
         fxfsmIduRzh+gprbQoOwt1hc7yiDHOkvyJO1VKuN74HxtFJ2IRooS1/MPJhqJNN7CoEQ
         C+p63yCvKeBPKftrgnBvEP00sbn55rs7lIcL8yNOEmqnbG37SaBrtfMfe0vBweZOq7eY
         RmFgRJqMvEg2WJckLO2cdQVB0AV3UV1KWUcA0A8OAzPV9KzgvxYCgcp+25UTE4NCZiFQ
         e2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730137693; x=1730742493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daPO0DEObFwZVWyhnjcEAQW3ZMZNSLeUrORSyBSwkiM=;
        b=eoixVtURHkAenZsJl7jEMpt2fHl4CIy1OrKA2glurZm8KsDxkxwgv6j13B+ryC30Kg
         Ys3Ohy8ncWPtlmyw0+jRLS7dRSgj7hI+GcQogDHIU+ghSy9sF8x9L/SiVxEPGQZNTD1o
         tkO4DOnQ7OOBPRE0tUYkue+Hiwyqowe+yO292Vi67oHQApuqgrCop0ERfq93lHrn5b3m
         T/9YcNqpUoVhF53FeQ0hcLoJYAWNnhPM/BzhL2EK2er4ESK8nNuWd7OVQ4PmVr8w3lW0
         B+fYHa3AXcjMlbN4lTXE1fiCcozI5oEUtrrWKc+vwHjyaLL+Wq+M+616viV8v+i/TxYw
         b/CQ==
X-Gm-Message-State: AOJu0YwYc4WyycCitLJCOJefH/UaXScpx56p8agWs0lKkXdgaKEFNXaX
	VMvtHUTkkALX8JljaWLw0inGbuX+jJE5Njl+aDekCWcnvNr0KyjY+mEFqAkxVPc=
X-Google-Smtp-Source: AGHT+IHc5ZmhkBkQ0zQmMnpzsBKgJBTYJ1ZCTd9HNJUtLBGIrWpSKZ/kmyxwQrRRaJqL6/8ZN/IotA==
X-Received: by 2002:a05:690c:2e04:b0:6dd:ba22:d946 with SMTP id 00721157ae682-6e9d89b4550mr72366227b3.13.1730137693124;
        Mon, 28 Oct 2024 10:48:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c989f6sm15241677b3.130.2024.10.28.10.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:48:12 -0700 (PDT)
Date: Mon, 28 Oct 2024 13:48:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t6006: fix prereq handling with `test_format ()`
Message-ID: <Zx/OWlJ6N+tKbLMc@nand.local>
References: <zod73s7j77gjj2f62clg3utxlxnclbyhjjz3yc74x7zyh35fzy@blwhzqefxyrs>
 <ccb2d7cf817a181fab8fb083bdc9f1fed4671749.1730092261.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ccb2d7cf817a181fab8fb083bdc9f1fed4671749.1730092261.git.ps@pks.im>

On Mon, Oct 28, 2024 at 06:14:51AM +0100, Patrick Steinhardt wrote:
> Oops, good catch. @Taylor, let's maybe queue this fix on top of
> ps/platform-compat-fixes, which currently sits in next.

Noted, thanks, and thanks also for hopping on the fix.

I was wondering how to handle this situation with Junio's scripts, but
applying the patch on top of ps/platform-compat-fixes and then
re-building 'next' lands the patch in the expected fashion, without any
additional cruft.

I am not sure whether I will do a push-out on Tuesday (as has been my
schedule since Junio went offline), or Wednesday morning. I suspect that
the latter is more likely, but either way, that integration round will
have the new patch applied down onto 'next'.

Thanks,
Taylor
