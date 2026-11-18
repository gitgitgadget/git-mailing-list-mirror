Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794995296;
	b=QTi0ABM9qB+uV8am07bPPTZrulTXRdTq/tjFVvkN+pnJtEOGVLc3RxYb9PGRn4rFdkOp
	 qiK9Q00AYoNLXaY+1wvFHEUDjjnWs6R4X2EaUTpuzKtbdv5aMZ7Eq9BXT07kCIcbA+AvT
	 730fPUqNSll1oXWcAYqyzoorXyn0rfDsMFc8YSH7G8iACzg/RtCUn1wfTWc0HdDn5tE/U
	 Fy3n3GdrBArDxZRAjS8nRCaqJSipwL+8dVkBnzX63b6bJAPlZdcusPg2Ni5Aa0mYanOuo
	 0zvHN0OYSm17N6lbUVbeQHg155WUJXu6YIyl+wGyoY4vR+ZQXMsvEmgYAdEdi1QcUnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=XfkjgPf8YodKm/zrGIAG4DJ3V4w8iUo1rZxwCb1R3Rg=;
	b=ovfyhVAqifgobu/mwomT/82EpMvUgCMrZXzbcmhYz+5QhHYZcpC3eUlpTI02IoQ6lZN+
	 1Gqr0JHq9srT9mmwuhx+dJtHEYnfxjOH/BA/n4ZkLEr5/aQtQ++41I9Foag/CAuZe5leo
	 YQY9LsAFbQMOiqNRHN4BzWLkfb0cwHwoSh/7unLbnHCtMjgYF3Cr2GUJNOPhfX90bYERw
	 cF2Uk+x7rypMi/3gvvEfvW0/Pzobq78xeVNTJzvc55WQSxx8H1nPUhp/s6pYgLs9vQB5K
	 y6+ZkAUI/ffgvhzkCpNji/5r7tXlkgeYzJ/h7d3JK6zyoclOCmhpXtJrO560KT4Vpsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mCK89pLI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF67B606A32A
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 09:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF67B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mCK89pLI
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-702dedeb70dso498989eaf.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 01:48:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794995294; cv=none;
        d=google.com; s=arc-20260327;
        b=sNxfxGjVDQeRRjY1GjMZzwKpt9Q0B0fyQqaCkZwqy1T5rFir1cNfgm0xIIr7OQTUh4
         vQWUe8LWlE+UmiEF6GbWJPG6OaFd09+PsSW1Ly982NLMq6Dz4m1bW07Rw300uQiMu0gi
         2533M7RflFHUN7jLE6UuqzLbYoEdWb9hBdyMxqYBHGOKnjyv9mJ3y/ylSX6XvvJW8y3d
         8GqBRgffvEbLRZNGehoi3uq1foH0SAPcV35hLA/GVR+IcOhLbyCmtu5+ToQRYPwNSB2H
         bLZxRcy2I9xX8KkH0SrUHaXLawnX+deAuIHcoCdcTmewuFK+xtKdX3RE2ZAYBmvc7HSa
         PO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XfkjgPf8YodKm/zrGIAG4DJ3V4w8iUo1rZxwCb1R3Rg=;
        fh=2IlyFsyd85Qbk3PELn8sRXdX7GczWSx3201S+KHBLyw=;
        b=nDDsjcZgNj3noK5hPcF47UevK3KxzAnSM8B1Tw5rE6ufC4Otsd9Of9pMzYwTy+dKSm
         x4cc3KwIXT3Mno+Sb/Sw+FxLLP1iQ3FR1EvNVyknVVT88vSmtzUzozTlqyczcLzDOJJU
         NCufDcB68yw4UNnWGlhoC5O+bQ2q7Xw4YRP+0w1GBC3AQ7CgG4TeqA+sHxo11eg2kyoR
         Y/hKa5cYp9EkMxVpxER2nL8i3a4I1qAcUZnKhktUgEN4Hk/Vzsg6lszzCjMyE6z6+T+3
         6smcJqJnonAQLKlOvf4Ikd0IdmHLAA8W8oKX7GfzpZd5ptbngQZmdJOfuB0Tl6JGAPBF
         LwTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794995294; x=1795600094; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XfkjgPf8YodKm/zrGIAG4DJ3V4w8iUo1rZxwCb1R3Rg=;
        b=mCK89pLIjizyx3RVVlRZMZGQ2/z9A0KbsSHx7sl4xJbfIQZ2K+HpsbB+yaXuwm1lXv
         0X9tg9d4Q5sCoTEspGL7lydjKFrUm0md3wvsF2GC2QD6L/MxPLsJVLxSQNLDj1o5iZeV
         OW4S0DUTZ1xGaPbx8Pb3ZzkjXxz4nNDV0A2M9rHbUIrrAM8L9fdpbqlVZPhkM1gMYszJ
         yENUj+u9ugUo+UQGGF2chQt9vBVQWtAcGvCtLhp2yT5K1v/YIL9sTVZV/eE43ncW++PS
         eW/yeDsBBaauJU82BYyfVdKiQ7v2Gk3eKljEkxSpECPYZxyhD0jmUBQGVRZ+uYcBLKvW
         YUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794995294; x=1795600094;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XfkjgPf8YodKm/zrGIAG4DJ3V4w8iUo1rZxwCb1R3Rg=;
        b=A5R2XNXgmr7CuDUywxcX6C/T76ToGu2kiTSP5cxo/OZJ+qQXNN9ofCV0iAfu51A1f2
         W9eD+ZYViZyeN2jWTfU9ZIzRfq7fNvF66i6i0gHn30+MH6I3F5Li7peLKQP6ZyQUXJCf
         iIAyyNm/jLEDk0/4fGWiEzQqkfD7ZB2OIoUHHwh7/6wn+KlNs6Vyr7GpQquC2s3zjwbm
         1Sfwx0n1E1/ejhn0mVTl2UX76jkhRm9od9WPkQRT+bcxXHZw7QhSJEVIJZcX9y9cQ4AN
         VCCcRT8chcA4z42+ZBlqZFQDMvTueFF3J3norRfflhbLRJQEFVjzZeS5eCERC+UMqtdW
         QQjA==
X-Forwarded-Encrypted: i=1; AL+hErH3VfBzJ+dlGtyMz5btiI849wmw6iahNjEV0vQ7INGV9Vw6J8sMReqfx+8ru/ufGE7cAEU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BwqpHrAf97Eyoa188oyJn81l435k7tWs8ufYlMpxgFY43ig2a
	ZHnFuKSMPfayRMT4AIIBrofTGTdABldadVA2yc0xP182fHunvC+8yXTjWcYWnh1qESjxhSMV6Qi
	1SVn/LOENk4CYpiAqe6db15T2yepYNZI=
X-Gm-Gg: AYBFou1mRTQTp2dCPaWq/rkvqxZyMKvDEgeiQKMc7vMIPImtWeuQM8S1qwM0LGKLqL5
	SQibhNIB1HDwc4HdYURLn1P4RO8Ii9yuz8hXCiNRrfO9VC8ovg2PjmiDmBbL79ryf6p0iaYsIfi
	4jX54Ljl7BjtT88+7zkT8mJMD3wJhcVpd+L271sw4GRhddkhmvv2UaDO+JLw8hW7cvcJ3keS/Bc
	E7wk5sp5u3jWey5t6Kc9LADR3U2GbWh2FvdNMLOxgo4idAyzBqwn0KgUVSA/ALkKbQBvGduJCe0
	CXFNq6RMAaauc7iHOxFhBITHI060zXaJzrLccB7yo2Ina4joAJsqm2VpTptrBN0RihoE3lv/UQK
	ntmtz9v7xRNUvN9h4JiytuTYuWDFE69WxQCs=
X-Received: by 2002:a05:6820:f00e:b0:71a:f5df:270b with SMTP id
 006d021491bc7-71b18492122mr1607402eaf.32.1794995294239; Wed, 18 Nov 2026
 01:48:14 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <xmqqmrr7fllq.fsf@gitster.g> <xmqqqzgjcjes.fsf@gitster.g>
 <CAHWeT-Zt=1MjD=fbOiAiQtb28Q4DAR_wF12iymXmeXzGyyLgbQ@mail.gmail.com>
 <xmqq33szavmy.fsf@gitster.g> <CAHWeT-ZcOqm9PXzM5W18+ktJ4gBdPNyx+g_2ZCaW25ufKH4g5A@mail.gmail.com>
 <ghwlqak2j9.fsf@gouders.net>
In-Reply-To: <ghwlqak2j9.fsf@gouders.net>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Wed, 18 Nov 2026 09:48:02 +0000
X-Gm-Features: AclHuK_kKAlA1udfRDfdBG5vE-N9vNZ00LjogrtiCLaS4D_WPYNBoXALrC8FqbU
Message-ID: <CAHWeT-Yh8yTnG7rLjvO+XBtU=bZHJ3WWoQQsPfvJO013P2GSPA@mail.gmail.com>
Subject: Re: [PATCH v2] utf8: add display_mode_esc_sequence_len_counted()
To: Dirk Gouders <dirk@gouders.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dirk Gouders <wrote:
>
> On Wed, Nov 18 2026, Andy Koppe wrote:
>
> > Junio C Hamano wrote:
> >>
> >> Andy Koppe <andy.koppe@gmail.com> writes:
> >>
> >> > Junio C Hamano wrote:
> >> >
> >> >> -       while (isdigit(*p) || *p == ';')
> >> >> +       while (p < end && (isdigit(*p) || *p == ';'))
> >> >
> >> > While you're there, could you add colons (':') to that?
> >>
> >> Do we generate such a sequence that uses subseparators?
> >>
> >> IIRC, this code is not counting the display width of end-user
> >> supplied string.  Rather, it gets string we paint in a buffer and
> >> then counts how much display column it occupies.
> >
> > You're right that Git itself doesn't generate them (although future
> > enhancements might change that).
> >
> > However, display_mode_esc_sequence_len() already operates on expanded
> > custom formats and message text, e.g. in rewrap_message_tail() via
> > strbuf_wrap(). And on stdin in git-column. They could all contain SGR
> > sequences with colons, whose width currently isn't ignored as
> > intended. (And my proposed make_line_colors_self_contained() wouldn't
> > reset or replay them.)
> >
> > The check could be changed to `*p >= '0' && *p<=';'` to cheaply include colons.
>
> I would suggest to not mix these changes simply for bisection purposes.

Fair, and there's testing work as well of course. It was silly of me
to suggest just sneaking that change in.

> And as far as I know, we would need an FSM to identify valid sequences
> if we are going to allow colons.

No. The parameter field can be any mix of digits, colons and
semicolons. Semicolons separate parameters, colons separate
subparameters, and individual (sub)parameters can be empty, which is
equivalent to zero. If the field consists of nothing but colons,
that's one parameter with multiple empty subparameters.

Whether any particular SGR sequence means anything to a terminal is
another matter of course, but git doesn't try to determine that for
colon-less sequences either, and nor should it. Well-behaved terminals
ignore valid sequences they don't understand.

Andy
