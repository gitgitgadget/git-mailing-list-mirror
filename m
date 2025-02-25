Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00D91FC7D5
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486841; cv=none; b=HmGAwRN6ZIn1nL98mNaCKrlbaA5mRF8WOP3NO/VPVe3nz2B+uptErxTDNs0OLHs86JW7BPFSK7V2iO/cLHSScFG7yhkQg9hnVOWlH4ovTLsVhfTBK8O5cCgXY2CXjG2p+PP7ItOs18ftf+f8yNtFUW47M+9WrHmC3n4rgafZHMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486841; c=relaxed/simple;
	bh=tlXexNhMEqwlOYDNd+w8n3DSe4TrJQAIS9fSDRlPv6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1el9aTrxrFzRA6YPmd4v+l+7+atKJ2jH/DtICmwpW1nS+Ad7s/PHL2N+YNvL/R6EeMjhxHjJXFf1c28u3nwMuERGPZETBXwb/qcMivoG7cNJ1VG66XhgMOFYFmGqcZznhAPTx3h86BKhPOw4beD6dLpgrunTvBA+zUv3YkP73Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9eFdgyu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9eFdgyu"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-221057b6ac4so104841695ad.2
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 04:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740486839; x=1741091639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gTXa2K9xGk9lk/UzQYar52lCJhXF6TdqqbcgNK5d2QM=;
        b=A9eFdgyuAZngZE0ipcj2jGhHiBHQB0jeZC6UTvAzj5UctELiwx5FFzrvfy1GETnl6p
         sxoejmrC2EsSYvOfiXu9/hpbCt5NJW5zafLXsFwRWa/3iVy1yHH6ByO3WEb5GTCDRTDr
         lE4xPf7fot9d1ewfWtN3m/+dwGgZxp2ixl9AdAIXWegHsLpwG7XUD60Sdx/zg2iyHxs+
         A/peQ6d9goM/sfIgGkTxkYgKUDXmyCJjSzpa08iFYrszGPHJt+MOpxGqFmNrfFMLdLnv
         DtQesS87sosLXpRxdwJj69kgaOuOTjWGbtjMLlfsXk0OPy8GRIi3T/UmXJNbdbQRRcFO
         /H7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740486839; x=1741091639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTXa2K9xGk9lk/UzQYar52lCJhXF6TdqqbcgNK5d2QM=;
        b=sFDq6mgNwB3CqMVRCgTB6z5fIU+QzWyhLlCdTv9W/C3dDOupeqrwDtci4yaQ8mqDIu
         Lg/lNakJiDASNlez72SHy9YjnenW2clnzlClsY0VLEOLzrsx1alvTISfQGNgL5zC7PeK
         Fketf458hNtDhho1Ec8j9jVjxOkmOe6o13D2qJsY3J+H2c1F9NSbrbMWjENp3QnrCDnn
         tfI7blm5/8CYTdtq4J6+2H1x34HMFd/KoBYF2jhLysmEbj5bDAPKyp8baoZFLHrx8SV+
         X3mSpFgLBAQOp9C2DzbPcIw4OI6E0r3v6enLS/LAMPSmx/F8h9kHeaeXocQ3vrWo4MDR
         lCFg==
X-Gm-Message-State: AOJu0YxtUSH+eGo0iIltPU/EJbRF3IJYa8KG+DEK3dD0Kcw+gp158D0+
	RJJT7HcDHjPNiIXoFauCrYs3Q5eB/5chY+xPJIRvVQVwynZR6QkZ
X-Gm-Gg: ASbGncvcXtd6PCHB9q+CMIcXUaKa7uTIKrX2LTJM5kDC68Ovg8bgd4+TrzXGUEfVcJl
	KXLkQ6f/fj+N/jsqOogThN8OMc4UBcAQBPQAKEwcQTnOIPGC4MM+mHu2Wy7z/FeOHdmdoj7X3IH
	iy7JeCS9S7UUv2AT2aQdSNVghQVIHMPvb5sQkteWQw2oV5TJejR/BpFww5QpitzWP3dJNA6Plxz
	m9wQ79kZ9R+EDVhzDUWe4KWiIlWYdovMk8JSWKfhiazh+SXSH2c53fxwRZEGgzYQ2kenAjytyFx
	PszNTFL33GJt0yBaufiMAw==
X-Google-Smtp-Source: AGHT+IHep3qr3Pu/S/69Z2hge3am03Pw9Cn946HZk1tKfw3SZfbgBofjD37Mss0diM+c92qMu9iFog==
X-Received: by 2002:a17:902:da8f:b0:220:fe50:5b44 with SMTP id d9443c01a7336-221a1103431mr299864045ad.31.1740486838989;
        Tue, 25 Feb 2025 04:33:58 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a0009dcsm12954225ad.49.2025.02.25.04.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 04:33:58 -0800 (PST)
Date: Tue, 25 Feb 2025 20:34:06 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5 4/8] packed-backend: add "packed-refs" header
 consistency check
Message-ID: <Z724vnaRqmPAGByt@ArchLinux>
References: <Z7NU5fZfc8vfSvZ0@ArchLinux>
 <Z7NVdhM61rhjAHtW@ArchLinux>
 <Z71-1xa_o39IAo6A@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z71-1xa_o39IAo6A@pks.im>

On Tue, Feb 25, 2025 at 09:27:03AM +0100, Patrick Steinhardt wrote:
> On Mon, Feb 17, 2025 at 11:27:50PM +0800, shejialuo wrote:
> > diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> > index 8140a31d07..09eb3886c3 100644
> > --- a/refs/packed-backend.c
> > +++ b/refs/packed-backend.c
> > @@ -694,7 +694,7 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
> >  
> >  		tmp = xmemdupz(snapshot->buf, eol - snapshot->buf);
> >  
> > -		if (!skip_prefix(tmp, "# pack-refs with:", (const char **)&p))
> > +		if (!skip_prefix(tmp, "# pack-refs with: ", (const char **)&p))
> >  			die_invalid_line(refs->path,
> >  					 snapshot->buf,
> >  					 snapshot->eof - snapshot->buf);
> 
> I know that Junio pointed out that we should check for a trailing space
> after the colon. But do we really feel comfortable to tighten the check
> like this now? If there was any broken writer of the format that does
> not include the whitespace we'd now be unable to parse their output.
> 
> I scanned through a couple of third-party clients:
> 
>   - libgit2 is fine and always writes the space. It also expects the
>     whitespace to exist.
> 
>   - JGit does not expect the header to have a trailing space, but
>     expects the "peeled" capability to have a leading space, which is
>     mostly equivalent because that capability is typically the first one
>     we write. It always writes the space.
> 
>   - gitoxide expects the space to exist and writes it.
> 
>   - go-git doesn't even seem to care about the header? Dunno, maybe I
>     was just not able to locate the relevant code.

I have searched the code. The go-git implement "git pack-refs" in
`PackRefs`. go-git never writes header for "packed-refs" file.

Thanks for this wonderful suggestion.

> 
> So yes, we should be fine, and the fact that other implementations
> expect the space to exist indicates that being more thorough here is a
> good thing. It might be a good idea though to split out this change into
> a separate commit and then provide more reasoning _why_ it is fine,
> including the above info about alternate implementations.
> 

Yes, I agree that we should split out this change. Let me do this.

> Patrick
