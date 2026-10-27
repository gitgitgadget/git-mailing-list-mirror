Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793105622;
	b=0WR42fPNuVcd+F3yB8v5mD/qeqWWBlspfCfcsAy8tb6Gpz0ZDnHubjzCyoY55RWlwbVb
	 rXIKw2Nf+NUKRcp5AWAODykfTYaBFe7F4Id+1/sHPMuTC3Wx5Rw/r7boO5kh+cGrCbbYQ
	 hU1YvgJ48MoGxHYkTfn9sPoGGRHKN+HcjM3Z2Bx0g5ptCOzjWdPl2I+iQf0L5m+KE5bZl
	 yxDLx2kB2LiM3uFl7IwZG/Q56pDxeUAsgGsAVgQEjw1TsaWhqmUfd3FQOm09F0ofSdlUc
	 yodI6XiWC2qYzBIkK+UxRFLG2DhD7O7FtKA+2wK4o3Spx1c+0pHZ1pzUEPEjyw2A0tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=rhAZh4hM0nDO7SxRKpv77LiDuyKyNYKI9u4pgccJG3w=;
	b=gqFVqVXlre4IClgvBK5FrGlLusXs6hl00rJDV/V/m2udKW792z5ApWsPjxn4pcAmC29Z
	 uFR7SEAA9Gf+EGYGMEMtIm74PzwpPvdOM8L6Thn1CXhUL89lNsozX/wwzKigoyYkOnIF9
	 xYI/Y+0Lpg3f8SyzHVsU0jZH/8R94Xw+7cqVliKv5pU2Y9/J9GsNHOXmeCGGkU37Eskne
	 ByACNnveWZMgps1swbTemH6jc+1rRHEpaTS+OunJzzmCVJpN+y1X11CQ5TYJQ0xx98z7D
	 agSYnLyyXLrOGIAB/GCiHiVgGTZHEIxdMIQfSat+9SyasZpBTlp24HvL2WZA6/LfxCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U4hjG4uA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B65606A331
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 12:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79B65606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U4hjG4uA
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-825b40f8a26so2002963a34.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 05:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793105621; cv=none;
        d=google.com; s=arc-20260327;
        b=k+5TDxwrurgZZmX41b1Bt43Ku0X0VWJBg5bMQbFB7RqdcP+TVey0JsyqBAsawmd6uy
         FTWCRuiQLp3u3A0LwMboeQ0jg24jDXUr3QQzC3/v2z1UQ6x2mixQBK/KRISwSb9wgsdP
         CqWNcf4PtJyg7IKeh5QvL9/Vma4vJW5iVuTD3PxB/y1nM2qlPCk+CwrWJQNf5L8Akq3H
         Ry9WNSM6/61m4QtprrmmuT1wnFsEKpvgb3OSrrPZMxNQHoDRkP43s0ggTo7sbG7EP5Dh
         SSF23JhVDrR/YCyxJC4+1CI48akjPgUS4Ic3qPJEFzCTsqAFH/S5QYWyJxY41N0SgaLU
         uHow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rhAZh4hM0nDO7SxRKpv77LiDuyKyNYKI9u4pgccJG3w=;
        fh=5VWuV6+JF8Tlr4dVBJXU2RRYOfskqpyOeKwO7q1Myng=;
        b=ECsW57u5Zb37XVgrJucDsu9ZUmvj3RFbMdZSlxn5t1A9fEyI6CVinlsJ1idu4R/WOy
         8akJMAbbv5Acg4zn7k0M23xB29y0drcScY4a5Zo62ZLb23zJznXGixZrR4Znkc5CWbhQ
         Ymo31/U/MQGbVYd3yDPKb5/Np2wTrgc/HrgcsffJL83gh+p9SPHEMA6cfHyCbLSaPM+6
         O5BhR7n28BkpetVP/X6ZnJ9mf6uyMcHrYdBz8mqcfQwOYPVOAcTT0gmh4K+55y8DBAf7
         CnGgVzPCIySVXyErHP4dTIumaeWeR8ugDHR3LMMmvlABi/bPh6kwCd78LnxpC/eZttKm
         g8Ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793105621; x=1793710421; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rhAZh4hM0nDO7SxRKpv77LiDuyKyNYKI9u4pgccJG3w=;
        b=U4hjG4uAm07KpnI9FrZBdfX7Ww0YurgsXiPEAgy3yDql9i33Obf6gvlR3Fw9ArNEFd
         ucbKJScQ2VnEM3i3Xs//U5jUq9Aa3nK58VIfJRA8tmKFd2WjXVEUZXsjwseCQ7x1ej1K
         /XARUhLw+R/AH6BL+DMFV/qoDmOEsfp4FoUtBLgU3IkMkn85v26PX9HjguLht36KueUS
         WthN5IsBLouJuLY22h1Jg+5ataA6xlW4uvGlP10sz44s+8qLVtk+hqEApwoWjri30Oeo
         E5v7pHdY9B6Zadp6TowiSNyYZm7hcKEZtibOyHPbQs8oA8tcUwrs6ZNOk2E4NOmr/SK8
         IL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793105621; x=1793710421;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rhAZh4hM0nDO7SxRKpv77LiDuyKyNYKI9u4pgccJG3w=;
        b=frpJb5T8tJq/YKioItv0fTKq3NI2rPV7PoqujYqhz1hNPnZJafbVwymeXqEZFCmjZ8
         lUqNHkwvZs3OBH/ivylpGsSaKu4H7BIZhUUTLK9ehzPm1/pG2pG1MnTc4xJ+eMVqNBmw
         /KIaIaubZcQfqy+A3iOU12hEymmTkMet2uFCKlf1v06JBSsDuY0266P4H5Rcvm5AXKoK
         kjMQoNJhKXhzMjKrAal2o5MnsZSimJonKSLowFk6shc2rrQckPcr2M+ZMr6DHoFNM6WK
         yj9EJmzZANt2aIA/UX+mkHSA2L5nrVAHo8VHmaYypEW93VuCKoUckQrRdotFwwCiEOoL
         fH8g==
X-Gm-Message-State: AFq9FYImBkZAODV6p/rt6ka42dE9B/Ngt3hpvtBwicBWQ2nUMUqwRNG5
	jq6KGKY9D17qbEi3JIEmk5yAwJRIPJtPeJujHEZyeJQg7llScbWyeENY+3jQKPuWjfa/QuKfvqG
	9BQHqre5F/oNSY3tKZZcB0FS1FXyvrpWZkJ/3
X-Gm-Gg: AYBFou0ie2ewn8LrolXBtQQEtrWXwmVM7Zah2g0LjeSs2hED9sUrAevJuO1TQCMVX1U
	+3Q/KH7vBZ3fuWR7Xgn0l9WfZQYRBO8BGNEmBZmC3DjlxEXovZfutRPc+FsgwboO+Mo4XlaVUTI
	QjqZrvEN5GEndgt/yNWcMiARQ7G9VqVaxP3fsNQhUKIgPjxPqin0J6JLznYpuRXGX5AlxhCxiLc
	Iq6Scj673sDqWMZz7z2cU+OC1VXlg+qA7s1WRvlnPYSsfE1t1YDcGrZOFoS+FbdRrp2HpAy9/NP
	Vhkhufwco4U3KBxcRX+g6v8UP11Kn9Uihw3o6NAIOJJMU7Wy/WzpI8GNBW0sXx6p64gDxJD53OW
	w25x27NOvWxLDQT2VWuVgU+YWQqlGASpANak6hBQ0dTO86PwCSBK6KvXJfw/qsq4MP1/v5bQgPK
	mbwVZjFq2c4crwSFCI77HgX0rvUBpBq4eIBzYIXDVOJY+P0bWtllyE9nCd9FiYumiPuPl9ezIhd
	6Sa2HQ8vxcLJz0c3Q5Boknb
X-Received: by 2002:a05:6808:c296:b0:4d6:90d4:6bd with SMTP id
 5614622812f47-55c002dbc15mr6879364b6e.47.1793105621462; Tue, 27 Oct 2026
 05:53:41 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023072559.3204273-1-christian.couder@gmail.com> <xmqq1p9gbgwz.fsf@gitster.g>
In-Reply-To: <xmqq1p9gbgwz.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 27 Oct 2026 13:53:28 +0100
X-Gm-Features: AclHuK-f2M-kA8P72WS1PowRYWGu0jAC07tBH87cBEf42t7OG3ZZj32p-l6ZCL0
Message-ID: <CAP8UFD3qSAnpNBxrBu0ow5roTv6wzqAudUc9_bOR9EK92ZYMiQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] SHA-1/SHA-256 interoperability, part 3: pack
 index v3
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 5:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

> Will replace.
>
> Next time please make sure that the cover letter for a new
> round is a reply to the cover letter of either immediate previous
> iteration or the first iteration (and all patches replies to the
> cover letter of the new round).  When you send a new round as a
> new thread unrelated that is unrelated to the previous round's
> patches, automation will not quite work well.

Yeah, sorry. I am going to try a new approach using a
sendemail-validate hook and scripts (see
https://gitlab.com/chriscool/check-send-email), which can also be used
with b4, to avoid most common mistakes.
