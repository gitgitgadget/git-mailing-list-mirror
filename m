Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7170170836
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782589209; cv=pass; b=CXy5y65QKyTsJVPFY4cnFGZLW0sruGRP1bzsFJdjtTFlsSSSs0BCt+1WyVbAKjNL/B0sgw6M7IW+snlfb8iB1MMoRQALzPMXxaEcP7u6TWusKUQ+zmcNaWhCQubcitqb2+JUJ53Lu0/ce4bLIWTzZLUV3weyIEPZ/YrxMaGvbdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782589209; c=relaxed/simple;
	bh=UJ8Sn0XGgXvO16kSAyBoVhJ597IYfnlNxkbovTmKbPM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ajfO0OcEZoOBjO5xn2Wln3uPDM5BovPyzKooWvj1+FvIseAlQUgi73NKD2ahB8H7zuiSGX4Xe42i/9uAN3wHbL/TnwP9yQSctDtK3Llotb//wKqN/avq9oJkSnP65dHOZmZDryQWBVZsLUCrY+YHbuwSsznu9UkoAtx93VuKI+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIXdwo7N; arc=pass smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIXdwo7N"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-69d862236ddso1565431eaf.0
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 12:40:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782589207; cv=none;
        d=google.com; s=arc-20260327;
        b=In9A+k+/9ywuQAbNndwmZE8mOLjJMl/AA3Vsnc2uZjeTAjOiIvXjV7BZrHu6zRBPCh
         3gaBBWVRDnpFB/S8A8L2YvaHfiPrleY25R2QWynNsmQkMKMiZleN2MpNe8bwCmPJGbYz
         IarkzhDeAAKXNmUyz9RMXCr2rxLZy3GsD6R4VhT9RFz5IZr3ThJxlyUIU98GEMhz2KF5
         au5uLL0K4cm1kQojYWUMQhw87dYYZ8pH+vdUemqqA+qE3M3uc1Vq81GYIm1GxlBkvYoi
         42TlHj4ebJ2xi7gvvtMJSzTg/yoJ/Pd76nSEWP5oYPFMOxwXx4dxmfbdnEm4XXyGrN/l
         9KMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=gogu02sHI57sEncxYeCKmURbt7DTQbOI2uDOGE3KaRs=;
        fh=mRgURoJIZqYUgK3jxW0Ex5mGDlkTMhXgXKLJrea0ePc=;
        b=A/Izj/W2r4OgqGRW9BiWckeVcFnIrtirdfJQc0eOpyBZBY89dxAWPcZX+CpON27BJH
         wkUM0twZJQr1Axg2hg0apgHRKbqEMg4QNE3hBg8I7emg0Ql/CD+lC0NEQ8ngKsphkvYL
         Z1vCn9F+twSj/wtEwkEWMdqkeDq9JVSZOgwR0xoYH4/tIN63NkYnT9xepyupH5vK4pFc
         1hNDGP0IXX2LwDgqg79OLZpp+4MffLqOsNqMNNx9GcBMgo1uhiIV2IZzByYqLfZE4bWD
         Xf6bV8ZTiWY9cgXoV1W/saLHLrVX5/pgg0SrylHq+a98XaAoO/mWinoKLVcuTUZ/GxcF
         OMfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782589207; x=1783194007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gogu02sHI57sEncxYeCKmURbt7DTQbOI2uDOGE3KaRs=;
        b=DIXdwo7NLWAR/QibhY3q72aKoRu4kEg0vu8Ce95rb5YfFkAFMz5MOAZouVRYkhMOLJ
         s8XUWbsLdckaWdbVuWZKlBsAVQlA72cNaH2ZmGJUO7bMImf5q8hT3L++KkqWZT3MNMV8
         hzfAeJoeHW9iv0ySL3f1aubKNTfQX+L/j9AWO7qGVdBXBRgi7WyJNi1D8nm/F8u1RYxn
         9fvwKoGrvnI77/4jMig4x+NmHjTchQT6tLO6ERodr9v0KIwkOvFNYpsYOBRWz5/HSGGE
         9lU4MRXbOkVPr3A94xGn//RdpEjmbUpAb4ezaSeAhOiZxofk8VR2ZnnOHAB1e38F50vX
         F2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782589207; x=1783194007;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gogu02sHI57sEncxYeCKmURbt7DTQbOI2uDOGE3KaRs=;
        b=m2B3jDSLVHsuX6qkKfoRm09UVUyN6CATVJPAjQPA8vCUaUjuzpFnioEMkIPMGd0sGS
         0qFlNt3lFLb8VlzUWc9BSyfR8pQYBVmV4lAhX9UixHRPH4mA8sVCZiOESO9DVJ6FmUFF
         Lhb0nVlHakjnB9sGUZ9XetJuQHcKmD9m/X17Pypams2DFMJsJqoOTkVFc8qj2IU8yPqT
         8s+hn/lwAodrT9pb80+XpIkYZB8O9XFDjjsbGr9SElvFqyemdjVsAON4LGAABQZnJelJ
         QhVjAMBepKR/Qn/CPF/pP+s00sqQbvv5HWpejD7fYqh3rTeI0be6ABfZCnxN4DEJzBwV
         o8zg==
X-Gm-Message-State: AOJu0Yzdo80iPRGJrBVm5iXLU7ak+Wu+pZnp9afaTpPlXQpTseFYkCRv
	oD68I44dQvrx3W9bFhXGv1bLn1ZDsUeMPpVsHup9EikY/ZJnmKQunuAHv6CP1TVL6+FviYacDnC
	X2/cl0B9frEQGbbqn/aIJgIyJ8WVmbBwNx6cY
X-Gm-Gg: AfdE7cnysG/J6hpmgvg4/D372wUZzNPUMwhOL6keuNmVCDHVICChq3ibxbKaXmqY7bx
	v2mEMlSiP6ZVbtmNxdHLXe3Q3xblo+vv/Eb/I/2r7Eh4jYAfQzWCiI2SktlZHuuREFTRKEoA5gL
	nd2fWMe6wxGtx21kY5pZzExif78I2PaLI8mjqJhiIiG5Si+TiIAEPOCi2FzzH7e8/ULGDlfyGO0
	Mb5IPPJEb34xKTW/cwWmdagns120lYqJ2Wztio4pnE0RtBQ3xAdYDR5M9TsG9i1AnF4hiyDb7o8
	osPZfVOAo/0ADdlb+swjnSce8I9LyFACHt8PmyJuEHdS3gQ6Zpxp2PMOTAfqKvf6MOQikpinDLl
	wIcHk4I7rHEPFk7U=
X-Received: by 2002:a05:6820:2912:b0:6a0:e3ec:7a5d with SMTP id
 006d021491bc7-6a13521cb6amr8891712eaf.56.1782589207402; Sat, 27 Jun 2026
 12:40:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sat, 27 Jun 2026 12:39:55 -0700
X-Gm-Features: AVVi8CfJ18tq1FwJIOxD384U52lULeV8BUDuKTfG78oQE8OM8Bx9HASQObFHFbs
Message-ID: <CAC2Qwm+48Gpj=AWHzx-nO00bwVfuYoGiwd=3gExbybcOyHC45Q@mail.gmail.com>
Subject: Re: 2.54.0: fyi: endless loop at 100% CPU
To: steffen@sdaoden.eu
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Steffen Nurpmeso <steffen@sdaoden.eu> writes:
> I have no idea and i am not looking either, but my scripted update
> of tracked repos stuck, and i can a hundred percent reproduce an
> endless loop that consumes hundred percent CPU by doing
>
>  git ls-remote https://gitlab.xiph.org/xiph/opus.git

Hello, thank you for the report.

When I tried reproducing this locally I was able to get a response
eventually, though there was what seemed to be a stall mid-way
through the response from the server. After looking closer, the linked
repo appears to be behind Anubis[1] which may be rate-limiting
and/or blocking the requests from your script. FWIW, running:

GIT_TRACE_CURL=1 git ls-remote https://gitlab.xiph.org/xiph/opus.git 2>&1

locally showed the TLS handshake starting then pausing for a significant
period of time before eventually completing the request successfully.
Maybe running the command with the trace will show something on your
end?

Also, here are some other potentially relevant configuration options [2][3]:
  git -c http.version=HTTP/1.1 \
  -c http.lowSpeedLimit=1000 \
  -c http.lowSpeedTime=10

[1] https://anubis.techaro.lol/
[2] https://git-scm.com/docs/git-config#Documentation/git-config.txt-httpversion
[3] https://git-scm.com/docs/git-config#Documentation/git-config.txt-httplowSpeedLimit
