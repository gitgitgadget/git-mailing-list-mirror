Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936228F49
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qRb4HHsd"
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3173611F
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 08:19:26 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6ce2b6cb933so417720a34.0
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 08:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697728765; x=1698333565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5/p4ohCVsg5S4csDBXvg2hb5PTnKxWTSa+pgb0K/x8=;
        b=qRb4HHsd0Nm1nKES2RydDpnPoQrAzNQ53a6P3uV4GOBGrbm45d4HiIWQ8Fzv/lGBZ2
         oQGocA2aDZt2MPhqizdGVJBhF7j168wtzDFCF2UdU7GgJPqnLSVqtqYGd9+UAVadeeSQ
         6I3z10QU5WG+H9Dxd/DbPF1BCMeJxXvQSVapA6YRPfHYd6k0mcr7fALCgizcQlcm/H+E
         Mvf4Ya5wVuYzucXMqyd9rjEJzFk8Ikh1bck3pX5MNXHeF6gphSHnaVmpUBcmNaa95Ov6
         0F+GEhn2nAt+fS2FNiNWshAvGbh7yNrmcIBgM6r9ZrUXTb1Td0Vjh/0mzKUT7c+pmYwM
         +3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697728765; x=1698333565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5/p4ohCVsg5S4csDBXvg2hb5PTnKxWTSa+pgb0K/x8=;
        b=qHn9n9XzXrCKYgmHqHOkBYJ8fWm8fMGvgKANJ3AhN7fq5EbFcqYYwQzYk5vMWjoC/G
         wuYa6aQVjBB4vwE1qsoK7kE9yNwoevhwOu/uwGCvMGPS2wxySmysjR9YQXe4P1fRzDUJ
         L5GwdF6t68FT4suMutMf87lPh81uqpp2I3n9u3XIZQK6fwCdiL/SQEwDqdBYwoN1XYt2
         wL7JXk5ZdXv9ZJccFrGO68m7DXOy+BA2srxO0fAxN0BkUo2zgwCzweX9S2S05g7/omfx
         E31kRKuMTZRwtIdfutO+oAXA3X31+W0xNWwiaU+2GDpnKR0UZyH4bJywGaIqtYLgvTMh
         F9/Q==
X-Gm-Message-State: AOJu0Yx5bFKccMS418/Qbl73n/kY8qq/U6+bsKpWnkfUKNauEysLo0Nx
	B9/W74RSFnG6btcIZfxhoVc0Jg==
X-Google-Smtp-Source: AGHT+IFxHTQwj6VPl4WQfBSJrTrK73oopb6WO+ZX8ylaKfl+uF1LM3xVYJ2fsvDkvfLFUO+EsnnC2g==
X-Received: by 2002:a05:6808:3:b0:3ae:251f:923f with SMTP id u3-20020a056808000300b003ae251f923fmr2515900oic.28.1697728765408;
        Thu, 19 Oct 2023 08:19:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id dc2-20020a056214174200b0065d0a4262e0sm855714qvb.70.2023.10.19.08.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 08:19:25 -0700 (PDT)
Date: Thu, 19 Oct 2023 11:19:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 05/10] bulk-checkin: extract abstract
 `bulk_checkin_source`
Message-ID: <ZTFI++b51Cj+Sto9@nand.local>
References: <cover.1696629697.git.me@ttaylorr.com>
 <cover.1697648864.git.me@ttaylorr.com>
 <da52ec838025a59a3f4f4ffaf2e6f9098a37547e.1697648864.git.me@ttaylorr.com>
 <xmqqa5sfplvw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5sfplvw.fsf@gitster.g>

On Wed, Oct 18, 2023 at 04:10:43PM -0700, Junio C Hamano wrote:
> Looks OK, even though I expected to see a bit more involved object
> orientation with something like
>
> 	struct bulk_checkin_source {
> 		off_t (*read)(struct bulk_checkin_source *, void *, size_t);
> 		off_t (*seek)(struct bulk_checkin_source *, off_t);
> 		union {
> 			struct {
> 				int fd;
> 				size_t size;
> 				const char *path;
> 			} from_fd;
> 			struct {
> 				...
> 			} incore;
> 		} data;
> 	};
>
> As there will only be two subclasses of this thing, it may not
> matter all that much right now, but it would be much nicer as your
> methods do not have to care about "switch (enum) { case FILE: ... }".

I want to be cautious of going too far in this direction. I anticipate
that "two" is probably the maximum number of kinds of sources we can
reasonably expect for the foreseeable future. If that changes, it's easy
enough to convert from the existing implementation to something closer
to the above.

Thanks,
Taylor
