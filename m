Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E98B646
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 00:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730074485; cv=none; b=LHCvh3Mfvhee0F4RrGSC2O5zvFi0vqD+ZcBxO7Trk7JH4VTS500lQ1OaNoo3qOpt5agXv0ISzM/i2/Q+17UWo2eBDWIdDzDDU4ZOR84y9C+Ex4Y2+lxUtD+EvV4jZExyeVkZg/tH4LdnGNOuwx+blvdG6fEymgPkd2xHHbkx9BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730074485; c=relaxed/simple;
	bh=vVDClcJmZV8/eS3i/AA+B11QyY8UObWEXI4o+8WMz/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqIOCVOjeKrVetqV0ECjLnrPrpWQ5xODkk3AdiZf0p64FTWknA9ehf+ClSOik09SVqSmFFtR6yh/cNHqy4zssaCDyecM+IO7OYA3KMbvPTmcBpz0Yapi6szUY3nQvzfySCfcMTVv4Jd+JtE9KnOYLRkNHx+EXz//8D61q3BV9MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=vRvSH9Et; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="vRvSH9Et"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ea07d119b7so2423877b3.0
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 17:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730074483; x=1730679283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vVDClcJmZV8/eS3i/AA+B11QyY8UObWEXI4o+8WMz/Y=;
        b=vRvSH9EtFH5jEJYOpwYxNYMZM4Ic1N7Lqc7c3foBXJPk/ikC5QxQADV7dGI6Cr9+aQ
         Nml/0vi1Mb6QjpLJxYENGk4el1yjWmmCBiUZBYzkC837LJhoF5AzGYr412A+rUPICKLP
         h8RI73HUOL8PAyjIJzfbPDHKwrWxN6YzcZOuGJsK2lPALtwsx2a78AE6Zd8yZDTYZB/3
         pzJM090NmJXjQd/daYXtHYtHZlAkDsnAUbALsN9BZloJyA8PewwAovXSebeTYea/0HHR
         N67k0PAIvwiqwXo/UrIDkMne93HbOxVC7E0RExsI3FiNIOjdWyUPtZLAe5IbNDFdcGSD
         0aOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730074483; x=1730679283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVDClcJmZV8/eS3i/AA+B11QyY8UObWEXI4o+8WMz/Y=;
        b=l9BbTxbv8x4scGEVsMRhGM631lIAHhvGrXIP3J3xZR4LOgAE1rITegYXOMlplIdjrK
         r6D3UV6HgcdV9i3IV9DVOmHcsVbulJ7SL+ATMTgUj8FnvfG/iU6hgyaMg9JdO5igRund
         XI3H9LM6V322gYepmf2ThAQsl0QgtY81P9RXa9ymgmxxEDvgV7tzP45DWwWwPk29ONAv
         aF3uULXS9QxzgWTW4Ica5bFH8755DAdydtVnFoqBmOFKOzgsfl8O3srWN8D5GTjmTFau
         VSxsR82Wd9y4VHV96ItANA09uapZj1TgrFn7dv+NRZTH7a/3c7CgsSodS+z3YXeTS5s7
         73AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAgiHhCrgKAyB5VHXacyHgHtaBxl1qeTBqIKO14rFBcQkd5Hs17c7Y7tO8fYHN3k55qj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YznbbeZ9aKMQTlk855pB92+XWP9mktdLdPgifm7BGLqWbfVN8w2
	/3DzRp969rFS5z/8QV71biCnR5S/iZa7uOcLLaJrWZ+bBcVOA6dWlbxaK0UhL9E=
X-Google-Smtp-Source: AGHT+IFR4IQDVp4eZGLEQzP1pQrNcrnYsugaFmYFXfEDEI/ZIp5b9W5ibriVdnD+JT3yC6gapxYZ0Q==
X-Received: by 2002:a05:690c:660c:b0:6dd:cdd7:ce49 with SMTP id 00721157ae682-6e9d8994b20mr47660637b3.6.1730074482887;
        Sun, 27 Oct 2024 17:14:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9e094231fsm7715117b3.13.2024.10.27.17.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 17:14:42 -0700 (PDT)
Date: Sun, 27 Oct 2024 20:14:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: fox <fox.gbr@townlong-yak.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 03/11] dumb-http: store downloaded pack idx as tempfile
Message-ID: <Zx7XcLlMAF68t1ZZ@nand.local>
References: <20241025064148.GA2110169@coredump.intra.peff.net>
 <20241025065806.GC2110355@coredump.intra.peff.net>
 <ZxwLOxT17OhLX/Rd@nand.local>
 <20241026060238.GA2227062@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241026060238.GA2227062@coredump.intra.peff.net>

On Sat, Oct 26, 2024 at 02:02:38AM -0400, Jeff King wrote:
> So just sticking them in objects/ seemed like the path of least
> resistance to me.

OK, reading it all back, I tend to agree that sticking them in objects/
makes sense. Thanks!

Thanks,
Taylor
