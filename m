Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C14C221735
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 19:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745610898; cv=none; b=Lf19bmTbJgwTglx/BnXQrqwIcU+7/NIFWMjTQGB+ii+7k3+ZUCXK/+w92KN7+05wCiD3q8cjv/bZKxM40bklMWctMt2k1w7mcUxAYgzoukm39w8gekJKSSeuAXuveUIHxYXyiFVl32w830gNP+dPEP8CbvodMLitcBAN6j3yEyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745610898; c=relaxed/simple;
	bh=BGB2V1BsxBf8s/ivGjeDh6qFCYkrv83C+n8kFqM/DGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfhNfA6sf06paRSCdjh+E87kI2JC35VU2oYh7p2HlUNBDPgBpPGvOPfvYecS0LOk+X1cK4cCnrzEGC5OVfra+IW7K1tSceK8m4uIleCr2zRNv5xNknlx9Zjrx2t3M9OAjOgish3xSvft4xqFzGt9OvmGAsg1vsiJs+1jJI6ukX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f28994823aso2165616d6.1
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 12:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745610895; x=1746215695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QlGoQs0LFrpQ/itOHcRxr+51r2pzTy15DZfqUFnBmo=;
        b=WK9UrDZWOVSBLH2q++oglJQwE36FNRddeE/trk36PBl6OaeWKF5w0v7Rtuik0KBEpB
         5zCMmJbgjuwYG0Z0fUnAr8xadBzKKbJ8XoHmLOjmAPRpUDFlcwmAd/vOMwu9nOvD6zBw
         R7nUa+P2fUHSggMwtHTXzGr1tVaPLnUdutenreBDqdcStVOSNjt3kDd/9RC9ZOZlDVFK
         yUTAJzLV5KggcFzss9xP9QbPkb7tjutvhFl03MqZq0EmulVdI0Acktb+13O4m+ZQQ5rf
         0jNS1ffxCERV+MVCWcbY71W/CwlgTv7VAMlbc+IPKGYCIZpk1rEXW34bcyMIm3VaAy0L
         QK/g==
X-Gm-Message-State: AOJu0Yxm4paAkUhQCXq158YICfnEHRR+c9+cqciGAOrOet40r87sEMF1
	cWka+tbD4Dp90KKmjKMfS3UpPTXIBHCkgD7SkcPhN+xfZx4LAyhWv1TDiibcQUm8ef2G2i2hcgK
	jDAQHXWa1wtY/hWCjpth3U/moe0nKph6PZVw=
X-Gm-Gg: ASbGncskzQcRKlpCG75bYuANPHaAZc5bQRza+yBAHpRn3VzNIGMzpONbK0UwN/pAnp2
	l5/TxdCJWNEKtV1r1oXmsRXr94pXc+nLZ54Rp8DkstVTmPlWdFKhrAmx/bRUWKh9qmvT0NenJy5
	6wR/ZP1tZ1CBqjKA07uAUP/l0uTTOuvQeGI0vR9fdeZC7YPN5h38fMjBk=
X-Google-Smtp-Source: AGHT+IHB512vHocQZNnUxXplut9iYreJNj/v4ohrNY4XMonb0lRlYOdH3S/l+xuDrlBAXRyC9L6+F55CXvek2UiItgc=
X-Received: by 2002:ad4:5b8b:0:b0:6f4:c307:5e3d with SMTP id
 6a1803df08f44-6f4cb91decdmr22304016d6.0.1745610895018; Fri, 25 Apr 2025
 12:54:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAms34P=fuow0kvxvQKxbr0jhqjnBu=VsP=xAxDieG-QA2ocVQ@mail.gmail.com>
In-Reply-To: <CAAms34P=fuow0kvxvQKxbr0jhqjnBu=VsP=xAxDieG-QA2ocVQ@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 25 Apr 2025 15:54:42 -0400
X-Gm-Features: ATxdqUGXZQRiRE8_R83lfqmBxTc2R8w6sPxvJwbIRSPTMgAGKu8bSpDsL39OJ3k
Message-ID: <CAPig+cQ6L60gRGZqapkVdGjo_C_k4Wi1miK8nv5=AZeNXnK_4Q@mail.gmail.com>
Subject: Re: Feature request: automatically read .git-blame-ignore-revs or
 allow global optional config
To: Michael Grosser <grosser.michael@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 2:42=E2=80=AFPM Michael Grosser
<grosser.michael@gmail.com> wrote:>
> I have many repos where I use .git-blame-ignore-revs,
> but I cannot set it globally because then I get
> ```
> fatal: could not open object name list: .git-blame-ignore-revs
> ```
> so please make it either the default for `git blame` to check that file,
> or add a "blame: ignoreMissingFile: true" option so I an set
> ```
> [blame]
>   ignoreRevsFile =3D .git-blame-ignore-revs
>   ignoreMissingFile: true
> ```
> and can use this feature without constantly having to think about it

Relevant threads:
https://lore.kernel.org/git/pull.1947.git.git.1745088194384.gitgitgadget@gm=
ail.com/T/#u
https://lore.kernel.org/git/20241014204427.1712182-1-gitster@pobox.com/T/#u
