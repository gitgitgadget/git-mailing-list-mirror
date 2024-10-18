Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5590917C22B
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 21:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286263; cv=none; b=Qi1f8WS3X0fGj5UoYkXoGUx3K7/GnMxt922luiCRB0sV5u3p7mYZNkppavIsDiuoCAN/VnRAehDzBzver6R5BYnlm9TbqcJW/XhuyrJr8dGe3ni5F1WJ6f/by/tq9XYwEf/a/FptqxA07x2V54fH7YJFGP8uljC6hOIlVcVahFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286263; c=relaxed/simple;
	bh=7z9kTxeW8lmwCF8Pn9eKZGOfHYgNHTAeTLrtu4bx/eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0xccCD6sdEBqeFBbdOxnYszgSLhlkCKLC/YZdB/FdLpce2WKWfEx3XZ/fr54/x8KiSoZfvwFzjcYi/e2Gh1Za1rBY8ul3MhQDvWyov9sMO7TEQVXmkIpnvlIL/NtuK1G4Y8HzaSzunaJbfutDrNOFsa8wFjoMzxcKPP8glyrKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=VckqfoEA; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VckqfoEA"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e3d7e6f832so25921927b3.0
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 14:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729286260; x=1729891060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7z9kTxeW8lmwCF8Pn9eKZGOfHYgNHTAeTLrtu4bx/eI=;
        b=VckqfoEA9eeY2DQukOs/B2ksDlNfijOKtJT/YqmOe82O66ojS1/peP33ZSBN3YDnPM
         6FlqNOGepk4VnnOoERlkt3IQOTsQL92y+Gj76KKoakadnCpulwgS3hNHApOAv499933V
         3XLVdfSvR/r6Y49xsLDvvJgKzyC4XaTbL6Xp43+X7AEPBJkWVMHh2gs10GP5vKzKbkrk
         Hi7XbV1bvL+e1x/AuQfXZUw3w4DKNxdnbvBc4lFXGgX66H6QOsqcssc1qExIwdY7GB6q
         ID7MS+6HRedVrduHgZ2q8AfWDT3NXvYRB+4xUpTHVNHAtIrpptcKiLQi2ltt6NBh6C48
         1YPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729286260; x=1729891060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7z9kTxeW8lmwCF8Pn9eKZGOfHYgNHTAeTLrtu4bx/eI=;
        b=HaWDbzt6hgHcqkzQ6cWXc9/vRe7d31frQyhbyR3qxRqDC8Ww2lhCeoN7nvF7m0iEvZ
         u4GWQ5bRqLXuK2jUxOq9alyXbQdS2XSKptJTqSf3VgTjIRZFSvHasWs58mNWbLslwArx
         /COf/dHH+Q32z2O4a/PsQyy3DdRSmEuZvXmHVosd9eExO5UI52idFB3VpODktcTlW/1t
         S86SkuM9Qwt4vCD6kU62vi0wuxnA3m98xpuvRwK/1hY8p3IYwQBjntKoH59r2FagRVM5
         Mmd/WDGMduVECnATwRJuSOW+bEx8EsNG6djUHEx8qQqxXU50d8oQS5/D+XoK/wSiI1YS
         T7zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKh9+qSJw4sTA6gDuB0g5dyWw08FpGeg8bz4afSoO4tP0sh0uTEH4NRCvEOErqK6E9+PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUnnc/lyj0fvSIW9nzUCVsf248RKbZ4FLNKreGAXostpMrxHTM
	wIe+INyHAK+z/9BUsaK95IdMTtVKAy1ZbvRT9mfG0Ko180ueN/mBLm868SK9RoU=
X-Google-Smtp-Source: AGHT+IHAxt4Cc4D/WQb311UuqV4vPj05J2qf6amdtG/8+2a/ccrviOthJ5/ytgfkgMLV58fFlWorOg==
X-Received: by 2002:a05:690c:f07:b0:6e3:39c1:1678 with SMTP id 00721157ae682-6e5bf6327f9mr41791037b3.3.1729286260214;
        Fri, 18 Oct 2024 14:17:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5c00e3cf4sm4773267b3.48.2024.10.18.14.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:17:39 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:17:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH] credential-cache: treat ECONNABORTED like ECONNRESET
Message-ID: <ZxLQcekbHEg5YLBH@nand.local>
References: <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>
 <658fe4fa540a0a5316e11ed43f9139d5ef818ee5.1729226155.git.ps@pks.im>
 <20241018052952.GE2408674@coredump.intra.peff.net>
 <8c4b513a-aa6e-4015-a6c2-e153b6c94491@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8c4b513a-aa6e-4015-a6c2-e153b6c94491@ramsayjones.plus.com>

On Fri, Oct 18, 2024 at 04:33:13PM +0100, Ramsay Jones wrote:
>
>
> On 18/10/2024 06:29, Jeff King wrote:
> > On Fri, Oct 18, 2024 at 06:36:11AM +0200, Patrick Steinhardt wrote:
> >
> >> Subject: builtin/credential-cache--daemon: fix error when "exit"ing on Cygwin
> >
> > I think this commit message has a few unclear or inaccurate bits,
> > because it's based on the earlier attempt. E.g., the change is now on
> > the client side, not in credential-cache--daemon.
> >
> > And I think rather than say "the daemon exit rules are intricate", we
> > can actually outline the rules. :)
> >
> > So here's what I had written after reading through the old thread. It
> > would preferably get Ramsay's Signed-off-by before being applied.
>
> Oh Wow, this is (no surprise) a masterpiece! :)
>
> I would very happily add:
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>

Thanks, all.

Thanks,
Taylor
