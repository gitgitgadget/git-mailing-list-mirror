Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB502144CD
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 20:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110535; cv=none; b=lEsKV7xZSDwuyCifknILLSAO0rZxPP7f667fMIFbIYkwa9GVqYcWnf1MFVuDA7r9ihLg10ZZFKC5mgabYkPtxN5F4xjMA2xF8UFcyz7+EUKR9ldqLhwTwe8e2bWqx+cOvROdxiMOWlmsKcxACMGCfY3VkgulY5gjx/cfF+XEMSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110535; c=relaxed/simple;
	bh=klayNBjxk0AVJppWz0tdGc5aJ2bVSUaFK4WmnkcwFp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+3zcExzTfvvRXBslAWVh4Xf54ujYBXx/mDCMN8oCrjmC4rgKjfxbEc7fSPQq/l9BKkUFFM8gxoJwO0tyhWlpjfomhC54TrKjeuHb6kg0ar7klY9zywpwY2Yopwnpf1uuSs6rw7dVqldUVVD1qeatIHtE5kioRpXgzYK3fGtqHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=uPOKBLD6; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="uPOKBLD6"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e3c3da5bcdso3291547b3.2
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 13:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729110532; x=1729715332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W3ZEGuYsgLUkCkoffeXp/fxhxdLmhv1GKvUs0dcB9cY=;
        b=uPOKBLD6qEtQ+M+z9yXQsY0Hi7lWnEIIsfnNVGj4AWru3BT6RHE1/63WCdBo/Jbxuq
         IrVWUgBoa0iNdXhTy+4V7dGdrZ+z/Lpc9Pgt3CEXcaVADOatbMb4hRiSCryKIwnrh9fG
         qIHGVAnnaLUbTepOmeFihteSlK2LswXBMCXL/2ReoZjSV88BpuVlC/XtgM0pz3E+Mb6S
         BcwpZ7Q4z3/SNnvF7zapS+aAOOnKduJmq5ECwcts8gpGAYLT90Ykb1maUcMc6Qx5ZyAV
         t/69hq1rIy8CYJjFapoAiyiprsRsq4vPgxRPlGIMgfcICfS9Ot1BY4ognbblGDJxWRk3
         0eNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110532; x=1729715332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3ZEGuYsgLUkCkoffeXp/fxhxdLmhv1GKvUs0dcB9cY=;
        b=ijhhlFqx3BHpzHkBLBYUWDgIkRu7TgOoNwSvEUd7lSITTVBmwuLxPFab/YlMeQKOu/
         +NyCul9MCV2ag9sTfiEx3NRZ5eoyPmwpdOo0DujBc0dwPh2Xt3+HH/DpXvli9DLYlali
         +sKzAVXtzNIin44PnajOAFIEEOyc5p0a2vQGsP0qn8gz55G9+34KeqifKArLlkYPcEOV
         hqsNfbQZ7ku3gsuGZBDkMEkP+O/D6gOLtA/Vz+z8pPMDfB4ho3TODuG+8QHOILRgoouG
         bDE6yHgVhyHAvrofqOPjuDAeNXPLe4tdBqNIM54X3w9k2OVtbbqgDOYiCuhByg44Srh8
         bQdg==
X-Forwarded-Encrypted: i=1; AJvYcCW06z+T6IDrnk3R7FPRKNJ2AVyyKePk29d2IGJLk0FODcMA39bXwIQ3a3Cur99ldSS1J9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGfRYA162P1PTSa2ncvQM/ICXn6uQ82t8DKVsEeximn5zjMlV2
	qy3a1DtujFOOTPOC2kU6WP5dgHtdxEaF7ABpj4KJlkMC3SfrcGvfIA9uiZc+C9M=
X-Google-Smtp-Source: AGHT+IHLff9gIx35Sqx9XZ6qwuL4Vp8p3ERIQKZ/0vw86yebQrNchUB0YiLyoI2PDN2VYMDZs0R9NQ==
X-Received: by 2002:a05:690c:3304:b0:6e2:1626:fc24 with SMTP id 00721157ae682-6e3477bacf9mr149069217b3.7.1729110532609;
        Wed, 16 Oct 2024 13:28:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5d81d69sm8357367b3.145.2024.10.16.13.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:28:52 -0700 (PDT)
Date: Wed, 16 Oct 2024 16:28:49 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH] builtin/credential-cache--daemon: fix error when
 "exit"ing on Cygwin
Message-ID: <ZxAiAUdtddwk5RS7@nand.local>
References: <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>
 <20241016145539.GA703747@coredump.intra.peff.net>
 <20241016150922.GA1848210@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241016150922.GA1848210@coredump.intra.peff.net>

On Wed, Oct 16, 2024 at 11:09:22AM -0400, Jeff King wrote:
> On Wed, Oct 16, 2024 at 10:55:40AM -0400, Jeff King wrote:
>
> > > The logic is broken on Cygwin though: when a client asks the daemon to
> > > exit, they won't see the EOF and will instead get an error message:
> > >
> > >   fatal: read error from cache daemon: Software caused connection abort
> > >
> > > This issue is known in Cygwin, see for example [1], but the exact root
> > > cause is not known.
> > > [...]
> > > [1]: https://github.com/cygporter/git/issues/51
> >
> > I don't see any details at that issue, but I'm not sure how it would fix
> > things. From the client's perspective, they are going to see the
> > descriptor either way. Unless there is some magic that fclose() does
> > that a normal descriptor-close-on-exit does not do.
> >
> > That "Software caused connection abort" thing seems like a weird
> > not-standard-Unix errno value. Searching for it mostly yields people
> > complaining about getting it from ssh under cygwin. :)
> >
> > If the magic that cygwin needs is actually "fclose before unlink", then
> > that is in opposition to other platforms (and I suspect would make t0301
> > racy there).
>
> This all seemed eerily familiar. Try this thread:
>
>   https://lore.kernel.org/git/9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com/
>
> It looks like the conclusion was that we should adjust errno handling on
> the client side, but nobody ever followed up with an actual patch.

Thanks for digging. It would be great if you both and Ramsay could unify
on an agreeable path forward here.

In the meantime, I picked this up as 'ps/credential-cache-exit-cygwin'
in my tree, but let's hold it out from 'seen' as you note it racily
fails t0301.

Thanks,
Taylor
