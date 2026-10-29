Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793264610;
	b=Nysd8kmq7EGzlQ2pxEPzyVWNK28zaa0Gh/JqfsTP1Ve/8agFEzItiUEwk2NgSppvPb2g
	 y225DRXFZFRPsFaOOb8lvoXec3ac5vv5rO5gZGmcp3W+pDSBsyYm2lLmGmtFtdJHAaKSh
	 TglwAZ1qEcEgbU9pGwLYxQaLt9cFl4lk2hBIOIHjSD5wCUpNo7Bc6H2nsnAHfStFVgts/
	 zjcurNSoCnxCrhBeGuVmrUsscHoJDOKpUeyJc5YIStWmtlwCYstr0kb/Hn5kc16bvBdGv
	 cx6MfUDbrQ+YOCwMg3bJE5t8TosL9g+dLHYuGtWDIORF5KjfFoePXgm/ghaCkQvuaKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=EdBW87P/Vk07aaUk/vPYcX8o+pmfZhJn9vqeO5NxSow=;
	b=Br54Lph6FlZScLQ6d9wLBQJll55NmOm3eCwW8RvMECHdowI/GeeR+ynZetVRNjLXshqy
	 FVkee4KtIcbq/tlLfa0+GhgtqKGl3r5gJLXHtcssUSgEH/qNT0RZmOLT5DizoU6O+a8F/
	 Z1Z2y6eAq4OIzFExS9CZeWmEX/Ws3lHGnFSW6oLe5ukWG4q1y+uYnjZZmnIkV3GDaYyIk
	 NVVb9OxqnhmGI0m2A3t24NcBPB91ekaJEtU2cApifo2d92tuffH4aIVpeMsIsBr8its8/
	 Qz/7pXNCK2SjobmC9FgvR37fVRlDmXaGOk7gzkGPrHABEYkoVFftiEkgPS+qCnE1a0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TFBxTues;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25816606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 09:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25816606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TFBxTues
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso15917297b3.2
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 02:03:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793264609; cv=none;
        d=google.com; s=arc-20260327;
        b=KmAiJwILw88PEXZ/EBJQIVFcf7Euw1DKLB52HmXDrp+4ztRhm65dcKIRJRZb9QvvWX
         C1aiD9p6EGLAw/Zj8bfqmnrkcqiw6bOncsu1ngGlUZ0t8NsDO8ws1wsdUJGH6nH7/9xb
         dBAXDJb7Szo2lUzqcO8+ZXxOW7qz/Rk2r+RbQFDbaFutqZ4HyOT8hDeN6LN+Wk0KKYPm
         bYg5O72ZVVyGdxrw+/NK1WdTIfzIWBf62QNlRINoqj6g1AW+4XSFTE9GcQTAFP1rfKuo
         x2yucFBi/ieKzKeojD5qQP8ZF2rpx3vyvhQaN9sVAAzFywtjGqf9R3mlJtGqljaGrr5O
         FqTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EdBW87P/Vk07aaUk/vPYcX8o+pmfZhJn9vqeO5NxSow=;
        fh=EP9x71YrJFb+fHMQIFA8k4qh8iwZGy/Vo0RjP45odfw=;
        b=S0z/Qx9KycFPVVRbUBz6HUv8gdHfuWQfKWq3pFbWNnQ/zBfs46XFtlw6qHuWKZs+Jk
         cnYvum5xhet4M+6z5p5pIhv7Pq97l7JjG0ssajmBDATLPtAwoR2qn6BvVkpZB23pd9jC
         W3DacakXBhZBywBDyixh5qOG8rtALNhpHXKSfFDYHh5lw7ZG0SBWTWoI70ljXJ6AtYam
         bfmVD3KZ+r33jIcyLQ14NUhEAo7DoKJ2VmpftoDOcpW7ZwKd3BB8ykj60SMh5vMhMxOV
         vE4GT+Q1T6UR2zi4anj7gIqRw0syZYX0YYkLtHJzHUCJWp/OOA7h17CKvFVkbvLzLdkk
         +YnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793264609; x=1793869409; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EdBW87P/Vk07aaUk/vPYcX8o+pmfZhJn9vqeO5NxSow=;
        b=TFBxTuesUIcjL2TqWiwXUYIcP0sa3PO4DUpvsu6lAlPaCZ/rnQm/bRHL/M+r3Dv3O6
         hHu3EHyP+I3+gAioxjYTZEtHhYAhlEtD2IcsHfqGT7uxKh6GKC0f34ihrxx3tR//L3fl
         EUU49n1HlSK7gf+Y6cCuCuas1dGe77tum8h/pTKnFJs14nX8gV04UQpN4/3SJMggmV/G
         LOR48iQD1+sUTz9msIF8APLzBh8m6p5RK0zdKjBIFePpLDYLx7QOKdyp6U14tsO6ZAJs
         ViRrGNa4eAiDBcOqy8syhaXfIUk+C0n24N2Huu8FFISZDCbhI6O9L9XBPlkctXgj22Vm
         tfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264609; x=1793869409;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EdBW87P/Vk07aaUk/vPYcX8o+pmfZhJn9vqeO5NxSow=;
        b=XrlgbnoKpuMy81zvhegvol9JhHP4vKXGRzP8VdTUGZmW+w11NGEyZBRVmSG/pWTXoa
         3IWuMzyGv1P9qxLUGobNCvT6/HKIvTUYudYN0BeuR7wH591TkIRe36x0RP4tkjkIl3aC
         XqAoEk3PeE9b1AJIlvpdhzx46mK2M9CdG5bdPmm68adkBQ6zAZwm/P2UPGzb5kbbgyI8
         JCCgDJ/Sl+qR0mXB1gI9UOtzf0g9aX9WDWhflVzas0HqI3ceLf78nK76BGsRKBkQKbtL
         ypST9eDcaMdHoKsiKlSaVEwlqM7ptdX91RD5P1GWWypQNxrW4vbwlpm4o4QlXLb0vtVC
         Medw==
X-Gm-Message-State: AFq9FYLNXdygyjEwqXcmz9P+36vzXwSL4HMkXL3s2pRuPe1Yf6im2AoP
	/YPNmE8o5fOphGcLW/hdDEwWwRGD41dy0v6bNh2vYH2wVwk4Tn2jeeNm4noz5Yb+FNc/ypsieKF
	6IWrI05aiD9TjOn10hf0upOBYg/lizdI=
X-Gm-Gg: AYBFou2d9zX6D8ADKDURr65MJNi00aBpGixax6QEaXu6OSfh1+ZlsH4EEuIZyr+/H1Z
	0bDD8wbkj7N3oehgmp7OLl2x1AN3AECk0oLI2VbOW2NVEwursnb788D4i8kZ7DRQIOOtbU0X2HA
	3rfLX6EUCvkE3K7uxBRY+MNI/Jxyi9XaITrfXa5AnvazMMuIpIPYfHVjB5Sb92T+YMYGVWQAOH/
	J6d4fym/RYkhtqHCqBUPs+PvMcAOxkEN7rORwumpeURz/OCiOdu/GeozVznAm0hTmW3MypdTKW0
	4TcMl+mMtVHfi37WhzPYmnmo5jrpdXB6JCV52seCKWbvOZN6oXxaJZaTm3wwkI9DXGp90kwuP40
	tC57+Qm5NQIRhC2HhJWudqrmekQFVF3XOKyhHWYn1DhLwVSjhQ9O+ffguQwdgflS7lRs/0x+azg
	JeE38oYSEOczXukLrM2qPttqkr3e2UNSgY4CcFtx4MxjV/AQLXc1c+rHjNOOcGW8RxNW2kIZlLP
	ryAEdXzMVC3YkqLf3FOUpI=
X-Received: by 2002:a05:690c:7108:b0:8b0:e7df:dd4b with SMTP id
 00721157ae682-8b1b5c8f76amr34018587b3.35.1793264609078; Thu, 29 Oct 2026
 02:03:29 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAKUOgLz3sefhypa9yzLszW43uQ=Jor_nRBAJaBXXv0d8M2ePBw@mail.gmail.com>
In-Reply-To: <CAKUOgLz3sefhypa9yzLszW43uQ=Jor_nRBAJaBXXv0d8M2ePBw@mail.gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Thu, 29 Oct 2026 10:03:16 +0100
X-Gm-Features: AclHuK_sWsCcADwRcnRst9aIN97xhBoTKo2JxmX2d_CKe05uxCBegrV_OIMUgcQ
Message-ID: <CAFpMFfA17dnuLSRt97BrM0u3cHAifJybr_Zc2ahr_zq2nspgsw@mail.gmail.com>
Subject: Re: [Outreachy] Microproject idea: modernize a file-existence check
 in t/t0081-find-pack.sh
To: Immaculate Mecha <immaculatemecha87@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 9:10=E2=80=AFAM Immaculate Mecha
<immaculatemecha87@gmail.com> wrote:
>
> Hi,
>
> I'm preparing a microproject contribution for Outreachy and have been
> exploring a small test cleanup in Git.
>
> In t/t0081-find-pack.sh, line 35 currently uses:
>
> test -f "$head_commit_pack" &&
>
> I'm considering replacing it with Git's test helper:
>
> test_path_is_file "$head_commit_pack" &&
>
> I checked the file's history using git blame and confirmed that this
> is the only test -f, test -e, or test -d check in that script.
>
> Would this be an appropriate and useful microproject, or is there a
> reason to leave this check as it is?


Hi Immaculate,

Welcome! I think Shashank S already changed this exact line in t0081

https://lore.kernel.org/git/pull.2254.v2.git.1792061236183.gitgitgadget@gma=
il.com/

Before choosing a microproject, it helps to search the list archive
at https://lore.kernel.org/git/ for the file name, and to check the
"What's cooking" reports, to make sure nobody is already working on
it.

Good luck!
Okhuomon
