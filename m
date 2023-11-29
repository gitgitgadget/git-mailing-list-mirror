Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="WbC67N3N"
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABEEA3
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 14:19:16 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-423b8a41061so1438061cf.3
        for <git@vger.kernel.org>; Wed, 29 Nov 2023 14:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701296355; x=1701901155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iGjAwR4fJj9QL9dYgK4lHr0+Yen7QVlNESFlO30/VsM=;
        b=WbC67N3N1ZMD55b7+m07hjoFmqjuS2tcNbVyq5ww28ei0jVKhQ6PqAI4/kUHwPM7E0
         QrSlsrp85YI1jAmMwMKlQ+o29lrbmhIX4yyErKkOlmXdhUHP66zcxDNthERCRmaOf6dr
         JbSCMGrhL6yXrGBxaGFkw42LJK3oeLvaH461J91laRBWOJWO4LI+AVkohvozYmMim6Ms
         /lgyY4iyMPJHtu/7Xk8PBYrjqD4/YLuLN+xbM02obumUuNKOG3HYkNYqfieeTdCNMvke
         59ul873Eu5QW/cLZ8A3u1qHuM93pHYKWVA4OU7pTdwnU17NGpmrYcMVb/O2NEAL01zMY
         bVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701296355; x=1701901155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGjAwR4fJj9QL9dYgK4lHr0+Yen7QVlNESFlO30/VsM=;
        b=bH9M4EKmdx3T9Rlmh3vV+dHFdhOL3ha41z6GESOrXp+TxawMhLGl4tfuDStlH5pi2D
         jKwTV7ZJ+I4E77LnUVgEhPPpmyRdBy7vp7Ra8jmq8DbNujKN8n2A6JzanJz46DMx6YVR
         NLg/f7l47KMiVHyEfdFpfNCYY0S1WT7nmlfI1Ko389JqLK8fGnUHopeEgGcAUgmCTuwU
         wmVXCOeesddh5gcb1CIm+O6iyz5JK8rK9/U/eEQxRthlV5eHUgmktQZVvzwj9tqXU86j
         ijO3mcBhYWV9IaGbmdtPCqbJ9+zn0+wzuKE/kVOZSV5tGdAYadJS1oIryY55Rim87nut
         WCZQ==
X-Gm-Message-State: AOJu0YzkMur+LKHg7w+sYni3fkx7w5o3Y/Ee78tOY4BIcKV47Vm8qh7r
	8ZOJvth7i+W7W84Yc/NT88cCXGmXd8TmNue+pg8=
X-Google-Smtp-Source: AGHT+IFCzNoZmu7BPaMvktLKXC5DOr32ob5FRc1pYhG/Frka6FybdtTqbFkUOkDostp1s7ZsofF9kA==
X-Received: by 2002:ac8:5307:0:b0:423:a6dc:f964 with SMTP id t7-20020ac85307000000b00423a6dcf964mr14550061qtn.28.1701296355213;
        Wed, 29 Nov 2023 14:19:15 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e13-20020ac845cd000000b004194c21ee85sm5976478qto.79.2023.11.29.14.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 14:19:14 -0800 (PST)
Date: Wed, 29 Nov 2023 17:19:14 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/10] t0410: mark tests to require the reffiles backend
Message-ID: <ZWe44hBxBCX50TIs@nand.local>
References: <cover.1701242407.git.ps@pks.im>
 <53c6348035360912a9d720448dceb17895703da2.1701242407.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53c6348035360912a9d720448dceb17895703da2.1701242407.git.ps@pks.im>

On Wed, Nov 29, 2023 at 08:24:40AM +0100, Patrick Steinhardt wrote:
> Two of our tests in t0410 verify whether partial clones end up with the
> correct repository format version and extensions. These checks require
> the reffiles backend because every other backend would by necessity bump
> the repository format version to be at least 1.
>
> Mark the tests accordingly.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t0410-partial-clone.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index 5b7bee888d..6b6424b3df 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -49,7 +49,7 @@ test_expect_success 'convert shallow clone to partial clone' '
>  	test_cmp_config -C client 1 core.repositoryformatversion
>  '
>
> -test_expect_success SHA1 'convert to partial clone with noop extension' '
> +test_expect_success SHA1,REFFILES 'convert to partial clone with noop extension' '

I thought for a second that the SHA1 prerequisite would cover this
already, but that's not right since you can be in SHA1 mode even if your
repositoryformatversion is 1. So this change makes sense to me and is
well-reasoned.

Thanks,
Taylor
