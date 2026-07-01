Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E18B48A2CF
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910391; cv=pass; b=hj934qqURJN6H7yApExau5NbytQLycdpSIxoD89xemALFARpw299lBUD5isxXXcfvIgj3UZmVifo2AdE+sXmTyrdbW5t5pSIkdQGjrPxlq4OuNtpSp9oCum7vKv0TmWxdvDxxUYvn1ZQxtiWle+UK+v9EZrYoDovpOVQsjuauNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910391; c=relaxed/simple;
	bh=SjFHS8aTBKRnckEk1HyxAPIlXUiYGgqDp6xL/wErDr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COKeMVYVd3gN76VNQQlajWovSwsd/9/6+dDgCPlB7wswm7e9BmUfZ+hLw5JR+wgqAVnIvyL2Uja3oyA6/72diFOwaIjQPb+x38zjLBrSGWMlI8tVi8036Elx+7q8Oi9br1x2zbJJcptOyHIZnGx3KCmMUtRBcGmFqdZbEZnBkZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=KMylai4j; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="KMylai4j"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-664c535f1a0so769587d50.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 05:53:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782910389; cv=none;
        d=google.com; s=arc-20260327;
        b=hCp6WPBoJf6z5N8HteULejBi0j8TRSKSxLiODp70MoR8B20KykjLPh7gNh2QSusE6g
         OqtJ0pLe7uf1YtKYISsGs1/94741CERNHvQ9adk0T6MRjf7rF1BfD8ssN0XgwH8slLA6
         tjVoP0J4rxuS1CFtzIbYBrQftYJh81rgzn+Qd1FrdbT0Pf3pKdyPb/1oTn39eoUEipZ/
         PHHhmIPnij1aTdQjEcTMC3/0mijt7AGsIFbmotBcWA4LX0I4de6LL+pb7KEwjOBUWgu0
         2O28VQsc7+LqmPgOYOgzcBEJyiw7H5eDB+0Ye6ZawXWwYnvkifrJ4YIoK3O1HtpD1530
         RXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SjFHS8aTBKRnckEk1HyxAPIlXUiYGgqDp6xL/wErDr4=;
        fh=uKR+VYiTirLEUUqXdppIwwQjVjJ3XlXDGodxADuehyk=;
        b=OunNLgN3pNrtw85xN+FEtE1OQu3cF/aP8LLz6KXzGr0hmg2DjFwJyuHWGWM/zC/EdD
         X3Dc41NHHDI3fxLr9uMCBszFDCrjMgHU+Y2EelBW6L+hKdkoPc2N8M/50vnwijXTj4WR
         rkHRaiA49Uuf8sy84Uxqbh0MOGnEP1vkmbXQ1lednykAVh+hnr0VEbiQ47jc0Q6n5bEG
         7SKqVd6rV+iGA3u9vH1BQ4wSonhppurgc5DI9P+AyI3NK0HrxKzT5iSpePkWaV9XJX4l
         GJVhuvwdlAbZeYtTOcwsbUbOLq+I/9i5Hu7jbDuGjnjIfHh9vICJPZhCFFP/hdIu4yuA
         53YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782910389; x=1783515189; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SjFHS8aTBKRnckEk1HyxAPIlXUiYGgqDp6xL/wErDr4=;
        b=KMylai4jQVa5o8pwotC5Xvu5310gJZi/Cd3RHohs4GO23HPn7je3432MKCFX6qYSeI
         Nl1b43fzINdPpOiB1QLynczei1UedxrO0RWRBlMgjWVanulrPnnP5PN+sFV5WqN/1QSG
         5fLP6cmoBhhEHz7UFmTPF+747aKgfmscaZkaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782910389; x=1783515189;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjFHS8aTBKRnckEk1HyxAPIlXUiYGgqDp6xL/wErDr4=;
        b=CpJik+NglyQmJFgWJPr72s70cdKs46s0qYqKyBQTjO77t9LIaiJuNU9PvQXSHul5xn
         frxrhvdqtywu+DbJjbFysazknuSNHo0POPcfBH1ip5QaUFMlBQgb9t35y77UhWf/MUS4
         2OZ/PRgzBdWXYHYWIY/G9Wx6vJ9d9GS7pG+w9+2MWxsRXSD6TKfOLWrbEe0aEvVe0emU
         c6PV201ozoy3VFXdD6s9wvciW0C2sGe2hwvXNoTgQz9hq4Xm4z7NopqbglNA2HkXwiWf
         NseioBlTCXc4f9k72Omkgarks66pu5gL9Z2FSg8los1NoVRxaRZBGKYQY+EM9VydfoTB
         qygg==
X-Gm-Message-State: AOJu0YxxtIZIbbIusIcSREDSd9DiEkeoecZMLSAyyHuU237hm00cw86U
	C6iYmqmFm0fJpZI9fbbP6twY5ag+go9yu/m8pExIVIUJLL46RtIcfaUNJERTMls+9iBG7P4x0rl
	D3+HKzmYh+dAuY9xB0gMAZGipUWFDFDmulp0GbEAhR+wO+9gbcdO3A3CmFA==
X-Gm-Gg: AfdE7cmwonURzcVE02psF7GoKhKdyKCcR45yDzzsr7uAE5ZL39UBK87Mjhv9R76pj03
	7NIKTmt8YTTJSJX3fHgB843VN3k2btZXzE6NgKksdfJ68zEZKUnzR0rTiGBP5xCALYfXpR33Lt9
	vCMG2kIDaCfAU3inC/k5t0G3zGWBBaC0Wnw20jx/dMfqUbGiaSDQ74+hHS3tc9r0x2gNZwBP1Hc
	FvtWhSnuJMs/5kbaKp9JZ+nz2brWYGcDo3uH+Ad4CYXwdlACoo8hZTTYiEmv8zXJtlYnTcdqg==
X-Received: by 2002:a05:690e:1308:b0:663:c004:9401 with SMTP id
 956f58d0204a3-66521bcbd9cmr1401996d50.58.1782910389171; Wed, 01 Jul 2026
 05:53:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACwZ3KFCJSqj-fwU8WH0=_53mPSZ-uaxdCcSuEEL7=eyJu4APw@mail.gmail.com>
In-Reply-To: <CACwZ3KFCJSqj-fwU8WH0=_53mPSZ-uaxdCcSuEEL7=eyJu4APw@mail.gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 1 Jul 2026 14:52:56 +0200
X-Gm-Features: AVVi8CfBgFt0mvLCFYXLiFveN3K6iAXKBZFRfi4sdWoO1mTIrOOOYoiGmqfsfVo
Message-ID: <CAL71e4NFn70P9npbppynrjKJuip71HGJwzOZf7ztR9cR6fAsqw@mail.gmail.com>
Subject: Re: A bug
To: Hayk Avetisyan <hayk.avetisyan@tvh.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, I looked briefly into the bug report and I am not at all
an expert here but this seems more like an issue related to
Git For Windows [1] than git core.

There is an issue that looks similar, maybe related? [2]

- Kristofer

[1] https://github.com/git-for-windows/git/issues
[2] https://github.com/git-for-windows/git/issues/5632
