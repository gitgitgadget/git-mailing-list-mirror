Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793694923;
	b=2AxPQ2dvhgMoUkSWaDeFCMhtB2k4aOBUUACJp2je8ZcKaSDBgl93Ua4hWhdeE9WbS0ln
	 JVaxS00PgVDFHFUKDVDYZ3xHKsdgBYzb+nx5lNJW6rI1hIVk2XlsK8S9zMVeipxTV8Dt5
	 XJBhYFTzac2C8MphwWyZhoqTFWSoNzUl7WVnUAbBJTln+Qf2rQKagEPbcQcnF3+XvDOBQ
	 ibHjdtnjjptvn2JD+V3VH+PmHdNZbUDp27IjDrtHhBewfUYk2TJ4v1W88mjtsY6t6kEia
	 JpRa0/pW0TcnesuFlFekllnvfzabcCmMQ/haF3bH6WOCDS+2oQbx707oFCqg9nsHaOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=DAHmJfK7+SYDgCM6SrUuD1u3HtvrrQ8Ca56hlQ5/lTY=;
	b=H7bac4hjoSVW8BxDYDneW4tYVYRJLzQgfJ/3HwEtiKv8MI8Z3u26ZyUOPX1g4ZeLjtfK
	 TN+27+i4UowOPLoxMFTDtN4BR0Clt3XYbhqqezNNyaBf3Sw6KVJ8BYdEwXXeOb3dLkyt9
	 JQUum6QEdwkDaLdk0AlqoDz7FZLb0MobC0nF7REAByW5jiM+mt4TyBXObUgrmsnnA1khF
	 slux8HFQN34JeJcjjMJJlG8IEV2OYD7p0z0cltqSvHb41waki8jho3Q7b4QbjwTpAEO/i
	 MMb3SbV9W7aIB1FlsDjL9D8Z3nIQLbtk4SkgCxHQRr2aVqpxnQTohtnU5hZy8cCczTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=HQLCeI1K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6D8606B6E8
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 08:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D6D8606B6E8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=HQLCeI1K
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c34bff61551so642799066b.2
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 00:35:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793694921; cv=none;
        d=google.com; s=arc-20260327;
        b=YK2griFiVSdiyytFPt8Ty5aH7a495P+Eb3+3QHqzM/PqN3ROa1wqZyV1xa118l8fg6
         mBgbvJAW+7rRpBGRRUXsbJcG+0hhyt9bQmyjUAYCOkAMOwReLiyOT8VRVvRU7SDXnONE
         PQg9nOAjBTNlp4lleVJzjPLvE5Te718ICJB5UicESFsGnAV93lErKD36OMAENFxSqLtI
         QnNPkuPMLzJly86XigqZAwSpen8z9G3+TOUc2RHQxkTymj08akyZ43RqIASKACK5Nyt+
         RDaDwZPQR+HcRUkEMNAnqH53sf+5BzCeZZ/5JAPJBgU/MS29WLSGTspR+YYNDnbp4L+n
         uZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DAHmJfK7+SYDgCM6SrUuD1u3HtvrrQ8Ca56hlQ5/lTY=;
        fh=/+3Lm9w01x77KNw9Pn64lvqJ9Co+hbIOQJSIen2Miig=;
        b=KLZflHpnyBnZ6/Sp5/P9yQ7d8SYU62VIIGAd3vzpAbCC4mk59Y7o2gJfQSbQ9iT+mn
         lqFl1hCou6xy3F6W7GHbP2PGCkHTqMDyP92kS2x7urF2EjvX2iz4Jh0Zzbj/GZh6vy6O
         EuD0f1AwYf2uU3FZTzqEDfjCHn6eVJ4fe30XXUAVolIwXlV8omN96VNX0sBDCNRnify2
         4CrONRu4sH/616Qki7UwDwwZ45t+KdgJ23ugqSCn7Knxf3JfWF9oyBffJnsoyqI7dwr8
         ev52GYToMiP69GDGUEwWzivzJcLnDavxJjX0k1lE/r5YRTDcC5UYbNygd1BNwAItxS1J
         YLMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1793694921; x=1794299721; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DAHmJfK7+SYDgCM6SrUuD1u3HtvrrQ8Ca56hlQ5/lTY=;
        b=HQLCeI1K39Lr9ZEuJB+S+UMhTmSLXJokC+TCKjasQNNInA2/VMw7Edx6qGiKL0Czka
         s/N9KJ5iPHqt7O+xibbm1YWtx1O1/6ah34M4WpL0x0XXLKTCS3JQKqSqSBv5P6OKSwcj
         /ixu2enp/POHcl4yWmlTXKMXGHftwBroZTMZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793694921; x=1794299721;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DAHmJfK7+SYDgCM6SrUuD1u3HtvrrQ8Ca56hlQ5/lTY=;
        b=0r3HVqtqpLoQX8vJrHeEv3wRculkvToXqxIkr2KaohL8vr3LY5XGSHpQxpqm1IZj71
         hxZMCNQf99RTsZgA1chnYpZDoukOFTi6awnHecCYQejN9XffArnE/xcom+TZ6vPu3zKh
         c6odAl3vncggFD5kDjvAr8BeqGurSobDaBayWdzQS6HM8xCcBCFFtKhZmaQ98gCScgTV
         I6HIk2OeEcMjPI5EmJpTIULBBpTitZssIkQ5h+WVkJBegnG92TCNJ4elmPAMLn5aw9ZN
         uiwhf+uEXHt3ZkyLITKq7uCDVX9NvNgPA0ck9l12s5N1oeDxzrRATrlKA8ownIA3w64s
         mx+g==
X-Forwarded-Encrypted: i=1; AKwUvBwAAtrRBEY3G4CW2MVGyQW5/hX+9dfFiFFeqx8Voniu1wQ0UJBQjV06Ms+tYmT2eBS2gz4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rCtS1ACRjo/DNPOuBFHts1UpZf7NF+D4MziHP7qqxm0ElkSvE
	tOIjyOru28Lb2v/HQhdODg7bYqRu/lbN9fw6yGGotH2QnkApQ86Tmk95X3FzjAeAr0hPAfvt/AP
	0uY4qAU132AOeX7NOzQMmYh8KxwMIhKdJpC75kT4olw==
X-Gm-Gg: AYBFou3zbHMHass426PvaAI8ImgM0NpjnqoE21yGXN3PKCKohA93aUE015bUAla1Pc5
	c5AkjXowuBu2OSkMqI4/ouLhvqQNa96cT/rUQ/TtnyvOKLEuGAK/kRrC6TmFCaXiqnRX1VjMA4p
	lfLNnfqcAsTRc00yjJdzCjs4lm4Z5OsL4VdNchY+Ec/p7r2FAE/+olB8e/Mvn6Eqk7VQoPYfUi4
	3V5x1vMiqLHll7p9ynjiTrF1Q94WNipUtWagF+S4217SL6mpaqoQysYglmwLke6nr3899DPMR+v
	VDVwwWYmjrhJ46fTDZT8Q/ZC7UCvHHjaDhSVd01p7iS+Dxn+DvWxNPV3DdklvmrcoxivqrO3rku
	n+7aXsALEM4uKetYPadtDnGQfjIOzZgpOuRbj
X-Received: by 2002:a17:907:d91:b0:c31:7495:e5b with SMTP id
 a640c23a62f3a-c4ca7a4bd85mr1003051066b.10.1793694920915; Tue, 03 Nov 2026
 00:35:20 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2279.git.1793634429929.gitgitgadget@gmail.com> <xmqq4idyhotf.fsf@gitster.g>
In-Reply-To: <xmqq4idyhotf.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 3 Nov 2026 09:35:07 +0100
X-Gm-Features: AclHuK_yLtpaC0VwVzEJOcv9eQCF_hZvfnUzNsoxsNIgRxxqg_DDUAaGWW0l5Us
Message-ID: <CAL71e4M7yFnTzYD0eVVGRmzkzSXbU0KZ-JScQOyB4-dB5xkAHA@mail.gmail.com>
Subject: Re: [PATCH] rev-list: ignore replacements in the connectivity check
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2026 at 23:05, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > Teach the connectivity check to ignore replacements as well, so
> > that it verifies the same objects that the commands relying on its
> > result will read.
>
> Sounds like absolutely the right thing to do.  We might want to say
> that we check both the original and the replacement, i.e., instead
> of ignoring replace refs, we ensure that the commits, trees, and
> blobs reachable from the replacement objects all exist by treating
> those objects as if they were also at the tips of the connectivity
> graph.
>
> [snip]
> We can address the "shouldn't we make sure that replacement objects
> used when the resulting history is in use are backed by objects
> reachable from them?" issue separately.

I have not fully thought this through yet, but I'm happy
to follow up with further strengthening if there's a gap here.

My preliminary thinking is that since replacements are
implemented as regular refs (refs/replace/OLD -> NEW),
their reachable objects should already be covered by
ordinary connectivity checks when those refs are fetched
or pushed.

And thanks for the review!
Kristofer
