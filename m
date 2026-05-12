Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009013AFB01
	for <git@vger.kernel.org>; Tue, 12 May 2026 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595624; cv=pass; b=JXBb1C6+khBJAcrImHf9KtlWlZhCHxjAc1mWU3sh9ucARqh7PxV38yv+EyPbsjTIZzjAn3WMd+nXVth/WlmOsa61vheO5msPqW3wgkz8+zI6Ab+H7uYOfCTuUdOVUjM0+7aCxvH/X4PrtXOXQlOSWlgeacmARER7uRUOv7nLO3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595624; c=relaxed/simple;
	bh=hfMjTisdqkQDSOYPoay6HsOqF5xBed4rc4Ft/lStRP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3VMsf/gNE5JQjGsOrIf2VbWn8g9sO+ctjtj7pvvm/uV1vcigtQX/Acb81NkPvJ2clxfeRRJF+Hxqch/Wj7Uguz7w5yWvQlDbSP0uIoiCWExmW2R3Qjpig5twCR2G3NsB+V66Zv+VppJa+E4w5JeBTV8QvhzUgg+ghqUjmsRs2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfLVVkG+; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfLVVkG+"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7b4ee3a88e1so56843127b3.1
        for <git@vger.kernel.org>; Tue, 12 May 2026 07:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778595622; cv=none;
        d=google.com; s=arc-20240605;
        b=k2ernA4ET9MbDZPmPEpB8+dsS3uTJQP2uJLnITbfbH6iEYvj1/cH9IoVvL6UcrJUDw
         iwXfWcUPywo/pwdBKkhWBF/+Cp+PWR/S9m1qsAh59GwA16ViCF7COY0fIJdetwlMOSiH
         ZQQ5PORUCU4WtLf1yFlzsKbxyoHq6UnzeQDbidqnJCdjW77SX5h55RJTPqyonaR4W4lJ
         KcwZ3rbNGA/mcdCRpWwOM4RpwLl8H5FDMQZKZdRWI1aap1nDZIc2U/1EdwJMpjoLgiS4
         SQ84JIwzmGWkJgH3CUbmZ5+97/YtFVzbo1W+8Rn77g8kUahiUnBL4uYV/Ndy2EJgq3HJ
         PDVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hfMjTisdqkQDSOYPoay6HsOqF5xBed4rc4Ft/lStRP8=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=TnmsLJieFM8UHL0RPOkXZSO0wv+Bm1eU4oZ+wozII/xInf8fpp9U+mfj0HMzfdymM7
         fuxQalzsDen9FFy3FWRJlx9imx8TT/Y126a7UW2nJqaJsxN/XYjSuCYF/gSYEaSRDdcL
         c8QnYVCvP4fe7R4ss0dyis9NZiY8TQ73z8662Wtm8Ew1cypo/fuRJMSFRVP4TpfU4qAk
         8caf9OYsJZz/m0zwCSO3n+t3JULHGuQyyN6abGxQvHDDvpCZdj8p8EQVpUZrnwZ94XJw
         jWutEyqgm9y1VIMpLTqnddXdcfRtha9PuYfrOrICXEvlyEjUFfzNRwLq/3io8YsrXBfi
         aNhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778595622; x=1779200422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hfMjTisdqkQDSOYPoay6HsOqF5xBed4rc4Ft/lStRP8=;
        b=AfLVVkG+Ql/+WFcSE//aURG0zcU5qbPL0GRDuJ6srHx+OuCCPI3MTQFzUmacW/Us/Z
         BvEFlclXpgQMLO/hVSemRYRqRf1jEDlBQOqYnwPRCag5qQMQAj9v2qB7XH/yLBB2iv01
         SDUX6UNLRhA3DIWV1JTcWsRIDzqePYUWjt/Sb7/PMd79cLFEskc+6A662nW+7BRi22nz
         Fg/DFVvy4Ma/NxwYgRTOHce7E3eJCVhzcCAgb/6Odj2SQrefshCc73mUvAF6x+SFkvnt
         fKDQEgHqYu98c7Wry18Sk7k3Bo8t0LJGqQteOPeToovsvFVjOdkCIQE0resfjzKuh6HL
         AH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778595622; x=1779200422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfMjTisdqkQDSOYPoay6HsOqF5xBed4rc4Ft/lStRP8=;
        b=UFo97VXE5lRRsenRiWUY2A6OEdkOc7w27fQQC27KGbTuFphKKnnd8oRhJVkQMB6B/X
         hLKhvIJ2FrxzPfeUlTDkwsjGZrx3iBtGABegAhGr1OaqUkF/+P0LtS/q+beDxXKQBfoF
         REhpSKY0UT8lL3ilEOaVta1DIP3VJcslid1bxMksr+Muc6iNsIbdUHhO5myklzyDulXd
         iMXmU4B7SSM8JzAQfLAaZrNltQP5Ji2HwHy6IC6r3CjQBw7IgGiSOPjB+xC4q7eFNrl/
         +9+9l0RNC3WvAPS/bvpuU9bGvDOCdaFXoXJV12gaWYbxhfT3vCzeF9LPcHUH9w+zoxny
         kT9w==
X-Gm-Message-State: AOJu0YxFxHJBNVIT3bMKI/tpk/eh+9nKubZzud9sQ7vQwXvx2b35UA/+
	bNy2B8m9rNILQtbNYnuQjoK+hCcVv26yAEiw34v2m+UmhBNRhBNsjq6TYeUCH3ZvfItTWFzE8ov
	M4MW0QpwvaTHxyLzBBNcH/iiP5MHG4Rg=
X-Gm-Gg: Acq92OEPMVBAudHjppbWB8Llp1HfJTEZSgy+4g7hCssyKE0z1yQPjsJvDpRm08b+bLZ
	1sBJBcVqtTCV6JW/Z3VJkcxU4kKLzgPr+/57elbLA7DcO244Pby4YepAU4gyL/2LoABIx2dK19w
	0r5H2U8oFWKod3Xy4JdLXrfyXxL0j4X189jTPZ5rnOemVQngGkz3neLV7n91C9M+4ZDqhHtp8I2
	Zboe5ljiMkyIrRBJ4WJ5tft0WHUEYT3Mr/EGSLlCSQ9Kc10HV+lDHze9wsBjGoAvWZ/HQCydMvX
	BfRlFFw=
X-Received: by 2002:a05:690c:c6c3:b0:7b3:f33:35e5 with SMTP id
 00721157ae682-7bdf5e07727mr250083587b3.16.1778595622022; Tue, 12 May 2026
 07:20:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqik8tm16n.fsf@gitster.g>
In-Reply-To: <xmqqik8tm16n.fsf@gitster.g>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Tue, 12 May 2026 19:50:10 +0530
X-Gm-Features: AVHnY4ImZsqT1i2EfB9bZbZtu77eNFLpr2OOpfViGemgoVyYvNNK2AUbeBvf9tA
Message-ID: <CALE2CrT9=5mOauUdzxJAEjeeD77RWGyXjLGGTObsk9R1eOrP0g@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2026, #03)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Junio,

I noticed my stash test patch did not appear in the list, so I just
wanted to gently follow up in case it got missed.

Patch Link: https://lore.kernel.org/git/20260505103332.43702-2-pushkarkumarsingh1970@gmail.com/T/#u

Thanks,
Pushkar
