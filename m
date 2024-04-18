Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E30815F323
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446527; cv=none; b=Vf8prre+ekO0Cph3pdY2XOxINITb7LWoJJLG3VMbGPPzg6qac9zA2ou+CzA+hWxjuHj0NjRlY6VKtSOYVh+jwk+Be+ZLLjiIleCjPD71o44WnqLQlKdirWjs5dMjytRW9kMJrOjys12qxDs19AIdMW41BeVj6WNfujR2CW2Jf0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446527; c=relaxed/simple;
	bh=6i1Ys6mPZzJHk1R+UeIzqMVB3fNLK3B0SDA4oC1V8QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEnnJIqf42hF9MyfndpOZ0JNTMuQ2Qh1WZ1YY09Kp0RFC711EjFB2a1/GI8Mh3SwjmYKajdlo7cawGAtZcoBJsH55av/naiLtrZ29rLNrlI6EIArKNOjvRnbIXUpDCs2BBCXarCp9pvgTOqG6CPdf6Rv1bMkw5aZ0hrUu68mPmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=MNE1+GX0; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="MNE1+GX0"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78f0e3b6feeso27819185a.1
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 06:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1713446525; x=1714051325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zIxeiAMyl/CUrH44D4Zd5aHVh3m2dIRbh84CP/9R3BM=;
        b=MNE1+GX0Fhm2x/RIiPQcoP3OReF+vknlrAKMyCYxI5vw6brNHauMewsw6P4ko5BE2N
         htOVYyeCu40E106IbCUrkUtUFq5peN3vsChd3Rg0KAhbcP9NYMuxi9Rs/yjoa8sKDStb
         KIc8u6C3/2LCpOl25OBzEAzGIdzNNsiW2y1NfWkCB7GS7Rkrob8oKX78ij4LVR2ccx/D
         GgCw2eCM5Y/akO9t8SqNwm4dMXLwmEZmB9iwVyfIbyicx967v+rOqeyYc8U19p4Y/dib
         wscjczZQ5sV2dZiDuU5m4+781FR/9q63VM+W6V5HAQYcs+S2fge9fJh4uUyWvaSvvK/y
         nJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713446525; x=1714051325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIxeiAMyl/CUrH44D4Zd5aHVh3m2dIRbh84CP/9R3BM=;
        b=ONqf8iD3+eJ5Ci1XJF7iw0HRt2bx3mMZGpp5HMwPHSP4bjoCTP24RCvpQyYchyT5QL
         yTAZuRGe9PZwxSwNXe1MNE9RKruwHYNThDHGoej6ZJkWwzmR6pvKgDD352guqtUv9UI6
         eRcQYY0qlJTRclvAap+zsMiBuY4Dt/Z0Ocl2ReExg3wN9HsAH767tSeWJT4NqIvtbf04
         2G/+fBDzrtIvLJC7T3ufxv5F1zrlUdcfDq50mzs5hZ6yk7CaMXDY8O/1LIMVHYV8P0Hg
         ofaY4W8PdoHexB/pLQKeKZYoupr2ZVavJzh18TFBgi3kYYTxKkhyiM7V0CzctLxn+h9Z
         LFdg==
X-Gm-Message-State: AOJu0Yx/jM68RG1QQwe95UiY+v0WpqLTM6npK5tWUL+tfME0wRvdaz2J
	yLo8BBYGkM9B6xyJizH8PaKpzTC/u8SfwuMw2QGnEi850J8pO+HXSln6k8AcqbA=
X-Google-Smtp-Source: AGHT+IEFNeMGjXwFvQtxDmVGoadVnL76fqytcNdGM00ns08lWkCkBD22Duhd5yP4UT59rzlcNDpYRw==
X-Received: by 2002:a05:620a:404b:b0:78d:612b:ca3d with SMTP id i11-20020a05620a404b00b0078d612bca3dmr3700046qko.11.1713446524919;
        Thu, 18 Apr 2024 06:22:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t26-20020a05620a035a00b0078f04e04842sm619110qkm.132.2024.04.18.06.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:22:04 -0700 (PDT)
Date: Thu, 18 Apr 2024 09:22:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, blanet <bupt_xingxin@163.com>,
	Xing Xin <xingxin.xx@bytedance.com>,
	blanet via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v2] midx: disable replace objects
Message-ID: <ZiEee8ySuy6kCvBZ@nand.local>
References: <pull.1711.git.1712495507815.gitgitgadget@gmail.com>
 <pull.1711.v2.git.1712554017808.gitgitgadget@gmail.com>
 <xmqqplun6aws.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqplun6aws.fsf@gitster.g>

On Wed, Apr 17, 2024 at 12:34:27PM -0700, Junio C Hamano wrote:
> "blanet via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Xing Xin <xingxin.xx@bytedance.com>
> > ...
> > Helped-by: Taylor Blau <me@ttaylorr.com>
> > Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
> > ---
>
> I think this took the review in
>
>   https://lore.kernel.org/git/ZhLfqU9VNUW+2mmV@nand.local/
>
> into account and is in good shape?

Yes, sorry for not explicitly ack-ing, this version looks good to me.

Thanks,
Taylor
