Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF6F3BB684
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 19:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789326237; cv=pass; b=QXGgYl1A9eZpSvlsyQIAiCXdGxl3pyWzAWQJ1/yQwhyWz0zYVizuSVd8+j3FjZ+m3T2Qd0qUxtO3VJVj/MH6vSkkcd0sHCta4eyFp5pmf0LmfIg6jmzWW5KOfoiAeZgognGmd0AhdXDbQj5BnTCVcNBZTWTCsUQlPfYr/ikEekc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789326237; c=relaxed/simple;
	bh=CoVijANXUotwaVPcg4YK+Pb/Vd8/Z6DK6QE+UGaMbbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNkmYHYzuSIoQ2XjegeyqPsPsNLxoGjun0kNGmyiR8vsvi4pojcv1dAhd9GjLMfKzLx4rqZ/ZT8xv0Ys893ASGIAevsngQEabcaGp/TBMXoT05YmHhxm9qdwFBB9Q9SzC3OL196XGiCVdUKjUcOx7jF4VgiSwlOAF/iPw98wpEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIIuDHSx; arc=pass smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIIuDHSx"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e5168ceso573288e0c.3
        for <git@vger.kernel.org>; Sun, 13 Sep 2026 12:03:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789326235; cv=none;
        d=google.com; s=arc-20260327;
        b=Y4NdZGHRblL0c8l0Sd08WPCv9isQ8Ic9u0zOfSccOksD42TXg0sRJKQ7a+VVz6MQRU
         v4ViAQ73NVwtp7CmQY8QdcMmhPid9DjWSeDSTo5Uv97KLwiaz4NRb5LfI3PXTbLGVqr2
         cAFfPIvpX/XJwLDgzDss4jITk0ssTavMgpcor/ned1SFJWlEkwgAJBSeSXXwz6VAT1Jt
         /wTO4TLkPmTU0qQskSE0i+9q2Qo6juEA94Gn8Le14gVLkSeQyMo6lWpw92jV2z79zNRo
         JHztW+gOLNu1ji35nAVTMvsc0dTdXowIg982RFIh1Yod4UYH21TCVC/JXixh0GRzBds/
         XzrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qr4/RVjScoNiny/Ns/Ff0LzSZ7SEx+mqC7jPaqNaxKs=;
        fh=o7Hx0BQvaDDmOGnZf2AZVvrkCx5mM6B0WPo6xKPtSyo=;
        b=YOb8t+sHJ5IcGud2AUvr17kXWo1ZN6DBKWZlGfgoVCLFdOcIG4JXVDYd4tl7mLGuGb
         YrUMFlvasIlwZcXPsfC6Qmq+W4e/xc0Vj4H17L/H33qLtjcpAkDae7BQ+hZBYwJ3yu5C
         5YqDz93L718Ay34D7MY5fwNdLNw71GbQEmek5poooUFnCqExqMWREiNvWRRuvebJ5qhu
         yfj8BWuCtDl3zwZvKktWeIEBMl30vn4QTNJIzygDVEljsUgPAWKfxMFEo2KxwphtldlU
         UxPKqLO4M0SuSaoE8uWRq0LDBmPRLm0W5L9OluxX0BDT9mwSyV2vIJ0K6ra4BcDykq7x
         nX1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789326235; x=1789931035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qr4/RVjScoNiny/Ns/Ff0LzSZ7SEx+mqC7jPaqNaxKs=;
        b=DIIuDHSxrftnLt2o8A+O80CiuTXNzyF6Pg8CelPA61mA9EIzmRUev1tufUONdLfxJt
         7paNL+z3fWzkgNMEUluSM5IY3mLsLRjP9811JafiHedjX+QOLKnAAm4Ou0Zt5CC2C2g6
         oHypblR2PMGol8V1TtizbuSLz/zdeQxvq8fLt5qMxZ4hRgdY1FFOV52vcHKEuywZd/Kc
         TLy9o2Pich7uu1xMDlf3LzFOboCSKFozYId3EnQqwI8uAZDKxvm1NkQi39855BSDaEaG
         hgl8OdBztMMGSDhl9v0ajllYeu5Hqsj+SUpft1uz0zfEPNRXYCHIYu1V2AfxvLdefmtU
         RIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789326235; x=1789931035;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qr4/RVjScoNiny/Ns/Ff0LzSZ7SEx+mqC7jPaqNaxKs=;
        b=BaarvqMBk2Icck19fQEaRiSUNjUxzM+41zaRitGWIR+KBpxzxWVF0O+dyPhORwdlbY
         s+uGsxl2lAdi4bKouFlsbhRF3acuG6LMoR1zK1txymNyVYyMl+6ui9dzLzmfLthtxjgE
         PM0jq/AlMnDEg8ePUtzPPYsAtMyoUEFG7i7mMk/tQdGOxuBlvPrqtpNErNixX+BddFRu
         4wC6zNaoO0PScU32sMwfxUWRLNc3I8s+r5wV3pOeaUKUX0NRk/HubC6v0LVzMtdFnnmt
         +uil/o6qG4XhfMdKmGjShqCQhQDUKf45sfGN5hQUXlwCS1eM7a421mCLk5lYOKblHgjv
         e20w==
X-Forwarded-Encrypted: i=1; AKwUvBwOzIBNHRXWzVXF9J0Dwcnlr7xVdn31WZ+G+1f1MBowY0z/2JKB5yW3sX/1fwxeoT/ajWo=@vger.kernel.org
X-Gm-Message-State: AFuF++lfLCtYCy+0tjKIuDf/yOlptu1b82WMZ61py6fokHeXPpLH9fdr
	V6uoP/xu/gS74JX5xj59ppe8qAKwPyEXv+8jeP2e8KH9MVXy/jNiZI0iq7IfzWMCzz+eOqelHPA
	hMZShA0WabSHKZwdJmzRPDhG5WRLLuaY=
X-Gm-Gg: AYBFou0e502JHjJM19hDfDK7SlS3m7UL45L/SYpGPNk3xnYY6SbCba+laWIEGngu9pY
	X+lWfcRBZDCZmEHPnp4YwKvWJZ1KjQ5MRQjZEU3IjluPUSNQRqY+7EoBDvlrbyQKqstDW7L2cRQ
	eev+2VL9ZvfOpPW8q1D5AXfSn6I/SXq19py8uydngYWT1loXTAaLvKLzec6JZzvjtJrlxv1XTSm
	j6N6dljcBUdh4eO00k6x+wf8z3EMmKExYwvhnEsgva9/LMbhupmVMa8pQUhOslNMQZaUUOyzTV6
	cik3fW4gRcQHcmeIv4s9y9pd4duoc312HLoqP8/q6dp1OeTvOlKLDCq0X4bA2WfqRAoD5HVgJSd
	aIz0m32pdQOA=
X-Received: by 2002:a05:6122:4b10:b0:5c3:61c2:9ec6 with SMTP id
 71dfb90a1353d-5c8462f44ccmr17162431e0c.7.1789326234787; Sun, 13 Sep 2026
 12:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2200.git.git.1771187016.gitgitgadget@gmail.com>
 <b444fa7af9f39960652209143c9845a47efd58e1.1771187016.git.gitgitgadget@gmail.com>
 <xmqq1phdavik.fsf@gitster.g> <CAGHpTBJKaTURMJmJ6W4iiCAy3-M2YWb48rF8GMoEPCfpGcE=QA@mail.gmail.com>
In-Reply-To: <CAGHpTBJKaTURMJmJ6W4iiCAy3-M2YWb48rF8GMoEPCfpGcE=QA@mail.gmail.com>
From: Orgad Shaneh <orgads@gmail.com>
Date: Sun, 13 Sep 2026 22:03:43 +0300
X-Gm-Features: AcwNN1WpOO2BZWxX45S69ptHZiExqyeR7GxoZoRPssq-HVpZYthjEPPq30aETFk
Message-ID: <CAGHpTBLvZGAaqkue47Ne9DHPSwxx4fPo5KusP5=sh3C2AxgAMA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fetch: clobber existing tags with --prune-tags
To: Junio C Hamano <gitster@pobox.com>
Cc: Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Orgad Shaneh <orgad.shaneh@audiocodes.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 9:57=E2=80=AFAM Orgad Shaneh <orgads@gmail.com> wro=
te:
>
> On Sat, Mar 21, 2026 at 8:27=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> >
> > None of the steps we see in the added test do not seem to check that
> > --prune-tags does clobber existing tag that no longer exists on the
> > other side.  It only checks the "git fetch" command exits with
> > status 0, but does not see if the tag actually went away after the
> > operation is done.
>
> In these tests, the tag is being replaced rather than deleted. Existing
> tests for the pruning mechanism itself are located in t/t5510-fetch.sh.
>
> Would you like me to add a check for the tag content itself to verify
> the update? I suppose I should do the same for the existing test cases
> in that block as well.

Junio?

- Orgad
