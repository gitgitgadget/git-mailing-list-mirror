Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795759574;
	b=vYBKm5acxCS54aSJDzsl2guJRP8PrzZhDW1G/TPdlpHmsQHZL+18/N02Oj7asxQhGbH3
	 +4TY35CFCvlCcH6B9rSTuecbaIp8mGXzBsOn5uYZ6O0smI1aRbLG5FGYIG24EhUGUOqlz
	 HLk8dVmWwpVubpwsrzWys7dfZe39UeZZVLVvmJXU9E6df6PWI746nIzO6nSkj5PLQeOK3
	 1x0vtzn+6MpWZ+Eq5xYMLBYbN59zMGHa4+rZxUe911n1dV6BZ3aurf7uljB+B30R51OtO
	 +D9RiVfaYMgX7zeAFtqfGUE9ld3ycs7C1lemMo1SzxUWgO973KXwuXxwv+WiMPSZJ6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795759574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MbYoT7KQY4UzFEVC933i7Z1fV6EeAwPt6xNe+N74urI=;
	b=MFzparbDdgJPdA6WhnGmAVEC5k36ugwJuuZ3H1apCXojX3r61HnY2JWSnUP9sjPcQv4h
	 TemmQfueg2NqMin9tMTKvaxCQzBQrSdw9mWYvVDQ0VkSO9Guvjd5Ng4AXlS5l93blxvLN
	 r3tjpXZFWwxMfWngsitJXodH+NHDJlG6iWqj1EVRYhfYnXrc3mg+UFvji45SeVru/1XBy
	 dpGmGeIOIpwH4ar+GpKGr3zDrdJHi5Mm9oOglDzrrL2/YuThlm2Tf/EuegLRrlVno+6Fn
	 PpcUy0nArFhv9qW+qNGc5bQKzgjV6VfQLagC9+cNdI6MHaP3ng6Gv8RmJkEHKzlF+yQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aajIjjm2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05A6606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 06:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F05A6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aajIjjm2
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5be4fea434bso7577667e87.1
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 22:06:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795759572; cv=none;
        d=google.com; s=arc-20260327;
        b=oDjNL8A51N+VTFdz0/qtM/WW5JQycct/EvJM2m0IOSWohQWF518pZN7tL6N4VK3nvE
         2sKU4HV5WuCoUTpb48G5YMEkacITlik5KpZ/GdNC0euAYLNNqhtcLX+2EqKQ6Ml4cWa1
         s+hi5oG0YfqeGEKZQ0Xt7HG9VSBVdc7W2YiXWpeB74Ekx6Ot3XOoaMlECwSTNTknkQct
         4hW9u9PHteNF2lmV+0KWKkTd0xFKo5V2MKxcAcyZ7kHSs3Dbjz3SolDqrnok9WB9j5F7
         youHFzICPPuurJLV0j6Pv1atdhw5TjSztF5UrfY0KzwXxtqu5Z0oi0eONQdKAFOHaXkT
         ZjMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MbYoT7KQY4UzFEVC933i7Z1fV6EeAwPt6xNe+N74urI=;
        fh=psBW2Knbj406zdabrElMwsX9K8L5dCF8+x5DCZujN00=;
        b=XR7BZiGdglOXYxGaeAdsp0QkqHKllq7VxnisDCP3DJVnXGqT7GNcO3JY6siBKewGFH
         swCCpHI6fsbulsAlRxG8kcu6++Sp05ERXoK4UVO/1W2GA+5Aq14MdMY5XxE6Cuc45jn0
         eB16kiBXOBU1v61JTNP8cyBKCe/DHlw1HoJhfc101NYYJMR1AaBX/94NbMsyWzLZ7y6t
         Id/LNM1bkt7qw9EVvMgfCHQ1svq0fUEXdYkPp7rDhV3WULpn23Efpc2JVsaVjFR5Fg/8
         RUbfZfS4ZP+B6BmLGp2GcsNdOko3IF8aUv9ZYMV3XIsNesRHjB6mXeVMn1G5q3cMtii9
         CH6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795759572; x=1796364372; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MbYoT7KQY4UzFEVC933i7Z1fV6EeAwPt6xNe+N74urI=;
        b=aajIjjm2wG5+BLUpH1hPmMn87zieI7WenzLShBAueZc12L5nGz72VOqK2EvoGPW/ml
         XBwHyTipfgpCzAP6GTsa6GrfuDwfK6TZqBsPgwVQpkl6CZsQa0X3vT3CT+Bj0RdVpkDP
         fEaRWgxlwjZfTozNGAlu6/2uSbF42oIZmzSJHH4wiO86ozjO/xSG6rRt5LO7a/yIvo8q
         v/A9MLj6JVkSeZiJ+E/iRSLNM0We1E4Og9/7wPSMk0XpPuFpH8D8NptZuvf+mlR2tvy9
         YVHPiqR/7c6Sv4Uk6dam2gqBceBCnAFAu/j8PYHdSW8tDcNFc/99gOFXVBmEDxK9+2aU
         MREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795759572; x=1796364372;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MbYoT7KQY4UzFEVC933i7Z1fV6EeAwPt6xNe+N74urI=;
        b=is5VT48WcrWMOjdj5h0rJK5r1LYlO5yObPKa6CAp7Cz/RlL5ZSTUHZXgIP0qEKCj44
         TyuUO+3tKGAWnIMZBCf5f8vNB2yp/ptZSUvPB6xSivAeHhAg7FmVut3ovAXeznGJYPX6
         zldWsOkwpU/Z12EjeqOrpHUjGTHlRJf3D+ys1xe6JaUtEIw6KcKqEA38Gd+SsTvgHCj0
         PANxRZ1XEPrHdLTM3atxGJcnOUNnPRGn3WroBWLlRJBlCGfLz/QvROk+vxQOvxOp09C0
         ETxS1mtInlKe9AlrIvF75ZKiwJ6InPfA9ImXpmZPOsdVNeEbTXRQVSd47awa1qRkS/2M
         Q5wg==
X-Forwarded-Encrypted: i=1; AL+hErFy1zmPLOxIFahFE23S1D73EK41EbH6gK01LX2PPlRAjLMsASzkm/ZsvhR9lgw4nktgptU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FECoJfRaNTcVcqwDww/yi7gmnvn76A829Hc+4GbNRnIfMUZI2
	Vz8qKf69boz9h0zkHhvn/DLKQoYHLViX8YjxKLbEhgrN7z0/wGJlnrkwJmF5m+kkqCTtxph4icb
	u6RPGkdtedjMWxOTDwrqV/AMY+azAgCA=
X-Gm-Gg: AZFdTZczlfXpQK6MCUzVa7BEa7YpEIVhK75VX/h5K2+CtNT5g4od3yXo/YGdKbPipKH
	i+x+Z+lBBdsjtORys5YIP53sxIwuvov9ucZT4cA8jTpsJ1YL4SMswuIgLtjMxZfLvfbdFgEmtbo
	0KLPGXjBeguXIt3gNtmM0ScnMjz4v7wzr++XjRDonZn5YwusKsc+n19eMr+m2d5XyHmczKoNCi5
	JAh5MxrOVhYOhzBj6Tg2+l88Yum0Q5Yip7J9cNoYXxwOpEYXz2O1dVWDLZJ5lYLf1B//1cprtFe
	lc1aOgxR3swPNh9mjbw6dJlt24gXu7huVIgYNKaQecnPGCFEhTXoknuYJgRUmPtrL2y702Z6aKk
	5qaq5zHTvNb7guWsYppL8OvtZ5ZCPYkdMrMw2/g==
X-Received: by 2002:a05:6512:3087:b0:5bf:f6c1:430c with SMTP id
 2adb3069b0e04-5c1b7bc999dmr5970686e87.8.1795759571825; Thu, 26 Nov 2026
 22:06:11 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2336.git.1795686173178.gitgitgadget@gmail.com>
 <pull.2336.v2.git.1795747717319.gitgitgadget@gmail.com> <xmqq7bhyes5z.fsf@gitster.g>
In-Reply-To: <xmqq7bhyes5z.fsf@gitster.g>
From: Nahid hasan Sagor <nahidhasan141400@gmail.com>
Date: Fri, 27 Nov 2026 12:06:00 +0600
X-Gm-Features: Aa3M54p6ZggUmJ-R4U1ia0SelCNtWvZnTUW3cF_wA9PV17W4tyYKyVlioJQMtjs
Message-ID: <CABQNq+==P8khE+=C-0xF0mrBi1VRpMnd=KmUoqYL8BNMsFp+Dg@mail.gmail.com>
Subject: Re: [PATCH v2] push: shell-quote names in suggested push commands
To: Junio C Hamano <gitster@pobox.com>
Cc: Nahid Hasan via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2026 at 11:53=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "Nahid Hasan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> This iteration cleanly addresses the points raised on v1.  A tiny
> formatting nit in the proposed log message is the mix of backticked
> tokens like `sq_quote_buf_pretty()` alongside bare ones like HEAD:<dst>
> and setup_default_push_refspecs().  We prefer a basic single quotes, as
> nobody passes the commit log messages through AsciiDoc or Markdown
> processor.  These are plain text.
>

Thank you very much for the review and for pointing out the formatting
consistency in the commit message. Using single quotes throughout
('git push', 'builtin/push.c', 'sq_quote_buf_pretty()', 'HEAD:<dst>',
and 'setup_default_push_refspecs()') makes complete sense for plain-text
logs.

I will wait to see if any other review comments come in before sending
v3 or please let me know
whenever you would like me to send v3 with this log message update.

Thank you again for your time and guidance.
