Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793799461;
	b=Mf07VpEYtI90N4wFSqPnWOl676u9d+SO9NaKYsjtTiuCb3DN6fTkkWcDFE0jT8/p66lu
	 inM9qlKaQI6SasD/OITDawLl+54wSKh5EPhIi4EXHOdBGqP7bw6konn5qasTYfu3cM3Li
	 HR3yql5FsxtMjOWwhhuwSK6DDDXgfXacKiK9a/eIYqbJwhMZTzJF7ITauAfliFYbRgIpz
	 bjEqYFIzBMV5zWRtE6oV3gPjMYQY/48SRB8d8RrFzzG/wFvtWgCZC7ZnJlV8ycRkYh2DK
	 RhuxXxJeMmOgvRcXhdFVtY8kuQMCTgwr2tUeSja4rnP/YLnlVbnJOFcQTfcWrY4pCvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799461;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=lWVBTbBycrKyzedxVHtMEb29fbWwpBJd8BxxVhZ4TSY=;
	b=MBMntxz9q/XUXxCo6+Tbw3GLvBQRAvGLldhaj8kVn4w6NhA68+GpghvhbUjmHPL9Jr8m
	 IUecSRlWPAHcc2n7rp0930KOki1/JAllBECXo99jTZBlUSQ13TH/na7MJeEJAv4ioLxq3
	 PB+wJjFhjiLG/+4XGDQ8G4dNv84+ZksXxNst8ph7FR5cP4TD3H6hTfGcslIBAgUvXKjOw
	 iRMk7HUrYYTHm7aXxVl1B/xnYM1qHkdIom/S6lx6tsYa3Eq2P8oJmD2a7iF77/xfQ8MGh
	 olT6iLdkidBZoWXFHq5kQktWtS2sqlVhL4wX7HAqd1Q0Itoaud/FQS/WRBd2+Thn8Rw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oJpj4I6H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.46
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF120606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 13:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF120606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oJpj4I6H
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-99806b7d89aso1376079241.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 05:37:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793799460; cv=none;
        d=google.com; s=arc-20260327;
        b=ATENx6sm8AS5r/382pljVrNtALc/ZLopzAWsWHbMpaE9cN76c3yboKFwV6c7FrFtdX
         sSZckz6wj+X9vP9TwuFtYStbT839BWl2XaWFX+PSZ6VviFvMaTb7KuuaWVO6NAq4+5Ba
         wpcT8LnYaOHqZJFeN5S4iW5Y+4Pn8lY/OrVOaViBef96lT9vN119eu24ZgOuPI1Cb7Nm
         kVlCgsaUUgueB6nS5ndIkD7HjfIXn7oeEaBO5XwleT4ASjB07LKMIru3r0C+7MfrGPXX
         pESMHWD8GUwT2oCUS4HCs31nQAL9YAIk0kZzBgjTwmPs4nTtNZFNwcvrf0P2iwNl2SD4
         i59g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=lWVBTbBycrKyzedxVHtMEb29fbWwpBJd8BxxVhZ4TSY=;
        fh=o9CHEBNE1+AGs3ThnM4588c7CimqpV6U228DU8Ahm9c=;
        b=ArokQ3RQ2MEAApJ6BIXDVJSzoCJjJwGjY3ULCeAiByuAdrD21EVwWJJHTRKisTsrcL
         bBgwr/x43t7SAWeiKP5Xp+e3d5uDxvJynleRRnnqL/v1/cQ4v7rRK40pXCazQUuZZ9PL
         Ulmk3R1YOxO1DgLhBin+kyJyU4CbL+vPbOjkwQa4pwfRD7W9T5HDb9urleXysYs1nyxJ
         efsQh56esJ3K+oVgZmShVDO0VeE3SMbq6fO5Za4TetXH6hOVnWbi3og8OhYuObbbN8ot
         c6I81ba+K0cTphvBZnTQfXn6ytY5SYAHDInuTohvfQmXOUgI82GgNUbvfuq/4eAPbRia
         fgnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793799460; x=1794404260; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lWVBTbBycrKyzedxVHtMEb29fbWwpBJd8BxxVhZ4TSY=;
        b=oJpj4I6HlYUFSJFAU03ZcQha8SyqCvAt/ooiYLI1hGRQsKeIg6jNRKBn18A2GVoXRV
         RLuQiyCZR1NVYE1bBySlD4B8l8j3VSFWghiQ1Iop1X0aly34cf0CQq3rT9pF4mMx6Bv9
         zifuKqJ7v5MK19ICrqS1BTxlhhhiCGi4VGsPPdMhZcg1cCMmW/6WE67F2N7+40UItsWq
         XslzdKvKZ68ry74SaPFsoMO23hJYDQLJ12n+gpGG6qWxu3hLMFCfCm1SPatx5N4WxUr3
         oF70t3uNfzdcX6O6uduUQZF0jDR3D1h/IR7qdz6hKyatc4q+zgVoOjX07xOaV8MLxm+l
         AkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793799460; x=1794404260;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lWVBTbBycrKyzedxVHtMEb29fbWwpBJd8BxxVhZ4TSY=;
        b=XMoH7n8tf2BIHelzpTjO9X5fMr+mCJkhwMb9lkzXHHIgr8l7l4uD2efN/kJ4kKaBRE
         9WYrsAm4ipIZuDfj9fJBWwdzWDqsY1WFo6nT08cvYzx+E0JCAyx/Ss/aqN3AMRnAEGt7
         xZ/zl+pPG2wtfLiCQSRi6EuerNhjB6/p2vjfimPoXB1HQvLYrveuiWyW0Ll0i5lKIqPD
         6iJJdqGmgVECp8VC8CqOV5v724WSL9x1aF/u2hwyHhTZFSIwOQXo6WtfSbeEwa4wQf5r
         bsHKWHlbX1kvuxDXc4GS58X8cDAQ/EHCrgV5CtcwF6gkFTVOizaNbHMpOVuKYmnWcroF
         v06g==
X-Forwarded-Encrypted: i=1; AKwUvBxBLN7fDPReqPo3a+nUMnemrJdrSLfWZsDdwPj99nzxG7938yIM/9x4BJ3dWP2urE93bCg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wpwMlIMw9iI+P543Va0koiSwAVzGxfKUFtIXdKFrXuGkkgVke
	zN6EUGaofxwtCOuNaAaw+62ont3CvcV4XkyMpqDz2FqtcD5UOwtoyDVktnydaKoBlR6V1A+eijK
	SrKBKma3nsO3T9jfdKhPp/XPvmANioDM=
X-Gm-Gg: AYBFou0TDwgIv9GifzlgzAkgZlZSzNfvQiglU3eQQYdGlVKesJNZNLaXMBeFzLGdfiR
	gN96hNQ2zbpqJo4gECi1vRtTSnKNDeERZgVRFYqTm52ImyRH4mrQ/P61UstXka/EymdKl0Qy/Bz
	kKvkk1OAW/d33oaE8H8ZdGpJK7COzXkRN35qv6FSLmEQ8+Ok5cBWl1aWJ8z9UGO/gUIez2lqXvR
	vxDYSV0vYApUzHnFwMxmOO7nffih7NlPN+gtzohIsGexGO8PvKEH9IUU/0K4d6uYy6mpW1deTUV
	lKey29QZng/4jY89ZpQ3Let0DKk/E2xlLxWOZwBTCAHe+gARI9kywRL3v/KjN4FCOLG0KkTMnWs
	7Agyqp0Cf/5Q0CQs3DnwyuLmVkLqvntcRIrBqchWy1IWFzvlNc0GRbA5kfOLY8QazNSxRGSN+y5
	BoWADWuuT5g3WiBhx65c0GfZUKLUM=
X-Received: by 2002:a05:6102:c09:b0:7b2:becd:1179 with SMTP id
 ada2fe7eead31-7d0543be60emr6084630137.44.1793799459682; Wed, 04 Nov 2026
 05:37:39 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Nov 2026 08:37:38 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Nov 2026 08:37:38 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261103212410.1389988-1-jltobler@gmail.com>
References: <20261103212410.1389988-1-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 4 Nov 2026 08:37:38 -0500
X-Gm-Features: AclHuK8c42zQRurEBLrjTyI7eupFF1cb2Qh7Z6NISj8ZdgV_yVXtoFW4PdRsvME
Message-ID: <CAOLa=ZRvbcjRt1MNn1ssun_Sfxm4ihQ+prw3sxc7=V5FcpVkMQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] object-file: small error handling follow-ups
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000097e7ea065f737bc6"

--00000000000097e7ea065f737bc6
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> Greetings,
>
> This small series is a follow-up to jt/odb-keep-lockfile-fix to address
> some feedback that was submitted after the series was merged to next.
> Both patches here make some small improvements to some error handling code.
>
> Thanks,
> -Justin
>
> Justin Tobler (2):
>   object-file: warn on failed unlink
>   object-file: return error on index-pack abnormal exit
>
>  object-file.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
>
> base-commit: 750f5de7dfe9a4062f95088212b063f189d50e91
> --
> 2.56.0.173.gf57c9a7388

So these seem to be the fixes for the comments I raised on your other
series. The patches look good. Thanks for following up!

--00000000000097e7ea065f737bc6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d373d60a2ecfcbf6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yck5TQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL2xmQy85dlRpVmtlY0JYUVI3TjZuV1ZuOWF4dUhvTApxSG5salBJTEJj
dXpETjJONVhJbThPMzhuTWgrMXUyMGZsWXY4bmNBSUtkdHQva2x6eEE0S2hwbWlVam8yVXV0CkhF
WE81R1IvOW1iU05raktlTFk4RHp3YkNLN1hDd0ZZQkRSR3krNEtQb2Q5cjdJdHQ0WHBwb1NmTkF1
QWRBa0IKR2FmYWxSdVNMaDFMV3pLVE9PbVBta3dHcmNCUHFheXdCajlYMzMxU1d2aXcvMitkelRG
NzZNVVdaVi93WENQego5YTNId0hOYUQyODA0aVFEcnRGTFJVVTdua01sVnR3ZE51UkpIdGtPbDlM
ak5LTGFYYkxoYXpwb2FqeVc0VmpqCjl5c2tEZ0FDTDFIeDJhVEluajlvRXBzOGUvMG1zYnlGeVVl
UHhZckJYd2dubG1PbGtPZGY5c1ZlQzNRcUJoa0gKZ0p3SzFvemRvcEVaOVUwM05CNFN2OWR1Y1dY
ek9hK3N1WkNZTzA5MmlQTGFKclFDbVIxdVJIOEhCYy9UMndmYQp1NUpaZVp0U3Jnd0huZXBRQ000
S0xwQ2UrelV3M0cyb0FITFFQcEI2Y1hUamdtYy84ZnlIV2dVb0ZRVWNHUXFkClhmdmF3OVM3NjJR
Vjkram1qRHlBZDdubk52d0JDeXdjeFdYRkZvUT0KPUwzTUwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000097e7ea065f737bc6--
