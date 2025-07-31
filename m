Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062A7376
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 19:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753990422; cv=none; b=aj7/evPfBMPwVkuGJChHoNnan6iKnwB+op/ZryMGo66zAfPxe47liWktfGYEu5osdp8Z5Sx6JM/flO0mf2cRa2sMQc3cby8TEVu0iK89V35GE4lZ1vCaPpWhhYg1jNtDwGynsk+hKHYY/eUdwZwu/nqLLrIH+wV4Q7t7ZvNdVSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753990422; c=relaxed/simple;
	bh=X3/iTYpaW4KeUoLYoVS/P+1Ra90sUvIMPc+SJUgACEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3DJTlelhGnhNawCpIg/T9tr5XKq6QQDU+DSuZYawKYxRgvh1yjQGXrTyHh/1718oq0uuX51ZAGTJXjCc1eI17cV8uL2kro2sf5Po+X5flygC07VhBR/mwBBzZo6knqB5UYhAkManL9CsuA7nPTFDMRNGR8k82anqNWt5CGSZX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ae6ebbcd7aso1935881cf.3
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 12:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753990419; x=1754595219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clvusajik3nsfOZ8YjbtwdGhAmA+ekyCPHg3J+60LO0=;
        b=gJ5MtdbHVe0wrrw6dnY1n91TgiGqTvIHsV7Ud1Y8Z/Og397G48c+zGV0zUsftp/LKo
         Oo2NRC0g3yruQyt+/Hu0kMAJKKNLh0vnAqkGzMx8EJpkg9WWBN0Vpz8I0ybi3N2dbeIe
         UrQsncBWU20CBRuOwh8lIB8X40BZUsKbaT3RkW4RgsOcZ49jfEOVGkakCshfr/yLZE7G
         MAKU25XndQvF7eMoGDjSD/SruADzvTocSZMbVyydN4ALLxMuq4hcyL85lWlnqzz36N3c
         PYsqO83o2trrCaYoDTN5S1s3Yb2pOjgQtqdgxU0Mp/ibKbDuBQ3oRItnsIiLMT9l4lq6
         OcJw==
X-Gm-Message-State: AOJu0Yy+WGAtYDQ/UWusbCz/Ys+THFnuyvBOnBFYQCTBOgGwW6bc/CJJ
	PvtRneoESm85TC+sRgqUiuhciZ0H/rNanHjKqamQhiyXEUbmVdhdJxzkKlQt05EOzls6krYaLWa
	yFQQwlZnIWKDVlE0n/it31Sqiz8b9ogTXqg==
X-Gm-Gg: ASbGnctmExX1jn3q0J/LLrbaYwnmJDranvQOWA+l2TM8QBSzt13McP7lskvJEmPrW6f
	NeBuFR79L8u+ftvPVl/BMojeAY4alBoof8xqEFARgVaYMtTlaAE6S9WwiNVYKomnN8G2/f1KTGB
	3vyezIKfsTlW4Vb7Jm6Z7VTS/JXgptKcMHk35XBUadPEPUvTetIB+WXdijjgHrMkCorazczE1a3
	3P7bBoWwB9pB8rDW+kvdWh42tGew/R6YznJ5Pvp
X-Google-Smtp-Source: AGHT+IEKXcH8JUf10viuwZde5jzeI7zDtoLzkG2L0X/F0dApssJDxPiRiajCDZewz2pV0CPtJ6halbThnAua7OAyEeY=
X-Received: by 2002:a05:6214:e48:b0:707:42d5:d7b9 with SMTP id
 6a1803df08f44-7076724e4cbmr46164676d6.7.1753990418630; Thu, 31 Jul 2025
 12:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731063949.1601669-1-gitster@pobox.com> <20250731063949.1601669-2-gitster@pobox.com>
In-Reply-To: <20250731063949.1601669-2-gitster@pobox.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 31 Jul 2025 15:33:27 -0400
X-Gm-Features: Ac12FXzb0uV66mBJpWM3f94UubVswvmGKhKwAjtqRUMyVQN82RUcPdOgToRqwRM
Message-ID: <CAPig+cT9tBSo1od8iuCf+88rvDO9GEikKm38WLcXHemM-emhOw@mail.gmail.com>
Subject: Re: [PATCH 1/5] string-list: report programming error with BUG
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 2:40=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> Passing a string list that has .strdup_strings bit unset to
> string_list_split(), orone that has .strdup_strings bit set to
> string_list_split_in_place(), is a programmer error.  Do not use
> die() to abort the execution.  Use BUG() instead.

s/orone/or one/

> As a developer-facing message, the message string itself should
> be a lot more concise, but let's keep the original one for now.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
