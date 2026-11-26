Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795690846;
	b=rUnrkRhetkiOOm1Il/lJBzHwyptHWCY608NE6lft9rOpdXvRkrpvQgwfYYi84ECtGOrh
	 O3AQyUKrarpLm9Xc50juNZdvFsvdLmOzGomdaAVNO5/MNeJko6wojpVlqQxFJQKZfC9ez
	 LteC0RZGc0/A68hAlpdZeltLP0oAi/HbfejR/BpDyWKhSZl316tGRDDPnwyhMZqtHmRyY
	 5QqlO2xPUB6z8PaJRQEKq2vgdE1oCEdbT4suJ3F7ZoDis0QjoSc8cKy0EMrAC1Ennewp8
	 4t5Y/XtgfQZj689hB8Byl6mw/szCdDcGr3sr1Q6jT5HFaWUQWzTxa/So9UsuWgy6t6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795690846;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QFYq/H1EhhGzgOj53Ivz+Jsh7aK8AnBq2IALWl7J+d0=;
	b=ntaPyh9RVA9FgT+uZWhow8p3dnikSSxykThJwc9bUN9a5UeT5LrooFk9BZI8EIVj5cev
	 /FQJt+brEkZhRAoCwM0homCTP1pJnL0Gs/vW4gyA5dcnUFSs/3ML5M265ZbP4HcbIHMi3
	 7wKCAN0AtxIYMIhfOpv+9Nx3pL6BLa8TIxG49yyF99Sjo/8DJz5Uv1JgB14JbeXldYkNY
	 GwuGUNYAb292inKhjXAtEMVJsIWqBUy4oavDkm9XqUfz1I9a9wtRXBmWG5FP9jdOxlJgh
	 ZjDSStX9oXnRST3/+I8KFsaeRRzwJT84b1RaUEz96+4I3IoCx9+CYkl2hS82kkcSlzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OXDicudq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B70606A339
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 11:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4B70606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OXDicudq
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3ae6a0ffb55so60442751fa.2
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 03:00:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795690844; cv=none;
        d=google.com; s=arc-20260327;
        b=oEQcimN4EA06ZWtTPHKLV/6bPucv5TFeRPejedtyVvhLlY4HBL3SjSuY9S984Lv3yF
         +1U+UmFUuGwmoIvaKvOpJKbI5V8Rz++0qbX4Rs/bc4Go5Q9dwGEVRw9n6RhlsAeXnOO6
         NtnOYDSDFQ+7s/gD7fd/Pi0fGqGjJXTQ38zksCoBsxnUPraAqHYkULc0p4Y+EJel85+J
         bxzXxeu0fPYIHaJigh8yVPZKlg9w3IoYUZWf/XZl3eTYcmrbOSiGRSLr7Hv2l08HGToL
         b/+3BrL0ZD+5o1dzYLV8ulVnL4w1c49XszJuPjYGYTGKEhImtr8AJEtphFGPwFp2Z+Hx
         LePQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QFYq/H1EhhGzgOj53Ivz+Jsh7aK8AnBq2IALWl7J+d0=;
        fh=VA95SB+PL63iGWaSIYDPqQpPc3kOZTnbTon6mrhsAsE=;
        b=pDs0f5LQbPhhgXvw37hwruW51CLzUYIFbzcdCHC9xLHlonVNH2jIH7gqtfK7O2OwD9
         /weytGUNgy/sT+5NDi6RptKPFsY9NSmiAhZVvGe27UUfp5rCYoGgotJDFlYmL44yMdeM
         /M396YdqBSFW/Io3LnJf4HCwa54oR26t1r0ObV3Q1zkXcMYMFMBs3Yfce7rp1I76sVuE
         8FC44wdqche9mPbDiSVLipIUFZbcDzIppbTTVjxt3jBL/EAhSeLqg6H/pwcag8fiylMd
         xy/FAuMo5amAVZNC+cUZZrdhn6jJ8fr4nYtWJLPB6nPtNgoXzMtdkY0nUcPcrvsZ1fxE
         f8Dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795690844; x=1796295644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QFYq/H1EhhGzgOj53Ivz+Jsh7aK8AnBq2IALWl7J+d0=;
        b=OXDicudqfLebQV9msDkI/b6Sy3E7WWzM+Dm/BRUioty1Inl6Kj3eCQBvZyhZg0+c7l
         esyfQ8E9G8627X74KR89/Y8RsjgbzOPsSDPHrllsbRugo7LQk6exVeh9iy/K6Jyg91R6
         kWnBg0+7RWthqNSUvvM7T9FTpj99CoQFP1+22Wv7KDHg0F9E5v0B67l0ovhY8eoVevbI
         ddQ3jDfXdqGyGw3LzYd/yBFlTNy8qFk44XIHh7rqgBTrnFC7CtbAyHv8vFh57bA1msH9
         +zuWVsu3bsZ6Q41+fboNz5mA4dV/8ddw5gawlnzA3qp2TapT6Kpxe+n/TarUMaIXD+WN
         VDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795690844; x=1796295644;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QFYq/H1EhhGzgOj53Ivz+Jsh7aK8AnBq2IALWl7J+d0=;
        b=NKhQwdznQ1HWDqhW0vjM5P6CCscCy6QbqjtqyGwkuA3DPrhn2K9CxIMoLdz092hOYw
         bEZngMsylbad6aCUUAVnE1gsSdowUMKB7zdzy8fv+zqF3zYPZFC43w/H+dOOevLD/BVW
         k25YHMtYAj7TEldYKYftHSUn89kVE/HsntmDg9qHGZGvEeXuvRT2iFGws3jM1zQu57O3
         +8M7u6fAZYfcEYtz8a6EbxkthBzB82sX02SKw9Fhrh+BeAa2EuGXtiYDF9h/O5fodp3S
         XegnpT1yzMyaGJs6+HlLjkw0s6Az+qy7xewrXgspdK8aYZpGPv8mtnU3OK3J7aFmeAKp
         tQ0w==
X-Forwarded-Encrypted: i=1; AL+hErFYOypxbdy9fNELGlWIUccu5ImmHetmojN0FyFaKgazcVy39Ydc1yTxs7jACB/SiyCELBk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Hc1gMpxJXEJobaW8gPuEigDyHm4zgfWWzroVwpf1qLpMb9Z9q
	w61jLrMm2XcTY4A9Wh8OdUJVz0pmCcjhn6TYqU0hpBcFmiYW7MREQBfAs9Kq1UFbCOR+o4V9NgZ
	kpymJVmP7Rc+RD4mw1XvP0I7VZpuNEcs=
X-Gm-Gg: AZFdTZdZA841mt4uvGkm5AEDt9PLdxrOOfCO+jyLtL18yzxTXEN6d4rQioCblYUj1DM
	igZmjLyqd/3fZi7j1aGDAoOwOA/pV3NYObA3Z3n2BomO2ixy/QPayuSKwE9xaSif9TXli5NE/py
	5/Kf3tGvYervu3HPtKyRyk/R/d6ibaWBHS/nP9A/qx+aA+FP0G7BxbcQq3TMlnb12iVaDcmQvrG
	Eu1eb5qnpvYPQInfwmCXblB4N3fjHBbDzN6AMx0xdDDa2JJo+A7Hiejf8gCv70Ic+ZTdJdDY57q
	lqQxb+EIyqIGgQTvUp7BYo8kXI5xJUClsEzy/ZlJpvGOIL2CSlIUb2FN2ZRY/rLMvRmBffmFNuE
	CbTWup294nk8aNkbEThtQh8B1SaNbOdkCwT7Stg==
X-Received: by 2002:a05:651c:a32f:b0:3ab:3f1c:c2c7 with SMTP id
 38308e7fff4ca-3ae7f7cd209mr60895201fa.0.1795690843701; Thu, 26 Nov 2026
 03:00:43 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119192307.2683812-1-dmnk@google.com> <20261124180556.69724-1-dmnk@google.com>
 <xmqqtsl3op3h.fsf@gitster.g>
In-Reply-To: <xmqqtsl3op3h.fsf@gitster.g>
From: Chris Torek <chris.torek@gmail.com>
Date: Thu, 26 Nov 2026 03:00:31 -0800
X-Gm-Features: Aa3M54pHZluGSAlyV1fqGKdB4t6iIArHoV136vo1ROSjmSMDtCzHwRPhHATe-ws
Message-ID: <CAPx1Gve7tLsHpAkNx4Ofi=Hi+aQ3ZCOBfX=3Lh48UBrP1SO13w@mail.gmail.com>
Subject: Re: [PATCH v2] config: skip continued lines when matching section
To: Junio C Hamano <gitster@pobox.com>
Cc: Dominik Maier <dmnk@google.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, dmnk+artist@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 2:37=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> That sums up the mismatch cleanly.  Because git_parse_source() already
> treats a trailing backslash on a value line as continuing onto the next
> line, keeping repo_config_copy_or_rename_section_in_file() in sync fixes
> a real corruption bug for remove, rename, and copy operations without
> changing how config files are read.

Right.

There are some peculiarities though, as I found out when I was trying
to pin down the very-precise behavior of config files. (In particular,
"git config set" when there are "include" directives, or implied
git-config-set operations by git operating on .git/config ...
misbehave when the values in question are actually found inside an
included config. Brian, I think, noted that some people are actually
using include directives here. Perhaps Git could note and warn/fail if
they cannot be updated.)

> This matches get_next_char() in config.c, which only collapses a '\r'
> followed by '\n' into '\n' and otherwise passes bare '\r' through as
> part of a subsection name or value.

Although it's invalid as a subsection name except inside quotes. That
whole "[sec.tion.name]" backwards compat thing... Anyway, I'm not sure
there's any actual value to a literal carriage return inside the
quoted part of a section name, but it's allowed!

> We allow a backslash to escape any single letter, and this can be used
> to escape a double quote that is a part of the second level variable
> name.  But we reject
>
>         [foo "bar\
>         ... anything here ...
>
> i.e., backslash and then end of line.

Yes, this isn't valid in section headers. Which I think is a little
inconsistent, but that's how it does work...

> Tracking *in_quote across continued lines makes sure '#' and ';' inside
> a quoted multi-line value do not prematurely clear *continued, while an
> invalid escape or a bare '\r' after '\' resets both flags just as
> parse_value() rejects them.  Tricky.

This one surprised me, because based on that code, I initially thought:

    [sec "tion"]
        var =3D "quoted
     value"

would therefore be valid, but it's not: you really do need the
backslash at the end of the continued line, even if in quotes.

Chris
