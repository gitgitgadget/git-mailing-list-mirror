Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793002161;
	b=ebUI8DQOfoa4hCoXhN7lbzs47B2AjMHSZmPYYpyW1Mxj51PMrGTxAC2x/nTizOyODagE
	 X1qqak9vr0t0Frh4xBlPJ1UXWcALWFk1PWUwemkgPIYb6kqaG1Oz1YE+3ndh1JcerlDMZ
	 0RKVntre0tfBy/07hwLD3/CtGSJI/xOX4Juj49UBteZp4/wycW0aJERHHmiEAS8uL6VQ5
	 tagW4FmGRK0UFGz8WreRVxr5NE+DaaQvLiYIfpJ2kcSDClW4K/0vrXRZKdf/ySrDuXb6i
	 0VHUPlzQcrvVm/GT74bTQYOB1FlsboEtl8+w6wbdwfuqizw2Jfa3n6TN3CtzTcMhFQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793002161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=gHHUjjM5bcBlvRs7KtwFATP3nnqZV5qXU1MLcIL1dKs=;
	b=PwII6q44S8XfTmw2RYONdP8effwfGNmhuGs1yiLT5wdQSoHQPwn3aEdwkNdIDXPNFxzD
	 6qjZWmd6B+IwK2pnFe4MWvbGipGxqt/lMlsglgG3dQP1jnOJb6+5pe5gwLc2+8YyofJ8q
	 PV6bT+6gJxsh8g1mhSPP4mYSCT9dSIhoxgzXzQsFlm5dWSj9j1LagoIFHYEZFkM0e/I9D
	 jJ1vNVCdfm64918rQl56PTZsIzYjhabTWto9FHysXJtUBf2ZH6Rg6UNvRJwnLUEtlRp8l
	 QEJNKKpCprWIvW7sMq80Q+jDvwVZl0e/y+e0Gm9uH3EAaCdWCRLEcHvFFK0B3C14k/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bXGr6sAC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77293606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77293606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bXGr6sAC
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53512cd2f85so30116531cf.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 01:09:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793002160; cv=none;
        d=google.com; s=arc-20260327;
        b=C7qXjwQuXnuoJkXbe8XEqfqVHHCdrfjfqNYFfdup2D41YfFrKqVZ5KnMhhr9/WkNZd
         09C2ODWE2JRnWrW483Nc9J7ODqx+8wQr0dE+zxVncaCnUAYQ3FSjCYv7VdwYAK4uXotF
         BXVxM5laUufuZpJ8DsXY8mE9vdFYXVIZK6kl1+bd0mAiXm8iGXGuh7mBBSdrqfx1MMjw
         KKNwCVDtvDZTi2Lxe79f9DyNTEQXwWA0QVO0KB/DMYwhKNwwqP57mpfS11Khz5fGU2Ma
         IM7+mmV3UHeoPYwmRps4LNPxO+qVXDSCuE9lmSlB6XrQxOiFZWlOzqAO+N4rTp86jQ90
         c1iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gHHUjjM5bcBlvRs7KtwFATP3nnqZV5qXU1MLcIL1dKs=;
        fh=wt9H1txgMffiL2BRk3a5PEfTpy43/9vXvLGIae/U3A0=;
        b=K8Qp34Q3AL+o7+uzyyAj2nzO37fHlnX4guN/8BWtk4veIJ1NCSFMqw7ZA4IDL2yXGJ
         ZwD5C7jPYUpKvZQjh22Kct1zu8r6dOMBy1b5Iura52xfwLghjC04s1MZ76G543Ad9pZV
         mkPzNOU4z2OAmQPNremuTPHHkOoQSKsrJZIVGPK8V1wwYNuQU/TYBe3yQhTD4rEGK1EY
         rEovCnj9OYdu03AbkOz0p9iumZjMF7HXH10STl9Xu5LCl7tG7YFeuZEhdhF6vNA7luMO
         TpDlUrQG8R0fIuko69bQtfr1O1dFwJLx2ay8khTkfLdlWjBGJoS5bq6iNOWyNG4W27RP
         gMxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793002160; x=1793606960; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gHHUjjM5bcBlvRs7KtwFATP3nnqZV5qXU1MLcIL1dKs=;
        b=bXGr6sACCbNU1IgYrDXCHKv6OhdeUCHSfaUbCbj1Qb3tpCkF7d9H2HXdRuz4g938pu
         esbBC6rPKHrepx8ifGjohHbFCJQxJmBl88ckia2BvUDK3n1G6rc2FXtr6+1hIBy9a3M2
         qZTD/qrJOsmMl4J1Mp/HRfIR/IMCNBPr8kVsFO7mYaoRORTMZGf9b5fsCUL91Ig8j8p9
         3mq4G4Qby/AP/t8zfh8GybRyq4BYUdTgqRLFu0RCjPbEPn7JASeDqAxiG+NoxQlMAjXs
         dfL32UymhmMOnyachYyv6OJoxMQ3v++RVviY1BdKhNCIN1MBUACgYI9uoXICgs9xYuTb
         jL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793002160; x=1793606960;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gHHUjjM5bcBlvRs7KtwFATP3nnqZV5qXU1MLcIL1dKs=;
        b=dzaEkNeqYxWEcyf2SlSjgKkcNfpbOFyqw2ucC0ezMvTD4K7h6r/r7P4H8a0X++NWI5
         A0JYBV0hsFnQER21u7361cLkGsDCGfHrBwkCB+o2cU6rc1/V0BVcITgVP87wkM8A/Zf8
         8heLqYmKhFDySmJxUe05huSyu46IH7tmLFdGaKLBmNtWVJ3CI4qXJzDk+rkCyAri4gRb
         E8N/HuEc21AwxMhWGnH8mzpu57Rm+nC+SUIRuSvLBukWc8Ail4UFqoP5QB3gR0Smumb0
         GPuqToirNhg/0G9RxRu2MUZ1vawznchQ0dKTa0VE5nk11HQX1eRIQ/tm/IiNLSHDtDhO
         ZULA==
X-Forwarded-Encrypted: i=1; AKwUvBwIZkYJRHZFKyxEITDCnANQbAGAnaY6/LZDaQ/r0STJk3+ygdhga1vjePD9SbNXZ7Vj41M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+C8nhrQnALQx7LbbH6oULqCvCAaqQUx58t5HAg/Ub5pKMRvme
	C+3rBfSzIbQG2orjdmgOw92PyDpQsyFSosDrW2EYKfAOfeop6htyWrbf8VfYoP/ezyXYka++zmr
	pDnzwGmMhgcvkBF3MCRne6AzfK70qfE8=
X-Gm-Gg: AYBFou2cNSLu1LSvAzcvqST3AOdrqf17olFs0PyIsVA3fKqqhzP3stBXFJYPoTi/ki4
	Hma80qhKlO8jSpeKk7GhUL3LliNMl1QJW3LqrSqQFmzuNcpgHxRcid7PN/f1baQ8HlXdHnLCtjo
	+N9mWbGhM3S1JJJ+ugPEgtY6o6zooeVvNa9srmoCFsJkkWca5Lw41YKvLpaf86XdQnpkNJrht2u
	0dt7hYl0+BIndwIKpmJjM68YReojJTTqPCjuNi6iST85FTB0tbQZEIG65RcOuxhXvpQZ0u8HYwu
	hc/NH4GK36TmHd3qIKj4NNd5qALJLS5Uk0JpjD65DKXrHA7zIbk2y/IQVPwy3fUwxLRwdkJbQXL
	Tktixy01K4eAjnecQrGkv6mKEwrPbuABFyC5J+3D+maYQq4lCrL02ALhA65t8YA7NnNG0oA==
X-Received: by 2002:a05:622a:a581:b0:535:1d94:5889 with SMTP id
 d75a77b69052e-5383b4fbca8mr90987901cf.33.1793002160523; Mon, 26 Oct 2026
 01:09:20 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
 <pull.2403.v2.git.git.1792774249888.gitgitgadget@gmail.com>
 <at79nEHLDrcoCgn_@pks.im> <CAHwyqnVVCp9ovsHDtc0pHYrFvpmdJq74gyx9yf3+ZWkL+d=CVA@mail.gmail.com>
 <CAHwyqnVGpc5ro+TksGGv4sp_JT-_ntuQjuXfVPSaeW+BYu2Pbw@mail.gmail.com> <at8KJi0eMEpN1NoO@pks.im>
In-Reply-To: <at8KJi0eMEpN1NoO@pks.im>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 26 Oct 2026 10:08:42 +0200
X-Gm-Features: AclHuK986WQ1cr3sof7QTIwNnjRtP4uMO-ezOra150tR1BkphUzdDlK1IJXTTm0
Message-ID: <CAHwyqnW=Vj-f6oMyKoGCkJp04Jz+qADoWgTYEv_VY8fWZKmRyg@mail.gmail.com>
Subject: Re: [PATCH v2] ci: fail the build if perforce, git-lfs, or JGit fail
 to install
To: Patrick Steinhardt <ps@pks.im>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > > This could all be a bit less convoluted if we had `set -e` in
> > > > "ci/lib.sh". But that certainly is outside the scope of this patch
> > > > series, so meanwhile this looks good to me.
> > >
> > > Yeah, `set -e` is a gem of a command. Would be good to do later!
> >
> > But wait, we already have it in "ci/lib.sh"!
>
> Oh, I missed that!
>
> The question then becomes whether the error message is worth it. In case
> we see traces (`set -x`) I think it's somewhat pointless as you'd
> trivially see the last failing command anyway, so you'd know why it has
> failed.

Yes, probably.

> Anyway, this is all a bit of a tangent, I don't think there's a strong
> reason that this really must change.

I'll take a look at what I can do without ballooning this topic.


Harald
