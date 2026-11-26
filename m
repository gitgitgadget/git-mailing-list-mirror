Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702106;
	b=mMRqYvLoDyVuCrr20EAbcMQMxH5Xf7IEofb5m35ap2TVXPzCueA8JCkE9UjVVUnHSZQq
	 dpXOHB8rneL9svucfEdVU1BgwPbAw64ax9LpZqneCXhvytfwfROOt73K3VCerTWLd7sE2
	 7jOfsdtVz6Wp3imRPMBOTQSCNhFcYtVVqx2/zjIfROqEChDh8choAXGM4ExEXChCklVws
	 QyDZdSLfEYv2G7d9H20J7ReFLjL8oWajElOhwvxD1uWMrk6L0++TG9qDPsWQ4TDVCoJEI
	 pvF6RNu2NFQLkyqcxswA2DWUqusEuJ+nDo22EowB1c9h8r8CItM/rDcClW7ecNNI8bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rqA7guqSPS8UHUvPrtq20NmWYsM9M8Myun5tV7HemrI=;
	b=cxpLDScyS5ixFKRQsilPYeqcVb2/UmoI+bSb2FfBAgRhB3Yy31QlDSS/kUqIPxIfW9Q/
	 VgLxs0os8y4dXHNMnekSQpbbNUkI9kRCzlGA2G6+c2TEySH5gxkDN9VtCAmxTGERgQrn2
	 nu6zdAD1pzgOZhaolPIbtjspBRcCNFIv2UkNSrPSl5XT3mSfwvybYnlUpTyknzymkYe97
	 hRZp28+cRXsU0bQj5vzqSS43jAb6Jd04tiWMxHWrOtU8Go78KAzm4JTA9NO/Fwwn90/q0
	 vYBPvQFv/q1k2jAzkVMtGR9sZec58C477sxEA3QC7ySgdsNHCTpu+ydcDEe/eRAsNRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kan42ne5;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC4D606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 14:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EC4D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kan42ne5
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so5136997b3a.0
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 06:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795702105; x=1796306905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rqA7guqSPS8UHUvPrtq20NmWYsM9M8Myun5tV7HemrI=;
        b=kan42ne5oLPet83QBYupvzMKkWp8Xh2yxjDFGZeyssne7c6s3SsG3I+Qgc8Z25WL98
         t2FAXLZaabO4we7ZNyubODQ2pwDOwSwXVWISEOL6jeh9pGjQ+tGoWXx/lp1/GGSe5OKe
         1q8bqOk8EnvyHX4IBK/MmM7glwN/TGQYFtq3dNdXujDkS7p8qlbQf4KZlb0ibTFOYEFs
         9FcA0XJWAEJqVj3t5ZLaNqiTstnx9d8ctkrho7d188D9gnAtYTP5btMUJoafYBvnaR0C
         ZfPciDGwX6M1ieY0vVjinEbd6F/d36eUzyykTZdkp0H99MAvb1XtYoXQzQSztOwbabgR
         Y5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795702105; x=1796306905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rqA7guqSPS8UHUvPrtq20NmWYsM9M8Myun5tV7HemrI=;
        b=IEyocrOqfcFD8a94Dfx1G4AqYiYQ7Pn/yHIKm9UzBJhlihnI5S56gGG2vZX+Q0uHg1
         AjGCCMaEaH/Dziq8/tluAufvu+hMTTocImrQZ/+dRfZg31Vl6yUKkx1uEwH7SE0VOEJB
         z9hKnFcQEazJD7g5Dd4lbfc3f/HUL0Ni3/FFMVUHZCMMOMJQznyY84SIZtsoizUg90zA
         MT8T+m/PymuiqWoTSiEvGY+RhaMuDDN+KOM4ibvhmcE3L5zy/HCVLTClrG/aVxosknGJ
         e5M9p2lbHdtlhEI9sqGaHMTK+H3wZgrvnUM2tg2HEUP+Ougy5qXIWarp0biHuVSHFGI4
         ETgQ==
X-Gm-Message-State: APuU4Z86aEnggpni9d8i9JGFmYRwbLwRDCJouw/UqYK2OOAqIHah6GU6
	zUMqVwo/DNEYJlJI/E1QjuInh3Y0Y5Leva7XmQXHDBFZS24eKU9XK/V2PO4gQGo7LE8=
X-Gm-Gg: AZFdTZf/n15tvkKal4kvO0H2wmD5TEOppoduN6Gj5irNTiNvCNISrALHXOiRjnb7sld
	rlH4MC5Z91NGW6z23AJxl0A9AyQxllLGPDsSQHgv0NCe0R39KtAVZXWBhtiK4gZhOSwZwXZwZm/
	/CrmIATLwceJil/ijyoWBW/EjDftWcRmvAxqBiEhiJd0OhbyGQnIuj2THGAtXk39+TLKn/v4lFw
	AjwstLZ+u7pYeTSVKIJIKxPd2ftdrsRhA2llDWMaepQqSZSPVoVUgmW5nP007NwYgAbKQy/pBhm
	vU8XVm2j9fKudBt1AMK+hg5lX7kvZuWKz+/D/6/5t8V/XPrOcoA36m2dRuwBlYuGOYM8J5sPu+p
	q8aVD0LTksJl967XZ7ai8xQgLzdSoqFzZBKHxLFwSxF4M4OnAyi176PPv2GgUETIs5YVaoxL880
	uuMngTuaYfWDnNVUMKBgePkMCEJN4ZQbfZweMSounS6+8Lq1zAvqBO9iXos84bXRgX2+awgFqXT
	jTYQ5CpE8aSROkRSDT5grkhaf+J62R/PtqtHmt/ITSmo27padpmRGCS7aK2mo6OPWMgMQruz/yZ
	NeNOKDTOJbE4A4RjQLG/aeqiOaTYQ/C2Iiax3eAZr1LKXWdIQl2iyT1RTFTuxN+XW/msGVjP4Yy
	pzTBSrjYN6LfwwaL8JGBtQw==
X-Received: by 2002:a05:6a00:4f89:b0:89e:3ccd:b3c7 with SMTP id d2e1a72fcca58-8c87c8657cfmr18485408b3a.33.1795702105355;
        Thu, 26 Nov 2026 06:08:25 -0800 (PST)
Received: from localhost.localdomain ([103.25.231.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c05fsm10917429b3a.17.2026.11.26.06.08.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 06:08:24 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Harald Nordgren <haraldnordgren@gmail.com>,
	Simon Richter <Simon.Richter@hogyros.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 5/5] date: avoid overflow in approxidate relative-time multiplication
Date: Thu, 26 Nov 2026 19:38:19 +0530
Message-ID: <20261126140819.32139-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <23ec6cf8f08ec63efe7b868d78745940e8475ed6.1795640149.git.gitgitgadget@gmail.com>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com> <pull.2253.v3.git.1795640149.gitgitgadget@gmail.com> <23ec6cf8f08ec63efe7b868d78745940e8475ed6.1795640149.git.gitgitgadget@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The product must also fit the native `time_t` range. Report
> arithmetic or conversion failures as parse errors rather than
> saturating the offset.

A result before 1970 is not caught. It wraps around because
update_tm() returns a negative time_t and approxidate_str() casts it to
timestamp_t. An explicit time at the epoch, east of UTC, is enough to
hit it:

    $ TZ=Asia/Kolkata git log --since="1970-01-01 00:00:00"

lists nothing, while UTC lists everything.

This is not caused by this series. Duy sent a patch that dies in this
case in 2011 [1], but it was not picked up. Returning 0 when the result
is negative fixes it for me. Would you like to add this here?

[1] https://lore.kernel.org/git/20111031231320.GA3857@do/
