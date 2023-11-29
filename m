Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="UbkHWSCz"
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CE4197
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 14:14:40 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-589d4033e84so192604eaf.1
        for <git@vger.kernel.org>; Wed, 29 Nov 2023 14:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701296080; x=1701900880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4WWcMczcEm6X16tHjJeT8kQm55YWZIr1YF/JvRDC01s=;
        b=UbkHWSCzbNQR/OWTpvNiV7FT8tvFLBL+pDnp6bKcbvevDPip8TauHKFsx3ZAGKIeKd
         00YIxsYaGs71+VMn/op7ST3UQmEzrTD87jjUzwB3uX5HTNZ3JZi3PpzxwRaRIzUHqHhk
         5DHbVhlBO4/rNdLuA33rgen44U5DFgAXCVvE+FhyjJ04fNQjVGQ8pCvoY6CKIb4axcHO
         mR+aPCZwBKct04Qj4nv4jeoWWOkZleh1D/exF7y+Mo5xItc7ObfNYNSmGv4lt52XY8JD
         JAShqE8EgN0pdiqyFDF5Jx0MOoF0HoIhXolR/zC+dpjn8AmyyWF3octYjC65atvRtb3W
         PyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701296080; x=1701900880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WWcMczcEm6X16tHjJeT8kQm55YWZIr1YF/JvRDC01s=;
        b=arN7zTnxHSeBjhuXZ9QZWgOOYyYN3rJQlMaRV4C6mEyBHciQmDSo4aEZvUxqMsvtri
         wru69wW/YB1yxZjhTa9AWx+FP4DH+Ehv4rMhaYw1A518DbSMuCjV6gCcGA/QpcqeEYBI
         wjJ2P8LiZr8GXh/OntAHq3kbfcOcIgzJmwyfQK6xsJ6dIbBgrBeNheKJ8RhfYAtrFOZk
         6Q86s1ctd0tC6oKK0tMAeau3xeJwyr/izqpnaGgzAeS2ClRH5bJ6bDsxlFg0mPkL77+K
         VFyOSjRdND1pnEYrJUQu3Fk0RssxtozV1n8KfabV88Ic084OO/na44vVJ5Q3W6APjtoe
         kfOA==
X-Gm-Message-State: AOJu0YwPmXACFq9EHQ9fUx8qNo4OWVhvi+RxYpBcu8GLTY0PrgtqM+R+
	DOHygVOQhmTwJASVxheYiUcooA==
X-Google-Smtp-Source: AGHT+IHNnQ+DFxJoansqSG4ZdvWxu7UEqXMDAAN/VC3tetewShDwSgGKbC6ULuP+++iWFdEOsE4i0g==
X-Received: by 2002:a05:6358:27a3:b0:16d:fcfd:bb88 with SMTP id l35-20020a05635827a300b0016dfcfdbb88mr21992828rwb.6.1701296080191;
        Wed, 29 Nov 2023 14:14:40 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o5-20020a0562140e4500b0067a4059068dsm3487337qvc.139.2023.11.29.14.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 14:14:39 -0800 (PST)
Date: Wed, 29 Nov 2023 17:14:39 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, hanwenn@gmail.com
Subject: Re: [PATCH 0/4] refs: improve handling of special refs
Message-ID: <ZWe3z59WGE0+8gXN@nand.local>
References: <cover.1701243201.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1701243201.git.ps@pks.im>

On Wed, Nov 29, 2023 at 09:14:07AM +0100, Patrick Steinhardt wrote:
> Patrick Steinhardt (4):
>   wt-status: read HEAD and ORIG_HEAD via the refdb
>   refs: propagate errno when reading special refs fails
>   refs: complete list of special refs
>   bisect: consistently write BISECT_EXPECTED_REV via the refdb
>
>  bisect.c                    | 25 +++------------
>  builtin/bisect.c            |  8 ++---
>  refs.c                      | 64 +++++++++++++++++++++++++++++++++++--
>  t/t1403-show-ref.sh         |  9 ++++++
>  t/t6030-bisect-porcelain.sh |  2 +-
>  wt-status.c                 | 17 +++++-----
>  6 files changed, 86 insertions(+), 39 deletions(-)

These all look pretty good to me. I had a few minor questions on the
first three patches, but I don't think they necessarily require a
reroll.

Thanks,
Taylor
