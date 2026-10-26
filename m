Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793012483;
	b=cvKq533kSwe08qE4sE/kQfnYnA8Zs+jWMR1+Lph2VZZ0uXFjDDvHgx+3kUlrT0MUDBXg
	 jONVQOOyeqCsbcYnZZTuCWW24zI2Ls5g0R8Metf0JemE4b4wgOwCQW3irQI9QJRvvX5hC
	 iYMTs6QXQ1lOWsGZzlwfunyedR9nrh9HnmREWdH0EFDzbZgAYu5HlS5kalVrSdUWCBea2
	 sQ53vxQBe3oE3s2SiDuTkUSJ9LbRWwd1AmBlkJ9HtjJNq2YwaZQLVJ4ExUrxeGarsoHRF
	 m2uysbAV64axYoePLJDxDRvhQTGRD1UMneSKrS2OJcz01m0Oetp4CHSUnjuVSsAJ8jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=yRj8DU9SIwprD7xAU5wceBxDlPEpHxPFbl1+bV3x4sw=;
	b=2FjAmOFgkCT4BcfBAIrYf5NRyG+gWqr3beLpm97BerI6cV/E2VwpB3IONy1cAefnJU2e
	 6rRT5i1E5DmZCuTC7HmalUG63tfkr0HgUfWh+8eDvS2moeoN9Sma89d5jry7xAqU4KJ7G
	 w28QrfX93o1C0KfTJoPDlwRoygK2QqPy94FFNenTpDSO07HkqA/TNkLeLLGwax92Ii1ga
	 Qha8V5fC4hgyGTPnG623ZBMEKtR+q/Uvv5J9dvwsOvLjV+B6cPAYAHK/LUcpCXAe9X83q
	 GMjy1DHmBJQToiGrEKDUpHCdwrQ99/TlgJ5x4wc1maBPsrQVjwmE8n4iL+6LPT00ykg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JUPPh9hX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDEB606A323
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCDEB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JUPPh9hX
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1aa2848d2so4563137a12.3
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 04:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793012481; cv=none;
        d=google.com; s=arc-20260327;
        b=pS5l/0Z2ZAdshbByu3vVMcrInJahq5hhLbWT8C/DNV2Q+fXJDHjvaZTGXsvZ5BjPrG
         rXlZlsoy5xaN7Pe/Zgma3qtVsa7z+n0LZCtm7K0/c/O0bh0tsae2s30BESApDtcsOGhN
         ZzrtL0WR38IZpRYm5qJ3uW6jTT5DRU36XNlhDF2r10L5MjkrltTq78kvB/nDP9vF/WVQ
         hHDwtlqQAEuMPBu0dWLYkySoVUpcW7FzTQ4eh85hwskiMAoKdyI8gZq6H4WnfR4hW2u4
         T/YvYw5yN2qGkCbCt0H1woThYEr9DQwg4HnV08wUdNvHlvKx/D3RqGjsc1SYJyordwUo
         4lLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yRj8DU9SIwprD7xAU5wceBxDlPEpHxPFbl1+bV3x4sw=;
        fh=Q52a7L4w/Wx21h1w/OF+MR30G1rc5jUAGxPV2bSaJ8U=;
        b=d7fICFgtPzwFI0gm+9RXf6vltN8GtTF0APOrgPYJgffC9yy5Nt6XLafVgG58Xv61kr
         T3ZMGQnsxgrWjxsCELBb10et6MSNKFeH7LznNvYqTIM9X+3nZV1pG4rzJLBBJWAlisJW
         1600iH1ckGBlXoT9ZUznUG/sf2+qJ8KbVCJpkZVnP5rrbr+fgoK6KW6XwaSz5B22qBgs
         QD8yom8kxcXU3bWcTHmJBUr4XwKxe7XwBfiRnmmOfpJEDBEn5Ykkwj00Rv2mC0eOlKMM
         w4NPBy8kcinjK9jMjUPsNzKxdiMwzC6T2sR6YgsFezMsTNDmdy2v5SwPH2xHAG07PtWp
         Estw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793012481; x=1793617281; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yRj8DU9SIwprD7xAU5wceBxDlPEpHxPFbl1+bV3x4sw=;
        b=JUPPh9hXK6en5tG3hr4/ojb1WIbOJOtyvwEjfvag84MhSMvq32ePkIKKNdXSLY+Ktn
         vbJcOp3HVJwRLT9oGUtAWX/9B0m+7K+HbiFXlFy2cEMt2vgjZ0PrFTc0G79z4rm1yvSR
         n9jwGoJvUZu/eg7em6ss4SYhLfXaW8f2tmPR1ZMUO86wpvTWwuotc8a2r3vYmKb8JgOH
         g9SbM0uJc/ESp0K7nWtrSMvna8K4gM1ME8FtKkaPXbj2/isEo6pDvWzsjyHq9x7uH+1o
         V5Aa323IXvKrFoC1yPZ7+J/2pNl0dn0sU/E1cJ/lhYm3Jk4cBjVxrdv7Q+ED2XQzrsZl
         XpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793012481; x=1793617281;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yRj8DU9SIwprD7xAU5wceBxDlPEpHxPFbl1+bV3x4sw=;
        b=vyoQwzDuLdC+7FtqeN3dyP8FjvgLMhkofGOh/9Wo+jzm1ofoiJiFxhquGohxYv+TnC
         iiSJ6VUOA4B9D/CI7aOMHSnYmKLRcwnyi3jSjE7YebNJaBkATuOeOyJANFJ6aoL3cHRo
         Ilopf/q0VQ/717eUH/D3uPt2xEBgY7kbsuzXffRvXVi9ZJRs1GoQHA1qI3sctNC9YFS8
         ZMdUV4/4lIRVY0oYfAEcKznWqoTjhwmXc2ovjUoIi486HzG7K246Wz21GVkJGAHTK6QK
         GcKCljVox14aXHhFdeNbjX16pjI8pjq402m9k+vc6BAOLH6FCmghPwN952K8xkC5WqRj
         6fFg==
X-Forwarded-Encrypted: i=1; AKwUvBwG9H2UdH+1tcLMPSs7FKYE0O5BlcIGOwG6o3HIX6rSj1IxD72vzPFZcJr3vgiU7YwGOJw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZkxk0epF6wrCs7qvjZgw4mQhml9f1eFW2EWCjrMXnMrsM+VO6
	rETt0C+fzqBCumFc/v08Ry8pY97KPYWlJFaIPWuk7vVJjeg45zM3ousf/Y4J5w7VmgA8jDFfZuo
	yI/S1lgu5cdulBcIGTP4J3eOAJ/IOwPw=
X-Gm-Gg: AYBFou1iM0pZtgqYSow3gGz9c3ZsFd+DlL05VJMXmSDtu4Vd/WDMAU+nCWg+npMtaxM
	9du2UX4+BirvQFpLUHA1srFuiqronOpvIlei4JnvWmoPZ/Jfoa9MbwoM/E0sW7F44sTU95PbqRg
	Qmy/tKYKhAOenWV8eRCN5/76c8Q/lAIdXm/O9eFptxnfwGppOgFPRxxO1yYzfKJjtwW4pazWFgF
	nfpm2zupus1IN+p1MfKuubjCLSDF7BBks85dzyB7TR9aXcRBJJGBJ9h5VU3atk6eLlYjolpQSLO
	gkGARDEsJxkfZYsEiv9peNkXx1CA7tp2zv7DnQVHkldJSETf51iLTpjd2wkx7xYCyrZMHBC0V77
	z3u6abNMXDKi4jCV5L7CwVgAwtMX/habeqq031osjohZehSfsOi5xCukLAnQPilhajS0N2g==
X-Received: by 2002:a05:6402:2049:b0:6b1:b75e:e0b9 with SMTP id
 4fb4d7f45d1cf-6b44324016fmr5550284a12.29.1793012480396; Mon, 26 Oct 2026
 04:01:20 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
 <pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com> <bfc2b43a-6198-47b0-8868-d92551548f22@gmail.com>
 <xmqq5wyr128q.fsf@gitster.g> <1bc5a05e-3d3b-4f56-8b11-2e276cef48ca@gmail.com>
In-Reply-To: <1bc5a05e-3d3b-4f56-8b11-2e276cef48ca@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 26 Oct 2026 13:00:42 +0200
X-Gm-Features: AclHuK-2bRLigxahae2Ugs5VcYjMiRGcEqpePJaEpSN_FnGOjHJeWYwe8ZeKJKs
Message-ID: <CAHwyqnUckb2ccoRToYwk=OVkHtWX1rRNa0z7TwMHcHQufNuNEQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] reflog: add --operations and --historical-branch
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> It would certainly be nice to avoid creating lots of entries in the
> branch reflog when cherry-picking. I'm not sure what users would make of
> us switching to a detached HEAD as some people seem to find it
> confusing; if we do decide to do that we should make sure we update "git
> status" to explain what's happening. I'm more relaxed about changing
> "git am", but like you I normally detach HEAD first so maybe I'm not the
> best person to ask about that.

I think that the fact that all of us have our tricks to work around
things is indicative of a real problem.

We should attack the root cause and simplify git so that even us would
prefer vanilla git.


Harald
