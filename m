Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793262665;
	b=IHf6m/6nZZO2dmtmWSrWEdAETWKMYxuDTnOF0Oh6dkBzSNky8S+RaYHwzbF/5oHd6Q0k
	 iiqZYqcMuX9ynDf2PcvxuZsxqIQOGrPPXYfttTB+iYXXhBBO8yTQNmVs96ZictI1T3zR1
	 0FVAOZUUxIs18Xj/3AKga/HjKoKOJ1htFowtHVAUc/iDOnDBIq4uPDEcDPsbdNtMSeEkW
	 agOWB1LiiDCrqpxWFv2Qx7YJ+bbmedxkRlEzexoE2+S1WBwtfvVNgw0cR5v92A7tTbebt
	 HsQQmFNUO+f9m9tSUnay6Rjmu5IvvObICOCNOfZxk4a8n2dm8MC9/59yQwcWiwe2G6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793262665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=iTup+LbI65HmX+F0ajq64fRnVNFNt8p5D/NFVGWrCWA=;
	b=MGz3zopBgeM0697yzN2odF2bdMe78EO+3e1HTCi3UKvORN8S+nW/ObeQFOsGo/FMORPu
	 j2pKx8sQTm8p7v23k999jvLj71pJVminwEZawIrA1g5eY42Q3pqbYEoc26jb7gy4/waWJ
	 kzLgPwP2UeSwO49TLRKeVLLIsI/u3cmuQ9HckwtI7jNmCJ/o8KnIqY7+s0HzKQWYocsMQ
	 WBvAZDe9NEyR/U1WVgrMoGq8XRSkAjgGbCHZNLFxSmoMwTjvXjIXKmLoTIkF4bxwie7pc
	 tRzQu71PIUxTmxXHv9546N3luHZdTLJCAjDm6praapvUfW7ejkd4f0/fH/j2TaIL++Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bww9/Ac0";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90AF606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 08:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B90AF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bww9/Ac0
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6afa651700eso2769551a12.2
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 01:31:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793262663; cv=none;
        d=google.com; s=arc-20260327;
        b=P6qpHAX+DxWQx0B5eRAG0PZRYL0M2Xtq9tupD3hE1j+MIASF23ziEkPD8DNcfJbzWx
         gGOIbqIPt0MjdXOUySO1hWQjR5w08N1rCzHAl7/0xgxHTVbxslVzhoklWTM6T8h5PQoJ
         lCjL7M6s/y7UTKtZ1eHvwf1cyTIesm4VCXzPwgbxFwmfeWE7T6kP+YjMt0uSrNUjo3mj
         escnTiScMuEa64R+GOv5RkxevZBKv3ybaairFubWJJH3HGVXK2Nb0yNRO0nwOLsYkyiu
         CsbUpZtmbMcn17QkLsEsHCNS02nlNRsaD0UTiAL3Fl7uGjRZ/dQsfPjwfpIW8Fb3VX/2
         wY4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iTup+LbI65HmX+F0ajq64fRnVNFNt8p5D/NFVGWrCWA=;
        fh=b/tPKeTBrkTwi1/O6y9UJrAOjDTp9JQQ/336bk26UPY=;
        b=iDTSLoSsoQcvsElUENFCvA8I6gQwQiUUq59pq1bpLNUvMyHp2a1joNRtlI4/FJKVnC
         1JvDf8ENjVQtwBQoAG0f1obNR6OoFw1Ce/eAqvllgtxOokOJoNVwkeXfu0fLp3NPDzDS
         sWxA/l37ifaaG+S88IsbbhmsmeouIbVxTjVpkpTpeKJHfDBfFMZdGgJ4/M0J3mtzRMOV
         XU8UvmSOHsMy7Vv9TIJGgquv0lExWPl/IUgDJDDzTB05O7mhD99/m5eLX7UlNt20+z6b
         HA0DVFR//8sr3yIS//iS2xFsWx/Py6RI1dyCqKxWb0GEd0zfLnWbqPg4MyHLsolvDpkF
         gO7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793262663; x=1793867463; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iTup+LbI65HmX+F0ajq64fRnVNFNt8p5D/NFVGWrCWA=;
        b=bww9/Ac0vM3LR1GAlfNxLJV9j5wW5vggfETUfaqWSg4lngWln82NjGzD9uvTkFN543
         u5uX1EnGTPSYu6oWiHqvojg8+h+2k/45zUkxWeUfRBD2HQ4ayYsUKzYyEr8yxuBGd9jp
         hrmLOxK9wuxwPJSKAdDdjSyCxFSdPrSARM5yT6q/7BX2jusF46DxEQ2uPnDtRrnwfvkk
         P3aO8tPx6j7JgWPHTczdMcKjMx0mMfIKUCfVkVnkPVcaG4CBVAbuD7rwCO2uWIJamv1k
         By8uN4ROhNSMsfzxE8z2whkEE9o23d+9Z+/vEcDDKEVH9Ry0ExgNNSL/PkkvoRLAsS+u
         IQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793262663; x=1793867463;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iTup+LbI65HmX+F0ajq64fRnVNFNt8p5D/NFVGWrCWA=;
        b=Jg3Z/JPlvz+k3EP+tUm1gNGMa7wt8SENnPcwzQpF4mo2+HlkMBpTRMynhTYrlxAZRy
         gQCbtsfWD6EyPSsFQTowezNeQwLVvbG/zLyIEOreuHcCIHImZKP6Drs0gOospy3SWt0f
         AjzlW0+J3K70F8a3rAQCc/ToUC98aPK4/zUBwK3aJ0Cp+J6s5xW0V34frTP9+n62/fVp
         bqTbJXnqsv9YfDZ0ssi/6u5SR7NYw96fLK51OPLoxD1BrkCIkUdzs/nimym1X+H/7eLC
         d71FN1qRpyIkDaCDViocmD9PcqelC84KaSotZQyBArL3O/rmCuZw0W349tQ3aX4R+krn
         FXYg==
X-Forwarded-Encrypted: i=1; AKwUvBx8+l7uOVEynk0TMXTbmDWk4TIuqbRPA8tiTKAscKaQ6Qr4tZmhzqN4HKCdwIMLBlWjSSk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxzBd7R6JXeitXwpaA67wHcfX+32cI08skBG3uwgL4BwxGg7ad
	ivWAymp1BDOIplsjiHtsXbmuNuTiiRqeYuwlUs10hCegtSQBMSCgrzXazwv3WzT3RP8YXBZ0FaU
	RTSN7H8siQgAaQR5/ulJesti5eGT3Gws=
X-Gm-Gg: AYBFou2E9qTkUBpIZlUln0iEaDGvvp1v88+Xks5D/dvDW88rUm5tgLcN4FKX9bXEzY3
	EJ6IxyziRXBIg0CjsML+aeEHdTaGPSxlyC7Fe/QklXl2zanwRqDAXYch3YsY7eJDy97rg6kgduU
	krS/Vy7kEd+cqyqfKdwABqf9CLB7tDAxJ91J2S+hhAjAN32TaoM3NnNrofHreY82i0rjv1mgT0S
	jLag3K+EQrDh87IIHYcPY/CME/bXzBMdo33sv7qMcZtB1llwHIRCKLL0wudyrioE1nP5GuiMcG6
	VlcjmH77bb13/Vi9sa4V4sEefk5jPT1eHN+E2oqyRn595Rt4w65uMr4UpEg++1ont6iVwOBVOxi
	nMMK54v83v+O06rXxyi3/BEDZ9wKzGEdIKoR7JEbMME64d4eo2oFTGxQyPysGZ7mLrIk=
X-Received: by 2002:aa7:d78e:0:b0:6b4:5f93:33cd with SMTP id
 4fb4d7f45d1cf-6b49cbd736bmr2597258a12.8.1793262663069; Thu, 29 Oct 2026
 01:31:03 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2425.v4.git.git.1793003627.gitgitgadget@gmail.com> <20261029043041.5994-1-me@jaspermayone.com>
In-Reply-To: <20261029043041.5994-1-me@jaspermayone.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 29 Oct 2026 10:30:25 +0200
X-Gm-Features: AclHuK9sx5sISCWYjM47KYLbtocVjdkz4uoYKijfPghq7Tb08Ni8n4sU3rePank
Message-ID: <CAHwyqnV2XrqLmvfKXXqrk3WdHsan_NeoT2rLH-ToxvhnNxumZA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] branch: let --delete-merged find squash merged branches
To: Jasper Mayone <me@jaspermayone.com>
Cc: gitster@pobox.com, gitgitgadget@gmail.com, git@vger.kernel.org, 
	kristofferhaugsbakk@fastmail.com, ben.knoble@gmail.com, 
	phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"

>  * "git branch -h" does not show --delete-integrated in the usage
>    lines, although the SYNOPSIS in git-branch.adoc has it.

Good point.

>  * Giving both --delete-merged and --delete-integrated dies with the
>    full usage text. A short "cannot be used together" message would be
>    clearer.

Thanks, I will fix this.


Harald
