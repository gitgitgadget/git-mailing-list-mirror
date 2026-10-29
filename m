Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284223;
	b=2UXu6aCJlwtecNeqGgY3kzq+EZNXtNSB+TmChzXj0Pq5Wii4Zt1lwKAuViTtrG3opEmN
	 9gAarA7XkHVZC+bz2f8xHLsV7h/IjlXYnM1oHRDmaRFxaTkdCfzBUsU0lAyMOPFnXCbJ3
	 iFf0lgIesNQTp7IpZ57IWoYgwkToDqR1n9VKIlLXpstsnWpp/FgITO2fBK+06DDc5OBKo
	 +8925xPNzv2EEBrektjyaZ7CzrKguWq89oGvYMG7ALL44kHj7J+PQOWsulAoW6yXWP1iF
	 JgIaZA4z+d0elw05b14rBXr3+e8tPu4rAr8kPnD9r0FOmWQUTr8T0Qm6M0zDywGefnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:Date:
	 Message-Id:References:Cc:In-Reply-To:To:X-Mailer;
	bh=SDJqVfu+qMxELxeovHd0aqooZgWmV++SfiyID8YuMHk=;
	b=QzS+9PKwvgBZlVpH5BdLcd5+FiR+0Rpv9koXXfL8TVsQn386sE3/BKzPC3WC4BaWibYt
	 iIbK5d+1ga4HB/FAiE2H1s+shee/e4EurnsSwm5tSJ74BeUrAH7dgMz3PbVdUB9HCn3l4
	 C3DEyI1sRPMISIcE5ZpgRW8FVHXF1gIidjnRjwLniIxn7XKVPa5Usb78Z/20V4QsI82fX
	 Z4TZWIEFnILDft3nJM87kM/MvnYylKBhSe4HzeydL/H7OrdzroawfdYgioPBC6PdRlliY
	 3poAmEP16Jl5w4nvSQ3A/16Br6zn/xARcrqNkBjFxr0J3mS9TA2tL7KW/AQuRqqhPIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="eq4hmc/z";
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E61D606A31E
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E61D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eq4hmc/z
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-533861a59b8so29129771cf.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 07:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793284222; x=1793889022; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SDJqVfu+qMxELxeovHd0aqooZgWmV++SfiyID8YuMHk=;
        b=eq4hmc/zbUoDX8NFc8XX/NnKjDaFDGSyC+L30jemovCIo7pWDU8bBFLnOSoJaAAMQg
         TydwCRLELYQvGUIk1i17FdfD/WL7c6HGjydD5mMmryomCqBm0TPWPiikHoLCxTxhfKPE
         dGeJL3TwsRkT/gEx0RDcOoO+NfTyPxGI8GCp+ILJzBRiNTk496hHPzxoECx/mMii9i4C
         pn+Hb1fszolH3XLEa9/BXyXLCvIaWokLYeCfBKwTmPWg4J6JD44j0CnjeBKetv0mg4ro
         kKQBg5/niabMpWZBZHPNTIcp5IUpk1HSeDgKUpgXAszx/MUTgYblq6L1sYpHwmGUjvuI
         D9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793284222; x=1793889022;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SDJqVfu+qMxELxeovHd0aqooZgWmV++SfiyID8YuMHk=;
        b=Ula+h+Y+jXrak/lFH96NX2PkbtjKNaDx+/QfomEFBxAzlDWohXPlV0zRHsakTgY4WR
         g4MwtNUxCGCNLXCJB2iTEvOHvSuVoNjtmywVlgPdLL7jLSjkMM6EYYmik8r1H1hG+sBK
         GDd4E/Cic+T19Aqc0T6nVl6lOxJU2eMYhWBNglvOnJSB3arztYNFYKcAazZe5S9QxMBe
         HNugi4Gjz6VPUWJE0sFlp7QVzjdy7yhvtNAkEGFDLyGog2AvBZmJfsj/zV06Wykmkfng
         tV06G2YYWJzMpBseDzTKjCybS6w+r0y2iXXZVxSqQZcAqY39kZv1Py5/VzAhtGp3Iddq
         6GeQ==
X-Forwarded-Encrypted: i=1; AKwUvBw4fz+xb4dLvNjqf+tlOvGypnvb/6RW2J8jUqRc6HuCa/vlq9Emy4p56XRUT+DIvfCjVbU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIklVcgoLM4blbvUWYUYZeNxQEIStuBZrDwCdst/mbtApsf294s
	t5FSbeBVEVfZGZBqFgQZkK3VZU2ZSJ4Z46xTe9UisZM+RaXEQHMFhznCFyRI5Bik
X-Gm-Gg: AYBFou0HrfOIUvKPYGrQIsDPvZb3RXuBtVFZB/SNIn2UPegEEOpmhU0nAtiGHk5rrH/
	xoiWKH17seyRi+SCHLaZq4uyi0BXnWjDLBbeiL0FZIj8t7QgEFw52jjd4Nb6KiCr8Vt/Oux0hnr
	HrmwpbJLgo0KYkf1r17x7gwysNdeFOX3e/e6dsADtj2qYVlyj4wcJZX9As2ppoDIGjSz8Z9JmL2
	ePp/DLGFd0e07Mzc/xwl+HEyXnquECVBMHb/q/Wh5HsF0K7GG3fKgZ41R3MQKAOUvhrtK3MuDeO
	X3G3HIEz3jpBCZUF+6CBZJglCGG5lLvDCD4RgKClcfUuq8gfvpJPAIvKE89U0s8wNbRaMRm/16G
	gpdgOzSyiKv36dViRf6ONVWH0CnrXXVPjH+B+yDt5m08j8BMtm5ndxGEZaUE7quvdzCEcF6EKdW
	hZ67DvljmgxhbYF3CcpxuxPsoavDuCpicQdmuLe9vaQ6BTi0pqK8nejVpYNTuvJvopijsJF3PJW
	SswsKOOzaExtk6I2B7/QuuQ+zQ5AWBRCpyPjAVoVL/7xKFDNu0xUiaPsp8a63r6+kg//+/h+Duk
	/3WiZrtxXUe6esRdypFe8UouP7JULG2W5DTqn6fT+j7Qj2noKkYiyEOie1r+fifkNZKq+9lU+bQ
	R1Tuiteqf4LFlx3Z1nGb//gP2cf9R5k6bxnQyYUj8O2GpKxP9oqOhyte2DNEQWqVSW1VaqdBigg
	D0EkI=
X-Received: by 2002:a05:622a:5144:b0:536:5a78:6bf5 with SMTP id d75a77b69052e-53fcbfdc6f2mr88907781cf.48.1793284221970;
        Thu, 29 Oct 2026 07:30:21 -0700 (PDT)
Received: from smtpclient.apple ([2600:1004:b03e:6cb9:c1f9:7732:784f:faa9])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5383970b678sm132706661cf.21.2026.10.29.07.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:30:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v10 1/5] fetch: add remote.<name>.refmap
Date: Thu, 29 Oct 2026 10:30:10 -0400
Message-Id: <E50044F1-41F6-4FD8-9A22-A43FF36932F2@gmail.com>
References: <e6af5d1e-4ca1-48a5-8a84-5e0cefbdbc2b@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
In-Reply-To: <e6af5d1e-4ca1-48a5-8a84-5e0cefbdbc2b@gmail.com>
To: phillip.wood@dunelm.org.uk
X-Mailer: iPhone Mail (23D8133)


> Le 26 oct. 2026 =C3=A0 05:44, Phillip Wood <phillip.wood123@gmail.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFHi Harald
>=20
>> On 20/10/2026 14:42, Harald Nordgren via GitGitGadget wrote:
>> From: Harald Nordgren <haraldnordgren@gmail.com>
>> Add a per-remote config variable, remote.<name>.refmap, that provides
>> the default value for --refmap the same way remote.<name>.fetch
>> already provides the default refspecs to fetch.
>=20
> The second half of this sentence seems redundant to me. Can we please call=
 the new config setting "remote.<name>.fetchRefmap" so that it is clear it a=
pplies to fetches. That would also allow us to add a matching "remote.<name>=
.pushRefmap" in the future to map the refnames of refs that are pushed witho=
ut setting up a default set of refs to push.

Yes, I would love to add pushRefmap atop later! It would
ease my working with notes, I think.

I=E2=80=99m on mobile now, but if I remember I=E2=80=99ll try to spell out w=
hat I mean
more concretely. Thanks for the reminder!=
