Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05DB445AEA
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319051; cv=pass; b=E7fu2bpNaOuNH28r7BD2Q7O8RtDxA+r8+cqHSnavjpX1c7qP1o1utEq7MlDiPgsl08u5zykj4EzFHxSLoV4ke6zeWbyJ1kPZS21mD1+tEHXFcv+3dMbJlsOr34qLb062nDdKfVz/11KmVi/TqF5vM+DSHhGqvYe0CdYOVqiuU7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319051; c=relaxed/simple;
	bh=ikJzI6EGxgPU4hK1DF11r2wP9b/UxzeMTAnQ4pJaGFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHNMkf4VqykOc0e3aWLY40WHbTunwuI99uWqpR17ewCPCNMqQ7jYbDmPNNqIXdjse4e12Po06FwiidALdXOffTN+HYEimubLil1mdoVjyg0oxscCPl0nYxy9UuPr653BDY/swMP1ybe9NWFRS8PlBj0XysLQRLaIJfztodmIcQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HULgPz2v; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HULgPz2v"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69c7ab350e9so1218236a12.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 02:57:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785319048; cv=none;
        d=google.com; s=arc-20260327;
        b=nmmuzWeTaAdJifB9+No9gJ3syv9iHV29+UOtPzDjH6/TgWbhdjrRn1Rc2lfTDNwAaM
         PPqp2A7soJFbxGyGaBlrYnjEMyH9xSlgQFs5agcjCkKne9v19mg+rxw+LdURRUaja/Wn
         T1Dj2c+fote9VYiXTt31C9Qi8Lm9Nd5MZdca6//9Wn2CuQ2+HgBC7wzYcFIkZK1JCPdE
         QAOrCOt/FOa55Xm9JGsTLlZIc5PLE5m+WtTDWl1mtDH7OaBFXug7Y14dQLL6DVMhQw/B
         WrZRyfBNgcdZPWEdTuzfcpbjYBQUIYNogJmBhUVHK0rn6CgLyndj2Uks5d2/apdl5uN2
         dd+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jEGAOjPgnwS1bP/d9cnTrRaleKRDlmywAwctv4pNyrc=;
        fh=2aAxuZ3FwNf3QcFlH2RvBEmGPgSA32B5xuUzbfpQbOg=;
        b=MPbl+Haj+nEEGDbCxS/jxe9M7Y9JJFgx7MFAiGhfdxOFYP88HZAOVkm68l5Ug++Tfd
         OnYqM95/yfdHT9TY3ax8wyO4BNsCciYbAoFIzEMfjYodepIgy6x4zyIdoweF3TJ3BdLG
         hXdlckdHvI/UMYO210SahbNcYgEwuQQ8HC+gmM5MnQ1yZXcHBR0Nw3kaz3eSC8iMna0h
         C24GXhIxkva5MiaK1kSOCWMnRr8fPoPmIXPVR1x3sGu/DdOw8NEXayLkf24bbCOdRewt
         AMH81qnmQ8+7N8xCIFXG6/VdN33iil74xwGZIxiS1dc0drgqVTw2fYMLQL+9wuSmKAFu
         xkBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785319048; x=1785923848; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jEGAOjPgnwS1bP/d9cnTrRaleKRDlmywAwctv4pNyrc=;
        b=HULgPz2vR73GVVeGcG9f3Mmi+XI/knc8gnSlb1cniBa2BpWMgY+jUNIxhybW00x4UG
         3L4nij6aomsyausHTEl1QQbgaofZP5oObcnuER3aRlsLv2dbcdfXVk3g7e7ydF1d8gBA
         DX6DQCeKBk3EdNgXMkceo0thq//Fsugd1Wdxl0/aNocsoKqitJtnTPhztNE6Rx2tVMaj
         9xHRaSUALLdkN+CEY2+Hcude2wEVVirqqLAXmb/idc9Af5i9tlA5GuWOjauqwQY+mPMn
         c6V8dm1wTbJEO1WoaQBkl4utnSdf2ephxCYz3f5zPJnlt2cXbFJj7pIWv0pU9X7LsLtZ
         4rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785319048; x=1785923848;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jEGAOjPgnwS1bP/d9cnTrRaleKRDlmywAwctv4pNyrc=;
        b=R5ZZLFTd0j7DxywSqRPUUfL9GrSnyJvH/Aw5PotX4/TF28FGwijDM7YLNKEe/i7bfK
         /2sqGdc50xV7B9LIfu3mlYpEdKtxYRSWN1k/i8M3WVuLKlgjQLEu5AnhkncWan1IEZS9
         +FMFlWR1Zhrh3suYwPICXs8+SM4Lx60uvfbab0rp3GCyo6O9ObTfZPNaw7CcnZGHtDvj
         eUA6hNeJ+ZoGBvl9kuiZwwFcFabeoYseVjDwEI9b8uk2ktcAA28BuUxkeV7PCmU8EFyV
         +bXLEAoj8nAbUiRRam6XS07oFvd+Vk2eT3j9aBopvevekQom/6If4TzjYQrcdsy47v8+
         3yWg==
X-Gm-Message-State: AOJu0YzvCyXtgMr1WznnAOAqyVfrNSkvSRcJrtvegRUXGNhM9i9RISxo
	KHwRLrky+asd5A2YuE+KwCU5afYRUEdN0CV7PiyBT8Tjd7gQ88uGosBP1v7v1RBPAu0iWJmCGPJ
	g+fag6tcpYRqKigXQv76S9F+/U8s2AKAWO/jwjqrneA==
X-Gm-Gg: AR+sD121bT44+Uuhy+RLcQKjFUe6haurOF/JFDze4BvvMlptp1PpdI7S5RCCZsc3YOa
	alaY5baFv0JSwmw/DeMl8BoaK7T4KUuM2KxrNBSWai053hNg4Nb6QvI/o/sD+iVvkskxouAEBHZ
	eiORiFTPQ8m51Yc1BvgV1Gw4ThDwhWRVgsTasTrzxFP4IvJYFmNZljyqHdsYT/wh8JEk9XZpOP/
	txYZMKncDmAMMPA/ApcWwgRkvzCcxPz7BQO1+jXrDFhcsTzq+fOeIPO0+hBYuFSVTLlEh9njCVf
	epGFKMbtB5CHHuPKD7K1xZnhI4DFaAzPLUUAujtIxqmXM9aixCLtGNbCKzzb9B4Q3vcSdT3ZHXm
	zMc0GnHADSK+oD/XlNgnYnlkEu4Qct3AMMlvzCQnjqnuR2YIo2q3QWNmt5Q==
X-Received: by 2002:a05:6402:52c9:b0:696:8f45:4ae7 with SMTP id
 4fb4d7f45d1cf-6a0349da6bemr2533340a12.13.1785319048159; Wed, 29 Jul 2026
 02:57:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com> <20260725-objecttype-support-v1-2-2d4ca3bbabf1@gmail.com>
In-Reply-To: <20260725-objecttype-support-v1-2-2d4ca3bbabf1@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Wed, 29 Jul 2026 15:27:02 +0530
X-Gm-Features: AUfX_mxYP0R3gdqwTP_jy1iUEnOrsqqs8ngEM8CgRx7-iF3w_t2cZKVcJ1l0gLE
Message-ID: <CA+J6zkSQYuK-ZJoiQkEJDS9fBypOrBEmgYZRj1yYU00ws2u_HA@mail.gmail.com>
Subject: Re: [PATCH GSoC 2/5] fetch-object-info: parse type from server response
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Jul 2026 at 17:25, Pablo Sabater <pabloosabaterr@gmail.com> wrote:
>
> The server can handle type requests but does not advertise the
> capability yet. Prepare the client to know how to parse the server
> response once the server advertises the capability.
>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  fetch-object-info.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/fetch-object-info.c b/fetch-object-info.c
> index ba7e179c44..cf6b94afb8 100644
> --- a/fetch-object-info.c
> +++ b/fetch-object-info.c
> @@ -50,6 +50,7 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
>                       const int stateless_rpc, const int fd_out)
>  {
>         int size_index = -1;
> +       int type_index = -1;
>
>         switch (version) {
>         case protocol_v2:
> @@ -101,8 +102,13 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
>                         for (size_t j = 0; j < args->oids->nr; j++)
>                                 object_info_data[j].sizep =
>                                         xcalloc(1, sizeof(*object_info_data[j].sizep));
> +               } else if (!strcmp(reader->line, "type")) {
> +                       type_index = (int)i;
> +                       for (size_t j = 0; j < args->oids->nr; j++)
> +                               object_info_data[j].typep =
> +                                       xcalloc(1, sizeof(*object_info_data[j].typep));
>                 } else {
> -                       BUG("only size is supported");
> +                       BUG("unexpected object-info option: %s", reader->line);
>                 }
>         }
>
> @@ -148,6 +154,10 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
>                             object_info_values.items[0].string,
>                             object_info_values.items[size_index + 1].string);
>
> +               if (type_index >= 0)
> +                       *object_info_data[i].typep =
> +                               type_from_string(object_info_values.items[type_index + 1].string);
> +
>                 string_list_clear(&object_info_values, 0);

Is there a risk of an out-of-bounds array access here if the server
responds with a truncated or malformed packet?

If object_info_values.nr <= type_index + 1, this will segfault.

If there isn't a bounds check slightly higher up in this loop, we should
add one. Either way, we should definitely add a test using a mocked
server response (e.g., via test-tool pkt-line) to ensure the client
gracefully dies with a protocol error rather than segfaulting when it
receives a malformed packet.
