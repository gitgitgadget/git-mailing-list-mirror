Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5702636CDF5
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 16:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755708963; cv=none; b=WGMO0wTTaNF9scGx5AF3+VJawZ46cFyHWZf6J6rqO7Puelul2jdWz5e7Saw04vKKDqSriR5JBBbd5nEvNuUlAhjZmz3kynTsSl6+gOH7DnET4wwePkrmkJZkfjfynoUCC76L1Jm0IIXARrulqdsWohEV/xz0InmdFJO1jj3J7sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755708963; c=relaxed/simple;
	bh=FAmegDYT+Yoc7Ugcm06bwKcksLIF/rqKOPtglG2Ihaw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=EV0WmDzNHMto3TGq+LAjA9wNJzyIXqL7QzYLh0KA69Etjub01ECmVdkww4RzQ3LmPvbNUlT+i2F4bG9N5lH1zQk0zW1VJCCUAHZ8X7A0new1sMbjPlIEVLbcJisYvPLKONnTYWKSWtRxNI+yKaj52yKDQn9T3kIhBwASXmlhMDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hu1Jvfp+; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu1Jvfp+"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d60504db9so333427b3.2
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 09:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755708960; x=1756313760; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FAmegDYT+Yoc7Ugcm06bwKcksLIF/rqKOPtglG2Ihaw=;
        b=Hu1Jvfp+YTyKI41cLk1gZC7AyPxQHm/GqPmGkcSxQyjIpsMYs6qHEGNlkZ26iMrnBH
         pbk2AK9A6LHzUx+GypLdMnEy+OHPfLoUGb1/1VeOFZK3+OD+SwmOepkiRdGddstqF3+w
         dFtW81ZmfzTay3z2LQXLD5Aie/UG0fp9jUwAnSEvLOOOdMpt6KhLbm9L4q0Nshxd+VEc
         e4bgbq6nTnbsdSKEGNeVnTOPjcoVHG+ngmx0st+liffxHn8CqAETfr61vgL6kmijGSTc
         u065DvaTEmkJblXe80CKnPnmrjI5mrXIJPexErDmVcJFhFyZ3kHf4izUdInJOQz41yyA
         4NKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755708960; x=1756313760;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAmegDYT+Yoc7Ugcm06bwKcksLIF/rqKOPtglG2Ihaw=;
        b=KynYihuFFsgSe8rvdOOC1Wk5/5Dmc1FgOnN0ZJzQeoeYxOvpwY7eaG17tiDqNGVvWX
         r98pm2ivJ81T+3kDPftkCr7qsyypmmjDm6Li4gataY/FkGPuCFlJEYLPWVR2fO+mf2zi
         ST4gG6MeRPC/0CQ6f5WRXZ+PYlCbXtcMWBqVyey2REY2SsM6swoxw0UttcfcSQBsCexS
         RdE31Y01YZIgJ0Z+h2WVYiNqID7kp7ygI/iE69G9uaLMa1pJZ3tGKY7B9bDHG1ljASs2
         oIbz9ndEf1j5ha3obP76XLPnVN0AENkkae2zyZozsjNsPeF644PSXwRm6JC8/lk6lLAz
         lSSw==
X-Gm-Message-State: AOJu0YxVLRwEv8rbe7r6l5RrckGA5GtIaF0Gnj9bqdi5miAiutvWObQQ
	7b/ilSfL7+y1koFtQf4apt6/ZXHcddMsyK/LgcMWLGELOnFs5tgPGMzQqIcy7+GB
X-Gm-Gg: ASbGncukUv4AwZlJ77yojBoWZe7SGaWqnmXxYfvMf7X4G/30AaYc1FPzzxEVaRnxHOb
	+9YLhcirntIrhy3Imllw2ooC0APm0uyxAl/49FB5UdVmV+dpqOxPkUdfQmIbaQZYmij/HlsE99Z
	y6+8pVD4mTiov0sa5jfPjzQMnNHiev/G0WZVWEkjAz5dkz1zmyTujmx9a+2VBWTfVenOISduFFV
	pT6GxCdrwlj28VPIEALtZp+XZUCRkcdMHpETZQ6PV5xSpqBFlskXdX8LuMNIGKUjHisV2k5OQQV
	YGVdttt1dd7txsU22NhMTTXKx5NbSui6UseLwivJ+XqI8BajxughgmtunNCkSsBmFqktrZlZmfC
	2xAOC5Ma3yQuDNgUk56WVuq0uENf8Dm9Yb84OhCpCTZ/BTIGyr7q6wE1RcqBzsKUmWzOQ3CNV
X-Google-Smtp-Source: AGHT+IFLW6STLW7OHQ1iwU4GaF+3L2Y8bz+muJeZNp6CzkYCFx4XhmFtEq9i6QbCIwgvD9qJ/j1fag==
X-Received: by 2002:a05:690c:61c5:b0:71e:7fea:bb20 with SMTP id 00721157ae682-71fb31d130fmr39987007b3.32.1755708960285;
        Wed, 20 Aug 2025 09:56:00 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:30a9:dec0:8b5c:1ca2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e108746sm37889877b3.72.2025.08.20.09.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 09:55:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy history editing
Date: Wed, 20 Aug 2025 12:55:48 -0400
Message-Id: <EB8D70D8-A91C-49B3-956B-7FA14EA10D57@gmail.com>
References: <aKVxIYBqA2nPTFYV@pks.im>
Cc: git@vger.kernel.org
In-Reply-To: <aKVxIYBqA2nPTFYV@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (21F90)


> Le 20 ao=C3=BBt 2025 =C3=A0 03:56, Patrick Steinhardt <ps@pks.im> a =C3=A9=
crit :
>=20
> =EF=BB=BFOn Tue, Aug 19, 2025 at 05:28:48PM -0400, D. Ben Knoble wrote:
>>> On Tue, Aug 19, 2025 at 6:57=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
>>>=20
>>> Hi,
>>>=20
>>> over recent months I've been playing around with Jujutsu quite
>>> frequently. While I still prefer using Git, there's been a couple
>>> features in it that I really like and that I'd like to have in Git, as
>>> well.
>>=20
>> Excellent! I'm looking forward to reading this series and playing with it=
.
>>=20
>> Unfortunately, patches 8=E2=80=9311 got dropped on their way to me (but I=
 see
>> the lore archive has them). Odd. (Not in spam or deleted messages,
>> either.)
>=20
> It's a common issue with GMail that mails from the LKML get rate limited
> quite aggressively. Konstantin Ryabitsev (kernel.org admin) often gives
> the recommendation to not use GMail for mailing lists.
>=20
> Patrick

Indeed I just saw a mastodon thread on that topic today. I=E2=80=99ll get sw=
itched over eventually, but it=E2=80=99s not a top priority for me and hasn=E2=
=80=99t hindered my side so far. My apologies for any stress it puts on the M=
L infra, though.=20=
