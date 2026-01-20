Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8865935966
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 02:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768876617; cv=pass; b=vBJ4GxTVj0yVn55G2OF7vsnnfcy1mUGaJwjqVZFgD9ni32glyEjgnPbxsNB6B5/A41k/0om9s1J5fFBQD/NU5iw8xL88f3VcQhiAopi6LKfEgfdCXo70HgLedImnpR/HMXtJw6vSnjT+Q76LiIiXaXLNMl+N4G/rZGeBPykvTpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768876617; c=relaxed/simple;
	bh=llCYed34LqOrZ1g24Nal7qh68Do9F96bUycP1LHXZpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxaE4z3u3r0mU7PnT9+ZWg4ecZzI5BSFyawcEDWNptcuc1lq6WBiZftzur29S7EzD7ys5QC99pu14KcegdvNJcop4sokWl7AmOHmljriigQACR4EP4Tr59ftFCV8ytHTVcgag8Wxmazt9FiyITF2zWScMbsMWrLVWs5RFxnywS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1TWJn8a; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1TWJn8a"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0d0788adaso31290085ad.3
        for <git@vger.kernel.org>; Mon, 19 Jan 2026 18:36:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768876616; cv=none;
        d=google.com; s=arc-20240605;
        b=YgM9ye/SGw/4q6cWQxAvM82c+NpjB4jK1BS9nO+TSwvjCXKuYyIIrAq1KXn8zeOLSp
         g5VGNoQd40EXtfhTOs+sK0s5hd/uNknh16rcYb0B8Lp7I7j7b+bvAyD+LamdvxKLxQQP
         9MwwhL0GO3QaPPLXaGYKFjxHYqAEx9gTXudMxWaicIJv3WutiZwm6iwuZ/i7v3fOabNO
         UnRYIr3MRKM0t7DDOhqljpG+nXpVQ0vHSnGFtJk8/7j+skSTx+CBw9NB+yswf+wZEXmg
         kcM9Cex0Nd+kGC6JC5E/Sf0uiva7CyZJYL9ze+yucx4w2DgAKFnTOXytbLDt6yuUEZed
         PKbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QPRhQMY3ptPwh+PNJC51EZ7w9jiqotAIlcvege1PflE=;
        fh=YmyOmxzAwSf0Yh7JNsFoBNWPPyIRs3Ia6ickf0oEn/0=;
        b=BWR7lHeS9VzKnWvqiGgrPkEWm/Bj9AQXGi70uQrtkMkCayR/c0NY1LwWQgGM/bvXWz
         /s70R9uoLemzDCVYL5qBnNUVVRT1sxDuS8JABFM8yVPhM+IqlhXTNXM2NhgmP/9+j+Q/
         8vU8F7cdPbQAY2zVkNBKuf50mE+fTnDFJYrogavglT513rJjVhOy8kRN9qbFrou10t80
         KFBpNoAvlABtC8WuLA4ngyhwjLH4eqsO4n6VKUm3a1Fn3o21VzQg988PkIiAmO+8Wk+v
         naCbgNi2rtO59WTBGZw0Wmga0sJ1QRBXShCSnVNSscFHA9V38MSFsn51tHq9yfPCxsft
         Lqdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768876616; x=1769481416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPRhQMY3ptPwh+PNJC51EZ7w9jiqotAIlcvege1PflE=;
        b=C1TWJn8aOJxUsrS5ba+Lw+/UYPA2QnkH4mueZGWBqe3xgvaAVjeM/rOQ8Lh/TXveBy
         vjLEmxAPfeZfaWeGRI+rWvfSiJUswj9xpOovxOc7i625xn8u4li2/k7HRQC4vJM2SB+U
         2Ad7kwTV9XnaaAgWYNzYKpjsDl1fC0iEEnJxAsjcp+T26vDsiqBxLsGmwr9qImyLZlay
         o0qMx0H2aO4YGJmL0eukEn62IbFPB4tm3zQxU6LL9BUpRwXuEYi8nSY87Zr0Iy4TUg0U
         JrsZcaQiGS4y1WLW2N5n1F3SH3ak2T5EU42blpm/btqj9mqAN3UKftV73SIG95KAg/Yw
         x1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768876616; x=1769481416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QPRhQMY3ptPwh+PNJC51EZ7w9jiqotAIlcvege1PflE=;
        b=HvnZjh9RGvGdj3gcz7X6D3xAxoh/9oqPwkQmQdb6CoMowBwqVElFvHkO0p0W4zwm2N
         B8I7URFNZpw9IUFlISRgnrM7u9dcSY1YeTdVYEm7+y7ePwsOKUmfqJz2v/Ztxzy/O9bj
         S4DQ9m6p56T01xhZX0L70xY1eJR+tS9E1olBOwbqaI11rY/Zcnfg504X86/y1lbtEVFr
         egF4EOi7psZXCfGq9yXcSWHiA0yxj1G5HiV/vOkIaD70WVTkloHAxc5uvqIzG045rsF+
         cOfECgJ61JcmkCvk5nVXCTTZfwuM3A3lh5O9rc582pvHuZE/O13EaIz1DGkLhvor/f3F
         zKZA==
X-Forwarded-Encrypted: i=1; AJvYcCWJWCvJHvBCftlTTGIUmfgtIVOX7J5IWOnKXkouBp/hx7QyIN9+rnCELdgWoCZaoY6BSTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8QNYL/EIMRzifMCFk2vBFqbUr+OqlmdMRfvVfp0BSqUqC83l6
	llKU4ur7hvBvNyvDQCjtdf+kUrX4tvt38gLctuNEBTpX0LqFtpmsNXC3ppRJ9oVPk5C9p7LDgr7
	RSm2cQQiCjT8RadnvhwtPRrVOoRjsJ0A=
X-Gm-Gg: AZuq6aLFgY6qpAZDZO/Bz5hFr2WwIsarTH+uagnFNp4lWWqSKZpz5oVPAqO2pS2q7b4
	x6gr2/rnNFf4QJN6Mk92Rt5eHSKBDRt5j//0VH4tI/vtvZs7NNPcCLEt5io0FHR84HUrq8uRrFO
	cnfXNtBsNZlrT39sq97bSvfs9grxCxtiEn2RAF/H1qOmIFUTX+4ignk9R7bGVYGkbqGUEp8W+jy
	k5R2ewfFfTdJCGykOF3nM3JTDO3Xt18vA70ho+3FoGYOENrqW02W6FbYzLJ8h16qsjpyAe7cBPd
	NCa82IYvO5lTTR2qllnKXq01kHmLQkP6FBMmsbxc5c4j5ynH1pJ/nH6axRTqD+eknM8C
X-Received: by 2002:a17:902:f64f:b0:29f:2734:6ffb with SMTP id
 d9443c01a7336-2a7698fc893mr4399045ad.22.1768876615763; Mon, 19 Jan 2026
 18:36:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
 <0437b899-5a36-4499-a30a-c2a074a80f7e@gmail.com> <CAH=ZcbA_HgEO2T2smn4Yg6gf4sm4jrR8A0ek1v9nqsa1MXbRJw@mail.gmail.com>
 <c2d9a432-0753-4786-8de9-c3dcfe69ac36@gmail.com> <CAH=ZcbAogCpqg0RkKg1WjuAcuKyArDs4aP+k=McCs_byDT2Weg@mail.gmail.com>
 <6ae80903-3cc5-4017-9eac-0b3100b93b04@gmail.com> <20260119055947.GA3100271@coredump.intra.peff.net>
 <CAH=ZcbCXAB3vzRbyHkunQh09njyLk4WXvfLVxynXaswEkBv+DA@mail.gmail.com> <20260119204010.GA3148606@coredump.intra.peff.net>
In-Reply-To: <20260119204010.GA3148606@coredump.intra.peff.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 19 Jan 2026 21:36:44 -0500
X-Gm-Features: AZwV_QjvkaV1S4OmZLTT9w9mmJ3bOm2PxwjIrpjtVaRQpD9zYvH7iqBwgLiZPwU
Message-ID: <CALnO6CCf9zEVgWHjK_-kHzALa_JrOUDT_CSA1a_xa5gfPB3LtQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
To: Jeff King <peff@peff.net>
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	phillip.wood@dunelm.org.uk, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 3:41=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
>   2. There are some modern platforms in which pointers are a bit more
>      opaque than just numeric addresses. For example, we've had a few
>      patches dealing with questionable pointer usage to make things work
>      on CHERI Arm systems. I'm not sure if any of that would matter
>      here, though (IIRC, it was mostly that pointers were unexpectedly
>      large and had matching alignment requirements, but all of them
>      equally so).

Arguably on all modern platforms, pointers are more than just numeric
addresses, due to provenance ;)

- https://www.ralfj.de/blog/2018/07/24/pointers-and-bytes.html
- https://www.ralfj.de/blog/2020/12/14/provenance.html
- https://www.ralfj.de/blog/2022/04/11/provenance-exposed.html

--=20
D. Ben Knoble
