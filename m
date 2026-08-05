Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A622C346A08
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914148; cv=pass; b=sX9cdF6L7m+j8BfabVx9t1CD2jqQvGMtonMT2tsXtzKzbSHwPL7XnucNnO0SQLYLbYgye7vd+8ssv59sw8uNDu/RT69NTH1QcI/eK7JFMbL2qCXhqd6sHsdUOna2XJxZE4LMoZoQAVR1uW/jrXZXkrtEKAJ2FY7wkEAc+neAWic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914148; c=relaxed/simple;
	bh=G4rA1WY/nD7RmPUb+LbYijezt6MB6UcHMpS5RDJUtT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=roUi79lrRqxXCosKbxDX2YEhhOeuUKY7mbkUh7sJTHYdPWp6eLo7/Jopfy0HlwQym3F/dpJrvlGRw946SMMV11LzCKAiqY7+vvB4q5VBsCjeOHFJ4yX0TP+Z08i23pPNExqLa7UUL/y0UFosW78yXB4XbNtssSK6Xh+/VI+1kdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKasrml+; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKasrml+"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-448cf99c133so2216121fac.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 00:15:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785914146; cv=none;
        d=google.com; s=arc-20260327;
        b=ha9d6uC08cF5Zg+fGO0fCk/u01S724ARcduitUFFKCVwuOaJCunAev5WacyV9cZ1Wd
         Wid8gWPXV02WiVpBVKONR3lVX8RzqsXQGV5fF5sJYpZObPU+DxOBjsC099f/oyNvOQ8q
         jnFQFaAtcop8fDaF7OXXNBAm2zAIrtRmg/KLUj70K8EP0XXPaMxWM1pFPoGFGMQPRvj1
         Kgj7D4YeuBV/NLXADbWLj+7SSNynbiJKrACP0RP8kLN47x7MyxOBXnMDucO3hEN3xPQL
         7H8eV+36IByjYLKtQA+6UK4zkVE2AD/GGgYUb65MBujURiHavfLfLeoY536p/hmgPw1s
         gnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mv3efqw3XlUxvj7BX3e9W9jV1rZVgNkv44peYPBB+2M=;
        fh=7EuA2s/sYzt0UA/lwaqSdP04xQWSFF4lGtDkIBxIVbs=;
        b=NnWDVlQntgqEibcQP4kqHDfXJ1/OQmffnlPeRHRKBViPNeXF5jBS7e9IKsNHp2UfyQ
         h6thB7QW/HVKGxAGrOLTjfq3JcgNzNiFfwdDJ8869FmLv6tJBqdGUHfwbQjOzQOyuDZi
         /71xX20vRelc/zEJ36clvy9mmH9at0Zg7dcmFk9Djcrgc5LcSZPQxgi4t/K5ViyBw6bx
         YrNSMOjLf/ahd57uIxdyTtcXS4vsELW7gRY6vOwFb+JyNBKPXl//b30jPoWbKZ5jLCLV
         ykAdVCsl4kwFqF7nST/FMjQAqwl+vDOV+z4Ym2Kx5N1+RY0LCUtvDutaxrKPlbiWVGED
         LaEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785914146; x=1786518946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mv3efqw3XlUxvj7BX3e9W9jV1rZVgNkv44peYPBB+2M=;
        b=PKasrml+2hTTJDAERdcitoGYNbxVlSlYpHkgoB53/VE7V1gOVNwehixWZnWI2rHV/J
         /APVn1+tmPPIztWzqYK4RitGZLt9vK76q7yFcBfAQa7MRf2/4/GKZxSyXPF3I4WEjiTm
         HGQWNkJdA4hpmjfmE/W2sKqJZm4Dmemjhj2KAfQktGm43OJlMHXn2Dl+qGFn4PD/3K9Y
         k5AHwjeFss/LgGzYwJAfCGurgdpdEb+qhjq+/hs5i04637FH9Kidv3937BZzpRohUHBA
         J/oV0B6F2dlzHeyteCkSlt774i1sug4yYfjbx+slcTI7rzCkhf9gP0UMoam42jv/wPTM
         B1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785914146; x=1786518946;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mv3efqw3XlUxvj7BX3e9W9jV1rZVgNkv44peYPBB+2M=;
        b=FVErUqSxtpCmXm8JCXTI4nUIX6uKPKVmSjWWTWnE+vykD2A9tPzVMS6Lg50Gy+Fjt8
         eo5VoyFkrocUnTWd4n/UV8OOLIPahnw2qS2ursJytp2kNN8EqRw95naRyZFzzE0UnVxX
         mhbGbMEAv5sZO4OX6kpXKllPTHhD157kjWhkWXHjzO0fHdFNZk9TfJE1tG4StaVOZ994
         Mkqsi61HsvTkQEPerMtwFE6tg6+kEFK+x76J6i13TP78GoK+vNXdZCjb/r8+4O8mrV7p
         stieq/i0iIrQ8MHORVBMhT6evC9EnwdPwfrbVdIO9wGa0BtBayzoUNwoMxGAxgbiX6R1
         d1+A==
X-Gm-Message-State: AOJu0YwcfF8rlT3N2zwGKXpeXHcJLvO7uOAkf5s1P6KMMG7eXR+K67eT
	HQ3cky1mUaaVcA+OEQRv3aJRAPF0Kk/0MUFkTTHiTCER2/jDo5AkZmxpIpO/2uktKbufBOklHFK
	/ZHB/ZCCgUc6mkhDRyfwjX5iGvj/Fg5bKRhLa
X-Gm-Gg: AR+sD11wIp2eIriZ9xWd3bcWdIoYrSZwgRB9eYge6yA5um67jw2y39XgkRGDpnFoL0h
	h+0gzbJk973MEE7Ni0aEnrBSg2F+hKbFoblMe1APZhUBHeSvzap6ExvMpwMIjWpqoNv9AXdsHdc
	GbbjF+hyBbiAUunIqCVkiKK8A5b+lsDpCg+6LtrMJNbJtDBaFZv/J5gfqlpJt2A9myXc8uoC2wF
	SKmM2bOlnpBlV828OE4M8y/4P4+S9Pp8FmIoYclmFjg+LMMh2C7qMcndVNjslIHtwwnMb1cr+Ij
	aJdq3cGo6sYLKujyzQUmbttff8H1hzA0UfvnZ8SyMYtIB41pUA9moBIxyWmM3v/ib/EQXhGz2UV
	fUOJLQTS9HBgf6ql+YJrYRKegE7AckEeVKCe6Kv8hTr6jh3AlJPXwiSZ1SdztDooEOVWADtc6tQ
	==
X-Received: by 2002:a05:6870:d40f:b0:43b:c04f:7a11 with SMTP id
 586e51a60fabf-45978ad4a9fmr8530901fac.4.1785914146457; Wed, 05 Aug 2026
 00:15:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805054611.128396-1-eddinen77@gmail.com>
In-Reply-To: <20260805054611.128396-1-eddinen77@gmail.com>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Wed, 5 Aug 2026 00:15:34 -0700
X-Gm-Features: AUfX_mx4ja508I5fa7HWcn38g7PIyM0cD_PYebj7ITnIGghcu-FmOi02PmL27hY
Message-ID: <CAC2QwmL2HSzJEb5hPbukNdqBzvMd=6ObiDrty+6T9tZ0otmogg@mail.gmail.com>
Subject: Re: [PATCH] add: remove interactive mode
To: shrimech <eddinen77@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 10:50=E2=80=AFPM shrimech <eddinen77@gmail.com> wrot=
e:
>
> Remove the --interactive (-i) option from git add and drop
> its associated interactive-mode documentation.
>
> The patch mode (--patch/-p) remains available for interactively
> selecting hunks to stage.
>
> Signed-off-by: shrimech <eddinen77@gmail.com>

I don't think this commit message is meaningful according to
Documentation/SubmittingPatches[1]:

    The body should provide a meaningful commit message, which:

    . explains the problem the change tries to solve, i.e. what is wrong
      with the current code without the change.

    . justifies the way the change solves the problem, i.e. why the
      result with the change is better.

    . alternate solutions considered but discarded, if any.

    . records the resolution of design or viability concerns raised by the
      community during the review, if any, ensuring the historical record
      explains why the chosen approach was accepted over alternatives.

[1] https://git-scm.com/docs/SubmittingPatches
