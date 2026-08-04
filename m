Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F5739B943
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785857682; cv=none; b=WhgdfK8/LGQubMMabFqtmQCF4E8Quxi/QtgGx1/nnPZNwHhAhkz6se+r3I2+y7eXZsnMNNUzmrw3rYuau+5I0NDS2AiOOvbi51vBzPJ/nD1kshwrGQDb0ckCZ3ftXu3prT1Z745DlAuC/6wZgkbFrv+s00S//USSC6Lz18jVcIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785857682; c=relaxed/simple;
	bh=R5Qh0yviWiVnN6dJHvD86hQYSwt7ADQKW/Z0Yy5B1eY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=P+9KY3EoZcLZZ9OksKXbYt1KgPZks/HtvBzwEl1uLTqsnSUg76CTv6dhk8jhX1Zr9QgCfEkbKGrnzxhoIMxnqMlgYIa+1iuPQNN+kS3MeKz08j0z4rNuA3Ko0FgkV3Rk7zItBDDHNFba4Eph1+B8gcp8i/kudh/p2YnC2aEHEvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBDAARxV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBDAARxV"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4955158f26aso22940915e9.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785857679; x=1786462479; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pnrdKm4x7gDeXbM+NyoNlOrV3AIy1wLNmLcMkH3rpoc=;
        b=jBDAARxVcD8vhsM4GM1O8gPv62WbeCLJekxWJahWN4Q52Yffpb1cU2EFPL0Kx4vyMf
         F79TgObWgOjz9EMhnUasyv0L0Rcszcl6OIzH0FjubBNNK2LoJgSUBK1vrXbFnqKtjhgQ
         pua90f1ap9mLU8rypY5tDRup4ggGn2hD7m9OtaKw9uRUVxghJIWUOQa42EVhgG7k6hcz
         3dl3JjvSFQwVbVum1XvQDwAjeN2zPfvXtlwFAGUAkmtYGUBxfRNSkZXi+BZDyYbge9Cw
         1ztXMmMnJqGQsT/ljS7XBUn8NDLkX1wVZXaY+hGdylI++P8v0ROuFrFwNLYzQjADtloX
         yyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785857679; x=1786462479;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pnrdKm4x7gDeXbM+NyoNlOrV3AIy1wLNmLcMkH3rpoc=;
        b=PkdNanvWTiZ9lRIHE+hrjEOXFJTvoD62r4xpepvCPWU9f302su/PWGtR8Y++MF4lCR
         z6ovMxF7hNusn3G2w+cuF+0VgUPG/VieBGm78HZd7nlkpRzHBDJvJN/NBK/i2hz4p6M5
         xlOU8sJy0fG/0m84kjP4RRlew/IOV3xqoc4ooEjXqoKQlrbE0nXcb90gaX51dGcGaKWt
         eiR7lv+NzhP1hgCbjBV4jMRVSKYHCeclXu4rHb0eWCiitoP4f8hdi3g4xTo+vgy4w/dB
         Jk2hA1c5gF9hOv0EJwIC5v43PZdbRR7k6vZ1GynFeS9kAeZqzGhL/gQ9BM9ULWiBbGcc
         rC2g==
X-Forwarded-Encrypted: i=1; AHgh+RqxkiuJYfyDRGkM43ficZoz9VqpjLef5J6D4ram8yfZTEYmvGAFWchSFEPuWMdhEn3jTDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFQ/8hYkgo57Mdrtx0DCxL71TYSNrpooMHLem7/F6ZrGNRmVqb
	A/tCr3GWA4iHoEG5GAztFE0DIy0v8ixwhj68TokpvoOLVO9IphGOasj+
X-Gm-Gg: AR+sD10WhrORimhBVjR3ofy1AYAcJTAGYcFf04Tq3bXJ5FucyZpp9Am7vAqeynXZLRa
	eTRZP2o6gXfqUqzFDRMLNJL6hGX+YERpSEB8n/tDYbISLWUIba7x6JzcesUSYvzKCi1gBRNOM1X
	+4z2nhaP6KI/SnjA4Ctg2v8h68BkFL7QUgBgfgcxAwKmZKkl5rpQpklncoTIlDfEz9uTlF06/5N
	btBWVMVRvfbt39RzxNVstbCAxvONFEGbjrszx+mP1JWTM9auIQ0rMKHBbkqgQm0Zp3HEL4uzzhg
	V2x5cvG02t5TI2DoPa8wFGVPa3emxYHG04JvsedQgjHCNA4v7IwhrOqv/PS3hS7lPwDfiquNAtF
	nWn6VnWkCsxlgSUGqPH6ow7Wpi6HXMDgCcX4dVD+c1sTUFVnZalbejJRqJUDqdYSSF7cBeRFp74
	BrTRqIMGlMMl7hzQfv41cpONS5zyS+1tUABRpdyHPUIuvcl0y4UZMf/ZpXAUj1auiLneBJ2hUkz
	rhBaeEmhtfKHHaqStLJ3T38hRX20/EEM87Bu65TKUEPelf2Vw/9+ygtOavN2AUVtWoHv8Uc3m/J
	4NGft5g7MPJRx1jWLXpzQmBw9KRIH2yzPtL/iUrwoMHo37h1zjZehAVgRFXxT7vd3MK/++ikmZ3
	k3G4lCaWYH5Q=
X-Received: by 2002:a05:600c:4444:b0:496:c249:dd9a with SMTP id 5b1f17b1804b1-4980c66c931mr302801965e9.3.1785857678513;
        Tue, 04 Aug 2026 08:34:38 -0700 (PDT)
Received: from localhost ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994dfe64e0sm7844045e9.6.2026.08.04.08.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 08:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Aug 2026 17:34:36 +0200
Message-Id: <DKG9PMUYWK0O.NJ4R6R7H9J0G@gmail.com>
Cc: <chandrapratap3519@gmail.com>, <gitster@pobox.com>, <peff@peff.net>
Subject: Re: [PATCH GSoC v3 3/8] fetch-object-info: pass arguments directly
 instead of a struct
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Karthik Nayak" <karthik.188@gmail.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com>
 <20260803-objecttype-support-v3-3-7176fecf7950@gmail.com>
 <CAOLa=ZQbbziEK8HiPU7Lpsn0NmWfEnh=-L4wSBFt4qHJWAbJHw@mail.gmail.com>
In-Reply-To: <CAOLa=ZQbbziEK8HiPU7Lpsn0NmWfEnh=-L4wSBFt4qHJWAbJHw@mail.gmail.com>

On Tue Aug 4, 2026 at 5:23 PM CEST, Karthik Nayak wrote:
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
>> struct object_info_args groups three pointers that already live in the
>> transport and are given to fetch_object_info().
>> Grouping them into a struct reduces the number of parameters, but it
>> suggests that fetch_object_info() uses all three of them.
>>
>
> But it does use all of them, no? Not sure I follow the reasoning here.
>
> [snip]

Yes, I meant that it suggests the three of them are used together, but
in the end everything is accessed as args->*.

And because object_info_args is built just before calling
fetch_object_info() it doesn't make much sense.

citing Peff [1]:

> - there are a lot of semi-opaque structs, like object_info_args. It
>   would seem simpler to me to pass those elements around independently
>   to the functions that need them. Likewise, we seem to stuff a lot of
>   data into the transport struct rather than passing it to the
>   relevant functions, even though many of those elements are really
>   just used for one function call, and aren't a property of the
>   transport at all.

[1]: https://lore.kernel.org/git/20260802154309.GA17844@coredump.intra.peff=
.net/

I'll reword it in the next reroll,
Pablo
