Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A36360
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 00:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709770388; cv=none; b=fnu8ahpDnMl3vpAdlxPL10JN1KGTSTZphiPQzzeowfsonxeAYCbFmYfabXcTxemHgD4GE8Mzt+9cPUCq6ifPdhRiO0Zu71Kc6/nTlG4PZBVzVw+yDPm0Gsx9MKogwijF76iBef1PBnlXUX9mrq4jReTiYOuESBz1KuGKlvAphok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709770388; c=relaxed/simple;
	bh=3s86gncn7KIZgUBPXFLcgYpw/BSVNRkdP2+ush8Xmvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/VOdFpWWskrpmr3dWYYQHFQe9zrQYtjYiYRGqb6o+dXW9r6RH0JTQRRBoHUS1dKOXQVcubouIYeYWCpOVdSnzZzA3rBoEFUcRYF7Iy1sZ8/UKZ+s8gVasFkM4aHmb3PvdjUgywxAnI6xbmKebn9SIA8xoGutHgqHAhAzEiRLsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=2ICGxAJX; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2ICGxAJX"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-788450cf12aso18652685a.3
        for <git@vger.kernel.org>; Wed, 06 Mar 2024 16:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1709770382; x=1710375182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tGj7cbmnIxhz54SS91of9RIAV65XJknsRRX+O+vZNck=;
        b=2ICGxAJXolbRrlb6FUDhZIsYREGelehXfN2gTmUrrrxZKFHIpoLdVNZhqUVz3l9wDw
         +K8bQNJO6qJpKs0iWWPUPQuyeSqjzWS+FGk4fuYXOWptza/TpVh/5r29h9VBQZRz6t2c
         DQ6qf2QrXxvSgKnmTVZR9E8gT2/cC6kYcktVO+RBcPqLlfRr0aJR8uPgLMmJ4Yz8WXZH
         SbFLiunZmWi3nCyKOuvdvl0qrrvISRABsqzEmOfMiE3oUCvlL8/nNdtp5YS7sp9gPbP7
         AZUq1HgCnPKg9buJJTMj5HRwnlhLk8g3yv7XtcVzRV1HD85jqpDMa0gQ4gafT6YLL/Tb
         YIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709770382; x=1710375182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGj7cbmnIxhz54SS91of9RIAV65XJknsRRX+O+vZNck=;
        b=bM2NB2kL3dunz2cpnPqRZKmbXaqDIWPoXPJHeAx5dWwxty+gAKMkezkmLUMmsBJKfo
         tgkuZxWX3m93DRPWC/ADM24q3VIf40WetLUpNshCugs8w5AP4GATkeoL7Ih0mUzyKchw
         tPA6ld6SXQj3rSkLHyYHZX1kS+YZuaOFYPv1Z2DyEYCENoHDm+G83ST1p/7wn8vPH/13
         rD5H2RJyzv1/uw8WXCX3CMcyBSZR25T7BchleBW6DB3gKrEietynynlJPvXu1KjJxKhL
         4mY4EzamWvu2mU96CWs7Tr3m+jXFo47G4Zc8DzAZID6GZ+Sy/GD/99pqd+ZnWx9+wymq
         BqDA==
X-Forwarded-Encrypted: i=1; AJvYcCWPlP3FqULumEZJ32r+EUVmEfhgadwLTo90GCQ69992o6aDao/W/xG2TGtu5L2Ek5jr74uYVzYyeGmzyFPK+AAuVr1A
X-Gm-Message-State: AOJu0YxiUF1PGNfcP9ge+ejXSdh2faIFXZP50GBMeuGmGydV5fpNo4Jd
	sw9uT3yNDZh5mqGP1mBHgI/X5Gd6ZFFF4zGpG2u2zN5YLqgPc+lzs0gY/GzXjhlh6zy8xiM+vfW
	oyxo=
X-Google-Smtp-Source: AGHT+IHOAMMYdqA406oGramSbBXDSt3ofo6NXm8i4yQyvDNCwfH8wi58jcCuI0aRakhNxEhLOftFMQ==
X-Received: by 2002:a05:620a:8107:b0:788:1b28:b977 with SMTP id os7-20020a05620a810700b007881b28b977mr7089633qkn.39.1709770382204;
        Wed, 06 Mar 2024 16:13:02 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id dx7-20020a05620a608700b007882d94cdcdsm3310507qkb.126.2024.03.06.16.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 16:13:01 -0800 (PST)
Date: Wed, 6 Mar 2024 19:13:00 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 0/8] builtin/config: introduce subcommands
Message-ID: <ZekGjDD6TjF0FYXy@nand.local>
References: <cover.1709724089.git.ps@pks.im>
 <xmqqil1zs327.fsf@gitster.g>
 <ZekAWSqr9qb8FIAD@nand.local>
 <xmqq1q8mq5oo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1q8mq5oo.fsf@gitster.g>

On Wed, Mar 06, 2024 at 03:52:23PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > I don't have strong feelings about this, but I wonder if `--urlmatch`
> > (or `--url-match`) might be an argument to the "get" mode of this
> > sub-command instead. Something like `git config get --urlmatch` feels
> > much more natural to me than `git config get-urlmatch`.
>
> I like that, too.
>
> "--get-regexp" may also be a good candidate to be folded into the
> base verb "get", with "--regexp" option to tweak what kind of key is
> used.

Yes, definitely.

> Could "--get-color" and "--get-colorbool" become verb "get" with
> "--type=color"?  The other parameters they get are somewhat
> different from "get", so that may not work very well, I guess.

I'm somewhat embarrassed to not have a better suggestion, since I
vaguely remember working on the `--type` option as one of my first
contributions to the project.

Indeed: fb0dc3bac13 (builtin/config.c: support `--type=<type>` as
preferred alias for `--<type>`, 2018-04-18). ;-).

Thanks,
Taylor
