Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CD279F3
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 21:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213311; cv=none; b=UyMEM+Oz3XC0meMXUyfL1FYtom3W6ZSfUFG+VKyQ1L8/U8vOWIxaM0N1viFZGKyVlXm0SuKwX3CIm7pVJyK2QBxATimR5IF6jqaGi+as43qBIc6yT1rt7AF0EQUpdbH0BT3YABqQrMXmIjTp6S7fojakUCoNgLxa8D4yu03hrLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213311; c=relaxed/simple;
	bh=+MO8IDwmI88WRYPdWlZqtel3rv4inc7bvnYUcpqtcy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZXPvT+9kDE/a0R1wVZoMdGYN8b4i2H5rnrelZa51xCDDwgK2mVR+uGtcPA5EfJH0EMdZIQymvpFsd9VD7r6rgyGn3jpdNNYTgR1PL//Gx7nQhv+abgtQKhGEbDO7/TJpq9jSNPLTfvWZpIMG3M29y6n1v25jGzo0l7IA4Ql8pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=hd6zN2Pc; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="hd6zN2Pc"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-70224a923fcso1278014a34.1
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 14:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1720213309; x=1720818109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+MO8IDwmI88WRYPdWlZqtel3rv4inc7bvnYUcpqtcy8=;
        b=hd6zN2PcvOgiOorwSOBKOy89hXiSIYhNiU9nwEtrJ7UvD0b4opMIOfW5nyXT0/0Svg
         lvVOilHEvPWZ2Rq4+4zKQvsqiNdWuFute/Yc9r7PpCl3rq6lj7hu+IYZJ9EYCFHLbpSn
         R7gqhxDe7uU6QVfBaJCTNiixH8I5nijHT/pz8SWLWOwUyIm+a/CoqnmMryhTsa0NVKSH
         3RdB60cXQEgnRV0//knT0VhtIQGhh3ZhcyBTU3vggtEfsRLzhQLR0uR35RcFcILU1W3l
         9KlLUsAT9IsJritrh1jH+B2OUOeCCuGuKaJLNctG5hDV7117UgJWyR5leunxt8ak5QAw
         cTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720213309; x=1720818109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MO8IDwmI88WRYPdWlZqtel3rv4inc7bvnYUcpqtcy8=;
        b=LcW5xuhAN7r2kqFNzewK1hlCVWgvBPwifM8smLrk/KF4yyZQavJ7vcGxa6oQxKdKue
         XZwpK66qf0FTsUZJs03xh+SL9KH9rYuzS1e9W0jvra0ZpHzEHKKk5ymMP8ZKRTHCe1VS
         +8r9hHygH4QjqDjM6oIE5NHaavOPxZcY1ON0eWLw3Hh2OjNMMMNzoVSGmnkEjjHj9krs
         sjDC3WnAlCVIMPMHCRCXQulPcWnGOi019BJjkBXhzJJh01ug9kH4X9zGGI9p6Ihq+1tD
         RDR0FltxPz+6VGlYU6ggJkFejZopFvYg1A9L64mrM71UjIVLyGBRz/dly0DBcDcRz6Uy
         G+NQ==
X-Gm-Message-State: AOJu0YyqGwTFUp+5Q625wCT8anv3ijqFS6SZIG1EP06Jyg/oNpuf0F/E
	0Oi7FvVaRVsQDLK7A7hC1Ktw7Isrf9DVIVkNraa0zCYGV/7HMagTEbUVTUBXEn6oKP+vUNNP02C
	Rsmo=
X-Google-Smtp-Source: AGHT+IFgUEXyVxt4U+hJm80a3AAZvDIbk95xUXBSxiB2SMlHTtxOFF+MnqTqQIJ1gVNt56IxT/HsDg==
X-Received: by 2002:a9d:7382:0:b0:701:f4b0:bef9 with SMTP id 46e09a7af769-7034a74cdebmr5992852a34.14.1720213308752;
        Fri, 05 Jul 2024 14:01:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69307c42sm804042685a.122.2024.07.05.14.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 14:01:48 -0700 (PDT)
Date: Fri, 5 Jul 2024 17:01:43 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Aditya Sirish A Yelgundhalli <aditya.sirish@nyu.edu>
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
Subject: Re: [ANNOUNCE] Git Merge 2024, September 19-20, 2024, Berlin
Message-ID: <ZohfN6V/PGdi4SQh@nand.local>
References: <Zj0JyL1b+g1G3zWx@nand.local>
 <7e506cb4-b47b-44ac-9e08-ff783f18e5dd@nyu.edu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e506cb4-b47b-44ac-9e08-ff783f18e5dd@nyu.edu>

Hi Aditya,

On Fri, Jul 05, 2024 at 10:12:16AM -0400, Aditya Sirish A Yelgundhalli wrote:
> Hey!
>
> A co-speaker and I submitted a talk, looking forward to hearing back and
> attending! :D
>
> I was curious: is there any clarity on the timeline for when the CFP will
> close and the accepted talks are released? I need to apply for a visa in
> order to attend, and having a conference program, etc. would be very
> helpful!

Scott and I are meeting to discuss this shortly and should have an
update for the list in the next few days. In the meantime, thank you for
your patience!

Thanks,
Taylor
