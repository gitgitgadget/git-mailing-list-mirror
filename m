Received: from mail-vs2-f6.google.com (mail-vs2-f6.google.com [74.125.227.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF714C33FD
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827454; cv=pass; b=SvRuqrviiUoU+h78PBcd/TOpxNhb7hMjV2sMo9uv0vvi5RcV0xWzOzT9uRkf50siekX0wc9s3hM4w5zlTLBZT3nkX6e4qlBR0GA5+BjZP5QhieE/q39Tp6c1/D9/1RSS2TzCrwqwjPeA/2g0iGsSOMWlK8NPkYGkkrT6cRR7yCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827454; c=relaxed/simple;
	bh=vdOrl8j9alpRzEPRsFYpV7snF/nVcuPjG1aLzOi3wxU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XEqrEi+TLjSq3wYYRQvWdKmzgonKMdwh29GPDUf6ZG8BO+OhDbNhRStifIqYWxc2Cvd7Lnc3AHELrwrdqXJ2jzsEhcqaCpnkyHR/fzL3xdhwhd8UqS7UJ7IR8zQOuxVRouXDhma+R/Kdj4lCPfWqynqk5DHWMQNkmDVGbS8dInM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kB56BH8C; arc=pass smtp.client-ip=74.125.227.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kB56BH8C"
Received: by mail-vs2-f6.google.com with SMTP id ada2fe7eead31-7c02963ec8aso634475137.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 10:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791827450; cv=none;
        d=google.com; s=arc-20260327;
        b=AF8DBlf3JuOPuyuP7gHvF68V5AQwJVwdSkB/KP7fEUTYp+QWHpF7lC/3Ac1WMdrSTu
         ZvU3Y6JJBITomHqex9xX4V3TSLp7TDzaUI7Mx0hhwpBHdXb5/4sLZXBiauDD5dR0mdJ8
         QjdW1s8uZCiWkjRrKfSuZ9DSmPvmhgstwPbQfWO9iCcBX2u2PkiHSTO59gZpJVdrofRk
         ZcLni6IDL7r7u2dvM6CJBYjVkV55plMYCi9w1ttucj3UYF/tePNnivduBoUWQBfVig65
         cSsop0LrSrRhQss5XwSkAdtaykkODPbnkU7Y/8ixwXRNsqitbRsbW1Afa0GczQpOFe1H
         YaCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=vdOrl8j9alpRzEPRsFYpV7snF/nVcuPjG1aLzOi3wxU=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=meHFmKgbA5UDEoDZEB+xcEARUee+W7+npdjn+iCzr8cL14kSYZjvGvZZKp1OCzgkOq
         zVap0/fCPGnnV1PN2/9VtG+5MO1xKxKU6YcjkWdaehF1EgWRd/XnhVrI40wJy4Z556F6
         sc89gc4bCUxvRU+S+KrNCOVyrI2qPOlslaFkfdhO+f5IIdBvBrCmv8lmiNCdJmm0X8KV
         3TN7rqkURlXkdjk4+Yj1Ok6RRjE8afNSwJojghf6+/8Gd+PtEvWbRirXLYRNxdFRhaJs
         bz+rZtG5EQ6ZzpyaGdJOiDgiB+lvgE62urtToAvztCpAk26uhbzrvEXY4uiqnGilXLhy
         zH2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791827450; x=1792432250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vdOrl8j9alpRzEPRsFYpV7snF/nVcuPjG1aLzOi3wxU=;
        b=kB56BH8C1c7chq8RHa5YzbI309LJHON82/mjbaxxxaGiOyEtHdCCFl4CkkOxG/PrQt
         RGQGNLikY8mA93feUswywNjojAcidAHsSnFYvidVoQB61ZZnwxlqHjjTmTnL220RsZcG
         YlqhBbR3S7XGhNrjJEx1QbFNivEzwJBhSsJSHrknDlDAzugaAOigZ0Tg/FFklFOsyHUM
         JBtOCVgZQmA0AMD9S7f0IpBksTeIJXKYZXRkFRFF0yXS/52npvpbynDHd50REQval5Ns
         WyDoni70AzdUcnB+W1senw8ZM/4t9d5UlY87HkcX/foS/hCDazAmlH4cy0G4hL5wF75T
         3p0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791827450; x=1792432250;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vdOrl8j9alpRzEPRsFYpV7snF/nVcuPjG1aLzOi3wxU=;
        b=NTJYhSn/7l49BFGwWB30ik1ZqnRgBxn3QmkxJjCuUdMIsxU6fvDfiZMhUJMVmgEnsM
         TJZOmudDMK2j8fQSVvbUHMT/P9m37OP9Qj/vcP/28c5ZVaSDfB9MbPsUZKebq6Nq04OS
         B2zEzSE1MXh/ObOZs/4sauG0osdJoZmcA1vtdQN5Msmr/dGk8MmJznvvKA0a9KToqYKh
         1dyuqSPFF4L4PpWtRYmCNv+EK7OTrnjc10jnDeGjobti0dMxuU0LDcPwct4AKJhb5J/5
         iN9L0oJymZ9CCkhbrHzNbBQUZEXTvnKzSm3lNB/tdO/QJxrLP6z7WJRnS2AiYQbYc8C/
         oX4Q==
X-Gm-Message-State: AFq9FYLFuKAhmoogRl2ZVT+sNVJgGaP0IBQMQJl+dM0tuAmXgsncsgB3
	+omFSdFKgcZHRMiTnqRvPKdyG+OCCY75NMCVUWrYd7/NRMKGRXx7etDrlv/KuWDSuIvmzjguy66
	kzQUMC4odUs3W1ZdJ/KEzlUSuX5ASEYDTU88KgLcpbsOf
X-Gm-Gg: AYBFou0TItuXT5qzCMAHmUiC0+5Ge2urszmT5z70mTW4/V3/2SKGEObbk/9bnWELYKA
	Jp5fXXDH+yQYbndDwra3waP7jc5sUTLjbiWIDy4+7OZ4zfpVNxI+lxLcTqk6Yc9MBkGaIaSSD9x
	4enw5OIQ1Z2PdKGHVLfiYNBB76DvSypc6dVpdKcc7t7Wccnv/uXpHZOOf+DmsmrUXaHNobtwlHl
	T0ALnhP395v6nPqZOvCQXCvwB6vAzN+ra/n/20KFAvV8a2gILvYX/SauHUpib5HCyavtWiUxSyR
	eZC0GdmVV0uGxssrH1qmh/Nz/vowu4C8r/vQ1R5+MheenLATd2X/M9S4EZvdmFV8Nh3apHZR8jC
	RoUnNT/8jq4TL6xf4NQw1Z3c=
X-Received: by 2002:a05:6102:3753:b0:7c0:b41:145a with SMTP id
 ada2fe7eead31-7cb373b9ac7mr2346123137.30.1791827450435; Mon, 12 Oct 2026
 10:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Joy <cryptocurrencydiva@gmail.com>
Date: Mon, 12 Oct 2026 18:50:20 +0100
X-Gm-Features: AclHuK8SFffAoKrG51by0--mFN_1U0wpDncTImfxrG-hDP45oBYKStzhkxoI34c
Message-ID: <CAKA8Uu3f6jfR4fxC+4uBcSw+4E7jG-Vm4E2jd0XHgwTryzA1EQ@mail.gmail.com>
Subject: Outreachy Introduction and Interest in Git Libification Project
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

My name is Joy Gundu, and I=E2=80=99m applying for the December 2026 Outrea=
chy
internship with the Git project, =E2=80=9CReduce Git=E2=80=99s global state=
 to enable
Git's libification.=E2=80=9D

I=E2=80=99m currently preparing my development environment and learning mor=
e
about Git=E2=80=99s codebase, C programming, and the contribution process. =
I=E2=80=99m
excited about the opportunity to learn from the community, contribute
meaningfully, and improve my skills through feedback and
collaboration.

I look forward to participating in the community and would appreciate
any guidance on getting started with the required micro-project.

Thank you for your time and for mentoring applicants.

Best regards,
Joy Gundu
