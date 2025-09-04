Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250AB2D541B
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023171; cv=none; b=AIAToI3a4JTKw9Y72+f+ATaU70uf4pBoxvzVgF/eeEHy+ht2E7KH1z8anV4204IMWtES3SF5oQ5Jy0tWKTJ7aDa/B15vBC6XGZ2bgBv/pteeZjcJ95r/mqfYTlzLZkTaZ2y7Q+FN4H9OXpewZoloPD7KaEszw3IoTeOUBPvxfjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023171; c=relaxed/simple;
	bh=e/aksCJQbOqE/VOVMoZlR2PTIqi3P20O5K84N3tEkW0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=LPbnomg/aeCIYgeiRyzgQ1X5dR6YAiL2sJgpDble3/dZmRFuk5Y+4uiL+Dk/AfhM/9UCkkMFtrYHYrJHWfgKYSFpIU3Ez8a3IPmEKIwYiCk3WgskvJwLoX5LuqSELWqLU2IwhoTVZtMZFbXifccjrZK/rXsq8MktnWFkYPGxyR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoaMPwdW; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoaMPwdW"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e931c71a1baso2495802276.0
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 14:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757023169; x=1757627969; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ql65UX/dGxO8LlbJS3PvCJe7iZilsrpHQZCneEE0YT4=;
        b=SoaMPwdWyLlhf8bsCBeBoIjScAElRpW9ARx/JO42O2HhYHAzezyApzMrcIfQt9im6i
         Od9VZtfziIj4rv1cJLaUu6EAwIc6s4fb4dSG7u5svH2bIv5FkH9rbreg0L3hdk7dW9PW
         Hv1SjwQEy8Sl398Z+7HebKv+C0tkawRN9wpwqkzq09XN/jG9Z1dTJQD2ABpUiYCHcMlH
         MCn8SAX9q7b7eifJmx+DlgrwmUDLf/a2y+WJ073oKJjNxFK7yntHi/T0UEs/I+/1HH7+
         FJdeFkLk9liHw+CQmt7S9Fh1ClujADszvyAYw2HwwvLLaxnvThtAV4hhpkHOL51573Pe
         ZT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757023169; x=1757627969;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ql65UX/dGxO8LlbJS3PvCJe7iZilsrpHQZCneEE0YT4=;
        b=YeymfR0AhEKOwdPctTq+0VPaFS8Eqn4UCO3g2UiioQpGpYKr54/eVwxWzuxsalsEOQ
         rgJxrcKUZVOz6kPZdkpi8kpoZG1Eusu8rOSNn8D44RHcfteZyMkFQgwD1joHFniZVslw
         YDyobaXKH1BYAbQKdK+zK+ahp5ugvvOiwyGUl80YFYx56TQhIdzShCptgoYHTr5COBBF
         iqC2EIfruuQ1DIYUyoOHNecMpMzIdItImGv9bgpW/0ytzdnne58I1o4dl0ycEmlS6gOQ
         Vh+ZKA6UubJalqimABI3ms2vb9KlJkHxdGqeXTl0wKbs1Zj/k+8gN5AE/GY4enaLQifY
         OgLg==
X-Gm-Message-State: AOJu0YyUNgLwU8xczLeDkOnSKc4GCOHssiq4ZkI8lO5HWZLZ/TRkf2Po
	4vIuGkyLd824gGBzAagBSuMqksklihO+BEt9M+LrlCwX3GUdZCeQDnoN
X-Gm-Gg: ASbGncvQEwfxG1B6p1xWjr1MKbjj5VH/5DL7xXCH8lVDLe9C3qUUORUThqrLhUNBZHD
	1GB9vqL6UZV1+bN7HzPDOYXftxP779VD4CFNMTeFzGaXIQt9MUZlR699+nMacljVDpxPfECpYnT
	O5xVYI6DirqT0iVomZp2jx4bS1tTZ9+Xv/qutCwTCWYI870jaawXnS2kQxYSrGm1DsnXdtIZF+u
	ZI5Zf4zStfhGzJA0v/dh0y/1HKOGhNnwwEv+tP6SUPCW/If0Vbxlw6IHAMC4jxvcuE4z/qSeIOD
	ti0VOtLb1o+/5KUoUQIEdi/gMLZoDPCIBumapcfBfJ6oZIaorc72bKSaAI5pigTKvaVW9eq45ZK
	ghlFMH91QN0iJqh40sqRB0iXBu7moHFmE/p1qH3clvfLk2K878tlLU52qAb8M
X-Google-Smtp-Source: AGHT+IG+lF1PcZRdGnLvcVU5xn34sLWgx+1o43kp2Y2Pn2q7xUe4Fae6NrAw7UZ61p9PG1HSrXI1RA==
X-Received: by 2002:a05:690c:6803:b0:720:73:1a11 with SMTP id 00721157ae682-722764fe1a4mr196031547b3.34.1757023168791;
        Thu, 04 Sep 2025 14:59:28 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:3443:acb0:c14:892e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a85ae106sm24422527b3.70.2025.09.04.14.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 14:59:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Performance (self-compiled vs. distributed)
Date: Thu, 4 Sep 2025 17:59:17 -0400
Message-Id: <E66D04C7-BAA7-48EA-997C-2E399CEE769F@gmail.com>
References: <CALnO6CCEF75uriogAEd5LfORJ-m9OmDcF7ubu-U_xLWwxfZWTQ@mail.gmail.com>
Cc: hanyang.tony@bytedance.com
In-Reply-To: <CALnO6CCEF75uriogAEd5LfORJ-m9OmDcF7ubu-U_xLWwxfZWTQ@mail.gmail.com>
To: Git <git@vger.kernel.org>
X-Mailer: iPhone Mail (21F90)


> Le 4 sept. 2025 =C3=A0 10:05, D. Ben Knoble <ben.knoble@gmail.com> a =C3=A9=
crit :
>=20
> =EF=BB=BFOn Wed, Sep 3, 2025 at 4:31=E2=80=AFPM D. Ben Knoble <ben.knoble@=
gmail.com> wrote:
>>=20
>> I have an installation of Git at /usr/local/bin/git managed by
>> Homebrew. I'm also tinkering with building my own Git (+ patches) to
>> experiment with new features. Today I used "make install =E2=80=A6" to ge=
t
>> that in ~/bin/git, but I'm noticing some performance problems. My
>> shell prompt started coming back slower, especially in a large
>> monorepo.
>>=20
>> For example, inside said monorepo (apologies in advance; output is on
>> a computer I can't easily copy from):
>>=20
>>    hyperfine -Ni -w10 {/usr/local,$HOME}/bin/git
>>    =E2=80=A6
>>    /usr/local/bin/git ran 4.99 +/- 1.69 times faster than ~/bin/git
>>=20
>> The difference is 22ms +/- 6.5ms (15.3ms=E2=80=9356.3ms) compared to 109.=
7ms
>> +/- 17.8ms (91.1ms=E2=80=93159.9ms).
>>=20
>> My build recipe was
>>=20
>>    export DEVELOPER=3D1
>>    export XML_CATALOG_FILES=3D/usr/local/etc/xml/catalog
>>    make -j "$(nproc)" all doc
>>    make install install-doc install-html
>=20
> Interesting. It was suggested off-list that I should try building with
> CFLAGS=3D-Oz, which I'm having some trouble propagating (with V=3D1, I see=

> some initial files built with -Oz and then later some with -O2??)

Fixed this, which helped with the binary size=E2=80=A6


> But on my other (non-corporate-managed) machine, I see almost no
> timing difference between a built Git and a Homebrew-installed Git. So
> I wonder if the corporate binary sniffer is causing problems=E2=80=A6

=E2=80=A6but not speed. Sigh. Assuming I can rule in or out the corporate pa=
rts, I=E2=80=99ll keep troubleshooting. Might try to install to the Homebrew=
 paths just to see what happens. (I=E2=80=99m assuming the sniffer uses a fi=
ngerprint though and not just the path.)=
