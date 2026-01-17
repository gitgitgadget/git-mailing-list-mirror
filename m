Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726E31DB13A
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768666630; cv=pass; b=lKyrrups08bwrzllanklOt6IynLI8UfYUPf9aGdSVH91JWyHgOVWd62zSvyShDhrSwwAZnhGzKntS6//Den5jd/mrcbbHEcrRH2yGc6AUivVBKpyux71NjpB83cFD84xK0+yRxq+BEYm1UxZDTUl7nM6p5qLpaCd7epAwSZ1T7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768666630; c=relaxed/simple;
	bh=xdPvkLFgqZvrgQqejF/J/N9/AqURizWgRUA9CDIhUl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/IZrrrpz+hQj2lr0y8r7vCCtAjEi3JrDlEwSKqBIDNlGR54zs6wo8yfAu9aDuMOIpIb95O+dSe2gFimrgFoJ2JB/xJ8114sXrEWc+WsKaBN2U9B9NYgqavUkR1G0/1Ko+i1AZI6EdSOr/4wB9AAjTyAssJnk8VKCQRHgNd2OnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXEJQAi2; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXEJQAi2"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38310ee9d40so26713161fa.1
        for <git@vger.kernel.org>; Sat, 17 Jan 2026 08:17:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768666628; cv=none;
        d=google.com; s=arc-20240605;
        b=c9aTULiOOcXioc4ntBLHO6Ni65EKXQFrmLhm470DKkzEvcSUkK3m+OUC3qfFDM8gn1
         D9RQlQqrlkuEsGNYcFJ4dMO9bvFRFZm+fBaytI5JGy1s0BzTwtqp/da/4u6gkJoq1X+P
         4qUIEI8HDqACzo0ygt+DRM+7GbLECGeP7UHkMgk3e70LFUBis54wBD3iJJ5Zk40msFWQ
         A+hDnzNf7ZXX8tnyn7VCNON+dj8waIzg+rYxkd9OJN0sUpn8N32GS8x3iz0JDKKM3xn1
         rrtaRC8tQRl8XwcbgiWozrCkbNcuXDcy6iLwzVBv0Dm8YqQ8oaQQcTft1ejBgOG2r8bI
         artw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xdPvkLFgqZvrgQqejF/J/N9/AqURizWgRUA9CDIhUl8=;
        fh=cA9ndVEQyw/jOntqmMS1eMFGHPsVa7b7EEPT5joIoX0=;
        b=X3rd76qJBIj7hOUqTtcXDQXIAi2o/mdtH/DxHAaHXJaADTdcpRsjc0x9dgQbs0P6p0
         4Csa898gU9E7NBrelC2RNt6TJqUGgmtv+dT/EXFR6HtHWLpgWHx83L710bWPgkX5XXGr
         ewxcKIyIeBsFtLvCXELrqHPbjNlejiNGigAPXZ+ScRq/KR95Za+/06tMnT6Zv2tG31/8
         LBmg87wrfmtvdSvLkHqTrru2BWnxWc/qlJuWYlioUsQJuyMevn2gVCSnlFrNnAziW3I5
         mptN1G333r1u8aOEBhOWPsYesoUeYC8w3bw/EfEtDxYqG0LJIdNw8icQN/lbTjdniMD8
         EJ/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768666628; x=1769271428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xdPvkLFgqZvrgQqejF/J/N9/AqURizWgRUA9CDIhUl8=;
        b=RXEJQAi2DwiA5f23jugEacyh/gYxIrtDAvcMViu75hFjUn4qvrp8nB4B/zq5Aaph/I
         0kW00xw1cUNZ9RwHvzeK7BncAUzHthDwHdKpaosGPbKniPcpHaw2Z7oEtojyDAFkNuGZ
         pm0A1o5ZxyINhuuYztvm/3h1rpEjTnwO9mmW6Helzx9mJ1QGIAS4htFboFrH2pGi8yjN
         5NRf08nqtLzrJgn0oIqoSoJrzTggfXIS6foiGi5tplBv1yqBcNqaXbcUPThOPrlCf43R
         Hyxt5/v+k9dpyJDpM/aQXI2JxR3hYOO65+Z5oyJTQpz/KrtpqgTzgwusUX/OvcLOcgVd
         l/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768666628; x=1769271428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdPvkLFgqZvrgQqejF/J/N9/AqURizWgRUA9CDIhUl8=;
        b=fdhkt1O42tnNJnTdSWgUE4+kGoN24ypLzWWlLyjXbUpY3RPy2teVwOyAwSLWAatU8z
         xnOh9pVEpOHkN1em1IiZ8+s6y9Dh0Ap1/4A4A6vVY/EWL+Q4DXS+hPId0yzRhTlq8gah
         9BHghlCkU3I1P1JUoGQ2Wj1WcGJgn8D+2+DPbieWRGumBjjR4EPZewe9L7kMtzw16uj/
         dJnAo0fqIasWl65NPkO/k5HOUDZo/31kSb5dM1RUN5Sa7R9EY50F8PDNWo6O2rUqWpdE
         1KjQXmiogwB5MBEv5H8Kv//n19+09wbX8yQt2DnSVYMLIP1BOGhfnHOwGwW+xy0BQ8qz
         FtWA==
X-Forwarded-Encrypted: i=1; AJvYcCWP6W4bQuIDxZ3GlxSu9yJAOp4k/NA73TiHxF7QdIrnzQBcMpw0bHA81ewIWMW8yDICkpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxil3cbRnhblwdECH12BV9140jmOAp5801pyqMCeOtBx1Wy4J+R
	Fy2PuMjh8lJyB1vJIqD5tlCPC22DgUw/pG118Y5Zt/A3sNdMwWVDMJS4kya7muzZvXQ2/EWNIGO
	oW+bJvYwOJ7H8tKW4m8cx1+7dGeSDBGs=
X-Gm-Gg: AY/fxX4SBrLQvnLMLQkakblZOAzuw+LEXRUv2zov0T9gG5PQ5tdPgiB3Sc8ehu2hm7z
	XRA+tWNyeCBzv7hk7n0MuhYX1EtTGrywCUCtxXCUiKgpwUAmzM22m6LozIWbAR94GtoMhV3Anlm
	Jwgpzwn5i+++c+OQOSvEKOdqraYCXTufgQ+3C/+QN96LfYXchoFHP1QAi9Ozd01QWSFfLKdz6+Y
	xjdansaftMFVRUTS700pBJlr7I1ANo70fnfzRl/3wAuxDL4gy41T6ohGymYulWt5vWZArM=
X-Received: by 2002:a05:651c:221b:b0:383:46e:4b50 with SMTP id
 38308e7fff4ca-38384335b6amr22904931fa.40.1768666627496; Sat, 17 Jan 2026
 08:17:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
 <0437b899-5a36-4499-a30a-c2a074a80f7e@gmail.com> <CAH=ZcbA_HgEO2T2smn4Yg6gf4sm4jrR8A0ek1v9nqsa1MXbRJw@mail.gmail.com>
 <c2d9a432-0753-4786-8de9-c3dcfe69ac36@gmail.com> <CAH=ZcbAogCpqg0RkKg1WjuAcuKyArDs4aP+k=McCs_byDT2Weg@mail.gmail.com>
In-Reply-To: <CAH=ZcbAogCpqg0RkKg1WjuAcuKyArDs4aP+k=McCs_byDT2Weg@mail.gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Sat, 17 Jan 2026 09:16:56 -0700
X-Gm-Features: AZwV_QgIXg_RZTqY5FYrWDcvlsRr2xKMC-6oB5oumKaTUH95IExtOvb6c7mHMCk
Message-ID: <CAH=ZcbCmMCYd7m-nrjSM4i3Tyr76C50ekJGQgDtRveMC7UxvwA@mail.gmail.com>
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
To: phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"

> If the size of different kinds of pointers ever differed from the size
> of void* then wouldn't that make all calls to malloc undefined? I

I meant to say undefined behavior, not simply undefined.
