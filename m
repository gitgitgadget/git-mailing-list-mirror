Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43761168BD
	for <git@vger.kernel.org>; Fri, 15 May 2026 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778837982; cv=pass; b=jEF8KEJXTEZbyBv0+M9epQpMWd2rlpRMNYnAEAoDwPwcz/1GK1c2AogL1ssdxBvdbXOkMPzHkcZN91Jy+6QA3u6XBxodyGxE4Ik28T/KaZZNsBVGl1R3qeQhShVZpxhX6tD4Pq95cIdfFWcsEu8ahv8nqBQHRWaZaqSTaS2p194=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778837982; c=relaxed/simple;
	bh=UZeW09VuGLB+ci7ENBiwdh6i4xUlPO9BB3V2tBzq3Gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odfdWlxA/cFI3pSqDhPwddY10eC6nRJfEMXehvcAjwHP3JqK0yMa2PxhsIQZfb91GosXA+EFzINNJ9X33UoukCD3XEHeL1z1UFVPrbX+jiv7M+oJzI1RfKmZjF1/ETI4lXqoU59hIoGNDn1Y0eRHg9fk1sH15833BVKqOq3ZKLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WS1V41Gh; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WS1V41Gh"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so15950649a12.2
        for <git@vger.kernel.org>; Fri, 15 May 2026 02:39:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778837979; cv=none;
        d=google.com; s=arc-20240605;
        b=jsbcfZamEWqe07Dlr1B0eOJm26C56Qwj7oXUYM9+ACsuy7OYe17PkdbKTiqEPFdZIp
         TbFC1DNXQi5D9SxHPzZCICv7BYUT14WPATv4mbCkidzThXmPQy+hAHAMEsEr/zQ4Wul/
         d4xcWx6BHF3rSmdw9Q8BkBOrBpY8dsH05Ma4apAO4fzOW6S0ByImeqHxDf78xn/xwNCp
         dps4quROqRoIiTq0wELXASskrYiCiNJ5qurREEDdkqnBw34v07jt3U/SHZzdytYu9hK6
         7Uo8kRpeSo5U9tY0jPIaeUh1wk7lksKwxJQPZBhKam151buLf4og0D2UB3jneLZC+HFh
         dP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aqNT1pRgTAjLGAOHpnmSxGcvyx4jYtBIPX26S4L26W8=;
        fh=2H7VkbY23qOYz+Sb5nC7m5rcZVran+v9IhesJCRl07I=;
        b=bLa5JvqnsCavPQEfqpvY65Vlwu4+DeTvDVJt6yLW1+hDFIlGKqRX4eViPlx9d2qg+5
         euqyOxv5HoeDLRVVXxt6vp4MXjQJ7ZSvf6j+W633Amv2vq4pnD77pYaEI9dixy3jJM+g
         wIiZN8cV2mNDklGu5lyP1DGpAnWzUf/fjzI5IH9EyjDhauGHNlqCq6xpFpx6ZO5VnN1M
         PVOsiZYxlzYPBN2RrGAgajCC9HlDVO4E4tTmiKvgHJQyjZXoRGf99uDVjz3/oWpvijri
         HYK/u8ziivyNNEKFU+IPpIWmZB5nm36zy6wB31mUIulUB4/CuKD/a1K+vg+9pGUYVBkJ
         6sng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778837979; x=1779442779; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aqNT1pRgTAjLGAOHpnmSxGcvyx4jYtBIPX26S4L26W8=;
        b=WS1V41GhOFdYCG2MNs0i35GEkbCF/vanePgIRqErFu1RXgdFSOr1PRExSt4yK8UQPC
         PguoeiOkV0H+qsDRDVgA9fZRnk5/N+Hnwtga5dNCXHQ6QLMDfJDEB/DcC8NHZNCO+EGz
         spNC3524o4Z26Kd833C+yfS2FUa2jqG78XJ6D2eNyUFKq5g3SCg3aTDb/EUWjpTT7YXn
         a4Li2GRqiDr7/PPn6+XAbCv4AuuRiZVK7/fozY1f1EQCTnjhdpbAQN37i2DgGjyyij/M
         zVSmAoBwCTwvG0pAAeeZAIo8nuzXEgA0FgKSNZM7OgJaO7pYzFwn84iTv8QSliCr41xP
         ap7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778837979; x=1779442779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqNT1pRgTAjLGAOHpnmSxGcvyx4jYtBIPX26S4L26W8=;
        b=C0VZCwnB0lDY9Ot28V+pAi8+aOjrsb5XzKBYG7r9Bjm88SLDi29sB+sLBsNlNtR0Ht
         8nS712xRZTN//O5F6ZWSMPfWmgRCX9KtuQLmAuDDHtl60SFhuaNySYWtn1mpCW98a9rM
         WrZ8y4lgeb9e8AN5UrKKvb73AQHl1yET/PKELl/N+vUk7+j7tzQYLGmBZUOeJPFoCUzp
         tvST3ZOWunemo9yuP2gSwQYoZCQxpRVkIIMoDVTGgXMOAnxHCsHxDnCrPiu+sjXhnyJ4
         eKLiwWpKYZfOZ4jWLGE4tC5RcxVrhJ1k6C4LEOtJuoiFSfmCMc0NNiBAfgZ7qG6s0sHl
         cDDQ==
X-Gm-Message-State: AOJu0YzLAK68wpo1/kGsxOC/6LHDIcOtNFTVgwsSvRQgk/x3xfAmP4mO
	x/EKe7wpakqCJfCODNfqm915QS7XbmdDpPC7Fmo9Iul0TYa4JYmkSnqMo1ZAbkhFQ+4WxuKzMss
	0u/jvTIuNTVm+cgjKz6v5WekqGaM21mc=
X-Gm-Gg: Acq92OERKf4lReTr6q3rA017s+dKWETrIZeI3+nlnChRBqn3u7/vrycKHl81aqrm6hU
	wnLQdcH3SXBZx0sEQEHXwJ73OmqD/mH2iJoMEQMxSNdFnSPnPCg6DJSxW22bPlar97CPJZ7QZaS
	xfHs6xWFp1Ps77UI+0iaSpJeEVKz9S/dBWXDwzS/TNFzH16f3e8Yk2KaL+8a967CVKIT+rcOZzo
	bTv+y9w86M1qk5GvsTEh0ku9QaUKQV+7JcEBMaG6faXSZ2JcSZLePldAO3sppvlsE2XJrTXKPj+
	289Bkn8=
X-Received: by 2002:a17:907:3cd5:b0:bd5:61b:2a9 with SMTP id
 a640c23a62f3a-bd5179054e1mr152105666b.28.1778837979331; Fri, 15 May 2026
 02:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqqzndel8c.fsf@gitster.g> <20260514221602.9918-1-haraldnordgren@gmail.com>
 <xmqqecjdea13.fsf@gitster.g>
In-Reply-To: <xmqqecjdea13.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 15 May 2026 11:39:01 +0200
X-Gm-Features: AVHnY4KMAAV6XdMjMR2oRBrXDdLw8ErchXeHo6pnHSym8BjFprTQWadwbRDM20c
Message-ID: <CAHwyqnUmUMrpuuyiRbSrjbOzHVViYhpekn33WwuqeZpzAy_W4w@mail.gmail.com>
Subject: Re: [PATCH] fetch: add fetch.pruneLocalBranches config
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, gitgitgadget@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Why do I get the above, which apparently is a response to my review
> for
>
>     [PATCH] config: suggest the correct form when key contains "="
>
> under this thread?  Am I dealing with some sort of mechanical slop?

(Testing plain text email sending via Gmail for a less error-prone
workflow, does it still add the CC's correctly?)


Harald
