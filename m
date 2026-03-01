Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A4D296BD1
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 19:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772393712; cv=pass; b=tudLOjAlOmMCMUcTJFcExkzXCQAVynNAQQcLxZ/YKfpegq98D/T1gEs06xbM1g+xoKGVP5TdS34MqQ0fh8bRoxlOm4R5CoshXqshg5wgBrwZUgq7A4BUHfJt+rh6DQhslpNYnQpzWZZgd3o/dkwDQfAnKubmFv5oQsBwCTd+7ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772393712; c=relaxed/simple;
	bh=lfbsYW5jXL41MW+Lgm2h7ECgUTPZtexoQ8FMQcCSpCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNyUNx8S0FuIk0+vq0IsSSJGBGBHqyG+P2jpHZ9FUXX1VWJFV7j9dnJzQusANKHXgnEnRBDBYqzpkE3fYN4+mqb36jkp5PprCr4j+W4fX11/WpHST0D3NWDXT9lQbwpnhS+A/FNQMS7lQq1kNDaidc3z0fMBEbhd55uCCXicbAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZkvZnCV; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZkvZnCV"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7982c3b7da9so35320417b3.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 11:35:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772393710; cv=none;
        d=google.com; s=arc-20240605;
        b=a1qmwfyxz7F20Whaae4CpEeHq7cNxKY7wlvsLkfPDq3nG5AQc7xv0uPFEh37t3I8uK
         aQLNjyw8sogjxcKTzd9H+kiAIAXg+UhWMYZnrNV07x+XRI2MRe5fwmS93x4labWdqE+A
         G7Yyn9yJoBNW45uDFTRTmWYKu+I+fFKEUmBAsC878uPvcXDpk0LPA8Ngxd7Xpao9Mz0v
         KinmGdOwzny4/fMS9+EQ2qKzS6RlwVp4Q2IUh3xsLBMhZkL/ga3rfgF7LM1D2aX7yW8A
         V/JDtgjf1C+8UKQ+N8nsyyigVzuom/MdVLNNcpdnW1G0Da05qSFkpyW+aBUrz9AIaa5j
         rpjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lfbsYW5jXL41MW+Lgm2h7ECgUTPZtexoQ8FMQcCSpCY=;
        fh=0OXz45ACnuQN3kwPzQaWKdux3EeSNS4y0hud+FUbk/g=;
        b=ORo65/SYD3MutJcAyAzK8gOWxpuEX1orpca2Fwn7GYrBiiHJQd8mAlNKIIIU6oAEw8
         MVscVz0WA/w9ILqo2cIdhQKX83InpHH3veNXLJe1unEYOD0v8/cXhrlPeLA8gUnPQb/8
         TcSQ4Ur2yi/guSfTbboNXeLpOX068cnqsULJtsyRxW7E7fdgsq09JxVMIKA18zCnBB27
         tyekHDMYbyYLX2mH6p5oiK6iilsgSvkpN7SDNc4o7UuigMvt1VIxCW8f2K3Mqd2ylTnl
         UMF8hOb7r4qjiMRcO2A20X4xKFWK+MrwaDGxBOyHEbv0MFLTMHJw6kLTU7p3PS2BbPWx
         AVJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772393710; x=1772998510; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lfbsYW5jXL41MW+Lgm2h7ECgUTPZtexoQ8FMQcCSpCY=;
        b=bZkvZnCVVimK1L0LUcYMybc7M+5S2OdJu2jQerjIRgQ+inBvGY6LTg/R7orPfO8b6k
         6XayFe3rTwU9s3NySiWH4Z8VenUIUdE3qVdEQc4XX2RSdRDF2z9O3FGUHsPw4iXdk5A0
         WuvE8iWz0PlAatm6NWORCP4kNud90IsddCjb26wnmt9+g6WppbYelkvasDM9FYjxOhXJ
         iomyTJBujs1CxRSzKPTlxafIzaMwS4w2c+Ge2nPb9Q2vAPXNtW4WyH6U2f58oDuX0OTC
         e7dZ2f9dRF/wxr2HX02gtaqJr9ETbiXKrN/UCRo7tmzFGwmjIxD3bp98ndqEukFovYE+
         FkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772393710; x=1772998510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfbsYW5jXL41MW+Lgm2h7ECgUTPZtexoQ8FMQcCSpCY=;
        b=j4SnzT7TDHXx5ewQPp9iHEwMFZJP12Pe2t1ryOuEIQIqLSgMVgaPWz62+0frHGNcIN
         7p3B7UL/qrCOLR/wc8w+/lI+IkDGO7iS+FIpaxszipSsICe8tMDPe17X3RMhRQ1QfrAZ
         ASxThzpUmHCYziYBmeNbAjT9NYggIwG9ioZQJRLSmKmssv3wr34tuoGiGbteAov43X9T
         iTU/3qJIj54nehmL93Yaj5WC7YEVanr0JFkZoo2/axELcxGwuvXUoKCX8M8O44NYe6nA
         5dTNEJ4J9sCGMqqrzyQJJCn5+gTOIEqEdULyLNEwK1+2rI4MQ9CIY/j3SX6e0q4/oaG6
         1MmQ==
X-Gm-Message-State: AOJu0YwB+lIwlEhSaHl5gTvQ761Rb5e+BWlLbWl8rA4oooJrERKr2Fz1
	R7gE/47LWJAk4Vk0J4KmpnTrW33UVP1v9QwyoDJALSiz0Bp3hhzXCjFi6+tWIBVpdi5dmRt/jP5
	hUHGtUQYZdzSpIy71z03TJqOmdtHtS/M=
X-Gm-Gg: ATEYQzy+aasNzP1Dm4BZ9BfcMMDF/732WYcD4V3nRoeeivqJ9v53645PM9feWzTTBwt
	TlSJZ4OujHjYN+B37p0LM7ocGI+EVGBJ0odGAm1grtZEaplqe2X1CR6KWOQoi7w8px9X+bRvsO9
	5sqJPds9CY4xhQSs0WYIfTqWuuWrQFwJ68259vN7vdEH+ZVcmepCI9zpqJ2Hy41xdgfsVAavDVH
	zprwswg2fvMRp7uye4nIWYCc8A/E/KZl9n/WLi84DF2IVxIFzNxtAfMdPdW6yiAVpYKMxB/z2i4
	g7jkDzVUsqa4J5FGzQ==
X-Received: by 2002:a05:690c:c4e8:b0:798:7861:5069 with SMTP id
 00721157ae682-7988549ed3bmr82918547b3.9.1772393709833; Sun, 01 Mar 2026
 11:35:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALE2CrTt_2-9C4zCrZPBabtsWY=+Mk-bH4Jaemk=yHtfpoLjfg@mail.gmail.com>
 <20260301134412.1072596-2-pushkarkumarsingh1970@gmail.com> <8D232FDA-E286-48E7-8E41-ADC6645A9BC0@gmail.com>
In-Reply-To: <8D232FDA-E286-48E7-8E41-ADC6645A9BC0@gmail.com>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Mon, 2 Mar 2026 01:04:56 +0530
X-Gm-Features: AaiRm52TRLD2TKQFah8qUoLLN3l7scuYsTPnqYG-LD4a1dv0k0Z6gx-OlhwsK8o
Message-ID: <CALE2CrQ8QP-cy=j+iRr7ZEog_f3y+LKd+9T78PPFfebVqg6Y5g@mail.gmail.com>
Subject: Re: [PATCH 0/2] repo info: add path.git-dir and path.common-dir
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, karthiknayak@gmail.com, 
	peff@peff.net, jtobler@github.com, patrick@pks.im
Content-Type: text/plain; charset="UTF-8"

Hi Lucas,

> It's too early to send this. The first patch wasn't accepted yet
> (and I really don't think that it will be in v1)

That makes sense...
Thanks for pointing it out.

I will wait until the path-related series stabilizes before iterating
further on top of it. In the meantime, I will hold off on sending a v2
of this series.

Thanks for the guidance.

Pushkar
