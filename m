Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1877C374E56
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 02:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772506145; cv=pass; b=HKqTbdLlrSsSscovz8f/9dJIUPNDKtsi0HFtiwB1bKgsBBKLRXatPlsN+7tP3QZToVx5BXF5H377FFJ56UA63P75sI2ZuzMSlzzGmrXNO6OWIlmSUTnEpj+UWZdTbb5v74vc4sb8tzVPI7aLTA8qxAaURO9HNtSvQvL4md7jmDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772506145; c=relaxed/simple;
	bh=rRF02YqQLCV38vG9U+wdIsJHWnCitg3zhwXvqwu1MYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AfLAI7s2MNtJMZ8WZMEM9oxxiw9V5Ci2ZtdDHaMGiAvG5CtVPLXYv9+yNEYo+KV9Lm0LytqzySjzXhCNzYiQXOSzCnNyHwTaLiPPKA3xeY2MueltPjXq1Uy1Kxj/AKI0NjTUcm9Sit+wS4QM+cp9t25+F6opYWbxtX0z1xC1GDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpsi1fnb; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpsi1fnb"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506e287dd53so46124601cf.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 18:49:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772506143; cv=none;
        d=google.com; s=arc-20240605;
        b=BCzpQkzuRJmN0bcTiAs8PkEorShuCZlbBMJ/XtywP7kv2tYr28HvsQBye83Lh6OYNt
         7tnqfu9yz1ywvDbxNAAj5nNaqlCq9AoK/d6lioySmvzy40HMEYGi4G760518ZH4T15MU
         4botlYpZoZn/J7UEPcjK9srMTYPopN/+ozkUQjCA4u7RNkSomJCmMlMjgOi3uvcixaRf
         NViiOUv8Tw/bg9si8wulqBtIosWH4KHI+XjZhsoE6bPacKPI7sJOQKp21HGdkMhiMufp
         MUtPxVnAWIXLLF0Jgp/g0+3YQnNDI3JUOtzs7muPh5NoWMdO7TpLRM6ymSMhVqAmxby7
         lqQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rRF02YqQLCV38vG9U+wdIsJHWnCitg3zhwXvqwu1MYA=;
        fh=pNOm/ecUw45in4Uf3SlJj4Lz1+HvcYVBb/0IhWIRiyw=;
        b=gknkl0FPE/YXoAk5FKF/z3QIZusx9QewUXkbOUzBOC3S3x34pS8EJu5zGvWufni31u
         FHITHXkvKZEgFwIPEe2WnqxblHfulT7ahNlx+M5/quQTUAEeHgmeopHdecZxNb1lX2nn
         yv6bh0DUEi+Wf3s9Bkf0T6saNNHI6ubFM5lqglv16zfFhVggYSGXzOC5BOQegoqrT6gJ
         sibmEbJgtI1b6RoEyAEASxF/lWB+CReVRY3vbO41V1l4yJnuwiHBzeGorz9X6DUVEUFx
         WC1vRDJmMFt73mxCfVoR3DCy4BqUMhYboRSpzaadMc+j+1x4r8UUat1YZmbLd6pPy4hb
         0Fng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772506143; x=1773110943; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rRF02YqQLCV38vG9U+wdIsJHWnCitg3zhwXvqwu1MYA=;
        b=jpsi1fnb8PWgcQKZ/PoukjJvNDnyalnvfKxOfKOW4z8XiI5P6Q0Sg30qUlKjc93Ngo
         wwr2ezlm4qlFLbm2oHN99hP1uJ/41kISFKzxTLQ0D3w6S7CdyTlqWiuoE/zxSsVXOUzW
         5bvS+n4FfEaJaqEshNf3LvFP5Gm39tBnZ2eI6eLeBgvrfK8DsBG/bHvdcon+7q1N8BIB
         0Hz6wOyCJzl8mPL93Kw+mdBiYLr9NrE+8bX3Yl5iHzcNIVwTcI7G5tJMgQyb4tNxKi9i
         8uD93yeKKLEcL7q7jR4/RxxKe6Mz1C0LY8728dXcFwrH4MyMYPmRy2uu5nY95OcGLe+k
         46Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772506143; x=1773110943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRF02YqQLCV38vG9U+wdIsJHWnCitg3zhwXvqwu1MYA=;
        b=xPFabK9mnsVG4F2PSJ9jX8XuWJ+b1CetJaNNQN8N2qCeDEzZOV5QA0SUzQrL82vXpQ
         e+ZHOc3IP/UfydJaMSD3MLTxShW6WbWJFfymHz+wYh18bwlP2xQytIIkdenkN+R65IWV
         5Brya5LcJmT8pqpio1kv/AuYP1us7QtCZMoLQIHe0Dej3CHTREjXJieVbAd1WB3GQmVO
         VjetxhLBpi9mPHfU7qyxl2zuR+hqL2wGhsxJqJBGq3naoecdiFGDKEeZd+A72Ri2knne
         jbDIeQ62nHXJP7+3tsc4WtSUFMIDJsJZykMbZmfceOab0lQKOdfoVCamyR0z2rEoYRxL
         N6Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXY+13sNwB6U+4NN01+RkxxlsNeEocyRUfqD8EurxxlOL0ZTuZ0uq6ISn/HFSl2EPq00zI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFAzwR6KVC757K2EYIrZ3aWlhFxEphKkUMAStdKhSAH3gLzlQM
	ilMjtgQNd0Dn2ocpiHUdUN32UML1KJWL4rAP1Oua4lQm+2nkLe8OBvRSnNcR1GV+1y49mp4jvTC
	RNtSyvAu+uQ/zCImaagXaOFA3CWzZw0o=
X-Gm-Gg: ATEYQzz7VObd8qQy3IZUit9OD50XOg6HZ+gqYUPmsmY/S5Go2phByB1SFqWRYQ+0WRN
	v314qivwwTWDGzKv74fRJtufBOYZlkub2UxGeU6/bw3xgGT+Y84+yN5KANvkFbEknib1qqahway
	yv6UoCQ3DZVPV+/OCMamDeYnbpwawiWj6wBGe8375sWMyDq06v7JjqlNxG5V+aC4cRwtL5S1OMd
	0FruR45mScy8/nKhGhVu6lrxL7cveYS6uorIAcND5a7Vx6qhDi7NCfKT/KglzhWjEKxEfxyhlbQ
	bcJTgKkeIb0mwMMtS3wx1voWMsd4FEzh8gGjr25+9xaZTiihll5uyTIFtC8ruDAlKojBTDpy+h3
	7iwpS5oWh0XXdr7drcd3wDWvBNw==
X-Received: by 2002:ac8:57d2:0:b0:4f1:adf6:5b77 with SMTP id
 d75a77b69052e-507529bd67emr186727951cf.59.1772506142983; Mon, 02 Mar 2026
 18:49:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
 <aaSusXil9nDHYGMR@fruit.crustytoothpaste.net> <xmqqbjh64262.fsf@gitster.g> <3983da40-bf2c-4665-a7d9-dfebaacb8bd3@gmail.com>
In-Reply-To: <3983da40-bf2c-4665-a7d9-dfebaacb8bd3@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 3 Mar 2026 08:18:51 +0530
X-Gm-Features: AaiRm53-DITxcFyHOCwHAfxSyWwm1qwTyR6v8m2hhJWh6uGJGian33mgF3CQAbw
Message-ID: <CA+rGoLfbzXqP1Tw+94jMmWcSGPoefMv5E_fvwriad-O5CUeKHQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] repo: add support for path-related fields
To: Tian Yuchen <a3205153416@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org, 
	kumarayushjha123@gmail.com, valusoutrik@gmail.com, 
	pushkarkumarsingh1970@gmail.com
Content-Type: text/plain; charset="UTF-8"

>
> Short question: Is using format modifier like (%path:relative),
> (%path:absolute) a good solution here? I think it can be implemented by
> simply adding a path parsing function in ref-filter.c (and some other
> work that aren't particularly challenging).
>

I see your point here.
but wouldn't this effectively be the same as Ayush's suggestion, just
with a different syntax?
Whether we use distinct keys (path.absolute.toplevel) or format
modifiers (%(path:absolute))
It would still result in almost the same internals.

>
> Short question: Is using format modifier like (%path:relative),
> (%path:absolute) a good solution here? I think it can be implemented by
> simply adding a path parsing function in ref-filter.c (and some other
> work that aren't particularly challenging).
>
> It should be user-friendly, readable and free of global flags, right? :-]

I don't think the syntax is a concern, even if both of them are equally verbose.

Coming to user friendliness
I believe Junio has already raised an appropriate question.
