Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792572386;
	b=JEJycQIiVM+nqiAXS513+ykkG+QxOAHmQltJYTU38R/A3OcoPARtexIgfm4YoIb+6Fn3
	 FuUIk6HggnNjNIppTyvOGjOcFW8V5TauqOIONdXsvAkfxoGsVEPwuhCmBsskd6uC06LYo
	 OpW4bJaHHuHorwvrP/uFjS/gMlqPWKOcUd4Yxs7sszWC9GT5UGssf0galZnq4V5eBvw9Q
	 053wJJzRVOHBVvge10XSt8uVimFAxotQ9obu6rbR3gWgSSN9ybY2IjA1Wkr3j9FZTk0+C
	 G9bPLXTuV1YbUxtyX05FkWr32AWnK5/M9EA7cUzIsRFkBw4N+QYFbSRXKwAOGVEY12Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572386;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=IpLHiXiUayKiWN+K4hDnJWvg4XNGRVN7QX+xHxo6WCw=;
	b=KqyBKmFd8OyVNzp2YYOPXqDP4MMyweLxfYjVf+BAI2hKYHoE4oyfymGNMDRzg92Mr6RQ
	 BAwH4XPXQxvsdBCU2lFqQ5LHwh4j8P9vfJhzJDPh1CI8PfY38mdfjGwbNUTWFHo8Vk0r/
	 9GAYByAL5m+aHAaAdYXOT0w0Lgh8JwwWaxxFKH24ir15ZShkAv6OJLfj+ANzb0n8RBV8i
	 yYoHOKtI4xOvAAONUeFEOsEk24yE25dxXkaEouWa0DkeXqVe6H7OVmOuppUuBfr7EU6CI
	 P6ONa4cG/8+tkSsy+VaGAD7UbXEovVgKzrftXXDQuZglJZooZzYUOz5dxQhlER2ULTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="f5Y4aX/5";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D8A606A332
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 08:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92D8A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f5Y4aX/5
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso556244a12.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 01:46:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792572379; cv=none;
        d=google.com; s=arc-20260327;
        b=kQaK2jzN8ADmXbkWPeglADNpIpaQt+SkZDsRCOLBAqXRrZSuN2ngCGf36RwmJl6vvD
         sRHu4YReun4syWMRdyMcaFFZuaYqk3Q51hCiJUQVATZk1pF0UyTjBcXXfbY4RBH71zX6
         Q5PK87TRkErcpbr/GEgOyXRpAebFAev/NizGCVZHKs8EQ4p1A7WKLtSyLZLI2m2DD3io
         HP4q7reZWZFQ7szo7rIQzjrMup/+FYpjZUwyXgqQ5zi08qAXq6fLqA8+bLVmPFTXiFlv
         XjL3v4hRvXnb93EiZDKBg6CPzADys4KYanh5ovw8+XQTSUBxoWsZ7XHmDs3L5oD8Z8cn
         rDHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IpLHiXiUayKiWN+K4hDnJWvg4XNGRVN7QX+xHxo6WCw=;
        fh=cA2VMuTne44f9pCxhyI7IQlEzMA8Jol0iMCiZCnLM48=;
        b=hYCl6WeXLrj2c7jGzMhyF64qNm5rFJdJYWRgMAHQhoy2SRz5euUwD1ZZsbDojoijgG
         zLkM9TeRan0OgjRRhj+/vEBE7hvWD1yJUClxMe8G8oj+yanmzldcUpf8zagAb8RsYtyw
         IMKkgDCns16X/XQ7TQagzCoDFSc/Z2BCi3EzGyJLRCZ7kiPiNpOhuwfHJnu79s7oZHwf
         v6i7xPWJP8UJ6dMJ8q+66eYdOCruaje6KFtfoRVj4qUhXIg3rfCWqw4qzq85Hn2Al5DH
         nA508iOfIXkBwif/vbCNSmp2TxezeaA0ECzf/4PhAE5M5lTb8s545vRNWgEt0aZNLa+6
         IMUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792572379; x=1793177179; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IpLHiXiUayKiWN+K4hDnJWvg4XNGRVN7QX+xHxo6WCw=;
        b=f5Y4aX/5w24rWvrVcYWA5zG1c9u51u13QxHbBxfgG9M3h2yEI8EGY8JxPx085ynZOn
         L/Tjo434C/teUeLPRWQBVOK3htQUptY9+pWsym9w5QVvhdRAEEcQU0U2KS5SErLrbcBL
         2jp89C3IBv05Ai+81fLwQC9mS4iyyEVSbUxPcuUGx1sZTxJLtdQe+p7LLWOU2ZJvjIUA
         fQL8OhTKcPvaMXvs+bxu3sHjGNSikhAknCrngOHXVWHIgUC1H/afLTWMJQzzKpXNaoVD
         Vod68PtgztDT4QWcbXvZ6elsvmXAZAyamW9wBmcjHeY6q3+zXFlpT+giscRJLYEas5AP
         L/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792572379; x=1793177179;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IpLHiXiUayKiWN+K4hDnJWvg4XNGRVN7QX+xHxo6WCw=;
        b=quP/XJoP0i9K+pLRhz36LS8EVjdaiBQ0/18kacbnFuVmcxP3SCOaE6kv/KDeHkvm0B
         481yYaGLvPSC+gxbndfwm/CHE4PQ93nUbXgu8CP6xoWJJq8mS042Dk2wV3h4KqI7EoXv
         tP8sg+ZgkHkeI5vFP40/rtMxtvVQwhN9hEzK46//JUrPNWo6nvRJyLFfiMY9Gsmi6xjO
         /hBHTAYXiWY7sVz/rPurApxv8XkYWzWBJYEeAk+w9jfzmSg59qD+/lnJf9gdcLkFUPQQ
         OerOWistWg/aaGT5f2nmB4DhOZk1gyXcSkTf/abhG6Ap3yNHQfTBC7Yha5Ac6SGKi92K
         lCHA==
X-Forwarded-Encrypted: i=1; AKwUvByyUyiz3U8drbkyFA5aeahBk6bDu5YjU0WG415H1TZoA3xxxFlMDGTaInw5bmlL2NdYklE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrBtZ1Eco0hQBtRq+J2C33ebYQTmNoqV3qPdObsDQWkQI+SOcw
	pbUQapak5u20nwPivY9Tlvq5LJH9moDK/UI5uBhQuRt5fg9g2vAg1J/iqOX9FqG2nAeNF2BbfYK
	bTBIxy29W3ZzBhvDmKoWqFk/40tHuH64=
X-Gm-Gg: AYBFou1H1QjGsUekvTc/v3MuuWNCeCPUtqv0r9IF03t+xwZ8AH1Yp4Hnz8dq9dae3fQ
	uv4IERiDU1bHnG03GFsImWOGHDCmM+gxHjJDqZJUUOgrOWHpIs5EmcQFTRDvM/p6i4laFCHETyi
	JR+dqRdmhhZijfOcYiotXOvOIx70uEMVAe0s4dOFW/3HP6LTSZUkjdkm1qAnYCjIUGa7jlsWc1t
	8trITjD5P3jXIN2LfyyGpDLJqQhjil8RPDP4fmBlyZUeE0XgwYqsJtC1KQfzYLu1s9Z3PFkpBos
	esyIUOc9JL1aTu3nuqlZjSyvH0uI+XUFQZMgszUZLu2SirBYgzk0cRDc6z+8v4yS32XUJKzC8x+
	RBqOy4AmKW8gh00PGeHVzd0vML6YO2DOoKkIN
X-Received: by 2002:a05:6402:2809:b0:6b3:f11a:3cfa with SMTP id
 4fb4d7f45d1cf-6b408eb1344mr881379a12.22.1792572378819; Wed, 21 Oct 2026
 01:46:18 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
 <pull.2456.v2.git.git.1792566469.gitgitgadget@gmail.com> <c42827a1225e49db2e0855638e4e76a06f7d9eba.1792566469.git.gitgitgadget@gmail.com>
 <ath23vYy0n8UFLUB@pks.im>
In-Reply-To: <ath23vYy0n8UFLUB@pks.im>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 21 Oct 2026 10:45:42 +0200
X-Gm-Features: AclHuK-8rPtkYWsnOBBkIATmukBBJLVUovj24vyYBZGBCAC7Tyq6ZPnboBmJoGk
Message-ID: <CAHwyqnUwbq3XkLajsurk=X_=s3a8Z85Ai2raVmpsxK8HavfwZw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] imap-send: accept messages with Subject before Date
To: Patrick Steinhardt <ps@pks.im>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Patches sent with git send-email cannot be fed back into git imap-send
> > after fetching them from the mailing list archive, for example with
> >
> >     b4 mbox --single-message -o - <url> | git imap-send
> >
> > which fails with "no messages found to send". imap-send only counts a
> > message when its From, Date and Subject headers come in that order,
> > and git send-email writes Subject before Date.
> >
> > Accept the three headers in any order within the header block of each
> > message, and match their names case insensitively as RFC 5322
> > specifies. The copy that git send-email --imap-sent-folder pipes to
> > imap-send then passes the same check, so the special case added for it
> > in 04133f5bc4 (send-email: add ability to send a copy of sent emails to
> > an IMAP folder, 2025-08-12) is no longer needed.
>
> Aren't you fixing two different issues at once? I'd argue that this
> should be done in separate commits.

Good point.

> > @@ -2863,4 +2863,39 @@ test_expect_success $PREREQ '--compose handles to headers' '
> >       test_cmp expect msgtxt2.to
> >  '
> >
> > +test_expect_success $PREREQ 'imap-send accepts a sent patch from the list archive' '
>
> Quite weird that every single test carries this prerequisite. Makes me
> wonder why we don't just skip all tests at once.

What do you mean here, do you want to remove the tests?



Harald
