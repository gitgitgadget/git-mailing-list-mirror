Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218972FFDFE
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938087; cv=none; b=lCag8e3NsMvr1L9GJ03tBvZ65gpzsokZFVShFQL82j1K6bCNBHRhHdokapk2T2ZHr9bHNsMKfUXAxVONhkezmuPILk52VpQYf//sP7vsrPAoWYmw67Z6FdneEuWm3BcoK+LOyvOevViAtjcEedsLfnt7EDlV76EbrQViIx2bxBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938087; c=relaxed/simple;
	bh=iVKyOgO1h8avIbVM5PkRckTYsdePzlbqP1UaH7pwJQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/pME3vWnQrjQa+hCUFGFQQ4S4WGeJ3kqBNXecR6yYz+F4tuTPAQ04Uq6a12cGrcvTio48Jg8Go1DPVaH7c5U3FETP/fJLx4Ds919/SDrCQUlDu80GTRf8I68uIbcCI/wKrJe+PbTBn1Ts1A5LGV4KbyAcldLsYCJQ2z8wnoVDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+B1TGAg; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+B1TGAg"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7724df82cabso4237251b3a.2
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 05:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757938085; x=1758542885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mYY0yp1onQnydKokdbvyRadtV/4UeuCOvdoJ2KwH9l0=;
        b=D+B1TGAg2wbwBHPNb/7CadDe43j3I88AOfEx/8Ojg5kPyT/epNduyssdJMXuyilDMG
         hpAryG7g3t0HXSqtD/E5tyagF/eNvIIaXvFEr1CaEPFMgy5eXKAOFlT3U+/CRPoJYtWe
         +sjXTxHJS7Lt8Vk0EQLOv/Jez0IizrfDsy/rPVhM7TactQ8b3lEaLdl3u6P+JcSbHNFG
         7XfZ9Cci3RRbdJ2sHbuacLhrYoYkffOTkeaCn3kUc6m1SXw9Kb3sXU6ATGLZ52UR6vQ1
         rRmdoyXI5XjLqm7MhPoFSIhq93RAGfA4ZdgGrwGG8qlupPMoC6Zwk4OhCutdMREI0L87
         dd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757938085; x=1758542885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYY0yp1onQnydKokdbvyRadtV/4UeuCOvdoJ2KwH9l0=;
        b=HydwyyecWNh4SCP9UiF8gHgsIoPgJ2i7pryD3U1fddOnJYISDOSI1hnwagASFbVIe8
         EVVdf/3H2AACDonkbBSVdPsJxrLicm7r2/AcvuLE/ztIu6yZBKR2I+Uul0fEfnjYgfej
         MkW6ZTlTz+6aJtc510i8kKDtbh+4ddfzU4WXQd72ciS/+ite+P8nurxn0VP85v/JH7EU
         PbyQqD/K0qD0qim7ECQMv3PHMBHqFYcg2ryl31aWstjTJVqWBQSlt6Rvr5/ZD2vDLcv+
         0ZC3iSufkzF4ar+u8/TQjN8BQP0ibwplXptZ+MybmcF+1p4BL4C5RNcMnNLc6IpwW0i/
         yiug==
X-Gm-Message-State: AOJu0YxSWtUk9ngLquQ0+LchOI7B7U4WrYRvbHT213VwUQ4S1LMXbj26
	O72n7VEWWvtfiyFtrqHnEt30QA88XfA7rrM42QXx+699CIyz+0I5rrfOt1/j2g==
X-Gm-Gg: ASbGncvFzxDFiMQHaFEx4qt4++8LPieUGfNVsRxBUnrLqIzduO9Fb90QBg7oLrSdnAW
	fSq5KRPqHwU14eAiAwDZD/1RuQYq575NODZKSdp3Q2DWCIrO0tAy++SGKF2cXvfa0656o1SB2EN
	UzV5TBt11M8b9xc+4o46ntTYkn/OSyDDkfRkexHaAKjvF6nxsP5gmerGv9Sv0/8ZM6k0303fklV
	9FTnn6gZHxH8MWn3X4BvpetOIc3sHVrbMOWZ0kS+jspygp2oZSFnj48y3TBYZns/jzKT261i9fT
	s0/xMfOPVzmgC+8hLsLAAMpy1q2PAG6ApX6D/0TEJQDGR5M1tal25CxkMVPEwXUioMaGMXd2Xni
	lEgG1VjPgXnauG97rvA==
X-Google-Smtp-Source: AGHT+IESmur8cpYLIL4Fm8W05CGhmSujKw6ziYmmLsCtG3QR+++6oevmXvPzyECFqE5Ych4ZtJUi8A==
X-Received: by 2002:a05:6a00:cd0:b0:776:22f9:1f11 with SMTP id d2e1a72fcca58-77622f9360emr9072767b3a.22.1757938085077;
        Mon, 15 Sep 2025 05:08:05 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77607a6a10fsm12879249b3a.46.2025.09.15.05.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 05:08:04 -0700 (PDT)
Date: Mon, 15 Sep 2025 20:08:10 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] string-list: allow passing NULL for `get_entry_index`
Message-ID: <aMgBqnwKSKDC5g0I@ArchLinux>
References: <aL21eowK8MwmDX11@ArchLinux>
 <xmqq5xdsyjoz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xdsyjoz.fsf@gitster.g>

On Mon, Sep 08, 2025 at 09:48:12AM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > Callers of `get_entry_index()` are required to pass a non-NULL
> > `exact_match` parameter to receive information about whether an exact
> > match is found. However, in some cases, callers only need the index
> > position.
> >
> > Let's allow callers to pass NULL for the `exact_match` parameter
> > when they don't need this information, reducing unnecessary variable
> > declarations in calling code.
> >
> > Signed-off-by: shejialuo <shejialuo@gmail.com>
> > ---
> >  string-list.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> I do not quite see the point of adding these conditional assignments
> to clutter the control flow.  What benefit do these callers gain by
> not having to have a throw-away int variable on the stack and
> passing its address to the call chain?
> 

I want to make the commit small. However, I have introduced confusion to
the reviewers. I would rebase the first commit and second commit into
one commit to improve this.

Thanks,
Jialuo
