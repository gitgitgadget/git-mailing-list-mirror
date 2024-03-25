Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF245D724
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 23:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711408582; cv=none; b=I1OUB4Yuf60s7mIxbBY6koGq5zHZlycEV8WyUFXAds6orgwMLNNAXQE10Eit9RQ1/4VPyUe4ivgZjs9Hby/DqZRAxZHQ11QmVGcLwngnOOdPu4r5RwwAJQ7bOmJuH17mnoA+G+SXKGiq+rrWZ7RzJlUIZeRQmrgrdLjaM+EE6II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711408582; c=relaxed/simple;
	bh=htn1lOJAjaE0GTL7ddCzNvA1WJqEnk393qATSCFeCcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EL/ncgVFHZmPgpxhg6gidFq9CHa+I7eMhX1Pv6WsoogipZKIlFNUhFTHWNPts93yssxoOnrvRvf0I8i2MvLWiGGbgA+lzQF3XuH3rI+dieQ+0Sx2IFOHduhmnH6bQC1cwgKw/A8V00WarCNAKH8n+SvjKTGJb8li0DxpK5tmRaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyFdy/TK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyFdy/TK"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34100f4f9a2so2920647f8f.2
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 16:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711408579; x=1712013379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYzXgsXjPe5qr7YG8HhogJUWjTsRhiwuthRrZIfsbL4=;
        b=lyFdy/TKr99j+jZ89v8CS5e7wl/2zzknL3upO32fuILG7jvZ2V9Sa/tA1WAhwokl4I
         a98ENkX5l0hSV2LtRzDnGTVDNWlufuh23rkSM0GR/8yAGeAY0comlyhakUYZo+RwdcER
         hGhPkO95KYlRmeJdiWYdEh8JVVtWpRJTgLjHm6Dfa5e7dhXMTWxX/iSM0WQTUva5Fd6w
         2/QOHMD9j8Kexv8YIOc76UWBrgkQ/3wuLZZZz9lyS/a1PGzzxNTt87oxWpQNja0h9E9k
         jbBuTJIjTzFABVOwReP/bwwulezvuKtsFT7tN4sfJX4eTspZPGV29kSyMI/UsOUR7yjc
         RFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711408579; x=1712013379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYzXgsXjPe5qr7YG8HhogJUWjTsRhiwuthRrZIfsbL4=;
        b=VFPA7qrYWu0kfONtWcyD/BA0NtT6mvpjy38i87lk0qKneKP2Z5IgruYuMl48HY2eVH
         gP23kYFy3wE+JznWwlCeEeoA1AIBXqJrr6Lo6Mgx7NVnqbBDzHEu/Wfd3oxGNx8hLArq
         hNOsH4rtt00YWwIRD0rWikwWSycExv2Skbq5m8E40fJGLAb41wP79QwuW2HCjV2XAIZ+
         CRi07Wy7hJYm7n8cJWHGQWWxVwCVWF2XrdyD1YUpEWc8B4q/4VDcDLJqPQLKQJpvAl8U
         /+IyDszztDAMrLOOv6iL8/IzGfFOJ/9zoeew2+Uy9ao1fJmSk5uQIcwmduLgP8IuT/E4
         ykzg==
X-Gm-Message-State: AOJu0Yw+JtN2oB0oqZ+9TLMhokromLh8FsiSZM1FXot2mtpoFN2x6P7g
	fi6EhMw+YZOQ0Bu+eife5v9HihUZwhJkaHMC30gTopYXpob+lyH9
X-Google-Smtp-Source: AGHT+IH/9qiiIA/BDfpvWCEYwiqj5m0iwMYo4ombbRwLZDzXXoouAQXMcW2X9h4zGnE7xOIIZ7DmEg==
X-Received: by 2002:adf:e247:0:b0:33e:281c:8f42 with SMTP id bl7-20020adfe247000000b0033e281c8f42mr4725570wrb.70.1711408578787;
        Mon, 25 Mar 2024 16:16:18 -0700 (PDT)
Received: from localhost.localdomain ([31.124.44.211])
        by smtp.gmail.com with ESMTPSA id r17-20020adff711000000b0033b6e26f0f9sm10601559wrp.42.2024.03.25.16.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 16:16:18 -0700 (PDT)
From: M Hickford <mirth.hickford@gmail.com>
To: sandals@crustytoothpaste.net
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	mirth.hickford@gmail.com,
	mjcheetham@outlook.com
Subject: Re: [PATCH 06/13] docs: indicate new credential protocol fields
Date: Mon, 25 Mar 2024 23:16:09 +0000
Message-ID: <20240325231609.284-1-mirth.hickford@gmail.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <20240324011301.1553072-7-sandals@crustytoothpaste.net>
References: <20240324011301.1553072-7-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Tell users that they can continue to use a username and password even if=
=0D
> the new capability is supported.=0D
> =0D
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>=0D
> ---=0D
>  Documentation/git-credential.txt | 34 +++++++++++++++++++++++++++++++-=0D
>  1 file changed, 33 insertions(+), 1 deletion(-)=0D
> =0D
> diff --git a/Documentation/git-credential.txt b/Documentation/git-credent=
ial.txt=0D
> index 918a0aa42b..f3ed3a82fa 100644=0D
> --- a/Documentation/git-credential.txt=0D
> +++ b/Documentation/git-credential.txt=0D
> @@ -178,6 +178,24 @@ empty string.=0D
>  Components which are missing from the URL (e.g., there is no=0D
>  username in the example above) will be left unset.=0D
>  =0D
> +`authtype`::=0D
> +	This indicates that the authentication scheme in question should be use=
d.=0D
> +	Common values for HTTP and HTTPS include `basic`, `digest`, and `ntlm`,=
=0D
> +	although the latter two are insecure and should not be used.  If `crede=
ntial`=0D
> +	is used, this may be set to an arbitrary string suitable for the protoc=
ol in=0D
> +	question (usually HTTP).=0D
=0D
How about adding 'bearer' to this list? Popular hosts Bitbucket https://bit=
bucket.org and Gitea/Forgejo (such as https://codeberg.org) support Bearer =
auth with OAuth tokens.=0D
=0D
> ++=0D
> +This value should not be sent unless the appropriate capability (see bel=
ow) is=0D
> +provided on input.=0D
> +=0D
> +`credential`::=0D
> +	The pre-encoded credential, suitable for the protocol in question (usua=
lly=0D
> +	HTTP).  If this key is sent, `authtype` is mandatory, and `username` an=
d=0D
> +	`password` are not used.=0D
=0D
A credential protocol attribute named 'credential' is confusing. How about =
'authorization' since it determines the HTTP Authorization header? This det=
ail is surely worth mentioning too.=0D
=0D
> ++=0D
> +This value should not be sent unless the appropriate capability (see bel=
ow) is=0D
> +provided on input.=0D
> +=0D
>  `wwwauth[]`::=0D
>  =0D
>  	When an HTTP response is received by Git that includes one or more=0D
> @@ -189,7 +207,21 @@ attribute 'wwwauth[]', where the order of the attrib=
utes is the same as=0D
>  they appear in the HTTP response. This attribute is 'one-way' from Git=0D
>  to pass additional information to credential helpers.=0D
>  =0D
> -Unrecognised attributes are silently discarded.=0D
> +`capability[]`::=0D
> +	This signals that the caller supports the capability in question.=0D
>=0D
>=0D
> =0D
> +	This can be used to provide better, more specific data as part of the=0D
> +	protocol.=0D
> ++=0D
> +The only capability currently supported is `authtype`, which indicates t=
hat the=0D
> +`authtype` and `credential` values are understood.  It is not obligatory=
 to use=0D
> +these values in such a case, but they should not be provided without thi=
s=0D
> +capability.=0D
>=0D
> ++=0D
> +Callers of `git credential` and credential helpers should emit the=0D
> +capabilities they support unconditionally, and Git will gracefully=0D
> +handle passing them on.=0D
> +> +Unrecognised attributes and capabilities are silently discarded.=0D
