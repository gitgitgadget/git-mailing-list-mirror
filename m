Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4653035898
	for <git@vger.kernel.org>; Thu, 28 May 2026 01:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779931376; cv=none; b=DhaTJ0p/mNoJUQPR3ooyIppyn0Mk5lX9XY3fKlCD8CwBsJYFdAO8X9tB+QKSDbR5V84FQ+975kFF/1TfE9wCDIbEUJrHXbW0NY87MrFIXiuZDOeXLlLTaEq6xDZMxOO4qUDuXeIu9anid5kBTEPAa1WDUs9uCcOrSCFA/xkdus4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779931376; c=relaxed/simple;
	bh=2W5sSaYMCXQRFkYS7ETd2uOtmwWReoY3Vz5pQvbpUxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JczlUwVkUlmonDM2K0OjFzgxK+hdSKteBEv+aB3zWnMFh85JrZnLEklFsmO75RgExdBrhgWCu/Ax8cSCovXMose7J4TLYIkL6oyCAdF9dV4uyR2FFZ4XM7RhAfDgeF3MYbQiNog4+e0aKketwEnePGXGGujlmOYDS5HGd25m/Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEMhaRCH; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEMhaRCH"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43fe62837baso7219879f8f.3
        for <git@vger.kernel.org>; Wed, 27 May 2026 18:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779931372; x=1780536172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qfS3Y0ROoJPqD00HrjFjylci0Yr6AL2srnm3ULeK7Qk=;
        b=ZEMhaRCHLURZjurnRudSQpTaCis3SSWEJpVMDYieO6NgZ/ZAoW72Gdi8TI1SgYkxbR
         SQWdRN1zXwdUAwWMKfvhtstVorSbZaiabMQWelAbdXON4aoTc1rnqE8HSzFdxAxIpvCc
         GjNMI3d1EMlTbJ3OHY/1aizetizfy/KlEnwBitPk+UwCNpMV6ZFULhBWYYuNxs6zCeRa
         Y9qyGHTKJPQTrjZJrq7MWWigsHYls8MqtyL53I5dI0Sy/vM5Mhf4BopjZ4Ca+mATfK5A
         /i92JBTb8dITbjd4Hepbsmg1enxWmcYZ7D/ZJRSzUvjoh9ecCpxO+vgg7SXnX+9/FsW9
         aqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779931372; x=1780536172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfS3Y0ROoJPqD00HrjFjylci0Yr6AL2srnm3ULeK7Qk=;
        b=E6kmJ9ZuEejUR5v6WsMZH4t/EQtOfOPiesyIJjrKHUeMvfXYKDianvDSMpYJ2SJTkA
         lfafFwcWSY4PZtCY6B0TyKF60rPWMteZmYTkBPl1/tQPoy1ib9jTlfq/XBxrI8ao847C
         COi33SaWOqTHS5rOdj9XOc4XUddpKM1Uv8QS2rdHS8EpUGZj9Z1pe7Yow32oMofXlrw0
         r5Mpb+RuIpfyvoGecb6qWe83KsAIZGIYVCrNes5t/Jbx7d+IW39EwOhTXsG8wAfYCzw2
         ZnGCr+dTOnkghKyz2VBxzWaE33uHFegnwEDLTUw/JEYWpM7PE9+YuaO6WRIH4zw2d1Jz
         vGxw==
X-Gm-Message-State: AOJu0YzVAmH4Qh5+c84sfg3/ar5BFAvFdSxFQpeRLNkv5q3WO3vrBzOZ
	lc3XIq31HDvMEQsTZupIM8c0CIdq1QAqpZaDNxeSGbxNGST/lKpuglV2
X-Gm-Gg: Acq92OEpULBV1bFykYy3JFm7f9C+T7ZLW5DCooq28drTYmaSuXhPBRhCqKDPhcs/GnW
	VQNZ3fIxrO0sNodKpz9HWYOKVnFbRaIaKC4KsT6e4++cUfyUwIdKYv6b1Day7GTfo0Roex9eL2X
	4wbJQPm21iZERTTawFoIBA3EOFM0h+FM7qTaHSeYLrpCFnSVarN8c9TXPzPdXQ+mvVRYtPxjx/c
	tD/qXCAcCAonT13womibBLm2Tii4kd5uX+hNsdvboMZU9WFXnb9EzZTN3lEfupQ6dCIQrZLlpV0
	OvMz3ZHUpaeKP2WBwmawMM/xRTy4D6MlX31OqWu00CFbMDxdI0Ru0BkdDPBnHZWNVZoeNkPrAy6
	NSOqmo86Ap3sGhw84IFRm1MZbpEgNXetc8MFJiBnepFUmVuY7VRHEm4NEa2mlYVp1Sx549gh8rz
	8c+OUCM9byxPMe/1fCE/jgDEGNsAJTZ0mBFKftvNSMSbw7S3pENOYWjzx17ZJ5lRt9N3O2YKUAW
	NTOgvELpayl0cB9pS184xq2OBZVSlClEg==
X-Received: by 2002:a05:6000:400c:b0:45d:d092:aca4 with SMTP id ffacd0b85a97d-45eb38a81b5mr39394055f8f.4.1779931372350;
        Wed, 27 May 2026 18:22:52 -0700 (PDT)
Received: from lorenzo-VM ([84.33.159.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ee2a12a69sm3164613f8f.16.2026.05.27.18.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 18:22:51 -0700 (PDT)
Date: Thu, 28 May 2026 03:22:49 +0200
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	fox <fox.gbr@townlong-yak.com>
Subject: Re: [PATCH] http: fix memory leak in fetch_and_setup_pack_index()
Message-ID: <aheY6bLM2gxtMDdr@lorenzo-VM>
References: <agx5tblaCZNsYEBq@lorenzo-VM>
 <20260519191743.GA2269222@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519191743.GA2269222@coredump.intra.peff.net>

On Tue, May 19, 2026 at 03:17:43PM -0400, Jeff King wrote:
> On Tue, May 19, 2026 at 04:54:45PM +0200, LorenzoPegorari wrote:
> 
> > Inside the function `fetch_and_setup_pack_index()`, when the pack
> > obtained using `fetch_pack_index()` fails to be verified by
> > `parse_pack_index()`, the function returns without closing and freeing
> > said pack.
> > 
> > Fix this by calling `close_pack_index()` to munmap the index file for
> > the leaking pack (which might have been mmapped by `fetch_pack_index()`
> > or `verify_pack_index()`), and then free it.
> 
> OK, I agree we are leaking here, but after reading the patch I'm left
> with a few questions.
> 
> >  	ret = verify_pack_index(new_pack);
> > -	if (!ret)
> > -		close_pack_index(new_pack);
> > +
> > +	close_pack_index(new_pack);
> 
> This part was a little confusing at first, because it looked like we are
> already closing the index. But we were doing so on _success_, not on
> failure. Which is a little funny since the point is to be able to read
> from it later, but OK.
> 
> At any rate, that is an existing oddity, and I agree that closing it
> before freeing the struct is obviously the right thing to do.

It is indeed weird that we are closing only on success, and not on
failure.

> >  	free(tmp_idx);
> > -	if (ret)
> > +	if (ret) {
> > +		free(new_pack);
> >  		return -1;
> > +	}
> 
> And here we free the actual struct. Good.
> 
> But this existing free(tmp_idx) is what puzzles me. We do not need the
> filename anymore regardless of success or failure, so freeing it makes
> sense. But earlier in the function we have:
> 
>           new_pack = parse_pack_index(the_repository, sha1, tmp_idx);
>           if (!new_pack) {
>                   unlink(tmp_idx);
>                   free(tmp_idx);
>   
>                   return -1; /* parse_pack_index() already issued error message */
>           }
> 
> So on parse failure we actually unlink it, but not on verification
> failure. Which seems like it would leave cruft after the process ends.
> And I suspect we probably we did prior to 63aca3f7f1 (dumb-http: store
> downloaded pack idx as tempfile, 2024-10-25), when we started
> registering it as a tempfile to be deleted at process exit.
> 
> So I _think_ we could get away with dropping the existing unlink() call
> and just let it get cleaned up at process exit. But if we are going to
> keep it, do we want to also unlink() in this error path? At which point
> it might make more sense to have an "out" label to consolidate all of
> this cleanup.
> 
> If we are going to unlink() here it may also make sense to just return
> the tempfile struct from fetch_pack_index(), and then we can call
> delete_tempfile() on it. See the in-code comment in 63aca3f7f1 which
> mentions this hackery.
> 
> So I dunno. I think your patch is doing the right thing as-is, but it
> may be worth taking a moment to clean this up a bit further.

The `unlink()` indeed is weird. Pointing me to the commit 63aca3f7f1
really helped me understand how the code changed and the current
situation. Thanks a lot for that.

I've tried testing as thoroughly as possible whether removing the
`unlink()` function call wouldn't change the expected behavior.
*I think* that it can be removed safely, but I'm not 100% sure yet.

If this is the case, I think adding a `goto` "cleanup label" is not
necessary.

> -Peff

Thank you so much Peff for going through this patch,

Lorenzo
