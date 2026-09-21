Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4823F58D9
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 22:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790029107; cv=pass; b=N6VEimmhX7bo/omq1zE0p37MCcTwin9v7Ep9wPHnhrJwYvyFfLfShHyqDzZjouJ+15TMHF/8Lesh5xPubZfMf9pE5VnOezdCgE4dtHcEnFpdiYOlocN4G2yInFQ93L3E7FYcmiyk3CtE2VnlZUkg7ol2CwmYYqCeYpVbZlsGUzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790029107; c=relaxed/simple;
	bh=wnZJ5x+rzVy6tLR/fA0sHeOP4X4grdskgQyq0EBKt0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RczgBZDzTnQr7RG6bJ11yhKQvxw9+xKcsn/Yv5gxKGlvMpvxY6FEN30osEZNKjFfOhfXj6ide3cTKJb6hHKkIjXJuVv2ZWuwIgS5cmH9G6kb+UPXB/u07XH281blbeaspRvfzGdQB88v/A4rzxxBg9gia+KEF1o9m8ndOoi9zv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vq5sH4m5; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vq5sH4m5"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a996c8adf3so5891942a12.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2026 15:18:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790029104; cv=none;
        d=google.com; s=arc-20260327;
        b=T7IMwU2y09LC5+vl3+cMG6q8wwyA9N89yNNMUZ/C55HVtqZqYp5vs+J5cdrRjJbVd4
         AuR1iNbVWmyYmqAdcSiXXLK5DJxi1LHDLtPm0wuwA+kUKzCcj+wpeMiKDxZ3TT644nv+
         GBSMWgC9SQCeegXRljea7cp+voAGHqUmSD98DD/03JM4PRG/JiXhtnO9TFQF3V3ZsyDC
         hBe4QsLZRzFZwVT8BlLgBToHaj4hYWlwAzMOHElSzr++BdrRV4+JHI2bnr5zuEZvDBSr
         KQ6mhvacZrq8HNoAtVSqc4FpoQSkdwEGXyj00aaKLJGociILVdIq+5CDA6g/DOLR1h27
         iZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AgXkkjjOTnNs2EB820eC3oH6tVT7ZP0ut+pjQTxL/Ps=;
        fh=PSlYlqEVNeLV3Gy0qJ8/OgknsJIKfNOF20u9siTZAlA=;
        b=hZnPH62ffCAEfDNlQPGOAttxTXeCATAWh+y772I0jmwvJChn3PSH4G6vOW7/QOpcEp
         e4rzWha5+8RPH7CM97l20lLtFHgQQd1JYek1YWvaxMYSRqe7kvoHZp5IWrQwAudrsbCg
         50oNwN7v4EN4HtMQMmSctBflmI/OT1dXiha/5SFUXCZQzKbPZ7CF3YZ7hs52n31FbrFz
         wx/3gS1hQwEkCPdr0UHuf6C6TRR4NuacmS5Cp4h2ZRf0IJrGOyyqNOBfK6BvJ7YOfWct
         MnvGK4wtailMrSfth++kXiAr02VkjuWgoK/5P5pibGggocizyBzbnfM+lTGBbEfg2i7G
         MpoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790029104; x=1790633904; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AgXkkjjOTnNs2EB820eC3oH6tVT7ZP0ut+pjQTxL/Ps=;
        b=Vq5sH4m5KmafqV/dRmyqctN9hHuCWlF/hkNF01NB6DqouQ6YtZV+ndPrYaSYpXhBM+
         AwmX3dA9Z5x8K3Lh2p81lWzqizOnv2/hzWdJpOmfRZpF5AfzCz01z9B/kfhrisO3k0Un
         8HMXCjAFif1P+KHkr/B9Ab74YGBAl7ZOwdMUWq+gpDErauOdvzedp92IZlMeZmbDWeWF
         Ikxx+wbzpZM6DrGyFC0MuTk9SMljpbSdkeYGLTzc+VU8OevSZ/l0h92iz+dQkam5M6u5
         rhhvGtMEBaSwU+C4sV+onUaa915/u9/HG3cTAvLKdq0CBTakgJvSRU5VkeIJ0ZMODV1T
         wI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790029104; x=1790633904;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AgXkkjjOTnNs2EB820eC3oH6tVT7ZP0ut+pjQTxL/Ps=;
        b=CPJJomb119Z/s+Ow7HyTI1BSffg5i0OoR3BXaQPLTMuciWKriI7mZKilxbrHSIeab1
         rxQBkndGoZ/oHsTSNoWf3nW8eFAEunWAivDvxTjzU8EQP95kgy0D/dUlhvSA/YhzagDi
         8zijsrALpjFWmaSBbDMY2TfslH2yAYixKGHChnfl+r6v3IxdtgISkUT6rJUPzOhMd4KY
         aCz7i3Q1PFJiXS/ir9DbvitT7ZPW9g05Bzi/oNbJWxxxeoKrvmjyksjdQD3ajsAk9Odv
         YIt9nwfNRySQ8MosE5JtT/8GwZWYTplfutvuxaYdgJObhMUCl8MAFjXdsrt2LdbYAGcL
         mwHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJWk+aDZQLjZySpOScJwZ8J8UJO+DxmLVGMR5IYI/TClqZx2A2Lx/NaNK+HSH2oSNgIyg=@vger.kernel.org
X-Gm-Message-State: AFuF++k0lVUUetEp2ucBoxJRfCyPX4Gr+Kvqi2c51Bnyz5AntepCkKp3
	N2MTZI1S5rkGD8bdIVSrHBu0X8897B8JcmMh24IPuSmoy0VLxnk/wGjwb5R2jSWIDZrVBUfST/U
	gDgGPaVWhdxrSk72amVZn8+1vtwIxh5nfAEFK
X-Gm-Gg: AYBFou3OQU4lm0mMob33FnntfD4JbsaJh9yNOkAhtyf87ujpWICQEkfAzk+ZYoDuNNI
	W2WeQ9OXH8AG2nt1FOIrmFQTZQiU577KXNNilPg0gxUjEoqB9gIlAzPwX7MK59lYhY8Dup2Ptbt
	/JVTOGpQgemQOrVyGP1iRvwjDH17V9U8oJo3SxlBJyOHMBqvZzhV7s0XUtC6dAauA0hCoOm+MRl
	bT3WsC4gzmThZyP7VQE0p9LMrtyWYZSG5nRAjG/uD6RaCq7DvHABafKnIA0qRrsK35TDxaq3foJ
	MSPU48u4RU/QOldA5F7BCdk3aoDvq+GCCf0N/5uWeRqp2dhC8Nfa7eY=
X-Received: by 2002:a05:6402:5d0:b0:6aa:9f87:a563 with SMTP id
 4fb4d7f45d1cf-6aa9f87a856mr1353645a12.19.1790029103782; Mon, 21 Sep 2026
 15:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com> <xmqq8q4uo8fx.fsf@gitster.g>
In-Reply-To: <xmqq8q4uo8fx.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 22 Sep 2026 00:17:46 +0200
X-Gm-Features: AcwNN1XQD_UQmuq35gP0JDG3u7v7x1IIC_2CWlExCsPly8UCus3sLrzdQJfnhLM
Message-ID: <CAHwyqnX77+qsstUmvvLw5Jvfdoi4V3YVagMddYxnWodHR9oq-g@mail.gmail.com>
Subject: Re: [PATCH] object-name: explain why <ref>~N fails in a shallow clone
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> It is obvious that users would see such a message when they say
>
>     $ git show HEAD~20
>     $ git log HEAD~20..HEAD
>
> but would they see the same when
>
>     $ git log -20 HEAD
>     $ git log --since=2.months HEAD
>
> and internally HEAD~20 fails to resolve?  Should they see the same
> hint?

But I think the 'log -20' doesn't even give an error, so where would
we show that message?


Harald
