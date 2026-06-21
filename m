Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57C44C6D
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782047770; cv=pass; b=P8itCm1h6btMyy0iPr257T15B9LEeWtjPGZAHw5oWtMz//y1X2PvFKKm42CmMozfNq716f0U2ygSvqlGdUin8EmrV52wOAqWbjLvBh2canm99yoxPyl0u7ZLKAkIh+tdBV0UgrO2xCr0Kqxu/M9hAel0eBVW0Zf4n2hKm4Z9TJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782047770; c=relaxed/simple;
	bh=eiEfnZTbVLIc1SM3e3mONMdyI62/UISlZZJ5B3QYqQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLhTfxHKRUBR7ANPuKOIxKVJa1sdMkbzpCZp4riI1yy5gLvg2h9gqi+gOpWVQ1sAJW2tN1DEKoc9S2e+uyolz1iMENZcT3F610FIlNA1JECpcAQColUcmcnDOJ5sAfMl2wyGV3Y9DI6uOwGa1nwmK1c6oZ93iH5yzCp027x0dNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdkuUlgL; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdkuUlgL"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-695f6438518so4599420a12.0
        for <git@vger.kernel.org>; Sun, 21 Jun 2026 06:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782047767; cv=none;
        d=google.com; s=arc-20240605;
        b=CO6B5zfCFt5mbxpT5GXwFfa1KANqiIoVOWnr68zMBSpX023L/dUaPtIvX+ZzjEBRQa
         Hl26M2Dqn4CVAJK84NSGYKv/tHiM7QYT40FgkWrxzuRH2Ly0+dPqKziygQurDzmGok0j
         Mcqg0ynTIqfMA5spQYxXi926sRsU08MhY/7liT7dF7V+NxrAfDaCenGxxNLBsRmoHYaK
         bQflXUHpUWoeefwY1/1SozqCCM0WdYxsi7qs7G3JOVMJwo3zcLzwa+fyfHBHBgEFPRru
         vZ9TVA8iIn4uZhucfHauxncUbOXLBBvTlsVu0PT0f4YarGUkZ1BYyJM4etswZjmKbXRA
         hJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eiEfnZTbVLIc1SM3e3mONMdyI62/UISlZZJ5B3QYqQQ=;
        fh=mZixHP2Ewss2SFJr0NJjUylVjNy0qV/BrWHw1aJTsFw=;
        b=BiARWknE6ZrsU8Wn+zrQ4he5zuJ6p6zXY7HZV96q3TVp8Zy5iCSnkrzvPG6T78/T1a
         VD/Iany51ueCWeNlxUvrzbcNOUkE3r4Nmcq6MvJ0mMPXIc52hKnYCpGnxvhq/AGAkqxb
         LpZfkLX7svLcCyxHbjNUWUp1OqkBQE4E3KLGSNWnk5umuXEl8lmn6Wm7IMxG+q8Q314j
         PNzThMwC+nMqny5V2yBS+UKLJ4yAd/FryUpHY2JpBICy6lrkJvc53c9bKym8ZMDb5T23
         0FON9ya1E2gU4vrNNIhR+aWLXA5u9WnKDr8PL8BsJNdqIzddOb3IY5t+4vHPFGPXt24m
         Zt5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782047767; x=1782652567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eiEfnZTbVLIc1SM3e3mONMdyI62/UISlZZJ5B3QYqQQ=;
        b=NdkuUlgLgoGhUH/qLlWoc+HB6vdhUXJStvtPmjQGrdDo4hurTYql13MRtuwXhdOhZI
         izWIho5kzXazWhNY8rSVI1Bwu6coFw2FVjsrYd+UqzM6fKlzTllby6vTiDJI79QIY4dC
         /mZOcHuZcbJ2hEHvdn5JzS0wKGG6MGFZCwbCPi0fQyw6km2iAtgyaYxZ+DG2JRImGNeQ
         FGsmGCw8g5oJXcxCfOUMEtdn2qlM/qutDdX3h/misX7Xqg5w8i2uZRU/PkwVYVhSAQnp
         wVhyNGx5t/yZQGbCY4QidqLpt1NidtDCAwGugzBlHsSghGTUSP699R9xtceAZK6xr/p8
         l7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782047767; x=1782652567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiEfnZTbVLIc1SM3e3mONMdyI62/UISlZZJ5B3QYqQQ=;
        b=Pc/J5Hy4824VjKdKPiZX7EuLlAzIKarhfz39Xtm5VOmaZYzgiL32qhub2w2k7nxr/A
         WpxCORB8NbXxm5LxcL28DlyeVO88xEtd9NTiubcvyBt0XGX0FWir+fszRZJ9gHcgTkVd
         yR4qX6lNUQknwz5UJoSlECp9M4O0FJx5BfQYxkFED6vYsdwCLb21i1n4SB2qjD4+38ck
         uSP3jEdQjMwYa/Ir90WeeorTEjTXTFQq54n5ojCfEmaEiER9y2BCqMGEi2Ph27keK/Ta
         FeYuTCBT4QfnRO9dnShRE94VxUUkimh99RdqXawbuKzprUd3B7cpelGlvJW7uqXPQb3n
         J+lQ==
X-Gm-Message-State: AOJu0YxsWce2o3aUbQ33auORROVS/KCZMJZGa9DTcm2NnQvnmJocnTPN
	+k47Wr+AKtReCDCKa4VEu+sOjPZf5dPRXfOoB2tx/Sn0v7q76Oqo+Od3oAhRi+Wr+5lqyKDqCVQ
	VZKG8fmrYCB1OIoQ7i+3q+BJwyr8WVJw=
X-Gm-Gg: AfdE7cksnMZUSapl88TJU0ddUdG4A9X1mSmDSDHkQ50WK+o4zWP69ZXicGqgecY2Cky
	Iq1x0eIlypiEOLSV4Qxy6+Tl3yMi9EnOjdhSfxkDB12jXwZFbp10v1my8ddL/5qyO2fu6ooCg3N
	oLXJuKzAji364HoCf2DXdu84hrZLU0kUqThuMko9tddg7BB9LQauWJunFRNP8+vuhMF+icuHZsv
	oik3B4VdMh4E93bl1NAJ0FdQKLESbTKWKZsqvvoMBBtyFs4HeZW83xF/kzmfuMcIxbw0x6x
X-Received: by 2002:a05:6402:43c7:b0:68d:aee2:7516 with SMTP id
 4fb4d7f45d1cf-696e52a62bcmr4812907a12.0.1782047766944; Sun, 21 Jun 2026
 06:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2339.git.git.1781459539.gitgitgadget@gmail.com>
 <pull.2339.v2.git.git.1781995570677.gitgitgadget@gmail.com> <98718401-9ff4-4b1a-97c7-71f8b6639fea@kdbg.org>
In-Reply-To: <98718401-9ff4-4b1a-97c7-71f8b6639fea@kdbg.org>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sun, 21 Jun 2026 15:15:30 +0200
X-Gm-Features: AVVi8CdkgE4e_JgZAWfhpwye-eL4-ZL6j65uPM_dclN3ZvfGDXpJBkBb9BfKWlY
Message-ID: <CAHwyqnWM8GpYWOLdMtaF1YJ9mTRBtK0NCQeZE4AorO==7Mz2tg@mail.gmail.com>
Subject: Re: [PATCH v2] gitk, git-gui: drop msgfmt --statistics output
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Johannes!

Thanks for the feedback here. What do you want me to do now, should I
update my code or you are taking over the whole thing from me?


Harald
