Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09301DB95E
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757973843; cv=none; b=W9MZhtcM6Z5gPW3uBgqdSRbJkRvDSbJU6VyNwYjPDZLO5toRiTSnK57LfMMl8rwRDaY31vbx5+lGLpN4oSLzisDq802ha6T9fyvOZHYN9W3Ug1C+y5M+dXF6HbujmDubI2HF/8eCTG9ZsmP4ZrCT0pR3Dj740rR4b41C/Ia5ZLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757973843; c=relaxed/simple;
	bh=/V0VgJreO7LUSq3o+zHEnBgM8upecXTW7Nfwj24X1TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwVVtjCYclEXiiFfEAeMdF80SjLP8/2ob+tLLvKivd9Jfy0yYx/bofjZiCLoDXUK4LkKO0bbpJGTiF0jRpF6ZO6rsrFu+ZcZ5FXAPBGR2UqKw6s+/JzoAEp/FSAHDE6rPDTC8n0pyCa0EB1dLsHkx9XF8t612xMrCVVQFM3Qf+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iigls1SJ; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iigls1SJ"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-43d271944beso790462b6e.0
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 15:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757973841; x=1758578641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JUZz9HoBkufSOpTNfRuNkmSyWBilVtxZXeoDfEtyC7k=;
        b=Iigls1SJz3WjUUcl09LhldOy129IeX6aWxpZuMPGZWcNpqBHI5A272qmmRNEAs9Vcv
         itrxZ4QCMWaHkdyBjbyzAWGEaQIDkk40ZqLHRvW8Ln1fuIMegLnn2JMhkFYwl8q4Xppk
         Pf/sG5hxCzad1+d0i8jV+cPqdYbyQvPkIY2AisKQuIAMEkq7/j4pghntwCxS44GdQIXN
         ycb7lUnnKaeIrpSJpQpciwuXizU8ZkD35pXO6O8I//O9RczyUmBHPuPyv+FJPBqexfgQ
         76mlxRmBG0M7QnkjrPxPWO1G4kL5O7Lgc2TteU0Aj5y4PDnA9EBqp33d8m9IrQcmkjM9
         DYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757973841; x=1758578641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUZz9HoBkufSOpTNfRuNkmSyWBilVtxZXeoDfEtyC7k=;
        b=io3Ps1OP5GcBgVNIw2BVLiS9ld2mbo2CvsEYUa2oToe238BYqDE3e9o839MF9i3tms
         aC7ZEX2oWiSqoiEwdyMAO2yBl8hjgF7QBjL6fFg/CiioJr0KXxgBoaCgv0dYhOulBjOG
         9ryqamOq9Nk0tWUQTccrPArRqmq04EIrGz++Bo1ucuTh9Uj79Sijm0Dx89nlw03x+Log
         XfeMh03fWtc8Wver9hl2JsmZE3uCv5vwCvgvm26LIiBJfypd4nq/FsHRBu/ptLL+fllt
         2JS3asbneRRCJtXDHKinxvXHBca7ko45ADXkDe+FIUsmzwTw0zKzQjZ3YqL1C4/Z58fr
         tovg==
X-Gm-Message-State: AOJu0YwYrUjmqdnXoAuMbV4y8dKA/vMwJxOEoRilF8BKdR5zLcOzdLPC
	Jj6Cn3lNl7qGhu2T7HK7B9ZSvBaTMrkFLxYcwQ9rM+T6BvrTxECW4MD6YfR7BA==
X-Gm-Gg: ASbGnctRhg3IDdpQuYjiaKa5mSfw/OSnjxYRHD2L5i9Q4Gi34a4LYmgtzhSUiKm7X13
	ushH1ZU772X5d4yDBEZiH0gCTgruNg6w8utkSjQ1TiN9+TNQUTxPL8ycd/XqLoLCMLsVfda/IJ/
	LjIV/ychYE3PEJlD9yjM4DOih+ZUiEui6L/0vYS/BySCavvx+Ux3jO06kUbplo3vRJFfGuRueth
	/IGHmu3L4wf5Cb+YGadYa27Ythiwn1zDGhg659fIoJnTCFoUDyouMWtY8FI2xm0mfY9Qq7dToBK
	PdnRKQSl3YRCDQ7Ofm22UPCOisGOlbgvtSxaNVQeq9jniz2l0XBRt7Fd9EPAJ1LmTRwykDChQtE
	KNebtbBv8/NmpjTCA
X-Google-Smtp-Source: AGHT+IFL1j3fabj9MGdtJEru0v9hGcUut+D6XgOTzVdXdPj1/CVOKR51h7rjBnfP26rzkdv9XjYvOw==
X-Received: by 2002:a05:6808:4f29:b0:43d:20fc:2c43 with SMTP id 5614622812f47-43d3f3a1871mr19935b6e.14.1757973840828;
        Mon, 15 Sep 2025 15:04:00 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-43b82aff516sm2591670b6e.31.2025.09.15.15.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:04:00 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:03:59 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] builtin/update-index: end ODB transaction when
 --verbose is specified
Message-ID: <vtj334m5xckvve43nm332q5f5dfiy362wibygjh2ue5eu2g6hs@3o47ca5pha7u>
References: <20250909191134.555689-1-jltobler@gmail.com>
 <20250909191134.555689-3-jltobler@gmail.com>
 <aMJu7vPKfnxt9UiC@pks.im>
 <3cmqsfz5j2h36mw7yzwbrgfgchaettcnidvkiboqqktkm3dd5k@h6rmgjnqdmq2>
 <aMetaZxCN8CDsr6g@pks.im>
 <273dcsi6xmsdb356adxrlhh3renuimnl5wopfzkxxnryi5fmwd@xud2pvwdz57g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <273dcsi6xmsdb356adxrlhh3renuimnl5wopfzkxxnryi5fmwd@xud2pvwdz57g>

On 25/09/15 12:08PM, Justin Tobler wrote:
> Looking into this a bit further, I originally thought this was so you
> could do something like:
> 
>   $ git update-index --remove foo --add bar
> 
> but this doesn't work because as soon as the --remove option is
> encountered, all subsequent file arguments are treated as a removed.
> This does mean though something like the following _does_ work:
> 
>   $ git update-index --add foo --remove bar

Whoops, in both of these examples I meant to use the --force-remove
option instead of --remove. Once the --force-remove option is
encountered, its codepath is used for all remaining filepaths. This
leads to the behavior discrepancy between the above two examples.

> This is probably unintentional though and rather awkward. Due to the
> nature of argument parsing here, this interface has several other order
> related quirks like this.

Grepping through the codebase shows that we also have existing test
cases that rely on the existing git-update-index(1) option order based
behavior in both `t1001-read-tree-m-2way.sh` and
`t1002-read-tree-m-u-2way.sh`. Still not sure if it was intentional, but
it does seem to be used.

-Justin
