Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="nKnd5cRU"
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8CCC4
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 12:16:28 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-67ad531686eso47353746d6.1
        for <git@vger.kernel.org>; Mon, 11 Dec 2023 12:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702325787; x=1702930587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IBdMg4vn3iDdVhYG6oK0qRUYZ1uGmInFMOlMuivgcQs=;
        b=nKnd5cRUHqcXh7RN70kZ4CMLnA4wAlHu/8ZwLt8CIEiXax18Di0WKYMgFivYBCR+a3
         wXlWX14+aLU5vOZRwfqaN8jw0tKEnxXkfMq6o7U5F6JPdB76e6nm0nwLOG8uw+T7ARgC
         V30BRRptjUQQCCqowd1rllMFm/uvbscbAVPfa8hqOVZyvh9v07ygutVLbk3jiC3P1JiH
         n7qb3XSnCMaeNT48pxvvYupNaVjEGmOcYDC2osvFr3LKGCBzaD7iRIgLFKPWdk5rRz0I
         tZ7OQtSRBV5/0aC5NghPhIEOx1uZH0TNl8E+WP+jwWz8HtEP8v9o/xMc9YJ2ahEUQzfI
         WwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702325787; x=1702930587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBdMg4vn3iDdVhYG6oK0qRUYZ1uGmInFMOlMuivgcQs=;
        b=U2eIxFfL0j6s49ffyc/XkjREDkwBwFG/0Yb6IkoHykzgtdC8fyIn68Z15H4b6Sfg+j
         eyjllKZzsJTJjRgUy4i+BKdQR2LfJ/bjs9qcqkCt14PV6IPtt4mkY0J8FQW3X4bfrW+C
         Jd+2ZgHYwliAqpB7XrbK4g7zH8QxQ9Qp4j1kg+ATpXEpVmX/NOX56sy1wejH4F+a2hdl
         etqznlcz+vsu2DgW1Jp1kfxUsFjoJ2U7AMSYmUjC5xq6yjC3r/lFybKaZLpBXhNfL5h4
         bGnPQnD3aMTd2lUvI3gxyHDme5k2e0+3xUp9wflsd1qTKYu6Sklu90fhcTIqwXJYB7Ha
         VzsQ==
X-Gm-Message-State: AOJu0YyHpKJfN4wULWgwVGP8Ob+cV8DxMsPLVQ8eWTuGXg3hDX5SpxPO
	hI0r9OSG6cLiIf4flxj+k9u03w==
X-Google-Smtp-Source: AGHT+IH603Gwjn0i85F5JnH+fgJaF6pxWWsW4EoQ5SJp2nXsigwapSe/fQaGiEwzm+XCD3ZsUlqG/A==
X-Received: by 2002:a05:6214:2cd0:b0:66d:9987:68f9 with SMTP id lf16-20020a0562142cd000b0066d998768f9mr8049590qvb.15.1702325787472;
        Mon, 11 Dec 2023 12:16:27 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o5-20020ac841c5000000b004254355d4dcsm3454177qtm.77.2023.12.11.12.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 12:16:27 -0800 (PST)
Date: Mon, 11 Dec 2023 15:16:26 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/11] reftable: small set of fixes
Message-ID: <ZXduGvCJIa25eldZ@nand.local>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702285387.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1702285387.git.ps@pks.im>

On Mon, Dec 11, 2023 at 10:07:25AM +0100, Patrick Steinhardt wrote:
>  reftable/block.c          |  23 ++++----
>  reftable/block.h          |   6 +++
>  reftable/block_test.c     |   4 +-
>  reftable/blocksource.c    |   2 +-
>  reftable/iter.h           |   8 +--
>  reftable/merged.c         |  31 +++++------
>  reftable/merged.h         |   2 +
>  reftable/reader.c         |   7 ++-
>  reftable/readwrite_test.c |   6 +--
>  reftable/stack.c          |  73 +++++++++++---------------
>  reftable/stack_test.c     | 107 +++++++++++++++++++++++++++++++++++++-
>  reftable/test_framework.h |  58 ++++++++++++---------
>  12 files changed, 213 insertions(+), 114 deletions(-)
>
> Range-diff against v2:

I had one small question on the new version of the fourth patch, but
otherwise this version LGTM.

Thanks,
Taylor
