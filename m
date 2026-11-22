Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795332315;
	b=Z4HOnzxvG5/gl3n6puw1PipL12Tq7xoleUj9+iUvR0/XEPFIczaj75tuxi2HK7hQUwcQ
	 zSJVv2ok3Kqvo7b16PGvsH6ekDQT15FjtxgI0G0sUTaBDCksao2kA7FFgXXdqzjvJ8Nvm
	 rpW8GP990bJtWFWDfaDOEVZi8A17/DVmLGKB0pJNdXrxfOrs18M8py21EjoFKO0eu0yHo
	 vZLOXXJDXPkudM1vRIQqss/SvYWHAjk1FdV7g8TO22SAdETxg/5nxm1r5luhn3wbdeEsJ
	 xYjU/fERpJgCiWC5GfyXVHRj0Wa0tySgjwVKnjSWSGpfcJDVWYFaPM2nRtwK3QwzIXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795332315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=ZKIvzdeq1JRgwfTzjzovP/E0QMysT3V0OsO/HZlWTb0=;
	b=U3yEi/A981CjX8GoSVH/s1KhXcAfBDRypqyF+SFzifBfHznFlc0Qmf2guSaWgTxMMMUM
	 Zys6DbmPZHiTTmBdCPQLARMyMp9XCUx3JHxNQZ4mM56sPSehA1DPXYDDc1gWWo107qntq
	 oxJXRQ0AgFhfxuWuUFbaHaosbadVu16tHv/7OU53GJYfMX/EId+qInISeurFx3Vy0IgpB
	 kO4hw0oyQVyROnyTDWHEz/EJgv7GyXrU0/a3LPQgIjWPw+/U8E26MX9bBBa4h492a67ZQ
	 G47m6reDq25oUSB5NLR8VOt2PmSU2ygwUi+FLMBGUDNxuFzPmXKj0oUqeDjOQZ8zn7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ygE6TuDp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618D0606A32A
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 07:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 618D0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ygE6TuDp
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-843b6f8e2c7so2360569a34.1
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 23:25:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795332314; cv=none;
        d=google.com; s=arc-20260327;
        b=UY2WOJpnpymk3dEe0WRDpGcA/upWWbOlJ2/NVIohQdCw4tGoLaFjL8VYQ3q/Bl3Vc0
         /k66NufnMamueZ2sMuVHmzO7NUAAbh4nDOh8V4XPySs/TvEqoWdevXDjvH+i/w9Gsp0Q
         sld4TrhR2G0dbEJjtyJxPBk92dzLVs3JkTmYrrPDX1+YWaq+d7+HgrBTKDT/DkjqEeXK
         6htAssowlGlNHt3w3koUr3jw1OXDKhHHHaKs2WKt+cBzKw17E+B8QRWYBuh8RPYyJAZP
         pHG4Xji9AfbQ07Sc0nq1ZBiniSrIYSv3Mwytm8H5ukV1k4JdupX4Wlg3QfB6dBYoc//N
         PXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZKIvzdeq1JRgwfTzjzovP/E0QMysT3V0OsO/HZlWTb0=;
        fh=azt8TgWTl01NptQZMw9NPhZWceF2SXJbJqFTBR6uZLs=;
        b=BP4tTdSnFRI/imZfs8hw8U6bLDVcoKIC3Qhl5I08i8bRPZXtA3uNHpOgQ7N4URkuEV
         3cq7AybpYGnf4evVBObtkPgr4MK1rizd3Z/SAE9oxXd2Gh8/ls8FkJEIQQVf7lzDFRgG
         2KYGJgdA6mLUUxOj7mFRcsaq595YpERmXL2voG+pTFtxpVxlKKFFj9Q9ZWHNW3ZpxXkE
         WksZseIJYpd6wRsYiz0nzTwO3Qzi8tL6qJGKrUobB4o9qo80/Wr+DymDx/JCuxhdxKbJ
         Hba2y0JO9VvX+fagmoLcTQVOaDX6liGeHsQU3aIW5CkHgwm9j1qa+9gneJRvKwQjiwJk
         jm7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795332314; x=1795937114; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZKIvzdeq1JRgwfTzjzovP/E0QMysT3V0OsO/HZlWTb0=;
        b=ygE6TuDpO9XziNAsZSowIKWoHJ8VdC6z8cC3ZFcmmsiNOg77sE5nvWaxjxYW0TWNdX
         R3Cn0xCTEd0M8NwE8lNaKCD9m9jbgYw6dxv5XNDH6FyKE9L1snc4br8DJEB39fn+ukKv
         9kweTqPpefU2boaGDlaUOAVGL/j0eal4lNo7bB6zPAi3LbSvb3WZnc5Tei2rQZHAb+3s
         JplpUQxl7hvUzFYZ/RUfDHPd8gErX/jo2DDFtxReO6M/Nwk01Mg2ltpmhlAZZKYc1R/S
         tx5na6cWjEylFWpMZJxaF0L3/uolL00P9EPy7A90tbETpvOESbzWjNlq1hiV9Qe6c1LY
         HsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795332314; x=1795937114;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZKIvzdeq1JRgwfTzjzovP/E0QMysT3V0OsO/HZlWTb0=;
        b=2KmL664lP5I+Eijj8iSMd77OISUhHcDKhxZXMYZEI0gLd2DADmvhwkYMsQ52BoBipp
         AjvorwaUYUSthU1MQnzBZoGcEKVkA/PGuMEN+iAzNVQdeGUjlUIeT9+glviXl/Ai820Z
         vg4N/GLEXbMQtAyjbGYrpBGvpBcTorXQ8i+P1JdqL7w7C32dxaqCW20//w3HnPGLFABQ
         wYRhOJ4wQxvZMaCfAjndtVcHz0j4ncI6r7FLRlGQ3uYg4zty43ZzBG2nAXnc5jpNwPaq
         Bm5JdYEiKkBHOtu/o60gPwX00ykIuPB/KGSWELJ3zDZwidR+DhbyaTi+ymTTHWZCUfCR
         WcrA==
X-Gm-Message-State: APuU4Z/5ZQiz22TUTdKtRUD0w9ASdD3e5M9aoAnK6/APZJHYWtiSSEOm
	UlkBCPEh2gdjIfMO9pAlg61/ClWtbYes9srgvZzMwsJZYffGcw9h4hhvgH2Kzfbkd9W2CvPL/Lt
	C+nMyduL6OnW4i/Aw81ZGGKbciIe8iDI=
X-Gm-Gg: AZFdTZeXoIRH8iAlN5MKRNe1deXF2OhskBz6JBSwelruaECbwCSsv2jI5puukJMHEr/
	ohB1svQcaETFC6HkGtJArEpXYEgym/XRJtyvBf/c1CGB2+D8nJpYRmT8Anvzh+e8U3b9+95dt73
	5JNPJNc9daJZdk6qmpWesHUtRkUtx/G0lb19//8NI1egkFyzyFanfGGFe5x28q4gskE9P0PMKHC
	ddc0Bxz6aUoZuSX0yucVrFziiwCptGzTCbGGIQylRuNLRwksRR/UTVwi1xpJ+hNKXeeHYVa6dPK
	G6GPcRRXDFv8CCVXnKhdPjLwtCwpgqAFHtejwJytO7tknFfJpMLrlmq/Zgcip5KVJr9omCWBAiO
	8nXA3Xf9iHOrJ3h+WoBHN62btkJ+/MqKMBt4=
X-Received: by 2002:a05:6830:4424:b0:862:ae69:12b5 with SMTP id
 46e09a7af769-86315aa555emr8812879a34.26.1795332314282; Sat, 21 Nov 2026
 23:25:14 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120-master-v4-0-5ff523db7285@gouders.net> <20261120-master-v4-1-5ff523db7285@gouders.net>
In-Reply-To: <20261120-master-v4-1-5ff523db7285@gouders.net>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Sun, 22 Nov 2026 07:25:02 +0000
X-Gm-Features: Aa3M54pP4CWC2BTPaJ3CYMZ2FxEbYEuJZpp3-N6NO-P1eQcf4dc2Zr95xnU4cDg
Message-ID: <CAHWeT-bkoGXYRv3hWTB1LhGctVF9gcQO5cw_+nz4gXosCywwEg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] utf8: introduce bounds for display_mode_esc_sequence_len()
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Nov 2026 at 15:11, Dirk Gouders wrote:
> +void test_utf8_ansi__sgr_len_end_ptr(void)
> +{
> +       char *sgr_1 = (char *)"\033[m";
> +       char *sgr_2 = (char *)"\033[31m";
> +       char *sgr_3 = (char *)"\033[31;m";
> +       char *sgr_4 = (char *)"\033[31;0m";
> +
> +       cl_assert_equal_i(0, display_mode_esc_sequence_len("", ""));

Strictly speaking, that's undefined behaviour, because it makes
display_mode_esc_sequence_len() compare pointers to different objects.
In practice, the compiler will pass a pointer to the same empty string
for both arguments, but the test should not rely on that.

> +       cl_assert_equal_i(6, display_mode_esc_sequence_len(sgr_3, sgr_3 + sizeof(sgr_3) - 1));
> +       cl_assert_equal_i(7, display_mode_esc_sequence_len(sgr_4, sgr_4 + sizeof(sgr_4) - 1));

Those sizeofs return the sizes of the pointers rather than the strings
as intended. (And the lines are a bit long.)

Andy
