Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795124032;
	b=A0QDSiugZTp1DYmrc543RLUjXxGHhc+v0mdjRqGm7JrWeW4+lmL7xlg1hBQbXwGBRpYH
	 ppa3mTAJZpYEeRlumkVSz5+RN89ST+qqtFo2TPGyAW2pKdevPPJFK/82dnVp2NiI00i8E
	 0q4uNoHZYCQUPdYeP+e+1W/JHMSlXn2DlR2hXRxlIgi2RH5HIQHoL0i2tqdqyIJkZMTaN
	 XME7bRaFSttkZduGVE4FhWGN/Vr0uq9/wmI7przo+hK0pf/iQUrbvDw4vDe4gfWx3MKa6
	 7KuMSpFF1zJuauD1UOHIqBBeXvWTozqoF8qc+i8AP+0CIN/Ff5aypqqF7IY7ZKUZpTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795124032;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=oa+fACTlhXId47Y8FFm9d86tRFT/uTOa8MjY/3KNyrA=;
	b=0hQah1XTUc1Hk5HA9OarFB1ATVAmBNqIiEQQ1WsQbEEaqTwuX6FUXqpX83B5kr2ZpFWi
	 65pbWKwj47VPqjGliqdRZX+8LluSJ66cXUAE70HKteuO5SVdyPffik8y5787eJrm9zmMR
	 4VzQDjO5To8uDKsvclsmmIp+2/pcsZSmdnDHfO7xhiIrCuqkokCQTJW0IaaNgiTll1tyG
	 miGgFT3mooD5LjwzsI36/590GPMWzJ2R3kF+cvDDLf50Bmw2lg13Ii4CsvnM6atkBrha8
	 5/6+NFB+K648yHq83kmi4o97A2cO5hlevry8yD6lF+SoEoKE3lbS9B2F23/plGaDjiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=abPS0PAu;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F62606A331
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 21:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79F62606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=abPS0PAu
Received: from localhost (ip-109-41-51-202.web.vodafone.de [109.41.51.202])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AJLXg1o2020718
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 19 Nov 2026 22:33:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795124023; bh=oa+fACTlhXId47Y8FFm9d86tRFT/uTOa8MjY/3KNyrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=abPS0PAu0M14InCyhAUqa1EC9qvTQ/EDTFmyxTuvRWGsikqeNIdbHKywbwb/6lTiq
	 tOjGQ2IBRBBnL3XvAPFzdI+yvKt6du3x4Hu+3aT76w3ZSKQx6WBSgfZRsUqxwxsfWP
	 9+iN6TFpPJegLxN1J43shjw+52Z12C/LG5BCXPYU=
From: Dirk Gouders <dirk@gouders.net>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] utf8: add display_mode_esc_sequence_len_counted()
In-Reply-To: <CAHWeT-YX8FOacV7YypyZ-qmr3Q2T0TEF=_Qy2bVE7jcS0OWvNA@mail.gmail.com>
References: <20261118-master-v2-0-3f2aaec15d31@gouders.net>
	<20261118-master-v2-1-3f2aaec15d31@gouders.net>
	<CAHWeT-aWx1VwUjM+hZ--jjSAbcMenz5Mw11y9ouFavGndUMrSA@mail.gmail.com>
	<ghse0x9sgm.fsf@gouders.net>
	<CAHWeT-ZNoDWqTMfCdQg3PZ2bbLD9PTVqeFMms_1dFj8dbReSCg@mail.gmail.com>
	<CAHWeT-YX8FOacV7YypyZ-qmr3Q2T0TEF=_Qy2bVE7jcS0OWvNA@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 19 Nov 2026 22:33:42 +0100
Message-ID: <ghld6o1p6x.fsf@gouders.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 19 2026, Andy Koppe wrote:

> Andy Koppe wrote:
>> Dirk Gouders wrote:
>> > There is only one user in pretty.c that uses the wrapper.
>> > I can change it to use the _counted version and we could then drop the
>> > wrapper.  Junio's v1 already included such a change and I could steal it
>> > from there.
>> >
>> > Would that be OK?
>>
>> No objection from me. I would change the make_line_colors_self_contained()
>> function I'm proposing in [1] to the _counted variant anyway if the original
>> display_mode_esc_sequence_len() is going away, to avoid the performance issue
>> with the wrapper.
>>
>> [1] https://lore.kernel.org/git/e9f88b533dfbd10528c9151e2e87207419d0253d.1794905511.git.andy.koppe@gmail.com
>
> ps: I guess you might as well just drop the _counted suffix then, and
> basically just add the len parameter to display_mode_esc_sequence_len().

That was the plan.  I just checked v1 and all this would actually mean to use
Junio's v1 instead of v2.

Dirk
