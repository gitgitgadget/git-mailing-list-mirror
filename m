Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792740856;
	b=xRYGW3ZDxkCJq7BFYnYWshOUpZzE1L9Rc/t0rCAfUz9uzes+IyclB5NWVJxid8r6TDMi
	 vokej+gVb+LopCD7L22XJJvGsjRNrTE2POsXZZHG2KHZQZwSU7rcw95fTyOiCZ7uPFGbA
	 MM73HgXuFlqiSSwvpJQIIrKlNSPPGZksNHdB2MiClItFyNkMgoCEoTpnNXjr+Z8cboPBY
	 myPkyl6uZoJl5fYi4qI5bfCrOAxDrojti1GhePKVj1OhS3sobd+4rvRnfIBjLGkzMZEBv
	 jh5DkS54YpzQuyyny2bSQEUzbBDCAUHy64Gnpak4uxiczplDnpgWFOakZXhC2NnV31Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=rLPSLIb+h6lv3TD8OYctDCA2GrM+ChzTig4J7sGfBkE=;
	b=Jj61Q2uVBQANZOT0LEUNvby93lf3vrpokpvezVv5yiOe/9Q548/P4cpU3uKhuMyksQzI
	 h3vFpCfw7afyIku+7LmSg/bwuannA1uCvPCh02wLxBwBMYaYKTBNo0Nv2rOJl3MnueP80
	 pIuqyhxEF4L7TNFQ9me8g0ZqamdXWMWF4x9B3J9a5ektUBXQItWIFNGzY8MCY+jmL8YTz
	 xofoQc4pse3GmTfZKVzPFHRzgzwLo9L4izQ3zETSV1fIWjfpbQO1unjhcum+wRnXw+lbN
	 6T/AjTzYEf6c/6/9JQfM1GBnme1yNnwh8ShZKXChMxasgwZWJT2vWXvV0JCSlDcXHjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ErzANw6n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.176
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADF9606A31D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ADF9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ErzANw6n
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4d7034a99a9so399496b6e.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 00:34:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792740855; cv=none;
        d=google.com; s=arc-20260327;
        b=Q9TYH/MGW3fk+1sTdlskBrJks7WJHuZWFl/fRVzt5U2mIdwDWfulLVgJXGpojd4Utn
         43Lvw87WUc2s4X4dKgQkTlU/Wy9csm0RmdzrzCV6pa+sdwXSFp2kywKcUadMSCpmZV8J
         Zh1elobToZjTjNd/TwM7z+aFxuqxhRrtLyHOUKk6iDtjbN77ZDq3B0JX0x+jbri/occN
         ndeLyHHiVQMrgJXAvFiU+SZ2SM0xs0cFYsorJw93ycFwX0jLHmIjqk9Eb7Xl4phS4FNw
         kOEO3kWPJduFITIt8GZd8TbBLeuPNvWAXdRbAYA6aLdj5Fs/ilkBJVfcS4HNzQh3U++x
         F9LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rLPSLIb+h6lv3TD8OYctDCA2GrM+ChzTig4J7sGfBkE=;
        fh=5VWuV6+JF8Tlr4dVBJXU2RRYOfskqpyOeKwO7q1Myng=;
        b=nXXlaccagRgLKqFe8500Zlolkoa8CNxX6/1X3cn5J5qBadND4qK1XyNCzABc1/QFmN
         SHH4YDzIe88QAc9tLpg9OZs76j0ZjlFwDzWIE7Ovd26qZAAkY3jWn0JgWJN8tfKAiB7g
         S8qOxdyEwGti/WCMWJB5ozOKlTao/WktbKvqaM0ifl3bvkT1rdWxHqik2BvyTW5IcT4/
         CWNjkWXnKG86stFSw2p0IqbcVpw3MupLiQpr4FbAXKNwddou31bUGjCtRj5DtuuLp/9a
         /Lx3Xg41rM2V1mTCDKpTZeK7E/z1IG2y5VPeZdA+TTKBkqmHl9NPfYmWnBYzYtyOD+tE
         C3Rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792740855; x=1793345655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rLPSLIb+h6lv3TD8OYctDCA2GrM+ChzTig4J7sGfBkE=;
        b=ErzANw6nOVczSrRWFsiocU8aWQoqindBQZqCBV0odhlRXXFncNdqiP08Ix8Ze3jB+R
         Sm4tRk8g7bMrCNJqCM4Isctd0RfgTQj5Uh19iAuBaDgeALUb848iDQYovvObpkwJcT6w
         cLuijlVet3rvo2XmKV/yyHVF2b2EGUfqCmObEA2RKLhdTZ7pgTze2p0r1iTbARnDF6eK
         G1caojX7aTPH8THGO+XsN5+HzCiWIdsXm+zmDeKg1/tg8NJX8d4Jv8Zzk3mf0HivEY4d
         JWfZuRAVAmPFUys6MDNZtFw9f8Nl8VMX6Kg/uhsdcaBJ9bbdbVweoPIJrFPds7z4EGYt
         peIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792740855; x=1793345655;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rLPSLIb+h6lv3TD8OYctDCA2GrM+ChzTig4J7sGfBkE=;
        b=nQWdmoE/E39WxlXlqf68nrU8J+iukTPryCabEG4TT7CnmHgP6bthQW7z4NW84HJf3f
         kzF/rg5CYzjfPlulaS4942CREdfCUEBpLGQCadZ5spnChW8ge7CqgFZ2MO4CC8/hlajh
         y0fDqSTQy/6v7+rRlVbsZrNwZaNbdoNt35fJGZ6pTpAJaS7y3nFSJvZel4SkU9CJ3H19
         NKY5cX4kRwg29hBSbl2MB4VgDTJBcpk34+ixjgyVHJS5jnGC+0stxOQfPcxxy5Dg756K
         5XU6xjjAyEOXs4hiz7KQiLRTEI3pINv2JRj2n0LuPVPoV6Inp9jpjks6DSOb3gJA6kIS
         J57w==
X-Gm-Message-State: AFq9FYJPMbtNcbUx0qbNTO/JJvfYOGfd7dxOAidqNIYDuC4kkdMLWflB
	exPiXcfb/j3QDZHhzKNJSYAqHgo4NBkjB9J80seEYli+GwnFPN6vYBG7zQH9C3WlfzvMecQBRHz
	D8ttpKXNGm7Vzsi6C6NH7jIdsl49W8pU53D14
X-Gm-Gg: AYBFou0hzfvS9B3TrFt2krHEt0AZPZAmBmkkh+FJ1nzSLPdy4TqO7d5mnF+sZmJ5td7
	/Eie/S7NbdmcvuUuf8WdsfiNKalPltShpoOPd3ykteMw1vEhGq6dzQfBlHbDfON6U+3n4050LHG
	ZG6IfaAtpgp7qxrarGOMQ4nVNmiBqfD+GyI2bmElRvcYSP02FSE/msKWhRRBl+wM9U7jfkgssNy
	dY0L2fKhG5Qj37jKR4n4Laf3izjR11fqHZeRt4zVdgI5F7SOeQrwpJBzNuQsM7HNx/tJKtgN342
	h84nDszqjLoAn53Fs9NoVGBvpwuTT5n1c72qbj/TyMcUglwm7Al4acf3Jbvgj5LxiUQym/5gFMZ
	K9VLVetUiDJ2uH2CjhOEANmUdbK0b+yxL+poqNXte6itQojyRoHjTTXeR0QU3maC20SGe8OV13U
	WWgULys0ORqVKFiEIGmxdaJRu25QTA02PFCHSIT4bUO++wAmpnxopQGE8FI409jbSbG4lHL6flM
	J5+X5U8TYgaWgp/nZVGwLji
X-Received: by 2002:a05:6808:13c4:b0:4f0:a3f9:9f89 with SMTP id
 5614622812f47-55be84288b5mr838579b6e.18.1792740855536; Fri, 23 Oct 2026
 00:34:15 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021063245.2917625-1-christian.couder@gmail.com> <xmqqzew6naiw.fsf@gitster.g>
In-Reply-To: <xmqqzew6naiw.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 23 Oct 2026 09:34:03 +0200
X-Gm-Features: AclHuK9ZDbJFfQb6oeZxbU-OMOcJfUYjFYiQQBHQV4BZG8-v5Jc8YDsxOyt10PQ
Message-ID: <CAP8UFD0gDWt_=N-YgtUqQjFyWhVpyP7Z99zMkqzyADUux9W=qA@mail.gmail.com>
Subject: Re: [PATCH 00/13] SHA-1/SHA-256 interoperability, part 3: pack index v3
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 9:01=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

> b. covers the ones you changed. c. covers the ones you are relaying.
> You need to sign both kinds off.

Yeah, sorry about that. I sent a v2 to fix this:

https://lore.kernel.org/git/20261023072559.3204273-1-christian.couder@gmail=
.com/

but I realize I forgot again to add an --in-reply-to=3D'...' flag to my
`git send-email` command. Sorry about that too.
