Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE903203A0
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774001321; cv=pass; b=ZHCI3B7papY0Brj81dkH+C3Z0NBmS1sYjbPVdisvp036P8uln1eP069xi6cgqPcBZBSPPZ4GaBFmvFrvQBQElZqBjuPBh2SNSvbug3CbNDRP0O9gh3hCW+6MXHeZPhIZ5aKKlYgYj111WFWRLXDicYI1XcwodHW+4RqNIMDvXRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774001321; c=relaxed/simple;
	bh=AWMcxdq73WhByLamGvkqmKE5HjO22EmiqHp+1XHzQIY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9p7NhC8VYZJxO5n1HJlgMz0kEH+QfWfMYHQuql7QJ0rohBbQlr1UU8JbH/EcNej/liIhqw0M+Kef3ykP4NESuO+VEwfkY3/P0i0dEqzr78lRepcivzutUokAF3x0qsANRo5mT+QIfUFfdKfb2NfA3NJz8zmj1hfPgod6Few0Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjOKgpCN; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjOKgpCN"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5ffc6a96665so101890137.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2026 03:08:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774001319; cv=none;
        d=google.com; s=arc-20240605;
        b=A31VWzB2mwdNoR+kbDQneo7ees01dX+59p2P2THD+hz4jTyNocs1zLkKom5OqgXmwa
         xn2W9HIhg/VnxGLNtuHynPNpcM+UZPAxWdP2mZjCDOI9FFsxQVU5+QBZ/Fpg7fBhcDDz
         a5Oqb8iEjN+2yYXuOpzOb+RQdazjXXpL41kXCxY5c3gKnWPS0CZ28FT2OBv0NIyUcIpj
         9kPQ76qfFho8yHK8lQ94OSOkTUv+yem+Qft7N4km9yafVBYv1oaLKBvNr1h5MKVtlP26
         K8FmC40m3DP8NwRr6RVhCFN9pWHRkCPEFySnEpjgRQqM5lmS9zaXPe5Nfs4q4ps5CMrt
         /T+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Ey8ksiH6wefmYU7OePKGbe0H3T/Jujn5DoSoXUspy6M=;
        fh=1u/7b0e7MDnuhW7H/xRENW7tNrqLZ8bFhbsSPfobDt8=;
        b=NaZ2jY0YmaNv2sFUM7Df3AOQAa92yf+Q2ni9lV2L6y/eLopTXdDhxpawZI5UYeZyZ7
         yi3N37CoUZkG7h4dVQEju70S5itvAvxzqMTJKlqBwilRh2DC/0uIeZCWv499gahGyJlB
         nwoUIgXvvAhChYPG4Tbgtwkv3YZCzgLF+7zyoGQ2icqrlSSOzscG5rcMSrR4arcnV15Z
         uJJ7p03uJF5vSgmSOgzbGGDgiKQ/s6b4Kod14yHXwwbNPPFDwDlMrzJfpFeQ0nUZiCOF
         ODW7XrGTCkMMPvtDTx2AHYu6+tJT4VzfOdjXaK8IX7Zq6HCPqmpPh+QKLZWmhSDQWSXU
         Xeow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774001319; x=1774606119; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ey8ksiH6wefmYU7OePKGbe0H3T/Jujn5DoSoXUspy6M=;
        b=GjOKgpCN1XVjxQrE3yZL9WYNbdPQ6UfMJeudErto5i9YYlOl6fIY+lAp/GGBh3QV/O
         9kI8bBL08G4+wcfZ9Qed3UDKFVfbn2AvFYUi96OrTMOWyJGdc4RriJ1uKDYLWPFZNK7o
         lIzYnIGGDqR9AzXJ6XgCpU4wJZXWhWLbthY1M6/mJcM7o4vjX4B/L9Jf5HrZZZoVoCL/
         Y1Q88qbOO8J2tElX6xA74Xd/t9BnuemUKG3SR+Ag/pxPXL0xfwwh/4ZhHz8Gy79tO2Z6
         TKjtfMIUXvFV9pYW95c1JMiTQgQxOiA2nYsVngTARzoRwXpT9r4vLv5BkRFmwSADhUF2
         jgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774001319; x=1774606119;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ey8ksiH6wefmYU7OePKGbe0H3T/Jujn5DoSoXUspy6M=;
        b=cI8jtruPrxE4s/Lysij8FxP8ColcnVQH5LdHycL7vVmg0+TghSTYQMkdJP5SKjQ0rs
         kCFBt1+R9wqvdP1MMmx0irKbdmIYIayKQQaA5IcYMM+Q7YAcxvhaGjmCLI3VrqZlWDHF
         c12SC4ZOlRhPbC+iZ0G3UbrNGNVJRShlcGBROGLms6p7sW0WRo7QQeAV3En55aE37yZL
         XliHGV+hB5DXqGhpGO5W8i26j0wYtMDvzil1ulpxwLP8WKyZ64czUmR/f22aNUsrwiw4
         kxp+rsPg9d6EaFleP4Bkxzwr/HrJO+u4CvKcZK0yfNgnb5zhJKMs/s3iI1Sv84fsAxCZ
         /3OQ==
X-Gm-Message-State: AOJu0YzkaFglAuM7W5CL4TjJHa24nPqaL2uhJJek1pSIP3x/uFceHMCA
	VhaB0xsUr9A5b5EGm13zCMByR+9SUsDVEEqTwKHEh1Gwj22OwSreRO2RWw+WmxKtWij5/CnOx84
	I3lPZdNG7iVJpzkF0y7qM2Lp4E9++fA4=
X-Gm-Gg: ATEYQzwM6lAny6X30HkpwsganeUH8myG4KwQFaJDnj05cotHEV5+WjY0FQ6H9IEEi0k
	a4l0XZFbz33MGZhS3If4XcSLuWmcfm5xR/xS80Cnm+UyKtRxChewGjobOFQarHyKH4XP6Proz7H
	B9aUXi6y31DC2NchWYFsYhRx9tOaNosRTCK3gVKBytual/9s/iOqSomjulEnZ5nENjDqHSWZogw
	GAGT34mppAccL2+63WoI8xwGIlIK/eaBtHGkxGfQ+khLT1VlfVIw/JA3Fl+ElR9SbtMz7FPlwqL
	jRiwK6it
X-Received: by 2002:a05:6102:5494:b0:602:93db:7fa with SMTP id
 ada2fe7eead31-602aed91b2bmr954961137.33.1774001319303; Fri, 20 Mar 2026
 03:08:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Mar 2026 03:08:37 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Mar 2026 03:08:37 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <8669d87c1b7f96dd0de37dabfb9011c8745a17c9.camel@gmail.com>
References: <20260319160301.98039-1-elkhatabibilal@gmail.com>
 <20260319180803.164335-1-elkhatabibilal@gmail.com> <xmqqv7erk5oh.fsf@gitster.g>
 <8669d87c1b7f96dd0de37dabfb9011c8745a17c9.camel@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Mar 2026 03:08:37 -0700
X-Gm-Features: AaiRm50fQYh3UTxvELo68CllEdCZvmCoNLlnPjcbxMQp0ZMqN9oY7jTcHAVFTPM
Message-ID: <CAOLa=ZTMR67FuougYKrd-=5Ags_QPT8q6x7xjObQV_KSj2KysQ@mail.gmail.com>
Subject: Re: [GSOC PATCH v2] t5315: use test_path_is_file for loose-object check
To: BILAL EL KHATABI <elkhatabibilal@gmail.com>
Cc: git@vger.kernel.org, pabloosabaterr@gmail.com, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="00000000000077fbea064d71de3f"

--00000000000077fbea064d71de3f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

BILAL EL KHATABI <elkhatabibilal@gmail.com> writes:

> Thanks, Junio and Pablo.
>
>   For the advice, will do.
>
>   I=E2=80=99ll also spend some time reading recent newcomer and GSoC-rela=
ted
>   threads on lore before sending the next ones.
>
> Best,
> Bilal

One tip is to not top-post when replying :)

From Documentation/MyFirstContribution.adoc, we have:

  The Git list requires plain-text-only emails and prefers inline and
  bottom-posting when replying to mail;

- Karthik

--00000000000077fbea064d71de3f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1a2a44039a3e2d50_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tOUhLTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOE5YQy8wUWN5bEsyemthcU8wYStDSEhpaWk1Vi83bgpnZDdlTDQyRnE4
bEdBK2tPcmd6eklLbTRLa3E4TmZlMTVKZ3RubkEwN3c0RnM0dW9hUEowNG1hOC9yMjdUaGpwCkcz
RnU4cEN4MlUzMmJJRTJHRGI4OUVYQXpmMjZnMkZGUTY0R1Y5eW9zampYZU5OK3ltLzVDL0dGY1ZE
cWg5MUIKdWJ2Tmp5TU9XOVhVVHBMK2QzYitwS25CazNLZThtMDZndHljTG5XbVZYYjVtMk41U2xN
Qjh0emhocDBxTUNHcwpJU3oxQ1J5bEsvSG1BQkp1TUgvMUl4aGhJbXNKVE52V1R5WitoTlhEM2tu
b2FyNFNqR0ZqVEZxREliWTE3R09OCm8vRGFVN3RSM2JKaVMyRjdKcE5FUTk1Njk5WlJ0NVgxM3U4
MVQzVGdXMXFYSnFGaGhUZzhnQ2IvVEw5YzQ4RC8Ka1liT3VpaVY4NGZhZ0tKS0M2NFFnUm1iOEhy
ZG5pSDRJaXBYTW1LNi91bjZlYnNaRkVSQ2l3Z3Q5WnV2aGdIWQpRMEJBcHRvS1BQL2s3eEh2Qzdr
ZXd6SVhVODlmSk01TDRTZ0I0RGM4OUlHSHp1OWk4U2FyMEJzLzdPbFAyZjRyClVjb1lxdTAwM2lS
Y1hicWZ5TGJxRElJdXdXMGh0NFBSVzRhSkovQT0KPWlhK3EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000077fbea064d71de3f--
