Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625A415EAC
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 18:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="unoji55H"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6dc759c8ddbso385936a34.0
        for <git@vger.kernel.org>; Tue, 02 Jan 2024 10:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704221387; x=1704826187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bkh3mWyDIa4BqfYnQGHLpyBwYU2gLlUXTE7R3F81K3s=;
        b=unoji55HJwxChIsG7W5NBui50S/4N67ZDrjuNO1cWulWECtVyPtlmo1vBeIgn3a2OJ
         KMOTX5s4+5hfjhddUscaRx/derCDkD2FcjebAF4Y9LN346LLprfHVaLw52pnmgZ7P8cU
         SnoyFpNzfKu0DILCDxOBrCu6DcdWCv6dqzOt5sVKqdAy3n2TBPguD6HwIoHDhiwa2d2G
         G/xo8WTB3/DsckeBEtkPd+G71m6Suko6vDy5YIhPiGvsXUrc3dooNz1I4wuUiwE7SCQt
         amgcAuRmgz6muYCqEbD773s4s6hsANDtpZJbn2g+0h1G7jROH8z2NnYog2WfAmnHsS3w
         PaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704221387; x=1704826187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bkh3mWyDIa4BqfYnQGHLpyBwYU2gLlUXTE7R3F81K3s=;
        b=axZT6wid8FWJYit6UqAVkiC9dP1bI1h1eXrPCb74q2cN8IUSboi0jpx3IOQ/vzFwo1
         toljQ/5dnwAqG0Mi5N5ZzMOS8Pp+gvfGxnNoOnbwJj0FxEcsBpHOdns8BGRbBiduwOW0
         tpbuHIsJr9FtvhC8JJB61E5sdPQ82uqmqP8iUiU0e6oqVZD1ffBbJQAAWbPOH4OY/Hk4
         D+CESFNPJ3jQUz+7PnZJGZOBTDMWbVfwv9+ZiUdqYWQE7M2l6z02Ws7GZ5Rl/PDKjFnb
         sz/GFdlxBaJUSDwjGnHOYGGZ1KjGEz0iQAttKtkAIj1eyN7zYyEHlrVbfXHC0z35ha/P
         MZEA==
X-Gm-Message-State: AOJu0Yyk8Tx8p8m+Ff1UfDBepZ1nvr9CoShC0poDNMuMObdrAuApB1hu
	Ady2diZnJPLZ+NXVoLslubBUWAzKvS683A==
X-Google-Smtp-Source: AGHT+IEzQ0qlyTsjf2pWUNQ/+9WmsIVCjDBYPXQojcGbuo+DIfBrkjnyzqksNqbBMP7INYTJDFO26w==
X-Received: by 2002:a05:6830:44a:b0:6db:fc35:54f5 with SMTP id d10-20020a056830044a00b006dbfc3554f5mr6746381otc.42.1704221387467;
        Tue, 02 Jan 2024 10:49:47 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l19-20020a9d7a93000000b006dc018d03ebsm2163064otn.17.2024.01.02.10.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:49:47 -0800 (PST)
Date: Tue, 2 Jan 2024 13:49:46 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
Message-ID: <ZZRayoauM6s5XUFR@nand.local>
References: <20231221170715.110565-1-karthik.188@gmail.com>
 <20231221170715.110565-3-karthik.188@gmail.com>
 <xmqqzfy3l270.fsf@gitster.g>
 <ZY1PLtPue4PgbhwU@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZY1PLtPue4PgbhwU@tanuki>

On Thu, Dec 28, 2023 at 11:34:22AM +0100, Patrick Steinhardt wrote:
> One interesting question is how we should treat files that look like a
> pseudoref, but which really aren't. I'm not aware of any such files
> written by Git itself, but it could certainly be that a user wrote such
> a file into the repository manually. But given that we're adding new
> behaviour that will be opt-in (e.g. via a new switch) I'd rather err on
> the side of caution and mark any such file as broken instead of silently
> ignoring them.

I probably wouldn't spend a ton of time worrying about this personally.
Without additional information, I think it's impossible for us to
determine a-priori whether or not a file underneath $GIT_DIR should be
interpreted as a pseudo-ref or not.

I agree with your reasoning that since this is opt-in via a new
command-line flag, that we're probably OK here enumerating the files in
$GIT_DIR, and printing out the ones that look like pseudo-refs.

Thanks,
Taylor
