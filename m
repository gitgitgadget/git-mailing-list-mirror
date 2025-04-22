Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A94127CCEB
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745342672; cv=none; b=DXOA/JfHHBC9//BfufWwhz8JS4e9mxVWjDCDi1oBQrjsy4jY6e4208Lp+iMKO8FmxNxkUfwkgloSLeOilf0sc3uUcKEvdoqDObA1BoTSfZee2M+l1aMrRYR6usmMYqK/aTcDYt5OB+twSi/Qj5ZfWnC5muOs6I66nVvY4novgBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745342672; c=relaxed/simple;
	bh=9dyIldABhTeu1GqkAzJL18BATftw9/YxP/Xi2M6FacY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t67/TKYw/mppx3tfxyMhccm9KVowPKVuFgxFc5ilM1ZHeu7BIXoTss1nMOrtzEwKi65AVZSy0GWLOdPMeazHrzt0gJvS+3zrlPwR+Teiy3HRL5kAJgxJgKbCvNUcf9OPNyOA3VtfLPIxwpmbMnXoCq8o1NsQk4sBNSxIJZdg/ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=gr7TJGUY; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="gr7TJGUY"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6eaf1b6ce9aso62020776d6.2
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1745342669; x=1745947469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aViRGdJ6H3UMgczaQrVwaLuFTcayXMukimPdpCWySOk=;
        b=gr7TJGUYSHiJ68N3cPDiHFJmt+6+Mt1heszp4PidH0dvUjl9ITOW1tPcqAbF78E9oZ
         M/ldYPOkIeayAw355lCDIPI3JIay/dgnA56Swap0Ewn7XqA0+kDuYeozkRd9Xj1Gul9T
         q9V8L5Xf9U+tOlXDYmUeEnAR2KqqZL4G9g0SeUl53FFxAmPOdb7hsCJgJ41YXi4WyWOs
         XjyVeTpzTd78dh35A0Lhh9UMxlYHdcp/8tUD1WMXqBqOADxerzwfNuy8I726hyOsOxXf
         T+MEbZSRHltmrhDJxu4mf8obLWs/A0gSX+yCVkM2hPo/+5cBmtL82BYgMZdkPDO9QwmC
         mtqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745342669; x=1745947469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aViRGdJ6H3UMgczaQrVwaLuFTcayXMukimPdpCWySOk=;
        b=iAUXB2/BVGG5y7fY7seT+z4AfFEaKJN+JDcogt5TV7mNMcPbVfCmQ2qgjT628PnNG9
         zwn9eKIGOOsb8AfGzWfcxcmMUJAPFnmxfb4KguUmZxH/zW3B8+o5EZSy9ArX7kwLSdu/
         WjwXTH1vPHA1T0ithFYSgl+8S9NsL4CFneEdUFxjB9IRV2fyHlFMeDLx+vw0bnC94WG4
         RTXxgbOxcCIBknR880JuvcaebqN7wEmoj+H5OeX3PcUKShNZshSSnxAPMXEzNLbXFQZD
         VX0elwL7R+fB/fkePTfvv17DTtS+/fEWHxJ4bz5W/ezae9SXfTDpY7bDGBt6jHjo9yCr
         kKkA==
X-Forwarded-Encrypted: i=1; AJvYcCUsKFW3T4CXAR2juuXgYZUfwhi2LcAZG4bndiKOQO3I86aVfkToCjiPDI8b1cU9KEu9300=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1fz6zP1/lU+zyopfCw5c3cm9SKdFcyDY1VHpQDlQZngePzp5p
	7vSUb+/k4tIQuh0rL+Xjn5ounR+sk+/osiPE8oAfZ449juQuKCJsIHGBnJfDBPQ=
X-Gm-Gg: ASbGncvBgNRe74FGvDL+gg4PE+JMMyWUR4DZzbgk3w0HiD5YULmw5TNMAodkxiIFIpL
	JEYZv7Tb5TZVmS3sKQf7Mr8o8x1aLgFbAdBs/sRQXwK+Ipu+1VYfIRzIk5UDhzmyVHTioV2CYvu
	cnZBIdcGqRyxLiGqPXF6TW7KmXr2KLCCARDKN7KqKCOPtxYFWxvQExW7gTOCLIJ8cOfg0DkRSuO
	efS6O86kHPtZIaROiZ1+g+uDgXyusjI0KhmmEWgTfIpg8L70qWfSV3rXgGdbLkasKL6nw00SToc
	UpgfxM6KZ1q/T2ubteNGbkL1xTiGwOhQCdqU4wiYhBDJHia/tVdJAyFO6LU98cCdPILVwre+Xzr
	iSWUUYxuOLDBo
X-Google-Smtp-Source: AGHT+IFJYODFkjl7fQA2EoJrGGmN3HGeN5JfNN7/7CwdX5z4sGo4uTyTBWYZ6QFQIStkGog9y97CpQ==
X-Received: by 2002:a05:6214:29c1:b0:6e6:6599:edf6 with SMTP id 6a1803df08f44-6f2c4655ae9mr304831226d6.34.1745342669254;
        Tue, 22 Apr 2025 10:24:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f2c2b0eb98sm61153326d6.40.2025.04.22.10.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 10:24:28 -0700 (PDT)
Date: Tue, 22 Apr 2025 13:24:18 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] p5332: drop "+" from --stdin-packs input
Message-ID: <aAfQwrhuLF7BysyE@nand.local>
References: <292ae7a3-2aad-1f22-2afe-739ec921d6b7@gmail.com>
 <20250422111632.GA1855088@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250422111632.GA1855088@coredump.intra.peff.net>

On Tue, Apr 22, 2025 at 07:16:32AM -0400, Jeff King wrote:
> ---
>  t/perf/p5332-multi-pack-reuse.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

My apologies for the mistake in the first place, but thank you for
digging and providing the fix.

  Acked-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
