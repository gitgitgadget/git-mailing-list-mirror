Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989EB1BBBFE
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 22:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737584524; cv=none; b=Pf5kwo6juVgw7orfaPXn0roeIXW78egHErP9QiUpLED7WBh7/1+o/sad+mFpnxHYLwQu4JAT5+i5/ybrD+O30h/Ct3/0DhttoeKhBBp9+UnEJFYNRKbCjEt6zfryyVxPsGLBKGb6qHuS769ONgs2RLmef9Qif4QYyz+5W8kcHhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737584524; c=relaxed/simple;
	bh=fh0fJXCmOftiFUgXhIcOHTBxS5h2lP/5OCLZlfJ/U50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4RxrO2CG31qiMQGzCQqXMUYgRd4vc3oVj97xGbrFwhdUCjXDOj6rNJCbAi5U2jkWi59p/9YaI8SY52lv0jc2HqwSTMt/elV1y0AYGlShRp8cQID2AxrQTNLIbf5mGEaikS+8kxEySv5mQmFJ5JlDXYpoxei5UUuVG7ttyIhNGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=gntQSsAB; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="gntQSsAB"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e4a6b978283so2443212276.0
        for <git@vger.kernel.org>; Wed, 22 Jan 2025 14:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737584521; x=1738189321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IMbVnKHQxYrsaFTEFoaI0JXc/8o6dZZnMGwEO3M4gUw=;
        b=gntQSsABFV3NZWAtLaIeI59zLIKXEsfjUAyhXOEFAbKzebt4S4gQEfGT11oArWycXJ
         Q1zbusZT+Az1s9SDniHE5m8QMBN8JYkSibQ4ibPWtqg8X6nzMliUcJR2CbINZeNcy/UO
         xrEsuKt0kirCWnfmO8D3/u/cdVaMcjDBbgFozapTfxV6b92VJ6XTgi/b0nv4iet2oApf
         4pRqgFHslE2rVvkC7U5EK6T2cvsFmV7fgZ0tjyMeqxz7DbaWNQNOQ5ILMRivIHSN+gja
         LQDA6Rb5pLdfs31PKgNcqWKQ6FLP7O8Ygbh5y7mfU7ijxFn4r5zsxPY3xaKwhSw4cje9
         AVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737584521; x=1738189321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMbVnKHQxYrsaFTEFoaI0JXc/8o6dZZnMGwEO3M4gUw=;
        b=mGFpZDhO0/9FURMzWz+bY1aVEx84MgAYuU8uzqEFYNXASra+3Lx4CF67gQtz9gBPTe
         Q6OvLbTz4hQkQcfIaQU8KUzRyijcKipOq6cDRNfXCz8MaZVTAeT40z+eoKU2UMFDP1Zz
         EnyIU26BNeWjGGRyJ5DLLR+53pT4kyU9tJJDnSWLVlSuz6c/zPVTZa1eNHeSM4G03LLe
         x6piOPkEZFqO2MbLHZCFX0mBbUA/U9vnkVrRcy3UT+ErtBQ1LdRmS21m7T/fwlsPmset
         lLyRd5hNqoJ+OuBFroppJ/5bIqOvDr9/HfK8+Uknt3YPa1iOSDNEx41/v0JidpomVNrk
         xEtw==
X-Gm-Message-State: AOJu0YznFIhxz51Tiq+NZCLKPnSp5Hy6RSg671bWkJ7xNV7RzZ65lqHG
	9nKFfZ5kJLbrRnhxw9fINVufArjHe4cjUu8hOharT40ilmJSfetHV83lUpUv0LE=
X-Gm-Gg: ASbGnctPuEyu6PszQ74q69DyyJvL1XRzMU+p9RpH+iki8wjvU9f743kMI+dBdz5Zqi5
	Fu2iQ8ChTspgIBOH/ErMlUHiw+CvxCGQupLADpjokWJLjioaT8Faa0UqDAVGInf+PErvZwOfbMZ
	ywoGiuPcryNbbTGkkBrIhQ4QH7tfXhbIT8REdWvcRI9GoxBWBsK5VKNeVSGLcyViucSFM/8+uog
	xtOCBbaAnAr+V4tfcbTV1j0jYKjPsj3uwCBP4+6ESr5NCPf8gqGHSwp9yPyIEt0nGBrINuYAuph
	y/jLGeSt288PuB9LXiVFixpCRfqtz3Gh7+aoAkq93g==
X-Google-Smtp-Source: AGHT+IGkG49jnPQs2UNXJZvah8GR2Hsl1STigkdxxA2P7yG6CTlYzhVk+meP7R6K6VoMvGfMASBsOg==
X-Received: by 2002:a05:690c:101:b0:6ee:8088:831d with SMTP id 00721157ae682-6f748c7d3a4mr8844337b3.3.1737584521493;
        Wed, 22 Jan 2025 14:22:01 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e66f53cdsm21858647b3.100.2025.01.22.14.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 14:22:01 -0800 (PST)
Date: Wed, 22 Jan 2025 17:22:00 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	jonathantanmy@google.com, karthik nayak <karthik.188@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 7/8] pack-objects: prevent name hash version change
Message-ID: <Z5FviP+M7Mi1z1Q9@nand.local>
References: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
 <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
 <18a41f2fe6f2219f16f998699394005bd57ac463.1734715194.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18a41f2fe6f2219f16f998699394005bd57ac463.1734715194.git.gitgitgadget@gmail.com>

On Fri, Dec 20, 2024 at 05:19:53PM +0000, Derrick Stolee via GitGitGadget wrote:
> ---
>  builtin/pack-objects.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

This is a very nice guard in my opinion, thanks for adding it!

Thanks,
Taylor
