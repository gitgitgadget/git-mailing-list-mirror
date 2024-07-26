Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800B046BF
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 19:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022283; cv=none; b=Z9UhaFk5AVxjj9wXWezt2qOxBGC3IkAX7upTYyjpiSsGSoioxWgHoCquSP6MrCh+wrwV8xjQizMAf/my9objr1iCzhEuCc4irYg1WvtEvhRub1zaPQMigw9Ps7FWzkI3zfab3t4HTId1XZkaRsgWjtyAfadC4zRbamtLFFUOEtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022283; c=relaxed/simple;
	bh=wBBV+UpfE16oqOGt6oJwDNrHJXuZI6ERmiFrk7VdriQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/6ItJ51YS2a5V2BNSV3RNzO+RRGnN2EJ5+WB2FuSKGf65Xp33Q0P39Fpd73lCLTRYjGxLKl7ETQzPfAVKVeydXkoksTC/SfsSS4whoP1LucyHx1H+I9jPiitTcsQulR91NvlXXvusQiBDJ3NgBoGT60vMrm4m1kCMKHkCISoyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b79b93a4c9so8747436d6.1
        for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022280; x=1722627080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zi67MMIS4xSQvxdcgShOebRvLprTT7OnXab+iPNYYU=;
        b=HsOuMKptDxSmtuJa6nljUZ2kBMZUvIOV2tA3aLeBGRRvJ5pGYgHI3pwDvFpnDJ1U87
         /IsZiwCvFivJNJdlPITSFTxTDliq5C8It/Wd61RFDy+5d9P1DPcV3dYvJqDdf7cfyYou
         kWPeeyefF6Ydl9V/YxTjGtm3r2Il5M50zdnXp98hX+50xEwM8NQnpUacVG/XgphTKNTZ
         ucANMbv8lmKTROGhOFUdUzNU0hGWLd0/JM99vT8Zp+rOF2CeHuzzLEAXjjVbpXvUwmIM
         /CkRvS3S82mVTqn0xQyaWf+Trt3SpcNdj/zXyFcMihlf1NOFQFzxUAVJT9TgZBAXH6a5
         zN2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRI36K3ivla5EU31q/C8AzS88Bu9GwUiKs56Kc3FUxL8BfkwOv+8S228iahvxFCTL0NLUnL3+MLOlIPLzjVXaxrUVW
X-Gm-Message-State: AOJu0YwpVXDrgut7sdjI+OgMZmXD9tCzhHo9/9Q94Eo/9MDRVCHK0QdD
	vwg15fboob4xbGVraiq82MC8dKC/3MuMlXRpFdi6wZDWrhWy2c0ekKBgnK+mzx0SYMxF7Ql/Qaj
	m/X1tGQcjY/yWigo3UAVxnQtSi9s=
X-Google-Smtp-Source: AGHT+IF9U37T6TFxtvr2hJt2QX01bpu6CzIKehm+Hoz7iOEter9WSODGgxtUsB4Bwcy6K3ljKVl5OvqiggwYCXNp4rY=
X-Received: by 2002:a05:6214:1a03:b0:6b5:1cea:649d with SMTP id
 6a1803df08f44-6bb562f96e6mr10480686d6.11.1722022280350; Fri, 26 Jul 2024
 12:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722065915.80760-1-ericsunshine@charter.net>
 <20240726081522.28015-1-ericsunshine@charter.net> <20240726081522.28015-5-ericsunshine@charter.net>
 <9d96b89f-f4e4-49f4-aa59-2c229d3988e4@gmail.com>
In-Reply-To: <9d96b89f-f4e4-49f4-aa59-2c229d3988e4@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 26 Jul 2024 15:31:09 -0400
Message-ID: <CAPig+cTKnWjaTkh_TwCKqu9Yks9KwOfe_+3xON+ErGYucLny9g@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] check-non-portable-shell: suggest alternative for
 `VAR=val shell-func`
To: =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Kyle Lippincott <spectral@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 9:11=E2=80=AFAM Rub=C3=A9n Justo <rjusto@gmail.com>=
 wrote:
> On Fri, Jul 26, 2024 at 04:15:21AM -0400, Eric Sunshine wrote:
> > -             err '"FOO=3Dbar shell_func" is not portable';
> > +             err '"FOO=3Dbar shell_func" is not portable (use test_env=
 FOO=3Dbar shell_func)';
>
> When someone blames this line in the future, the message of this commit
> will appear and be informative.  However, I think the message of the
> previous patch [3/5], which also touches this line, would also be
> relevant for this context.  And it won't be so obvious to get to that
> message.  Therefore, it might be worth combining this commit with the
> previous one.  But I'm not sure the change is worth it to have a new
> iteration of this series.

I did consider combining the two patches but decided against it.
Despite the fact that both patches touch the same line/message, they
really are two distinct "fixes" as evidenced by the fact that the
explanation provided by each commit message is entirely orthogonal to
the other.
