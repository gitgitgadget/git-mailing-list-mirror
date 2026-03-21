Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED9A1925BC
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774092754; cv=pass; b=DKQjiiaD6PZVmrhHkP/yb2ORVp3lVueXyVvz71HLeq+KkoMtjpGdm7TWXfe8ENoF/KVnR6Mnwxyw4FxI9w1vrxL2ksl/S0AzZE+fjbkcdvHZfzWP3C+kTbJsMMGL8p7GA9Yc3ITDE/OidNDEV8V3ODpDaV9RMsSwU6+jbNn9B8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774092754; c=relaxed/simple;
	bh=VGgdu01Z/rA1b9pAj50fILIGSgLmCv/fxYRzPKV4fTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=DKCJOXRQGlRB3bYK7ZXj6PkItg1624t13svl0MqtVz5onNn4XVURVc4s5ubWieYoYXchI2FdIDH2g29SdOfth/CQZ0/xoJpohFKiFVqILsKM+XSjCAyPSYn1KpWy9BP762GF/F30s05iOj7KTnAj3cWxNpTgyXw+58/QzPC609s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEIPceD4; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEIPceD4"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43b4d734678so2839542f8f.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2026 04:32:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774092751; cv=none;
        d=google.com; s=arc-20240605;
        b=RV25UYcQ2VJ12+hf7Yp1mtJcDJ9VGwLJ0V5dcgWsZq1Z6trBBhAy1SB2SY/vRaEDMb
         uarYdm7jAixuhZm9YSpp+uOZ1NFKvCftMWFmAAcYdYjhz8CFOj2Hljt52K7hDGrFbF3A
         53JOQ2yiXkOqlOhblHs1lh4lcmL8CWrH/kBJb5mglAXVPDfndlMT93bYgOz6sybNABZx
         4hZkWISr8hKJkR5talwcFD0Mrf2K08RjfuKnEUUx81NzehjzwUXa6A+aobpcf/Xi00p9
         6UCkIVwZ3mITOX2iXTnqv2d/6NPNnfpqdEKQF8TMjWnxe6RKZSro0FLlb1E15aEBMQHO
         8b2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=VGgdu01Z/rA1b9pAj50fILIGSgLmCv/fxYRzPKV4fTI=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=U21Ezz2Cy2I+fvQEzka6vKPuFsYa+oWfbv0ssjKumuWVRZHgniUVTJHLsSF0wr9pNU
         mQvQ00cRQGugEet0mk8qHF/rANw1kLX8u0Os0KeXPqyc3bNzY/7oajwUcloEte4b0Gy3
         gM9D01UUf5Z2FlySefwziQ1iuNUroHwIRyVtiJOSsQG1txPOIJad+WPM7DG+BoEFvha4
         fs8YjNsSYZBkkhnMMAcorV68S5rs/o6D6LFCWWH52nBVxa7kr4FwOL1osADRq4t9zC8G
         0v6TOUWm5goIZ/FFyZRawwoCQ8PBibpMPEdZsXKIsXSOgLp3MYibWTdnZP9/yzyng4ZC
         WdTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774092751; x=1774697551; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VGgdu01Z/rA1b9pAj50fILIGSgLmCv/fxYRzPKV4fTI=;
        b=QEIPceD4fkRifNgb3B1HXcJ78+BLXMEkDCPQMOVuiGcl0d5mrO+X9zIjApmDCJ21zT
         YIUh+O7fdDSg4tKTqA2UQ9xI3p9Jd06gqneE/F3ki+mK30a28aieHdo6C6LVyIgbAv92
         OhbI26uXPoYZzthvrZQtl3UnQpw8VIveMOiyD8DPvrfd/baSMd6JRdVk9jsc8Eb4c78D
         x0wa298j5MPnVHgNzyQUE65+ySvOfi/rTo++OcI9s/nOq6x72MLF159+wnVbSNUGtWeI
         cYVfUX+EblhXQTnh4nZrcf77oidCd+UoIUJKIMjWrRCib94eSryZ/sHTBu8xgYiCLsJb
         F7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774092751; x=1774697551;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGgdu01Z/rA1b9pAj50fILIGSgLmCv/fxYRzPKV4fTI=;
        b=aLRDGaNo2FTtTCky86A20J9XC2HELC5cReQxaI68/W21pEvPQR3IrScDWFPRG6qg9X
         yxh+QjLlja9R4edSJEgIKcFBmRt1qmKMXRaHKNl1qKBMFNnpUgbne73kkY9/SjqOmRQ9
         7Nv7m5Yq0JXYNaMKrffNz/5wOb0nCd5qfPGBaaZ0wGRxGc8klc5vz/TPepWNTDiMxkM+
         y3Rjq/VNTXZWWmzkZRc1Xk6nULgpfvHEl8TI6cJz19aGliNlqUtgMpHkhb4DcYzx/OGv
         qnx5dwdc2PGFSRWiA3a4Cu9XXpWCn7i/gfYcoXYTYah0k+LXJud06rnS6RJnuIjv8Olz
         tw9Q==
X-Gm-Message-State: AOJu0Yy+ASFsTvzhF3W8u5F4QF7Y2cTz+VSvzMPdfNNsv7H7qTDfzazy
	9iSbv4+b70ZAqylzblAfgCjpQJAx+Ggg+BrgEYAbG194OGm6wcQK98RYPmOrLUYuuVzbWjm3cBh
	RvrLzTHuVyzwi+EGY+qdbDtQZ37Y+r0uMXQ==
X-Gm-Gg: ATEYQzxGLVqJnofEF1i8HDD3k8ZMpglzA/XmVYgZej/Jdo27x+/ikPtPm1WWpKBhxzs
	59VD9KGqs/gW0NpqT3nT+CH5rLnLeGTBHGZfFFIofv52t2hZprugkIOvnug49SdtgGmRWz8dyDj
	2wpnKJJ0c1pd5wDxFQGI0RgX5glRgJ3dhCPqt5stLhmPqq9e2S5a/OdReOjA86Jkvrnfap/J/Hd
	AgL/5fr4qSAypB9Kxo/3Pd/7RycfwTQ+cjRFailT2dnzJEOark4W3zfbR977LWX9wEeL2d7jRBX
	p6rk6LJYCZOUqvOquen6DiDEYqRWTgjMf7vOlVg1Bn5yKQQdY7zsjpH4Tp8Bd4adLymWpA5mDwm
	MOtflOhTku/l5+Ahsk/mF8pI9FDs=
X-Received: by 2002:a05:6000:40ce:b0:439:ac6b:dd64 with SMTP id
 ffacd0b85a97d-43b64271cadmr10159702f8f.45.1774092751094; Sat, 21 Mar 2026
 04:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHDzFGdAzz1jGVsy+MsP5kso7spFZsNoXDK3UkR_JKGXR-zPwA@mail.gmail.com>
 <CAHDzFGfsrJu+Au+Nm_VrxrhvAQPLzz_ZfChFkpjeWFOV1y2q_g@mail.gmail.com>
In-Reply-To: <CAHDzFGfsrJu+Au+Nm_VrxrhvAQPLzz_ZfChFkpjeWFOV1y2q_g@mail.gmail.com>
From: Abhigyan Tiwari <abhigyanph@gmail.com>
Date: Sat, 21 Mar 2026 17:02:19 +0530
X-Gm-Features: AaiRm53vjKh6C_QvmTlUfb3phEcZx4SGrlyKVXAxA31WBjfC7w9FBdr0ITcuq8U
Message-ID: <CAHDzFGeDocjTrWH_cnODQYF-zLoBJU8WJe8J-8qGmrCH5zwXbg@mail.gmail.com>
Subject: [GSoC 2026] Introduction - Abhigyan Tiwari
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, My name is Abhigyan Tiwari, a 2nd year B.Tech CSE student from
Assam, India. I am interested in contributing to Git as part of GSoC
2026. I have experience with C++ and algorithms, and I am currently
exploring the Git codebase to find a suitable project to contribute
to. Could someone point me to the current GSoC 2026 project ideas page
or any good-first-issue tickets? Thanks,
Abhigyan
