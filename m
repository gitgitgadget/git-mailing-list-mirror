Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BDA1E8346
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809149; cv=none; b=m8RKPLBfCdS6GixVb/vbwtQqZj0mRqxb0ihbKWZA6yr2qOhWkf7QgsdvAw4997BmRZphpX/sosQZni442MUAuOnjBEfDREVh0uM0fNmeAS6Y8oXi6+P+r5WNSYoHCtBX5wvX7Ma8wzMlYKJk13k7hVXEf2aaqCqSBjgJ6XkRhdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809149; c=relaxed/simple;
	bh=I/kYnQwWMWCtqfnqtm+LWWLkr/A9ukiaPTKNxPL9SaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTBejqijyUeCmLwwNOfiWReB9tKOoQo2FLsX13+eq0ePehYUW3OLmWbN4uTX44ynbdJ05B6Ur7iWSDmxO7QDwZrlrefiBnGCeHc8WLzFOz8F1znGsVbqrQEzPO6gyEH6PY92Jfm1j9MymxoVSyDaA+g6NMotDpUlkGx2gXKz5Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=N3euP5wX; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="N3euP5wX"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6fead015247so1582627b3.2
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741809147; x=1742413947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4jpCNFaSewM92iJD4aRFc3BX/KTiXFtVHeUHH6hl4jU=;
        b=N3euP5wXsubTauL0/4+Mm22DG7VH9bpIVF/10BcMLSy6MAs3jjbHhkJ6BeAGZi0LCj
         8OmO+yiq4QWWHmrY04wDIDolwW7+eE7FVqhEaChcQshHfkB9aQuk81oCnXEyjXDwiG/P
         26XIYbPdwn1HfyNRsrMhZvdOM0fKbzrtfC3o+w2YPUmLAFf4cE9g4ShYRUUXOKd0IC9b
         eGHzZg6BuMqRIUo/PEAhzgRpNC9Lk5Wb2fQN0ijdT9/vjbmBf6EohMV7524EzmOBxJ5p
         XQuNuZRmE6fWiP1YKcn/qM9Exfk36bveavMUzcsf7ewgWdUhoHuGAIkOnryR+0fH63d6
         Rj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741809147; x=1742413947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jpCNFaSewM92iJD4aRFc3BX/KTiXFtVHeUHH6hl4jU=;
        b=eroF3AvTvY76qbcLhuX3GuT4MXf3FOfvaXJxLcBBMBRU/5WJFhtQwadlhJQspJrSc9
         G5A7RurOnLskfRPSWiDHQHNCcQCtNMMx0Rkb5nOfpK5msO/CIPzqtokLMG6zo+PB8KKy
         yts5LshWoxovM6KNc7SOAzHt+E35Iw/RHNppPaqGoFDJVHJL2lFrMXDCpH05nM9ua3tQ
         RFDc7VkcBuebBGo27AemOss4xIuQtKjQsg1A/tMGieGi71uVxq8YevUycmNc7VnCp94r
         e9zLFT8eYqik9KPf5Voq6IPQFr0U60EwCuEfI7bhyRz4lHCASTaPfTEysPANpB6opXYg
         b1UQ==
X-Gm-Message-State: AOJu0YwkaPPsjqxfANjbinrjhuqIlK54bFNu40RA7S7FbRQAG3jQRkdM
	blRxC6z3cIqtMfUNb0bE4B4Cie/JBcp5qONYSVydonty6YXsc8xc9XkN29RtfhAF35voWC5M6R2
	Jvsg=
X-Gm-Gg: ASbGncvd1WFHjKpFDsVnldpdQ6pCmJmcIe5kAhWjBj4p/6KQ8Eqg1Y2LMdQjVF8zxC9
	1NG1FULpbBLwb1YHdfavvZn73Y1Di1+lE6tpnWnA1CeB030IBynf9ihISFCldjQbgWwW0nmaHlb
	IVevBLZmhLtfd1oPcME49MUasDfuxDB6CdoWqz1tQLRQeJB++7fZJH49uh1YIxVfMLVAeNjYiR0
	YXZ5phMI94a9vQc716JaKG+X76UpV5hmRaN18+tHK6aPYCuuTF3b356PVHY9lMXm5VY6BDCWKzB
	3NR+Robw0rah3//m34Zeghk0JVuTPBWj0rfHja3wXHD4+ZXAkbv1SFB61LRCx82LZEaTIOx6JfA
	M/bFWjghQnMnpDe2sycSKPEI5aL4=
X-Google-Smtp-Source: AGHT+IEVe7p5uSRB66ENZoQ6uHkrBoES7vSftDkiA+Duc0S0FQxv8EqVYjau3jZzkt8ayjAyE2UfwQ==
X-Received: by 2002:a05:690c:688b:b0:6f9:97af:b594 with SMTP id 00721157ae682-6febf2dbdc4mr324296857b3.10.1741809146695;
        Wed, 12 Mar 2025 12:52:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2a68bdbsm32913597b3.46.2025.03.12.12.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:52:26 -0700 (PDT)
Date: Wed, 12 Mar 2025 15:52:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 0/6] pack-objects: freshen objects with multi-cruft
 packs
Message-ID: <Z9Hl+UpnEq07qFeW@nand.local>
References: <cover.1740680964.git.me@ttaylorr.com>
 <cover.1741648467.git.me@ttaylorr.com>
 <xmqqr0332un3.fsf@gitster.g>
 <Z9GpQqm4YBvWF7Ff@nand.local>
 <xmqqfrjixfwe.fsf@gitster.g>
 <Z9Ha2mFXpojI+aIR@nand.local>
 <xmqqa59qxc9b.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa59qxc9b.fsf@gitster.g>

On Wed, Mar 12, 2025 at 12:46:56PM -0700, Junio C Hamano wrote:
> Allowing the resulting pack to deliberately exceed 200MB ceiling is
> one possible way (I still do not think it is the best way among
> possible ways) to mark the pack "frozen-do not further touch".
>
> Now, if the essense of the problem is when to mark a pack that we
> stopped appending to due to max-size limit as "frozen and do not
> touch" to avoid this problem, how such a marking is done, and who
> uses it to avoid repeated work that is known (to us) to be futile,
> there should be better ways to do such a marking.  We have .keep
> mechanism which is ugly but proven to work and we know how to deal
> with, for example.

Yeah... I think a .keep-like mechanism would be sufficient here to mark
packs which are close to the --max-cruft-size as frozen if we truly
wanted to avoid this problem.

But if we have, say, packs that are 198MB, 1MB, 2MB, and 3MB in size,
that we're going to accumulate in order of increasing size, so we would
almost never repack the 198MB pack.

The .keep mechanism by itself wouldn't quite do the trick, though,
because we'd have to distinguish between "marked as .kept by the user
and so we absolutely must not delete it" and "marked as frozen by us,
but we could delete it if we needed to (e.g., when pruning)".

So that would maybe suggest introducing a .frozen mechanism, but that is
bolting further ugliness onto the .keep mechanism, which I think is the
wrong direction to be going in.

> I wonder if our pack header or trailer is extensible enough so that
> we can record "this pack was closed due to max-size limit of 200MB
> and appending even one more object in the queue would have busted
> the limit".
>
> No matter how such a marking is done, later repack that sees a pack
> marked as such, when it is limited to 200MB, should be able to tell
> that and act a bit more intelligently than what it currently does.

Perhaps in the longer term, but I think for the reasons above that the
existing behavior (plus the new patch from v3, which we should still
queue) is sufficient.

Thanks,
Taylor
