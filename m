Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699CA5C99
	for <git@vger.kernel.org>; Sun, 17 Mar 2024 04:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710649643; cv=none; b=sD59WXxBPb7a4ftRocm6h2OxkiobFJrduerT+UK4sNiaOZj7Gjz4eOyPVF2ygS37RnQXofYrMYOIBuMT+9x9HVGFGz9PfwTBTkRsZyI1XX007ko3SSYjI2G1NfREZmDORb8fCSeD43mPNaFAn2BRr624E9eqKweCifP3mLOruUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710649643; c=relaxed/simple;
	bh=gCwUdviHuWFdzbc5VPH4BvCnklLomwioo8Anf5mXOrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGFzzRTNU0gPTJbS4duPvFHUxq0D9i7tZ+okaKE/KGUFMrKwxlvqwNgOA+oXH+UCro8KVIShodmeBCKH5/qve3l0QUaeZDBPcXnm1dYmAHeC+Z58rvDRMi1PDuRkL6o10mWs7H/exEWehAZ1P2PHL2PDluLj6ifsXuBcE0eob+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-690de619293so21356276d6.0
        for <git@vger.kernel.org>; Sat, 16 Mar 2024 21:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710649640; x=1711254440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCwUdviHuWFdzbc5VPH4BvCnklLomwioo8Anf5mXOrg=;
        b=qCCAI2aEXnPyQMkkQb6oepPwYO5pfRR5qZeYShIjSJnzuM4Pfza9nyTvpgKoBDqCVV
         Zwrh3d4cu2jFnuBatkYFso8LsPcUXk+w/pq/U8K16VH1Btoz/T5XlT1XtzRb7jHp7hFj
         MLjwF5I8UR/h8uFf/GY5Fp4KoV91n8c4mqQfeDQZoWOJrArBiVf419Kzv2wXax6doPeH
         iv+dGsuNqUe1JVpng+DgUQaQr2XT1wRAnoxrLRiKOCXuMPFtLKjPW5SIpvNEUpj0JiMt
         2sTckS/FPDyjMf36RRWTX584pk8E682CeTTAeeWh+++fZr/R8q1jSpAyTJoKL6PiFbL6
         8esg==
X-Gm-Message-State: AOJu0Yx/wwpQ9ZsfETXVF8tAccJ6UjAxOv7lYVazVG/0hieU1YM69VJU
	AavrFs/GTXopCoG4qsta2OOffLmxx4jwBn8aEO3/l58lZ2ErDdUncpSDpw1ifjDbDzF4q8/Kitq
	IRvpvKSG01MJWwhzePtCWl9+ZWF4=
X-Google-Smtp-Source: AGHT+IHtXKcj6LEtxwmjUdIOsHf46kJzeKwO3t6Pb2kkL7e8CMjCABp2aKWfWkJOz0wm86pZjMWS8QR8WwOsRT01AtA=
X-Received: by 2002:a0c:e912:0:b0:696:14e7:18c1 with SMTP id
 a18-20020a0ce912000000b0069614e718c1mr128390qvo.60.1710649640311; Sat, 16 Mar
 2024 21:27:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710646998.git.dsimic@manjaro.org> <9a73e7d3cbb9ea210ed1098c5a304b0f5d5e1a2e.1710646998.git.dsimic@manjaro.org>
 <CAPig+cTVmQzC38DympSEtPNhgY=-+dYbZmkr0RTRbhG-hp2fmQ@mail.gmail.com>
In-Reply-To: <CAPig+cTVmQzC38DympSEtPNhgY=-+dYbZmkr0RTRbhG-hp2fmQ@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 17 Mar 2024 00:27:09 -0400
Message-ID: <CAPig+cSuiA5go7XbbYQqEmkASn043ByoHD4aRCYxNR-YrApBpA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] t1300: add more tests for whitespace and inline comments
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org, gitster@pobox.com, rsbecker@nexbridge.com, 
	github@seichter.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 12:21=E2=80=AFAM Eric Sunshine <sunshine@sunshineco=
.com> wrote:
> On Sat, Mar 16, 2024 at 11:48=E2=80=AFPM Dragan Simic <dsimic@manjaro.org=
> wrote:
> > diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> > @@ -11,7 +11,97 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> > +test_expect_success 'create test configuration' '
>
> In [2] above, I intentionally suggested naming this new test "setup
> whitespace" [...]

Of course, I meant [1].

[1]: https://lore.kernel.org/git/CAPig+cRMPNExbG34xJ0w5npUc3DDwxQUGS_AQfam_=
mi4s53=3DsA@mail.gmail.com/
