Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD0B3090C1
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311160; cv=pass; b=L4OyfczqV/KsjtaXjrSwByWow06igFbvB9CWIyTDQppEdhZ0hmoZvRgqXFSEHQAPLpwGhrp027UmBdEddOyHIXR26oYYiZcuI2CfvKRhiPSaoLV3XjpzUP1BW9l8Bnq8M/i7bGuYmf+G1S4cRQdrkcfEfs9RXvsHcHi0zLBmD1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311160; c=relaxed/simple;
	bh=qnGONlSiTDnbnd/KoSx0CcHHJaIVb6JGvC0q7sNnd+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6xJoYWULdTCz6nyXracaW1F62AnAwbyN2BlnNLva8LuqW0yd6Bqch/zUIFN7b/pU9cvJ5F4+NoGPE7A4EXryLIth6SEHVtso8h07rGln1c/FIW4iZIduiLXTdmGtJOFcEvKrmezBjRURE+RinqkvOPoJZ28pv3W1UtHYp3xGYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=IoQbdwro; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="IoQbdwro"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-662b76dabfcso1180914d50.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 07:25:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782311158; cv=none;
        d=google.com; s=arc-20240605;
        b=O8Awzj3cNtk6wVLDcM5tlt3j+6BFmbCeADEilvoR6OuN+gR8FZ5fv8vg6hWRNi9AYF
         5xUtHrmUfLLBBS8rTRSa8qExx9cbrfhhmCmqXNANcLQsMmoi3S87bN+Id8lGsqdgLNcI
         pI+xABYZZFA6e+rTg2sSX0t3mqmyjVdDc9a2kjNTQxTDabW5nMnd27eTQoMAUriUGNWd
         m+8JwZErfyeBV1eFMv/7gsZTQ1mQ57ocJxpMYsAa7WIW2/LcWEPeC9UW9HjaIeaTRXhv
         pImS7sRNoUh5EqmqieDmgc2c8LAFn9HdY/9wlpHUoPN/bZ/8D4tuRbp/dErM7HsMHpVD
         Fpfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qnGONlSiTDnbnd/KoSx0CcHHJaIVb6JGvC0q7sNnd+Y=;
        fh=i+FfKrkT/bjS5yyC2Y2CUdnIGzB2cEJlB1cdX15KK08=;
        b=lV8evceTahS8HEwJLKUBTOS/ayY6wUoEUfyEvJT3fNRPGYojNeVA4hJ6tQq8Ox8FR6
         xYBfged8hFere9hWSHL1Ugcd2WSECkYKXdaU1DmK3VqZxREiHZDg7rCLleY/YtraklOj
         5+79Wbj2mw+J1ZJgoeHhJJtkfSdx6omZMdBDU86vSIp4Gi3kLcO6BEThWu/9gfVTP46S
         crtfH7ankI3oCx3PgGcs6NVHaIYZLN21qXVZ1IOzDymLaHJtCQztjRTklc17sELYMTyH
         kRdX121S/dy6gRs26CcqMy6VlTVxfIjdDWKmA8kL8lfEWtpjm5d87uh1UUMCdqZXOntf
         Xx0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782311158; x=1782915958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qnGONlSiTDnbnd/KoSx0CcHHJaIVb6JGvC0q7sNnd+Y=;
        b=IoQbdwroP5wP4NL+ByK/4WnAtU7DGUL4FQTXZn2J6KXjz4IVsrKOlSSPF6VModIxPq
         EtsEVg/JBlQmdnyQ6JS8Vo8fD131Qwhw7WYxznb3iUp4r3wMDKoZgIxAHDElvKcdODND
         RIEmvt7F79UmDpwyxO/aLsnEgg0KqZGnGFzc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782311158; x=1782915958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnGONlSiTDnbnd/KoSx0CcHHJaIVb6JGvC0q7sNnd+Y=;
        b=jR7ZyPdQ4R8q72x+fMfeYK70opohBs1hVEXjhqhkcrpYFN2IJxChSQYXPLcjgG5ygs
         w8jLDtKJ9D0dunF3/tAs3kl2DOku30doXKmH7Qt5/ikIEjX02SH3jlYp5H4SxAczjcSJ
         esW3q3kk49N/abNJk7c5Wbl8ieh3dqO2qakkk3x/LFF/Hc4pIup5/rkD5Ijn09XISmkL
         PLDZ2aVoBIIGDWrwySpJPrkHlY0nuLDka47iCPq4FZFBoj8Zpk/0sfXW4r0iI4oBeGl5
         DnxZ84lUoNRSZnL/aD10ostbKbDY3q0HoMvvgtWACXmO85AnIzsubwQbA2GL8cyh83QW
         3wDg==
X-Forwarded-Encrypted: i=1; AHgh+RoO0WEHPvC4O6Xj5d8W1YkB5GAwl9A2nMP69Oqyy2VH7IznYzCED58k29Ae9i4ibbuZFhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6AeI95VHAkB0LCYCEPvS2cJWvimJ054+Dkgh3XOmC5HMaQy1G
	jdNuIEky/YptuPGz6h97LMTHLdQTYcKKLZw6RK7vaxG3aJkMsUjh1Bk45PS+X56sZeX2GSUM3C0
	Pn2E6aTWriSKt/tZsHbyHcqjqZRaWWRmAHXqlF4FJaZgnigVAcI1D0Gk=
X-Gm-Gg: AfdE7cnYfu3jvjQPcp1ErwUaU0AyLXq9xLu8K+I/9CppkfOHURDTcs81WkdjWwhXX6v
	MzNGdngJYTPopqFEYrYrlJUpIgEwTF96Euo5YqDHxmmNsC3/lNMtNM0r2hBuhVbIbZ3stnn+hzr
	IHS0/oTEv4av/d+bT5f1Ms84k7Lhld994IiAISuTYcQpm9O7dZzNo3Ho3FIzhrFAlYNoC3Y/p6T
	ZKr2o5Z9vhTLOrIsLqa0q4nSdRgT0riq2n9J1S3P6eL65I8w9l2JVnF3wz2N8RISH+b/Ajovw==
X-Received: by 2002:a05:690e:4813:b0:660:60a9:2b33 with SMTP id
 956f58d0204a3-6636e62de33mr2170297d50.53.1782311158070; Wed, 24 Jun 2026
 07:25:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com> <67c00a9f-2aa2-4e83-9c0a-317ca589b232@gmail.com>
In-Reply-To: <67c00a9f-2aa2-4e83-9c0a-317ca589b232@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 24 Jun 2026 16:25:46 +0200
X-Gm-Features: AVVi8Ce1B6gMrMu8KpEEMO8JZBvD7ei2WnlPOb-6RqjLUf4IzM35P3AIP7w-GSE
Message-ID: <CAL71e4MnA36ZchLaUsMSoLcb9LO77aac274jES8+oV=yxuigOA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] commit-reach: terminate merge-base walk when one
 side is exhausted
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jun 2026 at 15:34, Derrick Stolee <stolee@gmail.com> wrote:
>
> I like seeing these updates including the deterministic steps. Is there
> a reason you don't include the step data for 'merge-tree (across import)'
> in your monorepo case? The wall-clock is substantial, so it's not like the
> last two examples in git.git where there may not be any difference.

I will have to attribute to laziness I suppose :)
I ran the initial benchmarks before adding the trace, and I didn't
update all of them,
just enough to show the improvement and value of the trace data.

I will ensure that I include all of it in the next version though
(maybe 1-2 days from now?) or maybe drop some of the benchmarks to
not overload with partly redundant information.
(merge-tree benchmarks doesn't perhaps add much significance on top
of merge-base in practice).

Thanks,
Kristofer
