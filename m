Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279911D2215
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302916; cv=none; b=qe6ozX0UCl1gK3jDaGuVIs/m2jLnVHTaTqPWg9HcyIOYfy7S+lhzUPkcbz3ZdDUPDP7ZGXznGIMcQKJSnNMoSYDDHDDPd4d2CWXsiic7pYbC/qLh3gMWVg+hTBVoN5Z7bezu4L5cgwrxMxofvo6fb5kyhtV7xYq7JssUoVuuFpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302916; c=relaxed/simple;
	bh=2JceZER5ouvOY/02RuczTXXGTNoJk7PzAmsxdnjCtJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivVcTS+7zyQEwRxDmliB0Nv5alpJHC4nkQGcaEVK4gLHpP8PCB/I/nTdWT21OWFNevVWt6yMTEP4L/nz2ohnorlNugI9AKVeVTpoQrMMY+6ATUhXH+P4p328wGqc2kWcHsDUnOLlADovLqdFN5r4FjsZ9C5fo+vUs5NhQOFEtyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bT/0YpCS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT/0YpCS"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b95359440so36050065ad.0
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 05:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728302914; x=1728907714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=10I48uQAGwuF45NgLz+WQpGSBmCs4TY9ZQdOwnI1MLo=;
        b=bT/0YpCSHt3aHuh0ureG5JFqgmVXIqyV874LRELg74al8PZhMPSh6LruwM5ZnSK4+g
         AgwbBmg+rWPfhvcNEpkAoiq6jQgB1u6TudgBHO2i3MK5UlQoKoZ4RIESlVbjTmjYAn3f
         /xmhnWYN9UW71BHas1L+wVR9Qr2KTP9qj3jTsa17fyHUuXvlc+r3C+DwJ2gfO2QpaxU9
         Kdgnpb0YXtxgqwMng2sWQwR4d8VvGeCd8BUuvfKJVUEMhYg/X/7d+3LG/LLYstabYzh7
         YL5xqJTMWkDIPU9pEKIAvbW9d69Bvuq9KLdmDg6U4tQ7VP427+9bACedRtL43Wj9y/0q
         Yo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728302914; x=1728907714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10I48uQAGwuF45NgLz+WQpGSBmCs4TY9ZQdOwnI1MLo=;
        b=DOy/HJwDs1mMKfzIfW9IQKyjouPCSupWDD7sf2K/RZdJ0y4PxikD9m3SWilkyXZSEQ
         XW00Luf47fO3eMfSwfOPgBsDeLC7g4q7mxZtgqJZ3QhletLLajor5JMT8WjakLMe4VOk
         TTHvdtsDDAx4CJXSGE6p3mZLky2NxcNJwklcInjRTXIs6rf/RIRxoi5FNT18lSRTmTZS
         XGZwA+ul00JN+P+an8AjQwnL9txhcxmmwPYj2k24fGtlBiSbbOKBK+9guA1upeZuI+t9
         YKPXG+6MysFwpgUfCT30wauph30jaJVCK4VWwvVAv4cq5cxQrQLbpfemrXPeRlT+KURZ
         OxMg==
X-Gm-Message-State: AOJu0Yy9Y7qsJ5pY7kqxLzf9/drgljxKa6S4sgQP8IP5bXuJOA4Oa+gK
	OtqqLSAPQNYWpokOnGHHalLtPjCGAyRUodzmiJ9qDzopY5de3dStsM/YeK3b
X-Google-Smtp-Source: AGHT+IGoFwXK2/zaaL2Zph3NOy4U5lJQFkGCuXr4KkVAbxxEYYra/I9CujmQfxhsYSxY4ws12jgs1A==
X-Received: by 2002:a17:903:2447:b0:20b:bdbf:da82 with SMTP id d9443c01a7336-20bfde554famr190332545ad.9.1728302914345;
        Mon, 07 Oct 2024 05:08:34 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1395a2ecsm38466105ad.206.2024.10.07.05.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 05:08:33 -0700 (PDT)
Date: Mon, 7 Oct 2024 20:08:41 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/9] ref: port git-fsck(1) regular refs check for
 files backend
Message-ID: <ZwPPSe3KGjU_XAPY@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-osCNDMrUQv83@ArchLinux>
 <ZwOGmoX5ner_F3Ac@pks.im>
 <ZwOfBCSTO4Qvtos3@ArchLinux>
 <ZwOnYAx_h9uGzPst@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwOnYAx_h9uGzPst@pks.im>

On Mon, Oct 07, 2024 at 11:18:24AM +0200, Patrick Steinhardt wrote:
> On Mon, Oct 07, 2024 at 04:42:44PM +0800, shejialuo wrote:
> > On Mon, Oct 07, 2024 at 08:58:34AM +0200, Patrick Steinhardt wrote:
> > > On Sun, Sep 29, 2024 at 03:15:46PM +0800, shejialuo wrote:
> > > > "git-fsck(1)" will report an error when the ref content is invalid.
> > > > Following this, add a similar check to "git refs verify". Then add a new
> > > > fsck error message "badRefContent(ERROR)" to represent that a ref has an
> > > > invalid content.
> > > 
> > > It would help readers to know where the code is that you're porting over
> > > to `git refs verify` so that one can double check that the port is done
> > > faithfully to the original.
> > > 
> > 
> > I am a little confused here. There are too many codes in "git-fsck(1)"
> > to check the ref consistency. How could I accurately express this info
> > in the commit message?
> 
> Well, you say you ported over a specific consistency check from
> git-fsck(1) to `git refs verify` in the commit message. So I assume that
> it should match a specific check in git-fsck(1), shouldn't it?
> 

I understand your meaning here. I will improve the commit message in the
next version.

> Patrick
