Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606EC3C461
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1fIJZSWo"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5e7f0bf46a2so29087637b3.1
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 10:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704824938; x=1705429738; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K+a9J5DVjTkBnzbHXMdCDB7AlfzoF6wYIg5RXsKyMio=;
        b=1fIJZSWoa96gefN2bg+AOGQ4wTVs8sZnveU+D7wZH7H7jRNt20Yo1l3ex9q2UP8xc6
         2Q/dLIpdjt9lBf+e120K64qbHkOUns/wK7HqZ/yt7fjFL1xNdIno6BP2dPZOaVqZ3zVu
         GHRYaRVlwNbTPrib53XzOYv3LhEA2lx1Xx8l/XKJYABk5AYDTvYtsjxHJiPQzpRdespF
         oG+bRuaHpRZs+8kqX1yaJb0EyvJcSGmmNuHRYgAnsPUVjVnjYzoYLcshR0L3jPv7kyJx
         /hWfUXfQHPfmuzF4NpAt59kOqFGlyYtXJsIv/Py1wgBiVQ1rtUQiGvg6s460b88rjBoU
         180A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824938; x=1705429738;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+a9J5DVjTkBnzbHXMdCDB7AlfzoF6wYIg5RXsKyMio=;
        b=EInFmkknouwgmv39OYxW9GKubxhYx5VEa2581NhxumvwdSVsDkReUO0Asip3EU4PsJ
         cQuQvpskjQ4vwge+npiq39W55CkvXt8p7VmCzpFDbDwE9+1l6Cn7Tzuofcc7SPgIcL8o
         SISEb9kTRRTVeJXlqzVK2UvjG1sxcXOYYOyg/et4hMzOtfxm1BXNRyG/l+m0xnwXq3qK
         HIf8eK/RoIIIb/BYo6IZyoqzzD6sNx/VaGOpV8vi8K5VHIOzeLBXR2IUkxUb1daokxTl
         0ESY92Ep6Sd6tFt/jh5lIEApyN2yvlm27rggQd6Pv9Lrcb1HvuuK1VcUNCoQ5MeFjjOd
         xiZA==
X-Gm-Message-State: AOJu0YxC+nRzkiwjakbhelKA54zymICWQ9XMkgVKOQmiZyk79+OBB+aX
	hu3I2umu13ZH7RpGYagUV1eymK/CTdsjdSwyStlq6HsTohBaHw==
X-Google-Smtp-Source: AGHT+IHM8MG8P5oDsrRR1SD5ra9w/oza47ODwNQSWweno6m7oOMslRi/zQtUJHcRWsnsj0KaNfst4w==
X-Received: by 2002:a0d:c945:0:b0:5f1:5263:a3bb with SMTP id l66-20020a0dc945000000b005f15263a3bbmr4210593ywd.95.1704824938165;
        Tue, 09 Jan 2024 10:28:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a7-20020a0cefc7000000b0068109717d02sm1090469qvt.54.2024.01.09.10.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 10:28:57 -0800 (PST)
Date: Tue, 9 Jan 2024 13:28:57 -0500
From: Taylor Blau <me@ttaylorr.com>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] allow disabling the automatic hint in
 advise_if_enabled()
Message-ID: <ZZ2QafUf/JxXYZU/@nand.local>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>

On Tue, Jan 09, 2024 at 04:25:32PM +0100, Rubén Justo wrote:
> Using advise_if_enabled() to display an advice will automatically
> include instructions on how to disable the advice, along with the main
> advice:
>
> 	hint: use --reapply-cherry-picks to include skipped commits
> 	hint: Disable this message with "git config advice.skippedCherryPicks false"
>
> This may become distracting or "noisy" over time, while the user may
> still want to receive the main advice.
>
> Let's have a switch to allow disabling this automatic advice.

I reviewed this and had a couple of notes, mostly focused on what to
call the new configuration option, and if we should be modifying the
test-tool helpers to accept arbitrary configuration via command-line
options.

I think that we could reasonably drop the first two patches by
imitating the existing style of t0018 more closely, but I don't feel all
that strongly about it.

So I would probably expect a reroll of this series, but if you disagree
with my comments, I would not be sad to see this series merged as-is.

Thanks,
Taylor
