Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6A615EFDF
	for <git@vger.kernel.org>; Mon, 27 May 2024 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716840750; cv=none; b=fTYzzVsu21vYBwggL4+vvpYofX9ekLZrVnhGwvX1YPslstdwsaoSLzuNkGvsQVqThmwxiigiekh0kE2uZMb1SRW4VtjPN/RFZOg86yhE/5pYiodCwgl/KiLOESJDrj3O9lQXjalAuCKnDyZ2/5QGsIvgFTgW4zvUQ5n/tIJq858=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716840750; c=relaxed/simple;
	bh=y0Gf5yfsaPC8BYTwn2AbC2SgVENjTRllz42y2Xn1Q20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzKyOrGZl5GGG98ZkeS494UO2DBXB078rz+jKUTYZ3d9h142Mr2QnB4dUk+Neajhc+OWdRpff6VOwBulrz98WNQFtf5ddj7VIhL/UQOXv9AqztzDH1iOxmptIIWEl42BJmu+Z2/tqcKmmGS2O3tPzL1zm0xLvXh5W+yUKCxG2qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6a8d467aa23so527526d6.2
        for <git@vger.kernel.org>; Mon, 27 May 2024 13:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716840747; x=1717445547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0Gf5yfsaPC8BYTwn2AbC2SgVENjTRllz42y2Xn1Q20=;
        b=OVvAjL2wLgCu6KhgMgKnAOmOtvHqtjYiUgkRc4qDfsLApFMyQpHmqWY0tk+XyLfLY+
         h8Jog+N2G701K0KxM6XVh0e4jtUboB+E/7ck9f/E8/Mq7T6kVCIpCydvcfGLTOK3qi0w
         a3m58gMccvNh1MgA+LjfgMpMX0TuK/NI4I2s+0xVubxhzPON0QQvXnCFeqy5GihIpU3m
         nOaMMdLbgkxZwjHZcEAtiDbeWcmyiiNwm1562+owrIwHnQp36S4OQoPXs/pxohz57DhH
         1TIO/qlABd7tVOXALNhUnu5X27gZfrKIT6YRKL9IllmPPxbbDk8lMjSe+Yar4mHQphMm
         uI3g==
X-Forwarded-Encrypted: i=1; AJvYcCWT9ZoRWURfdnHhnewIzC3Oq5kA/aFIEyPptRvBGmbu0F7YY34xTeLsnhoxXEacLNdKwPhfnCnFID0fgB7Ej6l9D6dt
X-Gm-Message-State: AOJu0Yz3j055SypkvGflt3Xs9HkOqxE7x9De7TleiXA5bXHu5OdBBdc/
	gs3CnFltNyZ7Lk4RJ3vn8JKPitVEFbz6/0dqfmyeRPBbLqasiHpO0Oj8X2EaMZL27as5DVLdUSp
	xVGe2mIZ9/pzSbFbiHmsbfvtYgNU=
X-Google-Smtp-Source: AGHT+IGOuMNGiYUm+QfxHDinn02Nj0xZJAQ0r7Lj6VnRlDM6wbWhRuHqXBmxNP7/MKw2Wv0R94XR3XRo5vydBbFrE+4=
X-Received: by 2002:a05:6214:3102:b0:6ab:7034:c657 with SMTP id
 6a1803df08f44-6abcd139439mr111419526d6.49.1716840747411; Mon, 27 May 2024
 13:12:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de>
 <20240520190131.94904-1-ericsunshine@charter.net> <20240520190131.94904-3-ericsunshine@charter.net>
 <m4xqop5u2a4okzr2svg7j57ey5x5fyfqrqitwwzhh4uansuu7v@uy4tznnci6dy>
 <d655399efccfa6219cd982035c0408f9f084e344.camel@physik.fu-berlin.de>
 <CAPig+cTfqk+tbTAVyPj8YP1uHx1D1swL84h-4p6OKBV=dDRX_Q@mail.gmail.com>
 <xmqqh6ep4qoy.fsf@gitster.g> <CAPig+cTxMTAf85Gyi5eEYAM4pOTq2UTD1=oCVBy1q8aSF3cn6Q@mail.gmail.com>
 <518a5c2f34180ee2e6b674d8dc5a66b8a2d345f7.camel@physik.fu-berlin.de>
In-Reply-To: <518a5c2f34180ee2e6b674d8dc5a66b8a2d345f7.camel@physik.fu-berlin.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 27 May 2024 16:12:16 -0400
Message-ID: <CAPig+cRyLWzcs0Z1Zhi5_w8+Y53nfu44KgnMjETgo0ZK16W25w@mail.gmail.com>
Subject: Re: [PATCH 2/3] chainlint.pl: fix incorrect CPU count on Linux SPARC
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>, 
	Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 3:49=E2=80=AFPM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> So, could we get this series merged now or is there anything missing?

This series has already migrated from the "seen" branch to the "next"
branch in Junio's tree, and according to his latest "What's Cooking"
report[*], he will be merging it to his "master" branch soon, after
which it should be incorporated into an actual release.

[*]: topic "es/chainlint-ncores-fix " in
https://lore.kernel.org/git/xmqq8qzyifnx.fsf@gitster.g/
