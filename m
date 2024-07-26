Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507CA200C7
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721975468; cv=none; b=EsjC123fS34GnTra0g02R8a60FswcKZg+5sEu9WCaJVxmd+UuBcvEo9JdSbu8k8kN6pA2RnEb04/Ptjc12jTmBZBO1psDHiGkwN4Wz1m7wdtX7rvf/MYA1yMjeBg31+LLqQHbkBZGvOURgjANpIJtrI3Gmn0FQTpQHDqYVT+6t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721975468; c=relaxed/simple;
	bh=kjBMiRQnW4ou+Du99s9RbckrXGmDh4YzZGLbq7MOEyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdyrWdkSnDRUGUy6h6ETMRNqq6DMO8Mgc9Njm6Dc0pGzw22qI82plKCl0tU3/cFL53XteMO5TI1Qnc2VRe7lOHNEkGDM4UWOpi12WbY8pUC2F2gQndcE2ztKUsczd4wnJ3MxGxIo+LBXQ4YYVDWdynZ83qWdI1au28/5lfwONfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5d5c7f24382so133659eaf.2
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 23:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721975465; x=1722580265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHPqw45+2cIU+KmoYzt5AgPYOXLHlt/6PLjagAzr9uM=;
        b=dMO54kQrGCG4J9KXFRJ6CDGElMgSPolb5tZrhcrbe7C3ZbjBRUkvgNiAclxREIxiYW
         qRWnam/PLceOoYG5y6h/XxmeEqjv6OFvkeZW5wS/x5xBBBEBkHkSki9+QvrxoBY+ggvH
         L7C426nPlm1QnQ41CDl/E3jQv7UlnLkSY9uHFO2/Xspmv8ZluLHSHZ9mLysJ6KKUb/rn
         HLUMRSPMJw1vE0BMLTPoP84ZzS/kmy5UcfUoULw+qVAdK5YeWde/gPK/VzS5xgvWnNyf
         IZXvof5dHIFFVj6sscRfqE1o+LlLFoVAVe3inwLNk2kXoMi2bArslFOmed6zvpPd2Om7
         6mcw==
X-Forwarded-Encrypted: i=1; AJvYcCVsrszVPYqt4qntknaQpDsWTDtPsQ4BuCcQGeVU0xzvQ12MRJPLQBe9i5nSdhqvEWOJsKmSd7gcOY+Uxg8XMZgoj1zS
X-Gm-Message-State: AOJu0Yz5udlGDpfiBO7TZp05qwSxSFlN8/01pSIT7G4FZ2XdcARZ9b2Q
	jsRO7XFmeUGU5Y4k4EOP53Zik8aDV2AMeS5RTx9ff0viV2yegwX8oQ9kxXqS2KWnn8pLMH7rEhE
	6AN15iKHuH5jXTzfMEFA7LKdCtCY=
X-Google-Smtp-Source: AGHT+IGi2pHTisPjLsNIs2J5qNV3L+QL0VvtTkvbFn+q27XjKLUSy1/b4BPTHQ+XJ9lzDL/ozK8Sd73IH6pHH3V28N4=
X-Received: by 2002:a05:6358:b313:b0:1ac:fed2:c3eb with SMTP id
 e5c5f4694b2df-1acfed2dab1mr395717355d.2.1721975465184; Thu, 25 Jul 2024
 23:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722065915.80760-1-ericsunshine@charter.net>
 <20240722065915.80760-2-ericsunshine@charter.net> <xmqqv80xb7z1.fsf@gitster.g>
In-Reply-To: <xmqqv80xb7z1.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 26 Jul 2024 02:30:54 -0400
Message-ID: <CAPig+cSYDM-B4wLWX2euAEVH2FutOeFy4sTRJnWk_Qm7Y7so3g@mail.gmail.com>
Subject: Re: [PATCH 1/4] t3430: modernize one-shot "VAR=val shell-func" invocation
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	=?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 2:24=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <ericsunshine@charter.net> writes:
> > A common way to work around the problem is to wrap a subshell around th=
e
> > variable assignments and function call, thus ensuring that the
> > assignments are short-lived. However, these days, a more ergonomic
> > approach is to employ test_env() which is tailor-made for this specific
> > use-case.
>
> OK.  I am not sure if that is "ergonomic", though.  An explict
> subshell has a good documentation value that even though we call
> test_commit there, we do not care about the committer timestamps
> subsequent commits would record, and we do not mind losing the
> effect of test_tick from this invocation of test_commit.  Hiding
> all of that behind test_env loses the documentation value.
>
> We could resurrect it by explicitly passing "--no-tick" to
> test_commit, though ;-).

Your mention of `test_commit` reminded me that, these days, it accepts
an --author switch which seems tailor-made for what this chunk of code
in this test is actually checking: namely, that the root commit of the
orphan branch has "Parsnip <root@example.com>" as its author. So an
even simpler approach is to change it to:

    test_commit --author "Parsnip <root@example.com>" second-root &&

That conveys precisely that the test is interested in overriding the
author for that one commit.
