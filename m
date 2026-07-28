Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2546B1A5B9E
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785239215; cv=pass; b=uDIZDy8orEom75Gj79ja4QY1cxU/zcgUTTPCWnJBArZNt37X+nlnkCR6THCxHgQdGSw/UegavQtF75ZnDFTcCsG7LLMwQdKNfPyKxGeu5WR6oeyi+wJsgdPGwEScL372vU7oorJEbDqiRgQzxecfW56PDmH4198urQ/dMm13Z04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785239215; c=relaxed/simple;
	bh=YH7f+haRh00pbHq8DeYdFywxv1dMpHjIWWkxstAHOHk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HVBK4epYHEBYChyou8VDwXgVMrMY5wK58SLXKeXIuQs/Gx5w0Tl2bbl+7YA3ak/XG0dJkLpCK3ACwvenwBlfPeYmc4kgI+8FzOKvlsWkHq83b34lY3eXSzrMi90TkCqsZcMy9Df4fx1bmBNGrQG/28KEuJvwozmXGx97mf71nCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6anFOVK; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6anFOVK"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so18336785e9.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 04:46:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785239212; cv=none;
        d=google.com; s=arc-20260327;
        b=H3gdmh4YwqscWNjJrk4s64zrxD+FK9YZUf+DhJC8OWA/9XYFpKiapWWa5CJWb2IhPr
         DQXB1mF7gMM9Adsx0ItZkp3lEPg4GP4N0RX1AFiLJN8eLEY6BYHRR4cfp4Uupsg+dTNM
         +AAg1zWEY94iiKSwXTbokM3xvVlzZco7RPzj1XgcFL49uY9wuUvou5gxHdxUgOzBfLWA
         gfXf8iw8AcNUAX4GoQhSCKEAbUtqfJMPysKAfl9d7uunKelyFtPTaGdflSBI+1D4zBmK
         Yb31whHWaI9NbgFohnctqLtMJb7ylgRbzh2Elz0YXq5dVR8tbxTu/ceyZwYHKFCnBOXh
         0YaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=YH7f+haRh00pbHq8DeYdFywxv1dMpHjIWWkxstAHOHk=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=WU+bFtlDqep4Lzr9W6RTKQAJChclWZG3Y43+y43R81pZ55KvT3DX2X2NZdtWkcTBEM
         ISjd2DZcGgKcMSrVwC5sUkR3GzqHkiEhTq9KlG9rtO86v5ehdrYN6G47xT90IBVXvdRr
         ElI+fGS7K778wm/VXlUg5+PVD/4ojPO7nzd3johwchl18l8WqTGHrnYGNWemn3eNLU5g
         c1o8+gLKo3V+RXg2pbVJ6XZrXosDtZPXwhLQqeIA8YdvGpLiIax7eNaH1UBemsCedLYB
         f2fpBBGWrtxzvoFumzjZGtGzg0/qtwnpSm2vweXdZQ7fevAbuQaG6KrgEWy51Yg/KaCX
         NOJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785239212; x=1785844012; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YH7f+haRh00pbHq8DeYdFywxv1dMpHjIWWkxstAHOHk=;
        b=V6anFOVKz7myOm2ScC33i9w9elHm7IaK8HEQy7+G/OzY2LOsA/02rYQoXCVypL3F/o
         lveDdDAjKv0iUbI/p5AmBko84HWS8x1hL/qup9mxfHfOcOGv6Lum79IAAWXuS03iRfl7
         6bS1Kwap5hxDvOB1EfmJWUtHxcodWBfkjwLc/b+VFzEWuu7NXzkPXeWjFAtlpcCSYzg8
         RN6qqaUFNR1WZ/phPwxqoIu9Kq0ogP0D1Wsz98FUjhHpmao9OZkmZhYHN/IWpLo9rgpW
         uFSDk+P4LB67daETMjBRh0ynqKrLS7COKKDq603NwyEVrScqo23tjQZ+n1lK8TbYetiQ
         KYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785239212; x=1785844012;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YH7f+haRh00pbHq8DeYdFywxv1dMpHjIWWkxstAHOHk=;
        b=Ssi+PdtD9hfxdUtjz0isslOu+BUVaOcklRVqqrOlVtF/UwEApdBfKC+/YDaMzZH2Ga
         X8HCDpo+tasJwCkULa3FOsK+kDSUE4ghrQZ75j93HKK9sPk1hnG0LA1F0anDteUy6c0T
         oaSp1TCPZX5sbaXyzTFiYORQ6dqLJjybO65iciFvpgc7QcRDBQKGewTkedv8hZVUhiy2
         RiZvOpB5f72p9rD2/vyf72hkSJsX9wxZYNDggw+9VWhk8lg53/F0763ffTkeCaQxzcOx
         mGhaGf7mb5HT5Af95HN6fzmSWppnG2HQKhS037QqlKFgurxT/dhcn6IWcn2GJVnI0Y6h
         4E6A==
X-Gm-Message-State: AOJu0Yyr5E++ciYNUZsYcw40rNGYGZmx2lEJlcsCCFOq4+DLDTINioZ6
	6a2vi+r18i1Gl0ax9hd7Qq/EtoOx5CcyEOhfYGJXn/uc5AnpQF8+67aXJVviTWx2eKgH1344H21
	q5QcjPR0/1kyM4A8u/pGWe/2UwSxwOEm4Wmu+
X-Gm-Gg: AR+sD10jXzoOySwC7JEP9fq81fmPlxb2Q2gV8P/oxixr9GnLIM15cnXcabpUKXELbIR
	TpJxC8337N0D8AdEPXbVFKn+CsAXqhlWOtzSIzMSubLu6Gqloml1M6+bUSc0eEYQCdixJGc+HTP
	Fg4if62STFLME7j3vgdLpQYMftlIsbXdw0zdmkZemMnJ4oIKGptre2drAzKV1kjuEpThd1WIyJe
	GSTWX3D04efJMqxT/Xtm8wrlLOP5kVENSJvpW34N9xWuzxXyIzXAFbOo5J0S5cjpZ8cXB+vpnfo
	UnrJGDhLGx90ZUCfxJfTXeoQpcRVsll6TYTPHBtVlFhnP6lmTXI1VHAQCn2VTQ==
X-Received: by 2002:a05:600c:c4b8:b0:495:665d:75df with SMTP id
 5b1f17b1804b1-496c658ee80mr24311055e9.23.1785239212129; Tue, 28 Jul 2026
 04:46:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: William Pursell <william.r.pursell@gmail.com>
Date: Tue, 28 Jul 2026 05:46:40 -0600
X-Gm-Features: AUfX_mx3k5ogvp8f2qBAdEQQ4fX-x4CEhYh4Ul0lz4_fqzfaUl4HPabUbnLBfBY
Message-ID: <CAJPQ5NbTLnbe_VU1awCVggw5m9kGdBZssrZBp8G0YxcMjb_rwA@mail.gmail.com>
Subject: Bug: Makefile ignores CARGO_TARGET_DIR
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The Makefile hardcodes the path to the Rust static library at line
962, but the cargo invocation at line 3036 does not override
CARGO_TARGET_DIR. (line numbers are relative to 9a0c4701)

When CARGO_TARGET_DIR is set in the environment, the link step fails:

clang: error: no such file or directory: 'target/release/libgitcore.a'
