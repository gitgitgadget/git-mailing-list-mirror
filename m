Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C1334F48F
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861440; cv=pass; b=J1r1Za3W8X2Xqx2juxUSuTlgIc8tKmCRLk6VQkzKR7l19dsbyZA/jtBeXK+zzm7nlLac+OccDlqMo6gxQQfagutxBPB6idR0uMXhXD1JwhsjDNZYFsXVhs2p7lQxLDZL8sFeT4aAQwcgiLeeS8BeAKJ81Ups8mi+3yI8MdvDtEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861440; c=relaxed/simple;
	bh=J2OhIeIjC47mGSgWhgKaio4wDx6OeWbEoE5w12Fms2U=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrjLRsMO5/hhckzMKHtqUZS/9aqlR4vy83qaC550WzWbu8OxRvn4bBfL1YxjuqohekWTdJr7wQzr+9nKKJ0YuFPEat5e2WMuV9uB0eZND1TW5gG9g31/cCvthejF5cygCueMY+wioqgB2eSX//E0EtPYieNcDUYImSfAfCLik4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqWJCU39; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqWJCU39"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5bfa4c51c2aso1792022e0c.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 02:57:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788861438; cv=none;
        d=google.com; s=arc-20260327;
        b=n9hf4NvmL9A82v5VyEQ0BYzDzXqxBxP175yo46vzzLiP8M3oAERpicwE9wEFkXptci
         DSY7y9+0511FflRBR9XxBkWAXdpbkUagqgKpM1eSEzP2YM+kj3CzZ6VsDsXH5y34FMn6
         3X2GbHENSkhtBB+V2hXr7i/8LRvEr2SNmEDn+SqgM14qi5p55G40nifc3P9VBIPo4Rqi
         T4lUJvO8PhZ7dLtOxtg8PrppnsHKdhxa6gUE1Uru+BfuWbvPHnA1+jU2OqQ2Esq1MSoU
         3xJDmpQR02lpu61gpdaEHBArGG0VsLDD7bSGnSrRtSs/mHwM+btWzamjF44vYFYhSNoT
         4WWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=uDciJAArqovFR3Kh/6dCeawqglUagxgT94uPiL0fACk=;
        fh=D4uDqIpMAU76UF3y7kLhifPMaIKyWsi4/hRzYZ8Ccvc=;
        b=Loz0cl2WHt6rdrPuHYr2LjDTfd2FNcn665BdZ/1iHneT3wfiveiyIDSjgF1VxGBYT9
         4ummK0jzGLo69dxZw+fjXv+ErRnCoicbunuZ0dXEAvB8SD49NfOdNhGy7mnLVo7MxhL2
         KJGKjjwpV29X5V7a6W31QQAZTY9OJmpdvd0RBKzEWRU1aCOIOabJ5c4vLPOjWUrXcw0X
         wWE/sxLiG1xLNF527XAIavZE7s8PfuLJB5lEIwQSuYWqGVLq8QbKnD9WFr7DOYtM3al8
         r3DR/zXodYZonO6oCqRB0/yFmR/HsATBgR1vds4wcuUZY6HzVh5Wyi9sIyNJru+jYWeL
         fgYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788861438; x=1789466238; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uDciJAArqovFR3Kh/6dCeawqglUagxgT94uPiL0fACk=;
        b=YqWJCU39lbMx24GOi0+vtp7cD5kIn4qeV13zueJQ4IRlk4UtsaldJ+YCBoFg0EnhO2
         2eVRhLT8Cv4V779p/PlvmRuasEUAaLX90G3/BeJvvhVENViZKAubxYoOA9mclCtZkOiX
         UiqPg7ZZIiJjNQeav0byWeas7pwy3qpZ1gXqO81dUSxyYDi1hJDHVjTExuqG0vNvnO4a
         sPo3aEQRQa1Neb9+0abqPCJlg8oXncygZMvjJgPlsUwnxhcDQDOMbnIBXDNgwh2BmP8r
         XFqSRlQC1CsL0EPznmz8SCGP6teE/gbFHMIfhiK6QXMaucoWqQQo05/dvzNy6fulYBC+
         Z3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788861438; x=1789466238;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uDciJAArqovFR3Kh/6dCeawqglUagxgT94uPiL0fACk=;
        b=efvcQX5RWpD6iFRqPHMpYGmuCrlkC1FNyPUF5B/lZhMv1yobJGxL4G9xS3UC1ezd86
         ElGOwGt3GffG9cz6WPrfDyzoFIsHHViOJT1OR4p1iRXZH3PYmn8nttkiAAw+vcfdOrFZ
         hhtu1pSPL4dXquzCDzEj+oVFJNN+DioIjoKcjO/1qDIhx4LYWTJcCxXWkyWDuAbPZ0vI
         hQXB+tIXohC5aRcV1bRn62drAc8Oc7LWEC0I52OY4ta8isAl9y4Jal36aHzi2U7MkI2h
         F7r8FR3XvAlsOr80ycVWnGF9D80nsgfwS5mS0U+kT0w0LXV1ZVX35kiI6OK3iS7ak41D
         3znw==
X-Gm-Message-State: AFuF++nOu9J4tQsgZbaKspMgsJTs4hNwmd21aGU+DaIWXbYWTX5PdQye
	IfklZ+fFIGStDp1dhkbIE8FT6VeZTWuH/WGtI24/oSKKlZz+WiK06MFNqY/nWwvvwoDOR7Ll2Py
	ppH7YRo71vRJwL+yRjwhDW85yZAtz8Nk=
X-Gm-Gg: AYBFou2b59bP/Bp72SRHxJFGVymKm802gpmdK8O1K4f5yWv1oH2MybcFmbI1K6Ihogg
	C3Z+yH7hmL41b1s7cGxpZCNFRTBQnth9Vef3fpQjefdZOVopFjMqD/5bkWayZiwXh1qqNsSG37l
	Ms6syPPJ038nxS4O3kd3n7Ix538hOhR6yB7sOUdxyIB7Q1omgEsTE7STlLGVz3uGSoHVwfZcKC/
	bS9/AHcRl65kP5fR2QYWFkmioEGra4K8pUQSfqXP9QPcWhGA//8csT5Zm5F8KMXxOoV7n/n1eIu
	TqYl6OUYyoP9d134/CfO6XOTYgswKh2qfTgOdyRIkbexetR3CS3wQfqRN4rDq+iToV4heh/OVTx
	nwAfBpSOiZs72ahF525uZOfyLRAdfpHo04M8=
X-Received: by 2002:a05:6122:da0:b0:5c7:ae9a:a056 with SMTP id
 71dfb90a1353d-5c7ed457809mr11832136e0c.8.1788861437760; Tue, 08 Sep 2026
 02:57:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 02:57:17 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 02:57:17 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq7bkw3hk7.fsf@gitster.g>
References: <20260904-758-introduce-hook-v7-0-6c66f0a3a572@gmail.com>
 <20260904-758-introduce-hook-v7-4-6c66f0a3a572@gmail.com> <xmqq7bkw3hk7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 8 Sep 2026 02:57:17 -0700
X-Gm-Features: AcwNN1XaUe7ZydbWdd8UEWgzV7icbu07WenlbcbGge9awQ6zXx9GD7cvg-OV-v4
Message-ID: <CAOLa=ZTNMwJkXZ_CuKdR0F+_ZAxtr+eK6o=tjgUg4O4vFgPDpg@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] hook: introduce the receive-report hook
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com, 
	kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: multipart/mixed; boundary="0000000000008cec6c065af5c298"

--0000000000008cec6c065af5c298
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> @@ -2469,6 +2510,12 @@ static void report(struct command *commands, const struct strbuf *unpack_status,
>>
>>  	generate_report(&buf, commands, unpack_status, version);
>>
>> +	if (run_receive_report_hook(&buf)) {
>> +		strbuf_reset(&buf);
>> +		override_cmds_error(commands, "receive-report hook failed");
>> +		generate_report(&buf, commands, unpack_status, false);
>> +	}
>
> Hmph, what does 'false' mean here?  Didn't you mean to use the same
> "version" like you used in the previous call in the preimage?

Indeed. It doesn't trip any test as we override the command error, so
the version argument passed as `false` here is never used.

Will change.

--0000000000008cec6c065af5c298
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fcc1abeaa04106e8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xZjIvc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1melVaQy8wUVZVcm5Hd2k2Ynd2czFzd2kvOEVPYWNnNQpGRXJmUzFXS2dO
MGY5M041bWhiNTZFSFE3WSthZHJmMFZYRjFRZmNQZmpPaDYwSDBLMEJFS3UvcktJenVzZFJWClYy
U1RaL3pCcE5PNW04QjV0ME41RENwVm9MV0Q5WlBod1VJNDM0SnhtWlF2QjdkSUtsK1lvOE5WMVIv
Yjh5b3UKS2t6N24yZjRpQ0pPWHp3RmlndkJIMlBUTWpVNGl3ZHFSc25sNnhDcDdTZytiMmxpbUxT
WTFJYms5a25QRi9VRgpZVzRoYVFwcUtsOFZQenNjcUtwdEI5Z0RPWUlMdjg0MEdpY0JPVUVURjZR
UnkvSlMvUjNsWDIzWjZjYXl3dzF5CkJHa0tMaDVEQnBmdWUvODBCNmVnTE0rMTl3UklVQXI3SEZx
OC9oVmN0NHdUNmUreVA5U2k0ZHpnb0tnV2pNQnAKQW9GTk1mTUh1SGM3eXZJTkJYMjBXdUh2Wnk0
MUtoRytoN0gvT3lrYVRzeDVqWkg2Y1ovb3RrcytnVnE0UWd0eQpqNi9pQmVqRHE2YW5rNHMwZWJ4
TzZpdE9abzNQcXNyL3FYU3IyZVN5ME10bXZQUlVaOXc4YTJoRnkrZzZxcXFDCmZCU2tjZjBZdEdJ
SDZJOWlFcEYwaXR0NitDNUZaNC80NGlQcHRCRT0KPUtPc0kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008cec6c065af5c298--
