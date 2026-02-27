Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AAE37F74F
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772217339; cv=pass; b=FqVCV2QbXgT4Kf8P4aIDBtWoIq+8uGKhGUoVeYgkOFLsnwk2/cSaP6+Kf8FGkx/KsOa0JRmBTe3NaeJGN0jHT2JUxk0HG6SC21dUlU0avR1bLeVVkni+l8OKuesQbtSdGSHsxItVUnbTsXH7moT9U/Wm2QIvmWKaOghGuYYKfy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772217339; c=relaxed/simple;
	bh=faNfOajyQsZPAA5S+NcnQ2aRRYnSjoHI6zXXD8mpV5I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hmA7pYZqK8GD/TFEZyA4dyx71cnDoV6m/s96xT+7pzg3Jx1y0A1sEgOoDx/d5IPjgTNa491Pksh+U2lJ+qWnfCs/jiPdP3G3Voo4rBQSnj2T4CdAJO9Yowfd1jRRY0KP5mhDJeMBtX4Mnrj8x/7wYe58aS4uvxSBTJTAeRS0Uz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4i7g+jH; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4i7g+jH"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506cb1b63d0so28731581cf.2
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 10:35:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772217336; cv=none;
        d=google.com; s=arc-20240605;
        b=B/MTOGfKZMiRjrnOyZ6KmZXt1LQjv6EE4wkYKcx5D0RVFSY98VY4F/fs/QXRU9wiRw
         heukLJBJj17r36+46js+eCPUPbivj1hUcbG7PUnSfzHze95BTC8Js5v7SqW9hm80c2v0
         xaLo2LMnmVmzyx5Ga5aI34hLA4/9jAtKrZ5O+I1LVQ01jf4SMT08jjh9M1Qdtd9avwrp
         gNrrw37eTMGSGn6OmijuK0tAe7FVVlowhBKJBnQRmfJgIP70YzahOEfBDHtCQjaDxZ7+
         ASK65YTX/XGfXa5M3cTgVjUO+MRDMgunoWSp9/3CzGTyMz3b1LRyykh8HJnk3XHzz0TP
         UKTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=faNfOajyQsZPAA5S+NcnQ2aRRYnSjoHI6zXXD8mpV5I=;
        fh=PrdRnbZl4xu9GccfTo/NfCbocg3nfY9l2/uGel4mE70=;
        b=HIgoGfI2eXeCWOxEGOs8EoEiaewG/tRwJXnWsUoc7cJnqoj086d5gVCNTbey6igIG8
         StKgyVYOa5gjH7VncJzsPu0uDUfeBZqb7Abbbjyse5sovI7OBWHE500B4YW/qOXFTdzq
         8EmNqRaO3v2/Iufb1j6k1EpcqT3dUABoJsj70/QnMO14XftSdvmwjsZZLvikY7co8+F+
         eJzlvj4UU2YR5EAnJXEkh5sYlke3mbvxXfzmNTQESulJMtBjpWJouoKrmhsdWnwbtYwA
         o9vDMMM94c+HlHuAdrezALhc4h8QmRtyJsse72lxspqp53g6IqNJNLRh1PuOm5SD3JP5
         HkDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772217336; x=1772822136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=faNfOajyQsZPAA5S+NcnQ2aRRYnSjoHI6zXXD8mpV5I=;
        b=g4i7g+jHUoeA5qVLTLmmAr+tQzHX3NaCpSm1FE50p7NTiOpB+bgkafN3mKcuHjVE3e
         9E5qNfe/Taqo1hlVAht3y/82c9KNtKk/OUglJK+yvF9dXZKJDqzK0JwSDklEE22JnuV5
         4tGFS7ULhaxwkUjfvb45HV8S/FlOoZx3VS+ShrW9aNtMHSl4lE4BqGAT4fPXmKKzHvd4
         Nh+8DoPOO9d6K0cbf/QT3Ripo+9g/IPjfu8QJfz5LU0ZQBWQOSdWmCYf+0EFMUfchzDc
         CWzKQMwNpw/4slda7VN0iwa7hR1UORMeQIq55zDTEj5Flg20QgaBx2nLvBBLdXBkljix
         qjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772217336; x=1772822136;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=faNfOajyQsZPAA5S+NcnQ2aRRYnSjoHI6zXXD8mpV5I=;
        b=EDbz/iI6bnUkfX4Pdv+zRIH579DwBIL6A8nIERKRbnETuJIN5VNToGv0L4Rf2g21x5
         MqsfkKRj/cF2R+EFx1W/5APtSusjGUebZodOPFIt6VJLwoEsolmot0rGj0CAMTKdJSj2
         6igaTm7eab/8+I8GYLz/wTqVTYEGJuUUoyK1R1XC2Yrj1J4DS796XMmD4+rAOwfeWrSA
         LbY4jWC5xjJpLjwXSwUSULP2bAA7zs0ZyU18ek0/8zHX3/0ZOAFrCadApvca1GYOUCh0
         elYMJSNgZ2xy5IGSZQcwMsnovpOxAFA/5wJt2vhQTpd7m9LwtwgIEmxGY1hb13q//n3r
         +4lQ==
X-Gm-Message-State: AOJu0Yxrojft5m6dt2QA7XQ5ZSMT2hnyJuJkX6bGSBscJzlUmOYcDU3V
	GPEgVWGmVHpU/a7v4iY0u0W6SrqYx51xjuCxuAr2VXfArR1gId6+j3CC70TroDKuzVRJ+CU+wJ/
	KZi8YkWLQfXv9gd1MFrNxq19Vs2dMXjWsTGUtrg==
X-Gm-Gg: ATEYQzxhWDAcpkNQ9ejk5rEvCnUWw+LaLYW36DyZj4QD4diXcHy0dXJA7MgSq0Jkpjs
	NWRXmYvoomD5WXKftH8fWfpBpn/OMun2/TLbGnlCPZquGst4AUeLgE9x0Njh/TGaSP1Xei8xE6n
	lP7yPBNUWuUg07Oc88s8U8hQB2sN2pu/KD8j/CoabbQo//+PpI9FInPUOVQhGf+Y2dYqoYOuB6E
	Qi9pKIggO7D0kC8Mg1/Qeo/FaIpoZQsILes61AbjsvPfIdUupH1g+dK9vdpekpNOrFoAVSPJZsO
	3ftvNllR4K0+jxjKjVuMJs1f4XOQCpRylJgrjw==
X-Received: by 2002:ac8:5a83:0:b0:503:2f41:aba3 with SMTP id
 d75a77b69052e-507528e0294mr52013451cf.67.1772217336418; Fri, 27 Feb 2026
 10:35:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Francesco Paparatto <francescopaparatto@gmail.com>
Date: Fri, 27 Feb 2026 19:35:25 +0100
X-Gm-Features: AaiRm52B2693nmZNORGSSAqxLNbhRApVUCBkhr0KMNh-FLYK5CU0hawlM8tbrho
Message-ID: <CAEaT9_8nL6v0i4Ge=aG8o5abZXTbJ8EwF4ekUfho0MLU6zi0_w@mail.gmail.com>
Subject: [GSoC] Introduction
To: git@vger.kernel.org
Cc: christian.couder@gmail.com, karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

I'm Francesco from Italy, and I'm interested in contributing to Git as
part of GSoC 2026. I've confirmed that I meet all GSoC eligibility
requirements.

I've been studying how Git works under the hood by reimplementing some
core plumbing commands in C, which got me interested in the project.

So far, I've built Git from source, read the "CodingGuidelines",
"SubmittingPatches", "MyFirstContribution" and the "General
Microproject Information" page. I've also enabled CI on my GitHub
fork.

For my microproject, I chose to replace old-style test -f and test -d
checks with test_path_is_file and test_path_is_dir in
t3310-notes-merge-manual-resolve.sh. I found the instances using git
grep "test -[efd]" t/ and searched the mailing list archives to make
sure t3310 wasn't already taken and to look at past attempts at this
type of conversion. I'll send my patch in a separate thread.

Beyond the microproject, I'm interested in the "Move global state into
the repository object" project.

Looking forward to feedback.

Thanks,
Francesco
