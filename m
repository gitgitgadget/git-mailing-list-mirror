Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B133F1A29A
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 06:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753165635; cv=none; b=WzKAzw9HPbV/g/m8q85YTgLX2kU3U+RUt9ngZETanHXsXLn988Zla34ln+X7T3wAE/E9/v31PlDiNMaC4EUqXFcQEQF6vg64w0RjIvimFBtvWLaVJx8SPWgbmaIN+2czEd+fdevJ+Dj1JGIdgcYYkLDhYp2rzEYSaT0J/0cFQzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753165635; c=relaxed/simple;
	bh=n7nwGsNoeck08SaJ/F+L9x6oXNIq3fYH12ddkWgVKUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rw6jKWe2n4JXBEK0IeRT/6z3eP9u0bmLBBT9SQ2bG7+yh8CeSMImcsmR53LW3fJTc56b4n75GJbkUnzUUmC0iCWCqT7IYaPlfUXTYj8n1EdPH7k24e+hTZlYtvg90K1lX98QqviyMDncyKapanGzdTyQZUNWGdiHgxzuYOuwbkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKXUPPCr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKXUPPCr"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so41056685e9.0
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 23:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753165632; x=1753770432; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vHbtYInHGpM/wq4nTDOOBetdnMbOsYnMX/xejstxlRU=;
        b=QKXUPPCrDkTLI3s7PF/VzludYYfkXUG7oJunS0cTGYz2xifSpEvanzxUkkboj3GfRF
         k1ZCmPmQEpOTA5DEinrBdLmjoeiSLmRDv4NAAEU/Uwoke5N27ArsttmF3YsZKThKf2xO
         cZE5AbWtEA9F+tEZhXfbkZDnuRYJu+8sXB+yyU9L7aXFnvrarspUdpI+g81AHrc7z05v
         zVbSRQZjReGFZE99V58x3cuze6rzT2joCVZ/4uRqkbFhPwsLTyW6PXxPZUjmEiGNMpTK
         IJCVS3xZ3lbKzVG/67nqbHRWhpyoJMyoKP1HZ/Oc+IFgBraXEHso2sOqNWQDo2GAxx4S
         iLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753165632; x=1753770432;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHbtYInHGpM/wq4nTDOOBetdnMbOsYnMX/xejstxlRU=;
        b=H8pEOBjjOEmVlIZKcRNnI36ZPTeXX4gmKoySUe5sHZG4YqqFS2ufBjMn/bpT4wd72D
         0qCfQGyUi1MfobX+Z9kh315QuQUgpnaRgxAf+afbPb91cG66rgGU/t4kUdFvI1FwCO5H
         LqMSYCy7wN6UYnMlvXTWN1uu/Xkv4jxeRwfBVQUlG6VFmqr3W7AqZy5zwKfVSYRXLwCo
         rX11jqQ3gQIXSrhWgTxLF22WLnRJS7gPn3XJiOck+EMQgwqpExPnnVlliIrMvz9IMA/C
         qnxUdhdd3PvLb2UgiE2+pHx17Th5+zTISmaR+wECrSZzlFlcy72iBeJtbDxCGKuOOGEK
         8p4g==
X-Gm-Message-State: AOJu0YyOde9h0PFfzbUay55Jw/JA+jlvprT6WB+TawJCeZ6G0Ci+3rU7
	qbxraaOfuHLMsP4zxarUWe/ek91A76oWASsDMOe58mXWSiClquqTyUa9Kwrjig==
X-Gm-Gg: ASbGncvtQ0dJwsiGBNCGaZCf4zvZteZW+d4nCikDOcEr55NM3LvVze8fzVdr3rzCCuc
	ScC7MLz99glMSB2VYTbOzrAWTj34I07MgpRyyT3e9ScSbHyppvx4VPtzKtbB9xcXoXc5Gp5UnsL
	g5ynJeMcB6ZLKee8KOcXQO1uROSblr9g5yh0pNjuDoepxN3dBxNQO3ikbSAxbQ1ugkYI3SUDU5I
	y/4TfUunfBRSqoGqppWq2SDPqqZLgord7z6rLO/Lli3AmhkOSMHYyivYdJvU8wj/z8bYKTT3ulj
	E9neapKzbMv1ZMBDwRHui98EI5FFQt54hW0nE0x79MSZV8Q9NKhjgdJzkD6vxJDXtRr/6wxoSVx
	Lmna7aJvVfc9T/0aAO0U2AvFbT29GH/q20xTU60FgxWHnyK+JS1d1/ZI=
X-Google-Smtp-Source: AGHT+IGbQNOOumM+D5b4QBVXord0GMN2+IqVZQDJ0yjq/3t1BNMXZlxAYsOg+6yCC0zaukjUHDNBMQ==
X-Received: by 2002:a05:600c:4e86:b0:455:f7b8:235c with SMTP id 5b1f17b1804b1-45862743cb7mr20425775e9.14.1753165631666;
        Mon, 21 Jul 2025 23:27:11 -0700 (PDT)
Received: from localhost (92-249-246-243.pool.digikabel.hu. [92.249.246.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e802afasm179640045e9.12.2025.07.21.23.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 23:27:11 -0700 (PDT)
Date: Tue, 22 Jul 2025 08:26:49 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Jeff King <peff@peff.net>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 0/3] commit: convert pop_most_recent_commit() to
 prio_queue
Message-ID: <aH8vKQa7z313w1RG@szeder.dev>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <8ff40c56-368a-4347-aeae-2aca2cb6a5b2@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ff40c56-368a-4347-aeae-2aca2cb6a5b2@web.de>

On Fri, Jul 18, 2025 at 11:09:04AM +0200, René Scharfe wrote:
> Use prio_queue to improve worst-case performance at the cost of slightly
> worse best-case performance.  Then add and use prio_queue_replace() to
> recover that loss.
> 
> Changes since v2:
> - Mention that a prio_queue improves performance for merge-heavy
>   histories in the commit message.
> - Add the new perf script to Meson build file.
> - Mention which kind of history we are aiming for and show its shape in
>   a comment in the perf script.
> - Remove unnecessary quotes and use single quotes for the perf test
>   code.
> - Rename the variable delete_pending to get_pending to align it with
>   the concrete function prio_queue_get() instead of referring to the
>   abstract concept of deletion, to improve readability.
> 
>   commit: convert pop_most_recent_commit() to prio_queue
>   prio-queue: add prio_queue_replace()
>   commit: use prio_queue_replace() in pop_most_recent_commit()

The patches in this series were picked up in the wrong order:

  $ git log --topo-order --reverse --oneline -3 e436bc94f3
  36554bf51a commit: convert pop_most_recent_commit() to prio_queue
  304f06e0c0 commit: use prio_queue_replace() in pop_most_recent_commit(),MIME-Version: 1.0
  e436bc94f3 prio-queue: add prio_queue_replace()

Note that the order of the second and third patches is reversed.

Since the second patch/third commit introduces a new function used by
the third patch/second commit, this leads to build failure of
304f06e0c0:

      CC commit.o
  commit.c: In function ‘pop_most_recent_commit’:
  commit.c:754:33: error: implicit declaration of function ‘prio_queue_replace’; did you mean ‘prio_queue_reverse’? [-Werror=implicit-function-declaration]
    754 |                                 prio_queue_replace(queue, commit);
        |                                 ^~~~~~~~~~~~~~~~~~
        |                                 prio_queue_reverse
  cc1: all warnings being treated as errors
  make: *** [Makefile:2821: commit.o] Error 1

(And there's that MIME-Version thing at the end of 304f06e0c0's subject
line as well.)

