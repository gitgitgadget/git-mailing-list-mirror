Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68013182BF
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFbitn2k"
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0924FDB
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 03:29:14 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9d216597f64so651397266b.3
        for <git@vger.kernel.org>; Mon, 06 Nov 2023 03:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699270152; x=1699874952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4D4ENCY0YBjdNAPiH/AfiuAWP83uenSlVUNUTHCdVA=;
        b=NFbitn2kA2dxq0/ydvSpsLm+7BlcnIfqyi+3znHqcmzF29KnHSzVmEs4FAUUYvHGk3
         KvOWznNOklTVnUYRU5XA9rwnmTgJ5l5Ly5McfMZJtd5DsDGHNvmlYNDVcWXe5FK5O4vr
         3h7e2K+BBSmOszuhNryU3fFO7Y9ygmIqe2PFnj8/B88swx/b3GQjGhawMa7Uw/k9RyjQ
         HA3JarbrOwMAGKvv6GrLh8PY8AwpZ7SqHMgLyhW8T3ZQIcX3OU2S0OhTTpAM0N27oXGp
         RSBppG8Luf1SWt9ovkeAROJMXC/FuQiFvds6RKyiBuRgvbFbCy/GtWCttDv8xDWLPcaX
         ajFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699270152; x=1699874952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4D4ENCY0YBjdNAPiH/AfiuAWP83uenSlVUNUTHCdVA=;
        b=m2AXyX6Qg591d/1oSaDRNTKC9bKCBeKh8js1lPYZDaJcVUNc023m19q7rAS1LWz7y2
         ghClOkX7ojNX2yIROgzQQMcNEsZ1hkyi6db7jMuXK0JyZnXfss8MX3BwY6LP+d1AgR76
         T6MGd7W2pR8qtkk/d7q5zTZD/t7Lx6MCqyz4lGsnkJe5evrSLLKtLzNV7TfA+59fBBFF
         AcUjcp8D3Z4RnCJkCSiuWok+1mgzXUMFusl5udUm6vPU1fAOFyZ0wx+z3mtjfXRWZ3Df
         NRwXWBvyPKGKIBkpJx78rCt0WitU3iBM4+3V0eZzCilJiP7iuf0QLDsT6TWco3tAlNWw
         63HA==
X-Gm-Message-State: AOJu0YzBOeXxiqE8enECIEagSo5f5rSfzT+1Q7mGiByyyQ+9yQCOlivK
	AHFP+4DeJC+/L94Oh/0Mzpaqx90jrehVRnVOu7M=
X-Google-Smtp-Source: AGHT+IHnU3JaY3Xy3SEfwlqKIKNAy7cF1EFhHhRTj3gqxPo+iZ6XHw5gSr3ymZdGGcUIs0subn2aghLZ3Jh3w4gU6X0=
X-Received: by 2002:a17:907:6e88:b0:9dd:add6:4c12 with SMTP id
 sh8-20020a1709076e8800b009ddadd64c12mr7952215ejc.77.1699270152318; Mon, 06
 Nov 2023 03:29:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011123534.119994-1-oystwa@gmail.com> <xmqqpm1lnme4.fsf@gitster.g>
In-Reply-To: <xmqqpm1lnme4.fsf@gitster.g>
From: =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Date: Mon, 6 Nov 2023 12:28:36 +0100
Message-ID: <CAFaJEqtN0b+Prv79E2=sODaw8vRVGD-Ane7U+WzoFoTWkvCNkA@mail.gmail.com>
Subject: Re: [PATCH] revision: Don't queue uninteresting commits
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, derrickstolee@github.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Junio, and sorry for the late response.

On Wed, 11 Oct 2023 at 18:40, Junio C Hamano <gitster@pobox.com> wrote:

> What is not described here is what benefit we are expecting to gain
> by making this change.  Is anything leaking?  Are we showing wrong
> output?  Is the effect something we can demonstrate, and more
> importantly we can protect from future breakages, with a test or
> two?

As far as I know there is no significant benefit to this change. The
only one I can think of is a case such as this:

    git rev-list some-rev ^a ^very ^large ^amount ^of ^negative ^revs ^here

but even then I would assume the work done by the algorithm in total is
so large that the work saved by this change is insignificant.

I was just a bit happy after grokking a piece of this code and let the
excitement get the best of me :-) I suggest we just drop it.

=C3=98sse
