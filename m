Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C351E3DDE
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768052240; cv=none; b=aej7ye9sIuk3WCYozJDya4J7E0T6m83u7iUFKiFBhO6hSJfOHfnlpb/S4ChuWL1/+SUIB1TrLZjydfKfyzYw2GtUK2BieqUOhwXrB8EZhoxN3f/QApR2RtkCHsBgyMiFVSGujYoJhUnpxZllsSUa4p6bUi2d/zBI1IOYrhM3o3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768052240; c=relaxed/simple;
	bh=NDcHOrSWAiD7mgUYKx30Yp/k9Hqmxp8ElScs9v6yUgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3cVJpbcwqBGanjPR1VoAi3x6f1XCKP11J/bG49AFHQd4FvM/tuDGJEsQuoUqefGtkya1VP1i+xZTRGUE5ypfDB43kG4rpJktXC6e0w0lpykgso0FlZ0qyTchANMWCXgko9qGQ3LSeoLEWIBC5hVsUruKf/U7+LhTXLmUhBrsEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPG3kZ0d; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPG3kZ0d"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ae29ddaed9so1873489eec.0
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 05:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768052238; x=1768657038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7QMwdjNTTLeDOjr12WJToj1leCcOp+WzygGm9yvGobs=;
        b=DPG3kZ0ddlie3IXrAACQSspWeaJLWaeaCV1VM93cEgehEb9QVpUpkvr9395DAY+u2t
         0urlSSLsDSqH2kWMxP1/Ie33mrl/+CjAJ0ytpWxtoVT+2lqT8LTJNv01EThfLkla1PmC
         A6y9sTjhQWKSyH/LQn+V+p0GCAwUZZNp8YAz5mwDb+YAtw1OUYMYi/h09svZRzmClzv9
         4CLQcA8CA8mlu9xYrLljKuh4f8+xlwg7vNeBkds8aLxZoEwvF6KuHCDqnd9kJCV9vGo9
         UNJTQXhtPPioahEbsajMgxztXR0iq/+0IYwtLIS6NhF+G8Cqcdm31s9qQSvw3VXpbNfe
         MLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768052238; x=1768657038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QMwdjNTTLeDOjr12WJToj1leCcOp+WzygGm9yvGobs=;
        b=KGjH70JRdVhSrWsdK+CdRYD/055PvYgVja2OvgUqn+D3gfl+19tmZQmo/0/fGdbMz4
         FSr5WDNnixDYFCg2bUbEblFh/EDn2VNJd0kMZ7ZEvPg21/l3BdBATu7RftAHSafkoyoh
         CsT4MYhIEw/PTTfA7Bi7BTVLA1wqARoJFhkkOmQdpt6dOMz/TYs9uDGD8NJuJlj3I7D4
         n6OsRSP5mVhkG0FsvKYTds2kr7apHlOrSiekv+p+wCNAljvgDg0Rz+0LCaXLI+cu6yU1
         /KfeMMbscSUaeS2YXnfHoL7yx+F+SSq+11PxiHOMH3XjsHEBvYd+kSMqgqM+7WbOgkv/
         FEpg==
X-Gm-Message-State: AOJu0Yzpx/SHDCiDesQF2F51mbQeJg2aCRQHi990VtqV7WOJCOR8PXT+
	gUJ+TDtnzCy0xhGdmYipoLbuPEkCOruyXUhRFgClkhokDMa8nsef/JF2
X-Gm-Gg: AY/fxX59rE1oxY6lGbzUkVKc83Zg4ExDGu4gaV1E7pmz64W5PnPH6mWRTtD/S/QZO+Y
	d1P33FUUmH6nF7jHgum1YQ6FATSDziZrLIqmDAbmZ+4kFtvlyugaRkqzMZ/try5K5iNSL2KkBDt
	G0QiWP62zYRI9PLwrx9FnohJo6q3BAZ5BRiKZ5o8RyjMpeEd2po2dnviapCXa8ggBcULgsDTDAt
	7rFSI6Kb9jjWURp0TjsSf/sgrif/2iRdwNwIpPrVOAf58ghFpuK/UJMbp+/b6kTEndH+uM95WTB
	cz1WCaGUmzHy1mUE76pwftfQJ13IAsEcidRwx5k2G/H0z7QuRGGHFx6hWWZiCJxWZcijSUjJEEq
	pK23kzxYFS84CRz0Jf8cqp3aGBexn+XLHZzH4ampk5lkuih1rbfdfFtgYO2N3w83zgI43v0Lw9Z
	Xh4ZQFgQ==
X-Google-Smtp-Source: AGHT+IF04cBh7O7AcabYWZe1t3MpH8113c/1J9bTDB/qHSFF+koxdv2cUVEWrBgFRuZXAURazpLmsQ==
X-Received: by 2002:a05:7301:fa13:b0:2a6:9fb5:f78c with SMTP id 5a478bee46e88-2b17c74ce91mr12784298eec.4.1768052238161;
        Sat, 10 Jan 2026 05:37:18 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707b21dasm14326316eec.27.2026.01.10.05.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 05:37:17 -0800 (PST)
Date: Sat, 10 Jan 2026 21:37:14 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 00/17] Fixes and improvements for ref consistency checks
Message-ID: <aWJWCiTFQAZqDb9y@ArchLinux>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>

On Fri, Jan 09, 2026 at 01:39:29PM +0100, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series contains a bunch of fixes and improvements for ref
> consistency checks. It is structured as follows:
> 
>   - Patches 1 to 4 contain a couple of cleanups for the consistency
>     checks done by the "files" backend.
> 
>   - Patches 5 to 7 introduce checks for root refs for the "files"
>     backend.
> 
>   - Patches 9 to 14 introduce infrastructure for shared checks with the
>     "files" and "reftable" backend.
> 
>   - Patches 15 to 17 move some ref consistency checks that were still
>     driven by git-fsck(1) into `git refs verify`.
> 
> Thanks!
> 
> Patrick

I left some comments. In conclusion, I very appreciate the direction to
share the common logic for both "files" backend and "reftable" backend.
And also, we could check the correctness of `HEAD` to make the ref
subsystem self-contained.

Thanks,
Jialuo
