Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892553;
	b=YKRoOliw/ITLksgdXshLGfHYo3qfjfdWgt626JhLxM0KNSVFqxPda8SL4jmoKOfYPoq0
	 /15ZKVdPgAVe9+S9YMaGbLVKSzsv18jM3H9TLVQVnNkKLXaQ0/7SEK9zU7zQeXjw4Z1S1
	 pgm3Dq0g1wG6guuYWHmF9OR4F0GBg3orNT7oQ3HrVRhSl3na/xg+h3zHPt7tw2zTZIn6G
	 tds1jt6IzpXLrhqSaXVuAkYTRSVvsWYfb9MrlZ/+6ah5QWy36mqYnGCTK1jHJ2zPfOmKF
	 Ube3BzeQGSDpe6AZRSyZAq8eHJWul63TRgo0/Qpzz6Wt93Q04Ldz7NS+CqFRozi6ZzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892553;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=I14qm4NL9Khxw09aasjuBNbfxmhixlobad3145zqRFQ=;
	b=06Hvbk0GpMZ5rncyAQuHODNqGtxKMeBr8EVFHuZNlLQeoqAeVaM3sv954px+BBEqhRzm
	 B/3lE8YGMv3l16+1e1IcUzai+urttotNTTD69BMYqbcTA9wKTF64kVDUGP+OII7skLEGT
	 u7ZXeLmgu/mjSRNOznp6F0qoAsU+oaPBYBQuPuVZgbAkLFp8JCcXYaPpPonrxRplb7axC
	 MQxvW6XmqGwICrDRVElj9uyZFzqKW6U/XO/0SergsKNaz/ur6sS5fUJ7VVGC3ikseyER/
	 PuSN04n1g5oE7yvUgzdE6Uok101hvlUHRbwjOjovpS0m99y+tnTCmZ8nwWX1dhkj43A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hxpl0ZXP;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE47F606A329
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 15:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE47F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hxpl0ZXP
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b09a65c76dso1512055a91.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 07:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793892552; x=1794497352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I14qm4NL9Khxw09aasjuBNbfxmhixlobad3145zqRFQ=;
        b=Hxpl0ZXPT7dtZZhI+OrIlmceHvGoi/t7Npph0cY2GmdXiGRiqQuZoxxfPvzx0PXFcC
         ud32jJWhnxumBTClGb7NoxCYWSF2buc3bmCsTv8V5YVR6pkSKr8cK2uKRUbNwrhUzfuL
         nTVBxr0mEGJTD485tKvMVs9Nsr6ljHYItQ+cgEEEjE6feNkEvSL8Vkhm5+E3YHjrbcfC
         phf4dIMXHJhY+onbF+MAAirkabYXekRczquXKGOZhmaZQT9zyQvpW1fdebY7WTF+THPZ
         +A3kN9vG2KrSn+FmTWWVNh84mTRcOpsI2tti+VeTCyXiMXKXI3/UzUJ13nnIlUEVHkAs
         DmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892552; x=1794497352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I14qm4NL9Khxw09aasjuBNbfxmhixlobad3145zqRFQ=;
        b=dbNMuhinJwy2dPmnYYjQ9/UfA8fY+UM+DfjgtqZUHNp1tJ0I0D6vct6PK+g0TqqEq9
         lqLy+6k/BRr6o3IxyQiza3COJzkQAGX20fudiOUa23kZS9HJZM6LtaW31TVXhF1ayPO/
         WWFwCUBf6L3/Q9brkW2QaXA7120gUQu7ZLHHdTvW3AjUzSJLu9/QfF6fxCkVd/zLb3OK
         5uVHUstNrDwnnURzj+RpWMGloyAEccbg83MBaqS6OkPqvmW17HcUaWwgGnFMtZwNeWQC
         GWf29VLEL7W9KgEUxKsZ8c20MvDk+tp9z8ErVP77wjaK1XwpUYz+g5ZmkZPXQn1IWfKs
         ds7g==
X-Gm-Message-State: APuU4Z8JDvzaoH8HOY9TqcHiO0CHKUhlnizkdZsItb0MSp5YYG2/+/QN
	8OIHVDlXcQ/E2unSyJmfTYyw29mw1QcQutG0xTMpYdiG8gN115Y7eZ4T
X-Gm-Gg: AYBFou04tBcU14iZeZneXEzB1uywY7BnW7YE3XHXgxPITjJjAFI30LE1F018kaomWc2
	f1UuxkJDzwauMGx493fmaaKaX3quptkfGeV4hlBg8uias3bvHwDutljPASSjGirlXsjrnXG7WB/
	7l3Sj8B5GwljIeLX5Iut54fYZO7+BomwWiamu7Y27wAGdbwZ5NJpaWrejo06ogegQnh61zWNGvP
	u3WzMpFSzZAWZQ77+EAq4JRX+Rld6o1+qVtsQuY6m2FIQ88TvNvO8V/seDVP8Ry+3u0ATFn2rEw
	qbuse8IUKNcPxERrw8zKPz+tZXCsBpRIWXuUY8gl61ysKfd/r/jdoYupPUKO60bevZeGuHRUHUk
	S5ZXiMI7krgubR6Qsr6EBa/fs45NUby/kEwBHXlDs4CTVY21VFLP0Fa2kms0FDNj+StgU8w5whc
	QYc91iO4dBUDuUilZUcpy9kWPs6nyw/BP5v38YGMa55a7/Spw4FYkEaCcMCFe7Lz6bl25AoWv6W
	XPz4XT7XRkNHGY5tpu+MZaLnecbTbnPiBSPBVZ1MOGT8sVHxGVzzkaYKQOremg0qSSSH7wRbU77
	5W76i25ILGZ576MvlK4sGgmWPYtAgzJ4edRefqkSvX8RdLUjd1Rr6e/3OQzc+HfUJMA3BqYb8A=
	=
X-Received: by 2002:a17:90a:cb18:b0:3aa:fdad:7d6e with SMTP id 98e67ed59e1d1-3ae897eb520mr13117350a91.10.1793892552196;
        Thu, 05 Nov 2026 07:29:12 -0800 (PST)
Received: from LAPTOP-PVRSMPQK ([223.190.82.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b319f2c9sm4252229a91.10.2026.11.05.07.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:29:11 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] bundle-uri: do not die on unresolvable relative URIs
Date: Thu,  5 Nov 2026 15:29:06 +0000
Message-ID: <20261105152906.566363-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.344.gfa103ac04e
In-Reply-To: <auyH8BGzIsipPAJG@pks.im>
References: <auyH8BGzIsipPAJG@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Patrick,

Thanks for the review.

> This sentence is weird as it adds context that doesn't make sense
> standalone. [...] Saying something like "relative_url() is now a thin
> wrapper around that new function that continues to die, so existing
> callers continue to behave the same" would be way less surprising.

Makes sense, I used your wording.

> Would it have made sense to split this out into a separate commit?

Yes, I think so. It is three patches now: add relative_url_gently(),
hide the credentials in its error message, and then use it in
bundle-uri.

> Wouldn't it make sense in this case to grep for the exact URL
> printed, as the intent is to verify that we print the correct one? At
> that point, we can probably just compare the full message.

Agreed, the test compares the whole message now.

Aniket
