Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48591BDD0
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710604896; cv=none; b=J6nYwOzAJFnPBH6+OP+p+za8El+7A0xaGFopFxV0VekkCsD1riAwQdM34872ergRgdfX8EvC/E875znD4iLE5UAcvnydSmA84CVmes/MFZW6o3YbbJT6e+Hhd38vrvRtlTTanPeUOGSblbs1voeUxHMtPaVlodaIH2cA60Y9Hfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710604896; c=relaxed/simple;
	bh=ErXRepkq9WcSYNwUFCj2oAayIV26taSQ9XxwEhtH86E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIFXMTcyvY+k3aLkQgB+kOHonLvgjgJp9c4Aog04FCpDUSjpZc4RaUrJDPEfWCKul5wDGnEUKlBq1Ap15eRhGa/51b9yhc44iTtQ2HFSTNqqMwMzJ3siN1Pxm95FrNA8wzn/mVnZbaah9k8FL9i8us+gc5VIUhDlQSjuP3iqjRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=hqHY4pwd; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="hqHY4pwd"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-690edfcaff6so21216826d6.3
        for <git@vger.kernel.org>; Sat, 16 Mar 2024 09:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710604893; x=1711209693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OFP0m0QawWbwevuG3Qvm9NUFey2wRNQk0ktNyTP/2Y4=;
        b=hqHY4pwdUj9LGQ5hoLnpCt7UL0x/TRzIQxNvV6HCrTPi2dO9bpArIKFmJX3bItWnpj
         f2p4JpHb0Q9T680/S6HxooMmOFxuC999tATlQ8ycei9yF2YUV4XBRw9HZN7Fq77h1H0H
         ACLisVK2XnQjyD5iW02KFxs4zQmb4ISxbajRf62FH5SlN7W99GNjoRRb2gWzwFXHB5CP
         OUOAJjwKFwuh75q1HTJIt5NGSqPGRvvZpb/8K5lqY6jQ4tUp4eOTAqgLvNt3QXxTUL6I
         w9Z0R5oZPXjHY3zs2u70sdbzcku5Hy8QdanOvZkb75BGkZhu9lFvqVZy/EoBE0JNWfTT
         GMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710604893; x=1711209693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFP0m0QawWbwevuG3Qvm9NUFey2wRNQk0ktNyTP/2Y4=;
        b=B/81EZWJ1MHzq0dEMnKf2oCuFkDGMF2bYNkKtMJqpa/dOyAIs17ccX79xJQ7t7xHYX
         ap9alSeTb2yKr4D1LIPIHmLQiFdIKLkCse2zFqicWNnZJlv6KJAZBwmJChUOdxYfCq8D
         wdOvOnUdfpz2Qo/L7ajYHYr95DaQQiAqTRRocl8QP1yVGoLHTgBRVq1JDK8WQsr6EYnM
         xjfOUpI3Lofr3ptyXFQ6Rh5RgJbXb4TzesM7WoTNa/tP8u9WeSgAsN8L0K/8NkwZ2Y5a
         NexniyAiW/cE1W4X0jBv0VnDiWI8oqb3mTMXD4WtRy4UQO24m3TzAVyoHQNB6KHS66LB
         V06Q==
X-Gm-Message-State: AOJu0YxbGsYXH65t8zc3hChkVyYFKqNS+K+YrM+AE7DvjtNTyFOKw7by
	ul6sFaLyWmpi1LyqzwjZcWWvc6AbXXKWOBe2n9P3OuWSBfkZ4rE51McwZQANYSZEcr1zmfW550g
	2m5s=
X-Google-Smtp-Source: AGHT+IGkoxhKIoPWqZYB2ngOQYy3CnfALuWJbmnF3SmBxSjKBQyNzUCpzoCNBWAeaAAaFAlSSqwVBQ==
X-Received: by 2002:a0c:f347:0:b0:690:30fc:1a99 with SMTP id e7-20020a0cf347000000b0069030fc1a99mr7587006qvm.5.1710604893612;
        Sat, 16 Mar 2024 09:01:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id gv4-20020a056214262400b0068fb6fb217csm3309132qvb.122.2024.03.16.09.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 09:01:33 -0700 (PDT)
Date: Sat, 16 Mar 2024 12:01:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Ignacio Encinas <ignacio@iencinas.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] config: learn the "hostname:" includeIf condition
Message-ID: <ZfXCXAdlYdS/p8BC@nand.local>
References: <20240307205006.467443-1-ignacio@iencinas.com>
 <20240309181828.45496-1-ignacio@iencinas.com>
 <20240309181828.45496-2-ignacio@iencinas.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240309181828.45496-2-ignacio@iencinas.com>

Hi Ignacio,

On Sat, Mar 09, 2024 at 07:18:28PM +0100, Ignacio Encinas wrote:
> ---
>  Documentation/config.txt  |  9 +++++++++
>  config.c                  | 17 ++++++++++++++++
>  t/t1305-config-include.sh | 42 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 68 insertions(+)

I took a look at this patch and felt that it was all very sensible. I
left one comment in reply to the sub-thread with you and Peff with some
minor suggestions on the documentation.

Otherwise, the code changes here all look reasonable to me.

Thanks,
Taylor
