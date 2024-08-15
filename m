Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B501A01B4
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729029; cv=none; b=mSdEyFDYF+wZBOV96uMCyGGAY7cLNJysUL3DBTAbdqW9ozUnychvq0qzwC8CGH4yzKyYmrSB4m5AEpBDC1hHLEgjALEsV1tVDFGOaxQdXVt1mP5BadizRpx7qJeqJFGZ7xNNIyqSqrfRevZYGxxET7SKMFh2c2N5sQi7zBK4tU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729029; c=relaxed/simple;
	bh=FF+MurQtdZdnt5dNIhE2tG3P0PL53z44+1/nj0iH53w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnllQoqj3AlXP/y3tffKyBxZGZSECh/IOnSsUgo1zpGk47RSAygLO9MN51bnJcCePLrch+ILeu899YS2eOMFPnLmoT94WemL+NQ+dAN33N61OIPZrlkoXZhIK0m6BYt3wMPx32lTf9iOeyfgyibuK8Z0puj+z3/TQ2qG7rCE6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYOeGkA2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYOeGkA2"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc587361b6so9043545ad.2
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723729027; x=1724333827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GRzHvEPQ+gsCpjzJpqcGy/ugrJPjQFQhM0GeCxq8Opc=;
        b=bYOeGkA25tL4+3PkJTRotdz4ZvXDoWQnf5W6bE4hjBcc/R6jecxrboEVtRXQ0Yr1hM
         qcyCJACbZoIqoXKmP0RxvWhcuZbIgikwiHEbY9RD8XbNGKrIRDfwuT8WbxAqIFnN5aTc
         Gq61GYxe8Y3n2uKggadp9B4YmCIisWdUEGYMd9RQg0hupLGndZVn4zAWqTsklbyHlIpt
         yrpUv0xkIX5BUj8gmWbdQIKDpS9Eo7TxelINLtLFXeZUEg1ZqW5shDyXIXbeCz8PFmT0
         k9GO9LoxQLEqD3piM0HgdE87Uo3zllopPtdreNlbVp1s5sLTtVgzOaiGOTJJwP7u0P+o
         Yg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723729027; x=1724333827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRzHvEPQ+gsCpjzJpqcGy/ugrJPjQFQhM0GeCxq8Opc=;
        b=hxSz+aUH/JlUVzbufdgiAAHA8B7uGo6bGTKNr+Rgv/wgpfDWBdJIN2SSQSPlT7rRCX
         AX6PTcG+nPp+FVSNOHPev7VplJUMMkPVGleeOKT6CTJlnr8he5HtIRJlHwJUeAdoTx5Q
         bN/2Qe1EVmhuYxlCoYucOxSVUFIOWWps8THrg1M593DQAmm+3V7FOaqZX1D3C604TsNI
         QI5x2WCp7fKY4hDIIr4g6lhqd0IdFQ/uhwCPTZnciYT85HgxNGVJHGKj22nOFSl+uju5
         /Ji41iCZdwU4k41ruP9b9XjHyI0lletU+3wGYPLbUEMFabueWTyXjmG86uiXHHTEEjQM
         JLLA==
X-Gm-Message-State: AOJu0YxOHEQO/S0GLirHlTv+4FfhTwbQ9cH2d/RvlSLcR31LoUaVSbLc
	TXGHxmvDDodqVye9x4RvHO/HkXhNlP/BYciEdYBiDYgBY09osERu
X-Google-Smtp-Source: AGHT+IEj+oFzyNNCwxHvwe3a9frqMlEHSzmCi90n+QibbUAGr1gbC9L8WW0rHBstyTgsrc77WSJuCw==
X-Received: by 2002:a17:902:e882:b0:201:fac8:ff55 with SMTP id d9443c01a7336-201fac90151mr9488675ad.13.1723729026829;
        Thu, 15 Aug 2024 06:37:06 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031bcf7sm10221835ad.74.2024.08.15.06.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 06:37:06 -0700 (PDT)
Date: Thu, 15 Aug 2024 21:37:44 +0800
From: shejialuo <shejialuo@gmail.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC] Implement ref content consistency check
Message-ID: <Zr4EqESHSnQET1Xg@ArchLinux>
References: <ZrtrT1CPI4YUf5db@ArchLinux>
 <CAOLa=ZQVkmyVWAxyjrEQoEJ+gKJoJjfFqsDvr_A15FHGX1w=rQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQVkmyVWAxyjrEQoEJ+gKJoJjfFqsDvr_A15FHGX1w=rQ@mail.gmail.com>

On Thu, Aug 15, 2024 at 03:19:50AM -0700, karthik nayak wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > Hi All:
> >
> > We have already set up the infrastructure of the ref consistency.
> > However, we have only add ref name check when establishing the
> > infrastructure in below:
> >
> >   https://lore.kernel.org/git/ZrSqMmD-quQ18a9F@ArchLinux.localdomain/
> >
> > Actually, we already have a patch here which has already implemented the
> > ref content consistency check. But during the review process, we have
> > encountered some problems. The intention of this RFC is to make sure
> > what content we should check and also to what extend.
> >
> > I conclude the following info:
> >
> > 1. For the regular ref which has a trailing garbage, we should warn the
> > user. This is the most simplest situation, we could reply on
> > "parse_loose_ref_content" to do this.
> > 2. For the symref, we could also rely on "parse_loose_ref_content" to
> > get the "pointee", and check the location of the "pointee", check the
> > name of the "pointee" and the file type of the "pointee".
> > 3. FOr the symbolic ref, we could follow the idea of 2.
> >
> 
> Just to understand clearly, when you're talking about 'symbolic ref' you
> are referring to symbolic links?
> 

I am sorry about this. It's symbolic links here.

> > But Patrick gives a question here:
> >
> >> In case the ref ends with a newline, should we check that the next
> >> character is `\0`? Otherwise, it may contain multiple lines, which is
> >> not allowed for a normal ref.
> >>
> >> Also, shouldn't the ref always end with a newline?
> >
> > For symref, I guess we have no spec here. From my experiments, a symref
> > could have a newline or no newline, even multiple newlines. And also
> > symref could have multiple spaces. But the following is a bad symref
> >
> >   ref: refs/heads/main garbage
> >
> > I think we should fully discuss what we should check here. Thus I will
> > implement the code.
> >
> 
> Agreed, in refs/files-backend.c:create_symref_lock, we write symrefs as
> "ref: %s\n" so it makes sense to validate that there is nothing extra.

Yes, we should do this. I will implement the code and the send the
patches to the mailing list.

Thanks

