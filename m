Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078A23AC1C
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 00:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742344764; cv=none; b=TsHhcGMDtoIKZ/zCqMt4YdQhZX4Hk4y1FiH/AhxhilYYmS0KiV3YY6kaweN332xa1RzMlc56eya4qpD4tkFH7fyYu02168kVgHDRP+jmcZhp3NEDEoW+a6VMz9UILOzJplpgLCwSRHuRBNS/WDiKpMij0hn/Q1JXmnGppOr/ktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742344764; c=relaxed/simple;
	bh=uBqZaOBuQN4dW9hvYCpbihIxi2xYpQvu/I4ZG+RCLWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKGmRR1nnxh/GV9aY5hL4lEYHp5y7lVcQwugR4h5yV6bY3Cq4t8lMHfHTAecurTCzHK1V/EZjTiXmBr2vt0Y6o5LcA/o7cH126qcO541jq/v3nSJ3TIon9XEuMdr8czrcy4/XnFMk/cQ90nXm9ahXR4r6Rf+827njM0wFnam4EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=PHCkwMyO; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="PHCkwMyO"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e89a2501a0so59877546d6.1
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 17:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742344762; x=1742949562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S8sKUxJbQ9xzWx9rMAz3hbG44bNZS+8DyBS0D1dvUUE=;
        b=PHCkwMyO5TqS8vAZljtM0f0EeyJEyqOMTorUJZs835yZPuqBehfRr71vl4IX8n6W8e
         IKgi5zfgtjkT1Yznh/V+y2AOfw78vt7uR4e4PlakbNqTxaYDB3T+s+gdIouz9T3Rz8T4
         ed5a0SbI5KE4slug1L4ms6/miYE4i8OkVUV6eEBpCtNoBGtyC4cwM4Ck7mL841R8lk2L
         aeh5L98Y2c+nSDoFYcy8OEbXbe3ADXOByWBDe2grhbedCZe/x9hl5mrzCxoRYuuX1PPX
         MSHyFHsjwoII6CWn0QV7vhXL8wSHhtbvrBZtWRHfzbuR3VwO5nncPQR2/QT0xjkynqEM
         WiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742344762; x=1742949562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8sKUxJbQ9xzWx9rMAz3hbG44bNZS+8DyBS0D1dvUUE=;
        b=gw0JcZ6+c+j/4mIjrxI99WIudDmjF2S5ng4w71vBMbH2HxYxPF5cr452Jhe7k1Khvt
         IuSWR42Z/5YFniDTTUYj76BDgtDuGeE4AsoeIatnVieF2ZxpGKDbI939AXtAsZuxe3yp
         UBbxLvRHTzaYw6ZYScCmwrymgjcrRyTuriShFueZZ8S64D4EBAp08lYWCIbuBogzcM0q
         prgACPw2SBVC9qoaoqiH6RR+fec7B5M0M8+sy5BY+q/7kHuEDZ+DkEnB5JcI3LXHkGLc
         nDcr5fJ278oj8gIjeCHLRkMeWVY0KR++eT5WUKR2PgVpeQifyjHN5R5MVofPCquno3U8
         9S4Q==
X-Gm-Message-State: AOJu0Yy7HwOpmTcpj7PDkT271UY40jpdGCN0pSbSJQgPP4GGPIYFiqs4
	qkc5ZHF5pGI2zZztTdcEgoS8Thz3id/XUbSQhfXSSxxMhhyZQQ3fhgxjTNSzqIvmx8VICicKWVo
	WOe0=
X-Gm-Gg: ASbGncutBIi0tCi5RsnFJYWWruDr3nhvA1djzsJL/rAXlIGeX2HMdUUPAiJYPctcH2v
	zA1rmkbfhRfH/t4waMRYZEP2/MMN7zLLWKF05TdvLai/S0qc+O+ghP3LTE3rYnjQIFajRiJ+9zA
	oirHVyWD6aChTeh2dktxFp2GyL/U2sZwspBZocmwdWmDXVG3z96r5JlLunxyu7JR9BUc8rDRsAr
	ROkK1l/bESc7HUPM7o3Un3qdfdrDJMV1NvOrD6A6SVuKQt464wye4yWoaGhBm57BJkFATQGze3Z
	kSFO1ycbZWam6UDnPhqRem7nxIRDVT6tY5ghG1vHPBClN57g/wrcDj1alJ6eB92App62FZ7hGgh
	pNqv6Fjrr9Z7Mh7Vs
X-Google-Smtp-Source: AGHT+IEjgqH6NPm3upfGpQdz5MTlXp/9PeSqVot8qJ2Z7H2Qw107lw05WUW3+GzajmCAdkpNE5GyRw==
X-Received: by 2002:a05:6214:c4f:b0:6e2:497f:1ec7 with SMTP id 6a1803df08f44-6eb294202b9mr9734476d6.41.1742344761879;
        Tue, 18 Mar 2025 17:39:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade209369sm73809746d6.2.2025.03.18.17.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:39:21 -0700 (PDT)
Date: Tue, 18 Mar 2025 20:39:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 11/13] pack-bitmap.c: keep track of each layer's type
 bitmaps
Message-ID: <Z9oSOCtt4ENAskbz@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <a29f4ee60d519318d36a8d3c812b4bad039b891e.1741983492.git.me@ttaylorr.com>
 <CABPp-BE3dfXa8xda2M2zMH_Qhf_RPggBpC=tx8qaDpCmbr9hWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BE3dfXa8xda2M2zMH_Qhf_RPggBpC=tx8qaDpCmbr9hWA@mail.gmail.com>

On Mon, Mar 17, 2025 at 11:43:47PM -0700, Elijah Newren wrote:
> > +        *
> > +        * When either associated either with a non-incremental MIDX, or
> > +        * a single packfile, these arrays each contain a single
> > +        * element.
> > +        */
>
> Drop the first "either", and the first comma?

Good catch, thanks!

Thanks,
Taylor
