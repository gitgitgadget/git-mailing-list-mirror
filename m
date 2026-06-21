Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6B0233932
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 06:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782023302; cv=pass; b=PeROnDwBzxI6pPqvDinvCWMGtL3DnLeZ8PbEw+PUvsrunX/sFJaaHLynNw4gZeYL3pLfLkctTBsSImAx59UdTrIZTZFD0Xip+pOfIgMjnx+hk7jRt0pHfi17zPc+GPSlRBmL+2Ey8DHs+mr/nE5CxUcWl59QQBP9jdeVahTJV4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782023302; c=relaxed/simple;
	bh=pxH8hv/Oiu0QXqwuwan9NOt3PUqHsW0GQ2DNBpIMYes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRkun86hJeNwPPqhA/2x/GfE1sqxlg29bVWebA1EHjytItROhabDoyzJOZmAATNf12ugMjx4IHMGr7MhQdIVYqP+G7w/kZx9c4mAhIQEEPuj/UXzux5uCu2hifw0Hx/rvB04y20y9tVZK3FZjHGKc6EB93pAdXBchcE8XC3ptls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpKH+9E7; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpKH+9E7"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bec423a5265so596318266b.1
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 23:28:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782023299; cv=none;
        d=google.com; s=arc-20240605;
        b=D0bTLB8uqObZwOSyiuLeMdQfQcKDJ31/ctEb+BDMKXnj+0ewRt3X7ywrcJkIWCWlTA
         XCPZf2C4pSojB3xI0Oga7fvXmNWecf3PbqSd/KW1eCdnFKkLFecSXYcBtNrtXjLKk0N0
         3KqDdnFgqni8e1bQtSwQJoPh1nL2GCENKXdeNWUgPF79VdRwAIEYeXAahaYUQQErKRMY
         KbnnyuSXH+VRmKRq2HuEVxsur2iNQ5oSOf3hmp9e91SaXKdCT/bFA6tCe5gCwIj2Ikjw
         hnZhb0PrQnFjrVgfoPrJRoix2z3jek+y+EX9il+VbdF3tUj0N/G2nrkWTtG8TlOevUgB
         i2/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pxH8hv/Oiu0QXqwuwan9NOt3PUqHsW0GQ2DNBpIMYes=;
        fh=hGTg/sBUj3yzumvy3UhK/o7EqoTCQmDPGtnfZ7sPp8c=;
        b=GZX+rPRyo+NqfXu0pvm6AOvhrBgljr6dyPWJycIoe1vRVSqmcRb4iqFnz8jfRNejHL
         agzkYAZgx12SDSL/stNCnU0JSL5/boMGDgPQvP5fooMjFUEowozYZq+yKV2+NVTYzg3a
         5FSRCKd1PJQJ4xki/lbChv3ADa45wP9YFFImHOJkwxg8mo5it2IZBM0hJYTPY9WoQ0Sg
         FdBrKPb315YCo4zyLqHVueBPbz/j0p0xwQbBDRtT1zXtFbhedqqJrd+CtCaEDVY6elVQ
         HAF4xdcytCspxysy1MUkeRc9R1f138g0qHWLgtDFwA4gvk5BFNifD3zIdROSLCZdzsAJ
         rBUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782023299; x=1782628099; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pxH8hv/Oiu0QXqwuwan9NOt3PUqHsW0GQ2DNBpIMYes=;
        b=NpKH+9E7jFMeXcNIJCwpU6wSUpjNb2guZiUo9uGLGMx42OMBakGnQNHW0hnp022ePu
         OZmG6iGTYyzkQYr71zgQwwfbI+3y19xLmd+hFBk3rmpDZVPpQPfn8szrcMVAfpz5gC5T
         RvgO5h5HJH6CcecEPGTo3IoQRRbP/KHkqBQU19B04JRI1Oc/KSAg7LEs/79Hc3+1SY70
         ZP+Dk/+xFHT6CAjbnosLLpvC6m26P7TCAoqgVnccomVBVxQRzDAbTsADEsjR71pPbzoV
         ky9tGOjrgvONYeIjLsOzXa4IdY6iz6qT0j5GvMfW+lWKK7f3XYwvhiejvYwO3o4nh7xI
         fQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782023299; x=1782628099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxH8hv/Oiu0QXqwuwan9NOt3PUqHsW0GQ2DNBpIMYes=;
        b=SWOBHZB/oIpQyyj8VgiAQ3mpT2eZCAZ82t7hrVfnF7KxRuMczQ1BcU7vS+uDnhYTvU
         GoLA6Dg1GCmnYzk6qgUp4HSywn0pcP84xbr2k3FGzqKAeRG554HTrUo6DUxMvtqtW91t
         F09mOznI/NHZdd7GSXaBPd8iQrhGyo74wCnuhYFkDrhqwx/SAa54Y9iZdffdg+oMLYOk
         nySypIsRucpnqr4aEaqLYrLkNBKLhcPwxGmtod9xFaUHcp2Ni/Gue7Q912ArkMIxFfTP
         6COma0o8s927NFGfIjGcsmBSYv4rXBJsH2g7rBUNxDpLEZNNMc5TwgCHqHuUZCXKZ2N3
         RmNw==
X-Forwarded-Encrypted: i=1; AFNElJ8b/EYSP3+VI0AQ3K9VW8IbR8O2XBPQCTuRzIxhwBJXVnzJG62y0e0le8eY39CYGFq7+Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZRv9bZYRck+hwNjFFCh3bMXoBV50RQdJ9yXnC9bmeznYqXcva
	huZktqsIJ/YeG/7bW7JPzYZFVMMNZmnv5XgH8+bFfJKWTvq5hKzN6d/AFDsC0witveeeSYlo6kR
	PZ4aWFuIRrFo2/CPa8taixHGQ9XflfFM=
X-Gm-Gg: AfdE7ckoMAnGIN68picW/7qArwylKR4MjVHocyI0phvlZPRrLE3JRRmLZbosRfSwGaa
	VyNYlpY5FsqIzsNkwQ6nXXPxyY4Wbk352YezcnxIlubiYlrq7d6pARogslzjoOn5YHsfs5WMaok
	EnHZrTtbEl7PYy7APJ3aORV89z2omWenM3Gj41O9LW/Ty7myhbkc4pJ1SbKafLuM8PPiShUXpOp
	xM5V87Cdofk8ZDIWYBloVABHNegXD4UK+qg3fuQs1x+Yf+6TZY+VuatqbR5UZQ7nJG8LgN0ELZr
	W/qgPdXSj9RK4Nn4xPdnzGX4OVKNcRKAZkrcS6c7LBKK9N9BdBBCYl6F5d1AFELw7pSQpimuqOp
	8ewGzodCNig==
X-Received: by 2002:a17:907:971a:b0:c08:4e0d:d66d with SMTP id
 a640c23a62f3a-c097ae63259mr472134566b.14.1782023299330; Sat, 20 Jun 2026
 23:28:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260619-ps-eric-work-rebase-v13-12-3d4c7315d2f8@gmail.com> <CA+J6zkRoS5uZFkW1jJv1JO7jPMPO-ZANOYerbUxn4WPaApPV6g@mail.gmail.com>
In-Reply-To: <CA+J6zkRoS5uZFkW1jJv1JO7jPMPO-ZANOYerbUxn4WPaApPV6g@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Sun, 21 Jun 2026 11:57:52 +0530
X-Gm-Features: AVVi8Cdy5mD0kRwjcqYXkoBBG4Z29lGq0A8n2IbqQWc4wgjxvmanhlXw2zusi6A
Message-ID: <CA+J6zkRojd3KVfna05SuRwwHruYJmenr1NZ03DY-AtwT4TDf6Q@mail.gmail.com>
Subject: Re: [PATCH GSoC RFC v13 12/12] cat-file: make remote-object-info
 allow-list dynamic
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, eric.peijian@gmail.com, 
	chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com, 
	karthik.188@gmail.com, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"

Forgot to mention this in the earlier email, but the comment explaining
why the backward iteration of the list is needed should also explain why
it is fine to cast `args->object_info_options->nr` to `int` from `size_t`
(it will always be a small number, so no risk of overflow).
