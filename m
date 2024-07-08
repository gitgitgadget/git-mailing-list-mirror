Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF9111712
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 03:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720411182; cv=none; b=TkwvHGJNyXSrV8VA97HoGv9cIUiUxkROyAFQ1u6+iYquoVerxVQoxJFj4J9O81icm0+x67J3226InCtowA4fUPuaYbk9J1OrZHJAEAHfsRS5p0Lm/vJalnz0avd7nKm6kxj/sqsZMsW5LHo6fPFc5H6cTGwaoUE/Wy+0U31vknc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720411182; c=relaxed/simple;
	bh=wgaWxzrcJcszxTHe50bwGT13INTwLAEMT2o1f7500Yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJ2XHzFRew23Ir3bQTxn0E0UxbigQFXZYcTdcBMG34EQGc5kSlN29dSl9aBWxxyg0XG3f1T88uFS6I6g8sWWiGb67YAdpEVlK8mcYNxR+/A/GyOK9CW7FBLDViwpRkfTo+awF9CqKcsXvFhhcUVs4b5HTkHGO1as601mnngADcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b5f90373d4so19160466d6.0
        for <git@vger.kernel.org>; Sun, 07 Jul 2024 20:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720411178; x=1721015978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUbFpEYxb5kZSVYJcgA1yICiLWmzA/qymcErdXZSgic=;
        b=C4e/mCNCFgnK7q2Zw2QF4WUBOmp3V3+QHhnc97SDKbr2anfQWhs8d5/Pkh/GvjNNTb
         kTo2xxmbULnXDbSZBxHPxRuWl3LMt6WzagRAqN84Kw6h7sEBqZuc/02Tv6PSCmYPd6VR
         /rhfCwftOZj3mqt4acWO5bf5K2GXFo3I8EncONEBYChzCNwR568JWCHoja2BkwZ/Kd2f
         6WNHagnQUrjVYIDHLz90pQ4dDDq/iLSiPLIRPF0VKmNtre3VL7KbxW4KCCS5MyhMe74f
         I3F9O2ciCGrIEsgnNkHlhjO15lENfsxJEkOujsVbs82edwE5BrzkBOapEZDOoDJfZ5//
         HVOw==
X-Forwarded-Encrypted: i=1; AJvYcCWxLvn1NbUrQG5u85ylOFC5idETGItD/r5b/N+ji7AvF6Vg5rESmmMWv1Hqh+zIuc1tHmH1tNfyzB1UpTlPzf2/MEnX
X-Gm-Message-State: AOJu0YxPHAofuemXx8tjjK9Zo/9Npp6PqLhFB42s1nWcRvQcAgWFuqxR
	N1SEXVDGhn8sQ5iaBkgrahkU4mrY1KSO7qjFH9lmS0qXiPHoyxZr2x4nPS5L3Af+8Jzypu2WWFP
	rHvYJ5YowRNfBxDOcw61S33h+95UTqg==
X-Google-Smtp-Source: AGHT+IHzj4P691tanxlGqJrSlN4bh8s89ywbgxx3tskYeQXpTvoT53P96Rj4hpoqvFQsm4aotNiS+IIZr2InB29ep1U=
X-Received: by 2002:a05:6214:cab:b0:6b0:8991:a2f7 with SMTP id
 6a1803df08f44-6b5ee5cd243mr169742416d6.12.1720411178662; Sun, 07 Jul 2024
 20:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706060143.GD698153@coredump.intra.peff.net>
 <20240706060639.GB700151@coredump.intra.peff.net> <20240706060951.GA700433@coredump.intra.peff.net>
In-Reply-To: <20240706060951.GA700433@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 7 Jul 2024 23:59:27 -0400
Message-ID: <CAPig+cTfMf_t93arsTCq-7fSooiBKRw1L=DVmSX8Pp7xMJM9Sw@mail.gmail.com>
Subject: Re: [PATCH 2/3] t/chainlint: add test_expect_success call to test snippets
To: Jeff King <peff@peff.net>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024 at 2:09=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> >       for i in $(CHAINLINTTESTS); do \
> > -             echo "test_expect_success '$$i' '" && \
> > -             sed -e '/^# LINT: /d' chainlint/$$i.test && \
> > -             echo "'"; \
> > +             sed -e '/^# LINT: /d' chainlint/$$i.test; \
> >       done >'$(CHAINLINTTMP_SQ)'/tests && \
>
> BTW, not new in my patch, but I found it ironic that the shell snippet
> here itself violates &&-chain rules. It should "|| exit 1" inside the
> loop if a sed call fails.

Indeed, what an embarrassing oversight, especially since this loop was
added in preparation for chainlint.pl which diagnoses missing `||
exit` (or `|| return`) in loops in tests (unlike chainlint.sed which
didn't).
