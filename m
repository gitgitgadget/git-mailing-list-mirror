Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792796079;
	b=QXsWRAkumYs2v/hnBC0bVjyAiBs7zZeSmXLpHqpFar6W4xLNJnSsia7c5J+7uXpQeVPN
	 guQo4+TZKZBG5lOYbqgDfrarEYEx8KfAIlVSb0v2m6B+rVUyLXRJJiyASffAcF4Ab6AF0
	 J7Cbclm8dGTk5KyagJYbtQuvqX/hlfdPD+rlYoOC6ChHOGwwb7HlDUNjvV7QuY/vr7l+T
	 y6/43saIqMhzihMIfPZKaL0476B3EFz+GDrQVmP6hyGf0xmy4Ek7IDJftiYs+0O1YZ8Zb
	 HdCNgEt3RAu2VDy9ZIARRmw7vYQawCZpHV/0ZLQ0N1Cp3JMuzYpRK35GtNiihSGXIxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792796079;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=fL/NAj6aOqkgBS+gvUnvnUUWNMFrZ1yeTyD2MnA8LTA=;
	b=q6h9D3nNQ3q5DJmdFU58j+w7pmJT6RuYZZ2WUMe8baVRphAxJ6b6an2wkgWAqvPrfBiA
	 NmZDbjipR747+F+6OUB7qNEY4Ju8lTrPRnrVl+b8FwI8tzbSa8NlzgmLd9+lNpvwJFcJ/
	 HLAJ+6DqxQviv2J5+xm8LeFxV//4j1VUEOSK9rxL/Wsp6M2y4Rx8dquq+lgXHskqrfdfG
	 vNVFuWQq2+0casRT5pycox/1xEZYn/Yl4L4g/z01C0vPwxxUPfBbLOzHrpOCMlQaElqJz
	 vG6C7jBWadKG4asCMyKom2Ztwcg0UAV5nqgiFmSkDGmUWRFNi3cEH4h5N8YeZJUAmTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XNGZ9TDl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343EB606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 22:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 343EB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XNGZ9TDl
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6afa651700eso1886812a12.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 15:54:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792796077; cv=none;
        d=google.com; s=arc-20260327;
        b=stpf8NcDmj+k47iVPcDfb/HZ4f1P4QOaJEeNruAHtkgfO5S5A2iyHFXVrVvMLRg89j
         DbNQQ0AEhvrDlQBj6a/bmcVr+1DJ4EoX3kEy91p2jA+15i0ANhQCArRNEy3SO0CxXSOo
         y7FY3HhS0iRjCM0VWV4ccdQticZUVb6lb6/nXjpBdPihp/cSVifcJvy/1gjYr9jcFOFB
         ARYEVoAtXG+jswmmxcMSBYZn5tqtXiukTViVWRof+lXaBZenHKyxj7FvFKwZ5jfofPKN
         abPdYW2nhmQN94To5pX5JJuDIMTwmxDCQvYXwnfbVnzh7iGOFVgHqh4Fn3052BX1cBa2
         biuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fL/NAj6aOqkgBS+gvUnvnUUWNMFrZ1yeTyD2MnA8LTA=;
        fh=RXV3uVSXg92iwqTIpxgZMLwrLrnACCasOa5931riqgw=;
        b=sIiPwFqLN1VVAMCUi4wbH/qD+UzAU19q3jCfXbi3h64r1tGTNdny3DYDvw+7ZIrv4d
         O+8k3fpnmWqQGDRicRVWbKvBoo0YPcd4CefLlka3+/328niHqOzsvO+AlviRtnADFgmS
         6BtdkVG5XDfuddn3QKm0VFORD0JhXBNOpCjzIN3egkaAJ4rtdGiK9r4UWcNabxjyGhCJ
         tJQ4a3n2KC+FlQeu7wt73eTJAWeWQSCVNsSPwm/9l//aNxISE/MJ5dvu0dZopmbuf1BK
         Z3116u1PzzjlRLBDbEM9Va56RXOgKDZjvoZYn/WXDTHxYPLShmdo7xzuZwJpSpI5FPyd
         vp9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792796077; x=1793400877; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fL/NAj6aOqkgBS+gvUnvnUUWNMFrZ1yeTyD2MnA8LTA=;
        b=XNGZ9TDlUie+caNOk9eC2nK9OgH/NoG7UVj9I2NqIFakZr4Im4CRRLkE+RSyaMyNbj
         n2KnX5MSesizc/T9ZNakPhaPmUMXrb07J41D8L8935CXdX0CDLB0C9kFwZZLXsTptDRr
         MDhSmaqL1q1aZJYCUvkel1WvZIFL8uB048+5/vWBesN3iFR4431G9GNeA/0pGszoeuCI
         C21vqgVzm7VR2nI8VU0x8T2l12D6PoMHZ9br3EK8eKxV1iQql8bntGCj5G/sa8lq6z+a
         Kz/reWF9rGGb3Pd7mWi/z3cvNYQ8T9Y9D225mhdGjLVofixEEsRDVr9V4f28Vp1vdpJ2
         IkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792796077; x=1793400877;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fL/NAj6aOqkgBS+gvUnvnUUWNMFrZ1yeTyD2MnA8LTA=;
        b=u6g4lu5tL3+uN8G1kvPdd+o+5VqDHznqrQi+3vqWyZUHey3yIuMuVLDE4ieYnrFYhU
         3q+ObaDcaLGUzNx/+19e1keAh10qrchpXyW2BeNOKH6IyCoqLQHO1dTO1WAdIDeJXLvE
         1WKEdcmx0CKtiZgN1/wI60EUJcXITKsWOvcMMEaVp7t69C00GyA6XbeZpNrsW6oMpEnC
         J8fO0jyWCx3Naa4FbQZ2ebS8y6PcfAYCgxv5Fu2za6sfzYq9RBzRa7tezhn8rfMjOnjV
         3zxu8DBcQA6jW3blql9otWuJhFVQ5vz3JxxqI+zh1VkX07MlqbwBQFk9TNJ5jcJ4MPDP
         XwRg==
X-Forwarded-Encrypted: i=1; AKwUvBxY8QkQad91ltMlDseM6CsHd8zKh1NGcuu41+Vr6H/iQqn0zqAEzbWWtTM91LYSAB5QZdY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJ7E5udN1UbD920azt+r2Ziw90EBI9PSIPk8sTUdHbQsqTwKg1
	9Dip5VbFb2Gw/PGQ2+6vPFt2jqYmxj6fH9045h1OVFI3Jz1DVUqoTs98r3TeJlC/PPgoNkRp8eh
	W5hrw0i7kT/iflhlIKJKtdsOFRSzBrUN+fZKq
X-Gm-Gg: AYBFou2WHZNB1CgrXhLxI1PjSW4vJDHiKN+Bxco4hdkcpPxW/0olT625x+zY/rCJi9r
	ZyHMQe21apxmEozM/mLaYNasnjqBhiPb14tYmGpAHLwUJ0WBtAP2ufGFbuGPZlbuT4HIqAoCDEI
	kpp2SwxKCA/B4gWG4raxxQFooRsCpEJekqCFRbrWn2nIynhHQP7TRXCZXKWYpGrhE1fmViyFXX1
	nQFgVg7RMFscTr6SLj5gbuApBSKLS+sFasw5HPvNR9K3On7cTWCeJqHda5KkybuNEt0PLAydUQ2
	6AyPfqBK/K6JIBptAuNHvbBCUDzGb3PYtb83RC3hFo+LAN4vO/I8kBPmz31fx/PCu7Lu1qyrMRY
	h4ZOx+kEolRvq2Na9gb8a+00g3cjoizj9heOVlg==
X-Received: by 2002:a05:6402:22f4:b0:6b3:c320:8858 with SMTP id
 4fb4d7f45d1cf-6b442fe4726mr488017a12.24.1792796077519; Fri, 23 Oct 2026
 15:54:37 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2458.git.git.1792437798463.gitgitgadget@gmail.com>
 <pull.2458.v2.git.git.1792585662669.gitgitgadget@gmail.com>
 <xmqqld7o71ot.fsf@gitster.g> <CAHwyqnVMgAhyHrevXOJ0sBKkaPPzSmCcCPSSeqm6dm-MRX65cQ@mail.gmail.com>
 <xmqqtsmc2hmn.fsf@gitster.g>
In-Reply-To: <xmqqtsmc2hmn.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 24 Oct 2026 00:54:01 +0200
X-Gm-Features: AclHuK8vn0NUiR7EpwGFjTZAHns0IIcXkjBNA788TG_0hwBtPwADY214i_vUlso
Message-ID: <CAHwyqnXwFwJYSA-ktNuDKk6RfXjyvFiYka-K13-9wq=qFgKnjQ@mail.gmail.com>
Subject: Re: [PATCH v2] status: compare against both upstream and push branch
 by default
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"

> > This is the point behind this: To ease users into triangular thinking.
> > We should not assume our users are git experts, many of my them never
> > read the git docs.
>
> So instead we should assume that they start from mental model that
> was destroyed by use of GitHub?  The need to do so somehow makes it
> smell like a sad world.

I think it's better to accept the world as it is rather than engaging
in wishful thinking :)


Harald
