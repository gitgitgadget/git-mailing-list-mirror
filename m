Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67525188000
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751548703; cv=none; b=cxBMyXkCxU3veD+Y7cKZ+a1CUtWP5Y/bCjsMwdXbfV5FLaQK7gQj1c5YRTILVVP4e6W1gp5qENstiouH6GTJfr7RR4rpUyRg1GryebVFM+Sp/51FBJy7Vajl1X2pUdelNw5/hV+fNGd2rSt+49fXBT1pOI3LzP43JhrKDSyxhUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751548703; c=relaxed/simple;
	bh=Q3ArFqk4/7nFhiNOO4Iz4K29P1rHV/NFV+u7vhvWiKc=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=OVx21eO9SepmxXsZEAT3gaRX0B/DFk2MvuW7SdSNQdTGLJH4DPMhDCqMoBEZdTSQRA2mmjXkl5QA4IgycQNbmfn6fAhjX3m5SDUd7gw84hKPIu5jnKJFuhyKlqZKBxf9YpxQIyEXuOFCfAy87ge4e6P8Wc6F0SAlqIDqz10Qvxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJjSKqYm; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJjSKqYm"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e733a6ff491so5259300276.2
        for <git@vger.kernel.org>; Thu, 03 Jul 2025 06:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751548701; x=1752153501; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3ArFqk4/7nFhiNOO4Iz4K29P1rHV/NFV+u7vhvWiKc=;
        b=QJjSKqYm2Q4iUex66VnmpaCT1aZo5wugW2r78cv7g6Edaz95m2Tq8qLWf1oA+E+VrY
         hGInn1h9X/O1LLP2tvw7cw5vunnE9YqqyBKkhS4BLvMqvYx11GAJjt3T2ZTIuVqCcoiO
         Id5bkf+1py/qh4uahWAYaRDjvUaPanhSXrplf2jXT2JC8D18JXym2K6AsPvFqEIk5qjW
         DVjujPXU02+VN/4zGMa2X7pUdZXYimPttc8xbbQq+VsKlZU4rgbrVSoj30QnHfnT2Ula
         QuJ6+CVYOkAPvhMm0jKJ2CvDXMyAiHZFLgq7CuIkJdIThco8AYAgqfsbX7L+p1ZYEljU
         KaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751548701; x=1752153501;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3ArFqk4/7nFhiNOO4Iz4K29P1rHV/NFV+u7vhvWiKc=;
        b=u1imml+dZMlY9k+VcGchz+dUWYaheb49o6t3xfHRMGcscMZtDXZWmU5cyIV/fPCy/b
         5TK4dR27+iyUoEvfNOE9DV/BZMjo2JKkEaTl9wICZvPglmcEFsyxJhuxJOck16lIJ6aM
         monouz6BV1PA5GK8aTw89/+YmDuHzSaSZxd/fm0rEHcRlU1QQM9At7YN8RWsj4oUFssn
         hLVfY7TmNRc+Zb1gtQ0u+V8fw/Fpf2cozTyQbzRwt1nIHIHoPSU37yh7qLvgSAAKtO1z
         bCeKRUYzjnr+zCS8KZFer0oMJ3LtdeT4sLmPBuWPmbk4gpTSbMHzaq1S0DJCkqVeMjj7
         FjFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEX8aAihfQHFGzkfms291OUBEdfG8yozGl9N8+9ct8g+9fdtOwoVYJMu4IwAEPHFaaHDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypw99qZqI+NjP+CQwbdTCh8fCbxEmbpDFoVUmvB/qjOnjdGRCH
	MamjWR97JcTGBOIiy+9SAQAvm1yk4rVZiyrbQgyAM7wpFI/msuEwRq3QMnKNTKb3
X-Gm-Gg: ASbGncswTvX8OrLTW+iPThWVXhQO5auQPXVmpLnA6F43msY6laq+Ln0ZDHLjeO9wsuW
	Q4VdYDSJ2pVpPFgPoX31hAUBozVg5hLW1usH0Cc9dVUWCr4iiN9JNBqnFgteS7GPilW5K81Mipc
	60h587SemKluNjQOFYPbJWTHSl77uCoWfof+QDCsd0WWqcV7ulPGlkBP5B0MQw0NsrBlKL14lHx
	wOQD1Iv6j03t6x+0vdbJslPN3ZXFq6YA8e1lBW7SZ1sUqnemuyuddmQp4lXnWM6almm03VYJTqK
	GHlcKqaUaZDXfabhXmjKdcV+o/blkt9OeAM3RSfFFXAZ8g+V9LTkAh9dB+pQuRmkgFzB4oiGfrr
	5T2y3ZMLjCbkt
X-Google-Smtp-Source: AGHT+IF36MiSLKnQ0mY6ha/J7VrS9TSHi+eTOsbp/dFms4IxxT9v9oqfDo0ShKgLZxdXVi1seYW28A==
X-Received: by 2002:a05:6902:844:b0:e84:ce8:135b with SMTP id 3f1490d57ef6-e898f8b21d3mr4414589276.44.1751548701164;
        Thu, 03 Jul 2025 06:18:21 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a6:1600:d474:ea:3b09:dc6b])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e87a6b61f65sm4361908276.13.2025.07.03.06.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 06:18:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH] blame: avoid failing if ignoreRevsFile does not exist
Date: Thu, 3 Jul 2025 09:18:09 -0400
Message-Id: <93842D18-3051-4169-B314-AD5A1407575D@gmail.com>
References: <099c2a59-ac60-474b-a535-ec7dcb1f44f8@app.fastmail.com>
Cc: Francesco Nicoletta Puzzillo <francesco.nicolettap@amarulasolutions.com>,
 git@vger.kernel.org
In-Reply-To: <099c2a59-ac60-474b-a535-ec7dcb1f44f8@app.fastmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 3 juil. 2025 =C3=A0 04:26, Kristoffer Haugsbakk <kristofferhaugsbakk@fa=
stmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFOn Thu, Jul 3, 2025, at 10:18, Francesco Nicoletta Puzzillo wrote=
:
>> Setting ignoreRevsFile globally makes the blame command fail in
>> repositories that don't have the file present.
>>=20
>> Check that the file exists before trying to parse it.
>>=20
>> Signed-off-by: Francesco Nicoletta Puzzillo <francesco.nicolettap@amarula=
solutions.com>
>=20
> Relevant thread
>=20
> https://lore.kernel.org/git/20210807202752.1278672-1-noah.pendleton@gmail.=
com/
>=20

Indeed. IIRC there was some polish to do on Junio=E2=80=99s patches, which I=
 intend to get to unless someone beats me to it ;)=
