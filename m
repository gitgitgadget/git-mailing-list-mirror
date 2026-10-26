Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793017138;
	b=HAjwjspTevM79fHsmRnt5EairO1D2O78Ap/Q/D/NYiPxv+hElN4RW0HW7OYyZGs1PNTS
	 ouvy6+ftPdcm54FqZeAb8VOlGdHeXkQ+Vaaslih6hOTIO1ONvt0XWXqLZagcK7MnMy/nV
	 bs54/cJM1qFyQMk2I6iwEo+8Gz1R90LSPfPk4A0NtDj3/ecvVUl+UlyAO5hp4hsryTvNL
	 5m0HZTh7sI+QOY0wtOB+haXTBW0LqcZUVXg/GqBOZMv89hokutsVdhyzXgozEuBVrf74F
	 OhvOb9ZMxJfkiB/DVfAmyrZrTvEqMT+Ct+bA3OHqiF7kcz1QCzYcF+QoBnsCclGJzzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Tvhnheopglwo+h69PwEgxUkksBo1TOCmnD2qXgZ31zE=;
	b=s0Dl8pjEwbXd/rK2q+PlLsSPLmPDKTKC8AupKpP4ssEw/bQJH8miBMeOxx0jEkVGJmK7
	 EoRwgI9OzmwD8qZh7wwe0YGXW5sX4d16MlZvgv787jc/X9SAFc0j3+XnvtpR2gwRqP1pb
	 qYU94PKAdpxkGXH6aqE2cfHl/E1LsYncjdF8EPZe09tcsbL9SbdSkbY0CktegVmPwL740
	 pSZfoJ1A4/1zDO+pGepbkl4DqSuAnHEF6rgadSelnvxt8YDq8rKmBnXshQjBjAMo7MDhh
	 lXuabrAotbTOW7FqISvN0PpbBVoMlYfcO0/7SgJjXPFRjWSDghGPXWmiulnVXCC9sKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eUOO0Dlo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FCA606A31E
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 12:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42FCA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eUOO0Dlo
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b1aa377c61so3693770a12.3
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 05:18:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793017137; cv=none;
        d=google.com; s=arc-20260327;
        b=sIwxf3GyOv+yDeyHyuYTedSdePsEjMdQrjhEl01fpa+vJ0uf9X+L4iEMFlq5zLxhCq
         Lol/LPsqGUw5S7767ECHzwFKr66cmyE4KQ7l5Y5HA9q/YGIML7vc/sY6cEh2EDfILZMC
         NA4nDdxSlCIpIVlvJufxu2QeYypXZGCpbdGPl8sjNPgeWRzTW1rtgLBtY6P3K//pOl1K
         drCegdiDZLOTC0kni9g8cQnaOvdKZNA+Tax5X5mFWD7TF1Db9AvUkfXr6MaqCnf/Zrnm
         uqJuFToZ3Voiu0JfpVdqfPMsxhSlxhcgaRQXu9ioP8b/lZarigmvvgBiahReDO8B5aPE
         5ErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Tvhnheopglwo+h69PwEgxUkksBo1TOCmnD2qXgZ31zE=;
        fh=j1qagLAVRWPrL9IAYXLdjYKC3mGXiUoAVV2deN7t1xA=;
        b=ZhaWakO2r+mNsaAxS/8DQm3bEU4QFbf4xooNKBGo/9sDj7+Kfr1Zz2PD6FCfQ1O4Ea
         XTUfltJVlXLF6cc4taFb7tRDG8BVcfMyPijWuiwPWY5kiM3gHwGP0zEyA2iyZ1SgTpMQ
         Gdgk995MjvTh8bHzxmwCaR2MTGKCDwl7VtFjAmEqvxzyCHYt8v46v9yfPk6EJdJoyzxH
         J6wh/jTsKFKCiMRpeQO3SvunRhrdYR0lMFqJHTiA/1PXqXAO5w+9+rZ2qnJIBfJD6tkD
         tQi16jXPxJq2SXXqAapNGrHwcIREi8IfFUXDCAQ2gKbqADaasGRqxy+x4G+NXVOPhPYz
         gMtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793017137; x=1793621937; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tvhnheopglwo+h69PwEgxUkksBo1TOCmnD2qXgZ31zE=;
        b=eUOO0DloUIfrGIyitifc8/3P4YB8m1tvZ1a6GxBhCGRe0mK/uudl7EhG/fp8FA3gTi
         9SPzlXgSx5K40mRqju4ilnuc0LnGlC1w0TDHSo14LxsLzVbLmcA1c0AkD7kWX2UmGzGq
         DGpva6zVlr/+s55phjOoTN0nsothWFW+R7j8+W103UfssrIkIyuY3bGSXEg6Hw8FdHDz
         DIvD76hzTYiOZhb8RGFQXOO5OtHUZDttHDtJh7SJPtcyilTbC1iBcRR6/dzI7HgNLYbk
         tjSW8vEo7U30cZ0jCjkpWzJOapQMhkXX/FFcyn/LWR2OwiTe5kbf0u83BlasNMa063UX
         yEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793017137; x=1793621937;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Tvhnheopglwo+h69PwEgxUkksBo1TOCmnD2qXgZ31zE=;
        b=lkG7kr6SyqyAu39T0UmXMRd/zZB9YiBTuWKMj2Fg3h7HQkSL3eSR6d7gsvA1DUEWaj
         nT+2ut2Sr8kLYGt71btMBiSS45Nv34UC3u+8xg00cPblWZsxphZcsP/3uN1/bBLggCIN
         fDtonfU2iRwtpIembQ/W/rjLvEViEafBU8/6BBNORVv55SIsnSCJIV11ZnE/o0HXm+sp
         i+lFQA5np45ScM4N6nQTCYxsz0wVD/OQpHpNTfuaehj180Gzb263GFQwWMuarj6wDpB2
         b29/noFBxto+6syIXXtdvY3v/z1KOOtMUqWnMw5Vt4S6nEnSF+w5HnesElBw2uHImp6q
         PwVw==
X-Forwarded-Encrypted: i=1; AKwUvByB8hADjFYrfSewc8MfrV4eZ0YEdPF5iwdN5cK4byOlEFprYMCwKXXfldVeVMKbprtSRqY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhC91umO57lgQD2Lyrijd5Ncha4yTHNoxl/XqtPCCu61muDpq9
	SwAwo+WpaG2temEfCc9x+mWA1YbD3BiCohJ8H2od7pDN37q95c9EPTM7fyt3Z/nr5Yz3aZ4yhRW
	0iqoFvQnFHzNhNPcT+RGmETitL8n6j3LpNUQD
X-Gm-Gg: AYBFou3JkZWQAONNQKgnBw1EJ2sfs2VW5QW8k4zKGqpnuN39YI1gZv2AUh7xYeIC6U7
	ukSWnvpxBUhxD6L4pOYFSBOcM2ZdDF4W0jL5gdWi1hV8p9lonogcfslQLOXGAkRqTYiSwvwR9pT
	nW3Ot9BcgJl08jPAKLbLZgwSurVIfcOb+Oquj9tGzg7dHmLn3GC+SOplIX/5RpPNrPsaWZxnW5F
	N/c6ZTJB7xOapDCLIjwR0iK21rCIDzsfeZ/pSfDp43qgObqn7hBp1ZnG/bIeyyZSOcE3WQ0L2ju
	smP7QNGAqcUk5Y7tK/g/9F4/Av2rt8sFOhdhFK7i/nu3wxsPEcd6E09Bvn2Dey09raR35j4smUi
	Jzcy7S3gAMfgih9ZUG6rrtOaRDYFBEG22yAw=
X-Received: by 2002:a05:6402:1ed0:b0:6af:dccb:acbe with SMTP id
 4fb4d7f45d1cf-6b442a826aemr7654567a12.5.1793017136584; Mon, 26 Oct 2026
 05:18:56 -0700 (PDT)
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
 <pull.2403.v3.git.git.1793008465.gitgitgadget@gmail.com> <e85ce85d921f5c847c4a370a5c56c98f2f20cee2.1793008465.git.gitgitgadget@gmail.com>
 <at80qOfTn5_YUY_f@pks.im>
In-Reply-To: <at80qOfTn5_YUY_f@pks.im>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 26 Oct 2026 14:18:19 +0200
X-Gm-Features: AclHuK-97_QJWXpjSTcdphHSA0rs0daBH6FviCxB-WC0DoDMPbjtJTYUTfl9_LM
Message-ID: <CAHwyqnXC3UZStYB+hscXe9fXFqpicDD-SCMfKwxSk-agdw-pFw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ci: drop quarantine removal for macos perforce binaries
To: Patrick Steinhardt <ps@pks.im>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> So the question is what this does on GitLab CI. [1] will answer that
> question once the pipeline has succeeded.
>
> Patrick
>
> [1]: https://gitlab.com/gitlab-org/git/-/merge_requests/714

Seems GitLab CI passed.


Harald
