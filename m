Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D55C2581
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 02:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771641509; cv=none; b=SxzWZ47K9D+ic31FWprAb9xdoP3WRsAjAOlVqgeV8V46mrTDwKpcMDLM1HDKBsb/YFzzKMUANb0A+t8D1Ic+Xe48HLisr3JI6KGteMKeRhqGk3weWVQKHbKq6F8S6nGvciATkWsek1XUV2MXJEb720V7ecepwZ0azkaTKiEBDuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771641509; c=relaxed/simple;
	bh=I0I3v+HP1xzLry1BbPz5Gk9fLKjR72fB21P/aMwdfM0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=QtAvNi8UNPhV9MOAhmjgsbyKyvzr2irGfjdQsqIO/JH1XgMBEA3HTyAaaFVPa0+BPfDVn0jzNEz+YlLvKHO4oXWDuPuLCRecbi91Y4HUROXRzyC1LTg4ofd5FU5xCHz82D3Xo07dDfDJS+Ke6eS7+39EYslihjZ9YBxzdWOhTDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kk/LHcV1; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk/LHcV1"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-797ab169454so25788857b3.3
        for <git@vger.kernel.org>; Fri, 20 Feb 2026 18:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771641507; x=1772246307; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFqsSa8MIeSIzr6JscEMegTgcwyHAawv6n1eMPvS7F0=;
        b=Kk/LHcV1Rkc2d0+6hlvY81TcFx6y3TGhbtUTKhQiHdk99biO2tT7QxPBAgmE2fQunT
         P4ICFZU3Gyt48zmgAlM9q7SajXWfP5Fzg3Cvw2En3Gj5B6KW00SNS429YpO0e2vV8Yed
         N+B2go+QSdsRwgKkMCiMVXW3dBfp97embIlM9bK862ztfOvIvmncQQsL30+DnL4O8B5A
         uGHCmn5IWQsJsCSGtp0hMb5HaMCnfAJJ6lPywErxnEX1xitfUErUaAKBMpK4TpW/ArA/
         5GUKjHcvDSjnhPyGwMpeCsAhyihgl8Fljl8T4cO+wmJObHXXXYjJT6EGA92PWhPgeHxd
         wyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771641507; x=1772246307;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VFqsSa8MIeSIzr6JscEMegTgcwyHAawv6n1eMPvS7F0=;
        b=jqedQcGWsKywxEtM8k5cAFibhbSK35eMWONzIO27Z2v9kZAz64w+f2tnZu/glT/qJJ
         ep0b7shXGeNk81bGJEIku2v15hHwCilczuTAe45W8J7A9r9mgOhxnY222rQdLEYgP3iX
         IGMrNusaoKCPar7xi6/bmPDWKNwNYmEVeDnEnsZDdA2bVlveNURboOtuvsZP13j5Dj30
         38AxWj8UegN+af3gH62KypDLEj5UA2iArVrl4BjsIHfumdznKaY+Bkr7146PaTXGGpWb
         PBjy0+ly+aQDEfroCUhfhKuOTrijntkR+Qf6Vl14nAD5SSrTaFe5reDQfRJZlTkjriex
         zl4A==
X-Forwarded-Encrypted: i=1; AJvYcCWGBJsJSIHFrN7MhZxqpDB4y6B9oZHXWnJcfwG3kjywebUbBghGKEY2TlRpeBMfbKmMsFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynEnmQsCj3xd3IGX8VUCh9BkM0h+E5pTSMiHOCQYlDMiPX9fo6
	pMsr4KDbZyMrBu3Q3tZlEgr8gIEaghU9/kg8/NyqvDydMWgsg5/RuDcs
X-Gm-Gg: AZuq6aLDCGR1HXMyJAA6AlmGdigf5eGP4ZQ/UNzkji6KSzd2bJxttiWUy+FJ5uzcApc
	KNAzsK3mJ2S4dqb684s5WxyPt21OQuxMBattFPeyvSr9Zc2TQkn1qSXKwTcZahelKn3jcyRtZOe
	YkrGfCRdchpBvPI4k4Z2cDcVsehVZnNDdSG62yB80HZOG/5TEkjt93aKcd/NhAMsQHKC2m7mdsO
	b14UkGFIa+BXwcKrQtpjpq2i+/subCLE2780TSLSmF1SVYKTCKlp2y1dYjn6+rfbu1/UgbnmQ3u
	Vh6UEEPon+u/5o/iqbBLSFuPzMcDLj5sWbKxxMHunc5zq1wM+W/6+2WZPE2dBWXcmX9ePKBiclD
	YyHp+RKv/940NBzU0NSbZKyEMHINYGRZ+Th+lgvKI5Bn47rAh1KqJ3Vlg5T2z8cTyo9lqNuNOqN
	1QnuPeBbZN1T8sUXElzSjigTipG6ZyedrCf3IuiGCv8zB6Qizjw569DqlAyCYG0NEzphe4f9yHa
	bRNyAvySMomi6YtZzsNebpN3WWqS0ufDbotckm5o8ZYl3BKsAJYMMZ3
X-Received: by 2002:a05:690c:c50e:b0:798:3a7:cf85 with SMTP id 00721157ae682-79828fc165fmr21414267b3.41.1771641507050;
        Fri, 20 Feb 2026 18:38:27 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90eb:5600:4411:17e4:747a:db26])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dd81ea7sm4330757b3.32.2026.02.20.18.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 18:38:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/3] doc: patch-id: explain how to map efficiently
Date: Fri, 20 Feb 2026 21:38:15 -0500
Message-Id: <F628C3EE-0600-419E-8D85-0CEA9EEA2243@gmail.com>
References: <xmqq1pifvyhm.fsf@gitster.g>
Cc: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org,
 Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <xmqq1pifvyhm.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 20 f=C3=A9vr. 2026 =C3=A0 17:31, Junio C Hamano <gitster@pobox.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFkristofferhaugsbakk@fastmail.com writes:
>=20
>> This is the fourth patch series for git-patch-id(1). This one focuses on
>> emphasizing how the command is an efficient patch ID=E2=80=93commit mappe=
r and
>> how to use the patch IDs to join commits in a script.
>>=20
>> =C2=A7 Changes in v2
>>=20
>> =E2=80=A2 Delete temporary files at the end of the script.
>> =E2=80=A2 Consistent footnote style: https://lore.kernel.org/git/c70adde6=
-e3db-4a46-bb29-a19d7aba8c7e@app.fastmail.com/
>=20
> The latest iteration of this series has seen no responses.  Is
> everybody happy with them?
>=20
> Thanks.

No /further/ responses, perhaps? Unless my mail didn=E2=80=99t come through.=
 I completely understand if my approval was not weighted particularly highly=
, though, ;)=
