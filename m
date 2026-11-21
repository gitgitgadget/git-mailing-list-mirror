Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795288718;
	b=LfExy5uhxQfUF6yjsxluQEd7XbkYuVksjnHyXUQ3WLLsCrK7f6q07X2UDHOWJZBMyttK
	 LTleuFYc2k+jVfakUSwW+9h7S+BcDpRdZxXOU6Svp6GjMKrlp7xqrcJ+r9MemLZYy/ADc
	 0VOYVSM7xJfjdXj+xVGP7nD09lUBUJE3T7D+SU6gNrzJsccD7v6jX+iNWMld/9MaWet18
	 nWZB8eGpf2SQ1i9VowNoTVdR0XSImOYsxP1m/KRhG5NurnrTh9TU6g9vxeeNEO596W0W/
	 33gs1q2FW67iVJgzYlETU7eOrTia26h5QWKA101Nht6AbhVtnJZvPqNsBbnKIlff6uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=72kf3xfXSO7OtcKZXAPNeW9dcWSqWoQSABb7ynSBJAw=;
	b=p/M2sVw1DqyMiZwAqTP9ldGbYT3z2lMVyCeJxyoM3402HF90ex2h0s/g6zlHIBylXUpY
	 5fMbfeQz2BMHt2qziWJGG5UPBEgdbs88TlgrRHb5AE+6AKwv0DDtRMiKit8I1pj/pz4lo
	 lvR3ePmO2Au4yOjz2T0KvTY0vmMdlg4gHRyXLxcoE8tWTvxAAnLosl8yIh4FcsiUoJaii
	 0UtrNtsY4lUjrPR459iA0Z3LkVteWGjpoWqQs5l4eJM+BnayMr2c4A9/jywqzFtCT0z/P
	 vnF+WfDEFIbvyvqItBUgRlaxaQcpp0Yyd9no2bUs87x1GGpB9kHq5dEvQHg/Jj48dRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vuX9I9kR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFCA606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 19:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DFCA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vuX9I9kR
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-53c156ba662so1151585b6e.1
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 11:18:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795288717; cv=none;
        d=google.com; s=arc-20260327;
        b=bPbpuEVhM4RNpdMbaTuTKpAgGlG1Ad7KMAt2XqZPZa5ESdTDDMAwNkFFg463Ci6kMX
         tF0Er59zcEzjxc7LmOTS01O2vku0uD3penBJ1cRTJT+0n84coif7HnAAXLrGd2QIml3c
         sZDkLX7TQX3Gm+2dy0j//SZR1S6EHxRHvm5OzC9cqu5Na/meX55jwHVDi9cM4QNZEr1c
         05D03Yo+ppvmlpmlQCP4Gw5ttR4PXu66UOsvhzysMgzhWAclT29mwXmYmx5bA2PVVnbE
         ErKsxs8GQNBZx5gWVxQOmj2/ySdlfNzwGpWTalWdPaiKzL0o5OgJB1NztDAgaIqN51pM
         dV9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=72kf3xfXSO7OtcKZXAPNeW9dcWSqWoQSABb7ynSBJAw=;
        fh=RibIwiGwtzKC2Y0GHyBA/uOkHiJQGVNqyxcdxyQpGb0=;
        b=kzRyOMuqRWqpNdEGJGI77X0M5uoJrMeY/RUcVijrca1R7S1Rv+RcDGLSv3X3zvcy8T
         mP/MqYeZ9/U/0y8ZKReGhZFkA6LQVlQGkZ40tDeoneXuie87f4Jvc2Jgs+S1LrjvJLi3
         mX3i2h7OlhvoT8YohVTHWisWqgcmK4znOt5gyedWEqbQ5Zi0qgAHD9M/lTXZr4emzxtD
         GeJICxxKwj+EklYj9PDpSrGrxNrqz/HdGfCuuBH5mWHw4JAb6qbmf63AHAVBxSKZpLRd
         y4MIKTAzbLrqNjtMY9uew+PGToTvfRmr0AT62VxXEQVJDldxqgasS3yaIxTj/EYbra5j
         U4DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795288717; x=1795893517; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=72kf3xfXSO7OtcKZXAPNeW9dcWSqWoQSABb7ynSBJAw=;
        b=vuX9I9kRw5cbaD9U41apVNlVl7UDVAyhYi5bhXoXb9QTDhN8+0Ag0sSoFi5TYofenn
         VbMQAJdiObceCOXmtGI4LiJBfozUa5Qv/GeKQx8/wDI6y0CeVcT8a2iQfvgxapUQzj2x
         qAeDXUMDBJ2jq+SP8K2NIGkeWXrKNrBKAbN2xQVV4A1X6wQAVXGR83IBhDI3g1vZNyaS
         oUlpl0WxlqxRAWZyDkQN7u8Yf7kCPf6TyODffJRaJMiGlAd4QQs7RQAOk+Z1vRR8nm5w
         t72Q6RA6PV0yB1+YH2U08MZmJ602bMJk1ZfVuTNZQ8rPLnaYXQJpisjQetlelObUtIXW
         jFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795288717; x=1795893517;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=72kf3xfXSO7OtcKZXAPNeW9dcWSqWoQSABb7ynSBJAw=;
        b=Spo+hoPMoOelibet+VCScGdMi5+G9jbvCERW8rLCkmqavkj8iXReQc4t0cLieGBmUV
         umQPSeinIzma5Je2bZl6KOd6csXlsQcZiQhq8DQvyLb363KBMgzf3I7qWahlw8t+uToe
         uckHwupUJ9PzqysduirmyvIWoVfF7BxPwHVFtm+0SP1895sBfJOV2ISJVbgfdvF9Orsy
         BSkmTAn3AIp6Dpcl5G+A5jvpFIyHPEjyDlXBST/XfylhNa/7QW9Lhu7Ps+BFt5o+2dE0
         qGF4ZTwurWyTNDwxJOHQaaEHF4KxGwhPVCDtX1biaQHSDFEYxi2xC1mw0ei20ZDUGo3D
         u+3g==
X-Gm-Message-State: APuU4Z+y5IWrSntV/nw/Ffz4qAzep3e1SuaJNd2FGRovrLqvvVTiQyu0
	sB0lrrQNqqPhV8XWR/nfcVxDYXg7XFhfqlsIuZDV/ymnF37ROJfaooQs/FN2wfeAM1XaTNvg/ou
	0a3e12UP4TF/QHTI+0UrouXIf/Nm89F4=
X-Gm-Gg: AZFdTZeH+bl+5ALXzYTeejCQQQf2tGHcam7sEMkrhxd2nNySyscRLR9Cj8n1YzE9kan
	UoTcY0y4OZIgxwKRjXIxcN2egNOPcY+iHZduXUV+9nQ0xxMjj1nf4RMfvFv96p4UAbQNbq8EqOb
	ZtPOwtICRB4MRvlCggsFr2zFTHohzDfOVnu/F/En3klNZZd0sObovV2LOLcNkSI3MBm+RK3yW3i
	ddSJaLMqOMWwhsB+4TcvNCSPd3QEq9XUzPFSC0A+pCk7uid51Cv8P737dmXUAtWhyhc3lZxNsUF
	h1IvTzyyIlJVMB4zl7QMCZOZ7o9uujwLsjEUXnxQob8Moc+em9qNU5D0QqIufkvjFiaWtUmlbqh
	9TVIYKwRH0t6fyh5a9PUb4VJgHBpb18mUZ0k8bIrTdgdo30hlfz5Sfungc1+5DdZdmTXcPej3yB
	fYruAZCFA+vHU99hfcDjab3dEApZa02kkKuuZjiUWb85Q28aKKh1NeRA==
X-Received: by 2002:a05:6808:6406:b0:572:8a:59e8 with SMTP id
 5614622812f47-57a0c9c6c23mr6971368b6e.55.1795288716950; Sat, 21 Nov 2026
 11:18:36 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104202228.24642-1-edsonwasswa54@gmail.com>
 <20261114184752.1417-1-edsonwasswa54@gmail.com> <20261114184752.1417-4-edsonwasswa54@gmail.com>
In-Reply-To: <20261114184752.1417-4-edsonwasswa54@gmail.com>
From: Tanga Joris <tangajoris@gmail.com>
Date: Sat, 21 Nov 2026 22:17:59 +0300
X-Gm-Features: Aa3M54rnTvCrNEXo3In7ucc6BZlsQVjmpPkAFoXvrSAw9RF5Xalnu9ZY97HtZRY
Message-ID: <CAKrRMNreGdjSdqaFCe+U=dZRdRoVceUd66b4PEMLovrDMWzHUw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] credential: parse subcommands with OPT_SUBCOMMAND
To: Wasswa Edson <edsonwasswa54@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Edson,

Thanks for the v2. Your tests work well and catch the issue.

On Sat, 14 Nov 2026 at 21:48, Wasswa Edson <edsonwasswa54@gmail.com> wrote:
> This changes the behavior only on error paths:

One more change: "git credential fill --" (and the same for the
other subcommands) used to fail with the usage, and now runs the
subcommand. It's harmless, so maybe add one more line to the list.

Otherwise it looks good to me.

Thanks,
Tanga
