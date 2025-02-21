Received: from smtpout.4.mo533.mail-out.ovh.net (4.mo533.mail-out.ovh.net [46.105.32.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCDD8632E
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.32.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152125; cv=none; b=j4GBgFjjIgLJNKurM13c1W9urJD7WljoN/4XCZqJ4P0lm6zbs3tNsYIRQHNrYXRiGUcgshR2MxsoUE+/Nf4sOEolanzRMQjVV10jmuWRPJthAK1YkhCQeweUBEjIgBcKolXlDvAVR5dPS86v0BTDeKc6gyv6HFwk4Mcu1nOF2do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152125; c=relaxed/simple;
	bh=z9ZVeAO1xMtfl0QdW8eVoWHFw2NHrUDgM0Qvlla0hsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3iZg+lXM+KTejHB9EF5pbxHD8KZ3YvHlrCHsb1MwdBnBxuA6RwU5wo3i8idDvdcYBuEozNVC7Pn3zrhdWER90hsxBlbpDNpeiYBQe4mlOgTM8P5OF/XUEGn1whnXP/7eyRl/3DKSeWxPfJoq0aHigAC+TSZ2u5s+YGBPdxEhPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jwilk.net; spf=pass smtp.mailfrom=jwilk.net; dkim=pass (2048-bit key) header.d=jwilk.net header.i=@jwilk.net header.b=fyY8vwLf; arc=none smtp.client-ip=46.105.32.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jwilk.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jwilk.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jwilk.net header.i=@jwilk.net header.b="fyY8vwLf"
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net [79.137.60.36])
	by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4YzvB11XBxz1VXd;
	Fri, 21 Feb 2025 15:26:49 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net. [127.0.0.1])
        by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <ben.knoble@gmail.com>; Fri, 21 Feb 2025 15:26:49 +0000 (UTC)
Received: from mta11.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.109.139.175])
	by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4YzvB10YMpzyBk;
	Fri, 21 Feb 2025 15:26:49 +0000 (UTC)
Received: from jwilk.net (unknown [10.1.6.5])
	by mta11.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 56494263781;
	Fri, 21 Feb 2025 15:26:47 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-102R004d51660f7-b556-4f0d-8b8b-46ecbf1b005d,
                    3833C9059EBAADF9D952CF52123B9565D109EC87) smtp.auth=jwilk@jwilk.net
X-OVh-ClientIp:31.0.176.20
Date: Fri, 21 Feb 2025 16:26:44 +0100
From: Jakub Wilk <jwilk@jwilk.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Robert Coup <robert.coup@koordinates.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	"Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH v4 5/5] remote: announce removal of "branches/" and
 "remotes/"
Message-ID: <20250221152644.o5ni6vn6rncvmaq6@jwilk.net>
References: <20250122-pks-remote-branches-deprecation-v4-0-5cbf5b28afd5@pks.im>
 <20250122-pks-remote-branches-deprecation-v4-5-5cbf5b28afd5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250122-pks-remote-branches-deprecation-v4-5-5cbf5b28afd5@pks.im>
X-Ovh-Tracer-Id: 11184971152236162299
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflrghkuhgsucghihhlkhcuoehjfihilhhksehjfihilhhkrdhnvghtqeenucggtffrrghtthgvrhhnpefggffgffdtieekleegjeffteegfffggfekueehfeeuudfhhedthffgffejgedvteenucfkphepuddvjedrtddrtddruddpfedurddtrddujeeirddvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepjhifihhlkhesjhifihhlkhdrnhgvthdpnhgspghrtghpthhtohepjedprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehrohgsvghrthdrtghouhhpsehkohhorhguihhnrghtvghsrdgtohhmpdhrtghpthhtoheprhgrnhgurghllhdrsggvtghkvghrsehnvgigsghrihgughgvrdgtrgdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
 drohhrghdpoffvtefjohhsthepmhhoheeffegmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=UK99AHy1sGQr3Ps/JuT1xLsLxCqT/NQBMoBAIBc+BMI=;
 c=relaxed/relaxed; d=jwilk.net; h=From; s=ovhmo917968-selector1;
 t=1740151609; v=1;
 b=fyY8vwLfyOr3cHW1PUuA6A75MxdusmTAFZohCnPBDXkLHhQk0vBs67yG82v7o/FJLL2vHMg6
 hQRls/Kc0fvzxGUl6rzjKeLt2CyXeMGX6VVmr3GzXCTdhCRW9ngWSKTyB+wFboI9YrOd6dqRGCz
 fm4WHlIxta79Ekc8FWF9oJ1gcz1C8jH7xh42qliMFFtFLQITG5WUsINRmAb/Cm95oTuoLsHDAj9
 eOw6Ke+6UH1Z6X8BsljZzSWmtkrcvdQrxzcDW/YKLdeemQjnRjBVR35m1hlAE14SEfpfqk+nYYt
 W8AfjdftlaqyZkMligYFLO1MoGAo5m3vLUFJFhSeeGEsg==

* Patrick Steinhardt <ps@pks.im>, 2025-01-22 12:31:
>+As our documentation mentions, these directories are not to be found in modern
>+repositories at all and most users aren't even aware of these mechanisms. They

This isn't accurate. The "branches/" directory used to be part of the 
default template until very recently, so it's found all over the place 
(although most likely empty).

I'd say: "... these directories are unlikely to be used in modern 
repositories and ..."

-- 
Jakub Wilk
