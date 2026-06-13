Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34CF37F8A4
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781372617; cv=pass; b=ivZJXpvtTMdTvte1M3/RgzmhHgLvSBRV9LwR+pruemfY84k1oshPb91jO4fq4zu1QccHktIbXZgLCr9hio7GCet1FLzuaKZ6lTbz6/25wpDkf7prii74wN/Iq4MfTL0dOILkGpSU1Gp+WN/KsHrPoLUP8vRQnWtbCvmRnw6CbKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781372617; c=relaxed/simple;
	bh=L2VMkHo9nwgQ6S4sb+c9wTn0OOOhUKGgp+od3tG2NPk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jWjqITS8u7smKqsqu7DDtkRNM/Jas6zL/vfZBBSbW8r7hiOwWfPSzZA21LfBa/eDpnOhw5BC7SwoTYqaKGv6YejvsM+J53by9EZetSe1KjaFREQUx+f/mKueixnClZI0U5VAfNAiznX1vJdlVgmRDr18iBrT5rhh/kIBt46PXLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rn4wfoIF; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rn4wfoIF"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1370417c01cso2568214c88.1
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 10:43:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781372615; cv=none;
        d=google.com; s=arc-20240605;
        b=SmUAS28V0WvNEUq7tiUQ4CGB1rvDYkyYpp8Wuzfqabglpcdo6RW+nDLiyXlzfWWby2
         upP+RCl1JVe3wHCxCTnBtcOhv7uBUeqPYngoP0DJxxtKEziB8LdHiSvX1ixBodlLID37
         OCV1KdrdWhizjek4FT2dKLcWkD3UYOWWlaB2PEhsM1DDxQTQHiDyBrL2qzN3zbP+vzOY
         0/Cd+DqVYYqpqQkFn/8b3ekV11PCG3ytRrIMFONo4tCCS4vqGDWB8HLjnKf3i3/7SzyD
         wK6NWavgBGu6TsiN2CpM8rHmKCzcd+zuOwEgNA4057HajqNw3PnZ8i6A/yQ10Ob+8esd
         tJrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=eXLMr1JjX6kr/nFwar1hFDv2yeHewht6Uo4b9sIQkQU=;
        fh=o9qB5PXa7vosqHeNAjXT/dcYACJXfUUgxpUfJ02J2PQ=;
        b=ixBqZlYzGph9VQvReI3csjN1y1+aQkpHGE9b5jStvtHGxjhsYGtLrRNBI27b1XjBx6
         CPH+cBS/Tb02qGfBKE9H5V0GEiqDkwTDCTBRfDpHt8B9icc3aIEZ25FgFufH80aflIRK
         BBZwa963EwGh31ClpYqrE3es4alXPBtTosjLID1F1VHsgclb9W+8oGOtBsx1aytDLHly
         yF0qjih2Mfad4gAlMFVtZ+CYtgAGZMc5Zdxh9234Fq0z0AvlQ5nAjV/qFtVpKSQ6fTPa
         i/rCBLRiWm4ofNdThptPnbBAlFoMCLcQHeWkG4oLOmV5sMWGIPwOC+8kKYDaLn/nYvWI
         eG+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781372615; x=1781977415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eXLMr1JjX6kr/nFwar1hFDv2yeHewht6Uo4b9sIQkQU=;
        b=rn4wfoIFmvDENl0vOEQ5sBRqjdILxBJf3bIcBiOoTmzG2Z0uiufbB6hmZfo49QIliU
         GPHtviS7gCQTIphx3Jr/ELf0gpKBQUHtchNQcnTOhD1ZZSYNkQhg+H8Jrh0MVnS0dLC3
         upTtxEYWyCX+tB7RnIedZNqhPUMCm0zTMk0fZDmTS9Y2RtStahQ4Rj0AVJ3dE8kh7HdR
         l/RUVBmZMlXnM3eoNq4jIXXJI3jlUGTZlKheNH9vH6sV/qs75uXQliu1EyKiFg3f7SXC
         w9oWbGRMtvGGOOi0Ic1DCcu+kh/X67k6fc65AVPMh0zOSzml+V8m5F07nuplwkOLGVWE
         lowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781372615; x=1781977415;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXLMr1JjX6kr/nFwar1hFDv2yeHewht6Uo4b9sIQkQU=;
        b=ougwMTsHMeyv4Fe1YAilt2o2LAWlnWBXeDodHMlnahUL3dni/BEIf9LUeUx/yTmce/
         Ca5wyH3MYU8DsMqTDep1y9HJ17WpzxvYx9XVFKIQ8z1RjQ0LxDC/kYYYVJUrv+4tcaiS
         8OZFO9LpEc65L0BYpxXrlYwdIez+XEvBLPcMTzY9rlGhoB4SrxwHKM8Lho8qdEPu5Uf0
         DxknPnK6yc3BVqOMRpnfQczBHT+asMrEQRXvu6wOmQr7ejBBAZw+0IAptJJ2MqjVlUeJ
         l/07CyNaRdo0SAJl+7Yihwquu7Z0Mz6kEMFmRexFuwPAmfJeTQYhZ+OD4xO4PUBSZBU1
         wLbQ==
X-Gm-Message-State: AOJu0YwMszynxBHaicumHHJH+7B5KyeYI9cbQFfmu29tEDBpnhnRZsgO
	7JKD0CkTT8QxoL0y8XcmMxRWPT+MxGbVwJOFJUlZTz2qLRxJLMnLkIpCDvhyjHLCap5mnlHwk2H
	rVPYoiFiS/IqCk1qxBsHThL/22wrCAlZkHZFV
X-Gm-Gg: Acq92OFxNoCCtdHNXMAYQkwrF7njipO0OAQyrHBw68bfgGa5Txms3MDrGYOn+hMcAXM
	BV6hHIu0A1hIRwufR7747XyX4Q2kc66Id00VZUdIhAw5mhY/2SOg/vJKT88Htbuk6JFyNR0BLwu
	Llq4Wb1GlsTs3TeFRjSsD1hPFJ+TbCgVogo3yxJIbL+mK0k/ShxMFIatWIn/T18Q/QTHa6lOdjf
	ZiuBQ1+AWnJeLfSAdRI/JCs7nsg36K7sMEvMZvMYSYzOF8rSXPsSd9omNxh5tm3CCAiYSFiW0H8
	XqaJ
X-Received: by 2002:a05:7300:8188:b0:2f3:3daf:3496 with SMTP id
 5a478bee46e88-30820098dd8mr4339027eec.26.1781372615083; Sat, 13 Jun 2026
 10:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hadrien Loge <hadrien.loge@gmail.com>
Date: Sat, 13 Jun 2026 19:43:23 +0200
X-Gm-Features: AVVi8CeYh6qXsoQdDifPuOns1WzOS1a4iGubbvKIKMWIOWrDvLm_gvHBffEJgKY
Message-ID: <CADeHOfw6kNstNFucG7an6+Mbm2+=-PnOH8xtZkO9RK8=eWsx=w@mail.gmail.com>
Subject: Re: [PATCH] clone: accept DEPTH env var as fallback for --depth
To: gitster@pobox.com
Cc: git@vger.kernel.org, gitgitgadget@gmail.com, hadean-eon-dev@proton.me, 
	m@lfurio.us
Content-Type: text/plain; charset="UTF-8"

Well mainly I'm asking this for packaging (Arch/Alpine/Etc)
These all follow similar conventions (PKGBUILD/APKBUILD).

But in nested flows the ENV var seems like the proper solution.

Mainly I gave this example on github:

    git clone --depth 1 url dest
    cd dest
    bash run.sh
    here run.sh has its own clone deps (perhaps even multiple)
    --depth 1 is now lost

And only ENV vars that I can think of properly propagate for CI
flows/clean chroot envirs.
Thank you for considering the solution. It would be very useful
for speeding up packaging.
Even on 5k commits history it's 900kb vs 17mb.

I have also reworked the commit to include tests/docs.
and rename to GIT_CLONE_DEPTH

Kind regards,
Hade
