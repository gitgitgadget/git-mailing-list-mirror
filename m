Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66431C28E
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645725; cv=none; b=Vc+iWIRdWlOxazgssU32RsJY7ftKTDBS3zaxVRJ886vLjPCvdzIwyX5DtYrrUvwZvXrTN7hSb3bYaSN8JjefVOFsrHXsv55moXdOYidubHSvXONxnYQZMOM3aFLsq1lq1MFdoqBsMYGrmMZ+mLhCoab6wUzi5eAPtWv7W423kfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645725; c=relaxed/simple;
	bh=XEWzfxJYep7IY1vpabaF1wMqDERuw1FleQEfgk1ucGo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ovBc3UivPWRhnesrqvleitmmKqJOgW6guxzFkV3Utbespvkn85GM2463mTUPhhEWRt4mMyJ924h0QRSphouf/ALv+0sSMVN8z/y7unYJ3JzQSPACwQXlfUdKEsG3i8lra0hC02ePdFqQ54u+N7LgCmlCk0YUvFJpId9X5lgwS9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mafLigFX; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mafLigFX"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b00a9989633so229358866b.0
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 13:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760645721; x=1761250521; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m+G6sJaEt2QbMG0omJb2Xdl4YgPXHl4BXkTxzuzKpPk=;
        b=mafLigFXLQ2INh18tuho6lmPdHvuzKHi7s/zvZ4QSscRLjbqS414vOOY14wYsYB2yY
         qwHRTzqa32vD0UxH7pPSv5ozlBPbD+oy1SgLrcK18ydNh3A6jk3ET9IRJs+h5Vr62wjT
         rOKVJ0hsFyCep5vObfG5z/RJDSDrOHY9GHAVlsHGWh7f3QGZmdVJLXkBoGl4zYzEIgt3
         aYAhTRE7GFbEdGXr5/tzvv+K9CZHEETBFoVFfmIK3jIfasWopsBFvviQC8hFZMFaFfYe
         VIulCdq48hZoES1x0jURIZblqUCF32zQv2CAHXt0kF8ZBvSmBwXCu4tgHBI7nWo5WcKL
         90iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760645721; x=1761250521;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m+G6sJaEt2QbMG0omJb2Xdl4YgPXHl4BXkTxzuzKpPk=;
        b=ebFwUBoKxPdWahdY2JC3w0Tb9e8RuEh3tUb8H7XhA6B/MsabhYkOQnEZGZRSa713vi
         AJlCjQs6lwUPhmNtWan/1rijvukOBvrupjVdzCxAGxxNvXJE+xkVvluoM65sPLNzOL4R
         uudq7yZKOh0njvf5rubsXgkygcHpGorNjYzpkwbncVxx0wk1UAVEG1W6lMOsaIjRN7fK
         9nKWkaDeIMS3yrTabBrSbcKQwqU6hmJw9VnPl8Wvuuu1QbIdxDTlWlxHrFBxk/sWY8ht
         xe32wMnZzWPR5q6p1rH5yMmeppZ0RuNtu/tr9DncoV5I2zwm8qMdkm8hE6cOwMY7GInX
         DphQ==
X-Gm-Message-State: AOJu0YzWtYD7OwimGGrY4MswW/1VGVWdKI3vkWnIOVkGg/ZjuoThrLAZ
	GKxwFuttMz6qW2WQKdSH2X/hOM0k23Z1o+dN9Ad346mNF+p0tpDpUND2r/kIgOcS32551TOv+ii
	mx9IGyoc0BN3XNg/PgzOvRzQJ7blwhSrosjcR
X-Gm-Gg: ASbGnct/yPqs2TVv2uLu2vHygF28xaBvJqu8raTXnYt+qWV2hInpE5ueIPLTfWfAy4Z
	GDACa8vJl5Ex8TCsZu62kKrsJUEDtpJKlnqJbzzkpebBuWCG0YAsR6UKmOe87z/pBu7Vv2O7JTG
	srAMv9OfmaO+ugZdrzafVIAYSNWlSVCmzoGEP6BMctbhNn0wp109YN+4P81Kw6IxCdH1A7xWZ5T
	zu4jxEUhTSVCcqt4mjBh19jIKrLaqLBK91Mq4HDpOdWnZb4mhxFgl7B60udSKz0s0ApvOupHUy/
	HI7xNp/M/ONEP8nk1YNjVWhKTpWo
X-Google-Smtp-Source: AGHT+IGG5B543XNow22v53u/Zi91SQtimG+THjx4XqOpm0mWVDBRKj2ue84DXVOjU2mdoN9XzcFDnX4/c/pIDW5eX0A=
X-Received: by 2002:a17:907:890b:b0:b07:e348:8278 with SMTP id
 a640c23a62f3a-b6054cdd6d3mr511171266b.25.1760645721441; Thu, 16 Oct 2025
 13:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 16 Oct 2025 16:15:09 -0400
X-Gm-Features: AS18NWAktCFc1r_Bx05VuV13eVwfmEoDFqLP4FCSxitCVQdSqUL8GTYy4UPRBto
Message-ID: <CALnO6CDNRw3UcU9UM7rpkAoQsSmfdkxMKVihmoUmUOCv_fpbJw@mail.gmail.com>
Subject: Signed-off-by & the law
To: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Any contributors/users with an interest in law feel like taking a stab
at answering "Is Git's signed-off-by legally useful" ?
https://law.stackexchange.com/q/111158/26698

Having a solid reference answer is usually a good thing, if one exists.

-- 
D. Ben Knoble
