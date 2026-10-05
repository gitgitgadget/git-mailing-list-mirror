Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D07346AC5
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208105; cv=pass; b=q0p23i6hncihO5lC7sVdpfzbcQZXI6Viwb+f2ZWtxmdEIvTJe/RvZH3URxhcYwuVLI2kyvkXR0H1mZWvMy9DQIuJWmd2k+802gyPcnpBucdvZtJSn1Xe31QXPTYZJraJ6dZEfQKm4iWL59IMUnUaN74bhcANF8g6d1GsAqSMv0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208105; c=relaxed/simple;
	bh=g7p4WY4CyTbDZgvNL1JKBiZc7IdPmHpLZ5a4MBjy51o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZV3rv+3LtnQ61ujEyVOkd4Y9CB0cyzv8jFJ5WZ6AL1m90rrxVljZC02dTOAt/SrNx+wmZTRXtt8RYJACN7OHZ6ZhWiNeAkBdOnVV2G8QwaUdFOSORuuZk5YggYiB6rb95A6L43fvooeCxBlgmfoP420oE/rX+09WXumJfPKp/X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sph3r3.com; spf=none smtp.mailfrom=sph3r3.com; dkim=pass (2048-bit key) header.d=sph3r3-com.20251104.gappssmtp.com header.i=@sph3r3-com.20251104.gappssmtp.com header.b=Yo975Yaf; arc=pass smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sph3r3.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sph3r3.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sph3r3-com.20251104.gappssmtp.com header.i=@sph3r3-com.20251104.gappssmtp.com header.b="Yo975Yaf"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-919552173fbso22317686d6.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 06:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791208102; cv=none;
        d=google.com; s=arc-20260327;
        b=KIuSU9ZPkaEb8/gVFha0lwxhHvY2+v3mZ8wbaODlA6+qUfCGhu9mBgqasEKg27+YJL
         rO9Qshx6fi+Uzms9sxBOvlSQRx7aWSbUY71n7CkpusSq/2lIERS0vwOFWLDlS+BVtuzf
         8mPviuRlz3RzqRloIifxKweeftIMhXTvbHOH2Ih9iKKtl5clfIpZU/2Xf+JRqsbYGk5h
         xqJnPhTHb6v/imEEnWBqC07hSTojMziw81HG06sayWUFgSMBkju96cJ4pYMdNQF5horE
         i0t+lDNU+PuWm67OfXN1MFElJdsWb2TnRmkZhpHKc8JvZe8ihfX7KP4vW3JOCPTTC4QE
         Z1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=5ZVsJYARL+0gPSzPA2XMUBdfiRvwp17Eew+BmvYENrE=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=NFZoBymnNmTjjbF62m3UaImdJmYD8czKNFiAa18DvmPrIH0MmwMxPyczcPKliEifHP
         6+cFAib4RhW4WiQY4DFO6o34HyAml9cFH6c/6M1vUzGoWsz0sMFwBTFr6PX9HTYqkwMy
         DsZhn0c9Ote+MbhgCqi5pyAzQ1NRUu6Cd+kCIaMpMyI3FGRc8A1R4TCFbD2fbwg1L16f
         XUOaum54oX6xjNWpCClEl3L5WEB3XCQQFNHLR0XGpu0dWyVUc8CUZLhZS/qdMVMpJBwX
         K6LO1zB0MiBOW9rr3lmUmB6iQTy+K0zAP5Aju9KUar0bc5W4L5BNBOucMqXFhU5ihhFM
         h6bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sph3r3-com.20251104.gappssmtp.com; s=20251104; t=1791208102; x=1791812902; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5ZVsJYARL+0gPSzPA2XMUBdfiRvwp17Eew+BmvYENrE=;
        b=Yo975Yafq2tlyD+UHr/uGoqSEJfYSTVn6ylwfnrqLBy8xzI4sYdr0tBydDXgLyHFKQ
         dMvx+dJ6ShYHKasHqanV+3Mvz1M1T1rwcUohwYNJU41mDC5+Z+Df0tRHkXUy0mL8euHb
         BUNSSBai0ciLFUBL3ZREomRYxgBaqI9hptK7z3T3gG0iyoNdXfOXJYmBLXb8ps1YpnF+
         9RrRJlpBnbzVNMFHYHFw23yQ//4RNnl/sj/GaTuAJ+Rxrt4GNgZ0KVbfwuzxk1TyrmF4
         LF/dW2V/FHLVwTKjLZNXu4y6j0F8fhIJJrFIx+IT7+JeLtvRF4+mH40Szv0uanOpmoF8
         PjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791208102; x=1791812902;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ZVsJYARL+0gPSzPA2XMUBdfiRvwp17Eew+BmvYENrE=;
        b=hUWDmrGtyyfTEzvau4++FZExJ/Vmd8n2w/u4Gmy4uRbb1nSpS+wUTxVXhEAwxB9e0p
         /WavCvK8H/nPmihOCWgPrL7s/cpwtKS5han9JMMBx3Y1l7I+oNmVGAHzA5meiiE1noeX
         2oADNV222wZUPxcm2XsadjPFhC1uj/gpDAJ7d10Zgk0e/9DkKsW/up3ebJ5NPuEjtixy
         RoSZdgNKMEXLcHC/v2kh+dHRdTVru14/yAJrE7pMP8vkTFiQwsB2BQfwdy1QD9nThJUj
         7rk+hLN0I37oaMiw7H6V78eY054pqzBiROgyZ2e1wM/yEJEGXPV6PpTaonFsGKQ+5/OY
         rFlQ==
X-Gm-Message-State: AFuF++mMnR9TCfV6OmKaXxI3ZHkyCDjHv/4k2PRaNlihbvVFh10sQlKH
	/2BBmmiTMzZIJxjz2G33Wp/0OhPJbS8CzhilheGjw/M2XDNHzAdsfzuVtRm8Vt56KncGYed0LtK
	0ehTdBv17zIsNDETtddn2ElPBpFfc9lU76Y3AoHh0mrzEbbjO10EN
X-Gm-Gg: AYBFou1y3yX4o5fpaR0YGpX4GwYMpoJhqysrKM7UkIY0PfPCKGLIOr0QKJtuDdlEWgs
	d+MoqOOhpniuSCOrX75ji60LXS3snWTOludeLrHCaFpdKw1Gf30p8xRLpnWsiAnVW8O2/5J4nZv
	MkDtJuIEHYmWJJ0SftspSGQBIJJ9MpYHF8O+9t947KWFn5DQV7Eanatc+ZoseEBQipcE9CAe96q
	JFNcezBhbdatQfztAzNlcBV1M8wXIvjXkeST+n97/y3fMvxXK53zb+cIsrccb0wb6Qeb5vEn+9j
	aTXscsY6StRN8WFI8PX1CspXka70SRkp0d0ZuqbccxKAsYoIwaPkrfj0mPMYFGz0Pc/Q8IMdAQs
	ogSa/GgQZPi5g0A5D4AUvyvfUUxF6zvGOtpmEV2S+1XqBV58cjzXM94iGMkh6XWSGCQ0arkRSq9
	kcB1b2PbEnr/e69oSDgA6cuTNfkUOTq7q3los2wwHwNowh5Q==
X-Received: by 2002:a05:6214:2527:b0:90e:8be9:c384 with SMTP id
 6a1803df08f44-917c00c2d69mr212860236d6.27.1791208101778; Mon, 05 Oct 2026
 06:48:21 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 5 Oct 2026 09:48:20 -0400
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 5 Oct 2026 09:48:20 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Matthew E. Luallen" <m@sph3r3.com>
Date: Mon, 5 Oct 2026 09:48:20 -0400
X-Gm-Features: AclHuK-Ajw3IzJ9QkbBsdSIOdWYp9nK6O2aeR9P08Xp1YDeYFG4HL1eTzjLXVDc
Message-ID: <CA+h9NxRT-9QzLGihdL_Bp-yyt1AdXJ79YYgpK-OaegUz8e+HcA@mail.gmail.com>
Subject: [BUG] ZIP timestamp conversion and strict fast-import date validation
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Git community,

I'm reporting three date-handling bugs reproduced on Apple Git 2.50.1
and upstream Git 2.56.0:

1. Exporting a 1972-dated commit with git archive --format=zip produces
   a legacy DOS date interpreted as 2100, while the extended Unix
   timestamp retains 1972.
2. Exporting a commit at epoch 4294967296 (2106-02-07 06:28:16 UTC)
   wraps ZIP's four-byte extended timestamp to zero (1970). Exporting
   the same commit as TAR preserves the original value.
3. git fast-import --date-format=raw accepts -32184000 +0000, but
   git fsck --strict then reports badDate and ISO rendering returns
   literal placeholders. This occurs in strict raw mode, not just
   the deliberately permissive import mode.

For the archive cases, export the dated commit with:

    git archive --format=zip <commit> > test.zip
    git archive --format=tar <commit> > test.tar

Compare the ZIP DOS and extended timestamp fields with the TAR mtime.
The overflow affects consumer behavior: in macOS tests, UnZip update
mode retained different existing 2025 content because the 2106 ZIP
appeared older. An in-range 2038 ZIP replaced that content.

What range-handling policy should ZIP use, and should strict raw import
reject timestamps that fsck considers invalid?

Thank you,
Matthew E. Luallen (@meluallen)
With research, reproduction, and drafting assistance from OpenAI Codex.
