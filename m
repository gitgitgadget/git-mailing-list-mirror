Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794220038;
	b=gZqHqLG5kAHNmtqDpINCRz8wc760hetB+hnRRxPNl7FlE8eIA56cTfp1dn90CXrKeSkO
	 5EvEZE+5kGQwzCJTShgLMsxmpT4z6cIk55zG/4qpTR0O++98s87gX2EeZNMtClqIHMSyf
	 CFhIvyyqy5uqkeWPw7FnmmH2XWaO6hwwRqY4VbA0c/nK1e3wgYHY1oJhoNAFS+K0ftKTy
	 i66E52JftZHEa9akOrAPesT50TQA5UtFe5/vynCCciFMI4n8IRdRmJH+RZ6GjF2H8W/LC
	 kF+ba2QVB0MJvr7hcHXww3ymKQpQvqf2E3mUKqquavoAwPypzqhmDAEWe6Pz4l6m2wQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=JBONLngMhhQJQOfezGDZECXON9Dkxwfwb3j/uRdArdc=;
	b=czhUJvlr5WqSZfVIFS7KCoE8GMLgfM/HLDd9oexhQWiH07S2fA6ad3XBNlJqMRqhjZSm
	 ZZ3nh32ugc9PWb8y4wJ0gB7jMAgCWWoAqcqhNLFIqKtHbRuNNmPVCAT0T9JleXsXVoSnR
	 zD/+nrbTbeisuBUxlsY7gU2I102kaK6FKBiLA1j9GNLUJruLLcLikChmHaHWiRRoTBO+7
	 xvcSUR5FpSgBBqviOo791uoS+HcHJ6Ou8M286qByadMVeqyCGJ4BFHNz28kDFPA8yyNdM
	 eCi7JcDXuEesSerr3oevB9FMywQn2kqUT4h24K9Eun12VHbKPi4psz5pguDpZNtUcKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AfvYsTr9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FFF606A339
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 10:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4FFF606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AfvYsTr9
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67921b515a7so651887d50.2
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 02:27:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794220037; cv=none;
        d=google.com; s=arc-20260327;
        b=jNFoIi5gzGzz1sJZ4tFmuqgMGY4z26ZdpI5tZ8vIYcao1b7L7RUviflrQNZ1PQBKFz
         W9Rv+DNpfZ7hurAB9uQZhlqd1xfB2s5QIoGdN4bzTL6oKi2WZ6A0KArB6HRqclIjLcrw
         EfRVvT69mAKa1lZu4SD6pbkuaShUmYGgMOV10y+K4DLn+dWfHujvm5bUsy5LJZclYsVb
         oe5qGyvDFHgMs+DlDfCOO4OFjqtl+eyBg95YMzy4HKlQU4F4i73l7z9DBMLBH0em6l6Z
         /NgSgDQwn3vNlHTT+dI9zzw9ToW55mFSFWxwjx1Y9tkcgVZJK3Um3plLje6aN2L/i4Mg
         7BfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JBONLngMhhQJQOfezGDZECXON9Dkxwfwb3j/uRdArdc=;
        fh=u2HXvIO3dn789rE2mqcm4j8Y11yJaHQ3Ds9eIxaXqaU=;
        b=blo7C2jT5XNlP5dsC7XuqmP9Z1RO1DD8too2iPrWa7yG0cFry1V+wzHyU0p73maw4o
         7WMtOE5LCsJRxn7kFENVekxUuzAmM0qrD1sygoRoquVx3xJr6W81ZQyFKWnH9/WD7/qr
         nW4KgLSmXxIjVNfM3GyILKG6XADUXMdwd5SNacKhDZ02Itp9CMxYndy22XggGBr0udYz
         /2L/tjD3va/Vu/a+gWGSHFGlShSLt0i60oyQYfZdLGw9Mm6PIZv7NagZZeiuG7nWXpMt
         5yOiSPyxU/ebUNjn34piEWxxUEM+vQt58LoGN1mZepcwFdMj1ls0ZAKB6HU6ahhPWasB
         7Nng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794220037; x=1794824837; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JBONLngMhhQJQOfezGDZECXON9Dkxwfwb3j/uRdArdc=;
        b=AfvYsTr9iY0efqYcX8Ox8PHNE+3pbJ5vY/3HXJEG4oofjIZ8C1Qsflv8aiPSapJ/s+
         XT/bIRfX/v6E2t1mqvqg80bIQi9MSOFdTAetPd+5e9bXlGjN2AYUTId4f3TBzWWZEENO
         XATUWV/I/TFLaxfNyNuNdKuBXlwZ05EO8Wqhx3Tnm8htRQFRBHsWAZ+XU7ADlqwN1/qn
         vWA8JBUT7fswIrFIGhvo3Zk+pxrlfrTRdUjvNpQDj8X3spZoQamOaULvcviE+0kW6vfs
         xak43ji1hgUrRpcmp/6iqCtI+cUw2ytPdZQaX48MlbycRONFJzZS6jVd8eW7s9dQxIkB
         VZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794220037; x=1794824837;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JBONLngMhhQJQOfezGDZECXON9Dkxwfwb3j/uRdArdc=;
        b=aNAuq3rTCtfiEDabUFfWpqbBShPKJuI7fatoi2ECCUhjHfxmg8Mb/8AvCtLYHUkiv/
         yX9WbrOKWk+ANVQy4QF6phvu3ibDpWMFLTvWKUoieb7aS3ZQOTtHQpk4+TRmPtwhmpDO
         x1gxLqbZLGi0XIbGZ4FtIclTX6+3x4r+RemlSIboj8HcOZebMxOofG+puuFHNd6W81sW
         4Z+TkLqNY8tQ8DgsH8tXX1X0Xg5Z1mauQCzzd+GnwabxcBqEAhoDcso2Nb48tb0XoGT7
         cQ1jdLrM9jy3OluZfddFPdQLS9/b6bWLFpqJJsKh4bAl6tQYZmriQHLfVk60QoctEm45
         KGRw==
X-Gm-Message-State: APuU4Z/ufu3HCNWJ5S3+YtDzAeBV2VM5HR6giTw9ImL5H4mYZFiWK+tP
	rGJkQea0Xq6QTolt22LRwpil4rTB/4dwBpnksfFHzzjFXqDKsWBJsstb82XNfnqkTvpP/J9gx/r
	G2Sixywh9qMi/9YNd8xVmfqVA78MrmB0=
X-Gm-Gg: AYBFou242jJDV6N5SDYttxSFfeHmmB9H0ON6pZf3vb8YuC7nXuJrYzR5twsw0u/BACm
	Sd6F62cEVaBWgKpWtJaBJwhS8mTZ+2YqaVIRnUsU5UUoAfy8b+QAiJ/hbP2/v3pRuVuKk6bNwOH
	frupUWCczyb8gamYbPwFVR+XCjnldjstv/vLiGTM8AhxrzqnUvIYb2oqbIUmGadR6QsjumYIEvA
	BaJiQ6A6u20i7DPSlqDSuUcP5zHmnjeX+S1E+gqXqc+BOU0dpSTJ4UuuUso7VNIhf86eLQMNu7H
	fKAG+DU7pA628jr9wOBeeqqft+EiusQrC1RRGA1mG1EFcl02Ee+JeXbCPZO/py9s2MdEyb8Vuuy
	Y04TQghLk2fXyaI764dD7aBrV2uP4nbiCgPiC2hEEnefB2aGpjsGQK6o2n6aFcPTC4PIi2TtKyJ
	RGVMCckzY1BOjQ8QhSjMm7qvgFyfYiF7rpwPsVc879FArdMqtmGplylfOB6XmpBRhd4v2OSpbO3
	UspjaYRq8oyeE4DM+a8f88uwIgzCgpsX1mkGF8=
X-Received: by 2002:a53:d791:0:b0:67c:1b93:c8f2 with SMTP id
 956f58d0204a3-67c3da679e1mr1595210d50.86.1794220036947; Mon, 09 Nov 2026
 02:27:16 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <xmqq1p8zw49g.fsf@gitster.g> <20261105203344.48513-1-okhuomonajayi54@gmail.com>
 <20261105203344.48513-2-okhuomonajayi54@gmail.com> <avGP1YMrzFKIIsU1@pks.im>
In-Reply-To: <avGP1YMrzFKIIsU1@pks.im>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Mon, 9 Nov 2026 11:27:05 +0100
X-Gm-Features: AclHuK_NE4ikvRx-tOzo5Kfj-myEZJXFhV1CUevzQJ5tEqT79oFMfcx1YGu1fPc
Message-ID: <CAFpMFfBghbSSF8Zasok9CzA=1_soxJpjeRxJagSnaLygPDfcXw@mail.gmail.com>
Subject: Re: [Outreachy PATCH 1/6] notes: store the repository in struct notes_tree
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com, gitster@pobox.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> I think this function should continue to receive `struct notes_tree` as
> first parameter, as this is the subsystem it belongs to. While at it,
> and as we already have to adjust all callers anyway, we might rename the
> function to `notes_tree_init()`.

I put the repository first because most functions take it as their
first argument, but you're right that this one belongs to the notes
tree. I'll put the tree first and rename it to notes_tree_init().

> Okay, here the arguments make sense. We could likewise rename to
> `notes_tree_load()` though.

I'll rename it to notes_tree_load() too.

> Oof, this interface is cursed, it really should be refactored to not
> have implicit global state. Arguably, this default notes tree should be
> either dropped, or it should be stored as part of a repository.

Agreed. It is the same global I mentioned in my reply to 5/6.

Thanks,
Okhuomon
