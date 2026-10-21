Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792618624;
	b=bqEoPJu9IRKOyG/p9Ei3qZfEuhFjIBN/wAa2L4adAmK8K/+CNclx04oTJtoFKB38iCOC
	 AZodxn1cZ5i0jq5R3q7K8vO7QqnjXKgO/GY2mv9dAEa306Yd13lleFz8jxCB/z0pG7DlL
	 sVGRTEFoUlS3ggauI+/Yo6LSV3Wy1ZIjWwhey5/JS5NxTmGmlBYSuiPfDlDD7Lpe9+pR5
	 aQYh627hMVhXHDBfytoBSSBqUVUDSZbS0mrRjwHpLco6Gf3mCSdGGo04cGYItzx5PcAq1
	 76ZGyq0J7BW/mA30eT6Btcxn/a3/yX0ywxOZlhTqBW/PdS9WPtHeT4oYh/JKlUA+RXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=68u0JJOlvn2qCj5FcMz1Xn2CQAoqAyR+WwJR37MXZnY=;
	b=tLnHpHscil9pk6ym1clTFQwiO6pmRqaF7EbRgUz0CpsVObemjrvjY9juXYZilkD8ANYE
	 bVuoY8UzZlSzfzCDR23gIL5M7+43UwCNvqHfO6JPDu7kznMLRBjXr3snATnu+yd450R78
	 PtlcYhIrh3u5+n4lEpbH5cM84GfbiChuWDIW4B+vt2Wsq7Yv6ZSwEuqLF9kyIM7/lRbcb
	 ChgAJ5h5yvVPbjlFmApe9bKbgkJLcTFblit7oR0oxphwWYw7emMuAdZ7B9RR2wbl5d0ZA
	 oXjDpBqYv9+dQKEXN6Qtugb/29rKwNsgxsey845P8b99dzb2RRaNpJJ+BcaqRxvx9Bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G5jVqXDo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0FC606A320
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 21:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB0FC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G5jVqXDo
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1f4d8e09aso1792739a12.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 14:37:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792618622; cv=none;
        d=google.com; s=arc-20260327;
        b=kLunPmEFFAV7Fzy7JPKErgSIJL+Ej35h15MsTLPL9QEYiPNUhC/zlFoOVgSWfUtRi3
         7Pavw0hcUN+v/4sGmuKkUuD9Z3qqvMq5/Im8fmpOg0KdApwaudDu3Teo+B8CuGivb3tu
         MgiQ6jYQjA7NRR/lA8iyLxorNhmzBOKHi2otN6E+IA+3iDZ7N7XR3UYy01djBI4SzYu3
         h9ekWSejaLs/ZSbOGMyg+vR7i6QDgvvNaVF9D+gkF3aCoAvf/7qKBs52ZVwOQ1iwE8Kk
         zBNtsqJo0gfNsykHNnkD9uREyV+Hx5SiaPM4kSmlI8SZPngkO8rl5DqmtoIcxKahwMpE
         Ox9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=68u0JJOlvn2qCj5FcMz1Xn2CQAoqAyR+WwJR37MXZnY=;
        fh=a5uvVUzPOBFrep7FUYkGjAd6Tw8uE8ws7GfDpRPYO2A=;
        b=rMzyeCzt9pbEYgzmFtpb4tinS3PZwcStXU2fdZ0gbrD33iijlGqa6FnhRibyGSJpES
         cjhJS6BqhgoTuoCvtQ4YVzZY4Fc7vjNmowD+/6d2ZBJ6+zIfD1oNf7PuF10XmLzy8mgb
         NV6O+eesmk9n2Nze4FZg3Y3jYlnqbGLgEISVru+1xy+DfxMgRnkSl9h27VGQcRCStjv4
         2GBbIt7kjJfkpv1NUXS2ko+XMrKayoT5DLmcFksWjA2xJuRGq5NedzFaZqS0jSC03JIS
         wo/uzetONlY4GTo18tmzduT9W0XmkWE0Si+Ux+bqOOAdNSaovZwxDC7V3nlGkSWma5fF
         gruw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792618622; x=1793223422; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=68u0JJOlvn2qCj5FcMz1Xn2CQAoqAyR+WwJR37MXZnY=;
        b=G5jVqXDoUVK4c9qA2Ne3j3Tc33h/t7QcH4/AlWk6Li1RLJX5+oe/BJdNwkF7QTOMya
         MEXyAmIgSkRLzruW6qZUqtfdy1M/URSj/CY73VhwT4o8V31ziyruI/OC/3kfGZCjdG/C
         4oAKQEqEh5vKclZkmqZzY2lXv4+ea8PxUYzIYUeMV2wGdG+6hnEQ2BH7Exk/GL9ww+/N
         aFvp/Dr0EInbubbowd4JoxUl+TsJLmbqd3Xrbju7+RUJqWygnK/IMOF774A0pXd33Qrz
         HchSF/ySOavo0m0TCYO7lwrLCJ62+v8szj7ezpLE0Ek5zDSADcbKqmU4lP94C+JA0Cfo
         KzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792618622; x=1793223422;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=68u0JJOlvn2qCj5FcMz1Xn2CQAoqAyR+WwJR37MXZnY=;
        b=qui7K9P8n5AbT5WSBE+u2//GMFCQ5Wh2rca4zV6OI2qmlNyyrNdm0HkLVyYIgooXCc
         YS9thVtJraH7lLl1EtdmyPf6OgofG7Y06yMhzxkkMi34S7Xps+WV5sXzMXq77JreDUb9
         DqW/XCOnBuAusRGiWJb/8y/30dQJMDqBWv/iICAPFduMyZIaMJoWC4IV3QGWdxsojlPa
         BHP79VyKUGnPfsPffmHX3YJZi3u/iL+nGfvBVp8JBE+HCfMgf3yUdiECYYbhXzTvTX9t
         H6cnGIdjGLo2MktooLkNiDZhtA2DVILRHeATauTnlFv5Tpps090PMVVUUTZjc5lemL4Q
         uYOQ==
X-Gm-Message-State: AFq9FYJ+AA/yZxAplngCauyelqAwQVZsYzIQxAwOfd9G6d6yOYjpU2/m
	W9djGY7iY9K3WE5vS5rQoP4fjwVKlY6HE8/BIsS9xz3ipDbHdciGlkJEZ8HvWqGumW+cjzH9PI3
	iP8jzfN9zksesFTVqMMV4D1285YkFC8jC7e3YLxI=
X-Gm-Gg: AYBFou1FnF0k6UOEVJYl/aszJ4ry10TjXnLlNi6Q2QA5n2rgG+AxzrHUk3v8RldYEJq
	2qb+0yqW3F6hXawQTlV80CYJ9B2JgcaCS3jQ9vMvIp7QeOMkgIb9xaaQtmZSDfB3b8/lpaoMsJR
	vBW2sWgcpFxy1rUAUiResTTwzFfTH/d9OJkeRW7ONjgFpEGwpNz1PyOSde2weiKxPQRGINrFElc
	HIS3q8wPSOXOU5IqtFfLkFgVtyqoJ3uYGN7iEnyPA+jRxs2MMQYEpk4wZiA/EDmkPmnKZ0kvwxX
	g+gWyPk3Zw55wevCUBPcATC0jio6V+5RNxaeffyoONppB9ZxJxysh1Sfx1GPPYX2bOhwf6T/Zhf
	DHMwLtAqCBzOdL7HrVd8omIgKCYOLY+FmwZ81
X-Received: by 2002:a05:6402:400c:b0:6b3:cbe9:7231 with SMTP id
 4fb4d7f45d1cf-6b408dcc2c1mr2288079a12.5.1792618622119; Wed, 21 Oct 2026
 14:37:02 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021173350.67854-1-me@jaspermayone.com>
In-Reply-To: <20261021173350.67854-1-me@jaspermayone.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 21 Oct 2026 23:36:25 +0200
X-Gm-Features: AclHuK8EAw22bhw93jHt4WGtl2eBdJXiBH04SXCkKKvfVMIYJ_LJ6FD44EWrzVA
Message-ID: <CAHwyqnXC6--wTx0Mkj9r-9oj4R6ndubjzcucym8y3Hs9CKYfVw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] worktree list: add --merged and --no-merged
To: Jasper Mayone <me@jaspermayone.com>
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com, 
	ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"

I wonder if we should relax (or allow relaxing) the requirements on
worktree branches overall?

I noticed that I can't check out a branch that is checked out in
another worktree. Which seems a bit ridiculous because two regular
repos of the same upstream would never enforce that.

AI loves worktress, so I suspect we'll see more of these discussions
in the future.


Harald
