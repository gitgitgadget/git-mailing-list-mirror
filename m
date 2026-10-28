Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.82.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793178010;
	b=Lk6RKh83qzzVmCdrtBW5q4OyvYp/GPtApwO604beu2VQfHcYfvFZGLljxuFKYHtDsCJg
	 9nPzIXXnr/WhcA5TSrw8h+F4We2niMzJrq7d8NLRLTyTBa1seUMBggm0TA0tjftULoGzn
	 HOveBMkkMDQGkOtUbnq61KeJCMpMaD4t4hhNHHLbLt22aNjPR8PaIfCLW2Uby9a5FfW2W
	 sJlhC8pET1U3SzYv3WX8dYG/EnQa6p1tQyg4RLPeWf/+g8aD/KskO2omvA4JNpF6ixWrp
	 j5iHnO7WVlHVDbkabDsSeskNgf4Hi2iKdcljvwB9QhksOSZOlX7kskiZLZ4HjU7enPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793178010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=A3urTuepO4XsLFwgutQQXKtPisMqz8bX2N26TAdzcCc=;
	b=ROPa8THoKRWcrJEIDvKJFlrfMXItswqpk3jf9rpsoRs5xM3sMxfaMx34rnoqWPRjYIUS
	 lUuF5BEezmldUFSnYP53LMkSqlPxuNGYU0jKuNjVj+YLXgTavEHJrd/NcNwnUpxEcPpY5
	 zupIiK8XmxoFs4j5gvZW6In0FKfHc38C8fqn29vy9qlNsb52z53/7lt7kxNFd1VxyDwia
	 Kh0CS3EQhh41JWbp5mGjfgUhGus0Fas/uANwzl8u9VdRDZoU5KJzn+eLQcKFgN1bU6iq7
	 sf2+qxCtUDKSC5FSNNCl3jXYQ2ZIZ7BR+Zv4wTe7h+lIsZ1rTB7v9gDnAp/Rs3l6+Fw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WQGo4aj9;
	arc=fail smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A0A606A31D
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 09:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6A0A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WQGo4aj9
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-156cbe59622so770618c88.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 02:00:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793178009; cv=none;
        d=google.com; s=arc-20260327;
        b=n4kW4FTq7vfJ5CvtYksodqOeXTNAnVjplK1midTR18RIEoIzxFCzVeDM1xoBxg4D24
         olwtyv9F5ItHlhMa5mMl24g64ZkkfjzNcUKWHfIvOgDg2Kq8edB8DJ4sMkZXEMJZwQoI
         Vndm+CS7GTy8F99+ht+1qMgzafNBmqNWHajSYP1PCPxURftTP2RaNiY2uTz121xNXPbp
         9WT3JIGMvmrQu6Dw0hLS8VDPPXoTP2nPDOw3P3ueSJ80mi3b+ZBNQt+1oDHGr9YGZhwM
         5TCbRw6x1J3yuszoQ/cSj3RzBbqBXrC/O6ClHCaGIZ+1POt8O0gM4X+p6sVrCldY9tKV
         Hn1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A3urTuepO4XsLFwgutQQXKtPisMqz8bX2N26TAdzcCc=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=DJeRkn7EhujmosHsh7vaYdvfXRo7iLla8To6nC9kIa7JIPjlzQZMFWWlH6HuMxfLfT
         Ojgb8eLc8GJH4XqdL/RPMo6iDx9NTroeODYI0ak1kPQ6lZwop+fLgW5rxC7vJFwl0tUF
         acTxRbIdViVS8CYpGq43E2YFN6nF7+mhZCOaZJiLY4u/o9pTv/MpHqFC7p2g8NJx1z2l
         FuU/wwhinbiwoSEZ0FgncbmeadrMGw45if9ufzzxVStacgorWwUHRyMiAZ+uTqfWIdp9
         ep/8pLudqCHccR5xOKexKRdhuji9mjcRERG0Phriu3BNC5wQE43Ax04k3nc2a4GZp8Nm
         iT/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793178009; x=1793782809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A3urTuepO4XsLFwgutQQXKtPisMqz8bX2N26TAdzcCc=;
        b=WQGo4aj9fIJDlc7LN2xzL/YSpTzIc17AeGOXYvXRIVIruyOQp84wrQPWXPwnFS6Xtm
         f9gSiI68ULyziTqwgXQoIARHEIGd+k90xlKR6V2kDco1MGvJLxOYveenPNqIvgnmKvMS
         GLu16aa1YqBK/2/LL1fs9FReWKLi9VFCmm/011t6sc9/lmYIqWXJOQ4xWPqLD/OhmWPQ
         Yi8MmRH7OFHuAnn4j3j65nZRHsWR/ibDq6pzZ3JLxmf32AgHWYQrOVAXGmEuRJ2IcAEb
         yEwhgz4bF+iHpTUKRirwVmQDo8vQo3ky5UI7mDtU/LRtA7aE1DaqPQyqdLNljWObkAwk
         ruYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793178009; x=1793782809;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A3urTuepO4XsLFwgutQQXKtPisMqz8bX2N26TAdzcCc=;
        b=B7wJYN22Lar1XNJqVC8uZMa8JJyDlVaXzDSPK8fxIVe380GTtp6JyRMeaQeg61ddSQ
         Jfy0OKYvWvzpD3bjCQpn3tR+YlLJx/Lgj7H9PDhhJsozlQ3Iiy3TRLFN1h6Zm3mankXP
         mJTrpXkXoXM6B3Z1PihwlQCxh5YHzFFRi0qwtuKCAlDTgt+LsQxIWDXZJ/tPIpop31hi
         tOW7HMV2btprxNzdPuzG7Ozq4UoWch1XupoCyV+PhqRfu710a6qwoQktArkDGH+qLqXK
         /vQL3pyQfmzGKccjYzBS6zVc9PlMGCa80ndtXoDdGGpR99w7b4Mh3Z39FCY19fcz2vZr
         dRUQ==
X-Gm-Message-State: AFq9FYL9T9pszzRNdhoeFeMn25Tep/a+MpMZzyRRpaT9xn3+9tGCHVkX
	J2Y3Wa7Yto6jFneWTXsVSLZU2gCB2ZqUtyh4EeYyFl4s8cqoI3QBtmQNwqCtif9kwMs7hMVkIAa
	+g3vu1suWmtfoPPiMLVhWD6is0dvsOg9s5E+x
X-Gm-Gg: AYBFou110Jcmo7OhZagKrvzzjAUTJ/5+Cz2z1x04SVCsfCkMoadEqj6imaTbLmDxqH9
	GDxJSLRbdNivjP6kI53i6FoZ3vT1dQEtjFZMo0wdhczd/CXC8/jHdCDnb+u4Ebk5bey5dUD4/RU
	XLlACBNn3Getayw66Kb/IPKTNsWSY6vpt02DrEbSOuuDHqkXJircJP4TxMfM6Q7l5PAGnm11Ccu
	N5iP8yV2vX6ZFX9sBphdMnGCjuguX7r9gvR2wxFqeAzbd1jpk24P3OnQi4c+3jaYeYXb+pBhMni
	G5SwY29UzBT18mXyVu6SDpojpJXiKlZMEwzXqvbaSn7bOD4WKpgOxrZf7LZCkMipJQ9UjuRulHB
	pbyRgppbdJONR2afA/QGfvOcauQfYDxsq9xD9HnsGu643RAeGScKwGjALeJmy7VUo98sLToW6hM
	yh7dS0UC8EMlvEffS24fG9lib6+wF2TP/xIbx/TY1XzGOwcAEdbKieM0L5MpSsmFd9IfY8xFcZq
	HxZz0Z8wo9h9W9GHLts24pT
X-Received: by 2002:a05:7022:f50f:b0:18d:9eec:e0be with SMTP id
 a92af1059eb24-1a6c9cda82bmr2632695c88.2.1793178008523; Wed, 28 Oct 2026
 02:00:08 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028-pks-odb-files-reload-alternates-v3-0-011ddb64b626@pks.im>
 <20261028-pks-odb-files-reload-alternates-v3-4-011ddb64b626@pks.im>
In-Reply-To: <20261028-pks-odb-files-reload-alternates-v3-4-011ddb64b626@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 28 Oct 2026 09:59:57 +0100
X-Gm-Features: AclHuK_F-UD67kPdlk9-GRzSW9OdPzJIK43E5oIaDdNwd55HwPxnNQxgMg3-ago
Message-ID: <CAP8UFD2Os79AwJrFvoPti-AD=v6wDf7BVWy4o9dQxQriFD3FzQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] odb/source-files: simplify directory duplication detection
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 8:11=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:

> Rename `dirs_paths_icase` to `dir_paths_iscase` to match the naming of

Nit: s/dir_paths_iscase/dir_paths_icase/

Otherwise the whole v3 looks good to me. Thanks.

> the newly added set.
