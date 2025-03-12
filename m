Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856131DE3AF
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809926; cv=none; b=XEzeQTGgUlb6gogo7Qy8e2Bb6Ok4eH5QDS7IpwPcdHV/ZgSSOoiDceLKIHQrSThv+Z8IaeQlCRjByYy65iplHWATzIChB6MoVkuEsJojfHbRw1ElQGuaGfAhs2RVCfaIf2M2tWuyBzzKId+8nd86cY17Ad4T9xD/bX41Shysb8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809926; c=relaxed/simple;
	bh=eI0sOeqHL3ORDurM8wkADLpu5ZKg6UIuJ0jkf7grvjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtSWd0K0hUTgpv+NhnxlaAqCFOitAlQHuDV0sa7+Qs922DrhyvP+XcyY6MVGi93UH7cHfm11Ff6IGYFtdWj1VWdgMHy/0D7pL0Ld6OvvkmjFn2/nse5pNZdBMVcEpPhVreoMaX1yOCLZ3pJLPOXLkkdhcSlG5RS+JX60NUXv0aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=iEhH/L/s; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="iEhH/L/s"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ff0c9d1761so2147437b3.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 13:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741809923; x=1742414723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eI0sOeqHL3ORDurM8wkADLpu5ZKg6UIuJ0jkf7grvjY=;
        b=iEhH/L/sml521Oxz5OofG/aEOxAPLDXJCGJdS8C64bABI4/TTwqrlaiFgrueMA0xnK
         dIaYmJeDu6La/EKe0MJewck+7oC4cl+C3na6Yuz7XTG2HEAcp1jcNIFkgjOriBfTggGr
         YCTD9vb3ODWpdGxE8NZ60sj4QidJw9M2uy5WwfaS6gbkDMEAH4X7AHQ8g5K24k2wyJyp
         QJym7SxjjTUP8qWRFeyEWEOgrJ+sO0sPg/0fMhIpkqKDVYyAueLqk4x8/s1ncklTw2hx
         8ydR6Xbz5xOnFa8vaRuiAxdRKxRyR7ZJrUV/QcE31Fuyoj9aTuOQlL4ed7+FMD7HaqLu
         5VQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741809923; x=1742414723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eI0sOeqHL3ORDurM8wkADLpu5ZKg6UIuJ0jkf7grvjY=;
        b=NSqNRAEZQDc2HsWgACHCH09KETrih2o2FxCbGfov42ua2COwT6vWXwaSG9kC25t8Eu
         A0Ytwv9AvCrWzhYAIGFOznreSR/Br9yXfNZCVpgrUpjbD8ec8V+9HcABc9UojfqyBn4y
         Iq/sFwfSjWoKlwPL6Z32cTH1jtIH6zVmOkDIET3rkprgWBg/xY3cEP42oKmN5d3FgRgc
         6tafp9UIAIWThLrKRON635OAl8n7fmeNlm2N3NB+XnWSHQHbD4kbQb3lKDRgnbZfGRbU
         5jtg74TfxAQVNrvxvc5JabDu6nOAh+P+4Uy40nDbqKt7OfjkdAFS0hvyxfS06fgEcO6s
         r9dg==
X-Forwarded-Encrypted: i=1; AJvYcCXZsEiRLc2xCh9cMWbXUfWffCNymlKY6ketcQ/w0fjxH3lgqv9tcV+6ZMeZO6dhc0NBDTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YznGfHru26leuxYDVd2YovRPUVED8x39BMQ+DVv2dNmRMORjaYj
	Qq4JvC736vE+g12ofs+WiorRfGfjed8e5d1e+BXny7Muu1NQ6bAqrxWSrhhjjZV2o2h64zCG3TY
	Bpqg=
X-Gm-Gg: ASbGnctVVyCPCe/L4MiQDVRg+wqkwox4+YMOT1wkcUl1jWzGyxduNothYvUIUPaU6fT
	mIrvEtlXN/fAjsFN0FW4y9qpvL/dCkMbg1bWnnpH//jZ23Fj/zWWcoTrD5HfRrn4Y0oeJR2t/UX
	ziKrleUiBgJvJz1+a+8nz9HYEasr+sCcav65mixFJg11iEbLol2KmEZlUh1igdWaEmPSZf0b0LJ
	ldKyE6kuRTUrVB80YK3o8ABCoeGuvTpS+8FCfMZuu4oMfNSrv/VaZfCW5OQvZpB3jjkDfLCcTAR
	DyxRkh7NVVy7dzVA4iFgnI29upD9SXRkQNFUywCTQCXJuEDZPCkGuDaOOfgH+Yzujl2UYPov5CV
	zyRuw3Y1NCk6K5DAj
X-Google-Smtp-Source: AGHT+IE+DDLY9RNJUG5MynT/fz6AA3sDbM3gECiTOqbAVLu8JvM+JgB0KVEnBzWR6Aaa9aUT8TTZjA==
X-Received: by 2002:a05:690c:4d45:b0:6fd:2f47:f4f9 with SMTP id 00721157ae682-6febf2cc21dmr287228587b3.9.1741809923379;
        Wed, 12 Mar 2025 13:05:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2a1c108sm33066887b3.2.2025.03.12.13.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:05:23 -0700 (PDT)
Date: Wed, 12 Mar 2025 16:05:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/3] Small new merge-ort features, prepping for deletion
 of merge-recursive.[ch]
Message-ID: <Z9HpAgGq0FSOheLj@nand.local>
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
 <Z9FAh5p2h55_4mki@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9FAh5p2h55_4mki@pks.im>

On Wed, Mar 12, 2025 at 09:06:31AM +0100, Patrick Steinhardt wrote:
> On Fri, Mar 07, 2025 at 03:48:39PM +0000, Elijah Newren via GitGitGadget wrote:
> > I've got 19 patches covering the work needed to prep for and allow us to
> > delete merge-recursive.[ch], and remap 'recursive' to 'ort', including some
> > clean-up along the way. I've tried to divide it up into five smaller patch
> > series.
> >
> > These 3 patches are the first of those series, and each of these 3 patches
> > provide a small new feature that together will be used to allow us to
> > convert some callers over from recursive to ort. If the third patch,
> > introducing merge_ort_generic(), doesn't make sense to submit without one of
> > its new callers, I can extend this series to 6 patches and include the
> > conversion of git-am.sh.
>
> I think extending it to 6 patches would make sense as it's somewhat
> unfortunate that this version introduces the function, but has no
> callers at all.

Eh. I have gone back and forth about that over the years. I think in
cases where the either caller(s) or implementation is sufficiently
complicated, it's OK to introduce a (non-static) function without any
callers.

I don't feel strongly about it, so I think the multi-series structure is
fine as it is (especially since we know that more are coming in the
future). But I'm also not opposed to seeing this series extended out to
include the three additional patches.

Thanks,
Taylor
