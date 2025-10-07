Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35B723B63C
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759868791; cv=none; b=lFcTlMiBEvGOAHh5sXayyuhYpvBlU620Q1LhEpT0B+di0dIKeVpUuRcMQlDDeKc/eOc3VwPyAW1pHSEdgG2lwGzX1kW8wAv+/ma/r5C/Zkkbjv1Xt92k6Ba89nmrbEspuWef/f33z4QRYhDQnvixLCFBn6kezagRmRN6B/faKpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759868791; c=relaxed/simple;
	bh=Wo5J9FG7vsxuBOKICJ0EMbiZkG5Pv10CPxPFAWa1SY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnlnH7GGL+Sp0U49GuChjT8I9eGkO0zOI1K0lTRIJ7nhTMLQF+3Xul8TvqeC/11ouGlZvCY9mRsyLpfBUPS6xE1/UY0GITbl6U9DOk8pGKWGbnqJKej1W+afVYtRSet20gPqODrTdbTSBfJyRCIYX9L4oXQ9q69LJqy9SbBFqo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=aFwfRpTC; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="aFwfRpTC"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-9194a0241aaso276544239f.3
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 13:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759868789; x=1760473589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ijfKBUdaPmk8bs2qSIOrGbMxDk2WF7SqOe+UPJnSSM=;
        b=aFwfRpTCvb0LcnfnThb0edQwRyOEwCUazcHy2zf+XqMBNP2bOz0TZKCzHzIkPbWQxI
         YykvAw2+/ecWYj3wxAPVlfFyX6+IVbz87bHmQB5ctpOBaCtSdo7ek1099Revz+3hAxFi
         yqKFRPoBAIR/OQR734RCObIafmupv0fmcq6I/p1DDc0cXX3oqoWvQIlcf8sdVp+ODXai
         RGvnVOqmtK/jmVyDIeLHlrBa4Lqk0nTkfJnVFn8VfXIMgBXGFGrsNkpG6YY8sT/6Xsvk
         1Avf2q/UpsuMef4zTZuUjeW5EZEJNIi7n45Tc/aUBJD5ag23IH5cyDUzmHZMwwVjvDrB
         Ccuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759868789; x=1760473589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ijfKBUdaPmk8bs2qSIOrGbMxDk2WF7SqOe+UPJnSSM=;
        b=XG3UnIkF/WIGH+Pw7S/IECuA3HsUiYczSrdlHmRV4PujQ6p/JwJn8C9m2mh74yk0LX
         WCHC7pTzDEv76md1536hiqd8ddMa2aH6mJTecfE3CQiOW2vFgcjieJ7ChAko6J9FfIjw
         PlSjmHb3vDN7OtjYNjJ9pGbczCAfB647BL2RqJPSv8XSIvwbWUeLTrEY00ZVZTZv7hb+
         45y4mX4us6IO6pZNIMVdudDw6zJKJSoCvQOX6pC0mNKBUwB2CmiMjiBcQzirn4/I1S7O
         KCBfeZ0jhhe+EZ++VwUckFJax0MHrWt5Iqvq0F04ygLLmWaGPMOFcm7VHCH9VTExI8V+
         SbJQ==
X-Gm-Message-State: AOJu0Yzi6OVwLkiptVfckPb4zW01ZU3e7Rwq+Kj8YUshPXAABrxjihLU
	fxZj1aXPIRAm7PLb2FgBPgbq8mFLwO6Y7wOaalmQUHcf3JTBf9MqAO/0FJq43SDcxYZS1flAKEw
	JvbDUIQkT7Q==
X-Gm-Gg: ASbGncvJIK+OYbygh1ApD5T8UdNZ+ZkF/tfMdaa5zX1gkXFMyva7NdmD/PAtKkhZTYA
	y8jU2yEAcADkQcyfnIvgaTLu46hyCzaFad96nShsyGJP18qRMtj05wIj0Zo2Jr89Oj3fqDkh3hG
	8f3gGTMrMjPF9XBfwApyhhKuOTUYc+M6tUA30S/K3mEu+35ksBd7EuMwnmVABSB/e0iHb9sQ9Rp
	vHRgAOmzwtSkGTeui2eghvIDva84RPA9L0gMIzdAOtdmPlm8r4Kf8LecRckFUJFNh4hjqf3rYe6
	4xHklz4nMYndjx8qg+W+G8B+u6omM83136BfymWcC1LoBEagdih9pyaVENqlU584WpR7Iodpqqv
	OTVTF15+50p9MnKGFCEmA2UpNAywU545XOb894ryU4BaRHzzHjhapea0Csd/25Oi6GGabpnI96G
	6YGcbGh3skfT2zpluq+GWDM/9cZTCmQBTfNvILvIPXcR+d5tu9Qg==
X-Google-Smtp-Source: AGHT+IGZ9IsdY2w3W1PDK5nmUTXXI5oVu1NA2bnqJqoYvfWkkBHdxz8EwNCoagwmigQC6v6JoNJAgQ==
X-Received: by 2002:a05:6602:26c3:b0:92d:99d5:6a00 with SMTP id ca18e2360f4ac-93bd1960533mr80336339f.9.1759868788910;
        Tue, 07 Oct 2025 13:26:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-93a898dd8d5sm622840039f.16.2025.10.07.13.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 13:26:28 -0700 (PDT)
Date: Tue, 7 Oct 2025 16:26:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 21/49] builtin/repack.c: factor our
 "generated_pack_install"
Message-ID: <aOV3cuZhab7xOdez@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <96d27261e75fd2ae46d9633b3d4eff243dbcc187.1759097191.git.me@ttaylorr.com>
 <aNsUiho56-S4MQZg@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aNsUiho56-S4MQZg@pks.im>

On Tue, Sep 30, 2025 at 01:21:46AM +0200, Patrick Steinhardt wrote:
> On Sun, Sep 28, 2025 at 06:08:31PM -0400, Taylor Blau wrote:
>
> Is the "factor our" in the commit subject supposed to read "factor out"?

Oops, good catch ;-).

> > +	for_each_string_list_item(item, &names)
> > +		generated_pack_install((struct generated_pack *)item->util,
>
> This cast should be unnecessary, right? `item->util` is a void pointer,
> so C should do the cast implicitly.

It's unnecessary, but I dislike implicit casts from 'void*' to any other
type. This makes it clearer how we're supposed to interpret the value in
item->util, but I'm happy to change it to use the implicit cast if you
feel strongly about it.

Thanks,
Taylor
