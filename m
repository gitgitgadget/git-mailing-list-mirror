Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA431531CB
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290736; cv=none; b=C5ABEtVXzi+EjGohXIOIeeik+fWInXXDFzx6D0np2PNMofTcteMxc8GdURBFp/HSrIkg9iClmhYk020QWMSr9GDLeNyL7Zn6uh90LH0qRZYyi0iTI44nthQagzr6uVhw+VHMTSGHv0YUhnJkDM8PcHZnls7gd80N8I7Gxmps/mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290736; c=relaxed/simple;
	bh=e8CtfffJcYLtO68aYDw/buL51KQ5yvyU7opna0FspMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXUs4T+RfMP412ZPpMFkhCVnih/mMBZLdv8XPDYRPcV+ckNda92VZlq28J4eHB31ceEsyvhTenix3MQfdA7AUS+vqzo6ciePQ7/JkiDa79JUvcSNszUWETHuAe3Frky7CNrWxr9FapSBMkTOq/bC4IjSM9E74xtMURKPPZFHo2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REU4Lx4B; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REU4Lx4B"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b0b2528d8so47204945ad.2
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 01:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728290734; x=1728895534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uwvwsFNpsCnFGgge+LLJXG3ksJVc54tqqM1yNLiyw6g=;
        b=REU4Lx4BTFiAC9OqiZMaQTQ6bud8ejZHnNujGhBlIr8sjuwrKlVdNOn/Cv5z35N6xe
         iWwJD06h/pbLzkcxVD3obRfZ4aM420o24Oseo3/38YGYiWHrE6faCq33E3p78xXCYaEE
         BOgDtGbmgVTDwS8nWMKObcKssiyVWNZ14M4MOBxhuiGHM1Ka20GLdxT+JeuS/bPV07zF
         qclxoYFuxC/o7M0kYQ/Xh6IrkJlS8Z9G6F4ojRdxGMI2w98QpLRmEXFielOalRuD3pXf
         rUxCg5cpTEIUZoXz/XcRmHxHTOIjuesOfdvrRnKs+tjDZ72GQODUpEhzrVMZlFKEirU2
         6v3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290734; x=1728895534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwvwsFNpsCnFGgge+LLJXG3ksJVc54tqqM1yNLiyw6g=;
        b=E3/9WpyvETECdNMNs7MpsiFFQ9ZMEm2+mWpu0lWS/00hlRBPp5PXfxVslPyPy6ISwG
         a/Qth2LrMFNThSDjIeuLTZybtflOF/w+3xvGkFH99FxQhOl7tL/YzlkTWi0v4oLyp2dc
         fua1n7Iu66MfAhWoT2JJr/Okm6POyGXCl1GKdZkI60dxKElPx05hFcvfY7nGEJAf08IY
         3ZVVL/4vY+EbhkCYjzS56ID9AqldQ1PZE2h2rVphEwQzMQBa+2g1maPnPTeB/Iiruy0d
         k8sPBK8F6dRNDkNckE5dsDPYuzl47HuwTKJtQ7UHqz35T4fNQkXXoOkRePFNpcFLZ+ic
         UNsg==
X-Gm-Message-State: AOJu0YxLgatjRF7sTmH8ivjGbNqmpkvXZvE3UEbEOFd4PPh5PKOLCZQf
	V+85vV+MPeHk5v2k6a+TQyRL8UJQrf1helkvgRdebic46Im/WrG0
X-Google-Smtp-Source: AGHT+IECz5x+cGXNa0QPE3lZGmZ3Fqa+/CsHO179VZSzbF5DnsjOfRVEGJBFHeRDmLCgHOPUDRBVgw==
X-Received: by 2002:a17:902:e892:b0:20b:7388:f73 with SMTP id d9443c01a7336-20bfe3a021fmr168709355ad.42.1728290734349;
        Mon, 07 Oct 2024 01:45:34 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c139a2fdcsm35322215ad.299.2024.10.07.01.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:45:33 -0700 (PDT)
Date: Mon, 7 Oct 2024 16:45:41 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 8/9] t0602: add ref content checks for worktrees
Message-ID: <ZwOftTrlYZh9Oz63@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-_tO_Qtp6EDBy@ArchLinux>
 <ZwOGoxXmn_J6pgh1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwOGoxXmn_J6pgh1@pks.im>

On Mon, Oct 07, 2024 at 08:58:43AM +0200, Patrick Steinhardt wrote:
> On Sun, Sep 29, 2024 at 03:17:18PM +0800, shejialuo wrote:
> > We have already added content tests, but we don't have tests when there
> > are worktrees in the repository. Add a new test to test all the
> > functionalities we have added for worktrees.
> 
> I'd squash this commit into the one where you introduced checks for
> worktrees. Or if this exercises errors that you have added in subsequent
> commits I'd squash it into the respective commit that introduces those
> checks.
> 

Yes, make sense. I will improve this in the next version.

> Patrick
