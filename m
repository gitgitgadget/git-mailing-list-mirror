Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6441E10F4
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 00:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722560326; cv=none; b=d/7SLhRW25JDU80F/xgM3IA/ofhXc0dz1M+zqFD7DAIqYgDm5CjC7YLd6vN2MHhUGMXX2k6++SN+rRv5Y5IFh6PMfeBPQI8Vz5ngi0C7a7g5cC6aoHSEKEZzv1ti+CSrkhURnhoCnzAplHlj0+lIy6NcUD4w9gLWmHVOnsuO51I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722560326; c=relaxed/simple;
	bh=SZrtoxE1orzMzIN/pJIR8MJmfoZHIzbsFTTX3upmmq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGkZ0WutvYOSbZISUYm3+5xnIkueUeFi3wLNb7zJ1R7ECcWOZ6smhgTe32uKaMCcylbBhwFI835zMoRLV3112c8agJPK6d6ZHF7jH7L8aR6J7GCZrxpE0pSkg1rWuwe9ETafZ9tLPizXyaV9royvlsuaDcVNRopFimFwZRMkg10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=nXmIrgbh; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="nXmIrgbh"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e0b7efa1c1bso5289707276.3
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 17:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722560323; x=1723165123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJ9BeOIOeBHT/IS4zlB9zkDOy2abXQ1s4caEm13X2Kw=;
        b=nXmIrgbhdxvsfpccNL+GiCH9Tu4Zhkl3zPCh/gPnrVssI05VppfqdrvLEH/FaaW9qr
         d4A0o/EwzYZOoHsxwwHKrt8AuuebcJtrgzzdCVHlYkqCFdnOniAyGHw5qnwoVTTC3ZJ8
         YMPPuWyIC6qUQI1657R+dcl/7jza3D2MMco8+FwQ4D2FqZ/McpTv/D8zn273usFByjVM
         +1AVCR1zUrFx6v6dl5O0m5Dx+G/XXnPd+JjNrUr3Ngt1sG+YP4rkF+g5w/QhElsG/zgW
         jj/ZLXTkJoBYxWIYNtYz2i2lOXIMlGtpoY4oelwUthXNgb8b0VFrAt1DKCxjSuvFuFpT
         MmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722560323; x=1723165123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJ9BeOIOeBHT/IS4zlB9zkDOy2abXQ1s4caEm13X2Kw=;
        b=jKIfnYiHAOkNtpnA82LflTMtD4GYgrgRy8hruHGdNM5QzJL2F6cTmiMHL5yVYzi+TP
         JSlG58ehnaLqlPFFBVMrWQLDyN/HVZDKegKLHdEsP03pK0as7TZ3/tIZlOndcIyOkKP4
         UYu4Pt0O9HFdKHGzCRyBvy0b+g9UfyWHoIiomnxWaLgItQj9L3C505XSC65q1qzwT+u0
         InvISDXTMet5PoIxvidkBBV1ziO5KuuAAFprSP+dWAfKD0k1SfSoMoRzdLWwtIePj33S
         nBSu3Oj6aq6AWnyaGBuVo4yr9j4Iez45nk6TpkdhMI6ZZlQBdjU96kiuDhvFFbX1k5e9
         w9Yw==
X-Gm-Message-State: AOJu0YxebKKEVNu04tL/RJEEuA4G7W4cLWY+Q+XPyzchks3XOT9c8hjv
	V2fdxC+8QpuWoY/lyYixUsPt9bXQ8oe7gnz/nSAHL+S5A8N6gh9uebPi3CMolPhofSqOGmeMAug
	N
X-Google-Smtp-Source: AGHT+IE2XCGK28KOUIbVusQqpct97eJKU3isglHIHpTr0UvPteaheuSXV/sc6pYqigeZYshxs3ubXA==
X-Received: by 2002:a05:6902:1028:b0:e0b:c402:b04f with SMTP id 3f1490d57ef6-e0bde33e978mr2262205276.16.1722560323187;
        Thu, 01 Aug 2024 17:58:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0be534e670sm75533276.19.2024.08.01.17.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 17:58:42 -0700 (PDT)
Date: Thu, 1 Aug 2024 20:58:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: [BUG] 2.46.0 t7701.09 fails on NonStop ia64
Message-ID: <ZqwvQUAqVozGHG/t@nand.local>
References: <02d301dae43d$2202fc90$6608f5b0$@nexbridge.com>
 <ZqvgmYl8BTYvsSa0@nand.local>
 <032201dae461$c7bcc9d0$57365d70$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <032201dae461$c7bcc9d0$57365d70$@nexbridge.com>

On Thu, Aug 01, 2024 at 06:25:51PM -0400, rsbecker@nexbridge.com wrote:
> ls output with second resolution is here - the file system does not have nanosecond resolution despite showing zeros:
>
> /home/ituglib/randall/git/t/trash directory.t7704-repack-cruft/max-cruft-size-prune/.git/objects/pack: ls -la --full-time
> total 11
> drwxrwxrwx 1 ITUGLIB.RANDALL ITUGLIB 4096 2024-08-01 16:18:55.000000000 -0600 .
> drwxrwxrwx 1 ITUGLIB.RANDALL ITUGLIB 4096 2024-08-01 16:18:48.000000000 -0600 ..
> -r--r--r-- 1 ITUGLIB.RANDALL ITUGLIB 1156 2024-08-01 16:18:52.000000000 -0600 pack-68c6c8c8538900694c32380ac1484201c8b60d8d.idx
> -r--r--r-- 1 ITUGLIB.RANDALL ITUGLIB  217 2024-08-01 16:18:52.000000000 -0600 pack-68c6c8c8538900694c32380ac1484201c8b60d8d.pack
> -r--r--r-- 1 ITUGLIB.RANDALL ITUGLIB   64 2024-08-01 16:18:52.000000000 -0600 pack-68c6c8c8538900694c32380ac1484201c8b60d8d.rev

Ah, I suspect that this is even less interesting than imprecise mtime
resolution. The test expects that the packs are larger than 1M so that
we can exercise writing multiple cruft packs as part of the setup.

But that pack is only 217 bytes, which wouldn't trigger the split. I'm
suspicious that it's even packing the cruft objects at all, so I'm
curious if you can find $foo, $bar, and $baz in the cruft pack's .idx
file(s, if multiple) after the first 'git repack -d --cruft'.

Assuming they are there, it's possible that setting repack.cruftWindow
in the test repository would do the trick.

But I'm suspicious that that's even what's going on since
generate_random_blob()'s first argument is a seed, and all three objects
have different seeds, so I don't think they would even be considered
good delta candidates for one another. But it's also possible that your
generate_random_blob() behaves differently from my own.

Thanks,
Taylor
