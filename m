Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5890B35B63B
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783881102; cv=pass; b=lUYGJWDHSMrSEV1Z++4qxCymLc/PForH6QQyUcXuFdR/6dEUehCwvj8tAt5cZj4aEMd+Td38Vwl+k2Jf7NHOZWwcJ84/ITTcpbCGrvNl2+AlPR01zn4XQMlNXxGmrCjCfbHGFkdUt4dhM/nNgCXipM+NflzxZbwPOPr8GB8Y5Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783881102; c=relaxed/simple;
	bh=DmlOOgf81/PuHE818uyWpleeu6UM58Z8GqAcaKV21xY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWuaYPKsbnxfPPPULyfoQxmGvNLPU2N/v7GMvC/yH/JR7uKrw2dnDWQrDvpe3iUhrt/iSDS7B3GcVbWrZGCZjbvVIqNBitJq4E/wkyaPv6PpokBdkdtQ7etVBa//L5ErqkV9Zwqd+oUGHx/O9bOna4sTppWW6KDl+5FEmY5Bz+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=az60igFy; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="az60igFy"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6976b0c5adbso5003058a12.2
        for <git@vger.kernel.org>; Sun, 12 Jul 2026 11:31:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783881100; cv=none;
        d=google.com; s=arc-20260327;
        b=d9m7u2X1Fy31Ug037bWlOBgIR0IeIwjYhvNP7W400k0dvn4inOMn6Ae0Gfjp/Ti4W9
         wUSreKGB1mwJLm1OXNa8i8bdmiRAllk9oBg2HkP/jz/KDkujnBGknSdF43YmZpu4xbu1
         ePjHj7M/Vxqay4Yi4fzFPVm8KQvuaMLR6N36RgAz32O+P6V03xhjzhJfW6Mzz+daoxbh
         iMTm0hv6m0OzgZ45mNkAncWJk67oycdY/uCtwRhYpOeGhaq9q3vHsYuk5JSlR4HYIpwz
         kElzQHIRDdRpJiO+pHtG5phLwkZNMfSEJvo/bf2chzCbuR4eJQx657Q39D+IDY8OvBnw
         KLYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DmlOOgf81/PuHE818uyWpleeu6UM58Z8GqAcaKV21xY=;
        fh=9//vnOOQ6hcm9MxHvbCLU612IhMrZGw7Wzily2YxMK0=;
        b=VX2bYbYbazP8iwxrJADPM8llsb9VVjbdIkNgdw7oF6rjLQj7bQQR5+SmJrytCqXH07
         ffD44XapCLe2O1iUrhauyxcehzKshlJBplt0SLRske/5b/VJI8r4n1lxhUpXzydN+oN4
         XQQGHdGBOvMbGIFJStzztgwjKEmHjV9295yWfi1AvF8TiZYjUfRUQgNViSVzoJ3JpJg6
         B+O7BLRJsHxs+u4KFhZhnHd19MeetmGAdtGgh3AXxOjmZUafVvtzPrass5UNor5S5tfz
         rFYrhWTfopCEr0qnlvsXTYSjMcYodP9F+cpHTjRgu4FJMUAOD/kE1KYnjYvp3k3yb1eM
         lOyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783881100; x=1784485900; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DmlOOgf81/PuHE818uyWpleeu6UM58Z8GqAcaKV21xY=;
        b=az60igFyCoKwUpCRrMRbNBOARuYy6a3WtGbsSO5ZHheKTQvRpK5ANNUL19x8U+PNEA
         bPOGjBiC7afTxDS3m5Hpllgw5/4XEjuXb+r6sH/1ugwMMYLcGDDSx0fjKXDYemPfoP4L
         5ofmFr3wX8thf1BvTIq/24il1lhnaPHzXj7/1zi1sizlbDOlB2Cy5c6wdxO7/FUuJ0zg
         cdOEXRxoRgAWRUSvUqerBNI/ECT2bcm8AobYkI0M8+PsCmm7VEifa10VB0FwTe5OMe0I
         4KA3HlegpU7r6o9IMj3/wkT2B7iJG0WqV8Twe9Sa2XGLbKQvMukHrVVeV/QP/UPF21s6
         gJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783881100; x=1784485900;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DmlOOgf81/PuHE818uyWpleeu6UM58Z8GqAcaKV21xY=;
        b=pBezekRkq3fwyKE6Rubk8UhtLN0RfRZPIZdBIqmlins9iVub+36HEGznffwLgeqz8T
         Dzd4POQZi2Xs4+QYYpKi9BMg6pajMUCNO3tnzYxuFyZspKIKB6y2VGx+hcCG7QX9wN3d
         v1mcX25w4nG7RHWZhaAQVPeQ+QklHKr5CuJ9mdWg4561liwflKG30dfmxr4OKE1eRwrl
         R39/k5U/x17lDJlMxJ8tGDI3XVOnt/0rHmMrXodRfBcm7CoTReqkHo1vWaYKTb9v3p5A
         mM6MLixPnAvkbvdMh2EIT6tRWE1u7SZ98L2i/LMsF+wnKvRtPHVdoPkfXnWphSWbUJMO
         /yaQ==
X-Forwarded-Encrypted: i=1; AHgh+RpA1LxhWc8p4JEgPxv/wgKU1uy3aFrRrY0v0B4JBFtw6NojDgaAn9+jGPWi2anXJlHr7Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsSlbuSfzuRQzAbXMgKdmiSjTomVIKulGsEWorZ2tTgVAHBNPT
	IkcdR6uAEbUvzwjTp0bZjUIJf16OZCerhYxZQSLRJK2+cVuS1HMtnxJyeDWfYRu4hE+I6kW6Y4L
	hUzB5xs3uR/GrFP41xf+/CfrjPEeVGFM=
X-Gm-Gg: AfdE7ckA/Xw9SiLDFjHtNZCJ1X+taY9oOtSwC1GYnaA4ER09x9UDQtdAtI2yTyEDypQ
	gz5Rqtfy5A8Mj1i/HcHiERI70q9KKnNWCZe7Tpnf7rLW2ZiDP00ErTiLKkBa4K7UjVntWtD1+bE
	gLZapJ3DV5ksNo+elLONj1u7P0jmjY1Gkx/eBpabFJChI22ktjjVjqyDTGZN9kGpnsQYPATbrbH
	2AlH9xZ4HgM4nOkCO+ZE1wm+b0sFrVi9egz86sKNAoUj00QGDHhz0gX6PCbipLr9jwLKlmD
X-Received: by 2002:a05:6402:3548:b0:66e:abe5:ab22 with SMTP id
 4fb4d7f45d1cf-69c5f0babd2mr2641879a12.5.1783881099543; Sun, 12 Jul 2026
 11:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2339.v2.git.git.1781995570677.gitgitgadget@gmail.com>
 <pull.2339.v3.git.git.1782053803.gitgitgadget@gmail.com> <d38d233c-a7c9-4457-96c1-bfb75af71ffe@kdbg.org>
 <CAHwyqnX78ePVhiL+_T3FzCSA5oGaU_RPvQj6YP=s1WyULg=tdg@mail.gmail.com>
 <40b7eee4-6b45-449f-a3a0-0ae415097041@kdbg.org> <xmqqh5mn4eyp.fsf@gitster.g>
In-Reply-To: <xmqqh5mn4eyp.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sun, 12 Jul 2026 20:31:03 +0200
X-Gm-Features: AUfX_mxmjfE-lahd6xKp5mDqllcSdv-0w7eE-srebD5dyag75s3r8frcn9BDsBw
Message-ID: <CAHwyqnWsyWcggBBEZTfe5Np=xEAxe6iy+pekvUrsm4RY3VxTHw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Silence po catalog output under "make -s"
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi!

What is the status here?


Harald
