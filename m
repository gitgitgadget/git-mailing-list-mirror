Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C602F416134
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550354; cv=none; b=CNeRNCrKeQBNDLAqAZ5Y2ITAZx10x7UnooMf1j542Ixl+8hOLBsbgg0e2uvJ5oHEpTpJ6tu2m2lFffEswnS1Z+tIAyJzeZC54Eet6ODrTfewRJBWGvhv03dQlSiOHUIYerHld2USc8kAP5ZC+VJ4YUFu7yQkbefvj8jVamwu16g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550354; c=relaxed/simple;
	bh=JEM4tOVF8jxc6pfvU4e9C/IW9GJdMsSFuBQYvCiiGo4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=gp4EwEYrgOEVKVnp/uS3uvFbrvL0vO2vE+vIK3K0KSgnek4ZqkrowdJI0Xjvg1auF9by4BxxA1zAke5Mx/AR4x9cJfEKdGFlFhTRUe6S+IijDmv3eq4DwwTRah5Z21ELxzNBQCp9KCuphVHojwy2EP/VjS0QxvL3khM4xxyjNS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ppm88Jo8; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ppm88Jo8"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-667b0ced2d3so11274222d50.2
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 05:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784550352; x=1785155152; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JEM4tOVF8jxc6pfvU4e9C/IW9GJdMsSFuBQYvCiiGo4=;
        b=Ppm88Jo8uUoNPPx9MmPNG639HtJZPNPxlRwKIgnYKgXAot5e7lbsNAVoJXCirgV5i6
         PAW3XPenpWV4Ui2FdPfyaPau01c+Bl6f2DGgPJ86K01e8fRv5m1oRvi4V/4hCpSBd2SC
         P+ZVxZBylrSRo3pHPglu1xNF62OBgzFLatsC3evB/LtJT99WQ9w3TuGmTFOz9EsJNQHx
         7npXSBlbcP8nxHjL8C/jU2fK4F/tj6d/sayag2wYadas23bBS+Ko86QVD9YKHPdZfLpC
         IMfQZwb54mcr/by3lc7FNVdZC4S0WowBEN621DAc1HoJFqHJg4BWUtGBIOmvXXWHbJd7
         7DYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784550352; x=1785155152;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JEM4tOVF8jxc6pfvU4e9C/IW9GJdMsSFuBQYvCiiGo4=;
        b=ju/PM9RXABPK7NYNaMdDfUPixXUBZE1R9F10qSHHoaXWvpifzXHt1Vk5MJHPXawN4N
         cF5AQXwIL7tzrZ3PW55UkgZrdFhPj01tkyGCAAv+GEyFMalMREA/BQS4INprUXq4dDee
         WViyxA+lKpkAI6QKyN9DNdLNzdgXx31eWkLazMNHUNXDgF1+rhI+WsyLdcXR/yb5YjxM
         +7LuLMA++ujf3r2jkm8BDUHOKpefpON/pnjYzFyMeTX8NXwhBJ1SINbTn5Hi8Rw4WPOV
         5RY1LqJ8IvGxt1u72Z+6uYk1vXHvJFMz7vNuCGLSTC2mDfXnO1bMgnRm+7h94jPDvyTh
         wlNQ==
X-Gm-Message-State: AOJu0YxAMBjec1fc7+X2cApavnVzHnqZBSOTxItgcXLaTlL8mNFhOc8E
	asTyxeT0PwfPlDzE1jjESPwPhzz1e70BTK66cLQL/P/lCnTUPyi2lC1u/ucjrg==
X-Gm-Gg: AR+sD11Kr/z0BBUDJk7gTfSNa9EQ8B85z8kfwvPDKCRx44tly6F6MYBeH80zgmYMalF
	9XbUe+Xj+JOxfkI4aYApFMChA/tEooj0cmWtcYS74M0J8LqiIrRTyujjCrpvH68R9P6U+M6R3Uy
	hsQ1QRVj0VVnxk5knwbknzDS/146JQ18Mrd5gyRmsPcCzpEnkgZwzW+srQ28BYsgySGtTh6gR+6
	7WFtkz04t90pP2W+xQBsxlj8e4qbvl0pNM1ufKVgnYu5q4e14Uiit+zgPB1DjzADQ5Bpa1Y/OsV
	W1srGjrc/9e2LvaS/I9sE4IW5Tt9584AwgbPCI73TwU7rAYzPIZwwxVZHlVJwik7i99Qx067kUG
	WdvyldvlD9xuiHVtkPIo8lC/dNFrEqrCgOFVjxWZAW9AZlBgh15S2/aFh9m0fZC92ofVOW3xEXr
	Gb4OrqGy2FzB++BR5Hlygbq+7TSCJQ8sFUjMqrmXJOk5ptdjGl8UOwgQnCGio6vAw1dYdvg4DeA
	FnHiAUb92n39bVZbcQqavgmZlLh7YbzXrndpxBcS3xY05g4VoSLmH/4rSRsUjt7bA==
X-Received: by 2002:a05:690e:13cf:b0:667:8a13:c3f with SMTP id 956f58d0204a3-6683bb426admr3867353d50.42.1784550350750;
        Mon, 20 Jul 2026 05:25:50 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:3130:c0ab:2a51:cf53])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6683b88268bsm5633957d50.18.2026.07.20.05.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 05:25:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: git config: unintuitive behaviour with --global and --no-includes
Date: Mon, 20 Jul 2026 08:25:39 -0400
Message-Id: <A5FBF044-4F91-456D-AD17-C3047DA0F973@gmail.com>
References: <20260720113402.0dc16abe@frustcomp.hnjs.home.arpa>
Cc: git@vger.kernel.org
In-Reply-To: <20260720113402.0dc16abe@frustcomp.hnjs.home.arpa>
To: Hendrik Jaeger <ml_git@henk.geekmail.org>
X-Mailer: iPhone Mail (23D8133)


> Le 20 juil. 2026 =C3=A0 06:02, Hendrik Jaeger <ml_git@henk.geekmail.org> a=
 =C3=A9crit :
>=20
> =EF=BB=BFHi
>=20
> I ran into a problem working with lbmk (https://codeberg.org/libreboot/lbm=
k).
> To see whether git is correctly configured, it runs `git config --global u=
ser.name` and that failed for my setup.
> The reason is that I have user.name and user.email not directly in the nor=
mal git config file but in an included file and when given a scope like --gl=
obal `git config` does not by default check included files.

[snip]

> Regarding the initial issue: I just added --includes to the call in lbmk a=
nd it works just fine, so there is no need to address this.

I wonder why not use =C2=AB git config user.name =C2=BB without scope? That s=
eems to sidestep the problem. Unless there=E2=80=99s a reason to use global-=
scope only? There=E2=80=99s also =C2=AB git var GIT_AUTHOR_IDENT =C2=BB.=
