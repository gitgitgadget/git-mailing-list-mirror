Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803A8AD4B
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634243; cv=none; b=nJlJCqDzVqD5Xn6Sbg4zDZ2UQUjH5nhPtGD9lvJo0+IhtrD46HVK+WzC959Ak0lPvtNDzCG0KQ0uRsCekC/oW9dH6wZhhSqHhe4mYjLuRao+xNQWJkxBBuCuN+7ypoWqMz4wbRqBsQBi3634Dl9PBD03Zcsrw1BnVyjGsI6Tp7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634243; c=relaxed/simple;
	bh=XFcZlEWZSGDdQ+MlGEEY4RDpxvob5eAdew2Xhm8zXeo=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=X7SgSb9/N1Z99qp96Ue8fGQdiKwFWEpTe6mi7o8XNVRtgMXIB7ppS+YpgThgapDHy/8eSWHsAiakVjOkdWX6BzEMY3rVh3eC86B60AvQ4Rs/z+EcydMGpN6oQFdtU2lotX5E1DQUiGHZJxqQ4si9nh+IAUZnjRqK1GUVmO5J/No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mt/0I1MB; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mt/0I1MB"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-ea3dbcc5525so3939490276.2
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 06:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758634240; x=1759239040; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PFxdH6KsFaA2iU0otdrkJis0vkVqPe8gE8qlSPbJURI=;
        b=Mt/0I1MB0lycNTU8+SFKYoCEDoy98sYSQd2AJ6x8XLjZxyqgXI+T05VjG6lYjYfAyB
         HkPT2bQ7x+bZXjyGSDKcfa4s9kIytfjE2hTEJw1DGN84XBpQndQWf/wZt3+Qcxo2XeXt
         gegQijArQkZQ82ZrlOjdIf9udfmMqxDUzK7sddcKZ4T42j88qdApT3B3MFGe11fK6kwa
         ZjwIYNWP9pbRk3O6RrdQo+CBTnvGA5rBbPoNsXEbo6ydnU5sJPCPln7a0m83iMnKSHZ0
         HI/Ww+tOvpf3R4AM4GvAFnpRpxkRIawCKbr59OVkSk+EkOu6VPA9BtJXnW91k9I2Fco+
         R0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758634240; x=1759239040;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFxdH6KsFaA2iU0otdrkJis0vkVqPe8gE8qlSPbJURI=;
        b=KCb/decw0VD27Liob86yElByuj0QNWjNG7/n2FiuK9bHlXbMPMz5wzqvuL/Og+SiJ/
         bkGfWwiA7/yPc7cKEK+F4wFraCZH8WWDMgw6Ctbk3/dUCBN0AMH/5tlxuyZK1GCjv9rd
         xF7uNDYhHse7Pu9SSK7TfJnTF0aCBELrReQVIcieNbQSLCAQxyRmR064RHreYE7YUHd7
         F+HAqImfr+k3ZvwEocusiH/hKI85HMZiRzS21if2jOzcpJ59iKQDEA+IRfFGbpBQRORV
         oYcJv0Zyw+v8503HsShXJI+aECSBYekfHOSPoR0rqcL6oVePmJZnwBfkcIdjdBY3InVZ
         qGsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXwBQoA6/AXG6V+6gqx9kiq0jdKyzDKt9RdWq6PLBYIaz71YIXpsutovsmjymNy5OT4vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiDLXwGZSiid9mt4TaRARcM0hO1QVGuqn+uNEwpm2DiW/0724K
	vU1hpIrFWB9ONaOdLlMRKBP2sIPuNrxVi1ZUV1okktB33Wtdsj/HkVU0muUwHw==
X-Gm-Gg: ASbGnct3t9THt80Cmqek9+mKxY1aaeaayzYAr/mc5pYJu8uMChoNs/Fm9S0vDeMuPyE
	RVRxZjXrgWdDMRTOZ4CsYc08fAgjoMfyxcZOTSoSrUmdV6f0/gxsmB+5msI+IZpBb3S1si0nR6Q
	9KOQg0U60jIaMvlPPHiVdOauWtFS08xJqyLhCVPrOURrF38haxF4ean06xP9h1mmQj7A7pRqi93
	JhGnaO7AQfd9/Hs6qZKR4Utkd5jjeTIuTbHjL/odVayigmI54BLemVgqwva9ybM5D1MZemwf5B7
	eW4XMRrhv06No7wIK8Z075hutRimO3c+2w9UAdfJncOKbFXo5+m0QodBsZ7Xx3n4Qm+bMktL4Vc
	RwTdkg0fPM/CQBMWfyG1E33PLMOaOFFGkl9YieR+Zfbwv6580pzI=
X-Google-Smtp-Source: AGHT+IH1jtcZCNuMnQTL5KyH0Wag4D9VNCl5HdeObp+GzVg6PFY2ErQ0eDXD8i5xRTPvBxibsCv0bA==
X-Received: by 2002:a05:6902:709:b0:eab:9d16:f036 with SMTP id 3f1490d57ef6-eb32e0579dcmr2219253276.16.1758634240230;
        Tue, 23 Sep 2025 06:30:40 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:3535:152d:7414:b233])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea5ce709f08sm5031924276.3.2025.09.23.06.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 06:30:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC] doc: check-docs and WITH_BREAKING_CHANGES
Date: Tue, 23 Sep 2025 09:30:28 -0400
Message-Id: <DD6B592F-005D-4F36-9585-003C1C4ADAE5@gmail.com>
References: <aNJUUxfhM7QYDQGj@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
In-Reply-To: <aNJUUxfhM7QYDQGj@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (21F90)


> Le 23 sept. 2025 =C3=A0 04:03, Patrick Steinhardt <ps@pks.im> a =C3=A9crit=
 :
>=20
> =EF=BB=BFOn Fri, Sep 19, 2025 at 02:33:33PM -0700, Junio C Hamano wrote:
>> Shouldn't we do something like this for breaking builds?
>>=20
>> Documentation/Makefile pays attention to EXCLUDED_PROGRAMS to
>> pretend that the git-$deprecated.adoc files do not exist
>>=20
>>    -include GIT-EXCLUDED-PROGRAMS
>>=20
>>    MAN1_TXT +=3D $(filter-out \
>>                    $(patsubst %,%.adoc,$(EXCLUDED_PROGRAMS)) \
>>                    $(addsuffix .adoc, $(ARTICLES) $(SP_ARTICLES)), \
>>                    $(wildcard git-*.adoc))
>>=20
>> but nobody seems to put the removed programs on the list. =20
>>=20
>> The dependencies around Documentation/GIT-EXCLUDED-PROGRAMS is still
>> screwed up, I think, but this may be a good first step to straighten
>> it out.  If "make -C Documentation" runs lint-docs by default, for
>> example, we may want to tweak the Makefile down there to make
>> link-docs target depend on the GIT-EXCLUDED-PROGRAMS perhaps.
>>=20
>> diff --git i/Makefile w/Makefile
>> index 893070be76..711cade8fd 100644
>> --- i/Makefile
>> +++ w/Makefile
>=20
> Curious, but what's up with the "i" and "w" prefixes here? :)

That=E2=80=99s =C2=AB index =C2=BB and =C2=AB working tree =C2=BB from diff.=
mnemonicPrefix=
