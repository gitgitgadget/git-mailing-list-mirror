Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A8719BCC
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Hb9QTndd"
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597EBA9
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 12:32:28 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41cc7b67419so36136101cf.2
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 12:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698694347; x=1699299147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DH8yZlqqk0pdFBWhp+kt6qgUQ4gWDRC2AxWrgPzU8DY=;
        b=Hb9QTnddX4xQB8NpxGlaTMrd5YD08ktXUWMQJnhft3y0k5kRcQRtF9jtf4zv/NvLlV
         E335AGBWOpYfxB+ZnoOaNFvlclh+0rrkd3G3JLMwTbUd5jfgJeT753zVUvVrND55UIyb
         5kV6CW1E6zi8cW0vnKrdQ5HfAygyeq8L5hjMXM/Coag8xlEKbG595b9sdilSUqSaNSSK
         VyRHwKrkrOZn5LhryFdfuS2e+JAxjw1hmhp7MUnaOASAtRWg4vAeiB3V/pgQUxbNDDQC
         89DmFD+qgJxds8GHO/dAqnFGpKhg+KxTB5YhvEBTv4RzMNcGfzNRe/yClWRKxkeMMFO2
         Vcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698694347; x=1699299147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DH8yZlqqk0pdFBWhp+kt6qgUQ4gWDRC2AxWrgPzU8DY=;
        b=vJTpxbb9Oe+i0EwsRVWxngobLE1Asy/s11unB3P+/cXmstr01wteiz4Pn7FOkzYTR7
         1zzBQJq3EDJFMn0pnTPRV49qiS6AXOjt8zxblMOri3H5t/51ioVTShMOIpoEWybzYfy7
         pKjHDiC6GOq1O4IeUjyWzPhR3UY/ZwQy5k+9lPRfzmMZgB4/9l2xTUL2wqv2CRHA8sYh
         PXv1bn1E/di0q5OauhjQRLFv0VOFNSEgjdKcyhixjWAOVsq6PSKfzYZY2YPKD9aZq3aa
         RCekcSZBqXyVLX0AiRzXeJ/y/FnQu4/eEeCzIFWiVHE2yd0pLkuf0fd5yxLhn+LkTvMY
         MYPw==
X-Gm-Message-State: AOJu0Yza2CDozKPqC/kHe2KWCxTiDb/64bE0KTqLQWUrzctLEEBy+Kf9
	sUX7AVaAImlnxvsYEVYAUBEFpA==
X-Google-Smtp-Source: AGHT+IGzsZwIhn34gu6eyTqy57bwqqPxl3s//uJ1uMj2SxyR+d8jhAUXdjnWYmmHK2vw/7GFOYvFyQ==
X-Received: by 2002:a05:622a:b:b0:412:cd66:f65d with SMTP id x11-20020a05622a000b00b00412cd66f65dmr13354433qtw.13.1698694347487;
        Mon, 30 Oct 2023 12:32:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g10-20020ac8480a000000b004033c3948f9sm3662834qtq.42.2023.10.30.12.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:32:27 -0700 (PDT)
Date: Mon, 30 Oct 2023 15:32:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 00/12] show-ref: introduce mode to check for ref
 existence
Message-ID: <ZUAEyc0i6iISekiM@nand.local>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698314128.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1698314128.git.ps@pks.im>

On Thu, Oct 26, 2023 at 11:56:16AM +0200, Patrick Steinhardt wrote:
> Hi,
>
> this is the second version of my patch series that introduces a new `git
> show-ref --exists` mode to check for reference existence.

All looks quite reasonable to me. I'm happy with this series as-is,
though I left a few minor comments and suggestions throughout.

Thanks,
Taylor
