Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA1D292B2E
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781950721; cv=pass; b=mbg0VRbXVfKO52V1N84fGeKls51JBdIF08PySqTXSjbrgNW/thGLHn/3etnD3+vsAUnYEsDq9C+KbqoxDNOJcDtiD5e14UaBqD6cqCON6Jin7Yh5NAh0GRAXG+rI62KNAwQGwzH+Mo31KxhTjaGa6nH/j7um1F2O5vbikl7X00s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781950721; c=relaxed/simple;
	bh=hLUGzh+yAwg2fyIOYGwZxI4Ju4w7kGY3U/pvtc22mRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Co8MJCzIkjQxuwhTMwZTTlf6TnQ6sBvgC3W1IemOQ6fe0Sz8JEh+kZHHPelEEO6Hvcwv6aLoTXi+mvp3rHbekg3sr4T9EITTd/1ucZxzUBpPwOdzFX9E2Qby6n/HP+c3KRkcWKj7PRBweI09UnE6aTLtZFAt7bougvH8BRLEhhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7FbqO3N; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7FbqO3N"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-660390acd71so3932318d50.1
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 03:18:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781950719; cv=none;
        d=google.com; s=arc-20240605;
        b=e0UBfucdttOrp66bPQlcwH88gbmovkw6ekWaLQPwWJfn4Bv/yDvNgFD0cAMZlWSRgp
         ln5+XC0NUO349B/YDislxxHjb6nmSX8ZsHz8VEUXX6Cza/NYkumOi5pZ+I6o1+c6xyX4
         S79w6/hg+rXQb9laptE9ih6DxcMUc/QL5HDEg/1TU6znR+KLbuqewneTmSSMVmpYxXv8
         wNInxa/ygLcRCv/kWR5h/DPaIa7iobv8vMWMFZN7OPnRPEyE3oONr66lgMl8vKyoe73P
         dC7YriNmn4VRQKqMpdaA8Ra18QIA6nOL7fN+eVx8Nvb1vmU1dKeQY7aNIOYoYS4cMeuu
         KPMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hLUGzh+yAwg2fyIOYGwZxI4Ju4w7kGY3U/pvtc22mRM=;
        fh=yHnBALpCYLaJbEKwmRRz6qomGs0GEvYbx+JahkQyLKs=;
        b=Do/h75MYA0ztwNQ677Y8JAfeVpBob1XDMYYW1tAP+9XibAiIlk8aIm6RMtgR3U5Svc
         tJRFZDrdzmROoCzvmXdWbJPqH738HE7yA6Z4buXdvHJnTPUCcs3Xou7IRi16MwqC3T4v
         vyfVcNWYMhiP5TjfiY19agR1GHGqfUCw0lB+yXK6ws+HnyNBY/6EFQjGctTtQh8w3uw8
         fNn12m26fMuod8enGeTmb4YoYao83sQvXQ0Dh/0BWMEStp/bpTI/Y2gXvVG8zn12dZBX
         JEn4afxDzf8nIpXJOn9U3kJvXo2nw9XfjekCSiCfIn+3YCNx+wEDICPV4bTY17dUVpte
         Dhew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781950719; x=1782555519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLUGzh+yAwg2fyIOYGwZxI4Ju4w7kGY3U/pvtc22mRM=;
        b=C7FbqO3NjQzPUIu/Kp+hvm9QbJoohmEJdPJ3/pCqbq9sWShJ4lRLJ2ofzVZkor366p
         mM4zWcYyCivrn1Y94VlnJltRMZtXky0qCkxurWNTepICKoXynvrOQpOsC7oTxeKi5BSQ
         91oxNSaCfbx7P0lXZ0n62o5dR4Dazx09MFDUXjeFIIX0wVTZeY4uSiFlwyzJM51B0m4O
         BHQkmy/IKcR8iFbET0qXcEjgAq6O734pQCZ6VYO1k73bumKy6/TDPZfCKcx+2gApigJJ
         HUlRsortVc03sssOPfMtGQi1A6uyJ+lfHopAIhd4dvQjpVLFpxMIralJqois4ANeyMAn
         iH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781950719; x=1782555519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hLUGzh+yAwg2fyIOYGwZxI4Ju4w7kGY3U/pvtc22mRM=;
        b=jhf6MxwOF5DARl7dwEYoa4L/LptxCEIWsFc3gnF8PGfdw+u99UFPlbiuJJG+Ba07NJ
         lCFGxPLbszizA97Gpl4tRa+zSeGBXmubCa67bUCExPUoYDacPhm1JijsDd8S9EIGavBE
         y3ztr17VMOgisljye1iF2VBK785iiBmO0vDYPmsBbZFQEgcCVRZjGD94lOXWYKyGKDoU
         vftyM8j4p1juFl+5jmmDA+sxFGaD27R67qLBBs9QGds+SUUYxQb+ol4icXlg2Kgom1+b
         JFSR79bHZHxEfjO7LVW7U2CweNrNAxS+vJ69QH/xrTa/XIscCxzlYa1pU4poJHVGjVtK
         +uiA==
X-Gm-Message-State: AOJu0YzLh43rFqKgzFeGmUSejBM5WfVG5MkET3q7A9B53MthJrfqJUM4
	Wh4q6MbTOqRGKmMQxMjoJscJVILlqOhH+MBpk/j7EG3HlolVQfpfzArm38RIb+12FuGcP723lB5
	nldznGDX3BAk0GV32FDBQcNACDbbIrQRer2oi
X-Gm-Gg: AfdE7cnEfDcen49zcivcioxeto/IUBqp+svpC7QRY1GHpNMwFA1U37TOl8JQw4rXRpC
	a6WNEFheSo3B5JriqdOU5T2JMuPHEzlndzxCUbgUZqnvukThM5t3ajKVH6H1yg2NgdaPocoG6zo
	72OLJO/b1qae7pm6b+ajtttVFiZOmRlmuYycQg2XZ0vEnX5GRe4+icq/Q8CSGe4wXAP4ZLFyPcr
	Ai+Iq1HcBfuZnwNJFuHX8ZAu7sHJmpkahocVMjjI/0GjmR+jRS117gRSofO0DrHZ5wCLE2mUErq
	X/PNM4QqY9Zhqf3l4gz2EoZQ2lD9IMiLu0HjowIsMrsbcVDU5wowcpwqFJB6mRLoITyDXH6vqRW
	wxsuPbqDfcM9sNuPfwksz/1n0zoxiwz6xQQ0Hd0e5iCaLXeZd+h/p2FJHWAUxxGRtNEAJ
X-Received: by 2002:a05:690e:a4f:b0:660:5666:8bc3 with SMTP id
 956f58d0204a3-662ff1bc9e9mr5187514d50.47.1781950719101; Sat, 20 Jun 2026
 03:18:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
 <20260620-ps-pre-commit-indent-v6-0-cdc6d8fd5fbc@gmail.com> <20260620-ps-pre-commit-indent-v6-2-cdc6d8fd5fbc@gmail.com>
In-Reply-To: <20260620-ps-pre-commit-indent-v6-2-cdc6d8fd5fbc@gmail.com>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 20 Jun 2026 12:18:28 +0200
X-Gm-Features: AVVi8CeD8k6x5p3je3usm8xZl5Mm8mkTrA5--r9wUud5FOLjA52FAxH_edH1-Fc
Message-ID: <CAN5EUNSj-2hkEBF7N_M6RLsuujDNFNUF3w53zR7SN1_5i2BRyg@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] revision: add peek functions for lookahead
To: git@vger.kernel.org
Cc: krka@spotify.com, ayu.chandekar@gmail.com, chandrapratap3519@gmail.com, 
	christian.couder@gmail.com, gitster@pobox.com, jltobler@gmail.com, 
	karthik.188@gmail.com, peff@peff.net, phillip.wood@dunelm.org.uk, 
	siddharthasthana31@gmail.com, Kristofer Karlsson <stoansen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El s=C3=A1b, 20 jun 2026 a las 12:12, Pablo Sabater
(<pabloosabaterr@gmail.com>) escribi=C3=B3:
>
> The graph code in a subsequent commit needs to be able to look ahead in
> order to set indentation-related flags.
>
> Using revs->commits is brittle and the data structure that holds the
> pending commits might change in the future.
>
> Add two functions that abstract this for the graph.
>
> Helped-by: Kristofer Karlsson <stoansen@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>

The email on the trailer is wrong, sorry Kristofer, I'll fix it in the
next version.

Regards,
Pablo
