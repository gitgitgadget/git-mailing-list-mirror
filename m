Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B893D978
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 22:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719960497; cv=none; b=O6egjKi3T59wdGs/Kn6OYou0Uj4JnDLW6rs0tzlnHI5e6z1/PIlEcwkSuW5jc85y+yKJHde0KC6H9CGFpUuZtECPVAqjXaiXPdnAPdD8lHmbK/UHhXoGUhLluV+AUa/6JLJ7cmBhZzSApFWuixtxxlm5svPODXUeRWZ5zDyJyp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719960497; c=relaxed/simple;
	bh=clm/SlBYNOmYDirx+9CsSx2yE4xqYgI9SH+wYN+OGqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGBb7RPf42s+EMF6oFZlQpnLnfTBgBVQ2WNWSTVi3tHpgbTg5PK7lCZVASiI60AoVMqsXo1xDVRwi2PzFAFFSU+k+sPZChbaIFEK5mBhQ9xiQ9dCi0r//2I4Aty1z0Mgq+DJATxJBUGkSkkNyarmWNLklHi8wXNHhbb2DU0ELIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b50aeb2424so21493866d6.0
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 15:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719960495; x=1720565295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAkrXk06haLYDMPu01jQNdwwf0aM4YRERXudPoowXHI=;
        b=SREf90ZWkdMxcvz99WckSgHhK/9J4vpye6yBqpstFonxBSvbQFNmLR3JTXLx0T+efW
         I1+JCdLMZamm8bcs1N0GyTvE3LPFRkytRT5LTxbnQRLX8iP1MPRE+D705aBfSSREj2mp
         m4o/t98J8KTZwN9/cnW1wP666wziNF69d/8rap9ihsj8SKuo3otxAdYw+KsohuZkRojr
         ZfOYyWqTTCIZ8o3H29AulFy4Fuba/f5GRKdYdZYF+sOhThaEfGgE/Jg/vik8Wj9yIWuJ
         J0H91PEqjl9y309Ug3L3JF1Z4DLTT6TVHi88Xa3b0FADrIZGhbuMGa+V3ZmDLJADBk9m
         CRbQ==
X-Gm-Message-State: AOJu0Ywl4MlFN1gmaUfJes+ddbzONr+j7I54iCwN8DXquP/aEXHhPCHw
	ul+VT00bYvV1FPfSfUlHVW4I5JDkoaXvZYYDxLapE/q/mqAdgBSe+3ymDrT3oGiyv9qKvb8TBKB
	M7Ml2QO3FvTKxTkwIITinNe0ViDBjdw==
X-Google-Smtp-Source: AGHT+IFbexJVFfmxWA3V6RMXWCxVTqGG4R1oySFj7dfPuyMVNAJn05Lukr8YqQNgflZgmbfMX1XbKE/XUllblgRAFRg=
X-Received: by 2002:a05:6214:d64:b0:6b4:e702:56ee with SMTP id
 6a1803df08f44-6b5b704ef1bmr115722506d6.11.1719960494986; Tue, 02 Jul 2024
 15:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240701220840.GA20631@coredump.intra.peff.net> <CAPig+cQdioTBinkacLFb7yktm168oB+qyP9MpZtTRE=1aBz5yg@mail.gmail.com>
 <20240702005144.GA27170@coredump.intra.peff.net> <CAPig+cQ6PLZA=s6D1XsdcFeeg-=ffib9QZGFLycsHWLZZ1ibCg@mail.gmail.com>
In-Reply-To: <CAPig+cQ6PLZA=s6D1XsdcFeeg-=ffib9QZGFLycsHWLZZ1ibCg@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 2 Jul 2024 18:48:04 -0400
Message-ID: <CAPig+cRphdkfrH7MrtXrbg1Pn7XnVN6oodZO5QuPqBbPPFXVyA@mail.gmail.com>
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 5:25=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
> Although I think my implementation is complete, I haven't submitted it
> yet because I discovered that the changes you made to t1404 are
> triggering false-positives:
>
>     # chainlint: t1404-update-ref-errors.sh
>     # chainlint: existing loose ref is a simple prefix of new
>     120 prefix=3Drefs/1l &&
>     121 test_update_rejected a c e false b c/x d \
>     122   '$prefix/c' exists; ?!AMP?! cannot create '$prefix/c/x'
>
> Unfortunately, I ran out of time, thus haven't tracked down this
> problem yet.

This is also now fixed. It wasn't any deep problem, just a minor oversight.
