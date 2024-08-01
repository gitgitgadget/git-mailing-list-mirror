Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF5714A4ED
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 20:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722544611; cv=none; b=ZKbO2kBLQrobzQwV7z7Ro9JZdGluKx27VgKSMO+OWuOXrfLKzzBCrJQPR2Y5V2JyzdCXfNntPM4k08aue3cRSdsrOr0u20MATjQRGCCLeQQ7QPDLR1w6HY8BmiCZws0BmkYA28VcwzCrQZyDCAykwp13zqyRNI6Jl4Cd9n6JOXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722544611; c=relaxed/simple;
	bh=kN0nognpTpq1p+MIAXMcqsF1gqSQRdHR750/j4/tbPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsOWIe7Ikow08v4ImtFEAjMDwSiPWx0bFJo6D3cRvJmSBl9yD2xWYEYtyxjrKNFWAeYVs653O0ATUhYCOSS639fMcAihrqq0cY7CrZZYeu6GvnYJ8ckX1erfCLq59bYY3zZoHtRjPfui6DqyE58Oj/dONqZ79V3MmSCnWm/J4c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=mTd9YwUA; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mTd9YwUA"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b79293a858so36677706d6.3
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 13:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722544609; x=1723149409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kN0nognpTpq1p+MIAXMcqsF1gqSQRdHR750/j4/tbPk=;
        b=mTd9YwUARqZs9fab1nPphkIx/wxkhwP5OHkR5YlbVWXQT/65R44JWd4vKox5MI5RAj
         H4jv9wzmybTtlbn6CRJzB5uFribqMxAQtWSIXomJOIuEofxh+3eSJU+dlIRiv9sxiXgE
         HSslZ4J0KjJ4+a+yARVfkMGMq7L4F/1JhKHZsVnXA6hWKKySSFtKuC73jjG3VIgOoaph
         KZJ1+gb0YpMCltfDV8hAUrv64jTA314FnRmxPJPQwq/uBlIBRIJ4KMw3LdJe58xAbcD5
         VtOvggDruWizxJbz89FC3Kevxa88UMU6J1CItAenshFHEDn5sZ7qilJvNMtxRftrIR89
         VmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722544609; x=1723149409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kN0nognpTpq1p+MIAXMcqsF1gqSQRdHR750/j4/tbPk=;
        b=h6dfniqECSyB5ATXaaiqmgF70UWveJljI5rvFmhB5SCkNAPZi7VmXGL4sU5lRKMwdd
         aajl3BpsrwgUpphhF3+67Q+i4pz9aDF1+065ZVip4rqjku4YK4ZoHQcPQTavpUgnm6it
         0gJQzeZx//JKd8TItJjBLjFtmOGYxv7+f8Q6yecX3rXUI+uPmOH14bOK63F0ho+Bu5R9
         Rpozjr55uVKHlhhGr5fXfbP0gjxjZTnu2I/FqlZU4RstYApcaObsYbfODHMtxXy7hdKW
         af1Q+QbNpSx9knR27jRmXe4wW4knFd9eu/pLxQ/UyNv4gKpQQXkG0Nwg/ji813rXJcPu
         oISQ==
X-Gm-Message-State: AOJu0Yx5qD1ICbldPi8KSy/XKa05br/JTNFSCZ12RA10EpmIt0hj8lpK
	qDrJgHP3HIxoBXzqEsh6VZ92b1PcpxchR6Yxs170MhaQ+mrGaL2vx/lvRrh/MQg=
X-Google-Smtp-Source: AGHT+IFiUnITBGHQX/1Oi6SOINECZz6z/3k9P08YdA8P88Y/Ack9IIKAjNTc1KLT5aojDhRi2kxsCA==
X-Received: by 2002:a05:6214:419c:b0:6b0:63ab:b7ba with SMTP id 6a1803df08f44-6bb983d0149mr14994316d6.15.1722544608719;
        Thu, 01 Aug 2024 13:36:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c88421dsm265886d6.139.2024.08.01.13.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 13:36:48 -0700 (PDT)
Date: Thu, 1 Aug 2024 16:36:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 17/19] t: retire
 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
Message-ID: <Zqvx32vv8u4WDTKg@nand.local>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <23912425bf7c0106ed388f7712e7bb822572fe5d.1721250704.git.me@ttaylorr.com>
 <20240801104647.GQ1159276@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801104647.GQ1159276@coredump.intra.peff.net>

On Thu, Aug 01, 2024 at 06:46:47AM -0400, Jeff King wrote:
> ...if it is one or the other, I think it is better to test the new code.
>
> And I do think that midx bitmap code is less likely to be exercised in
> interesting ways by random parts of the test suite (versus something
> like GIT_TEST_DEFAULT_HASH, whose effects are pervasive). So I think
> this is a good tradeoff.

Thanks, I appreciate your careful reasoning here.

> Patch looks good.

Thanks also for the review :-).

Thanks,
Taylor
