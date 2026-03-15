Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E0034D90F
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577895; cv=pass; b=NKqcwiiK52Uft+59WOiHOmBSTZq0MR3P/IskYaDL/J6GNs+gSQehx9SuyIaOvRSmvmn6wl5IXjaGst/uuZlx8D4kSBedxQa+6DimesErBuqSXexGItoB9Scn0R7lN9X6eObtaOSAHUhflciHVAQXvsvWukBFIlo79qUHD4WseHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577895; c=relaxed/simple;
	bh=gQ9r5sijhwSYAUzLDbqsfBCBeH7YXDcpMUaOj0BUfFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rd9lVlf5o73d6Oh0pT6jW/ut/s502SXJxP49/CodDwjWXKGF8odShBD5KXa7+i4SoEsa4d9JrxSML/6fXXOHNq3naBmZUS0WeoQpLdYES199QXU2C4VhP4tr9jvhyZ3FhaUZL/GaVz69UWodQR9I+1vVoHCVyfefJ8c1dn82Sck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crT9emu1; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crT9emu1"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7991db3dc98so33834427b3.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 05:31:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773577893; cv=none;
        d=google.com; s=arc-20240605;
        b=SElGPM30WcG9LLulux1+juxhEhs7maLrBUX8MsaA1xL5eZc02C0poGvAqPvRiV2AgR
         pn/9oKWQ/g2CqiofX0FOh9qJM/YuswOGXwZUAroPW0CwCxFFkWyURlrMwJkbrEtua0jC
         SZHcZQMJd7qSVfpFxKIaTKSkD3OjA0Bb3/hNnlza8UMVTDIGA1gXw5BasFrwJodCd6lF
         vyym0jn4zc0A+9BP3Hf9mMIzBFIY7n4TecVoompbGSFUA2N3zlQsxlmcicjCDE4jP+RV
         5/Yu0m72qNbZBXOVzVGL/a7W0XswivO35hOgWAtBLW6A0A8puX9V+N/NMqut5WP83xKh
         mlUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gQ9r5sijhwSYAUzLDbqsfBCBeH7YXDcpMUaOj0BUfFA=;
        fh=q/4LnAa62WqoYBTinJALC6mn+j8MDo6jHsYRg7fNwxo=;
        b=KvP7bbrjMkGryYSD0zKWJa8v0PK2XTwh6XqNZ9oQaN01Fs7wDyu/dMzZEADp/kmtFa
         OYDlnrDo/2CqlbMHtsTUjlhY/ZGYa0RDNza7m5cEUYiUZofHoZqe4fYlGDNpuQs81KXX
         OUBcVsLoTmnalIf7r4PoOqMJq6Oe85ZpWBmy8ArmleBdi05ZVXXMfbGuak2hSBBhGMOk
         JmffbHjq9JJH1ehT2Z80rzfxi/4P3a6TMoHq09+ETf9rF6f14FDONpL4nGaHj4WHnF7J
         e0SbiqlRe6p57DlBa/4V3YE7Owh3EHNc+6kaMCh/tjIEB+gQDeFfgVEI5W2QiRi3FD0z
         5oHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773577893; x=1774182693; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gQ9r5sijhwSYAUzLDbqsfBCBeH7YXDcpMUaOj0BUfFA=;
        b=crT9emu1HF2N6d8QKqx0NI7+Hq0WXwiwbsqxZxEolBRKkrxck6ge1+dtGQCzCPklhe
         Y+a+6O6ynq/zmHJHahuL6ydjpnUPDtgM51hAhOhFZa+xt8EXxeo81SM7ZAhrxuklHbpA
         is7bjxFc3ZAEqCfOdg1QqqLaRqg8CJlCIMsG6JupBGdcV+cn/DYbf6Sh8A+Ax8b32lnA
         U9QrOWyTXaUDKzN3JbkQ6gAa0n+gkawUAeNXBcEAvoINUnykZ/x1auzEc/wyUSbunluV
         SuGwH9iQvMiYPuqdIsSIBWVF/yvGUlvKnF+kvVY+UnSOwhmDJKG9OPBH/qN/tPIRgQD2
         uB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773577893; x=1774182693;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQ9r5sijhwSYAUzLDbqsfBCBeH7YXDcpMUaOj0BUfFA=;
        b=Zf+Gi+QAIAJbPWzZm1mGFtxMyM27rKPzn4EcJAzYg0yf45VoZR1XdHOaQiO6C4ZvBR
         2TzwRJcRmhk9h51kmGTfAEWt1t7U8F2gcOFScgtvn8xHUcGTP1mBVarDwi3assAR5W/2
         0wSH4ZubKqAUDFM7p8MQuFNTkgkXRk0ruQUyykPeZEcXQ5G0uCq39fUz86O7CafRH+MU
         k8N5Bn+teuCmJtAOn+hXwu7zx4D7gPxrXPekigAH9lWhDV8Gnqxj3VFm5gUzCV2Rvm5N
         S5d6Wlh5JKTlyvR2Weq/+KqmJNmgxqxqDWcOlIn55dBkF785OPP0gbR+I0VmZ9kPTf7V
         riSg==
X-Gm-Message-State: AOJu0YwreN45Z08uKIK08KKnryYlcyRUDD4j7GtEqTVuDGgAJeHJ8ZRY
	5PwNNWq3uM19REKYiwMDWP0sRKkYmHIRyfP6lEVAivH9fC7Jfhs0refzunPLYbkUeMFCxRy/6mh
	y6CQaZHOSR7wI1dj3LoY5Q6T1GqQaQh6OG/+t
X-Gm-Gg: ATEYQzx8MHLy+rJm6JY455dNFEHUG/XQjmMdr9kbA+wEBSrOCNGRPOV4eeU3Tl0gSzy
	w7p/gMZzrYDnPtJvuF6NJLx3a9LyMJAH4r5Vuq2vhCpRETpHk3FX9h+AR5rhuyp2Jtu9eaC16Ou
	ufwoDI6J5HhFnjbeLE71BZJbqajeS2OeZMo/irLs2ecoEZ7o02HcVhMYhUr6kCVCRJkwOAUC4HT
	aVnCHx/d3kXD16/7rBN16m4LDbCYnE9inoL80B5/KBSNFwHl0HRtoAyd8l+sF3hbul2KntQiIII
	TwRBeEQ=
X-Received: by 2002:a05:690c:dc5:b0:79a:3d1a:a661 with SMTP id
 00721157ae682-79a3d1aac92mr29243107b3.52.1773577893025; Sun, 15 Mar 2026
 05:31:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOAgETOX815iJcsZOjVSYXr+o-uSkkAkEJ3FE2xkt1ODBaOUmg@mail.gmail.com>
In-Reply-To: <CAOAgETOX815iJcsZOjVSYXr+o-uSkkAkEJ3FE2xkt1ODBaOUmg@mail.gmail.com>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Sun, 15 Mar 2026 18:01:21 +0530
X-Gm-Features: AaiRm50xOyvXOJsCh56H2pu6QdjKsZXjTMj9fjyAIubfIuDakTI72ijkBhAiuRI
Message-ID: <CALE2CrTWMcMOPoWH8HEN_Z8_H1tdhdN2a6hN9BkJ4xs=0DN3Xw@mail.gmail.com>
Subject: Re: [GSOC 2026] Proposal Draft: Improving Git Advice Messages
To: Arsh Srivastava <arshsrivastava00@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arsh,

> A rough draft of the proposal is attached below.
>
> I would greatly appreciate any feedback on whether this direction
> would be useful.

It would be better to share the proposal in plain text on the mailing
list instead of attaching a PDF.
That makes it easier for reviewers to read inline and give feedback
directly on specific parts.

Best,
Pushkar
