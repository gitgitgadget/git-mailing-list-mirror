Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792691644;
	b=Lj17X7ghuzgJjgd/sUBtRWEzuv3r6UvDedC31KB+/wplECehhJfnSGfWKZaO/cIbTGjL
	 QFkHCE5rW6CArvTChfdo3uMpSpnMR7k8vbq/kk4/RUbqas8k8Nf8YvUlH2FBmRVaiSx88
	 g5wAghpVEhVpnn4kzFW3zI5pYqS/RVcJYsYAQqCtR88sBSzFke2i5Id+EiPsyAKNsVP5f
	 RG6sZpOf3ubTWYU6Ku4gZ0uh9IjGfpXH9y/kyABfrMEEshGv99AAepBKnF5Y0r6jbl0WE
	 YGnPvYpVI9C4neX+m+6jGkGl6QBvebtZyWblvfP1kF/iktgpb+Y2aU7Z0jNBB2BQpZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=xKk4cDIIXkbSNmhD1nEVgvOVO1P/mPnb93uA6jVgV5U=;
	b=0RTEWpHPQazpRv+J40fAXbo73FaoOk8yhZ5Zh1u5xjVNrsgAxMYKkHzY9es7HifIL3it
	 s3l2ehnza5lrGc3cro7B5apUJopB+fzyJlY+fejaVuMPPgOiE9DrWBXR4RiBI9NAAsWd4
	 8JY7cdMjfTnHBlBs+pRMd56zIJz3KxbqorRDvOSLFcifHK+XTvPu3JdHnGhNd2zgFOf9J
	 JvHiYh7JDnwlwhUTy9XFNK16uMPCKa+LQJ8Ni9kNhX1UPgOi6T5j1LlIBG+2Rj2g0gqLJ
	 pjy/Ve4W+uYshPCVGSGiHXOLH+xH7y1ruABCelGTprG8NZsuRSOy3p+f43IwXpb80Bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BZqcAMZz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38C0606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 17:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F38C0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BZqcAMZz
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b1aa2848d2so3272653a12.3
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 10:54:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792691642; cv=none;
        d=google.com; s=arc-20260327;
        b=OaGLQDkBZmwzNF0aLFLBi8Zqibp+FDmwRsasRPH89NbDf5VWpYMCrgNcEzIXWSsBSx
         tsUZAApyI4fSv4YKBplI1Vy5Jwhis0ddiOxLj+7KJ/hO0APv4iFteftO7nojm7XB2XcU
         WDYYFezPa8GU3DfoBao0YHOgrYLbE/wfl0Px6lUHBjD70juXG6Wqizns73Z/9lHV40Cg
         ls2gL3lYs+R83DqrxGX6w/g8HxpT0NLb7wZRO1McemLh5xQUbqx7ZdUs8apaoUTUP6/v
         D69TQHJoj2gX8ZF08wCHnTmKQb8ZnW8kjXtFULIa0tyt9zS6D2teGh8DpgkoDkaqDMGX
         rPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xKk4cDIIXkbSNmhD1nEVgvOVO1P/mPnb93uA6jVgV5U=;
        fh=R9tDEaZ4XK4ilK6os6G2wEaZcCc5HudkyBK/qriCOmE=;
        b=KaTj+T4VsDrpoWUsLSMB8487VWsRv5lPDZge8vY9JvkQx6R2EQMsUsNBoMDSrQKIyV
         YgH38uWga8hG+xP+2v9DElS2e2DuKhYN8WnQxrtnLwSv0GEPU1J4fWG8tkD6E/6zA06E
         RSgiEXJifz7Gw06x2MvYKFqpO91CAxqYG53Fl0EDDDskeECR87a94ue0QL76PHko0Iqw
         NYrCaNrubSnXnUdn2FRpjEv3TBzRKjft0Hox193zYxHGImShLq7A1IVnOsWWvAIOYOns
         5P6CRnMP/iFtznAvh6GqDbe7FmyjuVSQJdUefRlqONIr/zRT7kgTvSfbyIvCVcerzijk
         hqGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792691642; x=1793296442; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xKk4cDIIXkbSNmhD1nEVgvOVO1P/mPnb93uA6jVgV5U=;
        b=BZqcAMZzKFukJsL0cgHiTvQPD0ZpIHaLBRvG63S9U6GXszxcLJttyyZwmhbDXJYOV6
         eti9zb27zZIcYIA/JBSTzJfBKW1xs5Pv8OUUUiL3Gz3ugc7NzRinVMOUSZdA9MEvqvfP
         kF/a2YENz61z61sodJ6hD32vGimfhHB9sw2NBzEVxpNJMq0SHEAhbSsjLLkSUREJBj68
         0aCxRLBRwtwb0HdpE4pvJuedAHBWNkHWjjn3rN7H4+eIX5fI5/gsIHF8YD2nEh4RkzZy
         SyD4Ak/IeM4N2KnYIUYEnuCfkfIky1bEcW8ojQrY6BLxbyr0lgK3lzNGY1KJq6NYGxmw
         CEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792691642; x=1793296442;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xKk4cDIIXkbSNmhD1nEVgvOVO1P/mPnb93uA6jVgV5U=;
        b=EyDfuMnt52qFnsnrN/kBFh86XZE55lyM2CwjA98UnYk5YYNQK8O5i2cTtQgJXTjIG7
         EyPgaERFLlq27XxBuMrhUGlKJEjdt/3eOVjzJQW885U8zKWY+nECK6o5yJ8XR6Ev5oTe
         75LMaH5Qh7i8yDKYAQ80hZO0ExDtMPs/68eJJq9+GOiMy2kPM7GXb3A4QlEjQJs3S3Pw
         colFjjya+Y7AkPros89fhS024PiP1fiDD7sE9bpk778ZQgTBTaBq1ptOkEJpdeJQjlzt
         3KUVQzM6FdoAry5NMmuxMKaxyMTOivzDSc49CVovjmOU01EmMr4Ld2tTgtfd0adZiSJS
         NOYQ==
X-Forwarded-Encrypted: i=1; AKwUvBwRSwx9E7RHhdsVr20UKV5HEF9CUWg61toRyctgE/RJstBnck7+a/GPdZOUity3PEgrNSE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIsXRUuykU3ZjbtP9qBZfTL3b2j6pJSzvznB/ElT/QCTt4jtqg0
	O2kKTDMuD9Bvtg3aWAXv2a3o2QYU6VfZJfflWTv0wdd9VLVXR7GIGxgMJM6FOnRhSzk6r2IG9Zf
	M/n8pdhB1eFZicvN1dDNgtE3ITPFbSzA=
X-Gm-Gg: AYBFou2Yssgjj2vMPuS3h86ToefrPjBLDf0k+DIIRBePojIQ2Re7mAGbRGkHxxDBHdy
	RWiC4EqCAngggqatewGfNm8v3ju59ePZJDlWRKfvt31yTX2QX0aQEZ/t/ch+ZShU5N0ucUkaHHo
	g4AyYHeVWD/MfJtlA3KAfEV6mStlSuoTg7+tCd8dZ+p+BWFLaDbgLKz6Q8h6OEHXCeMMesj8fcm
	F+CnYGUCf71a9Zp6Cza6hrKNhIH5DcuHyxFlwbRnD6Lr2sYRgfWas5IAGiWiXUMnp+ezlfON1dc
	+UKRTHplM3E08GseGrfXNxMLPv/7AgVzPhutYiptaDo5PlDfjTheeq785zDutRw+bnaKqPysCzp
	K5VuYwzqBuZdCH0xCPH/YA/W514HbZGhnmdy7
X-Received: by 2002:aa7:c244:0:b0:6ac:b85d:10f1 with SMTP id
 4fb4d7f45d1cf-6b432bce2b5mr168597a12.11.1792691642348; Thu, 22 Oct 2026
 10:54:02 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAHwyqnU-BEtOPdVbBXtuEYtFYuL3MqC9nUQeP_Puvq5bsoWEAQ@mail.gmail.com>
 <3EF4DA22-6739-46FA-8028-74EED08BB931@gmail.com> <CAHwyqnWJOk9FCGkPi8yWOFq5vr-CMWNhn=wBAifx9Gfn+1bMzA@mail.gmail.com>
In-Reply-To: <CAHwyqnWJOk9FCGkPi8yWOFq5vr-CMWNhn=wBAifx9Gfn+1bMzA@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 22 Oct 2026 19:53:25 +0200
X-Gm-Features: AclHuK_upC2v7kKPKyT2fkJe1cxBdBnqCzW0qGRFJB2UV7eIY8wRUJ28l2mGlew
Message-ID: <CAHwyqnWi6E=idoP2+1FdeEE4-o3D20xJfsc4Dutt6R30c===xQ@mail.gmail.com>
Subject: Re: [RFC] branch: delete gone-upstream branches only when proven
 merged into a named ref
To: Ben Knoble <ben.knoble@gmail.com>
Cc: DonQuinleone <don@donquinleone.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Why do we need the `--into` at all?


Harald
