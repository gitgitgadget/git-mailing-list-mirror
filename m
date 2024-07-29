Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAA02F5A
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 04:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722227196; cv=none; b=BGhJiSElEaQgrkSh+6n16JrbMMVhcBMw0HlDNO2tODxlrt3XSC3uiLSI4liDwJk1jp6WeRJhk84DMTZPEi2MziVCbxneU4xhVOBsInvz6/E3aG2b/LBeTimFhlPKbqVPcOA96VrxcP6u/9NLpSUni0+lcCqNh4cRrWKitdGLpkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722227196; c=relaxed/simple;
	bh=+y9l4oqeCxM5QcypkwG3aFJBvn/TkmcusAHhuCwdefw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFYztjANWE0gclmS3gjyu0d5+qtytsYHHMb3yG65CAjlM449rEJmIXmFslEFdE7754kMaU5UgUwL/Nk3aQllPxRmk6vHDV5kV35pknaoaoUDt5h1WvhYO81mFI7PnGD23jlxJWLC0d0eLsBHVkr/8/DgORa/HWw3iYM5Q8gYQOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b5d3113168so16893806d6.2
        for <git@vger.kernel.org>; Sun, 28 Jul 2024 21:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722227193; x=1722831993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTXCbJwiSwKIINOcNxcapVIA5AOJfCyRsg8Hi3u9qeY=;
        b=whvD2lTdB8cBw/0VDG6e8m67pJwo96EBaRWpQEBLEqBqlFM3FHkraZGVVjnICAQTSu
         +TObsvWM1UzrfjzAI0tL6UsfFaCuDQ07kVIYfUEAk6VvNiXcBlWGwdDQpiVrxKze32SJ
         KC7wLUHfJNNNg9MFHttZzNtthskvWgln/AwamYu19UXQNHKhklf6TfFeiS4fVeteqJUg
         JNQSm7gavWLP4jEWrua23Yme8GA/CSt6Tht+nWU3uRZShX2T6mF+cRm6MPxSLVgHFv0I
         izaCuS89AEfCRbbPi1yLtptv8Yi6iwn86pr4OM0xmNrDCqMrMWMn5YBGAJOd40t8TPPg
         QLxA==
X-Gm-Message-State: AOJu0Yznp9weQinJmrZyxBK/QiaD/cSYwReMhf5NOjY1iorr7gnftjEi
	jMyqgNUP5qC0G0TsGNc2dniRrtbFnDjpu9cut5OfHKzQUoSGVnL1+FhUSjLqjcH+3RuV9SZ/u4u
	lQPMWzU4DsSsDBpsx83GnbjV/7vBlMg==
X-Google-Smtp-Source: AGHT+IEyDy66uYQlx4MyrdHdk0PRGI/1cFutKUtQIHqhF4/nR/oC/bvPM0keRPNkyKcVfkjzLNG6YPgx71YIvQSNhBg=
X-Received: by 2002:a05:6214:d88:b0:6b7:b3ee:5d74 with SMTP id
 6a1803df08f44-6bb55ace6c4mr86711376d6.50.1722227192922; Sun, 28 Jul 2024
 21:26:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729041435.7618-1-five231003@gmail.com>
In-Reply-To: <20240729041435.7618-1-five231003@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 29 Jul 2024 00:26:21 -0400
Message-ID: <CAPig+cShnMPrtvaYqQS33qmpDu9VDyFK5jADJ995s7vNJB2p4g@mail.gmail.com>
Subject: Re: [PATCH] unit-tests/test-lib: fix typo in check_pointer_eq() description
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 12:14=E2=80=AFAM Kousik Sanagavarapu
<five231003@gmail.com> wrote:
> The comment surrounding chech_pointer_eq() should explain about what
> this function does instead of explaining check_int().  Correct this.

s/chech/check/

> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
