Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A0714C5A4
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723454030; cv=none; b=B/37uOEdX72m6IhbzoLiBzGuPoi6nqelSNy6/IPm+TjY/BbZwwDofWqpmixVD7Ex3tDVsWX8i8y/lgb4QUuwNEvs9ugVHQG92z4oCRZIQriESMZypnbClJESfObZw4EN40N60seu48Ds2xHIgFhlqtbCLMOmsVluQ8qUvz10ryQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723454030; c=relaxed/simple;
	bh=kJtJ+xYXPSk7EqiWnlG0IzoXwp7sBTbIjpoE65OJdrY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOfsE9k2l6tLpLMGhejZHaUMp6L6uTgujhv73Xdj3PyWnRQ/vnE4XqqtAnIjZy8CkLSt11pWjRf/Bz009oe6pdx2bUW9G0mXbRNpJ9XSDxHAfKQDBJNXaikZFRO8iFQD4PxGhqTz0dO+4NdeeZbrKy6+Yc9c4MWOo3G61BPuTRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbjdrNHC; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbjdrNHC"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5da440d059eso1161237eaf.2
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 02:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723454028; x=1724058828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BHmJgS/k4qUQ52Ia8GZsLP+7KJQs4HKUW+R+aMyonV4=;
        b=AbjdrNHCK3Nt92VO9md1CbsfjaSp6PZrZMqmrrafaETwXQaWiGw3iHZTn0KMj1r3wU
         4A94eUy3BKvIUhMrRDE++VcFOFAfJ1Y5E2Vjmg+tDhybid3hVy1pC3j8xrqbDuNsEfGV
         GrY2kJ9c/1kbYv6bsceSwIQF3QsW5o72l89tcyG+L/Rsknp40lWygwK+pmCURe90Dt3y
         suMZClF9p/cHfVzptLFoTYxoh9LFcyTvf3NaWH5UN9FJE99388Jd5/m6Ddtnn8uhi7qH
         3O30bSJ3djtrCWLPLapxm0fboN9nvEE+Xe+7fVDBp3bp+MOVXrUaCfB/7JMwV1RtpFYn
         J9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723454028; x=1724058828;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHmJgS/k4qUQ52Ia8GZsLP+7KJQs4HKUW+R+aMyonV4=;
        b=DipN/CoqwoyVgksbdRI7DdPwE6rC7MQC1ICCqC6m0qlOSOHB5SqkuDUVJGoC/fcnIs
         lJeiBDQbbNMtMnbzhpWzflxu9/FnpQO2J+IAZQbPt0Im2cxDPJEcXPKyp72byFpCCpTK
         Ga1ZJ95jW93KyGwk7nm9xvrklK4VUR+BanZDuoIqlQN5YOLGmYM/mUBCG/4WH3aocrbS
         yqd1kfQIgp68VFBRj0KqbXncpSOcZe0fFEmusjAa8xL6yLjw+B0KGHMvR5s4d2lmbTWR
         Q5891oMjnxLUakSiDlGW72lgCXZkWh6Gssh9xaob2OiqtMjk+Jk8Z6Y/hbebwLcxl2+h
         Ac+A==
X-Forwarded-Encrypted: i=1; AJvYcCXpYSo6HLPXklqQOgbE+C+mlWrNvKuu/VtbHbqNJ7lh7Q2bCTzpYZwORMv53Y8nQKA4Szn1pPL73ffq7cHRUs0Z8gdN
X-Gm-Message-State: AOJu0Yyfaz8nUpSVpmY0B6qc2RJSEu9/Xyy4pghFqCUcMbxF58KF5iDF
	xjr8N2SPf2Jvo98N9PN+Q0WISwikJetd6Ua7GiK6OAQZsdSEWgkB5lLDx1k6GMbIkUDozxTfbwZ
	sDUH+uV5pwuiPjn4RN8Ib5qTos1g=
X-Google-Smtp-Source: AGHT+IFtYNH00q6hgXBxH6ipqBi0pQ+k+XCaiSGfvZHz7eMp4F16Idl1nf+8nptcVP/1Cw5vWMgnWlj0yjoAROUk7Pg=
X-Received: by 2002:a05:6820:162c:b0:5ce:3ebb:468d with SMTP id
 006d021491bc7-5d86f8220a2mr9145738eaf.7.1723454028668; Mon, 12 Aug 2024
 02:13:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Aug 2024 04:13:47 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im> <cover.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Aug 2024 04:13:47 -0500
Message-ID: <CAOLa=ZSCLZU=eeBqx9cpHkUJ+SOHXToVwMKjmCKLc+54MfxdRQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/22] Memory leak fixes (pt.4)
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000002a8d7a061f78e97f"

--0000000000002a8d7a061f78e97f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the second version of my fourth batch of patches that fix
> various memory leaks.
>
> Changes compared to v1:
>
>   - Adapt the memory leak fix for command characters to instead use a
>     `comment_line_str_allocated` variable.
>
>   - Clarify some commit messages.
>
>   - Drop the TODO comment about `rebase.gpgsign`. Turns out that this is
>     working as intended, as explained by Phillip.
>
> Thanks!
>

I went through the series and apart from some typos, everything looked
great. I don't expect a reroll for those typos though, since they're
minor.

[snip]

--0000000000002a8d7a061f78e97f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fa6a0fe96ff196a4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hNTBrb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNkNaREFDWXhtWEtVS2JFci9TWjFBalpCVktzSE5ydgpzRFduQ2tOdUtW
UkcyUUphNmU1TlBxWktEYVk3QVp5a1dMNjlzT3lHNjV5bDJXRVcxcVc4NUhWZXd6Y2JZQktFCm82
YlFjQnVKWnVSYWNUckRTb0xjdFRCOTM3YVpqcXk3Z0c1Z0c5ckhuck1EZGhYblVSMncvQnBRdGt0
ZzhLZlMKM0pCVWFLYUs1dWpBQjNkS2x5OHdQb1pYTzBtczI2bmdMR2lUa0pZcnMvMnFhdnpZMUor
bTdxMUk4c3hsUkI2YgpHbEl4L0tmTmUwNTUzQng5NFRSMCt2WnYzcXpFSnlLcmVTeE9BWXZnNW5r
dnliUjA2WUxGK0JpMEovSXBOM2gwCmx2Um44dytKTUh0OHVtUkJPTTdaZStjSlEySXBiRjVYY1Fh
eC9IRFBqRVIxZWpYTHFMU01LVUhPMU5KOWhXbFMKZWg1cmR6MWk4KzBTU2prWStPdkMzNmQ5ZDBU
UDVXYlIvVHNLVG5COFlYUC9RM3JHTVY5Z0d5OXlqd0Q3UmtPNQoxZ2IvMVFPblNacHRFWVRiYTAv
RzVoWUNNU3pkRkEzMkRHeWFaUndnd2FkMGF0WE01UTFBNnpKdWtQNDBkS00yCmwrNW00MFlCVVg2
MGRXVlpFbmMyellUbTJubGE2MG8yNCtRd0xMWT0KPXpoeFgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002a8d7a061f78e97f--
