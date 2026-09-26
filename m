Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1784339378
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790429647; cv=pass; b=MtbfcbA+z8D1DwjHDb9x0F7AZYpmh15lkP55SloTRKRSM7Uqovtfi2CIeS6entudIR9SQksJpXOmhWrLgcaMOV36cg/SzAzDTpObYMvKeqPJhODRBz5+CtU0W3xHkbblfnoQlpcoI2irg29O8B7lummbq+OFeQh4VepJpNHyP/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790429647; c=relaxed/simple;
	bh=+A43Hd6IOwcJtjUbyJaYZEEWCfYIrkvFBN7j2x53/eU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdjZ8LVf4H+mYlZ84SJMzc91FTbM2z6qNby17h2MVnjDiNfYlcI9xRwNNw1pkbBy6lRYXEOd8QsbDnuEYY/sdevt6Bb+vct0JJ4tNG6t7P2cxvGLnM+QflArjbqUHql1Fmete8Uf2CB+P4OW0/Yuo9Ewz/eHZfDWoKo3epUBrVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tl3W4nty; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tl3W4nty"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a8b9acbc6so250362366b.0
        for <git@vger.kernel.org>; Sat, 26 Sep 2026 06:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790429644; cv=none;
        d=google.com; s=arc-20260327;
        b=dawLTORcS1SqFt4Khn75D+txe9blx+F0u5ZalT+VKl4U2t65FwwOjeK+jMuCb+X6Ez
         qdssPz1yql3LP/6qO3r4CMHw5EJiMg1eKEWe+cA/SzcfQxK1FAm8EqT6Y5m9hG3tOJHm
         Mvz2IK6DKrQsjTltUyGA+EdRIOAu7AQc6rknL2KJymNWJweP1ZgIGwBnRYNZ++8hRgsl
         lYz2uLyrokMTVhRNAYfcQwlJShvP4DQRG8v5RR/A7h6SuA/v5FB7A9Oo4Rx7Y+lSwuFM
         eReEaf2DB76eNEbSODNR4P/qrgI59aw8KzusFGvCDocVOiggnClACDYoe7Ep28Ut+u5r
         4VSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AgUARw47pIKi4thqqfFGvlHoaEN5Z7OBlQAjRcxIgkA=;
        fh=fG4W3YJnPJalguEcyh7DPNe1AFTApIcLZ5pQ8ZUkRJA=;
        b=ZLhMROm89Djyc4YV+MfcHz2Z39E49gYyZ41efN56JYdYLLyNnsSL30xNGvq4Lo6gMQ
         PCL0UWEylPBPDXxYJiIOAP47nKnbgGc81v70dtGBUHtq39QV7G5sMV+wM4DTEPW6jMmz
         xFVsfd5N+XnEy9Z3TDCPUrQZuRGXI0mw/IMGXo9jzRQKpp6slbhmxduxDBSJ1HhUwO8Y
         fnQsvdhIqYvN+s600rLh6ro3/zJSMpT54vWzwemmZjDPkdCbb4/NggVE5//jUc7/Su9m
         0cMIaEs3ASWn/ALGBc+lumknv3glcqK4xzltP3sugv9kHt0QdIGc3zph4BVEeq7LBtMm
         GDiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790429644; x=1791034444; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AgUARw47pIKi4thqqfFGvlHoaEN5Z7OBlQAjRcxIgkA=;
        b=Tl3W4ntyTZG3LoB7l54+XVBr97hFGRa2ROBF1gWEkFj/5/FwxowkGOcqCZdPANRmny
         AfbT3qrftJScBpXLrXOAMZuApQj96rGilVAaA/79YV3dFQiwOQGH2qyfX8TC1s5pMRd2
         WHmD/ZgI12HUae/cO35KL8f3ZORnkEPWSV/ZiPiYclzigEHzBcvWrzs8OSOULE0Q+2zd
         NgPc7rhlQgizyrxPEIp/Ml/K+sFATbqYNv1fPN9yIp0hJo7B2WJDsrbK/fhk03PTe17S
         rIBzvzg6xV/wXzCv7J8yXxd1qlT/OL+cdlsgM/5k0e+9LKNOaZHAxP/upYJhUFoU4ADS
         0Htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790429644; x=1791034444;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AgUARw47pIKi4thqqfFGvlHoaEN5Z7OBlQAjRcxIgkA=;
        b=Db0wSUnvQNLnfo3QUoAkqpNJO/cAr5rxfrzHJqXwbGLsFTEdP2FOLJLQQU0HjUj3wN
         UPn4rLQuil2lnbT9J1Svk7TswbagAdBgk6Chml6+nC6GwR88BgdzqDFg6MaNFE/Amk4Q
         s1+cHfTzTxUgsELKdh0pYsiSRGZwL7lI57Dytc0CqP/8Pqx8ft/9K9e/8Tj5+urY/vO4
         uBffyOg8Op/IHLou0q1+Q9k44iwga5cU+iGJIG35ClLyh0Cn1BGfO7d+OJQED9aZ9ouo
         25HVC29zqh3/iiJo7kYOMYKVnJOzbGEfZzUcebgSqynpDrc/ZBdCkGahdB225Z4PZ9e9
         CvJQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRcUp5MjYBrXYol2mhEOMZro+SPon5Kp5fuPVeGR6sc/ah6uGvZlxyfAb/88gTi9WhvWU=@vger.kernel.org
X-Gm-Message-State: AFuF++l6qOwsMXNBxAx+mCyRTc87o4N+NOOkkJtRtOBDDyD54znE0jN1
	VpNTzxdN2dtd8YBtiBmS34Ms4ojbCEWF+8TgXk0veuWXWP+uBMFCPXU0CSxAxHaqEXoNp54nj4b
	MSLKkVMntJ2H9HNCdt4xVIWR0ZSZly40=
X-Gm-Gg: AYBFou1Flgos6oHCxq++8CX8X9nZaEeefrvU/WQgdTDGtM6sespS5pWHyxDNuzRu5tJ
	dTkG96iYB1byY8NthGPYb7wXpELrZAiFS+yB2mxLNsMgzYS0bR7B8xpjE8STh/9TFtRuLe+tfuX
	pGDo+xWuhxA16mxJO4PPSZddCxL6RGPL4Od0CF/s98DLc1NpsPWkN6vAzlXoB1Fa3irgiS4c3YV
	BHfwia5r2gpsfaTyKJkVVU4ln936MWnzrEsYqfd4IngZ4I6U6hWkGO47wL0z2jjoOytNyN4BKKY
	PD+qcT6LTCe2xTvZSTeXD0VaSg9s/cp/gyTrARwQjVuG8GP60pPh7tqFE8/4gRr2fg==
X-Received: by 2002:a17:907:c308:b0:c2a:3473:6780 with SMTP id
 a640c23a62f3a-c2ac23ec156mr737502966b.25.1790429643870; Sat, 26 Sep 2026
 06:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2402.git.git.1789199739368.gitgitgadget@gmail.com>
 <pull.2402.v2.git.git.1789369749450.gitgitgadget@gmail.com> <xmqqik3ssk5z.fsf@gitster.g>
In-Reply-To: <xmqqik3ssk5z.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 26 Sep 2026 15:33:27 +0200
X-Gm-Features: AclHuK-FAhbBKgb3xKyR5KChDB4uejrQI_c1v60dYNI2L6HnONaOB22lb45x-Fk
Message-ID: <CAHwyqnWriajr9HHeMhRxO639aeottL3oux_cro6Jukn5L5yXYQ@mail.gmail.com>
Subject: Re: [PATCH v2] ci: drop no-op gettext link on macOS
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Sorry, but I lost track.  There were review exchanges on the
> previous round, which crossed with this new iteration.  Is this
> patch still relevant and do folks on macOS need this?

Hi, no worries!

Yes, it=E2=80=99s still relevant. It=E2=80=99s not for local macOS developm=
ent, but to
silence a warning message on the GitHub CI builds for macOS.


Harald
