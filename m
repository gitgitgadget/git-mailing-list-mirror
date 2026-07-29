Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7365945C713
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344798; cv=pass; b=cCkXcL+5kMf5ja/ZUa4nXCJ7aZjZSWAvynMrQ4iO3Wy+LLcxUCMwh61Bvemvzc2E8maGD9t8Hrdcm8h59Joy+mzF8459V/41QyzUNfw1hGPC+J5AbDCWFY+hSJQggHAI5/IkHXoGMnl9SPQeEFDkoV6fwmnxATEX2DS3SHleaD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344798; c=relaxed/simple;
	bh=ncgNwBO7O5Z7VpQRx888zB2XhOgMDy/LodlcTl3ZEhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mxv+Ho4/92v1E7jBu20FVplywfLdPPNxPbpsZ8031duMYY0dDCihZJ/gj51uFMJnwbkXjt9PgpluepQ0DNgUXzCpoFg6pUz9RNHU2c7Hau4EBf3PyrnFbmsmBVlbd+Qm1KlC/xqn3Iso46mhF2sm9ypIW1/Jc47Qv+GrtT1Zvr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hjgu4ODW; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hjgu4ODW"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69e2266b07fso1665963a12.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 10:06:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785344795; cv=none;
        d=google.com; s=arc-20260327;
        b=NzhuyGpkg5HJiPq2RKbSwIblqAN3+s7YVBjgdFnNDZ2X+1j+/wd7T8NcmLG4q5ZQRQ
         5ukhBzqfIQFS6Cypqfir1+POfYasr53sTY3lXGwX8RmfOv9jjnm902SzX3uxbsi2wiG3
         n2MC3bAUqS2wfAR0qtVAP6treev/PPDO8pxoaMprhilaQOaJxMjZaBBUXRjf4X+8IvK/
         FFbT7z9UKSC4RAtMUH9nJDN/Y5iOq8AfBv9KDlosmxvxnh/8PnUBoIBdfO8mWE5LVEgj
         aPI3pcDcWZ3j3UlxxbZxBFOe9i/PT4lM0iUvS9bsaUH7ylc2+9zKKop2+XYKI+GXdfU3
         NR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NAYuBtvgkNPtu+77U+cuNL6hX3DsjLg4kaBT8NYw16c=;
        fh=2aAxuZ3FwNf3QcFlH2RvBEmGPgSA32B5xuUzbfpQbOg=;
        b=K5p+qxSwcRyx+l2jcUv9amdo1eZTdVUvt4ZTF82EujnFGq42BRrbeaHQF6KOwVG9Sz
         8/EwGmhQXwFKwNqnj/tj9S6UZ8vc8Ibg/p6/4fO4TwTdqaAy/85ISrePwFp6EJceCbk9
         kFZoUoCIATDoi/3dZXx+G0znJiaYTk+3TZV9lAARhx/ZB/+BtpLxVrJAGTWBFC/THTAk
         zB0VcnC5pw/ZTfHmVrqJZ56tqQyY2JVpR4VkMCJxh3dyairnVRH4hUvYoVqGr6f94VwC
         N3uFuI5tl6ypriIRjj4iN8cVj+Or5PVz0lqwWRsCmdGoe/P1kFFfj1/0fMeVlue3Ao/H
         h71Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785344795; x=1785949595; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NAYuBtvgkNPtu+77U+cuNL6hX3DsjLg4kaBT8NYw16c=;
        b=Hjgu4ODWcDYimA3P1xlWd+Jpaqr2FOtIzG14mNXz48F+sW07Ejtiwi7etHEgQx3ZYV
         Ol2nOid7GXmbL7i+KSe+GlWJqot+9taRiMRpinQ0wjNKkf4/4QnS9f2HYJ5xGq7IZBmg
         zeDVQJi9Nfqj1Vm5KL5SXxyK3AfOLquobsJ5iRevXzte9GvtIxgHNYQBS3/kdj5mpvjm
         ZeqRWdSjVpDwfTvx8YwEbEX/wEfrmkQzEU6/B0MzzAz6Z26p9n/5v/lVCvhrnm78uMQk
         ArarAQ1fQMc3SCi+Oxv4n7XovyX4eNCscYI9Q4y4xebxQCnw+xaMVJvbqHREkAuPFay2
         1Lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785344795; x=1785949595;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NAYuBtvgkNPtu+77U+cuNL6hX3DsjLg4kaBT8NYw16c=;
        b=V5iF4chUVX0yiKnscEarghuxkSVA6Hf5v40AMHHEXzg3PcTZCaGv94NKyKuer7HeIB
         KxTQ6G4+rUldWdbbQAapHQGZO8jSGRPsTquz5ZG6fuRBaihhaNz4A5cRU2IZ0bhExBjn
         o8j83On9qX1w3dgyOQqWKjKW85s8GH+4fHTTw7iJVcDV9CvqmDnBSsRDBI7n44+6yQu2
         ZqDmapnOAghHvWZrvZnVHR2fDxZPZ2Zhng59QCxSogCNzyBq5DZZVBgeEn6LiTSB59uJ
         Y6+ymdCMtBljJiFnwXVvIY8Nx9GDGvVqPqhphDG9uP5RtO4DoDFsxDHN/7YoNVi/umRj
         ndcQ==
X-Gm-Message-State: AOJu0YweBNxMX19fUUm0+EKs9yfs/nWU1sbM8k+iSK0K8smCSZ3eIBhe
	n7MnMtQ97rt+q3us+MXrRIEokMFoHAvMLvt+7m28FM2xf/q66fKxWBlI1Q130Hqk3vw2UMhqz1t
	l87b/5ebblY/y1TJu8F6zj54xdpq1pr8=
X-Gm-Gg: AR+sD12ISZa8guYo2og0j0CNIO4u4GBinrAnNYU8RN6bxTxT6MtRrHmtlnURlcqATnm
	Mjjer8qOs91olGYNoz1ltz/O0SomyREyjw+1Br+sGM1eGIRv9IDahJ+PMfXa9NYybHdyJg0YoqT
	ljfvt+xw5QwlEKezRgS1RuItLk53hS7NgB5ve82chSBUkrBLxkZzFplJdU4FmIwwOGjt0A4orAb
	/qx0i/+DzGOo58PPd7Uj5vL5NClNL/bpZV6U5poUech+xcg0d7nwin6pPjg0QVmiV9OOOUKVR1Y
	LRzJSFAh8/n0/Tfz0dnuxky/CfV2gVeg9YeD5s9FRCc7VsCPjPKQ5+hdfdJokm1Kt7NCxJKC8zh
	BgSvnCtQIflLY/KlLElhlP/oz4w4=
X-Received: by 2002:a05:6402:a0cf:b0:697:e8e1:d3c0 with SMTP id
 4fb4d7f45d1cf-6a034a3d016mr3814914a12.2.1785344794573; Wed, 29 Jul 2026
 10:06:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
 <20260725-objecttype-support-v1-2-2d4ca3bbabf1@gmail.com> <CA+J6zkSQYuK-ZJoiQkEJDS9fBypOrBEmgYZRj1yYU00ws2u_HA@mail.gmail.com>
 <DKB1II4Z88SG.38KG7RAF9Q7VW@gmail.com>
In-Reply-To: <DKB1II4Z88SG.38KG7RAF9Q7VW@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Wed, 29 Jul 2026 22:36:07 +0530
X-Gm-Features: AUfX_mzlOtflGSwLYMCboABulkHLnsowH6UXWGGHtEMGdHBIyhIpa1gqGXMnBhM
Message-ID: <CA+J6zkQQ2F4P1dr+ix8HrKth5W=Kw+AA5EXKwm4QHY5DKjt-Hg@mail.gmail.com>
Subject: Re: [PATCH GSoC 2/5] fetch-object-info: parse type from server response
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

[snip]
> >> @@ -148,6 +154,10 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
> >>                             object_info_values.items[0].string,
> >>                             object_info_values.items[size_index + 1].string);
> >>
> >> +               if (type_index >= 0)
> >> +                       *object_info_data[i].typep =
> >> +                               type_from_string(object_info_values.items[type_index + 1].string);
> >> +
> >>                 string_list_clear(&object_info_values, 0);
> >
> > Is there a risk of an out-of-bounds array access here if the server
> > responds with a truncated or malformed packet?
> >
> > If object_info_values.nr <= type_index + 1, this will segfault.
>
> This shouldn't be a possible case because of:
>
> fetch_object_info()
>
>         for (size_t i = 0; i < args->object_info_options->nr; i++) {
>
>                 [snip]
>
>                 } else if (!strcmp(reader->line, "type")) {
>                         type_index = (int)i;
>
>                 [snip]
>
> type_index is set based of the range of object_info_options->nr so:
>   type_index < object_info_options->nr
>
> and a few lines below:
>
>         if (args->object_info_options->nr + 1 != object_info_values.nr)
>                 die("object-info: unexpected number of attributes: %s",
>                     reader->line);
>
> so we also know that type_index + 1 < object_info_values.nr.
> After that we get to those lines that this patch introduced:
>
>
>  +               if (type_index >= 0)
>  +                       *object_info_data[i].typep =
>  +                               type_from_string(object_info_values.items[type_index + 1].string);
>
>  And because type_index + 1 < object_info_values.nr we can be sure that
>  this cannot segfault once we reach this code.

Makes sense to me.

> >
> > If there isn't a bounds check slightly higher up in this loop, we should
> > add one. Either way, we should definitely add a test using a mocked
> > server response (e.g., via test-tool pkt-line) to ensure the client
> > gracefully dies with a protocol error rather than segfaulting when it
> > receives a malformed packet.
>
> Ok, that's sounds a good test, I think there's none where a malicious
> server is simulated, in part because I don't know how and I think I
> haven't seen a test that does that yet.
> test-tool and pkt-line are used for the opposite: simulating the
> client to test the real server.
>
> I'll see what I can do about it.

Yeah, I wouldn't recommend breaking your back for it though. We
already have tests exploring the happy paths, so something that
simply verifies our expectations for error paths (printing an empty
string in this case) should be good enough.
