Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146993A7F66
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 01:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791854112; cv=pass; b=DdGZBpC4U5c4GMrQhPhH0Gi0BuIE7dFvZvMemKMsQPkYrsB8tqarsw0FZReO31INCkfmcO9r/xkDdCa7kuA795S6TiePXB+BES+zmz8gJwqXKAZ86Pd/Bc2XRkq1SLicE2iG9SywbjHv51onchMbo1xqdSh3iYKL2DRLm1u69Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791854112; c=relaxed/simple;
	bh=wt/2cEYSIdkIIZO4eqWhZtDTfpnzpmbTPP3DAJHb40g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbBeBQbj8U4feSixX/HGN2yxX2BXIuG43vOxcR3Dcz46lIYL+Z/ZjiwQxAniQdV3BH17yJWuZ8qcA9FSCYFiI237iJ2/Nu5qBim4caEp47qJfaMOKPiT0Aa+mBXBjm4LhuT1wjeW+fTnJT5azqOVGSD58vKAGQQTH73jeHvuq/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rWSrKCFe; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWSrKCFe"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-451a49abd8aso2192187fac.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 18:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791854109; cv=none;
        d=google.com; s=arc-20260327;
        b=FfMk4EbkBJlCexqUyl2CjnO5KJPWOlXqBJmwHNjb9eX9rs9JixGiJ6HoPh96JwTtGG
         gGQTpzSrpQcBXu/EOpimwDsgGC2G24fRXYndnUaOFWVa9dmvlvMLBfamUulO2jrOtdlV
         7IDzNWgvlgE9dpCzPomBMlqXrbyogGamRp5liVd41355S/PyHmBMarZptIEL0/UR9Kkc
         XsuJHBHARLY+HXuHC8+DlR4qdumuz5bNFyePwPc/ckQyoDFhBvheaVVlXEvkI/FuHccV
         n1BGJuTthaL/Nr36/d9kIPPvAikmO1au/uuSILRaiFDuADJ1j2nXPnX2ihqOCES9yv2j
         IyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IRV63aL5BaHaKbK4nljvQSd/IZ+73zUGKApH0l2Qqdw=;
        fh=o+LK9c6b+/LH+mSHPLQOJEcAk/w+c+cl4WlIYS3HWow=;
        b=K+U20NVzFTkSrFMsKuDDMQWcvk3UTrl9G6B9Bszi7wVggSjtcEhwKpzdwa4+fccp53
         A5uEzwOHE0UpBDbvD+Okd/yUd8JsdPCuBAqz1xOzTk0Hxu7WG7jlBL8DxesvCCdcJ715
         R6NkFitIAWjzo6b5fSP9BMDNlptM35fLo5uIjGoaeJOrTXimkG/0XRTgXBLS9tb0qMK3
         78mTEEAX4f6c4+MTiZiQLtCrn5bVcoSJ9hyiqwDNKdFJOXZF3IWN5K+8HbWtsCj71CPr
         8/ylDaiFiQvwHwIBSGaXbsSIXdVq2DclCaIcbSCH8qQDDo62NGs8q/OMEEh4s/bNX9ij
         F//A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791854109; x=1792458909; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IRV63aL5BaHaKbK4nljvQSd/IZ+73zUGKApH0l2Qqdw=;
        b=rWSrKCFe49hVS98EFE2B53d3JWLwHYB5NQYbyUKWaFLgdE7n0hSr5lZPOrOLgD68d2
         PL+cCZWiKKV5jKuJKpI5VmbcA0OKEEGUjU2i2Zn9EqA+TrGsxdT5BAMRh3AbE0dWeKTj
         8bG8cyX1hd1eropyT+TLWvCcJmFh7XamKuxD9zexrrZElomlcwPmj4WM0zuzvXmaHSy5
         MQlXXxQ/Q0EzbNQsUYzo225u2I6cp8BWScOz2DntuZq2C2JuaQf0VeznIpOsshY2LAMG
         OJ+lfTm1Odz5tdurr5FOOzZeo0QLZ0eyMQBLO6LBBK5cTy8A1Q3kumM4rReiDmQXEREN
         TqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791854109; x=1792458909;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IRV63aL5BaHaKbK4nljvQSd/IZ+73zUGKApH0l2Qqdw=;
        b=uLArqpbGFBaRbqDTpNgfRvVcEl76+ZPrurbywWN6RRAvu17v3bfivDBQ6n3jI9GVBv
         6u+KMwq7QKvWAcIHuMSKCeHEnOcDQDW6cmwM/BajaWaPIeT8PqZCJSdU1COGW+9SzR11
         F9PgGpwcsUzKCToDg5hZz2V18bYLw0iqNhwF0ZKlpo6urGQY23ofGd58WwW+m7GQZs+u
         Byrr5//EKRsv4eWNVT+XUMVihucRrqqp1c9Wwo/B9748XpyAL9wuCWI+WwN94uKWndMu
         lmhP1jRi3MLHcWLqqPfZrtq1dvc1sqDUB/X75Ax3/gGTKJZxCec4N1AL75dP7Lj0TTLn
         NOBw==
X-Gm-Message-State: AFq9FYIHhDjxEHkGgW5i/U2r0CI+CzW0UeG4XpLc5huKfWzvRv7sp9er
	LwX58MI3MnXYdsRSVbh7LOnBE3BdG/q6PEaK3PAs2hISAv75aD7EukRt9N8h3H0zcYIVWe5FOlU
	qfAhPR/azDV11u0cHankvz6ZO44UUFls=
X-Gm-Gg: AYBFou0N2I7BCUsHy0JA2pDf+XDdrgDng4dIu3DCcFrM7AnUmqfDixFiDXetexF/KS3
	UuT9Ba+XAqNXbZI2xCD4RpidUsSuYbhaseAuSK07CgM9aY5DDX9dB3Ifsvqdjruy6XEp0kMXIKT
	LAen+RJVyW3DHJSVYwG90znIW5P0Qzh+nCS2izddOSzRTf8aBYDNXAKKWAAH8W5dnoobbsQKPiG
	PdQf7DAHar16biHaKf+oKfSjECgSKY+PcuT4rKuuFMo+NXzVOP/kZp4yRAFTkrwma85HNPpNUUh
	he1wUrrV+YlQECYgQoH8L4Iu7P9YdGk/CCZ6aMFsZDt/Beyxli45QphpJCjl6fRlEBNCk9QS5ck
	hxgOPZcRzM2uAMRmDmyrH
X-Received: by 2002:a05:6808:67c9:b0:4d6:92d4:c806 with SMTP id
 5614622812f47-50c5a6e6b24mr10156443b6e.62.1791854108802; Mon, 12 Oct 2026
 18:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK4AdTSnaAOk649a0GLe1M9C+cYuDa0Nwo54=HT47R53Q4ZdWw@mail.gmail.com>
 <20261012015846.2649843-1-bellacaselli20@gmail.com> <20261012015846.2649843-3-bellacaselli20@gmail.com>
 <xmqqecdu67zq.fsf@gitster.g>
In-Reply-To: <xmqqecdu67zq.fsf@gitster.g>
From: Isabella Caselli <bellacaselli20@gmail.com>
Date: Mon, 12 Oct 2026 22:14:57 -0300
X-Gm-Features: AclHuK_qxesr32gvJDDMy1K2rHha28BU-NtQ8IHT51zq7BiKfIS5HQeQquhM-Ao
Message-ID: <CAK4AdTQNqp_B3kp_Be=2pLuX0bSfK_v59_AP5kHwh2YmfHYo_w@mail.gmail.com>
Subject: Re: [PATCH 2/3] t6500: get hostname from "git var"
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Eric Sunshine <sunshine@sunshineco.com>, Ignacio Encinas <ignacio@iencinas.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "exercise the wrong case", meaning...  where hostname(1) output is
> different from "git var GIT_HOSTNAME" (aka xgethostname()), we would
> have written bogus name in .git/gc.pid file, simulating the case where
> gc.pid was written by a process running on a different machine.
>
> What is the implications of doing so?

If the hostnames differ, lock_repo_for_gc() assumes the lock belongs
to a process on another machine. In that case, strcmp(locking_host,
my_host) is already true, so the remaining conditions are never
evaluated, such as !kill(pid, 0).
So the test would still pass, but wouldn't actually check whether Git
detects that the pid belongs to a running process on the same machine,
which is the behavior it is meant to verify.

Should I adjust the commit message to clarify this?
