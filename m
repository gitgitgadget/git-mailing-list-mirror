Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65211494A3
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719358226; cv=none; b=A5fxN6BmG2JDoVaaKEYmZg2RKk05BsmUMoKNf7K+aR1phhZdyDefWmXIobkGJ6eXRGCHAwSOizyTwYZlUstvS5TNyg0W2ocy/7BlHbJywGrAuIqsaPlSVBXCn1jokrO4XCA3UPFX8X3IT7sRpsVJq3aI5LCI2oHrrrtcmXfm7qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719358226; c=relaxed/simple;
	bh=3p2KmbzvBTqXdqU/H+6ZXiZKm3vf0AnPObMAjMes8c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hb/MPmw2zKTci8PwImaw1nrD/q+WkIoagU6lry1Vlw6KWk2uc78oPOOO/YPtSJBYHV+7Q2NlT9lR1FQTEHFQCqJm3dmos34l/6T7oPUDBIOvhTXFBSaLVXCZzXU02/ozGGVisvQwMu6RoofnTaZ2zb1ta/zRpYoeikek1myy+dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b50c3aeb83so23973836d6.1
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 16:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719358224; x=1719963024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYT7rN1ByIoSfHDr+jA1qT+LY5qSwpxB69ekg16VYjc=;
        b=iXwnY5uax2zzPQwqtExa5fGTJVjm+proBVPjoYQ6SIMtPaDsPwQxLFEGhX0gVQlJ0o
         0GOb87SRcJygvfU4d/xmWHqpQXlGVxp77YA4taPwP4MrbhPXXFVvOtcfwi96lwmuHcPP
         ZM2P1l0lXePtUTQDyQJkUmZ88L4L9HDkjRtu3RSGLR/Mn2IFqWQyyITHImDQUNL8qJce
         7f3B+B4G4s9fVIMoWUE5+zdwGrT4esiJXfoa/hZ18AiLd1si1P4vrSdq93Q/PYPfnw2w
         8zEgGBggZ+QsLH0cJgUBN/dWkj1Ev3xpFM5MKi0LpltQpG7Po9SNrCxed4enUu+5ln1h
         /q5g==
X-Gm-Message-State: AOJu0YwBJ4kEzy0ht1uBzQ8qTaS0xh8BdreCE9bcACRTunrI6/DkmwmV
	mGL0OSKoglolo0Cm4dEPbwDUot5EgzQ1o9/6QFMnYjDpE3s9pWs2g00D5A/4QVLDChaIVxwPqjx
	ShaB2RtJBx/A1xHEB8P+j0M3mhaY=
X-Google-Smtp-Source: AGHT+IGR25ZVKmwNPz9i15q23bxXyBQ4Dqhc7pkBSyy7LmwFKqejkyNABlntDcHhxNQIuvfS7wF95+RIDWpDoECSUc0=
X-Received: by 2002:a0c:f906:0:b0:6b2:b251:7d97 with SMTP id
 6a1803df08f44-6b5364926a3mr98095276d6.38.1719358223681; Tue, 25 Jun 2024
 16:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1726.v3.git.git.1717719428510.gitgitgadget@gmail.com>
 <xmqq1q58ejnw.fsf@gitster.g> <xmqqtthzrraw.fsf@gitster.g> <20240625231248.4070257-1-gitster@pobox.com>
 <20240625231248.4070257-2-gitster@pobox.com>
In-Reply-To: <20240625231248.4070257-2-gitster@pobox.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 25 Jun 2024 19:30:12 -0400
Message-ID: <CAPig+cRaQbWTLnvbx-Yec3mGEJDOQQr8RX+bT=J1FzVDqjq2_g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] t0006: simplify prerequisites
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 7:13=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> The system must support 64-bit time and its time_t must be 64-bit
> wide to pass these tests.  Combine these two prerequisites together
> to simplify the tests.  In theory, they could be fulfilled
> independently and tests could require only one without the other,
> but in practice, but in practice these must come hand-in-hand.

s/but in practice, but in practice/but in practice/

> Update the "check_parse" test helper to pay attention to the
> REQUIRE_64BIT_TIME variable, which can be set to the HAVE_64BIT_TIME
> prerequisite so that a parse test can be skipped on 32-bit systems.
> This will be used in the next step to skip tests for timestamps near
> the end of year 2099, as 32-bit systems will not be able to express
> a timestamp beyond 2038 anyway.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
