Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794570067;
	b=FlOdcStjUs2lnfRedYLpQh6Yga+qwY7HvAuV25dz++VjiQq3aSuZe0HH3wA7OxZAC8wP
	 4IpUrvde3kmZeoUaxKGqBHygouNKhQPzp1BJ13c5DbAjWf/f6GJnJOF+RhqcKwOT8Fcj7
	 GUQGxthi3ecHW/RRSeM+tjcFl8l4KWu/CzG0d4cEnRlcZxsoGeb9dnK+GpOG6B/Qd1Ns5
	 AJd5Y8POOoQZaiSqftBR5gvtXC+DTY0s/LKkfglmShl+zkQR3PSWGI8T39wiv60JHd9H/
	 W3wL33BZKOhBwaj8hrjvFIL1d+ciHi6j4UY5cdct1vDDel3BMKYN1nF3x/wzKMLgLzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=X937XcxarNU2hTAJnDSl7S3O9tRbqHYXCQpz/Rnj4OE=;
	b=gwRDB+np8M3jH+tsiJHTLR09M4ULyy2TN2pSrwPGTMVx0s+frUeiBqlXEA/ONbRh9WWX
	 A8rHl5FGRWZWSCgbw0Ho1BA+E66VLquaLkUnDrl/B6yVsWdrY+Dv0RvpnA4X/ylJ9ZP4U
	 HLVXc6mLi2zSYuHy6nIhFG0hFkPRkgB9uo7akhQHqRXCReE90uAX28+6wClYp4t+HiBtx
	 Eo+tyFqHs5OP7giYM6760vThZz+Dh9n09N810N9lhqg43C3zqlZREtrQ95sOWGF4+QSw4
	 WwyPPljjw7ytQgeoxUdEvGo3go3AM8tawbDKay8B6OpFPGNDToKrHwkCtpGjeVhMjmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pjQyVfyt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE23606A321
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 11:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFE23606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pjQyVfyt
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67be1e468a8so596200d50.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 03:41:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794570065; cv=none;
        d=google.com; s=arc-20260327;
        b=W6+Fe2J7lFclj2kFnAl3vVCoqyP5MVSem5xR5KFI+c2pp9aO8eVO8RiKBtfKb6sdfF
         7os8XaYxKY2skyYdtUDe7dPq4wWdvbZPEd4ZoAZvjFpZCKYWZGO827aG3/BVkjnV6LnR
         lsx45+eT6gqyuJmyckkzNnpU4N9T40G39KZqpEw4rdxpxX5bF9pwPSOOrlUgwy0voEsB
         maCu4sGG0p2ir5ITHQvLGgTJb22rPLbFplzpZbGZDy7Fg7lUZjUd1g2DC9HSmfIibgqm
         Ts6YY322/e7r68tMAECLfEEXOBGbMK6HdgimfnHedORIPOXM/QviLEFyK88cg3dN5uaa
         atlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X937XcxarNU2hTAJnDSl7S3O9tRbqHYXCQpz/Rnj4OE=;
        fh=u2HXvIO3dn789rE2mqcm4j8Y11yJaHQ3Ds9eIxaXqaU=;
        b=L7U0u2aZERRg2TZH6Kv1DN4O0VH1DRb2NFQ+pdXPbTJf9TClBNpNRtP41HBdeoe9PR
         /pxfh1BOSjJUkHUJf7imM/C1wM8fGidwMeB0dTEKXad9koxUQmHRDI9xEYH5irMSzGPE
         5ELnodC2dlImSNv1TuznqOA84nfKioBHXW+uBcIynKAZilTPvcOMrRcGASTRGjXhkRz5
         lhIdc4cqNaU7B6aUYCeQu9c4+H/y0FyYKv+mbYVXrdsf0MviNme+fIUn8O6GwfXfBmWq
         qdvvdve0th4zRkoh8LgQ7MwlhrLTn3coYS4OqqKHTs/qYOvk5NNZ0xGq8g+rrnZjoGi7
         7K7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794570065; x=1795174865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X937XcxarNU2hTAJnDSl7S3O9tRbqHYXCQpz/Rnj4OE=;
        b=pjQyVfytU2M3lCNpghhcR0AZ4LGRp/ubD9Ouc6q6M6z7iNXu8PjUeHXlCPRZL14W8a
         ly7OPa6aou8qSxFa3ZTv1sg/LqMaPKiBdnk+QC3gnPX6vLd4m5EHy+7+9bFs07rdqj56
         JBDF+ZXHSqtnxg9ju+RXbvyV2AVcw4bQlmsfdFjX13i8adG83FzEg7IT2u+ybRsTZI+l
         qlS0DPyZOHR3BtnQWARomO+mjVEfmlYVgpbjZffZG6NRGMzkeAyK4+gTKOH+5yC0kcKv
         YIu+h7m36joLexaNX1GnFHmP+HfUIQ3KlWyc1gbfnkQQOAPBaiE8sGBYD3CpZlggCmOT
         4gJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794570065; x=1795174865;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X937XcxarNU2hTAJnDSl7S3O9tRbqHYXCQpz/Rnj4OE=;
        b=Dzl230Nm/LJsocqM8IO3iBqPn985GtldHt6jkTBOFFs5FToKulINXZdmT9aS3pXTfJ
         dcI+y5eWN0CNPOVkEFMNRqElLmSBnKW0nI28yTHUD7+4NDrb057yrxAsgTsTIi8CAhff
         vt9R82uilxsY4hPfIFWTdY+Pcv7gXDMR+KCUFB6U6CAcArlbal27C+GXYVHU3JgeEM9d
         Qbw8Ro4DklgW8h5jzBjmLZTVCtItWbfJIrZuEJ1BFOEfMso4KV1gPCOw0QTmqv/3S73o
         LNqlYaAAVK/MALYfHuiytgwrzZfgdu0k1Iq+ATzVqOB2o4cO4WJeva4Fl/y4yXJjKQVb
         7OYA==
X-Gm-Message-State: APuU4Z96ef9LLxhCIXJGJo0SKblNZoVqDASUyFIFtT7+Pv+6xnPii3Zx
	XJKQ+Xka0mjsco+KNOzk6OypYCIozFklHSBmlryfb5/8ZzpVB4HGdXKBFZPYibA3La3+UHuitdL
	RJ45TqSzsXjHSRo7zaxQrryTEIWnbr8o=
X-Gm-Gg: AYBFou2UfYOmMOjzy5Wetz4iC/dDarpfJyaftbBCuOHuJjgzSB+OlwChyDEO2EfuYxq
	oIDGkg/ygK1BZeZdw9+fVSK7hIaHmCau8Z8e5bzGWuZuFFNBLp83VtHdg4ZWf77hRzocQt3+5y8
	0LtQeu0eHiU1mVZrzEMfFjtKWrB24Uc8DzPKT+YDPS8p43Aev2IUnP2WUGiUPSORaBue/3xxnrr
	jUl6HFhVP7UsuFI2LwG0x5iNhkCYJ4fsoLxZTjRrPu39zn4KTug6N+RTRBIZoHvItf9uDFMxPjV
	04dOeHV4fAiq5wtmg09MbmSrNYA7EhzNXWoktjGKaUP7PnLPnqIDp6nqZDQQsDeil0FolFnR4FN
	qmC/QCryGZnN5inlT0KNj/VngLQoWefaQTpXFPySAmP7Rt2Bz98A0OzUMFO8YDvp6v9LxZNze9f
	U6SCxCDTQmgED4Vz9FZG5cPfg+iDosXmJx1MGAiRETvLWlAE9GX+wK6ZZdtvBoVCFv6Wla6NyWu
	FCCNC0cvJBNSz4ECVliJM2rGaz1O0X9RzG1zAuV
X-Received: by 2002:a05:690e:1348:b0:675:617e:6c2d with SMTP id
 956f58d0204a3-67d895c1e21mr1719696d50.25.1794570065460; Fri, 13 Nov 2026
 03:41:05 -0800 (PST)
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
 <20261105203344.48513-6-okhuomonajayi54@gmail.com> <avGP6txIm0tK377H@pks.im>
In-Reply-To: <avGP6txIm0tK377H@pks.im>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Fri, 13 Nov 2026 12:40:53 +0100
X-Gm-Features: AclHuK-ylCx9RA_5aE4t8cBqRXdmczqCUnD21Ylc0nIu4VKgiR4LZJhCQR3L0yc
Message-ID: <CAFpMFfD_+Dq7-jaeWCXH7CUQyW67fNgGN01n9oU1izppFbE89w@mail.gmail.com>
Subject: Re: [Outreachy PATCH 5/6] notes: pass the repository to the
 combine_notes callbacks
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com, gitster@pobox.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick, a quick ping on this series.

I replied to your 1/6 and 5/6 comments  on. The v2 I have
already renames init_notes() to notes_tree_init(), with the tree first,
and load_notes_trees() to notes_tree_load(). I left
USE_THE_REPOSITORY_VARIABLE in notes.c, for the reasons in the 5/6
reply.
Let me know if that scope is what you had in mind before I send it.

Thanks,
Okhuomon

On Mon, Nov 9, 2026 at 10:18=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:

> Hmm. I was hoping that at the end of this series we'd also get rid of
> `USE_THE_REPOSITORY_VARIABLE` in "notes.c". Any reason why you decided
> to not go all the way?
>
> Patrick
