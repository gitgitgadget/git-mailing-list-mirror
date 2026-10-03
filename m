Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD4F272803
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 04:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791003054; cv=pass; b=VkThxv5sBIJAIr5DLw/c1zSQn2rshIBaxBzuFlKNK8q9EjubGFXsJ7J/1/j4GJ+Muz+cSkmuAV+XgTkB+HNCBcOr7BEa97SevKvwHKLJ9wfdbvs0RBTQY9GoT8KL6y3nIIAjfWa5hgqOqLMlG6Ex1kAcuGVxZ4Ps8J4HPvfs1GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791003054; c=relaxed/simple;
	bh=c3pytUrs9JspRFNFSgbOQSoP60PRF2KABWD5O8RVBmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmZzuXtKJD/GIKSFpza0oa5Rvd8to0stddj/FL3q3VXJHxjsKk1vi3T0JtO7cg4QDxcEtFoBfc3dAYqu6HaX/37B1B26KGQFPudm7ckQ5J8Dvz1cYTtuHgi68L2wM1Ttqm3ENEID3adaUvAkuN0GgC7U2rjEMjccmuVo9Qep5Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrevP6e+; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrevP6e+"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so35467f8f.3
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 21:50:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791003051; cv=none;
        d=google.com; s=arc-20260327;
        b=B/OnyAsUb8jEpPQr7e+0KYMnvUK9OyRfd+rP51pbvIEppc0qFw/dCZqFfFX4AnKJLO
         EAqww8XjSdULKV2kKAhfDvtH2GMtR5EddGDfgo7+hnwsRJ58/59DaBzGujKS0GCh/CIT
         QuEcvlNS8LZYl+f6t3a7elfzn92y7kjHoLIJ/Ar1lrLTdd8xxL1MzfRRTCuvd+vq2vz8
         659/wDP11gwbzrBLQygTmCoTJZICOSx2ihJJEa8fsXRLAvYcoDiBUinvXB9sDiK2E8/v
         6Qmq9YOue2Ajuas/g1ocqiv7zV5PTaR68Ux/QgKZL3lEe+WrkxJB1MNWzNw67/ucpJgP
         UXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rNtA7cLctgWrjwqgc7N4+dWNbRYwwQlSY4Te8MHTnQE=;
        fh=w0Gy0U/6XCy3Ufv+zmlyPYUyPiGuXogm3Rr19TBxFRI=;
        b=Naw3EyBg0foqhebkhgo21x0Nw3L2GBaRdx7jTWNbJSrFtbsA84n61rf6O1UTPTjQYf
         q9W7il1vHTrrvlAzaNEgcf49QwX9ZdbqHM4rGWazkZzp2G71TSNydZ/m+dUq4aF0BI3L
         Kb59GpydqgtPSmV+B2CxfwDCzHDzwV9Kg51SiIqUooeHXinbSEWPy649dIGRyveOdeCr
         y0SJCEFwfrW7Wc3qV5uNxTmP7oh0wryu+kUlwFmcHfVflu9YnpddmaKvURi3PFZJ2buF
         YNW4trlyKvBj5dUhstMWtl3maoxq/MTGU9FmCFRN30B2hczdDtmuGDYLq2zLkQrLL77y
         YEjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791003051; x=1791607851; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rNtA7cLctgWrjwqgc7N4+dWNbRYwwQlSY4Te8MHTnQE=;
        b=IrevP6e+W0UoLKmGH16nvGsYC8d6mv/B6Vm25Zp2WS8TTwEqaU8SX2xtJg1NpMhVyj
         iqvCyybtyNg0Pfa61JfLM7AFh0lIyw4AhQTVsbyu6+KcLJjum93Y4iY1L3mOvLhLiFmQ
         dxJqn1/L3pZNXn8x0GvVUbS21EPAXjJGf7aAtVbyp9izL3O9zWXBqrmRWBzWjJ7xGJM3
         MS9zJgUQILZr4T5f67E4Hul4m5w8GpGeph/OyD0iUhe4EED0LiypDwFG4zzFIh9EkV6J
         vsNlTrFz/kk4NDyD1PlE7mJwoSzqPZ6CNGun7Bnoe2+H/itU0ZO8wO9KZruYTM9Y7Buz
         dg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791003051; x=1791607851;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rNtA7cLctgWrjwqgc7N4+dWNbRYwwQlSY4Te8MHTnQE=;
        b=Hil91czCgtaEFQ7oHnmLuVDxBqFdlUKWuzNsx21XEwtj2XwC/BZ4pTpRNVoaRS2tqU
         TqFzfJuY32qceXRu+4q4m20WG0Jcbjjo7EYugoDWqag4W8ba/46nE0s+IeaFa0vNHwrY
         4CXQdwMW+r3cboL4GWbByjFO5zAdNfvqiRnVasIVqOObVbGeSQRpOuhv+6a+0S+O/XVe
         iuLpUONEUPEkncdjfmsh3RUV0bZ3L8CWZTGAv+71wIx3BALlZShMMlj23f2Bys/f92Wn
         BoXCilgiaKh98+hUt3hIyjl2TRRonHjgLumNRAr6cgbSTJdl1pdvPLR+f5KTXvtiMFXc
         FIag==
X-Forwarded-Encrypted: i=1; AKwUvBzpWR2wRlbzvgWPx05lcEl/BXE/8jYw+7dl5+DUb/jgL0ctGG8KeMphCuy4LplGUADo3zY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3VlqmSKyDT3tK396iKbuk3IZJ7pLYth3j8eFzCm04FTLa19f7
	rZaQfOI+ZqGk/RVn5icHdfmQlUxuWHI+PI2lS1zIGL5C0jmhtb1KcolvFN1LGvQHCg1nz9Tvc++
	Z6IOK7BHFybgdFc8D7IfLTiWaRHqai+k=
X-Gm-Gg: AYBFou1+fspQKnGMMxJb1Kp5qhwycqWIcXwbNiWp0brLvzl1mlYpBhH71Zw3sdeCVXR
	lYHZX1/n2f5WRiewjRtWp7qIOaRQ/Gbe0T9LFmk8/QLGAyqDcjudNcAB64EU/wPwmdhwZqAm4QN
	ySJpEcSdKgQYn/m8b+0r7NIYwctB9KdMMuSeTpYYdpRT5wuXmA9aqp8vVoNO6IzOkgqCGz8Egd0
	AKP2t/cYAYKmIGmaDtWfibN0xkVtGLKeTot4WRgf+2UaBBRqMBK4TaF0bDYrDd7xD1D++PGAaLR
	bTihzP+18Zgm1a4EX9dTk21CBzUrSJsyE0Rozi8F7HjTSOwDtmLgJdKuMMYHAwc8GET9Jeq18Y7
	oHjJC1J2AzS+Mrg==
X-Received: by 2002:a05:6000:4021:b0:48c:41c2:46d6 with SMTP id
 ffacd0b85a97d-48c41c2474bmr6034458f8f.35.1791003051107; Fri, 02 Oct 2026
 21:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922040047.2567-1-colinlewishinton@gmail.com>
 <20260925192658.1166-1-colinlewishinton@gmail.com> <xmqqo6dlt906.fsf@gitster.g>
 <CAHeTm9Pb-fb-ZS_m4UVNZxfp+ENQwBUGDvP1E24dEDTZy5RFFw@mail.gmail.com>
 <DLSD3JY380Q4.2VPO95D7M213G@lfurio.us> <xmqqpkxua87a.fsf@gitster.g>
In-Reply-To: <xmqqpkxua87a.fsf@gitster.g>
From: Colin Hinton <colinlewishinton@gmail.com>
Date: Fri, 2 Oct 2026 21:50:41 -0700
X-Gm-Features: AclHuK9YENo-p8srQY_wCW7YiN4dx1h2pPbvE77nxaG2fbTc5GIpEUg8FQYcvCM
Message-ID: <CAHeTm9MBx_ndL1XkdyjtjFaGvoF69AHwP6DLYsirpBVsiNRfAA@mail.gmail.com>
Subject: Re: [PATCH v2] fetch.c: defer fetch.followRemoteHEAD validation
To: Junio C Hamano <gitster@pobox.com>
Cc: Matt Hunter <m@lfurio.us>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Perhaps at a minimum, this patch should leave the comment intact (or
> > reworded) if not yet addressing remote.c.  v3 otherwise is looking good
> > to me, and functionality seems to work.
>
> To end users, the annoyance factor due to an irrelevant incorrect
> setting in fetch.followRemoteHEAD and remote.*.followRemoteHEAD
> variables killing their "git fetch" are the same.  Correcting one
> may be better than correcting none, but until both gets corrected,
> we cannot claim we helped users.
>
All good points, I will add the NEEDSWORK back into this patch
as this is a half measure to the entire problem; however, rather than
leaving the NEEDSWORK in fetch.c, I will move it to remote.c near the
remaining defect in handle_config(), and maybe add a short comment in
fetch.c for context of this fix. Unless there are any concerns, V4
should be released soon.

-Colin Hinton
