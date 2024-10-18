Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1442913541B
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729285788; cv=none; b=CO9DFoGuwWfZl4cVuZiIt1RXTdFqqeypd/GgOdwtAHneWXdkQBX+/tsFA7yBVtWwwf5VE74RD9sprXsKADHfi+ajxwqE81TN/v8ViaPLMRlduVRw20CEiMKcp/Va/lJ+UppmxO3eL2uJE1Z1+QKqSXrgw95QNVBl543DcNP1Jug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729285788; c=relaxed/simple;
	bh=3NTwTsxlJWYkChdCo6gR2EH1DIRabfIf04kXiBfpzmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1zYRsAq3xBLZ77IH1Ji3Yb5ZwIVCTnslsBk3i3KiknsWCS4+dC4V21XciXBkq8lCD31tHiQS77g4IRDFh+/EWbcyDJPtNfy+CMwo6Ol1w/aXZI9r0yqfo+TKHPNQV54TH6Rb+qwYTOCRgt6uxHYPSxMzl+1rV3UIy0wqx/EV5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=XO39IGwC; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XO39IGwC"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e2918664a3fso2281035276.0
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 14:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729285786; x=1729890586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VjSe0p8leVGBNGTP1YeDWWseh69NQM1iZ9Htdm7xUFE=;
        b=XO39IGwCcddDcwfk8FDxVX3Li/T3B7AGgEEp6Z7hy2pkns/8Yd9XoxAz6jC0UwIreW
         Xh/yyF0C92cXTZHBF/CXHt9+w4ybCg6MR7l51SXfTz31vzO7vFENytWVSA9oLmKDCMEC
         7aZDWrMZ5opWEhHb3LLCNz7qy/C5jY72XRQqgbBtLcuZAnHlo3/aTqH7jD6DTcOvercg
         nqWzvvp70MCxvajTStT57SvydpxtCNxtl0rZbcwTD/bd9csHuBoEKbvt0DvVpKYSCkq0
         AtHo8FDXeaR5knJ1cblteahCWPPEqpIUoE+QoV6o2qxPg5CTOBis0m8q0gNDLEMP3IMt
         s0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729285786; x=1729890586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjSe0p8leVGBNGTP1YeDWWseh69NQM1iZ9Htdm7xUFE=;
        b=AbyR2NTpTlmhTrSCSN4HbHyQqdCWP9mAbSkv9u5QPITJ+WouYdSRCv/6QmouhGLHW0
         v3IaSXSgqg/RXwZtLQTloEa99WXrP5yGI9Zb29Ad0isvBwjVtwr6Z/7cGDbCWhpJmwBH
         z5O2R4E8i1zL34Sb4aJ6jbRKQ6PDiu57c+0051WeWib1Zpyh+H87qonj3+y+ojSmRzlp
         es3oipOpkmPVUccTsJuLoSnMeNWuvwtTYfiKcKs3AMxOEva0GQVYP9/FVVJE0GnDikdX
         Kh2DENdYTno1SrzYI5t1mb+xHwLtAcO54EZCiF+yvT9wJT0vWIraErxZv80pwTeCUJ8P
         5yHg==
X-Gm-Message-State: AOJu0Yy7vtVx3UXCnX+qmUo/l4+wWueVYjSsm+ofqiVNlC8N6ZRp6RiZ
	PRFFw9kZsgjPCCK494I23vYjk2Nt00N+/E3LXHavatwkIcTFO1P2WGcsuvtDX2w=
X-Google-Smtp-Source: AGHT+IGTpv7fVMpnI7AyMTWb/Lyuefp3p8JNr4uivOPZNHkULp94a8tajdv1rfnnEdTSVoXTlMcc0Q==
X-Received: by 2002:a05:690c:3708:b0:6dd:b8ff:c29c with SMTP id 00721157ae682-6e5a3eb5f55mr69841337b3.17.1729285786005;
        Fri, 18 Oct 2024 14:09:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5bffc980asm4655187b3.21.2024.10.18.14.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:09:45 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:09:43 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v3 00/15] Modernize the build system
Message-ID: <ZxLOlx69KQp9jXDF@nand.local>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729254070.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1729254070.git.ps@pks.im>

On Fri, Oct 18, 2024 at 02:23:47PM +0200, Patrick Steinhardt wrote:
> This series is based on 15030f9556 (The second batch, 2024-10-15) and
> has the following dependencies:
>
>   - ps/cmake-clar at c6d3e52c91 (cmake: set up proper
>     dependencies for generated clar headers, 2024-10-15).
>
>   - ps/upgrade-clar at f3501edb0e (Makefile: adjust sed command for
>     generating "clar-decls.h", 2024-10-14).
>
>   - ps/platform-compat-fixes at 80ebd91b83 (http: fix build error on
>     FreeBSD, 2024-10-16).
>
> These deps are mostly just there to make tests pass on all platforms,
> but I wouldn't want folks to go test things and discover breakage that
> is not caused by Meson itself :) You can also find this version of the
> patch series at [1], branch "pks-meson-v3". @Taylor, I'm fine with
> keeping this out of "seen" if you prefer to wait for those dependencies
> to land first.

Of the three, only the last one is marked as "Will merge to 'next'?" in
the next integration round[^1]. All three are in 'seen', so this should
apply cleanly on top of those.

What is the state of those first two topics? Are they ready to go, or
are we expecting a new round for any of them?

Thanks,
Taylor

[^1]: I think I will do another full integration cycle on Tuesday of
  next week, but I am not entirely sure yet.
