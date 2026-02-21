Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BD2354AC2
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771693044; cv=pass; b=ttanLe2I3rvQAb/dLV8pJi7ZiVMerp1IfeV7DwU+JpJaR3/IYHccM/9UDbmPAaC9S1WlBany3AO3Y+znMT629Dahq2of6GmknQ+mWZZ1Ve2prbWFjcFcxjXzfkscfPPtKi6J/vyLzaDnh/R4X3BuXSLMyLY1aHFCpctL19hVIvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771693044; c=relaxed/simple;
	bh=/nJ6SqhmB9sRCteJ/pOV7cqfBFUG6Rkxp2RttVQi6y8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kuLpK13YEfwL6ZpW3P2Qy9ZwfqLCKgFcllw/q4dK4vuDBb4SqsivrbHpbSdsFHqefQLXwqufJ9qGu869e83ezeHlerYKWDQKkbYplD1EhKmtsf7F6LX6Zz9hQ9Jy8k5yAmyXlPJOz1jS2NBCpqDaGFgFgNHO81BFafmT4q2jgKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UW7WtBYf; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UW7WtBYf"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8f8324d2eeso52511866b.2
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 08:57:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771693041; cv=none;
        d=google.com; s=arc-20240605;
        b=EnvA09Q4OQYSB1yJUT0ozNTx3xHTUDtz1XDXlsWMzs0Mf3DPobf3hmA3LDWw4y0Q2l
         NdXrg5fFxczudTKXawVCaLz4XAzGPuVEgvZ/vpgRc4kEzlQlLfPbRKf8jwHxNXjLvcIN
         u9r/mG3RMCi5Ilae/Sfye/5SeUkXKSEH4/rScnh+Z76RMTjvvyLh8Oxq2nlahd1cjoS5
         bae7hgudjJSgLj30BpsRSmWF6NK3uIT05GxdNSNJZEVGSk8GGa7dz3k3bZJDvaVEzbtL
         vYEg5Wp8O5RTAiHwhoU61PwemZwcXnoLf/nv8ns7gsOABNaCeOw1Xp5/qvDWYds57B5Q
         fg6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=/nJ6SqhmB9sRCteJ/pOV7cqfBFUG6Rkxp2RttVQi6y8=;
        fh=GIZcwMHKI9cUJX89S1BWW7hJ122J82jV7G+YpQ+Sp38=;
        b=ACPH01oczbUG1ancWIIAowhnG52EN8YYp+iGkFgttVhD+eGDaQc4NuPj58eA0IO4hJ
         ZpwqVvDYjqbelAljqswCqWiwsbqNVfYscQjyn8MRLNt+ZQFsW31l2lX5AMAYjZaazgQh
         /J9ocHWb54nuL2/xFBd5HfGBD3TA8wjkTyISAxAvww5KVCgEifr2CcLYXF1PotS2/MBu
         OF/FeS7g+WFxOZRZH0dAY7e3BtpnslfyWW/3Yw6c2fm4/rkMcJKoUau3acNXaXSztw13
         s7sTrPFggeMvijdln+By0iLXnoG+XhmF/3SSQjUTE53bUMsloVSpQOoqnnW7vmUaK/63
         +kQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771693041; x=1772297841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/nJ6SqhmB9sRCteJ/pOV7cqfBFUG6Rkxp2RttVQi6y8=;
        b=UW7WtBYfV7ULAW9dwv08nMWrjT3wtuvvK9Ugy7S86QzLDszn1MKC9KzMjo1bPNGQGH
         IAGi3RfqiAEy07FtS1AngyqzBA7svgS6GtardEHg9d00NiHHbJWOuCgGoPpOlF7swcyI
         EpRhNzmlGxWqo3WF9eqXEq3LXsxcGdL0FqyzM4r23Ei4DTBHNjNy3KQqUo2tmG4L2sSR
         t+keuMOa2xeoR2d8M/c4Az7omA9pcInhBEqPOBvzCw2BtXiv6wgLs3/oTthIXNO/nNRF
         BdMpKACQA8reTZuU6Z+P4tafoXTreRxq68llowuFeQmHH3Pv/CSFC+jINxLH0s1qqCYB
         H+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771693041; x=1772297841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nJ6SqhmB9sRCteJ/pOV7cqfBFUG6Rkxp2RttVQi6y8=;
        b=YD9p2Q/5ALrHGNeVRulp179ze/kB/0Xz2mkhtxbaDD0lsPtOSeDw1vKDDFz9LdA3do
         j3dzZQydYNnS999dJNlbZuYRZLoOZmLVqxYMkiRCiGghfG5q1TI/tFpTYW5nXzm9Ux3C
         hStFRQKXpqKdD2TLQYWWDC5dMrOH85GaTyEcS1cWQdod5n/4ALSxJyz1Vo/ojbV3Xcqo
         Wqd9gd9yUvsPj8Du44t+V302Dcj/Y2MNHAyzKKnK+vNcfKB2k5T0ZqzpSpqQu8kMpsRL
         +s0Fyg0JWhjfYqEXyVAmpebgGsGfb+Co51ZntyPBT9tlaw7njzHorIdIbF2jN9mcbgUR
         tstw==
X-Gm-Message-State: AOJu0Yx+P6tr7ZYybITFBqjgkFZQhtVDIq0EwwztWaagPCSXM0O05ckk
	YTrcEtwF6VF9bV7MjX7ye+/g96jlMIxIDm3diTMfo3MP7wTxY/jLSLGGMGJWG/Jy36E6/YXF1Io
	fUXw8zX1+UFCuh9U2zzM5yCt++B88bFWnYMhbzHc=
X-Gm-Gg: AZuq6aLW2Fo7wRFHQgiqMNf0WauVQBfVdKv6uwINyLy1LEwIEm7Ux4mLp7bIWBhrOji
	lyT8FQnORAmc5NjkGaEsmYPnSXWKzXaR/hh63QjZOty+QOqsuaikv+Ll5a1q8MlX/HTARevDcIZ
	LhPtFeYhQMOSCOpaQCuorAIM+Lu+r94E7TGpLHkhmK0dmUyhHkPtTmewmEvpPseyd9fduhTekhz
	qxgQE9PFBTrCBOCBNTjj9pqzG1Ti7V8FarShPyNz7fYIrhnyr0ygU0HUUU4ks2WzBR9WuIkYQgU
	EHhNu7ETXo3Hi54dVhQOL/6a+pE9qxk2bE68Y/EjSg==
X-Received: by 2002:a05:6402:50d0:b0:65c:6387:472f with SMTP id
 4fb4d7f45d1cf-65ea4f1aadcmr1181099a12.4.1771693041410; Sat, 21 Feb 2026
 08:57:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lambert Duclos <lambertddg@gmail.com>
Date: Sat, 21 Feb 2026 11:57:10 -0500
X-Gm-Features: AaiRm51PzJYu3MQEbepVwroHQVVXtsy6tTLa38LMh7ZHtV5V1m11VClZCwLGcMM
Message-ID: <CAHU-3nJVDmdU9FGiPTxR=rL7nZEC3K=0Xyc5gAZNCRYrQMG4uQ@mail.gmail.com>
Subject: [GSoC] Lambert Presentation
To: git@vger.kernel.org
Cc: christian.couder@gmail.com, karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	lucasseikioshiro@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I=E2=80=99m Lambert (he/him), and that=E2=80=99s the name I=E2=80=99d like =
you to use. All
co-mentors are included in To/Cc as suggested.

I can confirm that I meet the eligibility requirements for GSoC.

So far, I=E2=80=99ve:

- Read the community documentation, including MyFirstContribution.txt
and the General Microproject Information guide.

- Built Git from source.

- Submitted my first patch using GitGitGadget:
https://github.com/gitgitgadget/git/pull/2049

I=E2=80=99m really excited to keep contributing and to learn more about the
process. Please let me know what you think would be a good next step
for me.

Thanks!
Lambert
