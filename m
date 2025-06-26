Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822672CCC0
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750955765; cv=none; b=p2IBu99Xd8cNAzQZr9zWB3FCjCO72vbizqqq/AbTtj8E8ji7UW46B0nFt+BP4GmPHGnKgDUicSP8RMtBZCDFxLPcPzNdD4IYSHuAxB1R7CY8z7OxcFURsU2XSJkcmgZSNr5WGYqLAt/uE8drX/N4HCknSa2ZEKe06gR0994ylo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750955765; c=relaxed/simple;
	bh=cyTNBR7Ax0fye/mOYKLytvRfr2ZrdwI0AZAjBxvk1BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yexmnbskx0TZrZiA4saeLXQwPiB8HnlqPGp8qr/jcWQSD9WgdVYb6/DHWppB2UMvBcxJJFZ5yOGycUa7yAvcQBDIytz+TE1F+SkYXxBjCLZGzq0Fzt+H2VjS/lH+kn2DAKvUQIMU4/L0+HfQY3Ub7rhPl4gN0pScZQQ1DdYx4xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmGQfxSa; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmGQfxSa"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-237e6963f63so8935725ad.2
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 09:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750955764; x=1751560564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WIJsBEj1OPc+8FpiMZqIJcnOMAKqFAIXdKOEPNQSRHs=;
        b=BmGQfxSarXhuTuC/2i/V2VWVpbMcrvy7CE3Ss0fTgQgHg+8GTrHWadX3GCTdfGXsws
         gLIzhDPp7BXMoXmmKMHSDHRsELZ6R9a+Y1XGVsMG6jAZ3Xn0MewwNSpEOdmQ9ID/C30f
         HBxo/TT3vgY3luzGsqIcbjy6HBUSqpPlYFB5Z0sPxT8nWFzOJt4vQbhJ9vfMelslZBCG
         USxDLCrjEeJeBw2tSSK+UBMG41/vAlAIPU2viFG7ad38GkFymtbL7NN6W1usRO+ZF71S
         3ePFqxPMmJ1NLgUj49xqtlTmOqVnlqRqL50fPbWEfsmNZ4IhVaFhrnmDJckKITGinfx/
         4FKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750955764; x=1751560564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIJsBEj1OPc+8FpiMZqIJcnOMAKqFAIXdKOEPNQSRHs=;
        b=qrXISej7AYj0I4zcFko3vBjTFSHCQkkaNuF+C95QbP/51gMWKW3JTsZtHBTN4qiRCy
         7nywJ1SMB7b/LibHH1kWBce/uqoX/7vTNgcE5NdKQcr9uokkzTJSRwpymwfXe7exbP7c
         LOl5HLpd/cIWbzBpBeY1e1FMjaIVRQEVa+TMUWXfZoIOqao63SfiSgtnKsfi6SIeZIad
         NB0cZyQiKQN9Az2ozzXjevPCd1COyh52OK5kVnxgXsUnjrO5Z/4bANcmcfWfDjgzZBGx
         mL5vdqZ8eJCBWpabQ156VKKoeax8sLVOT7U4N9i7uxMea6ESr3bP9AXGyDUxAcSF55HF
         XE+A==
X-Forwarded-Encrypted: i=1; AJvYcCXW/h2tyzqtIgSEjuBkwndZMnhLdy7A4EEAhCPvp420lnPQMxylBNL04qPFYzZqeHN8ry0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAHTVN7fVvP8IByYwnYXEuVF24CZe667+SYXPQH+vfoxLfWv1W
	4Dk3OzZclgpwa5C3paOmB23ukR0l6RYMLy7sTdSjwpayLlvrEwJ8x3xOu6KqsA==
X-Gm-Gg: ASbGncvQaJG//bbkYfg69pHeA5hkJdT9iz4zVMOUACJ2ikCkrpP6+iQi/eyAYNv7e51
	HUjAROMKa6RAtOWZ0hH2n/aoYxlMkkvhFCbgRT6ZJEMz1x+EMgDaZaC++7iysjvBiHPdBI2txmf
	qmcZnzk4Fcc15m5JVLfw+mlQkT5EAJmlsvcRA79XV4BEBJeT2sU4abWAVOxGHPgvcJVPTSgzojM
	eIKsbowkCH5m1gwiH5rZe2ZxdrYoAPuVTeTwfMt4FNTVEYTyZ3xe/7t23x254scMapIzvXC8qpH
	NwhFsY0PfZEk38fpux2BNDdRL3Yo/SRDdEh7IkYOB3jpGZsNISZ1r3dsZSh+T8kgYAjnmnPB94F
	ioDXSFFWjqBiaaOsbSrl7aP9pCxEqxQesBA==
X-Google-Smtp-Source: AGHT+IGzh2NgMv5dh/W75scLi9d2+s2fup+mvg8bkmcdaJOFI6fXSl0f8H2uNOFzGPYcZY/TcyiKow==
X-Received: by 2002:a17:903:19eb:b0:234:909b:3dba with SMTP id d9443c01a7336-23ac43d45ffmr12875ad.20.1750955763654;
        Thu, 26 Jun 2025 09:36:03 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:3061:f32d:ab3f:87dd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23abe3f533dsm1977345ad.148.2025.06.26.09.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 09:36:03 -0700 (PDT)
Date: Thu, 26 Jun 2025 09:36:01 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v3 3/4] daemon: use sigaction() to install child_handler()
Message-ID: <wanrtwacxrjmmpfnjwxhgdfhlo4uvnktijnc2rxdzlnkpe5r4a@3b2e2onpqakp>
References: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
 <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
 <c66bda461f45791d278779fb0021f1e0369fe889.1750927989.git.gitgitgadget@gmail.com>
 <d7c86948-e0b0-4864-88f8-fd1222e0dffe@gmail.com>
 <xmqqy0teplfa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0teplfa.fsf@gitster.g>

On Thu, Jun 26, 2025 at 08:33:29AM -0800, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > Only because you have chosen to use SA_RESTART here. I think it would
> > be better to drop that and instead say something like
> >
> >
> > POSIX leaves several aspects of the behavior of signal() up to the
> > implementer. It is unspecified whether long running syscalls are
> > restarted after an interrupt is received.  The event loop in "git
> > daemon" assumes that poll() will return with EINTR if a child exits
> > while it is polling but if poll() is restarted after an interrupt is
> > received that does not happen which can lead to a build up of
> > uncollected zombie processes.
> >
> > It is also unspecified whether the handler is reset after an interrupt
> > is received. In order to work correctly on operating systems such as
> > Solaris where the handler for SIGCLD is reset when a signal is
> > received "git daemon" calls signal() from the SIGCLD handler to
> > re-establish a handler for that signal. Unfortunately this causes
> > infinite recursion on other operating systems such as AIX.
> >
> > Both of these problems can be addressed by using sigaction() instead
> > of signal() which has much stricter semantics and so, by setting the
> > appropriate flags, we can rely on poll() being interrupted and the
> > SIGCLD handler not being reset. This change means that all long
> > running system calls could fail with EINTR not just pall() but rest of
> > the event loop code is designed to gracefully handle that.
> >
> > After this change there is still a race where a child that exits after
> > it has been checked in check_dead_children() but before we call poll()
> > will not be collected until a new connection is received or a child
> > exits while we're polling. We could fix this by using the "self-pipe
> > trick" but do not because ....
> >
> >
> > Then we can drop patches 1 and 4.
> 
> Thanks for a suggestion.  I really like the "everybody in these code
> paths are prepared to receive and handle EINTR just fine, so we do
> not have to do the SA_RESTART" observation very much.

Except that is unlikely to be true, as the code has changed a lot on
those 20 years (including that it now uses run_command) and that we
had been effectively using SA_RESTART under the covers for most of
that time because signal() behaviour changed. An obvious bug:
(ex: 20250626161038.85966-1-carenas@gmail.com)

I think using SA_RESTART by default might be safer, specially considering
that patch 4 already exist and it is not that complicated now that we
have 2.

Carlo
