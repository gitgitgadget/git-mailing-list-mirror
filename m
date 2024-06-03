Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938B674297
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 21:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450343; cv=none; b=MwgISH4tSyCJO9p6i/ipxguJRTsX5AZapVuVe0Mam3GN+PYxQldZjJwYuQdYYTYP2KW0D47kH/LNMzk45+/VTGKiq12FLapn0Te/QdGWLNwrsHA76FvDeSIJ0Ygy3fx2R8MgjvU7dXMvW3dudSES3AZYGHMxjJNaVziou0lz/io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450343; c=relaxed/simple;
	bh=u0eC0vctO52qO+iVsJrTXMEQIgDXJTjXBubHQPMjd9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dcjCT7/l5RLFKwfDdS8/sCZAHup6FREOFzu8rBa33rC8xN2rzrevqx51xdy7cEVU5pM/c6vpnWGyMu9lTYFmJ8TEtrxe89LoJ0HNTnqOOxxKdI0pouHASvkVQVNSjMmNgCpuIbstfAeKejmJUMxT07KLw8/cynCzngHk18SSqpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6aebdea932aso17196096d6.2
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 14:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717450340; x=1718055140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdfGDnYEtURwF24tyQATWDzyhF7NrEmhj0FhaR8CG0k=;
        b=qaHtDl/iCbQO7E4eB+g9IJo7LHpYmbJf8edQG/14/KYTr/S0vHYoGYtET6dk98gBjo
         NSO6JcJURI+yr7KIpAYZc0qF4YGKYtPWLgBJif+cKqRtaLD+E5j3xZR/Ni36NWDJ56ZN
         slitqxWy1UaG1k8JFmL1fXdXt/8y9wSZZjsKv4mWwc4tA2uqNbAo4aBrF9qdjXBq4c2N
         /uXcz0JHdj4+nQBlvFEjtBni/WpcmSHltJDXmx1lwPkYEPzOtiw3zXli5IL4CcU4QeZG
         jVWaM3KE4YPaAZV+RqWGlY2tQ/ZR3biGwGrTRToOCOquZnGHdFSozYFFfmzmZVh79yup
         WkkQ==
X-Gm-Message-State: AOJu0YwSpEWaajmAASDE73mQW87MszNk99AAQR4x5ERMezKnMKVadDgV
	M87dMFeahbTtUOsT40DqSFX0xub0dKamfD0zPnsVz6PGIgxCN0CYijjzZ3qUY3xnSzCSss5Szuw
	PMY3/sPldsMvDygTZ87fLWIj9kuWorA==
X-Google-Smtp-Source: AGHT+IG52ey03vdlnaOm1kqg/+jdyT6HahuH0st6DFlE0skiNwFHapkUwXave/T/SSschMNnCD3n6AOLIkLtru2PmtQ=
X-Received: by 2002:a05:6214:5152:b0:6ae:ce61:b4b4 with SMTP id
 6a1803df08f44-6aece61b4cbmr99080386d6.0.1717450340295; Mon, 03 Jun 2024
 14:32:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq8qzl3mhg.fsf@gitster.g> <20240603200539.1473345-1-gitster@pobox.com>
 <20240603200539.1473345-2-gitster@pobox.com>
In-Reply-To: <20240603200539.1473345-2-gitster@pobox.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 3 Jun 2024 17:32:08 -0400
Message-ID: <CAPig+cQ-kacp_4UoPPOOaZ6k6fa0cDNCYowdc1S7qJ1XteaMuQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] refs: call branches branches
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 4:05=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> These things in refs/heads/ hierarchy are called "branches" in human
> parlance.  Replace REF_HEADS with REF_BRANCHES to make it clearer.
>
> No end-user visible change intended at this step.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> @@ -9,7 +9,7 @@
>  static const char * const ls_remote_usage[] =3D {
> -       N_("git ls-remote [--heads] [--tags] [--refs] [--upload-pack=3D<e=
xec>]\n"
> +       N_("git ls-remote [--branches] [--tags] [--refs] [--upload-pack=
=3D<exec>]\n"
>            "              [-q | --quiet] [--exit-code] [--get-url] [--sor=
t=3D<key>]\n"
>            "              [--symref] [<repository> [<patterns>...]]"),
>         NULL

This change belongs in patch [2/3], doesn't it, not [1/3]?
