Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="S5pfjmLV"
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6462D7D
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 15:30:49 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77dccb3e4baso15295385a.0
        for <git@vger.kernel.org>; Wed, 29 Nov 2023 15:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701300649; x=1701905449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SlMIsy5WTMEv1pgWZWbWF3c1senjr2M4FuW8LMj786o=;
        b=S5pfjmLVzK4AsHUYjTBE4/JR4bYDuD54LLj7NJnd8XxXw8KIx4q8aNoxL8R76SS+t+
         brE3FwCm6cytspRuDyAjsXngRYkSAPCQw+qdRN6YLmgUTjKj/TyXbsJVDJKkzhi3FEmf
         eSJ1OWKpf7cQAqi9x6foShIGL9ZhAhp74furuUUl9BC3g0zBCLFORnS7Fk0Z05NsJCQs
         r8aM2FViKdPIQscsIqIbBGZawwixu1H4Q9z2vvdLe4QZZwAQtvGsJI2FaRgGYqKHC4M/
         hhGP4J3u632jnpfn582ETIkCJGatHNBQqXUzGgqREWuIjujKIVXJHMXC5Ii8LjfhXkue
         kBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701300649; x=1701905449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlMIsy5WTMEv1pgWZWbWF3c1senjr2M4FuW8LMj786o=;
        b=Etn1OYtMOunJhgSnMSYktLuZToRbpYW0eVtNxj1lEodoiCJsbfgys6hwBqDBD41/xg
         CkJc/S2wjs0/buNMBypcTaG8fFHIUKFkVAUbxLTByIJbneQEmZaAqs4+6ljpw2QfjtVA
         blUgpuifDaKtr3HV6nACFrXaoet2PPCDeSAJCntSZUDsAJoQMzhzr/jvuKtHkORYp/ae
         U21anKgrwYdKW0aAFnuiiOB8Tqip4f4F68lxn2p9OmNHDs64MJz1AH/0utLrOdg6LZCa
         528ugT7Cs4PKwyADDol1RSzBpcZY95YV6ew8wz4Z6KocsMCfRKDY9X7mal2gu1nQeFzm
         ctbQ==
X-Gm-Message-State: AOJu0Yya3uuF2118G8eXANVTdF5chzXZswtlj6f9ymbO2BVSy1QbfHmE
	XacoEEPrXeEpKAJ0QLlSEGsE/i8gJAmMTTtf6+U=
X-Google-Smtp-Source: AGHT+IHJWBZXyajnFx2ex7Bd4QT//O1DX8czY1WVScuPhgh+hFExXuY0qzAKLerVTBzs2SLgeA/sbQ==
X-Received: by 2002:a05:620a:6901:b0:773:a9f7:eaf1 with SMTP id tz1-20020a05620a690100b00773a9f7eaf1mr16958912qkn.21.1701300648783;
        Wed, 29 Nov 2023 15:30:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id re19-20020a05620a8e1300b0077731466526sm5815270qkn.70.2023.11.29.15.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 15:30:48 -0800 (PST)
Date: Wed, 29 Nov 2023 18:30:47 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/10] t: more compatibility fixes with reftables
Message-ID: <ZWfJp80vzVhbdH89@nand.local>
References: <cover.1701242407.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1701242407.git.ps@pks.im>

On Wed, Nov 29, 2023 at 08:24:36AM +0100, Patrick Steinhardt wrote:
> Hi,
>
> this is the second patch series that refactors tests to become
> compatible with the upcoming reftables backend. It's in the same spirit
> as the first round of patches [1], where most of the refactorings are to
> use plumbing tools to access refs or the reflog instead of modifying
> on-disk data structures directly.

All looks good to me. Thanks for a pleasant read :-).

Thanks,
Taylor
