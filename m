Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F8C1C29
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="gOWvLjiM"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6d9f7b3de20so136026a34.2
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 16:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702600737; x=1703205537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gyx/iHWFBsg4jf2xwSif4cPAUz10K4QMQPwCcKH0s0w=;
        b=gOWvLjiMkNLIth7BhoUk1SX5GH4xb6jBekvUQ+frYX9wz3BXScAn1RRLYipG+13082
         2B20oCxhX9bejxz4v1oI4Z4EPF6l5IrFgGW9dIPV1EGKxT8HIQPNkKT48Iud7xOO2af6
         A9BLtbQcMnqY+8PpwWgRT79jbl2hAY84yHefRT40EDI1ElxLizTlbgObC3Z/yYuuqsdr
         ljyyXGfqOZY4JFIjKSG5sECrVTFD3eMW1smjJfVzSeMOlUpVN9ocrT9ZmAESM7pcugBr
         yW4Sa37m5GEcOoA5v56uoJlR8TIPbcn2s6T6fCWaTPKtG/mxzl5CRp/UDjHjeiVsglDG
         HG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702600737; x=1703205537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyx/iHWFBsg4jf2xwSif4cPAUz10K4QMQPwCcKH0s0w=;
        b=C8Adbc6OkSwBkuu0gR1fzwG+gVSnnG9s38QQastO+eIlXpu3FmZWYOcSG0dNJIGE0A
         ZXgjc3rjSz5/5gpuaiMjVcdEkM5dT7rMKj0anjlHQ0UNK8kmPsDEn4thedrVZXSnBa8T
         5O7UVJwa5TiB7gsP8zSIQ8c46jyXP7xiuxN/hQZZ4sOGEKvCRFS2GOdYjniNnGfkfJzY
         l3ws2B1ZrOp4RAGAE8ZSWGbr6nqqUg0Q/7vQL4cs6EBoZFzhJ2+2uaP8cYH2kqnwbOdU
         VKhsO9IIxFLtV7SmwCFRC8OeTAGLS19/7ot5PtZ/xIXYaXYQiYdNY/WsikOYkW3AEsJp
         2Frw==
X-Gm-Message-State: AOJu0YzO9zyxWy0S6QTwc2+1/mekvvWasD0abvtsi7uHYeW5FUoBI8LF
	rljhdVPrU9UcZuU5yaRpyA4MuVM2Q4mW+tE6W3X3og==
X-Google-Smtp-Source: AGHT+IF+m1oitexn2YYu0r6S3EDUozF3sU9yAyHang3dBuVjGUKjLeUjAiiiiV3iMy+rZqHLwWu0uQ==
X-Received: by 2002:a05:6830:18a:b0:6d9:f06c:4ba6 with SMTP id q10-20020a056830018a00b006d9f06c4ba6mr10987001ota.69.1702600737345;
        Thu, 14 Dec 2023 16:38:57 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r6-20020a9d7506000000b006ce2fce83cbsm3421947otk.25.2023.12.14.16.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 16:38:57 -0800 (PST)
Date: Thu, 14 Dec 2023 19:38:53 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 00/26] pack-objects: multi-pack verbatim reuse
Message-ID: <ZXugHcFnfmFPOOU4@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <cover.1702592603.git.me@ttaylorr.com>
 <xmqqbkasnxba.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbkasnxba.fsf@gitster.g>

On Thu, Dec 14, 2023 at 04:06:49PM -0800, Junio C Hamano wrote:
> I haven't looked into the details yet, but it seems that
> t5309-pack-delta-cycles.sh fails under
>
>     $ SANITIZE=leak GIT_TEST_PASSING_SANITIZE_LEAK=true make -j16 test

Hrm. I tried to reproduce this, but I'm not seeing it. I have:

$ make SANITIZE=leak GIT_TEST_PASSING_SANITIZE_LEAK=true test
[ ... ]
All tests successful.
Files=1001, Tests=14558, 48 wallclock secs ( 8.34 usr  2.10 sys + 391.60 cusr 319.67 csys = 721.71 CPU)
Result: PASS

With this series applied on top of 1a87c842ec (Start the 2.44 cycle,
2023-12-09). The tree I get at the end is d148e16f5cfba405a9823cb68540a8c83004f98f.

Did we apply onto different bases?

Thanks,
Taylor
