Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16451EF1D
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 00:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742344009; cv=none; b=fvZLg4wNgy6clHdq5Ttx7ZVuNPi44rdsTpz1tIT+iwIlSoZAPE3WCsv8us0R2eysznYUE3ykZ1bYFtvJWOcHWmP2Sqp8vtm6X/5u/e5OJOcUP6EP1/9HP6VLZzgls7ejQyHe4uvfFNpasRdzp1RWj/hWxa5DbltAN4pXkJNQJcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742344009; c=relaxed/simple;
	bh=1QETeCnFjR8k8QqyYs6J77ujo/mnPWLgvZ4dm4zAU40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHM0aHeOAU28pLJAWY4WkWfF2/jL/T2jvydVTE4B0Lz3IWbkIaQ5PxJUyjg2GSKXpdqllBSU3E34Gwk/NADOwS8xNY3W4vZBYS3tct93Vl0Gpy878oH2+f2rTlWzlS/lgelTX63191HnUE9nourq3n5hoCLL60Gc2aYN3/KpmGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ZhQtchtV; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ZhQtchtV"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c3bf231660so738943185a.0
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 17:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742344006; x=1742948806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LTlsOwG92loU5ulF1/kcC02DQPq3AiQrh8okqbtK+wE=;
        b=ZhQtchtVov9PiscJVKywNTaIP8Kb2qfgm2H9+InF4JUa0GikhbT1zl02G3TE1N3+Yf
         K+FD620vZ8JMk++aVF1AHz5PJVTQaQayORoX4duYhH7L94MhjhdTJnw0VhOGLTr8lVrY
         Xf8G9rhzwSk2CN+GZDSgTKDktIBuMi/1USC/uZpdM7BJcMlD3b56M16Up5H0/IxxGrOd
         FgXneAl1NTwr14f0WYB/pDhbPH8AgKcKAaPtfNTkyRAu7jKNBI3k4aml0Ul7cSf3rGH4
         IawCkfovBByS7VoO//a471S5g/iOfTwh7qIzAvOd7nz7Xg9PepOgs0lMFut5hAs1BYf+
         5Q+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742344006; x=1742948806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTlsOwG92loU5ulF1/kcC02DQPq3AiQrh8okqbtK+wE=;
        b=BRM2l//0VUG4XZeqDBokY+vjlanCgaLpr8irbSAHERddYUkA3kZapYg216ktgjWFuW
         ccL4S6Qk13zq0aAVqf9eYauR/F1FDzjdvOxNDuc8K3kRIEYkdmioRVmN6DT/BJ0o+eRb
         +dXXTwfQ7E0g7OcR7GDOZBK3qZcGidDudO+EH1KDFtd762kbcFz+IoFvyZoVM0+URqbH
         3Qpv/1cm8XuC5CupPkxd8XXEO2Br+U2tYi+k0SUKaFDmQRVbyb7y9QvW9p3/SZbSoWZ7
         Z1Z0Q2lsSZPwjl17YX7nwan4fH6QRfte0qUnUT0rcywhni4/KME2W4fSLvY5vQF4CR/X
         eBWg==
X-Gm-Message-State: AOJu0YxgT0sMw4xGshN9+i8sFYLjkSpCApy2T/3CPStFu7ZxpPGdsrYm
	5iH+Td/tzKXx5q2IwxjhOyKVozZjG8j2Z3jmJNLXJq+III+LpbGWt62PnNt1nAc=
X-Gm-Gg: ASbGncsYZy81yQY0yztPxpkYjZsu8V0cuThxU6za6dDK21w+LQO29lpvdHF2cZML2dM
	0I9sCv/C+BEUS9MEMXocykHf977Mg2NZOEePdU7RiCGriAvC0uvpq80L3ylkcoOrlag6+51zDbO
	y2RskdbFPVxed2Ub8mq3f7f0loRaTNMb3ydm8mu/yiK8GEZfreeK8lg49rciv6i2kQyfBNPKKbm
	tHxgumn9RjMOkMZ/EBnQgj3a71Ip6YZTvV8g0WuaUGsygOoE12FEEfkBNiSwJr7paRUsU9Utwru
	1bPnV+dRmo6ORkGx1NHJdHzNfk9ZHXtvEmP8M0ryYQ0ETzBr1TFmMntfb0BUhWxQKUpwl6hR/ZM
	FTDbD8uWYw7R8cUZS
X-Google-Smtp-Source: AGHT+IG4xslAQNxVpin8Fx9+wxgUQbLJyuY5z6tTqCcDbj+DPj99BDpcYtXiKbD34vjk33AgzyHtPA==
X-Received: by 2002:a05:620a:1a8e:b0:7c5:3c69:2bce with SMTP id af79cd13be357-7c5a81879ccmr94583185a.7.1742344006534;
        Tue, 18 Mar 2025 17:26:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c9e081sm784995785a.56.2025.03.18.17.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:26:46 -0700 (PDT)
Date: Tue, 18 Mar 2025 20:26:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2025, #05; Tue, 18)
Message-ID: <Z9oPRKHKjIWC0Uue@nand.local>
References: <xmqqa59hzydz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa59hzydz.fsf@gitster.g>

On Tue, Mar 18, 2025 at 04:56:24PM -0700, Junio C Hamano wrote:
> * tb/incremental-midx-part-2 (2025-03-14) 13 commits
>  - midx: implement writing incremental MIDX bitmaps
>  - pack-bitmap.c: use `ewah_or_iterator` for type bitmap iterators
>  - pack-bitmap.c: keep track of each layer's type bitmaps
>  - ewah: implement `struct ewah_or_iterator`
>  - pack-bitmap.c: apply pseudo-merge commits with incremental MIDXs
>  - pack-bitmap.c: compute disk-usage with incremental MIDXs
>  - pack-bitmap.c: teach `rev-list --test-bitmap` about incremental MIDXs
>  - pack-bitmap.c: support bitmap pack-reuse with incremental MIDXs
>  - pack-bitmap.c: teach `show_objects_for_type()` about incremental MIDXs
>  - pack-bitmap.c: teach `bitmap_for_commit()` about incremental MIDXs
>  - pack-bitmap.c: open and store incremental bitmap layers
>  - pack-revindex: prepare for incremental MIDX bitmaps
>  - Documentation: describe incremental MIDX bitmaps
>
>  Incrementally updating multi-pack index files.
>
>  Will merge to 'next'.
>  source: <cover.1741983492.git.me@ttaylorr.com>

Let's hold off a bit on this one, please. I have a couple of niceties
that I want to squash in there based on further review from Elijah and
Peff.

Thanks,
Taylor
