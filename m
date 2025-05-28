Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE0EFC0E
	for <git@vger.kernel.org>; Wed, 28 May 2025 02:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748397623; cv=none; b=NivpKl2L73UfAsetf6P94N7cH6XplAeVguMk0Yuih/HlShoVf+89lkc8hC9UPDY0HCrx/GcmBEsrBLSbq9yhM4wlV2MryN3QkX+xLiqf0kqDebt0oEzK8nEPUD2v4fJgCqK8rQHKOXbX5N7Mox+5/emcHiwxVmgEDqf5N9XFvSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748397623; c=relaxed/simple;
	bh=uRx3u3VhTbFCTxTs6vQg6Ftxk/kxaf/6qHluV8wOyCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWk7VJ2LcWJlZjd0EUB+BLOIBWCBRrWfzrRxOjDoGRiVFoa8tC51FRqsYJN6Vzc2azxFQ9y+QOnL/Jw38+u+I+9QYMVFXWwIwYuQu6fuYTSlsp/4pfdzXEPbo7MmXYXMnNUb0Lr9if9lzU8zB5b9+pZC7pkVedYec/FeYRaODJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=IC8q2D47; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="IC8q2D47"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fab5a9a892so13488156d6.0
        for <git@vger.kernel.org>; Tue, 27 May 2025 19:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748397619; x=1749002419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5D9LDHvJUMWrnLIWTsunrlluqWrA3depm3CJfI8hQX4=;
        b=IC8q2D47IXrQ7uFg4hstTgkjVHJtZN7SBnnJkkYej0z9phtZufWelZsjkj8hyW4Nvj
         9/YBof/PUugkV0haW6Gy8lsJyBTu7+2xFSKAB4vfATLg3/PTc1P3Eykrx3K7LfNw82D/
         2nHn/0JM5lATdCpBoE0tSQzwqDkJs5JimLx8OHd1NBsl0+4LojX3klX0KB65IbjnXtJT
         OIGu7myJ0R1bXpRPL9fu9oVKggIfjCt1wRISTXtqU99KJWDB0FJFcI179V9NfDSKSx2Q
         bFqEZwfJA94P9j/zguq1nWpvacS4t9NfEzZreP4/e4zmx7jXnxBsAjkyHiylUfVdW3qk
         T9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748397619; x=1749002419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5D9LDHvJUMWrnLIWTsunrlluqWrA3depm3CJfI8hQX4=;
        b=MKhTW5FaDQn6oKSS99tNlS72RGHgtbt6mdQweF+Cvvn6L6D0y/hiVqS0XICrNjlILX
         R2OYHUFuRFlV7qCS44cwCSvxhIPgSMFCW4vo6mc2p5euL3fRueof1015T+EbamyGopxE
         0ol5fSvI1KVynaKxM2kgqtzlZ7J8JbTy4oSXBvwz17qAklk7uklTQGPLNoVKUxgOA/tn
         4brADok3CKflI0Zve9JJrE0fY3hZfEaxxCLFVi94af7sBnJsVKfX93JOq2cKRoL/lzBy
         cslpVu0xrElI/ujA6shELGFAsPvii0y3umqlgG1wp0GvXIhe+xAJh4s/PrgbRzCrkWIN
         RK8Q==
X-Gm-Message-State: AOJu0YxTrgVFSJKNEBITNs7e6Y8sjkRk9zEQguPniNtmGu1JkP9GO9jF
	fB4zzIjefBJpxmXI+ycOJcgvR7xdxM4Q+xMX+n7xUywm4bRhcONxpTVE3/WA4H/wXJQ=
X-Gm-Gg: ASbGncvyMqohOi4ZLsjo9HT5UUATNuG487ouZYk9ir12V++AXJxVCWjhcGscznENTyC
	AeX5PiU/fl696INJ9ndHgiwIr7f0R5LroKb3wp/vnBlmByxGiYZbxoWx7kMmTEZMOHlh8w42hfU
	nzWhMCmRgN7rAtAFqxDkgFpNHr1Y24dS8fWfIgUrgNJ0biv0xgwu7RVGczEfsrZuYSsHsdXUSWA
	BzWCP0oCzfhGxv+527VJaqqhxJfUCt6VTNcW9KrWJawEuZqxbeZrLFZ9Bt3WxjFA3HNkHUqMtOy
	QHRx/2a4lKgJNuDhZ/pDEy7ViOucXr0DbdSJtZZVsSeL7cLc2TYa7dMjx2KXid/xSvJKesie+oy
	Y5jr+P8UmSxG9fXPo9KcNo+M=
X-Google-Smtp-Source: AGHT+IGd484rP/pG/knSQirsx4ElzI5m+Zx2gXl4o3qJ8edySAkHAS/terOKanEAY0Mv3UbRUSjaPw==
X-Received: by 2002:a05:6214:401b:b0:6f8:c621:5a0c with SMTP id 6a1803df08f44-6fa9d29c6d1mr306808556d6.31.1748397619353;
        Tue, 27 May 2025 19:00:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4a3c792691bsm986651cf.25.2025.05.27.19.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 19:00:18 -0700 (PDT)
Date: Tue, 27 May 2025 22:00:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] pack-bitmap.c: fix broken warning() when missing
 MIDX'd pack
Message-ID: <aDZuMciIqrP2aPq8@nand.local>
References: <aDC0bK+NOuuVvQtb@nand.local>
 <cover.1748198489.git.me@ttaylorr.com>
 <ad7295b11b2e2c48d859623bf1bcfd92ef15ef9d.1748198489.git.me@ttaylorr.com>
 <aDQXBBrL2Ni69gwE@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aDQXBBrL2Ni69gwE@pks.im>

On Mon, May 26, 2025 at 09:23:48AM +0200, Patrick Steinhardt wrote:
> On Sun, May 25, 2025 at 02:41:51PM -0400, Taylor Blau wrote:
> > diff --git a/pack-bitmap.c b/pack-bitmap.c
> > index b9f1d86604..99c4927e9c 100644
> > --- a/pack-bitmap.c
> > +++ b/pack-bitmap.c
> > @@ -490,7 +490,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
> >  	for (i = 0; i < bitmap_git->midx->num_packs + bitmap_git->midx->num_packs_in_base; i++) {
> >  		if (prepare_midx_pack(bitmap_repo(bitmap_git), bitmap_git->midx, i)) {
> >  			warning(_("could not open pack %s"),
> > -				bitmap_git->midx->pack_names[i]);
> > +				bitmap_git->midx->pack_names[i - bitmap_git->midx->num_packs_in_base]);
>
> Doesn't this cause a negative array index though in the case where
> `prepare_midx_pack()` returns an error for any `i` smaller than the
> number of packs in base?

Nice catch, yeah, this is definitely broken when the value i is smaller
than m->num_packs_in_base.

This is another spot that would benefit from similar treatment where
callers (outside of midx.c and *maybe* midx-write.c) access the
pack_names array through a function liked nth_midxed_pack_name() or
similar.

I'll adjust this and send a new round.

Thanks,
Taylor
