Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03CC8485
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722787356; cv=none; b=Hh83VxjCH0jO2dS4/crJ8027KBG0QmP20jAIMM5tB/bYgTB1U07Z2MdnAxsAbuTPa5ZPdtx+9Fj8Swq0kDUQGzFEY7bOdV39fFoz+9Yk+hotoMaRfBWe7+46b0lpelFtwHLDYdBBv+7BZwOtKsnZQEVmoWJHzxMPxoTmdvJCtQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722787356; c=relaxed/simple;
	bh=WJDsLEzSt8f7u7Kr81beYc5+gZ6dTyal3EJvP6RGrTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goR+wBe4swwzruZFiYuvCqP9wpv+SNIunMSEF9GiqE35cVzSdsbcr8wsBHsUDbcgMGTyGZp+xEn4PqU9iNS+DqUD2Qpr6o1corSPyetLGbJNQ7LB31BkXPPLsp5rUw7MroT2Yx/Y64Og/7r88DGU7LgkmfuuiOXSbjsaHU7p4SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=pCBIa2F2; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="pCBIa2F2"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-685cc5415e8so45849597b3.3
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 09:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722787354; x=1723392154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WJDsLEzSt8f7u7Kr81beYc5+gZ6dTyal3EJvP6RGrTo=;
        b=pCBIa2F2K6d0a+6V2SrNynzST7R176ktgTiW5eQkoFRhtXCMDI6XMLx2Q/1Cc+H664
         piR2D9EEVN6vHqccJJ6BmrubLvdsuFOVQaJXgFjVgIRFFS38R/jZSfJqTr5ghU+9ArpA
         PkfH6+7cbsJhWiTItzl/gjeIjW7Zg9e41E+JoHOY/qL01jjU1yyCyInMdu+K55/Fl5kR
         USx6LwedrZIsX5F0cGeXk/GYYvySSv+cXwH8d+B9Z9+dxAtVNGUK7SjcIXfcTR9AZz7T
         /E7I3oYTYR1oD68G52EGmjOZRvQhDFdzkzaNs+zB1tYAGDb2VcdyEPfD+MjmCI8KBJLe
         jgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722787354; x=1723392154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJDsLEzSt8f7u7Kr81beYc5+gZ6dTyal3EJvP6RGrTo=;
        b=bszpaZR0FL8ABULKIHZ5UZkOxnrxGj6ONEkWsEDEnIjNxvBu8Ku7z8g8XqbM1C+WsW
         a2vOD4gT9GjDbwgJu+fs17TU9s3p8BiCA0oXa+h8uH3hPR3ZZbx6eVmXUZx1gFS2HJhg
         Wf9M5MFJBo+IjUncvroh/4ueyxUw3ltNjMWxGuzLvRMalWU81AUAign8ctwd/yf7wbMQ
         ZFszN7jhh0hs8UY8oQWJnawFGu+itAPvDp0QBa5Wd8ceDT2YhCNrBYfvi/K3C2YOz+BZ
         uvqgJAvAqnuLBvrqECYScaxej4w0tGSz9P89Wswc4aLzxUPrj26K0YfrhRGmY9a+25u+
         NqHw==
X-Gm-Message-State: AOJu0Yz6QbeffwIG2q1/EleryFiW8z/7j2Xf2a6u+VcL6bhbqsXHyjtn
	UwFLW4Dh37AMDm0KiVP1CWx4Bpo3oVUlaVYolkyXMkhvZENYF9VoQpQpy5m5IlPpaWUfXQdLeyo
	2
X-Google-Smtp-Source: AGHT+IGoxtIkBFDlxThSh4N8JL3uMuBxX4k5qgIFZn5aVjc2VtkOAzFDEN0EhE7E3LU3Al5DN0LGfg==
X-Received: by 2002:a81:9e14:0:b0:65f:8218:8b2f with SMTP id 00721157ae682-68964584a38mr89431557b3.43.1722787353895;
        Sun, 04 Aug 2024 09:02:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68fcd1727f3sm3865017b3.90.2024.08.04.09.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 09:02:33 -0700 (PDT)
Date: Sun, 4 Aug 2024 12:02:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: [BUG] 2.46.0 t7701.09 fails on NonStop ia64
Message-ID: <Zq+mF2fyL5hux+3k@nand.local>
References: <02d301dae43d$2202fc90$6608f5b0$@nexbridge.com>
 <ZqvgmYl8BTYvsSa0@nand.local>
 <032201dae461$c7bcc9d0$57365d70$@nexbridge.com>
 <ZqwvQUAqVozGHG/t@nand.local>
 <040801dae528$70966d10$51c34730$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <040801dae528$70966d10$51c34730$@nexbridge.com>

On Fri, Aug 02, 2024 at 06:07:55PM -0400, rsbecker@nexbridge.com wrote:
> After the first repack, I have the following idx files. No foo/bar/baz inside.
> The generate_random_blob() does generate the proper amount of bytes.
> I tried changing 0xff to 0x00ff at the putchar just in case we had bad
> sign extension - that wasn't it.

Hmm. What is in these index files if not the three randomly generated
objects? Can you run show-index instead and share the results of that on
the pack(s) in your repository after the first repack, and share the
results with the list?

I think those would be more readable than a hexdump, especially if your
machine random source is different than mine (in which case I can't
guess the values of $foo, $bar, and $baz).

Thanks,
Taylor
