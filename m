Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794874355;
	b=oUH4x0N+9GYKm19NQfGi/DKT28+2x0JuXzddsRR6p5hO4a6MMJseN9seCw+tRzo0iMNv
	 z4ucWCLQ+iuidQat7pVv7dzxi3dA2q7ozx3P4LnOW75NJwHppPzTuRUSwldU4EsIq8vO1
	 86uzNDx+QEH+ykkedkWHx8c0VOUMi0PFvMFg0yZ76XvjpsQmCipqwaTlHgN1I1+p6ITVV
	 nhO+/edWmGc3yY0D/5cusol+Wckaibz4+yU+HIlFxuZGeXgd9t8oVoCEeRXDpUt/diRfv
	 rG+6QuERY01OjvEH50eLWZ1El6fftxeNRCbs/8UGR5bJc27xbcwWEQaC5IN4Etd/Zgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794874355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=8mzkev2RcLJInaVMDY1JQGEQa899TWWLYOesQRWaI54=;
	b=1HB97lOyacj615BmxDJFd22C20pXFClZYbcuR0st5SnAFOsNAM7SNj4MIhaS5zfOj7/q
	 uD6GXE+ATs+XCRyH8h597PJqxBazxXmvR/zCDVSo7SMqsf96z2iKXWIkufxxhKksN2NHo
	 scVS3MTW/PvwM+PEwobBIcMLEjK6sFsoBX7afYbvQpdhG+tOkKuFcyX309HRqb6rU5kL5
	 UHkqDNwK5CkBx9aLFI9W4jS87UAYUrfuvXEED+A19TrK3iKikNuGoIEX7Tv2W3jB6vVRC
	 uUMy+Ilk0bp/f/GKdPc9lrfLCec0quaKpF7VQQFDN0kdMtmU1amYUSjiLHPepYb2law==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y6CN00q5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0582606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 00:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0582606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y6CN00q5
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6ddef424972so4367446eaf.3
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 16:12:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794874348; cv=none;
        d=google.com; s=arc-20260327;
        b=H+VsfPVh9IqgrjJhwLwP0mYIw4bbSQo6ohaEIm7z1TVua9LDUmw3leEIFOFVS9IGU9
         Ni35K/fKiLSHIfKJUfN3Zs6MQEM4fa9JICo0k3V1qkGiey+9Z6kJ3mGHLGexlwz3++0F
         z1AnaSdWaMaR7sxazpaEr2hDvAKq2/e0de6LmyFPg5+Cq6ozBNp8ZHTGAQ4DFZRW51vM
         n4dneKFuduSuIgbNBlcwS8L5cL5rxqX1r0NS8FGLJUUsawkij6fyfYalbJRyGa+gktPj
         +WnqMCpEc7Jnuj6uyfVQShw+JGtMa3GhciSNPSNmiAmqYFIc2IPUXhfZ2YYbu1Ip2UBO
         5X5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8mzkev2RcLJInaVMDY1JQGEQa899TWWLYOesQRWaI54=;
        fh=ItU38k1UieHHhvz7YfJQvDt4bmIQorPThZuCJqMVwv4=;
        b=g3lrRJvHI1FIKRoM4bRwbZ2aOBKiDmib864zszQygV2pitOMxf5pzodUAh63S8w8hC
         pOUjbVyVeLQsBEn2kcC1cuNeZdEJvOGQjDfQH9L5TxO2dq+AOlIY0rqnjcLFp7PMAV1x
         PxfTV9fjAvb95bYfrubqbuXzW49b9gFkQU23iNYmkMIb+py+OFXArViq4EwtpmQC+d29
         C9q63cBcEefqjIl1xLWstJPhfCO8O8xAhVR3ly+/W0sWPG7YpF2Qd1TTZvr/YdW4R+aS
         sZjyVHXAUUIOD38v8zx8x9QwDGJFUuAqOGLFksRBkwy9VtRhIc7ylWSaWqJustsHMaZi
         JtSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794874348; x=1795479148; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8mzkev2RcLJInaVMDY1JQGEQa899TWWLYOesQRWaI54=;
        b=y6CN00q57GpFmEUZOur++D1W7SkryogDFY8i6U+ULGjrc/V014h+d1G3MFrg7+9akf
         SuUwVLjD3gDgUjaDmRTIuZsnI0V43O2Kv22seZdzQgrOy5smMTQSWRjxVI5hGSWMdiBa
         1/WHnBg0p4BSrJA41Bcqxk01ncCdN3QmP3NqOK82nZBmpoo9rHxJ46TdGbttrI0vRWN1
         +GzyzQiRz/NwWjzlQgtHVgM//xCzdRLAYKxT+O+FdAkyCNUzQ6Ht6KbLyd1JJIa2tciF
         ZwGin/LDC5uyTZ1raMEaYW5eJc5ZExMXaokaEjXYT+N2McDNHDwvTEvfFfWKeJOJPHZl
         TuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794874348; x=1795479148;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8mzkev2RcLJInaVMDY1JQGEQa899TWWLYOesQRWaI54=;
        b=YigK30xg65OSLQ51Vc27IBMmlVZacSTSYAtMsxX1Wbm8zbAmHTG9r1MaE/p/7OQoHG
         tgNhatSpHdGO9/ZJYkBTEC+OGP/1YzhCC+ONz8O0ZKG6i5QwsWdPUivXkt9quuNWQcHq
         Yvl2EL/fsSvMHjp0No12KEOxMZAS8rxMopmUKfCdBMBvvL8ZKPSaMhv9hIJUMSEuFbku
         W5T6bq3EiyNOjW30d7m+URkPUjrDAAWMYM4qe2D2P3F2M/jQZAWHDLsM8t3hOXGPCeHu
         KgTPw3STFqEiUh8jqQ5lCBIPssQAZqLNmeAPOVIc2+RbutcMZTac5UyMXronEBJGJL8J
         pGdA==
X-Gm-Message-State: APuU4Z/yJEdFNkMYiQrDf6MZKfZx1eCJQccMF8m1LwFhB916oTNqSEqW
	T091GG8P+/Mgjk/KGMCwkC4Nr++A0XeXOqBJkvFMhjL3v3K6f4B5rJ5djJjqkCDokq6PM6hXmoT
	7McdmRaL/elHvImMIfJnQxEhIi5wUqEA=
X-Gm-Gg: AYBFou0x9SlCAg3FESZlf7ZnsRSc+PSZyaP8dMJBqT+qZq9Q9AV0SwrJq2kUCFFHdoB
	k1rfy75hPvcEeNRJpyXa8GT1J0CNE/iyR4qZU5VTklYM8k7y39adbbhgw+mCLgrT96ElKCTh0kG
	YngkeBjmdqcD62Rumx98jYVzomjVcV9K37Ev3yJZg9TT9aoOF2M1YtOOs27wR907ITRwGWIWvtn
	cHUEaSZ6T0utg2sMDBMVcAv9iXbVFJrcMw+1OONiI0TWweeGOK7RcCf1gsgQxsEBm15//5zvyYD
	e5IyFTSfYjcvRZLlk8NTpaLWDwqFEIF8oEGen0xlRUd90Pflz8BsVN1QZtEtW0XTiUmwqzZtoqq
	9PlrsqW/46zGZ8taEWd95tCKv2JXUIYLVaTQ=
X-Received: by 2002:a05:6820:f00a:b0:708:d449:478d with SMTP id
 006d021491bc7-71ab51a788emr8311995eaf.74.1794874348527; Mon, 16 Nov 2026
 16:12:28 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <2f9f835e3f99d7de5bbf51be2e8ef4dc0485a46e.1794778250.git.andy.koppe@gmail.com>
 <xmqq4idgn3py.fsf@gitster.g>
In-Reply-To: <xmqq4idgn3py.fsf@gitster.g>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Tue, 17 Nov 2026 00:12:16 +0000
X-Gm-Features: Aa3M54qJ8pmYe-kgkFCwVUCfaUUiu1x5usxi7onT3PbTW7ysPmysve0l5ayRneA
Message-ID: <CAHWeT-Z=pKMtGN7GU-UP_yrygTsihn-cwYoLPzjo9=3J_SjJ8Q@mail.gmail.com>
Subject: Re: [PATCH] pretty: fix lost and leaked colors at line breaks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> And custom format writers have no way to control what happens at the
> (artificial) line boundary that wrapping at 72 columns %w(72)
> introduces, %b may include many lines but there is nothing for them
> to say "at the end of each and every line, do this".  And that is
> why you decided that runtime detection is the only way to do this to
> help custom formats?

Yes, exactly. I've tried to make that clearer in the commit message of v2.

> > The same can happen to
> > lines picked out by grepping colored output.
>
> I am not sure if that is a problem.

Fair enough. It's a minor point, so I've dropped it.

> > Secondly, colors that are still active at the end of a line can leak
> > into what follows.
>
> That somehow feels contradictory with the previous point, though.

You're right, I didn't put that well. The graph doesn't reset colors
at the start of a line, but after each of its colored edges. So a
color carried across a line break is lost once an edge has been drawn,
but it leaks into anything drawn before that, notably the uncolored
'*' commit marker. Attributes such as bold even leak into the edges
themselves, as their colors only replace the foreground color. v2
rewords this.

Thanks,
Andy
