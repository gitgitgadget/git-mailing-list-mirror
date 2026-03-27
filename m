Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600A82DECC2
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 09:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603445; cv=none; b=T0vHK7FKJE1UJnHJBMHxDfY0a+2Ueu7ei6Y+aDF1w1uUSgl5zCnLsQLF1obce809ymQnsclUlqT7U31OZ5k3j/pFAtTEyzYLkFepcMrnyZIganywFQjMqIpKYQvM9+ZDsfNxuZj28/TjBTxXzJ2qOY+rTSXoTQumBWGlQgvVWiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603445; c=relaxed/simple;
	bh=5+Z6Ch+e3mDyzHBnJFWv3Hu0gAKUhGrSom1KqMXZmns=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:
	 References:In-Reply-To; b=Hyp3RX8L52FfWy1KHg13lO7Q+F1k51703X6wcDYz7JiuVK8+l5muxyhMQUCXhtZqsn3KI0cXurdBYCKi5SgOSbO/erao8ZNdan10xJZxpVO5EQDf2902PVK7b9P/CKIojBG1DOq/87hDpSl2UY/mGhMyfLH+lp190h2ngmnPZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQvJmlz6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQvJmlz6"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48704db565eso26717545e9.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 02:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774603441; x=1775208241; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyuctO/VyqwZiwRGaCAxS1FX4R47hqYjISWG6IaN0Q8=;
        b=aQvJmlz6NkfDWgD8GmmKREd3z0cJx84LRhjEOE2pzsiJh8ApBN41/n56K3vKVpHYc6
         Q0nnTLvehZzRlsJjAaJ4pJHtPfpLp2nFI01VOAVvgdyZrxWzYqKxZL3slXH4w/YHWI9k
         z6DXKILOjd6Pqi+VEKjBkcWZufgp7P82Z3HP70NsEpfRE5Ae1I67XqI5A3hqnTw0oXJ6
         TgFv5D22TDHC0WGl4GkDGYhQyEwnqAriSvCyLSpZ6FSJd5X1na0rL/VrqudL68sYTwXZ
         Ug7OZg3Nrd2DOmG5m2INyLbqM6LcKc0oqff6IRsWLQ5f8sg3hXHhtISMmcV0o/x7l6kV
         VuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774603441; x=1775208241;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZyuctO/VyqwZiwRGaCAxS1FX4R47hqYjISWG6IaN0Q8=;
        b=B2BqQ5Ghh35atm240VmDEFLpDRaVelg0aXKKaqfmT6MSUK8yfYAwMQSIVoFmv/sT4s
         jJ8qvqn+aVN8lnufpH7gXDqswZfgL8QF4pNpyuq0954fW55SpqGUZAQ8zCbovIcvOziN
         JwDIWArHJURwGCqBs0uAsh8wyEEEl1+urCpAlCgFQSK6iFtIkj5gEXr54KfxPYykZHLp
         ESc/TU7uKx+g0lT/em1QsRgbf0wlN2WabfBrwaeYEDl44fY1ce/ylyQamPsLCA4iLd2Y
         AGkKH9Ql9q7Lk/MN4M0cWUytcbUcdAsBmKNbhmpSR11IfiomERT1a+48W3tEGJS7a3Yf
         U+1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWAUZ/fOuqKrsgeD7aQk0K8UJ0oTiYPGoNpmA/YQiE0kJrInrD+l8FOGjjLFpBHpB45/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/QzegLpAyixh/xzySGMWuFky78hj3i8NXyFJOOSbABJncLBMM
	INtMUY4ugL0YpBaf9QFQqphmixe9+xRVdLD1JYftd7b2AfnX1urfkp0vyYOx7w==
X-Gm-Gg: ATEYQzxJcEFoSn2C0tQXFD+zt0gOKAjogZ4IPUUCtnXFlREniehB4g8lEM24AKVxYyA
	IBzWkcE4B7v8xdhzJWw+WLgPWwpN2PN4nDzWo9AClO1pJJBdq6T62P5sIMloEBdwYg89L2ELqfc
	haFk/+lY25JWv+CgsLRC22B5gdxpIBsE77vUNIcnIHbad03hvQEVPaVHfW6qLugQe8XGGP4vtAT
	S/RJBwaEbtTqmVc6MlLLRjrUl2RQ/B4WiHnC5LBYCYA/IIpC2lgsc2W55oHdxnW+yarKgCC4sJs
	zsPULjNPSXXblUUhxt6Ch7XQWgEmwh2exZkra8DR8izcNjB23j6Jn1qsxWN/wEdmvSXpkCnkQXC
	5yYy3AwX5BlMy7XtLCNNZGS7Naurxvk3f7nv6cZ9mshuLXffAgqAIFtuVpXC2iPWY9/OYuJACZI
	uqqkrHfoB46Z0MOBPb/jmd
X-Received: by 2002:a5d:5f96:0:b0:43b:4faf:a496 with SMTP id ffacd0b85a97d-43b9e9ee4f4mr2539780f8f.31.1774603441129;
        Fri, 27 Mar 2026 02:24:01 -0700 (PDT)
Received: from localhost ([193.255.169.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9192e352sm14306284f8f.3.2026.03.27.02.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 02:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Mar 2026 12:23:59 +0300
Message-Id: <DHDGF1CL2QHP.101BB8D2101N8@gmail.com>
From: =?utf-8?q?Burak_Kaan_Kara=C3=A7ay?= <bkkaracay@gmail.com>
To: "Shreyansh Paliwal" <shreyanshpaliwalcmsmn@gmail.com>,
 <git@vger.kernel.org>
Subject: Re: [PATCH 2/5] refs: make get_files_ref_lock_timeout_ms()
 repostory aware
X-Mailer: aerc 0.21.0
References: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260325164833.1216577-3-shreyanshpaliwalcmsmn@gmail.com>
In-Reply-To: <20260325164833.1216577-3-shreyanshpaliwalcmsmn@gmail.com>

On Wed Mar 25, 2026 at 7:44 PM +03, Shreyansh Paliwal wrote:
> -long get_files_ref_lock_timeout_ms(void)
> +long get_files_ref_lock_timeout_ms(struct repository *repo)
>  {
>  	static int configured =3D 0;
> =20
> @@ -998,7 +998,7 @@ long get_files_ref_lock_timeout_ms(void)
>  	static int timeout_ms =3D 100;
> =20
>  	if (!configured) {
> -		repo_config_get_int(the_repository, "core.filesreflocktimeout", &timeo=
ut_ms);
> +		repo_config_get_int(repo, "core.filesreflocktimeout", &timeout_ms);
>  		configured =3D 1;
>  	}
> =20

Looks like the existing code uses static local variables for
performance. They can behave unexpectedly in multi-repo cases.

I think moving the config into 'repo-settings' should be considered. The
config is already lazy-parsed, migrating it shouldn't be a problem.

Best,
Burak Kaan Kara=C3=A7ay=20
