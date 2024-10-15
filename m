Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9581F80A0
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019228; cv=none; b=s038keIHl/jS0AYrdJOswiX4532JVCBhlKf2v7t3eWgwvCmUaAh1yHZSTpS/3rB7xrpe3S9sA30Kun5Nb71kVpy5XxD0n6Qtstp5ItUESWue/WKKq8kuc5Cc0BWJ+XoUvHAvbG85rVIv1Ps40/RDnTm6Nm3Fy36142hl6axo+UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019228; c=relaxed/simple;
	bh=Ta1iIl86u/UNkVcqbym9BALb/a9sjwXl2kfSVtGqN/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nqzhi5QOc47NNEBgRqsTczqctnc85oJkIN/a6joEh2NeAFpBTGzEoFKEDgYgtsIFQacqh69KT5dKbQPXEHi1mdtE8IdIx8A7ujPv4tiKGJT4HG7+Pet7pQrbqOItnWGQkWftppH8AupPtptgZoMmDPPlCO8mbNf2JbV8XT8i0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=m7aXj3yl; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="m7aXj3yl"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e2e3e4f65dso53335447b3.3
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 12:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729019226; x=1729624026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ta1iIl86u/UNkVcqbym9BALb/a9sjwXl2kfSVtGqN/s=;
        b=m7aXj3yl3gRmG90sBzYNwpacFyvE49BrhsDaCDZf/spTA2arV5x1J5hk5H7XffbDPV
         MAR44UJUVEU8lIxRwbiXLYIjkNB09EZsYXUCq/uR3kTefSkDZymKahwQZi6o5KF/VoXT
         9vIVoKrmcMGMReUGMgrX961w3hZ357vFzrfIksCHPxXwIVoGYQ9WNePlM13dvCT/p2H5
         oloPOgMeey3fb8NfD6SVvx8kFtg50tRwzo66B7WkACnEKjXeuuflbbsjFTxfx6GFziRZ
         bS7WozoPJfnVTHuO5Yb3QQsCcvrmO7M04WHjDQ4auvRWd/vV3il7Px4z17ZctprGD6iq
         o5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729019226; x=1729624026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ta1iIl86u/UNkVcqbym9BALb/a9sjwXl2kfSVtGqN/s=;
        b=ZJTgTJv5gfuwEc731AvwrYQICLl3O1F33aO6AKfiZ4Cnt7h+dY/kpOqmGo0N3BzBho
         tshACXX6I3mi5neIyvBOzou7vrvigUk4UQy7O7K9cWSkTLT6cQjc3txCu6YFTOuvf1C2
         t6JchoGAu8oSWcOGVpmfx7ZrteHBMkeMnYHupnfWzPTxGbjR0Cuh73WRNON+BNLn6oL0
         1TMzNsLn+V/Q1q8wFYS1bInIvYVgx6Jako/z4m1Sw60qQIM0Krk0SbY7X/a+MDD4bM4V
         aPiiQJfxx21RKfIH2fw5FYvW8396/5g6o6r5o2ZH5/ROc7qc4CFStPL1m95XjZbROnDn
         qbGQ==
X-Gm-Message-State: AOJu0Yw2SmMel78xIc1cv77gEHUobtEtpKlM3x1GA6NNVSRp+8d71P+a
	5VoDnghy/GdxIYxHJm0lIWuVSOVSYihQNnbs4x9WJ1Zc4PS5KiTKcJAn47aRtSU=
X-Google-Smtp-Source: AGHT+IEufOuvIzyDD2zmtrZVZesNRwyl1heH7cMorXQDyyFK/Tun+SkDlbntoKpWiQKBvr2lDn0lFg==
X-Received: by 2002:a05:690c:9a83:b0:6ac:ce34:9726 with SMTP id 00721157ae682-6e3d40afbaemr19010607b3.18.1729019225612;
        Tue, 15 Oct 2024 12:07:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5d26551sm3969957b3.125.2024.10.15.12.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:07:05 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:07:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: "Gibbons, Jason" <Jason.Gibbons@finastra.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: fetch-pack Unexpected disconnect issues in 2.47
Message-ID: <Zw69WPUT/9P327nx@nand.local>
References: <AS1PR08MB7514FB0AE229D34BFE66C4EF8A452@AS1PR08MB7514.eurprd08.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AS1PR08MB7514FB0AE229D34BFE66C4EF8A452@AS1PR08MB7514.eurprd08.prod.outlook.com>

On Tue, Oct 15, 2024 at 05:16:16AM +0000, Gibbons, Jason wrote:
> Hello
>
> Not sure if this has already been reported, but we have noticed that
> for a large github repository with lfs enabled, we are seeing the
> following errors on fetch:
>
> Connection to github.com closed by remote host.
>
> 03:42:26 fetch-pack: unexpected disconnect while reading sideband packet
> 03:42:26 fatal: early EOF
> 03:42:26 fatal: fetch-pack: invalid index-pack output
>
> When we revert the git client from 2.47 to 2.46 on the fetching host,
> the problem vanishes, and this is systematic both across CI build/test
> infrastructure and development PCs.
>
> For the moment we are just rolling back to 2.46 across our infra, but
> this can be only a short-term solution of course.

If you are using Git for Windows, I believe that there is a known issue
[1] which was patched in the MSYS2 runtime used by GfW [2].

It does not appear to be released as part of a tagged version of Git for
Windows yet, although from reading [1] it appears to be planned soon. In
the meantime, you should be able to work around the issue by using a
snapshot of Git for Windows.

Thanks,
Taylor

[1]: https://github.com/git-for-windows/git/issues/5199
[2]: https://github.com/git-for-windows/msys2-runtime/pull/75
