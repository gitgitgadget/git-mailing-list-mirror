Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE99134BA20
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250530; cv=pass; b=eBOND1bZEuJ0uvKTTrWvHxP1DSHDnXsGxclMqdvFL8P55+CqSrpN0sAaj+fw+cZcM8IxUwwwvvGAtFlFy8TilAmM+bepYSMQ6Fw+xEzNAWMsI6SPH7WF8gRlhj6jLOmHJ+fz9r303pUDOW9oydY+3QEhpIMRz+GVTjyJh+++pGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250530; c=relaxed/simple;
	bh=oxulgUMPM5Fjt/HjopMZ8albL0rTvKvmUN/B4yYtCnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCEEOqIL2i/5/zrqODwMIEWW4zyG8ergFf309qWQI2z35BG0ulSwqGORmgZHOYT3Qavve/z4yStUYEHXBXoKdD5J/z2H+TDdjfEQ7CMRfG70vnmIJipwrprIz894PHHISvbL9eCBcYcwv7fHAf+J1fDfV8UP4S68osEnbLuVz/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNyycnMY; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNyycnMY"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-138405b7bc5so875111c88.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 00:48:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781250529; cv=none;
        d=google.com; s=arc-20240605;
        b=LcteTTr8tICnaLhY4diPlEm6rqObTX6H9F44gyqTlN+bDwFkkSt/qepPQcpcN2gEmW
         6H/IbKRT0TmFHKDJZhGvVLu/DxrerVZE5AJ7rm2yOhTRe4Pl2K2UQjT6HZ+Kbmzdino6
         EQC2EPj2F9HFt6OVt83TSCHdkkZQvXVfECe+vJZhT2H9nnhUttmtPHFDxymFyXo7gwfT
         qzc3TNCnBOq3Hb6clmwhaxZmQsnhqO6zcrjHYaY5ixpfMw/51JLUSxrzNEloHU4R+pCd
         KfIipPpud1f2zqyTNxWDEf5uN+citHPQeZts90GrZTA8QfW6PnPAEEFQfdg2an04q6Rr
         2LIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oxulgUMPM5Fjt/HjopMZ8albL0rTvKvmUN/B4yYtCnw=;
        fh=hEoqR+K+i2TKfZzeZdxHavFML4oufOJDrrtQSUwGObw=;
        b=dibyRSGKAbhUXZ4hUWFZhisL9gEuu5QxRIvaWx3eo7LSCxgzlYbLoozN5aHaWNjn7l
         oufJXoVhwYusCeaG5ryuAdKtyFRirHnbPPhaKON5dlrDHLbhIbct+FlGlecn1XKaPufM
         fEwrEWIhT2E7PFZFbciPLA3qxcR3P1Gbv1iledMB21KK9DMZLs8X5PcTSVLxyeSnTEzY
         bZk3xiMvIePXlvTLkZv2+GwkwvFjyf0eG6YRIm0iShviSJrxuHDQeh9F0+5Qu3vaIeFW
         SHOh+X9cDerwW8hy92x7j1j8uPzyv425cN1ydmzspgk8cSkrpXo/ahBK9q925/njn4Qe
         ujCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781250529; x=1781855329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxulgUMPM5Fjt/HjopMZ8albL0rTvKvmUN/B4yYtCnw=;
        b=bNyycnMYKu+WS2Um0Qa40ZgRgcueTxQNDwXk1boSkMpwVDm9hQBM/Up7FhKeFJrLuH
         jqOz35LDEc3ObwSJM25x7rekaeVuL16ZTHr1qK8md6fKqDxpBZBTumnJ8CBl7gTjRPt/
         xeflMC1aZr7DNAEZO++cPLy7glfAbgKdvOm3u6NMu7X2zmQgwylVONFs453i3elayfK5
         /kwAfW2Mk/M47t+S/foOp1lOm9gnlEufulXnS0Wb8B9ZC0i/D6Y1mbAnC+vjmSoZFHQH
         N5DWD4dvyCyOryy9jGRwrPSjpaBp6hsH452ct35vi75lYnroEdvhu5ozdwy5tMvgaqyt
         tXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781250529; x=1781855329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oxulgUMPM5Fjt/HjopMZ8albL0rTvKvmUN/B4yYtCnw=;
        b=en+wst1uJl78CILip7h0JQK+ZxGWh8/odaDDIZO0XGnLS94pbZFOXf5eM3AtH0XX/S
         rquC4pptg4jpYtHxj5UFULWe/yebBob5FoKfCYfgLTzdXh+sP/VqPuICQH1TI0Us+Gbw
         Fj+ITPmR2874kzjW6NVNi84OI717vy8tguZcI+ch8Oko+NP3NkVyVFT8ductg5Veym6A
         JL1SmkgWWkfMJr/EeKbuUrEa5FF/hJDOADf0hS2/QqQBhtIPjijjoDukY29mKP2WFvBs
         4YP2Txrejw+USJmWOQGH2mvBZTimRImTG0Ju08BzL5pfd6S9TA+qwTV33R3SbBLEluCM
         MiNA==
X-Gm-Message-State: AOJu0YwAZnjSwk+dCg3So/FP1R/np3RsF3Nh63CaSABlG0xsDJVCQ7Gz
	Sh/HcYeJSvKjx8JXkxVwFnpS+geU792Dgewjluw1EfWXiYg5EeDyf4yuqLHDd+NxBdJ6BnmqlBO
	r+IIgIu6SltmkOwyeGbbZ1z9HhAAoiZI=
X-Gm-Gg: Acq92OHzKc/t/SfGk2wcLCHdmq/NQe0FgxT82WSAmzi7D+cdc4wFjh8rV9AhtQSXGR/
	NtP2V4kXuWGGb/k/Ff65uzWKCKjTx+Czy0TG02kQsEZNme3z/TDXuELBGH9syrVtkmNmqGv+oaE
	85MNSpKz7sqQoLzgkcfO5aE9bpn7fzlztAeHHDHCVfoIIUVaKjMpD/uADMJvorWrHExoq2FvIKu
	JJaiZwiHdAXHr31B8Nyi/XnE2fsd2WCoh8l9xMRNmbm3K7+IJnK7wMLGlsPT4r5t8H39PMgH52Z
	JxPHO9Fv5IaXw97Gkxz/pVPyI7MwMJWkcrRCn12rBBmXSEmWRx3BKsHQgcdEHF5B2S9o
X-Received: by 2002:a05:7022:ec2:b0:137:ec47:8fe1 with SMTP id
 a92af1059eb24-1384bb7fd3dmr851237c88.29.1781250528816; Fri, 12 Jun 2026
 00:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530160520.77859-1-cat@malon.dev> <20260610093635.139719-1-cat@malon.dev>
 <20260610093635.139719-4-cat@malon.dev>
In-Reply-To: <20260610093635.139719-4-cat@malon.dev>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 12 Jun 2026 09:48:37 +0200
X-Gm-Features: AVVi8CcPPZoEJftP7mUbheOmRFNm-MBejezCipJ-4qJR8ZcQGeSXeb_fCdWteLk
Message-ID: <CAP8UFD0X48BJcjLrr8mY0x3A03NSEN35G7jrvdvvp7Qm5PYAdw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] environment: move trust_executable_bit into repo_config_values
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, ps@pks.im, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Olamide Caleb Bello <belkid98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 11:37=E2=80=AFAM Tian Yuchen <cat@malon.dev> wrote:

> +/*
> + * Getters for the `repo_trust_executable_bit` fields of `struct repo_co=
nfig_values`.

s/Getters/Getter/
s/fields/field/
s/repo_trust_executable_bit/trust_executable_bit/

> + * They check `repo->gitdir` to prevent calling repo_config_values()
> + * before the configuration is loaded or in bare environments.
> + */
> +int repo_trust_executable_bit(struct repository *repo);

Thanks.
