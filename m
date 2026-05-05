Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A492773C3
	for <git@vger.kernel.org>; Tue,  5 May 2026 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973897; cv=pass; b=RzSl3hkw6t3qajxLQV0NVyXUjSsgxxU2DyqHTrKC/3nGxcIJjLfuFdYJhaaDXfBYOaOD5+3tRhVi3tFktDvh7oYJa+mK3klmRnCZsQZ2W8HIms3qxPXEFC5gBmKnv64Mthfkp8Wdvor6k0uM+oW765NAFU7gci/7VkvjlxOgc24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973897; c=relaxed/simple;
	bh=0CFy27bR+qK9LeBX4V5c3oHbrdcmOjKr5d0M5lyx1o8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNjQlXss+HciPYPVLIhOK39qqvdTFZGxtxhyz1kU8APhuWy0h6surCEeoE7JE53nfskYFZKtRgOmHyBJgVeM3jBQF4r2dvAv5D77lp1bshg6YAraLCBiBru1BPOJwShN0IqpjUMcQKoxAP3ZN0NwpGmVjSAJsaIdFVf3H+jMP7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6aesF6p; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6aesF6p"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so795831966b.2
        for <git@vger.kernel.org>; Tue, 05 May 2026 02:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777973894; cv=none;
        d=google.com; s=arc-20240605;
        b=ejQk0okpzEJqJu1RneGM99Mhx7bZoTrolKIXMeI+yTegynWU9+9TupeLG0ZW09um69
         7KSJO84xxe6r/frt8tzjU8c+FKcONfOmF463O+uiA3grcUtnpV1BtxXunUzCg8ftnLAZ
         7SFxoryL3+dOT03xuYijGKRNBN/B3Klz0E6zHIs05lKcxugCGi/8w54s0GQgMo+09NAX
         t+JN5qrKHM7W552BjnASzgkPPZQYwUUV7o5y1ifo3UcJumPveHA6o53S+W5Mm1EfDsRs
         QUsBoyYhctIuQR+ksjXT1xR3PZl7tEhkBvVJ8rp5N9fdP14GuZKKr3rRlhJVCOIv3/SA
         1rog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m7Bl4c0j3LckSpCrOU+x54esEgUjsJCVbXplMlN8C6k=;
        fh=TvJNO+rJreHiIe/P9PBSp2UjZQ18Q+mmajMR58IAADk=;
        b=daSYPUcsmclu0absfdJ/jhdhORZw7eCm5z2qMqmDBVZfb/aGdVzl/qNMFr32wcqTSo
         3HhqIGKmbOss54eiQylC31zkMLvWxTrTGTVQoHZJiTymFHhxIk0qtq1s/3nKFtuSFUWh
         mSXSVx6bzHULmbexQ35+yJwuH06AMwgwlOtK59JJS/dMLRDj8ODYpsK9Iec72UufO5mS
         8TjxM4aRGLKuEpCUwSHGuuy8wm7RRNpNuJQZve1VMko/9YVvC/3RK2uhcwHyJwVQq5Y4
         HstvRxFQVHmPp6MsE8hyN4eJauna/Q9Qok8uNiOm4X3q2fZqOiu8yS6EPFZ+xiAakqhy
         XEjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777973894; x=1778578694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7Bl4c0j3LckSpCrOU+x54esEgUjsJCVbXplMlN8C6k=;
        b=m6aesF6piLgfKVuyLMubc6TzTrgrQ57DKSVu4oDBDbdx0Et6A49G+JUQ529/Na+B/p
         0IQ34JtmQjOtcEjHUYFHj5FuWncW2hGjwjZTvQ42mTMbQeueH/FoDYCSgn8tKM6+7EgV
         TZ/6hfn1a9sqeTn5qgLxDF0keg+mCVWUas2+VTPJUeg7A/pdsjO7oKEAiCEWYwkSo2KH
         DMbq7sdOqXet30P38N+AOr53BRTNUht4YBMdkkbyuHldpcbZa8tR3dql80mYr+Bpa3Oe
         idoivZzKWGoXQM5ibXUI5uzUtRyF08NkrX5xDTrtajftF+ME8mefEyx6G9ZeG/0d5hrT
         oQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777973894; x=1778578694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m7Bl4c0j3LckSpCrOU+x54esEgUjsJCVbXplMlN8C6k=;
        b=Ai+DLz+GtKLqwxQrsii38rStQdwvoY9mp9A5pSLkS00EEivKK2EJXKc1KTeu/9xHhn
         wY39G1rPwBAYlSYB7GxaTwS5kcX03ud03vITRQ0ouh01n2AjiErAzAOJD7RmDTdIwGhL
         77hMuQPn6oHUS3EklvzAcOdP54r83f6uOUVhohSQSyekpmg8PUe3NBzjT50OB0oSAhEO
         ptsxSWNfUCXrOr7eY5G+rbPvgBjlfa4TfuqzE6cRe5mSD2aDJS4ossFhvmqJG4x+qvRH
         fG58NDXFe01YaQQsOh7OEXextmr8FbolsoUJ2XwPoLn9VPYJZZ8y3lPwP3mA0+9xj6Gt
         rz9g==
X-Gm-Message-State: AOJu0Yxc1Tc0gXXKN31KvL3iaYMZ5VBCBSbAYydAdxRCLn8nDD3XMAHW
	DAeB6Xaqtjdx+EPbsX8AT+iMPBJ60ZFFECZiyGWxWos3S4dClb1MQev0nrZV7qcNwlvMTj7UIFW
	Qts6zjBDcgtUTfcz9qUHNlkaKAmugg/NiEQ==
X-Gm-Gg: AeBDietb+zUNlXSW/uZZXE2eKO32IJdPHc7usc4CzaWtRG6jFmCKWhjuUram7NLgcUj
	JluqVxZgqh1aDPnKcPQIehFUXnsBx/2pwBDoDLnLG5hUKT50H6YBtL8QRt9gQR2F+YFHwu3OaW9
	it7BfTVaf7QQjv8WgysSrPBnDvE+c7SupfLkJbxPhhesXxEcJ2bWfrOOrd2WsYyvifqQuoHhn9h
	ZLs5vUbS/ewXOapxjZi2DTjyQnYq01PA48IXGo0FCDcOApOwLn6jjBgaD2F3QmWVEFoHCvk2HKP
	hutY7Bi5gM7gXEFo
X-Received: by 2002:a17:907:6d27:b0:bc2:9733:9ecc with SMTP id
 a640c23a62f3a-bc29733a257mr446473066b.32.1777973894019; Tue, 05 May 2026
 02:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2d3f5504-f5dd-4171-96e8-b5633b6a1f5e@app.fastmail.com>
In-Reply-To: <2d3f5504-f5dd-4171-96e8-b5633b6a1f5e@app.fastmail.com>
From: Mikael Magnusson <mikachu@gmail.com>
Date: Tue, 5 May 2026 11:38:01 +0200
X-Gm-Features: AVHnY4Jf0dIHrcjaDbstb8l3Oz6LEp5BxBFthIPH0l_IxTnDf7LeizF9yc_KEDQ
Message-ID: <CAHYJk3Qvx2i-K7ozLmwyA_S1tbRhf9i2EZa-5sfzBwC5aebeQg@mail.gmail.com>
Subject: Re: Git trims the last character of content from remotes
To: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 7:02=E2=80=AFPM Hugo Osvaldo Barrera <hugo@whynothug=
o.nl> wrote:
>
> Hi all,
>
> When I push content to GitLab, the remote server sends back some text whi=
ch git
> then prints to stderr:
>
>   remote:
>   remote: To create a merge request for zk, visit:
>   remote:   https://gitlab.alpinelinux.org/WhyNotHugo/aports/-/merge_requ=
ests/new?merge_request%5Bsource_branch%5D=3Dzk
>   remote:
>
> When the width of a whole line is the same as my terminal width, the last=
 digit
> gets trimmed off. E.g.: if I resize my terminal for the above to fix exac=
tly,
> and re-run the same command, git prints:
>
>   remote:   https://gitlab.alpinelinux.org/WhyNotHugo/aports/-/merge_requ=
ests/new?merge_request%5Bsource_branch%5D=3Dz
>
> From what I can tell, sideband.c prints ANSI_SUFFIX =3D "\033[K", this es=
cape
> sequence being "clear the line from the current position until the end of=
 the
> line", and this is the root cause of the issue.
>
> When piping to cat or to a file, this sequence is not printed, so the out=
put is
> fine.
>
> Is this a bug?

grep has the same bug with --color, if you have a line of text the
same width as your terminal, for the same reason. urxvt supports an
extension of \e[3K to clear to end but not erase the character under
the cursor if it's wrapped (but not yet moved to the next line). xterm
hasn't picked it up though, so it's not a general solution,
unfortunately. It's a little unclear to me why git prints this
sequence here at all, are we expecting that there is already other
text printed on the line? Or is it to clear cells that may have had
another background color when the current line was scrolled in? Maybe
that case is more unusual and less harmful than actually eating the
final character, that it's not worth clearing?

--=20
Mikael Magnusson
