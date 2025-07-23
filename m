Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212181F582F
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288654; cv=none; b=nndhC+4GhHHFhilbXz2abj9j93gf/UgjIujcraMRMiJ8pvYAIa5w6kEMWYiR8Tx6nJy4A5gqDU8YEIxJKidi7Fp7EayArF6/8jo45c6jTatKO/xsERCpLArsNeykgEGNyLYLmszV3/hEUOIA/6891GlpgIOvawSkTxK5DglUzis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288654; c=relaxed/simple;
	bh=e905i+kZoahaRPAOLEemIOMf4QcfI5ke67tdxm9nKVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLlkyBtddCQx7QiYVXibzOWxHGlphocQ2XoRXoL7RZKKe+GzDXVB4BpkAB3VfFsVFehXdFDkVKuyQjJY8OiYxv73awkMilkoMFjpU4X7KQJlMgPDwoqBSJzuvfjmQNSDEt0uK5PENM3gE1gDSbN+/8Mn1sfn9PDnfBvQaxHVIA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-702bb5e3d4dso60726d6.2
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 09:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753288651; x=1753893451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e905i+kZoahaRPAOLEemIOMf4QcfI5ke67tdxm9nKVs=;
        b=ovqeszBkYyg6lRhm7wxAsG/5ldkSJB51dUwwI1maJb0pwis57boPu8SGrCrIq57L4I
         bd8OUPdAhwJlxIMbfkiAUBhMlpuwcIC21A1fdUnSyDWtKFxrFI3BI0tDVFvZcQel5JVv
         4gJ8DXFfLXlQ4x8EPQ5m5KyHjf4gK9tNs2RSI12C4dUBjmh+T1zUbQ24K/PPGFzwMyXX
         leU8e3IobwlLljR5SQOjxXERqbtPAk+jxSX7GBihF+5MOYEfrEFoEJZchpN7DlmNOjy7
         9pHr8GaNdd8uWeU4rj5kBes+2nIoqk92+7M+USTDb/MsQCK5MQVgkiZRUh7ased2QwXC
         aBHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx82gYh9Pt2rrgFtaCd29IyY1UWt30EpNfRM/ZClcV8QaxwTtf2apepp2+gw9ggaji65s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2dfyFHZXObWZXQRLT9bzvOuY/WFTBbxOlfsdTdeTZZ/mjo1UI
	D/5BBA/NkFymXfemIho9LVyuVlkwEoD6zJbpCeU4c/p7OGgGQSXDZNzP0HcY2qOnNuHtQaJw0Oo
	F59i/qWcw4cTHxsPPCFCL29ZydsXau/5GaA==
X-Gm-Gg: ASbGncuVbvsohdlQaeWzSVfCmv5pK3YvUz6VHvMAzMdxoJiUxovyFp8b/wl9svm2Kon
	R4MkYknMfWn8TUzUt0BArmXfCFOT9EMtBA9OYdWcsF+x76YuQyqQic5CIlgNhHNCB/ipeFmH1gw
	q1gytplubZ/Oy3DiD5dj9TiEcF3g02kff6NaVprsucQ/mUhyzZJMnGordHxZeA2LaUeEbW90VgD
	1xt8g==
X-Google-Smtp-Source: AGHT+IHRs5o4/UIR6HPvnRq2LX27aQcKLG7GXHrRXo0ZPANWlWw33PckpWHQAUh0Y3jZYp1xZRAiAPWgR7ASs/S2Fjc=
X-Received: by 2002:a05:6214:29cb:b0:6fd:75e1:16e0 with SMTP id
 6a1803df08f44-7070047e231mr22419656d6.2.1753288650818; Wed, 23 Jul 2025
 09:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722174102.1876197-1-lhywkd22@gmail.com> <20250722174102.1876197-3-lhywkd22@gmail.com>
 <CAPig+cR-r=CeEaSTeWsX00MLCSRJUUVXMUWS6Ui-HQcR_qMGJA@mail.gmail.com>
 <20250723075513.GA570540@coredump.intra.peff.net> <CAPig+cQ2p3muA0-8O_u-rOW0uVGQ_ZE7hcz-7qq8M1U+PdvtpQ@mail.gmail.com>
 <20250723084624.GA580010@coredump.intra.peff.net>
In-Reply-To: <20250723084624.GA580010@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 23 Jul 2025 12:37:16 -0400
X-Gm-Features: Ac12FXxXAVMCSIvg1wYjTH973gyvfjhQjpvORDGBBRksL7h3y2vgefnKnZ01jFg
Message-ID: <CAPig+cSzYPaBGZ_muhxwcNy4xWaMF5Uc0+SN7ygnS4wNaGxEKQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] t/helper/test-delta: fix possible resource leak
 and ensure safe cleanup
To: Jeff King <peff@peff.net>
Cc: Hoyoung Lee <lhywkd22@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 4:46=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> On Wed, Jul 23, 2025 at 04:11:26AM -0400, Eric Sunshine wrote:
> > For completeness, I'll mention that I even had the thought that
> > another "fix" would be to tear out all the cleanup code entirely since
> > we _know_ that this function will be exiting immediately and the OS
> > will clean up any dangling resources.
>
> The reason we have the "cleanup" label at all is because of the memory
> leaks. And there the issue is that we build the test helpers with the
> same compiler settings as the rest of the code, so SANITIZE=3Dleak will
> complain. So I think that is a non-starter.
>
> But if you just meant leaking descriptors, sure, I don't think any tools
> complain about that. ;)

At the time the momentary (but not really serious) thought flashed
through my brain, I probably was imagining dropping all of the cleanup
code; I almost certainly wasn't thinking about the SANITIZE=3Dleak case.
But immediately upon seeing your idea to use die(), I recognized it
(and liked it) as a superior version of my half-baked thought.
