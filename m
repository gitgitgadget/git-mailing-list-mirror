Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE7E276025
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226363; cv=none; b=bKqdN1lxQvkPiDik3SqIgaV02M/45uEB1iQXUB2m4pdKcTr2pPPNp7c+l3daT2VtCfJnvlHv9eh/CspWWeQ7XELD/lxqTFKcvGS/RG19afTWtNBj8hCkVH5ejyn4PEqopp5f5Cp0MTnzy+53cVZiTWSB+fSb3aZcn7Yk94GnDac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226363; c=relaxed/simple;
	bh=vFvt1yPVF1V3CMm16EjJLiJ8Xe8ZAu7BGnAVSf+smuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLCeoqOd+kvIM82ZadDonG16K5B3lJookxuOLOFER6V8TSdDPwz19ZZ2QE3SFMl1bVUCFSWPDRP7lp/p3qJZf9CNzUs93zbBgQHBW3yxTKgdLdr0kwYgCU55TRvgWhboTfsp+KRUB5p9ZYubE76lbXDgt/tI5V4w3qsLhJQ2m5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkQyqptO; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkQyqptO"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-770d7dafacdso2836742b3a.0
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756226359; x=1756831159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Cjyo4dumaXkSBCjlN+Wn+zKSpBWBQbPPw4ZBryMqHk=;
        b=LkQyqptObCUaRPHttAHH877CNHmz65BHBFxk8IMrVeCRpuDoaVsmHHay4qa4z5TpAN
         0fpY/MzczTjdcLdKwAvY1rsdhsARs0Y0U7EWgsKQGXgzObNUMLvnWQI3sow0icoWfjKI
         iZuAdGpb+WcPbWlGJwM4v1SfKo9usMhsTr5Jh5ZWd2rTCGMBA/e9cTEAAG/1nlvOhgy6
         uL5jdnJDBZ4JHhzxGIB56zmB5ap8g9PiLH5MK6KjYLh7VkcD3dU38gouvqTvZIbaADUg
         FySHhffg8ZqD7mT4Z0DItExoZPaM1eNl9HVhXrTRDCBG87pPFBGW3jGj+GduZwliOq5A
         IY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756226359; x=1756831159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Cjyo4dumaXkSBCjlN+Wn+zKSpBWBQbPPw4ZBryMqHk=;
        b=dSx6vXwfaHEkw0C2FlKVDIxRNv0V73Ele/eTWAtbOitvuwIm31hHxG0mN/fa8j/U/q
         HF2/INNz6AzCS9uruipKFe57wa7ykdAlDLr29JyKXpFVt+qpZIf96TiyF21qiCjKMiOg
         K+T4bjt0WvskjC5d9bJkDvgisM6jX/LMZfabdck12+eSPw7U4ot2nde889WR6X3Zfu+3
         LHselbd8W4mWvCLAJG1bS8J35BZD8/RnizJHzv0F4WoGavuX+n9it5j6jIVls8JlFlIN
         1L5u5Ift8P4dymlb2No9a8wscHXQlEv8F3e4ZY7n6hfGQK4vD4nn4QbyvJ1G0g7odC2v
         5M2g==
X-Gm-Message-State: AOJu0YwsQb5rX6AhRu6LQ72CdIQq+PqsXM4fidTwXrRoB8oRCFXo6WVi
	m7ZC0KM7Mpj94ArKqB2Qq5ZtK53TObc4v+Yh8Yher0CoH26OaSjudaW2oNOztA==
X-Gm-Gg: ASbGncv9NFF8YH0xTqY1K7M0dZ5Sl7YeUfe3kfnfo9RZWy38dWMLV9As23DTUeQrM7p
	IK0WnGTHEkdRgVCa8w9dlM+KjR3f/H4vjijphNnN0Y2ISvoJEpBshqLkgdH6OrtUmIzjOaDoXUz
	kw3j/ODpFqoDJrHmKsyyBI2a1gDq/cgXECaYWv1NgtGtmdEXHbPPNkOyXenMUtR/JF8KAVT32cx
	Z7qByRz4einhiQn6j5VF4rdVAxh3fjNhUgEre7sv1jwOrlRbbnZlfTvy9Cl6Jg14Meq8vsCmvSz
	iRp7ml8FXOuA9Sy34oB4/HOSVqNgsU1CIs9vZJwkMwxnu3WFEi80Eab8hxjlJmBT3cSzOWhCvzQ
	p88WY4Yg6jBgONJzLlIDlDr8yDxq9
X-Google-Smtp-Source: AGHT+IENs8pgUjrp9HbawogoxaWGW11HusBPn9tnMVNBPYE7QICmjrcYh1dOZ1rCCa91MmoqUuh7fw==
X-Received: by 2002:a05:6a20:244c:b0:240:2e2b:9188 with SMTP id adf61e73a8af0-24340b0171fmr23091391637.12.1756226359085;
        Tue, 26 Aug 2025 09:39:19 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b49cbbbaffdsm9614926a12.51.2025.08.26.09.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 09:39:18 -0700 (PDT)
Date: Wed, 27 Aug 2025 00:39:16 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] refs/reftable: add fsck checks
Message-ID: <aK3jNK82FILr2GuT@ArchLinux>
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>

On Tue, Aug 19, 2025 at 02:20:59PM +0200, Karthik Nayak wrote:
> This series adds the required infrastructure and also some fsck checks
> for the reftable backend.
> 
> Since the reftable backend is treated as a library within the Git
> codebase, we don't want to spillover our internal fsck implementation
> into the library. At the same time, the fsck checks need to access
> internal structures of the reftable library which aren't exposed outside
> the library.
> 
> So we solve this by adding a 'reftable/fsck.[ch]' which implements and
> exposes a checker for the reftable library and returns specific errors
> as defined by the library. We then add glue code within
> 'refs/reftable-backend.c' to map these errors to errors which Git's fsck
> implementation would understand. This allows us to separate concerns.
> 
> This series then adds some checks on the stack ('reftable/tables.list')
> level of reftable, namely:
> 1. The table name is as per the spec
> 2. The number of tables are consistent
> 3. The tables.list has a newline at the end of file
> 4. The table names follow correct index sequences
> 
> I also plan to send in follow up series's which will implement further
> checks and go into deeper layers (tables, block, references).
> 

Thanks for your patches, it's very nice to see that we begin to
implement the consistency checks for reftable backend. And I have left
some comments.

Thanks,
Jialuo
