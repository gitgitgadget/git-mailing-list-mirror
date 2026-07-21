Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920D720E334
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623524; cv=pass; b=sb4F6og/WXrxXJ7CDLgg2qmiFi1zSYDY5AqW2DSmfmCDqmyFqHiykoyg+kd2fVyq0+4ebng0t7JB6sCzJZ9+LQj5dyvO+ioRmaREvleDyD9rotLThs4qMbuIkzrqm6j3XVTp53TSAe0bCnIj9XbPUv4uZ631eMsf9hmGA9b8Huc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623524; c=relaxed/simple;
	bh=lexIXTIaBZUIcdRdcaZNaY6rx8cc9hDiDfjFtwEb0SY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qm9oGzE9cPRz4E7jhrkpcABmmyZ3BlGlm6O3VV0/n+3vn1/U0lz4qvdIjkWmfGu1X8rt/RbffBvP37Vm+nu+rb/+lt1bDvsqPFCXYncBvUSKzWyZCrnDKpOV3WEPFLCOLQJ5iwvBFc9rYjtoRZcqTisdIEJNlG2iFy2tms2I13Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=D5BGRjct; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="D5BGRjct"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81062fdeaf5so42588927b3.0
        for <git@vger.kernel.org>; Tue, 21 Jul 2026 01:45:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784623521; cv=none;
        d=google.com; s=arc-20260327;
        b=ZwoCIODoBx6L8GaRgn434jKikNXlULu0Y6W+TFjYraIOnCEwj+ZxjOHc/TQUccObSj
         i1eFcXOkFHL9fSuY0Y5yfvB/Qb6SZTmSauJPhBC6uLsb7yALekDfyQCYP1f2ALiRdc29
         /pDrsDyjc9NcdIYZ26NBAW8dNYxnTHvsOVwBsKntGdDmT662WCktkvS+5wquGS4hkQ+v
         u9UuCorcjh0UPBiBxotbKd2+zfuGcK01EWE3rI/dZe5sizr/XPu7jtAaPdxadUO7iZzp
         iplP2zu16dpQEmCBAwJO5jP7Q579q2wANxvIOapVaYFaniDSiXLtFtSqOsaQLxLKYxHJ
         DC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Kn4YzJtggQrPOFfNqXLEBm84WL/5pZg9+Oi7JVkod9s=;
        fh=a0n/8SuZhvl/MOIU9DAD5MjDPhCdtJ5QiWkmbfxF9o4=;
        b=q9tQ2O4Cf6feNd23pnRJ0zG1Ifs4Ffj/qwks35wFEnuTTNbFCUQ6DrrFUqJJu40Ae3
         CtZpFTRLwx4jRhyeynboagr6g1GsrJqT/7EYDfCga2E33tnFPQNfB5ge3buDvXENi27K
         LX4t/Amvd6maWh62iWe0Ecql9+A0ZRV1eq9hCMpv1oHG/df25ZtHHpMOyqlqwnSE+Z+J
         Ac/ply/zQslb+YpMRUSsc53z13pq5nnhhYSaS0zGHELSSFBs2MB7nM1FR2p75AlAij8A
         QaRQ7FRK/xKYMBJV5yz8OIAaqTjL4hpOmKAxRQUgeEaIifuPRffDVhISEj1bEwLvw8e4
         1Jow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1784623521; x=1785228321; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kn4YzJtggQrPOFfNqXLEBm84WL/5pZg9+Oi7JVkod9s=;
        b=D5BGRjct104VxORg9dJdb3JGSKezjAauVFAXAtdrk/1yOE94aDDM/aRP+/ARuNciV3
         gUwLXkzg0zGZXu3mTCSxGO7AaS18vrjrsNEVrPawJvaCLfF5jPrNImzN+gE3m8+MhUPJ
         Gc4wm32RCbsQ8iU2brSRFrB++EyRImUZHZ38U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784623521; x=1785228321;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Kn4YzJtggQrPOFfNqXLEBm84WL/5pZg9+Oi7JVkod9s=;
        b=sLE4u2UW+hU7kFG+09A+MSRW65C6/1Ya1f1OFWO3SRR4YcxUMoeJGdRa6T1S6ijgym
         h5p5DOkQVURb83WSGhOyCrlMK2CgEeFhf4ieCAkFcneOa+08fg/H6veYD8KLtQ+rONZD
         WFzAZuCi2C/E7M26zHqDCSogO2l1gvw+KN2J3Q+R+lg5P1WjWI8lK7avl0M30T1vruOK
         5JDs398W8hUjZ20jWO6eSJRUhwiBsXnGF274EG19pdKrQat4vZD6D2t2cv4YcZbNnYlK
         v1NgiZmtZayhciwDLG6rR3fXDvk0rJPjZGRw/lbZDICPqSOWYUrpvAn1Q26b6n9RHXfs
         E/6Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp6EUA3VHnruRb/FJrk0x/VA7kHXSF95PCEsvQ/ISqu+iSBi0uOXBAY+UnDbrV/LRGSj1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ANY3yFB6InJGxdoBeylczNF409ftUk5JDlTD9gcQ+99Cgy5f
	4DBAeFhlTAfF49I3pylpdlakvK22fsDd/6sCrMTPD6M4o1qr+iBw3LJ8ek/YE7d98Rp1lCA6X81
	/JmJ3rMBjxkGZepEWP0fZ1XZI5DH7eU5y6jS/FvfDZg==
X-Gm-Gg: AR+sD10nr9FlqT+hP5vX7BUtrGMHGykFP9Q3NazvCsBc1Vz9RgcJEbMogrgjB5IKahh
	w9Z5qOWtSmdEwqO9vAHBPIgA7EOigOlPjcFRf6Zryi+9hOg+B7M0bE496hpAtFnsZQWa7xlTiwk
	0Aq9VoMqWToCJyj5ReW/tZD2NlTnCVk0hjztG7hOlCvAQOEyuF2dLlZCZ43uogqRFbJKO2BqF+6
	N+e9OBzsjsWnDmYltnEUNwy3UpH/LqsVnbeheKvVMR0VvF1Z4dalPmokmP3yuQ=
X-Received: by 2002:a05:690c:6e83:b0:7f0:38f7:6ca6 with SMTP id
 00721157ae682-81ee27da775mr79390737b3.5.1784623521395; Tue, 21 Jul 2026
 01:45:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
 <pull.2149.v6.git.1783776466.gitgitgadget@gmail.com> <xmqqv7al9rbj.fsf@gitster.g>
 <CAL71e4O5=ZJoPD4dnPmh8mjsTKtugx05-8d83VeQdBNOjp=bFw@mail.gmail.com> <xmqqse5en8wz.fsf@gitster.g>
In-Reply-To: <xmqqse5en8wz.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 21 Jul 2026 10:45:09 +0200
X-Gm-Features: AUfX_mwHw_mhhGplYJ8ZkcxlhAcbUGTNMzUYC8o-xiHddHS1OvsQcbf_Xhx3APs
Message-ID: <CAL71e4PwoJ4fxKBNuf3HB3Po92WRaV4yDBUDcuEYiggiDD=+Ew@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] commit-reach: terminate merge-base walk when one
 side is exhausted
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Jul 2026 at 20:14, Junio C Hamano <gitster@pobox.com> wrote:
>
> In any case, we really need to get somebody take a look at these
> patches to move them forward.  Any takers?
>
> Thanks.

Yes it seems we lost some momentum here. I am not personally
stressed about it but it is of course better to reduce the number
of topics in-flight.

If the patch series is getting too large perhaps I need to shrink
it down in size or complexity, but I am not sure if that is wanted
and if so, in which aspect it should be simplified.

Some alternatives:
- Skip the final commit that cleans up the date ordering fallback.
  Currently just a nice win, but it could be submitted separately.
- Skip the extra test helper to get nicer assertion failure
  messages. It was helpful during development but is not strictly
  required.
- Squash together some of the test commits to reduce the number of
  patches.
- Squash together some of the logic changes to jump more directly
  to the desired end state -- though I am not sure if this would
  actually make the review process simpler.

But perhaps this is simply the time of year where people take
more vacation and are thus spending less time on code reviews.

Thanks,
Kristofer
