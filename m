Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527E510A3E
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729546221; cv=none; b=m1dweVlo3xf2Qcm6+Muo0P3D2VNyEzY3qJ92ohsq7R3pcNkMLwf/TmP+VWB/MZv4sfOvAO358xAek9TiYfArhkbM7eiT6yX8X5US5cpaZ8rU8YfsfhuHV7ZccEDWhBcK5fjDpUrj6LKDs2Ija+kYy43EA6IsXBla6Cg06zYVHAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729546221; c=relaxed/simple;
	bh=mEOel7oG7a9EZJ4E/gkTRlWVLxZwFFXshqzN2aPC64o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rpk0JyFVlLtpcHDiJBxWs4lSuNRXVjNT/6pJyw31FdVIDPKYBPCh7qsvAtQiwY9aSJIY92tw+Jo0CGvxbQuyNQXWw8l7QxyoYbDvqoCRQRA5bibxjcvflWwh0Tn4qstgCYGBVmlskFQM9jr2180DNnNuv02uyduVmGVWiaUEYm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=pNUXjaUz; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="pNUXjaUz"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e38fc62b9fso49425937b3.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 14:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729546219; x=1730151019; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xl4CRo+wXlz5/8zABEocpe8gHjailD7+dgbhmLedABY=;
        b=pNUXjaUzy7EvicnveTm0hCWzsz78gy7cKeE88D69klPmgLqhZorRvcgD9UcGiL1Kix
         BeNMGSdioYZ7n4nZTrUiQTxoGTs0Iw50C4pzgLmMffBfLIf6O5B9zDGbZm/3l/XkBKN0
         a12O8tNIJTXTA0eFuFXjX6qoL6BPIi77+VOvx3uyzX4dUQByDJgfOwxHmozP/w0KxcIL
         fnZuiD/auVGAIzmt5elnG+VD6nd5xM9QHNmyltIAPTHWKhWL4/Io0CVASqFOSG9L8p8t
         7El4FtSeL6L+ibqDaDH7/m0QBo5ivaIbIJrWXSbbLSDbvgWoM8fWEBBbNXD0vtbjeYQ5
         UhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729546219; x=1730151019;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xl4CRo+wXlz5/8zABEocpe8gHjailD7+dgbhmLedABY=;
        b=vYlWVSC4jvmhETiZfgyfNLEdofI8zdyxttufOLjwI2lp1aBgrZiBIuvRBIQ7ANbgR6
         F4HX5d26REuuwvFUKdUlfhgMauL3ZKJSfZiZQkcU1ULBoLD7liyB1SO4WOu9JjCC/66+
         1XsvWHnZVJvgLj3EeDtp74YgAwsRdg+4WEMeBizZtKb+gaF9kzXN+3fYpprVOzAq7yfR
         nVD/xX6GEGqUZpuNqm1fyXE8Dlf4eZLlX5wQTYcnTJ9ICTJdPq5c/G8pvAXbwZ2TwZoU
         Zg+u5pqUhRuSY32oHRtq1Y3Nr5qeVnDNsN69ORPo7zoX9LLkv2pTyBE4bSrn7Rg8hVLH
         2VfQ==
X-Gm-Message-State: AOJu0YzlgdPgD1nJloB6P4rPHDag0Pend1mtoT8PQyqEpukHHSo06AlT
	pV/RQ40mAsA19gDKlRfhyx+bYynx+Me6qqjLE+SKG5MknZM8Cfj7IuhCQwli2b+EH+ih3cPu9pT
	d
X-Google-Smtp-Source: AGHT+IFz8e29b2IyhEx+JGTlV78XLT8I9qlsSeCeUKSR89l5rIrCqQ4OWmNUdaGQ/Wbyf3km0oo0pg==
X-Received: by 2002:a05:690c:9c0a:b0:6e3:3521:88ff with SMTP id 00721157ae682-6e5bf9a725fmr125343627b3.18.1729546219349;
        Mon, 21 Oct 2024 14:30:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ccb795sm8341197b3.84.2024.10.21.14.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 14:30:18 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:30:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/4] Documentation/git-bundle.txt: mention --all in
 Synopsis
Message-ID: <ZxbH6ZktKRzzCA58@nand.local>
References: <cover.1729451376.git.code@khaugsbakk.name>
 <39bdc5941c7b53c432966984fa79b81fde978e86.1729451376.git.code@khaugsbakk.name>
 <0eb35890-6193-43e2-b3ac-7c26b2360a03@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0eb35890-6193-43e2-b3ac-7c26b2360a03@app.fastmail.com>

On Sun, Oct 20, 2024 at 09:33:39PM +0200, Kristoffer Haugsbakk wrote:
> On Sun, Oct 20, 2024, at 21:14, kristofferhaugsbakk@fastmail.com wrote:
> > prerequisites”.  It deserves to be mentioned as an alternative to
> > `<git-rev-list-args>`.
>
> git-rev-list-args huh.
>
> git-rev-lists(1) has `--all`.  That must be were it comes from to begin
> with.
>
> That’s why I kept looking for `--all` in all the wrong places.
>
> This patch should be dropped.

I was going to say... <git-rev-list-args> is a superset of {--all}. But
dropping this makes sense.

Thanks,
Taylor
