Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795619613;
	b=jzWeKmLtynhdVCbp2ncmQYBD4ACnfvM3bFHxsyapf6T8HjyXLXhcl1fcA3ejywzBew2z
	 DJHyaneacm65uE5E1QmRmQ4G4rEPviD0NSmqkTSE3z0Q2Ts0euO6Ats4egGhHcKsZ5Xt8
	 dvcUKinoOWHDMPDJ+WMHEcaPhSMY/BhacuzySG+q24c9+c7RRWzM6WnTGEqD5HZI7/lY8
	 eFYN8snpIoH+AhSO+mQ11Ok3+ddo13g5QPSRec02NshnflqRFWNmiZuCcFeEhZVrNMx1g
	 +CiQXiwQgEMsMMl89nWjpb6Ej1wsklB/jHET1/rA5WyHjsFz1Ovc7Zx/TZWAwlou6tw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:In-Reply-To:References:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=+vk2XHDz2S4njPEnTBX9D7jnB8ze0zVXB2tky50CKZ8=;
	b=JJCcMdd07q02Gd/8bjCQUHnAfqDAMKJfXYus9iZHqEmaf99LOlsB7UoRvFxb8hl1Eotu
	 unbAVOxUg3t1V+UCRDes8t1MQxv7tDKo65RDgYC4sgmR9G84R0ni6mNf6E0S4OyodqjgZ
	 JlmKybN8uJyc2/lC5GurgiiWrN3R1maMUnz43SseYV7LMehK4K9kzt+s8Swd+9NUBGLaQ
	 jz6mtdUBUUDUYDFb88EBLhxzEb9mDm93/wKe2bVa6Ibw7SxLGH5xi16Cxc+yeSxrovY19
	 Hot92A9qh0ZBPyeLu5o08OCMU9RGbE7sYHlxIgODwIMEA//DKNMooYdWmXkVEMP/D8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ju2NLy1Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE335606A321
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 15:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE335606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ju2NLy1Q
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b869ea8224so52716a12.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 07:13:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795619611; cv=none;
        d=google.com; s=arc-20260327;
        b=EfsCfG6j3txgbm+fF3+uNI4g6iem+NJN1T+X9jcVoueq58ffd0WPgCfjxaBGvgW/x2
         aZlLRj0lPr3P0jvJvpKZgjBOK7A8/ErxsTeCCvzbnYKXGbpcwNHT335vfe4PFL5tHp4C
         N0uJJIyUZrN5Bzs9PgMo/rSC6qDrCNU4bn8OUF/DU0ywTQ3QxEPONOtnEKdwfvD/zhxu
         2kZUAr/euT2lxTufdn/GuCSBGUM9jPS4ghBk+tKf9LzmHQ51hS9af7/bAd5n647+ONuW
         g9Qv4SwPUnM8KAIadB6k+nwH0MatkrKz2VLfAl52jc+ARZUNPyjrNw8gNDjCcbFxRu1C
         Fn0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=+vk2XHDz2S4njPEnTBX9D7jnB8ze0zVXB2tky50CKZ8=;
        fh=YkC1o8BhKLEX/2gF2JnmcaCV6Pt0EAOAIz81VezVYjw=;
        b=NBkIW4DfOHDczcHDVZJP6eXl1Eeh39LCltn1rwKEvxRO5R1s4O/cge3VTdzfGEZvLG
         tHVFbJF4f+m+xXbZyvJ50DrrCd6Jy4/wkol/khvOvX+U9TMwYNpB4dPv/1q8K6QdsecE
         K8wfCH0f7FjHBpjewFSF/w8n9Ow/fzdADcHNLqwEoiTVT0V1GEbmLNG2w43fV5jf0MkW
         iKkdKikz8jXT7Dn5r7nM9GVrgfLpU09vD0Zh5/Gq/TK5uBoZqUZVxRqrYCceg6pdz9uP
         VOUceufY2hrwdqaDeu/MKNIGn31IXAvz5C1f8MXIVR5Kbu/vTjkLanRyj3Ln3XWVA+xM
         iktg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795619611; x=1796224411; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+vk2XHDz2S4njPEnTBX9D7jnB8ze0zVXB2tky50CKZ8=;
        b=Ju2NLy1Qo5PpFzYFpslbYhjkLIDFrQZxHzXUA5cYBMgLIRjZTIqyEATdnrYfgZJhPR
         EsksVIwvWlJNCwxYWgo+7JsO1UUqsJgwueC/Bso3QEyQv0Ku9kKskUhfat5NPX1XnuFN
         xy9l7m6/KPELh6wSvzA5ksDej4X00K3iDRhjFI+gRROdyRU6OjHCJcmDBzUl24Qi8VDo
         sagbOWZK/Nt+GGqpU/y4Z0SDfZ4daikPGtZXuNlaFNYcMbEhWum980E0VAGb3oJNn6x0
         yXyXR2T+Ew0J3DzpFB+hxrnucnKnxqSULW0hhbmerzB6GJ5Sm9tgte59yxdsTZHLMM4S
         /Afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619611; x=1796224411;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+vk2XHDz2S4njPEnTBX9D7jnB8ze0zVXB2tky50CKZ8=;
        b=yPhNmxcHqClGQJz05T6Tk2UY80JH72LKYeCXNiH3h9zJAGLvtIi3nVRu4tNYd3swX0
         UNwnf08t9zcAeyfz9mZFm3NLN3aIjxt/FLKzpW54ImV9lnSot/bx7v+ZrAbsVL23n5tm
         robEFO8g4apl7ekGi5ZM17Hi+/2cUKJUthAYlBACp868k2nWcIsaP0CExe0jg8pdoOOQ
         sMCaygI0wh6lf0W/PEVbAiXeZ5HGgUf+iw/SknTm322JVSylZoVEljZmth0wRVID/9pZ
         g1b3CJRDr+/DuTjCPizdYZwB6IDY/v4aEIjx5YtCI5MxKCEXg7+bpway9n2LOg53J/4q
         OTGQ==
X-Gm-Message-State: APuU4Z9aTF675bYzNjseuLH0UCFwLh0jHT6Ka5WXuUbVpnZAolWFUcEx
	ZtyWvIP3EVzI7mJcZl3b1o2DgDM9vt0aensWKhW74q28lnzL+1hbASXVY9+f+2baPMXYm3Cgv8x
	g1TW0+VpHvZK/bi1b23m3zhXdr/1EzesX2m/oNz4D
X-Gm-Gg: AZFdTZf1HoewSGh67PSOHOV3q83dKuSYNGTBK7SKCyNJPgM1Zx8zTiBHRa9eB2lZLP0
	FZ8go3rVyODxa3D4FZ5dNTwt/PX68d3ep5Z2OZD1qNcOblKwC37d2wNd3/8DhhGt4l4FZMnUYas
	tIoziKomIdv9GLpqcF37ESJC2Jv1sLUXwQPFBTbcTsDdf1eMt8DYldeo9DNVbxP2N+7BoHhRi02
	NMRN/NeqWQYuNWRnAhBQxuuzVTliWS3l3I3ANEiaAUASF2E7zhuMSWkjghRssUFPuTGFCGiA0u8
	u28iEvAiYjP8TmO2ohFBTAM8WduslNL+qat8YToX+DV43AIrrtlxSTi1UqJ6hDfVxQJzwjW18df
	oMp0Rj5TyOYSkecDxHeq8OlX9PolQn5Mx2t9aICsw+7iGgtDzcidtFLph/LZjffJ67bUEW+8RC5
	sofKJoBqAOXg==
X-Received: by 2002:aa7:c614:0:b0:6b4:629a:6352 with SMTP id
 4fb4d7f45d1cf-6ba65b4065amr423167a12.5.1795619610571; Wed, 25 Nov 2026
 07:13:30 -0800 (PST)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Nov 2026 07:13:30 -0800
In-Reply-To: <xmqqqzg9kfyl.fsf@gitster.g>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
 <pull.2287.v4.git.1795103883.gitgitgadget@gmail.com> <8dc66bfca4f42b1d847cf5e39d5940e0150ef2e4.1795103883.git.gitgitgadget@gmail.com>
 <xmqqqzg9kfyl.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Ravi Mistry <rmistry@google.com>
Date: Wed, 25 Nov 2026 07:13:29 -0800
X-Gm-Features: Aa3M54pGzm-tgeAp2t45nRfe1xL5UcgDXq5AEtwfs1tWIj_UkAycf64ReKixqRM
Message-ID: <CAF+mdicKWo8wFYguMfs06bcvSBda-0zSORbBLbDs=Uzk9SkgCQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] http: add http.retryStatusCodes config option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>, 
	Patrick Steinhardt <ps@pks.im>, "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> http_retry_status_codes is a file-scope static that has the value
> obtained from the  environment variable or a configuration variable.
> It may be worth noting in the documentation that configuring it to an
> empty string does not restore the default (i.e., 429 and nothing else)
> but disables all retries.
>
> It is outside the code touched by this patch, but because
> handle_curl_result() checks missing_target() and 401 before
> asking this code if we should retry, 401 and 404 would not be retried
> even if the user includes them in the configuration.  That may or may
> not be worth noting.

Makes sense. I will document both in http.retryStatusCodes in v5 (and
add a test for the empty string case).

Thanks!
