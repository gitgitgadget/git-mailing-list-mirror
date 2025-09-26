Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8628714B950
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 01:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758848457; cv=none; b=k1Ezclh+Lt+sR/tlr6iScuCRDUGdoEtecOUUcf8zOvwhNvQnQm3ZQ1IRet8ofKyJMpMEUefhuA6WgOL/uonWlb0cm37+bs1rw8Bm19/VvNathXwbmh4pYRVDWlgW4sxXDbLZJMPUGI4ZwrYj9Nbj2Va6rU9mByr4j4gtRf7NsDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758848457; c=relaxed/simple;
	bh=9C5PtoWAGTSC0QnxZYuvIuZN2zLeomHUR6TLgohEMUE=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=HGzXIeZ4uPADA9UNw23S2qz9v69SaDth/hv9LyOg+jtEVJ6e3m+y2EFOv9yn7zcMiEhUAaRS8NnsLSSAJMbtvZDoEdMZVyDOLWmmwFR5yZM60ESXxjnnafCWF0A4DOZGk6Q7POwaLQDlgEsJU+OiYPs9yDyVm0/J8iLkYN3GscI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsY08xrg; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsY08xrg"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7939ac99c29so1508174a34.0
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 18:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758848455; x=1759453255; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:date:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9C5PtoWAGTSC0QnxZYuvIuZN2zLeomHUR6TLgohEMUE=;
        b=TsY08xrgRCN7d+q6iecNxKVZ3+YwDMaX0sexCJ7pP7Il8VmokN5GQMjbAEddX7oyBZ
         N9D9Xxy7poIbp8wglAdjWuCQyxwHYq/psh3v4eqLfmTnSU/BgSCQDUDxy7Z38ZDk8mG7
         SeKih7EFWluOryJwoyTrqj9ZcYvZUWxdoO94yEV68ydQo+jalxBB5lZ6PsyeVU+b1+5N
         OaPmWrLQEytfTAsYRbt/q1ECK8QI5kpKG8ZUkwYxo9/upC6FpiXTXJRH9pbXswCj6xwf
         lVx185hBeprbZ7m1nRPinTmf/i2jM4W5vojetHLrsrnaFjx59W3xcLwj4vcp5zaAgIhC
         KYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758848455; x=1759453255;
        h=mime-version:user-agent:autocrypt:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9C5PtoWAGTSC0QnxZYuvIuZN2zLeomHUR6TLgohEMUE=;
        b=bOWtUY8D83eixV80AYeOtQfyGhne4AtdmazTxAVRLX/kUIq+BVuV2nDlOIPfZhbKiE
         TZ5SnsCfzmIGiXEu1Fqfa3fg4tx0WrVNgXdUlw7jYFNAuWj1AsudGDL6awDVWG479xCS
         MAfnbl4frkLXjc6zV//6J30F+eDfsxiwoGv/WOHL0Uy3k8AO3J/eQpYLfFl16N5+hOSH
         XVaRVHvF7MH9pSFZ7Q78Frns4sxi/ey3xufvjkoBYgnvqdNvB1NueylKZczA1umuLge7
         SGBVCKyNWkkpdOD3i/Ma3AIS/MxyWbH6yQyEE3w12b5cJL1Cu+RDjqA4LIM8oEyRZjVH
         Oi0g==
X-Gm-Message-State: AOJu0YyKk5BjTc4Xic21QmgAAPseYLft+tILgcm/VPHP3tyw8yynMrH+
	4z0NvHh+w4i/jpX+Vu+qxnAhGMClel+ccfzSM6fA8a9+pJz8bLzNnHlNe663n5am
X-Gm-Gg: ASbGnctTXz8OXGKhSlgvNONgvyzjkRBYzR52bbkAcImtzhJirHlrM8grNxVjaB8sv47
	XhWkiVQ7EyOr0eUO6kFWS5ioGh9gMr9Qq870hbA0+sJFZnOk8P8onQ/y+TT7wLWlaFqcNl/n3fD
	DRndy8s+dTEnpgDQJdKYba50pwRWG0KU6edG484dT2MO8edCGI/eYrD14R/nwWt68nTj+H8lBV8
	Bhum2kfZXFedOa7wuE8RUjmgBf+eBhNnrPMyYvymVJE1JnbJI1vCdQ86lVgD5ihtioq4On3QTQE
	pYurhx2/YfkwsmoY3JCuU0JXib+PT8HYMObEEK3GQWP5Y0D9gqywDHEGBAotBSr+Qyr8XesDFhn
	h6qb0G4yh9+6pmtbGAy42meIcVyGxB9Ym9FyUC2Dxj7wH0B4JhlXnLYzr7m7oeAvyFUKwkdSmzf
	QBpc7GLl7yJ1dIJZp5maiLevH3GWe/HTQ=
X-Google-Smtp-Source: AGHT+IHJosLm5ry1yfdKsZa7J5JFcR5TSjxFZ0vR2eYUUE4Nz/p9Od+jL2YGlt3SQClQDuj3LKOt7Q==
X-Received: by 2002:a05:6830:67ed:b0:757:b8ad:c2b9 with SMTP id 46e09a7af769-7a03d1226b5mr645493a34.1.1758848455256;
        Thu, 25 Sep 2025 18:00:55 -0700 (PDT)
Received: from [192.168.0.171] (h135-135-197-41.abdlwi.broadband.dynamic.tds.net. [135.135.197.41])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a6a5ae6b1sm1290995173.68.2025.09.25.18.00.54
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 18:00:54 -0700 (PDT)
Message-ID: <19a81573bf1ef7c544106e8fa7dd3b2db304c4f7.camel@gmail.com>
Subject: git whatchanged
From: Neal Miller <meltdown03@gmail.com>
To: git@vger.kernel.org
Date: Thu, 25 Sep 2025 20:00:47 -0500
Autocrypt: addr=meltdown03@gmail.com; prefer-encrypt=mutual;
 keydata=mQINBFnLCSkBEADELqmI8SzCYyZjwjnj3SMT/aKHSWCT/xuJlkYRBGOVakFEYMxBHxw2H
 HvVgVS5QbEIC3GAfmdL4HkxAIxlsVXtuNsWdOM6SQQJA/RTekf6Ee8+1qk4kqwPuu7JNayAL4PKy3
 napZhLAu1nUX/+noJTPDICKXw2H6VTirvi5w12WWJ4PTIWVlI5f4bjniZy0wqwu+SSLG+9gQPcNnq
 /FtXzQKeuz+sH3mVSAx1iG9RFZsM28bTltbo47s4k4hwAUZpgQXuxX13IO0wTVzVCBxMUmMTSTWiM
 1C+nSPnjwsUblbHkwdkUf6DXnrdKxoL4n1f3nSUPX7Ey+KVXyThx2SCdkU22Qi5alssYkOSMvN/T+
 Rmyc4l2fR9/oI1M7WUsz5Eip6G5jlbkJ1WHAOteNl36+yj5XYErPlf8L74LgkgRp5YeeUlqNoWwF2
 Sw73pD7C8NsjnknFcIG5E8vWgWgqXm66eoVKNxd+aV9a16gjOJQ+SSPqO1wHM/AiVuAYHJPAFGjqW
 3ZzqmQpetdgclrZgEHIfcdNVd8Uf+SSVeEB7ty0ndPo8G5Drdt+1upAxO2ffXmahI4iBs8OOAloRi
 lX9FUBHiWJetSHCaeOLxMvBpRDls2X4wSdQAQ/NeMSQX8zVuyNsmOsk7d4s949tONGBp6/nhkDLkT
 sS8GwCPeRIezQARAQABtCJOZWFsIE1pbGxlciA8bWVsdGRvd24wM0BnbWFpbC5jb20+iQJOBBMBCA
 A4FiEErYqSfL3b5eA6ZvbjB9s6hB3b8q0FAlnLCSkCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4A
 ACgkQB9s6hB3b8q3G0g//f755fxY1/ONx2YBzG7efVu+6t3Gczk7H1fpBO1WLk1Q4rhCuFHhdtMbe
 lf9LkTrEeEdet6wgi/OdwIFEZCDHhmM+LFVpd/Agu3jC79ae1kVfIp1au4fKc/38w491rljRIMjif
 yi/8AEgujYlaU55j7ixDUkvlYoIwM11UboV1NYeaidMRSP3vrE7qNhLh2WLjSZLCDWO+j04/XwHu9
 16AwyLUEUcI/QEZZQ8tildBhLidaKCZ4Erq8AD7hoFlhEWUMW8JtJ5eY8OYjXEVzg0Q5vmQp6vd54
 957dfiWaUeiJnOcjVHrQp2EXPKRLLN05iuWHNUVdevc2BVanCWsVGN78Ssea1GEINZjJMyfgnhJJV
 k8KcHA6EEAaWg0c/+Ojk5nDa9IuZoI3uemvGb6fdDqYdkv/VdTIBM+sLNeF+IAEFRbUfyOLTkN/HN
 bDAGrTSXw/MM0JgaMaxt2LUkEcCR+TIjXqYoImtaDpwRbVXntC08tzVksboJW0O1h0sdCWgkPDpdm
 ZdbvaZPbO9wPyTJdcthtevIwLUeZwC8V0wuKtTgdBBdpPkK0nTPI9/x5LGLmzcq5Lkfsvm5BEtmPu
 ABfMch5Imbf7u3SJwpB6SnGvzPPSTmLN7DQOtAeqf+wznvjQrWSgG/W8ZGbC92hYbuzaqnv56KPpw
 i0pfqRILEXM=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ozOuy1Maz4vKeZo9zJCc"
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-ozOuy1Maz4vKeZo9zJCc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

--i-still-use-this

--=-ozOuy1Maz4vKeZo9zJCc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErYqSfL3b5eA6ZvbjB9s6hB3b8q0FAmjV5cAACgkQB9s6hB3b
8q2X5w//epShgkkpVtlH09CPoZVU/Qkn1XgzNxu998+ygJ2MJQCDM3EPxpbP5Stm
RsG3qea5ysB57wdVWjm3QcNH5fnZYNaBZNKjT4iAbAn5jrPEkAJOkcpXtIktDvBB
euTRLAkaRFzIw7VCyblmFI4ux1z1jEezoZ48SkjvMTCAU/zEesY1iddvhp1pENAp
6dUubed0d5/uhbc2FvJ5KmznvH1p5xvYdKzcuFZQC5z5FMg5GxemBKZ786PF95pw
JsHgjhZAHEVBFUYI9egSUxJblORKXsqYSJhWeS+waHdsa8UXRRsjmIN1aT+cTPXd
Swz8iLVIqGCjqySBM57puqKnhl64PS9QAtHsPGmpeZjOB4WTvT2n3GCNx/VhrGfE
iuixSq1/a4m+iwnC+UwOdmLWuWlVblbx2cO9BMFzxowIaH3lzl0oBB3pyZ6iB7tT
S1p1ZfWRMwahkpnxNzzJiUcWIxT7YjRHxW+ZhjETLMulQihZdpWRrNgHxzBH49UX
66OQc/I+h8niwR4RdUnvEHbMpk50qxlI17rwucZOAN7iNJLXSsKT+POtAoUCo7V8
qNyU3YToWfGpj+04Y6JzH/Zj2fw9dlAv6PdpQ6exHR8BlAHLnHrFve3h5h/xIUs1
2JKBdnT26JJ+r1E62oGcRrMwwboI/E+Or+uCijf/sdEsaVCXDYM=
=NfPR
-----END PGP SIGNATURE-----

--=-ozOuy1Maz4vKeZo9zJCc--
