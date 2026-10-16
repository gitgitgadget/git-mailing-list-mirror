Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E60E515880
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168145; cv=pass; b=Z7YdICIWCGMEeyXSSZHbfnjjTIeY7ZkTlERr94WXaZDQcV4ZAFD4ar87bO7FUyaWHSnduE18w2+PgMbEZuNQ3dSKhCVlm3GUoHmLSHqEp3v3ya4xMHQzFhztDRxYy2GkLzBAlCORY41nBdGTfoLx4+EE2ECe19iGfLKAcWtuL4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168145; c=relaxed/simple;
	bh=rtww9fZ3WG6t5BsnB5xcMdNyckN5REjUHgtzkwoym8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8SjzD9TDAbKsP48pavRd7DU39p6NEIhM79ZTId42yyQlrVlLDpdwk6RWIdPklc9Yfvy5ESNYwBJ77tYgN3IlzBWclyc8g+mf46g5UWZo7NSPQZlELx3AJXGPxh4Uidriw7nfzeb9htve9RbZnMs986+MaM+RS5ngQRHL040gH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=1cGikrNu; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="1cGikrNu"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6740e7ae219so189424d50.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 09:29:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792168140; cv=none;
        d=google.com; s=arc-20260327;
        b=imoei1BBTydaJuEAoi7i7Cxs8Ic0ywWSPIHbeAFV0jpzItNr8+dPH+LtlLnr6FSdMt
         q6g6turkGUjtSvkXx5ObD2fjbv5KNl/xs/pZnSQKTdVaKLjROMlynx6WppBboo7T308L
         8gYlATNN49nPsdXTI52hGKND5IImxUkHvgyghZCYE7T5BrV13NOjIK7lUDpPwCFY8pSl
         ZCl4ET9oy8y9cYdoOvhjuSahHAK0IYADh6/SwgaDc6AFIUgNJlwMkN0tvThiKg0UKACy
         Gw4FW1RliOhJfBFIvigWX+4AOaST8AKR1ocJxQdbTKZ/Uewp4G0ZG0rY1VVGg18GUshB
         KVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rtww9fZ3WG6t5BsnB5xcMdNyckN5REjUHgtzkwoym8M=;
        fh=jK7UZZpofpIKspIH3Ol31ZfjyJBrqyFlX/67pVjLfUE=;
        b=Rpa1OL8g6pvUu6rHqttGOxHEU6s73y0lF7C5KKEkiXAVbH0UaBjPnkfo4x3NX7eYVt
         ZDHvN8cFPzcZl3dzhswUyGwcr29Y5f7a1TW+e3bpIyDOqn/BcQh4d9jvyBVcz4lYtP3n
         2ePSfIlyeYKsGc4LgjaFpLXu3ID1ylUZZ2Ysze6cI7L7BGXKn9FCFtyDd+Lddf3u+47F
         13Ea+wibkqNr5fg8SY/M/Ig0zk6v2LcmFI3IDDsO2g59ld0g2TB4fLRK7VaoIeehHu+Q
         NE/3tacwl9tl/WrEm8XiIWNd0KVnoXC8VENTSMFFvL4w0XI9yjIk6mhWbwkYrpsnpB42
         uuCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1792168140; x=1792772940; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rtww9fZ3WG6t5BsnB5xcMdNyckN5REjUHgtzkwoym8M=;
        b=1cGikrNuU5Ku5SKAhD4xMxqsO5N0PRWNpouDdJZ6aELIHo4P4HBef3U9dPFsqHiVH3
         HBCdaUp+Ifa54CvZ/CwtBu3ib6ZV8F7pqa9agkqsx+SNGZH3MTf+L0XlnvVoayaGgaan
         dbV4PLIRTEOMLtSnFatIg2folmvpyw5rZx2BwBc7F0fa8FNOWlj44+Fa7yHVksmB4SlX
         gXnU/4/YoSelUE3DgApXaT3WkmgwMCqXcPSoomho2dfpYNWVIzrvTKlZyaB+OQB7xmQ5
         zlaPmofmu4cm8yWMjcNJwGgTRGAZrBCjsUzvBLltH4Ws2r2KYw4ItJD2qTqsvouwlOOL
         jCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792168140; x=1792772940;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rtww9fZ3WG6t5BsnB5xcMdNyckN5REjUHgtzkwoym8M=;
        b=LOTm++1MVA8DiyUidJLwJD8M+R/bzaNQJ/GLIawVLnkWnx0ADhWi6Dmr+JTE0fdsvl
         MqRgd2ITcPPBog7xVj/kPWuJIDSjLJWrts3oxVpTHu9niF5VgS6mTAVt91gKW68rNkQj
         Ivldju1aLHfEvPCFhlB6GNgArMFmjx7Gb9Pu+IW6XapP1R2TJCHR4bIllYYu3OQy7fIW
         T/jKqEo7JrRH5XilcVGRIODB+5wBnW18QukdfSK/cC0WdeHyDU/Hk7Y71U6MdVMDOKzc
         uQHjL0hcE+ChMQIxEQ8SYygMFSB1Hz9T9t0NJ4RVfJmGRxgiijVBTYsy10J4ZRX60/IX
         DP2w==
X-Forwarded-Encrypted: i=1; AKwUvBwcwpjkAuX3kx4Uc0VI/yiOhAL46z4tpiz6ZeyMlrf/lvhNaqhYHCZxKX/CZeS83AaX+Ug=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxfK9y5p2RS6GwdSzgV0OzgNreoUjQfxwdKhOipDQ6CFD4cdKI
	wLSK3BLAx8LUfBSwP7ASoo1CPHPYiLSJwrJeSqWszlhGgjZaWV+1+LOfW7ipmQX/8/4NH3YKhMA
	j8jn93U5KM3oFmnhWkUPaF9AG2zkRnotxl75vpuExy3WZXAUNgJUbENLNKA==
X-Gm-Gg: AYBFou2pHfE7zWMCqLF3fbwr+M6oCnvF6LRV+B9YtxKsQ99ywygzYoJQw1PrEjQmjWN
	v/HufKt3RFycBqyV+/ulTR4tPqiEwa0FP51Afgp6GeaYtV+BrkQ4l8LC4wgIXYEDIXxAeXr5I76
	sJWe8rUdUNpr6mx+O+yafGJioyoGaAi6UN/ycF6Gs9CS+leI6hwgOFrft6tpOUUz0bwQQuMKqdh
	3vxseTMFqQg6FKRJqzvdxo0HWvrdVVvGSjyO5K2OiH+uHGknboh1Sb30VsbQe0Ei54QDCSCwPNz
	4FfXbOhTxyWI0EtLZXt715zrwjNziFLtifuGtc5GqBqH6g+8MJM3DOMU01nO6DOV6hBMorZE8wC
	rM6lsrZXuA3g1vECxcwXBDgj9luEcGk+pW/FOiiQJQQoB/g==
X-Received: by 2002:a05:690e:1519:b0:677:af43:e258 with SMTP id
 956f58d0204a3-6793629ea83mr5222802d50.117.1792168139676; Fri, 16 Oct 2026
 09:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2261.git.1792154374653.gitgitgadget@gmail.com> <20261016142515.T1gr4%taahol@utu.fi>
In-Reply-To: <20261016142515.T1gr4%taahol@utu.fi>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Fri, 16 Oct 2026 18:28:48 +0200
X-Gm-Features: AclHuK-DP0SteqKLOtBgvdvlqrFsAZgqkfmW7MEsgYsnDo-SmhafoIPRPGgpB24
Message-ID: <CAA0xjtoyCjzjzNnoGdoA_o-TK9=nKK98mXEpE0y_jWJfah_Xow@mail.gmail.com>
Subject: Re: [PATCH] sideband: skip unrecognized allowControlCharacters keywords
To: Tuomas Ahola <taahol@utu.fi>
Cc: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Tuomas Ahola <taahol@utu.fi> wrote:
>> + value = end + !!*end;
>
> Reading CodingGuidelines, it seems that `!!` is a construct we would
> like to avoid:

I wrote it this way to match skip_prefix_in_csv() a few lines above,
which steps past the comma the same way:

*out = value + !!*value;

so the two places in this parser read alike. Happy to spell it out as a
conditional in a v2 if that's preferred, though.

Thomas
