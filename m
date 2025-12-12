Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232602749E6
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765550939; cv=none; b=cZvecLGOxJx40mP7Xe+s70rqZeAjugXHOJD8ZlPZ8JxfHhY2pyhEEINr0Cz/i+blogURz2ethVVrEY8ezFxlDg4/wBcNNxz6RlvkCqLki7aVhK8j00DdmDVCpmJ/3X8d6JMtGAtURIbvO9WSGxqdbWjmuKLyD1Nr5egbYBIT1K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765550939; c=relaxed/simple;
	bh=lef7OheMlLy7RjsSFzSEdppqwfkR/wmhUZvgEzT6tuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0F/PqcWeDFiyQ2j+Z/yXmNwQY5BGDV7WO4evzM/dEAJlwfg1i01yr/ktkGrXjxV1fs8NiC29qrxvam+C+guYlMQ3Ojc9FCUpJk5BzSmOqlQW0BZcphj0v3i6HjG8SwrW5qilhRuypBX6mUkbTZ2adZ2L8KbzunjjzIQcG35WcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnUdWygY; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnUdWygY"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ed75832448so16246101cf.2
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 06:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765550937; x=1766155737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlWjCK4Q3r8BXZXRxQlLqiLfkWaPLU+3rwfdYTJ4SbU=;
        b=MnUdWygYBQxyPdNZllgzNc8F2ffuRi+9ySY1dh+j8iBRcKF5z7qPw6avqrssDPFEYV
         uOUiYGCvhaFIz4N224IJA/UfTl0a14W0jkM6FttcbZBmGLjBYjNS2tMQVgDdQZpb3xGF
         LAxDvqgqehPARfGdyAYvza9wz62A1++W3EvH0clUfyZ1bcwAQXacMeyJV3+Xd00FS5Op
         GXfn4lqkMiiERzxNrv7wDDfKDNy367oE+egHF8KQO9mxUC67fSvmLbKElRjkNDMUYCPP
         eH4QBnuBwYZGl/GWbQS6vtnrnt/wSoNujNtH0HOCqTas4JuXHnxtfsurHk6Vm+gIhMqn
         1IGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765550937; x=1766155737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vlWjCK4Q3r8BXZXRxQlLqiLfkWaPLU+3rwfdYTJ4SbU=;
        b=eRkDzP+7+rGHXQ9rLNhLxj8tmdZmo730b5KxkLBL9QVEpj9MgsbBs51QWJI1lApr1u
         ik18eBjjoLu7/gPCYNZ+7EqPsyeMjZvVxvT1r+JrRdq0gKB3oh8FcGRYslobr6W2lZnW
         Q0jxdeT4TW5QaCnghcMqorcU/1TK2z+JHo4qCs28hxaPs0nXLeCTNbE/h101aBxxGyzq
         5gHfzbAUcalMrFLOFiYJTpcVKUXw1RZE0uNj67C79iXy77GJ/gPgseGjeTHou374TYWr
         KxH13JXNILT9Z7RJNS1rbb2zB2Sbey/3SyouteA+Ejp8ZWcVXCs/BG4dJ6OplkERCTQ+
         0ZBg==
X-Forwarded-Encrypted: i=1; AJvYcCUGOJD3QamVgYY7XW1xoQrQiWL9I1giR7DBxc2PDD2Sji9+To+1s99Dci8hU3UPfp+Rf7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHyFxQIumsjrMX3vEgvWZ2FbJXd6FlP6pVZocYNlwpvKKk4eaG
	dvPVrV7FksikGFZ7JxoMamVciVeWjfFS5MoIwqJXzPBHlrjGJB4Lhn46v9GzdZlcctfI81lPt4S
	0ujot2mmOayTezfrurt8qlxiVn2BFS30=
X-Gm-Gg: AY/fxX6OrR/ZRa4jqjrbWJRKUIrVpHbvu8Y7WyMLhyaxwOzcEw0trRwjWG1aGHt9Ecf
	KByCVibT8BEgutQrteftX8a+7cMXvgiSpNlui8bdULVlfyXju7NtKP8kuLVbYfCSpkOYQYNuTKw
	s02H3qeH035rgBpU/fIQCx427KcXgWo6SXMTbTS+9lnFwVv2pG0cs1GBD/LlKo37++3/QPBUPAi
	DOvUsdnCXVfEQ3jOjHTYX0GErW0DoYWcG0hXtxyZTI5txve7pI29o0KMqkVKTqVtWByBkHlVEo2
	BAUqmk0pmbGPyHwsd7SzZP+GU1Au
X-Google-Smtp-Source: AGHT+IF3Iu2/NFRyl/JocWtAWZj9QFeMcuW9vBgKxBctcPZ/i2/RWLz7604ftPNZe7L96SaEVRIfJHbtxGYkRBVCjm0=
X-Received: by 2002:a05:622a:544a:b0:4ed:5ed:2527 with SMTP id
 d75a77b69052e-4f1d047a17bmr24414291cf.3.1765550936709; Fri, 12 Dec 2025
 06:48:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212020930.11654-1-jayatheerthkulkarni2005@gmail.com>
 <xmqqikeccnhx.fsf@gitster.g> <52483794-bdba-44b8-9222-761184ecea95@app.fastmail.com>
In-Reply-To: <52483794-bdba-44b8-9222-761184ecea95@app.fastmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Fri, 12 Dec 2025 20:18:45 +0530
X-Gm-Features: AQt7F2q1ZWLIS3hPkYeo1EOZeXHZ5ZsXqUTrTolyxvPTVBoMnBThSpwtHo_IKyI
Message-ID: <CA+rGoLeO1P9DLNVgiQJ0=nAQEgt=W+jgKM6XZ9TSipMdPxAjNA@mail.gmail.com>
Subject: Re: [PATCH] Make pull.c match the structural conventions
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> I=E2=80=99ve seen some commit messages in the last few months that have t=
oo many
> adjectives. I=E2=80=99ve never seen that style before.
>

Ahh, well
I had this format saved from Junio
---
First line should be an order (Not added but add) and then give a line
empty space.

Then
- Give an observation on how the current system works in the
   present tense (so no need to say "Currently X is Y", or
   "Previously X was Y" to describe the state before your change;
   just "X is Y" is enough), and discuss what you perceive as a
   problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to the codebase to "become like so".
---

I tried to force this format here too
That caused a lot of adjective issues.
The patch above is just a copy and a paste
and I get why the commit message felt the way it did.

Thank you
- Jayatheerth
