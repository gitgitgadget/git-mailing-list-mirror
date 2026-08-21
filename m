Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1F43CB546
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787310908; cv=pass; b=ge+xJhef9ldCLJ7tctHDPS9qUqaJG07FcYL4/Yosyb7Az98TgYnD03vpoyYNZynV/ywJ9jwazvO46EeoSoNJTj4vL8s14/588HU6uTBpAyxD/hEo7HmAUhs3WEzks3ftpgQ1uS2EVjWYEgBb8LO5mMlgu795GateCeu/6qLMvc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787310908; c=relaxed/simple;
	bh=gMQpK0pmBSUaMcJ+Sjc2ghlo6W9hv6jkFGzYq6jgjVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LajQJVyudmLhUwA/RjDvDR1QzGDv35qHYaNMAByytFPNeTy0C+13S0+At4BzNz+aQd+NJYp5AmpF5PcMTQ9gzFatUkwT4uwhgpjLVyVx2gACUjMZgNHK98vXFF9+cf3e+xsPYd3w0uhJ+FUtFwPBo9RD3Wpw7GFglnnbciEN7Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZ7Msg7M; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZ7Msg7M"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c214321dc32so172024566b.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 04:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787310906; cv=none;
        d=google.com; s=arc-20260327;
        b=LUlUHof79Zxyx2E73Vqoc1A/UgojjQ/kUNeagq9I58auaUEG7Ez/HANSDCyKPSLX2p
         pcRgjPqwRQXK9Vhfu01vO29MZFu/43YRVxqEfFjXVMbPoK/qvU1BsV4Y1rwmcDcl585d
         3DiziHTtnaIoq5v2roZD+5RSMUvOssSKb0QitWBL+zcVBFN2eMq5QAzBAgaWBicpVk7i
         hpwCnC7d/oedYPU8mZ3++T0+7QA55JOd+AtVHgWeh1D+hEUc0ZG7jtMEHSkUcwzoNpsy
         9z2QnWrUewafm5o+Lka7sAuCfPqGUgvGb+vC4CMCGQIbIdqkWsCGJP5XXp9y04kDgSdX
         5QtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gMQpK0pmBSUaMcJ+Sjc2ghlo6W9hv6jkFGzYq6jgjVo=;
        fh=4taht92dzazhQDOjq8CsAaKR4Bsqe7vCuOP5jjEO90Y=;
        b=CJa/oQ+MfsjhyxDnqpmZ7K/+8pp96TUnilyVyoEYWDDA239/R0mn6aFbkaPgTwINdN
         627tdb1Et9XxiGeBZwXNClBXOOY/rK53SdKiBwpeKHFqIIu1gAp7OwdDlQlsFj5h5o1e
         QEQSdmaAlnsTXll/aQ6nzrkUvatEfYi97eBrfuUF+jUY+LRloSQi+i8odo3OGzrcaZba
         3/PWwa4IvVwQRPBnO3JXWFJZ4AAvF9s7YvmKsAtETNAddqUNB47iSaBH+RBge4ANLMez
         p6Tw2fFYAlRXyJK09kIhvvyAUwh4TrHSVS4ETXcvTgsJDAr+HWpdNt+Hv8nGHkC/S/1O
         m0Ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787310906; x=1787915706; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gMQpK0pmBSUaMcJ+Sjc2ghlo6W9hv6jkFGzYq6jgjVo=;
        b=iZ7Msg7M5yo88bVTHSzLrV/91wLUuFgoXUsbfQ9/ZZw5C0UXloNFobpDCqNjaDNo/5
         VPMASSZ41h8vuDu98GtlZXQStD60fy6XQIhu1mB+o/OgpEabI0OfapH08eiLl/5oUuGA
         2+8Aw6ttXpRjYuynjKzeHeiUyHJyM8ZmD4vp6qyORn88VsQW6QhspCIv89G/guTVcAiT
         athG09IWwJsDeywETT9Cp8r3T+qyGxcg7BzuVCHm0aUONDuclq4/IhvP4Ua1h0MgZnQ/
         BmrZQodd9b9KbN8ArMbweWR26jvT3aXnfckCdRgQnrP0qBr8hI1uu2Ymd6qOE1HXCTQw
         eclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787310906; x=1787915706;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gMQpK0pmBSUaMcJ+Sjc2ghlo6W9hv6jkFGzYq6jgjVo=;
        b=Ok0ej+9vdFKJnIdnNOhiUUBhoXjUctISj5tY9RAF6qAec/vwShlylq3gn+IIl8fyig
         29mn8ucd5+9WDF07BrXCpsQd5sGBSDOtM5fodQ2knjX0DGo3rJkFgyQ2/Lo1rhcIG4im
         DrDaSO06YNkXWOr6S4Z3vvlHwRvd/GStF2nosMYUxM3XKeUDG4wQx27OeEPvq0TOyl35
         04nopEet8hCnJ0RAWesdh5oh/al2MH8M3i5Tj9c5Lcbh3WEjx7S/qDttv4cxuiocXSWY
         YxJjAbeoK76L1ozGNCbuFfsBG655G3xLVKTk45snz4odMcW0bSiT983hiDiNWfEfqi+l
         EiRA==
X-Gm-Message-State: AFuF++k8piUHtmHgOVNVplSMgY3RHa5bF9VjpURdtK5MS1DN4lu/3A43
	b/2+Ozxv3JPWk7GirqfE8TqQxpJXBnekWz45ayJGU0OmB4Ij67aHW03Aivrrsmc29QrOBRWLDl1
	3cKOO+lpNfWDJ2PZM+iDCzlKEiy7ovR7AkfX5
X-Gm-Gg: AR+sD12UkABWN8sLVgJq78/dOMQtucFb7Ny91MSTLguym3C5suNbaeuE2XDl1DGqNyi
	Hizm0GqJO4oRTLQQcUCPCsuo/GQ9iMt7CK7MmTlSNsIiG1tJM5C8pz9Fm1PYc++74tYCaMBNWg0
	oeMvAHeYlnyPjU34P/Cc7v9mjFNMGtsJ/dWFGl8kmTCHFZTtga0SRKgZxreETjrgiawvnfU25Km
	ptWQYMCSKl6s5C/bMOQI7yJMmaCbn3xwfCDijLBtv3i1WMsPAUFWf6j3LX1Tp4a/g+XhAgfZB3+
	na5hYRJR7o7Sy8xqaRuHzITQDbpTN09J+5ckfqAKCcCJ
X-Received: by 2002:a17:907:e1d0:20b0:c20:f864:d480 with SMTP id
 a640c23a62f3a-c246a6559aemr444365266b.13.1787310905669; Fri, 21 Aug 2026
 04:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2369.git.git.1785492641983.gitgitgadget@gmail.com>
In-Reply-To: <pull.2369.git.git.1785492641983.gitgitgadget@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 21 Aug 2026 13:14:28 +0200
X-Gm-Features: AcwNN1X7jmbmN5ItOlZbt63_90TS_PQw0UZovms3j0_MKyFjx3IG5lb_9bQz4rw
Message-ID: <CAHwyqnVteA1AfqXsFXTAvFdbTZmep3o84RMNZQWVaHDHtODOqQ@mail.gmail.com>
Subject: Re: [PATCH] ci: cancel stale pull request workflow runs
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi!

It would be nice to get some review here, this will save a lot of CI money.


Harald
