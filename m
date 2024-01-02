Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C2B171C4
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2LsJnxP9"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-595d24ad466so517149eaf.0
        for <git@vger.kernel.org>; Tue, 02 Jan 2024 14:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704234556; x=1704839356; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q1paSHErGTFo2VbQDsttAiRBL6Jd85I4Iy0NSQ8Q358=;
        b=2LsJnxP9+s0C2HebQwCjgNHSYow49VMiIJrAlXKg3guklAV1ad/55cYtK8tmHynwKb
         +Urxt6UOjI/G3XtjE/1XED1hb9OVI3O26sO/nir9G/5YD/yTy2Ik3XWAejEEZaoSN0fx
         7F8YewFihHbumgxQIfrXF+ZGWFYqYJxYvmNVPLCb4/vsZt3rqoyr7jhawpasW1KzKS+a
         X56R0L82JDozJhbDqOEH4AemODCPk+YYUjqsL96jJf0gafzp1iMS2nyeBE2GRhILLkuO
         /bh6u4gUWxbYp3jM4qz3huj/61M/jFbS57L6WCsNGqgxEgxqOoshUIwQwnf/Gd3ZtFpp
         rxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704234556; x=1704839356;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q1paSHErGTFo2VbQDsttAiRBL6Jd85I4Iy0NSQ8Q358=;
        b=VIs2DliYjR03Iv9zXn0yNB21vW260PqEqB6RR7X/8tWHcNVxMd1mXtHeb6HFzTMrVy
         LwEjVk97FHeuUyUWxwU1R3OnxHOLqs1LKphq2tu2h+3//dCndiS4mGAP4D+mdafqz4AS
         soemVFXJG+8WtFKC6GYR+Y+dgCpllAYd3LBNBM9oEOCyGT6DoqJHRqAfZDZlanTA4gvY
         C/TaJIofsO7iH5UdRXpaeB6GQTwrrcqATeiMeRhP5npQRHPEZscy85MUMfckRHsOdm/7
         LZPJ++zbTsg/Ocdc0KM+OU8b/QF4S34b6x1brE+ygbB8Txil6+GqqekNzXc9uOhvLJ9W
         lY7A==
X-Gm-Message-State: AOJu0YzB2BwK/uAubzhWXUKA35KwOEGGN3euQDzRGq6QhJ7MEB6TxkDe
	OvzOyFUoX5IrWKwxSIfSgKB6binme8mDoQ==
X-Google-Smtp-Source: AGHT+IFLw3Jj+/VjWDkDSgXTS8D+nGI192ywpToBYdCNrG631qfM5S95cG+8BQFgNLTDCq+DzPmshw==
X-Received: by 2002:a4a:1407:0:b0:595:95c2:a23f with SMTP id 7-20020a4a1407000000b0059595c2a23fmr1355218ood.9.1704234555794;
        Tue, 02 Jan 2024 14:29:15 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e193-20020a4a55ca000000b00591c8fa01ccsm5342968oob.25.2024.01.02.14.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:29:15 -0800 (PST)
Date: Tue, 2 Jan 2024 17:29:14 -0500
From: Taylor Blau <me@ttaylorr.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Jameson Miller <jamill@microsoft.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] mem-pool: fix big allocations
Message-ID: <ZZSOOg8pMb6iKzHz@nand.local>
References: <fa89d269-1a23-4ed6-bebc-30c0b629f444@web.de>
 <1c39c0e7-05b2-4726-a90c-f78df4356a41@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c39c0e7-05b2-4726-a90c-f78df4356a41@web.de>

Hi René,

On Thu, Dec 28, 2023 at 08:19:06PM +0100, René Scharfe wrote:
> Changes since v1:
> - simply use check() instead of a custom check_ptr() macro
> - drop unnecessary comparison of next_free and end pointers

Great find and fix. It's nice to see some examples of the testing
framework being used. I'll have to play around with it sometime :-).

Thanks,
Taylor
