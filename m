Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C6A1537D7
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730134050; cv=none; b=l8vMHeTvhmAGQc0bB63m9wZRsjEpSEj/KFMf9lcJzMhzmFd2JuuVAXrL3WYtqIf4p2PMr1GEYzce6PhOMVMmASdKJ+d8faC2VbnDl2SwWi+qRethIDYMOnMnyOV8bcyxgj4hP5wXI+3RMmH+jIac/A+lbXD6V1/So+hpDKnaDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730134050; c=relaxed/simple;
	bh=dzsSz5oJje3tG04BbaQhhfYPPqS6265UqP97noB1ibc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3QlrZYYGb+8J7aqJ+gIUyx3MtRaBEcdwzn0ma19LA7XN/VXBeFhYmfshf9U0qIc8X6KT5T3LfU2Rrf52NJbM23Yu66f0DcFGOea5aRiSNYN+4rpGMqcVkZiqP8d1pj22mrTH9H9+i7B02mvbT9TPtpUv0ScaPRznjUZcNcVF8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=mNHms3Qm; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mNHms3Qm"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e29218d34f8so3416963276.1
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 09:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730134045; x=1730738845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dzsSz5oJje3tG04BbaQhhfYPPqS6265UqP97noB1ibc=;
        b=mNHms3QmSXPNkvoab/4bjCOapi3Y+QIkmaYtWO5uZQZVy3HTJqtaGdLfVt5lyuYui+
         Z1zombO79PR1pvaivNJ7/QC+XM7YNaoQdFON6W7T9U+CxnpgsgPq4QoqtHE6CcVDZlCA
         6c2W6LGf9ytmuqewq98Xg6KzamKxNDS3hkH6Mw2IOMgnsMwAw1rQBlPbl/NfoT+kQTNJ
         Ry4nuwFePNqmeSaRaxXM5aVmxZYuS61uaS9Tq6Y1RQHfJGytinFdRhSn2C8mEPWOIx5E
         k4hyVSJVcgdrMbyLTN8lSCWYeX8l0Trj5TseacEdJqRdVFuCCm0cZg5HbLVsgjMRdcKz
         QOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730134045; x=1730738845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzsSz5oJje3tG04BbaQhhfYPPqS6265UqP97noB1ibc=;
        b=VXrwzZBgOwuVSHmDa6TQQuCbbgrNDQnll+mDFA2oZt1xyvJUkXJKw5A0fcP4/lpxvQ
         NMzvLe6qQ8nKHUtWEKqXILSXzI7YwKzd6POmdQnNozjwFtU82q9UEu0EqGDPZyaFqdn8
         BCjjVmPI2CQmH2zUIEU+RXP8YuABots3OuXnKxHAlbYrASDdbTNJM5FytQKb4c77WLJD
         C/UYdDRyRmfg+cR6tOKuJ5vKhyu5QFIe/GXWEsYa8dboEmDC6ceXRKZdvjAlRBC00GyN
         MqBA2et27UHyg6ZUEwO3h751xoJFu6t+nFRk5FnLkMR1ASb15JKPeUXEl3mWQ7UIoLMT
         C4+w==
X-Forwarded-Encrypted: i=1; AJvYcCXnDBeadUPcMTj+cRrAanePgVnnGDYm1oH4s6kuzn2qPctz6w3pQ/U/Snw1yKiSy4nhLPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh08/3rsE9Jv/Neu27nzsl1R6snnmOKGNBmYwc6pCEG78XM3Aw
	TuieWMVhIbqL1TcMvvOn4VN+q+H7rSSfSnnpVkZG/a/TE3Ci45fqouVr4pEN+Ac=
X-Google-Smtp-Source: AGHT+IHkEnguEfTrn9mPIejlx5RnG2XxeBKjVhmbXE7xSZdmVqaWnwLoRFVS32BeJYDIGzm6SdArvQ==
X-Received: by 2002:a05:6902:1689:b0:e2b:d406:3645 with SMTP id 3f1490d57ef6-e30bc5fb6bbmr343412276.8.1730134045539;
        Mon, 28 Oct 2024 09:47:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e3079d51960sm1401190276.5.2024.10.28.09.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:47:24 -0700 (PDT)
Date: Mon, 28 Oct 2024 12:47:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, johncai86@gmail.com, newren@gmail.com,
	christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 00/17] pack-objects: add --path-walk option for better
 deltas
Message-ID: <Zx/AGrGTN2mQZqGs@nand.local>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
 <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
 <ZxbLFLDgCm6wLmB9@nand.local>
 <Zx8lHzDyqyBpzrAE@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zx8lHzDyqyBpzrAE@pks.im>

On Mon, Oct 28, 2024 at 06:46:07AM +0100, Patrick Steinhardt wrote:
> I've flagged this internally now at GitLab so that we can provide some
> more data with some of the repos that are on the bigger side to check
> whether we can confirm the findings and to prioritize its review.

I suspect that you'll end up measuring no change assuming that you
(AFAIK) use bitmaps and (I imagine) delta islands in your production
configuration? This series is not compatible with either of those
features to my knowledge.

Thanks,
Taylor
