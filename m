Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793156206;
	b=uFrt7b7C0JpXa8cImssil/B+74oQm5aI3VMbvEHf+WCirtaHUHsh8/63Nt7kptZCTlON
	 VR9zPiDi3MnkSlancw8PAooRYWS1Y2U+VB2vyNlvTJnWvK77t2qS0THKPI21U5VU5SEM3
	 xhYyO92ChHq+KQR0jJI1aDAofmOtY0qa9axa7SoQmV/GuawcColmtoAJAn8i1x+mgwoLY
	 u8Yy+dyPKzU5SPuzrTV/bue2Aoi66x0RQIsqNqrRj3hsZLWE01RHpNn+FTHht1n8r5Eyc
	 Et6c8OhgYWruW2OUvHssx59zvX2LjRYnS3YOlNb0KRNO09UvvOMQbAz0zlXnR4AziHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=qe+Aba1mc70euwvyHmGWBgP7N9IWvenUJ5MnD/rXHZk=;
	b=lPjSGLntEIpsDQyxoTUF//sOeVE7I0VU7GZwzgeHxnVQ1GckgEvYoWzxecdCJMM3ye2Y
	 MaFc0l0dSIWEkNPqV0HcuwpGlVZYnuamosawWA1MhLkS3tiZGGeC7CfPhaP884XzYEu/B
	 37xT4L2gcAVlMcmfljJtFMZWJXFzoXba1IpQbaqLGsW7QLe1SxZBxOpeSpKK16taMs4XF
	 7F2fQDAm+8MCLjB15VaQD7gfGvhTJNmpW2hBDb0IpGL3F2jfdtfQarg9LAczVKER+2oRv
	 SIIDGsBvTY87tYRIEN6j8TrhPuLlzcwBrh0ziI+0XjEVFUIY4mgSNuVm5GSwrQAwqKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lE8CTKwU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5A0606A32D
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 02:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B5A0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lE8CTKwU
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e46e449e8so280627f8f.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 19:56:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793156205; cv=none;
        d=google.com; s=arc-20260327;
        b=ZM6zg3DBvtTJ0jSeBQ6TAXcMxw0W+1PJnZCAtJC1T12wCWSf18aO94/UjX34xyp+3Y
         YA6ZX3NO7P7EB0jswkMjf/4bXoaE9SJbJNN2gZ3rbtLLDBPZAfh4RpnaqBKPWV3ktlwY
         b5/SkT+nw2R25S4RLbK7W4Ejc3N+cAmAexwsBZ33buG4xJlPN1jEd9e+2TY2wOQONBI7
         YcN72MOQy5uchOyVo5kUBjyGCpxfvCe47hhM8LsiQKHERBCwwDfXtv2HuNX7Favq3jm9
         oTNTfd80E+1JsRMQfArYm2Vjl0k7YX3ZqHkdhqMtxCFK9zfaqPvbzytzYXn7fQjGx2pn
         fm9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qe+Aba1mc70euwvyHmGWBgP7N9IWvenUJ5MnD/rXHZk=;
        fh=9lOeBiTeAI+4FIPMHGbUvHErvC4nv37dZNbhm6sOM2g=;
        b=F4b5dcXtVBY2mF3efcXm6vudchqLe865W1onPjhGTQkGePCX8ttvr5ShpgZtFOf8DN
         jATSD8zBg6GFwLe8UDlhs4AiaUq1OHfWfUq3J0kABw5hvGSqGDkh9TP8PFES/leRZuah
         rCGSsX1IHgkw6VeDIKgWvFuZL5F4jwQQRDStl9ybr6Kuf6S3G6J391YDwQJMsPFacrqw
         +b6P5gAqTbKbBGsrduVI5DIXGmN2nR6mBYzqw/GQZY4NV+veym50rosi93BVTHG0M80W
         n7PzunJ03ifCQJOxW+66n2J8dNE2lt7huBAFal9sB9KymeeeRZ1qLJD5se2h7Z34Ul7y
         PUgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793156205; x=1793761005; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qe+Aba1mc70euwvyHmGWBgP7N9IWvenUJ5MnD/rXHZk=;
        b=lE8CTKwUfpn78kKP4piu1JZLLyop+LEi9LBXi5pha9+YkS1kHhNvBp6Y89c+0reChU
         +g4TTv4UN75UV7zloKX5OiqqrHnyIGrXVsNQz6SWzAI4KLkCmFiIeyb5J4zu2YOZ9F/K
         h6qNdCAFYgSEem04IR3T+bEVYH40ABZJH1Ixj88pRlmk6oIr+PNZG/KDxCSA9cUi0/cf
         bPVOs0pyrMwwBy2P3GBXYw18Ik+Oxam4cSZhVeiRBvoOALpWMwdOHAYZByCTUlxhhV5W
         OCRNjIRKGlnfhDJadF24HNRO+a7jNgiqj2bTrnHBtMsBRXvOMIl6lspmFkSLEPDD06cj
         jRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793156205; x=1793761005;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qe+Aba1mc70euwvyHmGWBgP7N9IWvenUJ5MnD/rXHZk=;
        b=wKZkEC+6ZJxuB/1Htn+ghGdELF1PPupZ46UuEdvxxCdT/RZS8G7oH5OAKNfRxugFLs
         sv450bSK3++CJn0R3ZnZPua6+Sl1ZhYXxmzUN1tctQkqv+Lpgf0v91kjlPKeNvHC/nJG
         N3HVyw101LDgkxRgJ1Lf2bH3l29Aq0xeDQA9R7dDeB39NauVqy8dR72xHrjlB/hVgc6+
         PR7vElpI4ewkhZypdha+6U45WTjARgdNOZ9l0QfGGEhhcA3q0P3DUG6TCHwIvrItD6rH
         ZyWKlCZG+ExH84GUlmbbmP75O5ptSoC3Jp+2pkgruVnYJtbaXvCWy184brdM5Mjip1+v
         STjA==
X-Gm-Message-State: AFq9FYIpVDW6q/Z0U6xFs5fHOyXJLfRYpApvi/bhwlofcdejaQ1RKhJK
	K1wIVNhfAfgf+CkUw6//m6DzZk+b3HTOvvZiPIf9Ky0fyJ3SzyC6Mx5Xr3hPe/0plWXMNKy05S3
	KhOsSY7Rd2HFd2QIxuRyGiwaUCBn9DuU=
X-Gm-Gg: AYBFou3unOksKJf7bKulU59XRDms9yo2lBw51vAuv7d35JCKD4eaBXD7hbMTP51JyvX
	92CwyPenkYDxntvnODF07GeG+XGxihG1bYFsvMsyNoErLpItlnF8ZQfj49kuZNXJid8dlWmu29f
	lpReaIL3cWbY2dYYPDQdttVIuFiSFzEdfT/TsI1qu8pExLx4xCzryDNIg2PY+9HT9QzCbufoBex
	BaSS+Flfq0WKcUIUnLfjjb7pmra0VB0/WBhiaLCeZIBENGlcOam1T0TJBHBUhyhP/nBD9d08Ezd
	MxFTilI4Fxw/VXZ07auuTMlj0aveY/SfN5bvfeYjfAG0m18m9T7xQ/Xh53u8QNeGHixp9dwXFZ2
	Gz6z+euQKpXeSLhL+XCwSIsQ4EN6E/LdmSVRG3aAo0J4SXR0kqU4CyGynmBs=
X-Received: by 2002:a05:6000:4a0a:b0:48c:69b3:610f with SMTP id
 ffacd0b85a97d-48e5d2f2015mr2621781f8f.26.1793156204639; Tue, 27 Oct 2026
 19:56:44 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018235508.848-1-colinlewishinton@gmail.com>
 <20261023185007.21642-1-colinlewishinton@gmail.com> <xmqqecdezfr1.fsf@gitster.g>
In-Reply-To: <xmqqecdezfr1.fsf@gitster.g>
From: Colin Hinton <colinlewishinton@gmail.com>
Date: Tue, 27 Oct 2026 19:56:33 -0700
X-Gm-Features: AclHuK9cYNS5VYtF46PjGaJjuEAlNq34nVHjvzM-Hmsrc5c5VXRYSp5m8-xiTQE
Message-ID: <CAHeTm9NOqLA=BfTU9ABDFt8+jOzaRDPRrMNP8thzAQN2NVZAew@mail.gmail.com>
Subject: Re: [PATCH v2] remote.c: defer remote.<name>.followRemoteHEAD validation
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, m@lfurio.us
Content-Type: text/plain; charset="UTF-8"

> This part of the code becomes overly deeply indented, and more
> importantly, the outer conditional around here has been reworked by
> another topic and the code that learns follow_remote_head will have
> to be reused elsewhere, which would lead to a nasty merge conflict.
>
> I'd like to see this part refactored into a separate helper
> function, by squashing something like this on top of this patch.
>
> Thanks.

Okay, I will refactor this into a helper method since yes the
intending is becoming too much, I will also keep my eye on the patch
you previously mentioned, and post a new version once Next has been
updated from Harald's work so I can rebase with their fixes. Thanks
for the feedback.

-Colin Hinton
