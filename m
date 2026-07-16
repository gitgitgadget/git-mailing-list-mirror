Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9003AF644
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784236986; cv=pass; b=EjbkPXrYp9C7GdjiPJjGZAAEMqetiyoo4nhf+Z9futX84z6lr76n10E86enqqeZ/0mN7OoxMbQlX7Sv08UCStEm2FD3f6WltCW3CrsqCbENERG8bQIDJb1hsSO/uKad6G3xdrgdWKHupcxfMLif59QqVzf5Rm7Lsb3TkIj9JWuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784236986; c=relaxed/simple;
	bh=efq2EKb5ftp+W1wud8YOyEMXftQA1sUHzilYLKaF41k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFsXmkFpOdd/nM1Lc2tMEOmcY4+bYsoswOgJcjokWSLQ/WLMwEIGYkXoyLbwqou7H5eltpXorMwIlVPeCSVB49klu5B/lNqAKyFZIusdGzOPr7LEq1vqLNal7DCVG36mGnfWw03lV/pawzCuFaJpXsGv6kVGDJg2/VeBgxeflr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoYXetti; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoYXetti"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15e592da74so874290166b.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 14:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784236983; cv=none;
        d=google.com; s=arc-20260327;
        b=P1eYEBXAekl/4+W/tQ5rYa+0RDRHbyZiYB0mEW8Uf22h47SrtEGklJBi7bUAutqSCL
         XECNf18WUuT/oN6PwTRqvceUfmaTOCvWxohAzqkqTsESN/QtMjUkhvv1mtPM4HFIoI5L
         NH+togqUyZS8yDoeoRqOvNv0WWA9kuiPQCgBIjOh2eha8HgLI+NWo53DqmIRl98/I0TJ
         3NEFrCaxJ9gpXivv5/ZuJZHL3BivSLprptlQOWCcnOJ9sj1X8egW0K1BsaakKNWD86Ol
         Qu6ys/T2X/5LWww+fjYJ9nWRplOvFIEdWYVSCcSX2Q1cgnFAYB2cs0DyXhVuBUbXjv9a
         X9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NiYxHLRqoK6xmPNqMv5jpdQdDf++J2hlNp8lvJswdBY=;
        fh=6tFKMT6cshYnNBRRzNoJ/COu9vj1dbdLIzmCXjn3+tw=;
        b=k5C0kdjrJmmD/DkGcLkGQgqmh4EOIaI/fPJUvSaORFC/24DjEReP/NeyCNy3v1iaiV
         ChIlGkHsY6IIk8UeDOLOOmBsOK+3FovkQDZFE8H7ZfnT6Vm9fcgTzWZ2oHrjejDNfjrw
         lL0AePpQvi+CE6uHfad2eZXoQL/+fKlz+AJ++am7k38pkzomah4nY+9xSpbrfjEFnt4e
         IEldEggV0eTxVIAi0ZbCagBgnEkFV8ES/QxBXIC9IKpiyIJTCY++S9Nd9L77304c96nR
         fyUhv9U49v/OdDe03t+0jFmuELaczweJn37VCwdLWfOtxyCr6KOxzkbLFMTY6hiOc6HQ
         lbdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784236983; x=1784841783; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NiYxHLRqoK6xmPNqMv5jpdQdDf++J2hlNp8lvJswdBY=;
        b=LoYXettie5N3Culu6mEdv85utmrS6xERaJJBvpV5IGnLG8mh5+RHdQCLqvXNpGDyLl
         J6kK3aiXemsRZ280JYAnIgdvupmn0KMn+/k2qMBUwdU1RbbQTjFYZvLfLV7uq00KyNCj
         i79EBEIeLaPyp/N6QiHUz8fkRqcwmy1tJi4xgle2LMnJOQBj9Z/P9DP6tFQYzpSGX2UM
         Jm0BnBIPb1y/xkjOm/1ckfaIiIj5s/P585Vhwfo1kYL+F/Zppab2vm7xA92COABRuFL2
         IRHZSmc+/Rh3fau6HXUTVdqaPJJnn/VG0kGdyEQeJqgVbjZpUJhN0BOeYo2vrL8xDEO7
         4JpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784236983; x=1784841783;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NiYxHLRqoK6xmPNqMv5jpdQdDf++J2hlNp8lvJswdBY=;
        b=HZmr3+qiPsCBzTIgbprZob7stIOnezOnbFFR3hqD7I0zGaaF8KRaLvZjyHPIuLE6Qr
         sHMgzi61a+8EVvZcrdFWMnvRQIEOik+TKFlnF5bJ8NzqUOobxD03H6nizot8PWv4axDR
         bUO3YsFdcoczUzPD7129gihE18k2wimLKy79BLF1P0TaYXPbfAYUvul6KhuX1WbJAxN2
         FN0BWerRT2+F+Vq9ZIJu4Sg/p2SN/Gzj+aikiYtq7gdZaPwLaxzduZ8GTVl41Y1ub4P2
         ruM0Zt+QIXjw2uRIdAVUdJ1X1LGfX86wBFpTNqC+d0x+KNw4LGUezgy7u7ZWKNpfvdbG
         /Hcg==
X-Forwarded-Encrypted: i=1; AHgh+RoKKTvLr94/XWJsaZ8dC5sIEXMMbAcx7xzb2wNxtojkdAArbM3DbCIp94ilsuzOmti0bKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhMGZ83e+KMuHU9jIA+6MuHMaPMEQb+/sLITryiwMKeQ3tPCAS
	t8sIePMymmnpBHDB7JkYRncR7kK4Q/+ggeVZxAsfkL4SBzY0TIWMTzok1KMCOw+0fuFIwEZoqUh
	6Y3kh56J36ffBzEjFAz1wG6n1OFoquA04xhdObH8=
X-Gm-Gg: AfdE7cnXNl0yvgwvO/Po7SOHDzIuLV3/8Ok6aSnshbqnPiqr9CvNuL/N90UiRIvfIX1
	sjrJApLGOtaFTEWG8VP+ncAsIxLdSktXiw57SHMRjOz/wGPWI/LPuq/rRB/iQdP2xRt6AMIpaJm
	bXcAa2+REXXI7j867+PdQUHZ8SXQQSGaqA4Ix5JuoqH1tJ5IAZ0S4VxgoypHODR26wKSZDn2dzx
	+08yle+eYrtXt4c1cLuDMmt03VVSt6w5eqql+2czYmxXi4Z+vn8r2KXrhywjg==
X-Received: by 2002:a17:907:3c8e:b0:bfe:ed06:5a20 with SMTP id
 a640c23a62f3a-c16794d13f7mr532362766b.53.1784236983090; Thu, 16 Jul 2026
 14:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2335.git.git.1784180159.gitgitgadget@gmail.com>
 <a9194b1d00b260a7a7852eccec54c872618b5fdf.1784180159.git.gitgitgadget@gmail.com>
 <xmqqse5ihmsz.fsf@gitster.g>
In-Reply-To: <xmqqse5ihmsz.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 16 Jul 2026 23:22:24 +0200
X-Gm-Features: AUfX_mzft_j2i_Kr6nbdsgDiKLCjsDyaH2GvhmjEKVrygTOy_cUyaiRL5rlamHw
Message-ID: <CAHwyqnUFfewFm7tr-Busv1rKP=4Rqnq+vJ7mEdgbaRLKbpbo=g@mail.gmail.com>
Subject: Re: [PATCH 3/3] bisect: add --auto-reset to leave when done
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Add an "--auto-reset" option, accepted by both "git bisect start" and
> > "git bisect run", that resets as soon as the first bad commit is found,
> > returning to the commit checked out before "git bisect start". The flag
> > is persisted in a BISECT_AUTO_RESET state file and the restoring
> > checkout is done quietly.
>
> I often find myself, after the culprit is found, running 'git
> reset --hard' or 'git bisect reset' to jump to the problematic
> commit to investigate further.  If '--auto-reset' leaves me
> checked out on that bad commit, that would be a very welcome
> change.

No it's the opposite, returns to where we started before the bisection.

I don't mind changing it assuming no one likes the original idea. I
guess the name shouldn't be '--auto-reset' then.


Harald
