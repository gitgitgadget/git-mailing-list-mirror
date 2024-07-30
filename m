Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15251A619A
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356960; cv=none; b=QwA+K8u09p/pHvt40bQJImPfNs0e/A2w7eMXBFiKBITUCpOQbT4h4R/lqHR1IhzJ/MuPVmzePYaWnW0Iis1LL96AozzXfLKguJGxLsWVxSEsG/wEZzPxBzX3KtC/5/Ovzxz7w9uGaZv//rkNeFpBU+83d41OGnYcW/S3fQwEBms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356960; c=relaxed/simple;
	bh=PMhE4QUwiuLl08oc8byLMAQWqTarlgmk1fsAbUqpKY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mE6Pku/ilWOqh/0787PJLqUS3Wh/kUUSAN/+F5qEmSoXbGFYHYG+B+f7jbrmXorDuiPQxBqEGfw75lJjunXw2j1XgkPeqBamIawlnSE2tgl5rnUCVmfMI3LXBUdBnqeS49hftN5G23sblnLNSPJX5XAy+srUUIKuG5/nY2QteLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ezy4poWR; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ezy4poWR"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cd48ad7f0dso3665277a91.0
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 09:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722356958; x=1722961758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nJ2+YGV6M9tsMOePIu8WyhWZ9GOP5hHfwjCUMkTFZy4=;
        b=Ezy4poWR/6xtpcnwP0DOru6eKp2i0zy8gGuVu6t5+5Mvh5rOONS5JfzgwMstHmJJ1T
         IiYC+JU9R6Egiua/HrWN8dgdhI7qyd3xzUVyvtV+p02jkyZwCR95rlauyDn0jCtX6k9O
         BWVhGnPHJPPmIprWn5YMKlzw0FXtG2RXN3mi7L6LC15HGI515Z5RlPaHW5eNRK7FPEb1
         clf3V9aiyp9Z9f/YdEn1DGV2i3tslulotVInKs2PO9UE7xpC+p19u90EXmSsMJZYVxQc
         LVFPee8gdw1yyDBrBCeaMgAlw/70ryeLpuKDQiBsyTU5tTdK6gY0k0d6KPYV7NPz4sM+
         6Btw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722356958; x=1722961758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJ2+YGV6M9tsMOePIu8WyhWZ9GOP5hHfwjCUMkTFZy4=;
        b=CmfJlI3AcOehRXyEPUIrow+BwBMpWndCDgTsUG9JaxkJ3luWLCLV5wzNQ5YRbvYgLq
         FaU+dVLJZk5EpX4UC5JjEuMt7AD1ZAueLrLYNk8lVMpJIzMmLfjy2fqZuH7ElrbLnu3r
         W4XXJWncBiAxCz13Yiz1HOwP5pkbQaKVuSAZ1nMoa+rP8YaDwnOQiad1QHzW5u2fSH+m
         +xp3UVal5VYnEylNdCIEk4/XATDJY4EwaCui/2EAmdzo5LWbj37E71NspX01J5JkCl/v
         GZr+n1jFTVR6eNWHeWL3vhj2I+38K2Boj53y+oX8clXUJVqr9skSjg3qo/Nmkgxf7z92
         csHw==
X-Gm-Message-State: AOJu0YzWU2P710eB+tIXWFLU75DSO1oP9DHHD0AiDfb8GYUNRmCidcxO
	csQZGR6cKADceDlrWl1PXCY0WkgrY4iD4Dd7vlHtXAkJaiFIWHUt
X-Google-Smtp-Source: AGHT+IGdck2JPJ01/FqHH0c9f1WfrCkvNs8fyRjCfsx0bIpPtiNV3UUlkXVRkSa3gDcpV/AN6HNsHQ==
X-Received: by 2002:a17:90a:55cf:b0:2bf:de8b:bef5 with SMTP id 98e67ed59e1d1-2cf7e1ca11fmr13082676a91.12.1722356958081;
        Tue, 30 Jul 2024 09:29:18 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c55a22sm10987671a91.12.2024.07.30.09.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 09:29:17 -0700 (PDT)
Date: Wed, 31 Jul 2024 00:29:39 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v13 00/10] ref consistency check infra setup
Message-ID: <ZqkU8whn1LfTRdfk@ArchLinux>
References: <ZpuCg1GL1YE_sJBP@ArchLinux>
 <ZqeXrPROpEg_pRS2@ArchLinux>
 <Zqik_yal_hPTlotg@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqik_yal_hPTlotg@tanuki>

> I've got a bunch of comments, mostly because I've been out for quite a
> while and thus didn't follow the progression of this series. But don't
> let yourself be discouraged by the volume, I quite like the shape of
> this patch series and think that it is very close to what we actually
> want to have.
> 
> I'd say that this series is likely to become ready soonish.
> 
> Thanks!
> 
> Patrick

That's OK, Patrick. It's important for me to receive reviews thus we can
make this series better. And I will wait for the advice from the Junio
about the design of the "fsck_error" here. If Junio were satisfied with
this design. I will clean the code and submit a new version until
everything is OK.

Thanks,
Jialuo

