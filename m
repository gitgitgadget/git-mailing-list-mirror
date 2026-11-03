Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741387;
	b=SahGhQxOhZN8hYEM3A0ZPs784746OjmFixh9fNwXLs7qVsOlRhkBUthmkfLYqLrRKi6Q
	 b5bmif5lG1BaC6G/WiLLVFVejw98JmglZkYbEf3KQAsbxft4MfTNuLiPTp43Sh6gQvL/k
	 rHvSTaYTWnaCwYYDBMwGDpAdjWbHgUbaen20FsyzD/0K4d8Aomwac410ofCHgkmv7SE+g
	 UPSFW+itJgc4bIAC/9S2G8VAuU8kNkp0gwyS7J+GHsaKaVEuzx+cql2Lz+4FEkdCzIEYY
	 9EUwhL0D0sWd0oh++qovHkOQ2xzTIg/UrwEupJ350K7c4AJf/Z0y30HW/yAabQ45z6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=b1dFF+vT8xEb0kMUW8Q/pBe04rhlIlyL0oNRyKvvLTE=;
	b=QrzpMN81xdL1NokGBQQQTwSiCMiqaZz4InicpDv5vqfNErLQsNA9wYFILQd1cyrHkk2k
	 IXhWDNlOIUzN5lhK17ANA/eg2xLaSxSlopSKmnBEi2N3oFompLfhFmvO0L4MsshM1fFHU
	 Ighb1u1+7TJEYnuZhNpokZKlPYHWsMVPMakX6nGBYwp0tisi4hpdxFvaZWTSnYEJAUvfm
	 BASD5HjzUYU3nljvtAP+N6Jmp793BrbiKm9SIlp2cELlOKDwybcmkgBm/JfmuWkiIqGV3
	 YoaxiHIundkEAxKmGqrZElRa0ILX1bkqG6mwYHIcN79rEQVvpgEEnwx47KYDA64hrHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hYiybXse;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A73B606A31B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 21:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A73B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hYiybXse
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so76635e9.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 13:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793741385; x=1794346185; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b1dFF+vT8xEb0kMUW8Q/pBe04rhlIlyL0oNRyKvvLTE=;
        b=hYiybXseoqHo3aUUPo81M2g9/Ebx0V/lYAkyeQ/mapGk2K71DaBrsGsd2nt5pTMuFZ
         v9fJ9889VZrfrtQfdhMOLpliwuHxRJAFiU90uozePBge9xavc0B56ED0n71t25tuvEQL
         ucR1r1m8d75N/AYy+YK/XS7+LY9Vck21YliGaRDmcmNKCpYXXdNzxHKGYC4vQy7U8x0o
         odu1qs4LM6xdCFBBlIksg3P0xtMm1CsygGkz918ziQEsZv6M7TbxRkSlZPGHoz41IAKT
         yBA2Kr1MOP0KDQ3EPTMNYxdz4VEGlU0G7dy5YG5rZ/bgmCF/NxTlulfBwfsYDa6ezVGY
         LBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793741385; x=1794346185;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b1dFF+vT8xEb0kMUW8Q/pBe04rhlIlyL0oNRyKvvLTE=;
        b=1CeYIxEo+IP3IxrC8bodVDzCvCEcdS/92oBMEHsC7LXFe3LUY0/CmAgb4Zeqs8+8Zo
         dIW9Iu//QGL7YgLiAr1lgX40mO46eOS8pvZkLs7TLIgtJiAHP2MRr9GogyFcbjzALaIe
         NO0uLd3S4+WAE+Co2DdNT6eHfaW1otep8bPfeH+75JaAS7WRkAdBQcDvL87cV/OYK/ki
         PnVGutybq6gfsTOR12kZGHW8URbCaVouXtVEm3NDqAT93R1zwzvGd6mDU0IrdB0Vf89r
         4vN1WXjNjmcL8a9z1phvSZ+NcidBcQug67SSUnSOYWhF4djct0bTuMb1Rl5vy/Ba2Xqd
         GF9A==
X-Forwarded-Encrypted: i=1; AKwUvBzKaehyKhqqpDktR9SIjC8WoOPR9vyRGEvBzbe3q/S73S80mpXowVAK3zVlushK3HWcU1E=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZvyidDy7cMtMH6fc7rtgAMN9YQtzYjNSlh/S6VcddnC9MroC3
	BMaJxRgDp54De/2F1eHkECCwsHb6fWqJeZEJ+64uF7xvIGibsuoFzbra
X-Gm-Gg: AYBFou0jQSxRQfToR8Z7ogTo77D9H+AhTjux0nzKnkczhqMCruesZLwbbN01OBPY7+2
	3/DFbcQv9VffvM1qaI6BTb1UOA5Wi7KV/BXNAFpL5zdNAd9C+7dxpkW/pliFFOAfMvfl3d46bEd
	Sj1UDeI3859s5sqK5bw4n/uNU/ew9tYzFFPzrysPHproln/PQKg+sakODOZ5vYb2+512m2saToN
	Q1WmvT7KmQje+9wU8seN1OmG8R2oxgCiM8EcFU7L9Ejwi7Fz9cbOETIzZEAR4TPDoAJkAtAcDTR
	bs5oH2tozcBMdZQ9T/SxgsWqAlFAZINnS/tp7x+wJcuGzmbv7PYHFr8qjEZQcJmgXFFJ2/2Nq84
	Nd9hXR5sNjOSeGzuWTEPijD1lFG2nnmQMlv+wQ1WXlsxyVs2xz3d1B4mG8EuXYUayfMseDRxnb+
	7VAQ8xcedXOh/NxdvialieqG0PCNpZ684l4Cbqm6MExXnxad19tmYzKvyMbOi8YrYsY49p9cQBT
	Xm/V5zqP2OX3iRn6k/doWw6se9i+7rkj2STHvRcA6Ic6+M2jI5SKETYKoSV1FvIRFvqmFO0Ay6D
	lMpuw1RMj+x7mEnq3jDs37UodcS8i8pstjlovY1lWJhTSBbvG23U/9Mx2hnrSVJQ/VODAtbrSOR
	/UIfBkzYmGlL1JTbNfdAa2ShDWT0atl9wXUps8SREOWIlJlbpKKfB0QrG4iMrkE01dIyjIZZUIe
	5dm9aCYOi9Ge7zEeJ1gj9+hKwchoc7YligUVi72MW735ZQkqlqHIxN
X-Received: by 2002:a05:600c:524b:b0:4b2:612d:908c with SMTP id 5b1f17b1804b1-4b2612d90d4mr103374805e9.34.1793741385283;
        Tue, 03 Nov 2026 13:29:45 -0800 (PST)
Received: from localhost ([2001:818:c665:a700:a4bc:846:cdd6:3f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43da9825bsm2186785e9.15.2026.11.03.13.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 13:29:44 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 21:29:43 +0000
Message-Id: <DMLW93TBSOXK.2OLM5O3HGK1ZY@gmail.com>
Cc: "Karthik Nayak" <karthik.188@gmail.com>, "Chandra Pratap"
 <chandrapratap3519@gmail.com>
Subject: Re: log --graph draws an orphaned branch with parents
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Pablo Sabater" <pabloosabaterr@gmail.com>, "herr.kaste"
 <herr.kaste@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <CAFzd1+4Jx_sWvMrV10gi9400BBNJOUXW0WwsypiM7yCh5x8fow@mail.gmail.com> <CAFzd1+5s6V+YC3onNjYQmxRPVnsMROpsVi=qy1mg2=LOAnU+gg@mail.gmail.com> <DMLW72EXMN1K.3IXVPHWNYQ3EH@gmail.com>
In-Reply-To: <DMLW72EXMN1K.3IXVPHWNYQ3EH@gmail.com>

On Tue Nov 3, 2026 at 9:27 PM WET, Pablo Sabater wrote:
>
> I think I may be able to see how to fix it tomorrow, but I'm quite busy
> until next week.

I forgot to ask if you want to try to fix it yourself, I'm happy to
review it :).

Pablo.

