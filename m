Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF8E288C96
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782048792; cv=pass; b=TaYRVqs6ezWhZ4VgYFpcjSzGybQYxjn+pr9Pt/GhwH9S8EBGVN8tcIdZodTbp/pmOh5bpZ1J3FPuZHhilljPEyTDKoA/AWpKzizGS4BjWQklXim5i6qnCa8bY9PNQWzBiBO1RVY13pWeIqTH62/ZxeLG7/hMpAkNUAmjJR3ZEC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782048792; c=relaxed/simple;
	bh=GEHm8qzeCi04Q+SH9WfP5gsOaxqU1n8eGte6kuG3hAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5XZ7WqZAjZ0DEo3vxavNUNjRpkWUupO4IInmf+P9Z3y/tgIQzJJKzt2Qmv1Njiepqrot/vpA7exNLa7iQEzc+Zxven8Mw1x49I/GJ96LZYV9kwB5zQQsOgHeN5c6oCWp7lKx/Z48nBQjmQXaA2clg5Z7vTjw4pFjsa5aiog5bQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwwsJfIw; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwwsJfIw"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-697573b16ccso3507850a12.1
        for <git@vger.kernel.org>; Sun, 21 Jun 2026 06:33:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782048790; cv=none;
        d=google.com; s=arc-20240605;
        b=WuqrY6P5t4Nl2cqdVUaGmH6FG58dS19stWyGzziFYIhXVFDm+aN1kyHJjkHWwu9dNc
         cLeAxrw3vOS8gH9l8aPLW0S+Jp+TPyHYeVVdsVdLYDzvCT7GeUhkwsSF/yhM7nGKY0fn
         4pgmFb1fQQizO5QB5wd/dO1yfU9yBjKufRgGI56c2NVgfATTew76oXYUAwXZKJlBDYr0
         IAULNth1iZSuMU9pYqlQ6kzsbb4TO0QhXlJ9wHXoAnhLA3epu2UofI4XuzFM6phmHrAb
         OHfFBVB85gnwRdnhNHRzOLTjwNvOaf8ohQxcnFMV1KTE8BAg+CvpqKUZzzFPYWzuI+r5
         tUmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GEHm8qzeCi04Q+SH9WfP5gsOaxqU1n8eGte6kuG3hAo=;
        fh=mZixHP2Ewss2SFJr0NJjUylVjNy0qV/BrWHw1aJTsFw=;
        b=hed7jzMlXBXUcYDiSW+Glsb/d3rSgRFgNBZj0JRjSWm5jmUn4ddn/cyy4jKvjKI9UF
         YWWAoTgCJ50IGzKxJ5g1NJarEQYbtn85UaoJ+rn98JJLeStJAU5w7NUukO7EUMmI/hLf
         qEPKfXyXtVv+HHcfJZK/3kpcBKeTzjG4LFQM5kS2KeAiPkrLeTfdAvgLo3Gb/pFtuZxa
         5cS1CEEWS5Qj2IIFFZrqTrPcxs0T2tXydZ1ygav13T1HcAmu5YauFMNOlGQVPlSjSNa0
         e4wT9GGZYJbZv85NNG12b2p/3wVap7Xhw2Q3cfJT755u5reAsB5KND/tCv4WpPtLA7dO
         Wcjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782048790; x=1782653590; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GEHm8qzeCi04Q+SH9WfP5gsOaxqU1n8eGte6kuG3hAo=;
        b=CwwsJfIwv3XLEGtiriz9KWbXxIrv/dd45HGnDTj244ismGmAJwX16DMNESqAZbwroU
         /6pKCjtkjwdO1wyAihDG3qHNCGF2X0fFtTDT5o4Wq24y/J0/NESXb9+DqMJ0QSIAyiRf
         dShFdC34EBH4yyWhxsTbjqJbkAMKiOj/iCViPjkZIx774DBXSWMAtyWmbusjVeyBDele
         Le0WE61ivGX4nDKJvezF6Df5a9bXmrTLARDhbo/yFktEd0plbqpWYO2rbK75iUzv44vE
         p39J2krwFFvA9EWOEyF/p6UtOiHLr1z6oyT4V0+rRK5IoY4jvAn46JTNpe/CQI/ckIBT
         iECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782048790; x=1782653590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEHm8qzeCi04Q+SH9WfP5gsOaxqU1n8eGte6kuG3hAo=;
        b=FdFilqhjsd2dHYOAkNnfqF/qv8OVhCHK0kp2SsaAJeoRGcgFm/gps2Q+dyPptOr0bT
         6ZIwqKCAXWMgSjDbnwozXzvJqK3N4LrL11ysdFrc6HwO/Q+GCuSNWfGIfTyeG4NU6ndD
         Ua+/5JD7EP5Zuh+8V0rAVx+Aru0neggFMH4Lwj3cGqFyzfoepGFPqAIUvW/qVQq9qkUL
         i/LRhmm58JwSTdcSylJPLpI+ZXZ58fnFlCxi2tkCbQjZ7HEz6U8Q5FAKJyjfX0qA22KB
         P46XWO6KuAkpzZKnENNSDYEYdLuwEnUrzy35Nd7lz36W0StjU7tf4Hk5925NCLq1HgTH
         kawA==
X-Gm-Message-State: AOJu0YwUTmLjZ1j4/o9Hd8lMJeEhjQpdEvw44IKE9cnNd/rxDaFvRnW/
	xK3czlULODcJNb3aCeGqhwnqucRONlPPWda6QTpeQHQ/NCiIApVAu7snrnXP5P0tyJw63dvaRg/
	bhlwF6QInqzk7Ivc4Tin0bwRlvAZ2/2DP/9fR
X-Gm-Gg: AfdE7cmECcq1W4b/z710Wd8xpriJCBwqnRKOKX0vZQ269Wba5KUsi6ccbsAowDUTW+z
	BKrc2VxVHX11gohteTm0mZILq9ApV3yUdy/Lr7D28e7KlGP1QowlmD6TFFmdawXn7aFS39q4+3B
	4aQilpyYMzl+u3+7atXRqfV/0AAXF5IJyE8bTKAyjRV2D4jIDpRLbm6H1joEY5NGvC5CPQxiJTm
	kb6th5fjyVq2gOrsRZoGiR3s7jb7MjfxPL8jI26URTGDx3n4x+WYP9UQpTeooIUb0tq1Gnj
X-Received: by 2002:a05:6402:240c:b0:68b:31c5:86f7 with SMTP id
 4fb4d7f45d1cf-69702e5181fmr4478870a12.16.1782048789564; Sun, 21 Jun 2026
 06:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2339.git.git.1781459539.gitgitgadget@gmail.com>
 <pull.2339.v2.git.git.1781995570677.gitgitgadget@gmail.com>
 <98718401-9ff4-4b1a-97c7-71f8b6639fea@kdbg.org> <CAHwyqnWM8GpYWOLdMtaF1YJ9mTRBtK0NCQeZE4AorO==7Mz2tg@mail.gmail.com>
 <c98bc105-f868-43bd-8268-52eb56e5a7c5@kdbg.org>
In-Reply-To: <c98bc105-f868-43bd-8268-52eb56e5a7c5@kdbg.org>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sun, 21 Jun 2026 15:32:33 +0200
X-Gm-Features: AVVi8CcvISs3hnBeGySUBaQoZRPdVRhh8DPVyc4EEDrqCofuEoKssyx8b3JtVXI
Message-ID: <CAHwyqnU45DKGMfhJ1e3FmaebRUWkYb39pojPU2TBgOEDvgv-DQ@mail.gmail.com>
Subject: Re: [PATCH v2] gitk, git-gui: drop msgfmt --statistics output
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Same series or a new series alongside this one?


Harald
