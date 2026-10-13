Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF93B2D73B8
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900307; cv=pass; b=oQn5AeVtIq8wuCR6pBGzIUWJqHFqPHIVm0JIpB4w8/aJECKOyxjfoD3tB0eidlcs/XyP0MZg8sMFYMc6/0v+qrVLgkq9urSM2OxAmyijD77BEjvrxgCkqrFXgi9X3IdpiX3mMQjYwNRHJZ0GWARiTI7rsoCrykgX+o6gzrSpUX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900307; c=relaxed/simple;
	bh=yTi8nlXmtzd+Yj9i0/bCMCngIKDn6pGGuF438Qaq7Lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qb2Xx/36NiTaLVKh1QpYV8WsUVR6+bpUJRhxaU5J0XDv3Mps5k+VcQdLUCLPclo1d3KfMEvKvNppYc6ltQ2KOVaPkHGzkgELnEB7oAi5q+aGHYBLjfNNm+DEZekkv6GG1tohEIQa+VyAOGpZijTnu6sEXSnLFW0VLJFJkZU5Okw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5AeYyVP; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5AeYyVP"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2e5e090746so280897066b.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 07:05:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791900304; cv=none;
        d=google.com; s=arc-20260327;
        b=adwu67jw0PS5WAQD4j3/Py41BHdpOKKQ17PbShTcYmMqxt7zFR+9pEAzyTmxOwX4Cj
         dEMz7JH0hl9EvdB9Wzt8qqMtxRwX5oYfuDCyzrfyPW13OctuKlmrroh8dHyBUQC2xrus
         mLbM6MgxRSOJKjPcFPoRb5ximnnK1pEF7Bpf4dngNuSCo6nYyAdRqbMbDMr5D4FcJ9Y3
         0HB4xyip25dClF2gtfhGdAt+RZz+PEyjYkFz9kyxEeqGSWJQJ+nZ1QGG67S5Ds4Njdz9
         wDRJVPN7kF0uVxhWmZl43LGat/WsPZc4mrUWFCRB3sdUmsxTb130g7x5PgLK38fwBpYd
         ol9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yTi8nlXmtzd+Yj9i0/bCMCngIKDn6pGGuF438Qaq7Lo=;
        fh=dN6yqLrW2AhKjbphrjDMUGgim3uiEELP58JAayysshk=;
        b=W9jX6QlIN+lx2kMRkFyAZhwXh+guYDVjj53wsq0hWDKYVpXcoofJo4S2RI6fnFYNpM
         4OJNtrJQnvF+zOSx0qRCJ5TQKe37lEtwCpRJsycD2eLFPmipESQpRgXUBguOBWVxGCjB
         qJBrtiPuizSYxP25K2SDM8ooilfKDbiNJIiZ6Qrviz8Vjqiwb7mO6xJwu8SsaaYy0iNx
         WswmBxN25x8fSvnjrNPF5hC7k6jzw3V8neU4dUVgqk08EWbKZwSZYyTs3m8g+nN+khE5
         8hHFNZAa3ZYdbEvlcr/XGTprk0mB89af1DR5rX6phvI2w7QnyD8mTTqm2Zvxng/VRTeW
         BrUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791900304; x=1792505104; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yTi8nlXmtzd+Yj9i0/bCMCngIKDn6pGGuF438Qaq7Lo=;
        b=a5AeYyVP+rlgASmfHKnd+QRjDTAETxbWWJDAtSr+D6gTImrbAgPCItTTtpSTLKAkYc
         O8PbJTQ3TXddjYCL3zAMiYOmprMOsAn7OnNbFn6yWijCdd5uY19ViAzaVtdXOGwQB0d5
         kZNjXY/P88l0VPsy7/A9aKN07GiMt7iYS6ZA8HLgDYvP5TcP6+tT5rH5EPZhWitII3Un
         qwD1N6eaSF5YWTteidCciAfU9RyEZikG2IMmmFsyfkdsWxr79kNyYhtFr/a1B6srxc2f
         WMv0V6OJegAui+s6XWX1JFJwrtjknR1yKZyZQH7K2iVV2cFAzLutisT2WqV2PN+g7pTL
         sfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900304; x=1792505104;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yTi8nlXmtzd+Yj9i0/bCMCngIKDn6pGGuF438Qaq7Lo=;
        b=ONYz/Gv6WULYLeOuM9pEG3yuD9ux+5AbfXQmm/LcqgwsMw0p/E6fvO3Lg8xBy4LZB6
         cFV+69348RIXl1DDyDAritSgUCTbH1uuvcGOM+K9ePBgtkm7otfu4WaVjxWqyhj9N7s5
         mVK94gxXo+tuq8FFp6BypAxVJJvF/PRsugJ2+2Qe1Eu0jjIFY6QEP7ysFDH3ZJ54I1MM
         2QJLM6S+fxYFA1sDvcvbVfx1yL8KOvSoGSmOMeKtaH/uLzAq3p+g5k//9duWxytEX9Ek
         4LhTazE2aK9Uv6AYTdRZ4/QDQ92NsDg6hh1OQgrBwsAkkZf9ROhfPIhF6qENux3a2Z2l
         CAyQ==
X-Gm-Message-State: AFq9FYKCQSXV5leroe7JUfqEPiYP40VZpJyzY3zj72ZMYfY1Wuffjg4D
	Dwj/mn1S05Lmnd+ETIYv6W2TjKugoIaiS/oM6mJmQsQE45wFfFtoq0QMNqPouk1kWdtDDeEX1qP
	9Vg1wf32hTg1LGc3o3WjWQFuK9nin8tQ=
X-Gm-Gg: AYBFou1sNy5SSb8Y12PlYWOZ+FTLA1hr8sLMXXWck9MDBVe6lY27/IN9IuWl1DMdz3z
	U8zcsUmZBxm3TLHfc7SL8LJllfALwI6prrrP/4vfpT1lg0xEeoBczxDgMbFqvPGeEd/fUvc5dxu
	7s4qGyKDt9IHW4a1QMZMHCcEyJtvBuqtoL79X3tMbcPv87aRKu3h7VgqQSrrPa62mRNcigWvvos
	3Ql67BysNQzM/Wb82hH/KS6QM098ICAtUbxhjqKKZrbmUj4xLellTYm8wL2MWwlpHra7x9Nw0Vs
	6iugP7Ao0mBPoqHCREj7ZF8E4TT6JKTjI0tYl6i8SKxXUzsH/yFHEN6+RzG4PJnh7k7RiqIGwbM
	bh51mVzVPw6CgCQ==
X-Received: by 2002:a17:907:bb49:b0:c2e:378c:8ce3 with SMTP id
 a640c23a62f3a-c31aa0ac445mr1190620866b.32.1791900302268; Tue, 13 Oct 2026
 07:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANHmUQTa8tLpHjZZ=Fp0m=X5Tb+uFuCcRobX7x05gKamXAgrqQ@mail.gmail.com>
 <CAPSxiM_36hf1r33GQyEMEkCAs5yeEWr2J+gFfgk=rx_-DoTv3g@mail.gmail.com>
In-Reply-To: <CAPSxiM_36hf1r33GQyEMEkCAs5yeEWr2J+gFfgk=rx_-DoTv3g@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 13 Oct 2026 15:04:50 +0100
X-Gm-Features: AclHuK853gYIIDM-pDrmIpI5_MQjO4LkEn-5Sl1VVmKFhPBzODMYdL0EbmFguOM
Message-ID: <CAPSxiM9eQY8oQVnpiNRqXK8SNqSMy3YcDwkV07Mh1wJzb-n4fg@mail.gmail.com>
Subject: Re: "[Outreachy]" Intent to work on t0081 : replacing basic shell
 test command to test_path_is_*
To: Shashank S <shashu8660@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> >
> > I'm shashank s , an Outreachy applicant for December 2026 cohort.
Next time, I will advise you to try to cc the mentors. So, they can
see your patches.
>

Thanks.
