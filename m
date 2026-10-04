Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC403165F16
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791119846; cv=pass; b=jGLIhui0Ym264gh8UuAhwdqvZq0I2KPlKk+KQLfKOazNMB1rMUgA1QNJHfeuZhHYl3qo/MdCrjw3mMlplq3mhytlsr7V1Hj6N1WHHVK71OlgLl/04JUhzTVj3J2O+ExHOFzB4QqlVklYyI/qycJMWib7OIj6cBlTtye1zhqFagE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791119846; c=relaxed/simple;
	bh=l2ox6XzOVx+TMvII68I8xUX5indbMrQtY08j04MTj6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQfQqECeNcHzirtohWm1J4qjLyFzL7jAOyH9LIYfU9RT95/Z/zr4QDDd3mlGxVgqGsu+jm1Fe/Ta4JE957VgrjuWtjOCZppVy++npBP3iNYC/TMF53BPMLLYA+zBH+xmQHDgI9Z2gEPBzvAFflSUIDxvEZ8NDmbGPTrWANSk/es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Op/8YECZ; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op/8YECZ"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a601ba6870so1616728a12.0
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 06:17:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791119843; cv=none;
        d=google.com; s=arc-20260327;
        b=USEZhScGr46l7a9iSYS8VHYDu4apT4RtRpUORXaipunWgw8fAkYV5sR6wQtSUcFycw
         JGVFbWo2BACRxg0rfSkvqVjL4GKbeuC6whA76BVMgpbMyD/+MGa99pQ4VygTFEPn/1/o
         y92me/SsBG/V58TFsZf0FYro+eM1yeowcfCwKzf3bk+hpa4i0ZBhUdQ3KxrPK80Uiu/u
         wQBkW9tqfadcW4DJ38RQJS97qNij7rbcdhhGJwKzJVBR3HHGy+gZn3wt9mIoQ53pDPfs
         RvaEjfIYWQtAqh6fyrAHYee9Fv+RhCa3qs/T5Hbyyiku1ws9x88yhOcFzwAkzKM/203O
         9WhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1tKsZ1p/+5180ErjTC2u6xktutPIa+UzFGnDe0YXhwk=;
        fh=YcV2SGovJ0+6YIIweCE/Uc/xG0g6Fbsx/XnhH1+HjKU=;
        b=Jmnfa37x5JFqjVYxm0m09Be4pROXcftFT+9X1gBb6GgdsIhySBKAFiP2fvVFOorhuI
         YoqxBJwRGOIQoOSa24SRjP5UCi4I2b8f/dSzWa50hExs9kyKF69DUs9ZT+FFeGtUgCXA
         GuZafxTO6GUu9seJcTYFFO65MJkPBFCnzQAQFkBu2Cv7HaOuqknMoIYUeF6NgLfQuFjf
         gP3ODrPOgn4kDC8uMnDMdGN9DlL3/exqNbZHRg9W4/Qprzru+zytC7Q50WOejBXCfahG
         06Iy658HHGjv+3umw47Kks3W7vrRGd7kIBaWKx0OA0yaHGTeJ8rAwQa8z1SI6iYpuDcF
         EJbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791119843; x=1791724643; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1tKsZ1p/+5180ErjTC2u6xktutPIa+UzFGnDe0YXhwk=;
        b=Op/8YECZqJJM5Up5Yxkc/GobUhcf7XGXZd7Vp45VhPPpQlqsoaFfi20uRSAk5ZpHKT
         NeLGCPs0S2Kc4WUcyACSXK6bt+Fw36tG+jjbDQdkKkEYF7Paq+2p2YJyOR/Qb2gpRHO5
         2EqoBg+RPZA2iLKcfi9FW9adqBe5oUC+Xmvf3YAnvlVkJJdpk/tIT5/11u3Xo0Acrxep
         2QU9kA+oGpDN717AERjqcpsnY7K1VuWW5aOMKJwt0UVtHr1WzI4dhZzWLoOdHkWCSsKy
         epmU1Hc3D79ARbCpTI6d65x4BNS306o/+UkzekXVLaIm3y8T6RaSxN5T/qL6gH1V49tS
         HKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791119843; x=1791724643;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1tKsZ1p/+5180ErjTC2u6xktutPIa+UzFGnDe0YXhwk=;
        b=C8SlgcKnKCTQytZMhrlK5nMa7N20ZCmk+MoXAP1Xo26GF1Bqv2Ep7K7VlBWx2b7re7
         8Od+yfdw+GXF9lL8+j5Fu3bWmJt09D4SLq/9TU3/0XgdyRN3n5LqCAkfshugqT8FAiEx
         jnAS/8VaZz41HignUhtoRiy/pEi6VpTytp1Tp8gPyDuF0y4mxLxzL1jQbVyUGUO5Ba+W
         Bb1kSMx/BKcPT48ut4P7c3oPjX/RiJYlujHSCmzaaGvm+QHaDLTjBlp3RC/ghzeJMIAD
         WwgkMm2H5fVnbwnr1OluGlMxDFmQ/wWwzeeJ572Sh+dVOpVLUKBd0U9Mfh9o5+Oi3bUD
         1r7g==
X-Forwarded-Encrypted: i=1; AKwUvBw0Arsq0h1mjjKStc54kVL6h0bblQg4MGkReTYt9YIOKbMMiX1HLKkIHl6N7DQvKYOp4xA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJoeJky6/k1LwZpjlKsowrRuA79XfGJ3WiYEf7FrjFAjOZsYzPn
	FIpxx+w56lRVMayBzQdNWlRtp/8Z4AcvaO2FHzFZzN5lnuZQFfThdLa3hxJW40VIF/C4Y93zN3D
	2/iAYaBFlDvSOWufwhRBYNkrjk2UwEfSBGw==
X-Gm-Gg: AYBFou1cvfeaECvZvd4bka18uU/U2IfqsxGpsmzFDL9eeEqAwsHAQUJcIyb+JKBmaWs
	YmGXdBsC7KuktuGKZSs/cvZ+4uv3V1wuCPMaMxcKdkzJ+ARfHygoUZPmpY5BbKM5gmW4fLs+fg6
	ZhqDqjJfwbNJNwwUdW35o0CjB+zSITCHoQUnUI5MbcRi3wTaSQ8tAgMcOW3IF8W2/9yoJHASzIO
	P3sAZX0ZRejNPcNAd1ONkPHsnrVfpGv9JnkAaOO7Xbv5txFYGiEux1Q4FDSv0uN32RIxI+zQSnp
	owa8jBkiHRaYhP4Emyovwavz6XrNcX1J2N7cdUwG2IaQZZ3Ell8QH7o=
X-Received: by 2002:a05:6402:4553:b0:6a7:ee56:814b with SMTP id
 4fb4d7f45d1cf-6afad906407mr3149669a12.25.1791119843013; Sun, 04 Oct 2026
 06:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2428.git.git.1790960147943.gitgitgadget@gmail.com> <ae47baff-daaa-4b78-97e9-94faebb8e694@gmail.com>
In-Reply-To: <ae47baff-daaa-4b78-97e9-94faebb8e694@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sun, 4 Oct 2026 15:16:46 +0200
X-Gm-Features: AclHuK9dBKcfcqt4d564EN28WGSMqGZuYC9iMJa2GiFQAZ23bVKeMve9znVywwQ
Message-ID: <CAHwyqnXN=DZ_EzfTfxZ_==8HS7zX25NKoQw58Ou6HZELP_n+Qg@mail.gmail.com>
Subject: Re: [PATCH] branch: let --delete-merged default to every upstream
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> With hindsight maybe
>
>         git branch --delete-merged [<upstream>...] -- [<branch>...]
>
> and
>
>         git branch --forked [<upstream>...] -- [<branch>...]
>
> would have been a better design. That's the sort of design mistake that
> is much more likely to happen when a contributor sends an endless stream
> of patches because they're eager to get something merged, rather than
> engaging in a thoughtful discussion with the reviewer.

I appreciate all the help here, but it's not necessary to throw blame
either way. It sours the collaboration.


Harald
