Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448730;
	b=iIo+6p7QVob6nPbJUQZWmkKWK6WV8C/75vrYmeiCWmWAEhGgcGiCCLsVmOk7hMBid2Sl
	 M+uO1U/IFDqtvpFAFcg5mP1KqlPbu48WMW1fm0sCWF7u9J3FnC/O8oz+4p4d6wlIdUiHt
	 kRvFvSx1JwGoO6ogWuDlIFmv1yCSisWHT/9BlIqYX3xVNEYYQjgUNYDQT0s/x0OS1r1qQ
	 dXHzlVQNoE6wOST8iYYO4Axp0PhZUBG/FWbwKH1a+hd/NynIfnFrdWxS1gP85tx1WsMfw
	 7kVUxCFpcRD+i3QYcVxbpgHKZ8ViA61hIyc5ereCrQEeaXwJ0CP1uW6kU0ucIs4Nyjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:Date:
	 Message-Id:References:Cc:In-Reply-To:To:X-Mailer;
	bh=RsM8UvDEMkbsLIuqYq/9D9PjCq1S7SK57V53tAq9Oo4=;
	b=X6ytUeApHA5bMt1+KCKV2fZNSggRYL/r1qiHAMH+cS7zvoaHXlt90CspyIKvFWhrXcSF
	 yEYOZJatMMBWINiDJKbDfM0r7n/U6eICgL7LVCno2VAgQuE00BQ00qPJfZP+v+eSeUfxa
	 ennaAqkelboJCx4UhOixotIivz3bcPBKKwbTULmX5g+0DhbWSTazXtvjkURP5kDePpfwW
	 U7WNNXvODHDgCbFzOsNlErU4NTyudPH3y40pNQNT6yCJn6hp80CRESc4TTide5W5NcV82
	 0FcuiFhY7GYqxmi/fWz3MYBlWaNiWQi9AB5DWwWWqcgc9vAKOIKqu0+cRsrizodl9Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cIfAfNnz;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9BD606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 01:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F9BD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cIfAfNnz
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b3b57a31f7so9216967b3.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 17:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794448729; x=1795053529; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RsM8UvDEMkbsLIuqYq/9D9PjCq1S7SK57V53tAq9Oo4=;
        b=cIfAfNnzl0jybKazKDe+Tyk/JkWAQ1+Om0fiDybUf6aamI32o6f7ONO+2NTEvUbjRG
         NwsET7Eswn37pTfyOu1Ri+KEWvhil7TzlukuvpcMhkvjCjBZfDSyJF4oN3KOaI9TAHFt
         vBtttFm85+WQxrORPNXYZ88UdfCX5EFpkFzkhXg5X1tpPP0oRwQjw9WOcwKh9HrNA7Wp
         1wYA4qLeA3ShEqY5gE3J7oAcSl6MBVwDicqTIvm8B7l2zEdvRNaDt9IHBaAi8wOWnPT3
         6W+WWtLBu4ADOFcG2vxNUDJVZyhyDegJALB+sLMe0KRy0a21xQNp8jENoZfiQcVWPTct
         i/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794448729; x=1795053529;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RsM8UvDEMkbsLIuqYq/9D9PjCq1S7SK57V53tAq9Oo4=;
        b=C0VyCz0yre5X8yANNYLPNE6Px91OlfLqY6W6B7zpZeGglYLqNAEzZp8iyUSWhU4Ni8
         QuoUoIYvnFscTceT8BQfn8RoV4kmQGiF9wiCLJfRNvb+2IvusfsQaXPK9BMOdqfcooIZ
         p6EpaQIt+fQxm3odGFxzZ6WPfSCkT5l/luA7i+HyBYC3hvvRqd4XwoZfAhlMUy/fGEAC
         0dl2WGtCLj4d0E5imKFOOv7QfhYtUWznVZ89megKowRyjU3J6uREXN2zA+us+6nI/aTW
         ULtV2t/4cpfNG+JnFWTVhVmrjcPmoS5ceRVRE9BnT6GUV7vVOEOSY1kDXuc/RU+h+XKL
         x6cQ==
X-Forwarded-Encrypted: i=1; AL+hErHNARzX5phhdMYZ/iiQh1KsW4HT4zrfepFt07bLbs4KhT2xM8NhPYihlmJ1W1//nVx9J4E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/51Am+6ARMRafWeiCyTtc4uqeLf/tgPEsOC2guHbsOdN43u6Hk
	wwpPDQV4ZtoXb/+46SMF2Sa33y9lqDRjPpv3iM5EIGhS57cnLGc0kMY9
X-Gm-Gg: AYBFou0cNh7Qk1950s3VENKTryUe4jLo1hAdLtdvShYJoNWX8J9gzRhSQXNigv1DR4D
	bfP5EderMM/1IVpLGekD2w9uB/Uu+R/lHlwPM1kp5lqOtoUWCEDszhuVOS4d+Nz1cmnPaPqAXNB
	9+LH+waANVX3pAmQABPrEU6CAFum27t+uJ5f9YHJjq+1FKBDY8Cdpo+9PBJ9EqA6+D21eLxEBAj
	oGFOLx8FukAMrBkUbYlOyPbBkuA2z+OJxfsjkzpvyWKcI7Dll/vN1SggE3NHKd69qyUJ/poxRF4
	g7PSiRrR6TE3nTRuIsxjC6i3LohOBN/MzWCAnWahSwhuCVy4pDhD3nNNOVAcsb/qblVef8mkCnV
	79irZ8C++CX19SbWPnD7vx2jaJ3k8WFy5V98UcibtydEX0YmPioyHHoh9ndcP7oOgOsmxEMz3Gm
	XZAXdC/m7wQGYwnrv85UeA0tzEZhK7UjrFlHPD1bl71rcTvrYWR/2Xjumahc1M/Q5woFzY4+1oH
	53GPX9ogldibJ+jzDfSK7H9SyRzzkjN71l5YjZdPVL/nG2DMXF3Ly0IDoSBm06/Ef7ggZcMxx90
	iGHGKK5iT1O+DOG4w9RNwWhaHGjndeylg05nZxv5Yqw+f265ZIzUqw2pxS3Pp/jdmdodIpbiNeh
	awHTmgitptMla90mHsPeMby2fAw53ZvEoHI+6srXUr35C1iVO7TF4WB07YRjfWM+5PE5v7F4lYe
	2Hiss=
X-Received: by 2002:a05:690c:c181:b0:8b3:50e3:ec53 with SMTP id 00721157ae682-8b3a80edbabmr24265997b3.54.1794448729200;
        Wed, 11 Nov 2026 17:58:49 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:9d46:600:21c1:9edb:1bc6:8d8e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3930bfb64sm59309197b3.0.2026.11.11.17.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 17:58:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4] doc: checkout: rewrite detached HEAD state explanation
Date: Wed, 11 Nov 2026 20:58:37 -0500
Message-Id: <D6E81F16-3546-4FF2-B589-3A5CD70E966F@gmail.com>
References: <ddc6d42c-6e40-46a5-bb70-f89f11525ac4@jvns.ca>
Cc: Junio C Hamano <gitster@pobox.com>,
 Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
In-Reply-To: <ddc6d42c-6e40-46a5-bb70-f89f11525ac4@jvns.ca>
To: Julia Evans <julia@jvns.ca>
X-Mailer: iPhone Mail (23D8133)


> Le 11 nov. 2026 =C3=A0 16:45, Julia Evans <julia@jvns.ca> a =C3=A9crit :
>=20
> =EF=BB=BF
>>=20
>> [=E2=80=A6]
>=20
> Yeah I agree the "it's the parent of the next commit" would be distracting=
 unless there's a specific reason we need to include it.
>=20
> I agree "the state from which your current changes started" isn't right bu=
t I think if we reinterpret it as "the current commit you have checked out" (=
which I think has the same or a very similar meaning) then it'll seem famili=
ar to folks and might even help.
>=20
>> [=E2=80=A6]
>=20
> Thanks, I took this language. I left out "clobbering an existing branch" b=
ecause I couldn't think of a reason why someone would clobber an existing br=
anch to check out an old version of their code.
>=20
> - Julia

Glad we could move this forward!=
