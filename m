Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4564217B50F
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 14:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438039; cv=none; b=cC145wKXhMTH5ILbBFqqW3hCYIpHCFxKZh0tIWLwvRty55RPHtVDkolUALLfkhB4HQMfTa+EummWQCDVi4sYhmhhlTEDBQjJ5OkHqM+N8cXjbAezvhtoy1TccaH9EhitZS1Up5t80t6pzTgcCvMoyGXX6Jobu/zrMx0Gpwscp6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438039; c=relaxed/simple;
	bh=7OHyHHdM+2OpPap+L+6mbC6KCR7UI6RY8Exr7lkRlqQ=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=tYs59gJt72y0tECZ6m4lwlugmDmQxBx6LJNIK6uVFp74JCtSNEPpEppTRhDUvG1lxiVK1r/c6RK1ahwcNL6n3v54DKEPZW2KKe7Xaw/e8uPJiaKwm+jBU5FBd4HO2jYfnd2N86w0aMyRaL2uoRGNr4LzbBCzqCJX/XDmMaUgDKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N53uXg7A; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N53uXg7A"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-786572c14e3so9638347b3.2
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 06:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762438037; x=1763042837; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P3DhQZArKRoMg5Fx8WKzJcVtuAsOg2VvX9wDkOjr/2c=;
        b=N53uXg7APRnF94jx5jLWXnh/BkjylqD/Deb8dMML0t1E0LdRWgMmlY8yJ797TqAgZQ
         VwsZ+MTVn/oN3eRxb9g+vN9OQA24918FH9mVLwcAokbrVuFlZVtCmSiXLKf6vj+VpG9L
         AxDpRmucUOsppYsfeRm1Gm+YcZgVEQqIqKlT0LAqPN7gfmUnonsVCD77yjOFehebi/WJ
         AAkJ3aHKbWdJ6UlcpcSQUU9CyRdn8EJdfqd71t6u2ztmKrge4BkhuU0FQyRDVx3bh6QQ
         ASZ0xKSvyeYgb92A3dZtsKevAv5TXDfZBxuxh16NJV2QcvkhOsetzs6qvIDn2b4uh28q
         nx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762438037; x=1763042837;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3DhQZArKRoMg5Fx8WKzJcVtuAsOg2VvX9wDkOjr/2c=;
        b=Jgu7Eg8kMAoGE69Zaqfn0vh+sa/iRoQpWE935GCoKH10XWHOxzU81kN7sBEsXajp4f
         xvIaNTiDhlh77pB2Q5ensEjzuC/vzhpb8ibKwLOZZA7HtBIElZ7V9FhAQdh9lO+e1eZv
         1mTkYU/Ze+lgmouRvwgJLjYbGup2MdMAU4Db7OER/tbdGBtRMeorYJXIsELd2YLv9AQC
         KCJgLbMeF8J8U4aHCOkSnNZmW1Ywm1Kv4/VPhjrlWWxt5/q3G2yLJ66nV5jv4uL/wbER
         RFoDWUWI/pcRESOMD7FrYhTTsKOmHwTevAtmZMtPW0u3rgIlJPu2R/Dv4ktgHgjOZZgY
         FOvw==
X-Forwarded-Encrypted: i=1; AJvYcCUnmPZi0d7Adi7oCfOfZt1xbXY98yuZ0qh7qYhsRbfifyvNjAD8iIbfqyivfJiPte+IyD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNhaEhjKOX6lZ+2E9jCfnnJIzPfwxviKSm4J0MyKZkjG6a5oP4
	ce2qwKrSRbD2GcSFxfrDVC0jz3l7Y7gEnXuyb0gbrAfm7bTNeeQo1MfkYKd+4KsX
X-Gm-Gg: ASbGncuKbEwSF7lsuHjb387hzS1ooabgbH5TXMGxp/xlrJV8+ShSWxHGf06zuzTUxb4
	3DL/tFvl/3n1nXoQId6o+Haj8S1JBzqSKjrglblDt1+ACA57kkQKq7+JNZorE8X8WB7QssDAsXn
	nO6DbOeZDMXO7tPdLBqORuG9IpgCy5qVYrr2XyQsSrBdD7zoQO6b0XWh+ZEdLmsNkYLQCKX8sRy
	FqGsNDbPw0gvweMCEJvWrsupYbqkhDk7FRHvem2x7Q3btogi+T3ngElspfDbk4+ZZ4RRUtnYrQA
	PipetWoQ0yAuMNJZNbMFAPSrDZAB7XcRZ5TTLvGUTtrX0t6c3TntoYaIqQG07Z/ts9Rb91W1kIY
	SwzbzSU52BeGmTpKgbBfTnQcQ5QS94meEnyFnc84GQ/R7TQCnlnzLVDo+/6Ctcy+kXRZl2q73ZZ
	mKYLpLK452EfVAPCOPfGwANY/r+Re6
X-Google-Smtp-Source: AGHT+IEhRSFTnaWpT83a+gKS/2n1nbdM480icllpI29VyCJYKWPe1fJWlGfFB1r3v2jMOVgBs4ST7w==
X-Received: by 2002:a05:690e:4109:b0:63f:b2e8:11ae with SMTP id 956f58d0204a3-63fd3570e60mr4435124d50.39.1762438036870;
        Thu, 06 Nov 2025 06:07:16 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:81d7:5975:fbe7:7159])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640b5c9110esm812140d50.5.2025.11.06.06.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:07:16 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] perl: also mark git-contacts executable
Date: Thu, 6 Nov 2025 09:07:06 -0500
Message-Id: <87BB8F6A-7176-4C51-9F36-BA613E7D8B08@gmail.com>
References: <aQxMmnzPR6swvG-d@pks.im>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>
In-Reply-To: <aQxMmnzPR6swvG-d@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (21F90)



> Le 6 nov. 2025 =C3=A0 02:22, Patrick Steinhardt <ps@pks.im> a =C3=A9crit :=

>=20
> =EF=BB=BFOn Tue, Nov 04, 2025 at 01:14:57PM -0500, D. Ben Knoble wrote:
>> When install git-contacts with Meson via -Dcontrib=3Dcontacts, the defaul=
t
>=20
> s/install/installing/

Thanks. If Junio doesn=E2=80=99t mind the trivial fix, I=E2=80=99ll avoid se=
nding v2 for now :)

>=20
>> Perl generation fails to mark it executable. As a result, "git contacts"
>> reports "'contacts' is not a git command."
>>=20
>> Unlike generate-script.sh, we aren't testing the basename here; so, glob
>> the script name in the case arm to match wherever the input comes from.
>=20
> Yeah, that feels sensibel to me.
>=20
>> diff --git a/generate-perl.sh b/generate-perl.sh
>> index 65f122ebfc..796d835932 100755
>> --- a/generate-perl.sh
>> +++ b/generate-perl.sh
>> @@ -30,7 +30,7 @@
>>     "$INPUT" >"$OUTPUT"
>>=20
>> case "$INPUT" in
>> -*.perl)
>> +*.perl|*git-contacts)
>>    chmod a+x "$OUTPUT";;
>> *)
>>    ;;
>=20
> And the change looks as expected. An alternative could of course be to
> rename the file in-tree to "git-contacts.perl". In that case we wouldn't
> require this special case at all. But I guess that this here is good
> enough, and there might be other consequences if we renamed the script.

My worry too.=20

> Thanks!
>=20
> Patrick

Thanks for the review!=
