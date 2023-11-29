Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Rlewtgcz"
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3611FE0
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 14:13:35 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b58d96a3bbso158380b6e.1
        for <git@vger.kernel.org>; Wed, 29 Nov 2023 14:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701296014; x=1701900814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cN8xsJU9IZ0RyFwLkz6lOxQc/xG9xiet81N4V9K5sok=;
        b=RlewtgczG6mJOriuvFelSEc+OfCq42l5Ow3YnNsoIv+KO7j4IlTl86MytigBGwbhAV
         yCt+ACH1Qa2IIgoJGaUnWf8Zo755bCeIjFQ70nqDGo8TnsThxe/uVLNkWbz82qXzlO/5
         XjLFlBw27sfbT8GdyG3gA4TbOictHhmy/zPXZWz1WpRBBWVo5LRZ0YC/VvNXKombNkkU
         jKXjyzTR1/+pIPcM2Dw3DBHsworjUPLcjV5UcKGjGKhDgYJ3121IXH5g53deTj4AHY8N
         MTySApaAeoloj9YXhRxUF2QKtKUN0bq0GfZY1/J+onmZVmYNp56BgvftYS1L1rTrPnhD
         6W3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701296014; x=1701900814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cN8xsJU9IZ0RyFwLkz6lOxQc/xG9xiet81N4V9K5sok=;
        b=X3WxXrKB/8EIof7t1F/bBJvfYv1pKgp3mxK0DFSuy0MS3uMSy/UGEkR2dSoiCjdUwX
         BuqOxjshT1p2ByDYxM+3bqR0q+uOc8oh1pmkGlEWTzjZsg0QVhcYd8+FODiJmC0SrLYB
         v3HCgT9MEVuEh+ytjvdAmit59osmW366B/0gVBL4y8sRrYXlnU8olKwST+Vbye8vrCzN
         AtKv/7ui8i7Xq32Uq3DHnW4ikIijTY3pUYHyIOorCQa1n6e0+JflW4dbkGcpOYQ7dOvB
         26u8cqLupQxLDv7jPjOroXPfCTrr4RMwyt7zvEJwQtZPsY1jZoKbj82QmMWz8l40qXxp
         fJJw==
X-Gm-Message-State: AOJu0YyW/S097CkP8/tFyyJok3FIqT1UJdOXLteOEcPReNOdH+RjAEPd
	HPfBGrAxKNKv4zUSF9KY7nvw5w==
X-Google-Smtp-Source: AGHT+IHwhOOsLTXWKr8xxMNBqGsbM+OWgyV5jA+IE/Mv8HTgdnTQFbILL2Eiy278nuJ39Vo9v0Jzvw==
X-Received: by 2002:a05:6808:bc4:b0:3b8:3e9c:af97 with SMTP id o4-20020a0568080bc400b003b83e9caf97mr22820383oik.48.1701296014430;
        Wed, 29 Nov 2023 14:13:34 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id qz19-20020a05620a8c1300b0077dc5e60fa1sm1410771qkn.54.2023.11.29.14.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 14:13:28 -0800 (PST)
Date: Wed, 29 Nov 2023 17:13:24 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, hanwenn@gmail.com
Subject: Re: [PATCH 4/4] bisect: consistently write BISECT_EXPECTED_REV via
 the refdb
Message-ID: <ZWe3hCpTu/OYinWi@nand.local>
References: <cover.1701243201.git.ps@pks.im>
 <c7ab26fb7e9e24b12b83dc26fbc17ff4d96e206c.1701243201.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c7ab26fb7e9e24b12b83dc26fbc17ff4d96e206c.1701243201.git.ps@pks.im>

On Wed, Nov 29, 2023 at 09:14:24AM +0100, Patrick Steinhardt wrote:
> ---
>  bisect.c                    | 25 ++++---------------------
>  builtin/bisect.c            |  8 ++------
>  refs.c                      |  2 +-
>  t/t6030-bisect-porcelain.sh |  2 +-
>  4 files changed, 8 insertions(+), 29 deletions(-)

Very nice :-).

Thanks,
Taylor
