Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796488;
	b=ZuUmuxjWn20PZL82FEBGiR4TJpG6Dws45M50DkREBtoYEkpAIAg3A6jTw4sAI6olkHx2
	 NwpdjhgrWDRVeMldKTfLmxjtaqAncgwkgvjZDb+RHGO4wrwJgVXaMaPverlHTY3cXdt2S
	 eu7vhFm2vYJvdqP0reSwOpqoG01gjvaeZgx7cAOMRXppcUTChxUXawPVtQwwbXikgqSoL
	 6ujhv89D9M1vGOGhN7QYAE8JoTiNeSEEKNYsP9UFGZeyYC1uLEbSuegp/4KXkd6knqP1h
	 fO8zHEP7/MmIowX7MF3NKHR57nAy7nvd3EjIe5uBDweMl1rI+EhE1Mu+sLeciDHzP0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=w+hgJlk3ft7t0vsJ2JiPJq6ODHgyZUiozMpbINzdfCI=;
	b=WVmfGOnPP/18AyoklT54mcFcuVLXYkVCU0jO2MeHQRTxZJaVpt5/PV0qj8FQhtUUu2ao
	 8KWE68M/5RBH1iDIOf7EsizgIy73LUv3R4WLemuvRNRq72ww1umdf5PHPgoXRsnWZD99B
	 eFWVOf4Iqv1WY5RGnf/VD1/pODQWTErH5cmA/iC0+4qLHgp+w6Ix3izBH/wzaXzmT6O2P
	 R+/Ua379jrvjp14gz8Ao7qXwmIzdZqKccnUUDhWBWjtDHwBVOxp4NsPfm58anqja6D0Tl
	 eFJ3kucA24Jji52o0U2WHObtpUnlbKLf2656U6EdwWRP3NuGfizzSm5E1jKmk1teCQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MOk6Obkz;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F47606A31E
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 16:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88F47606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MOk6Obkz
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cdb1199bfd8so3862422a12.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 08:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795796488; x=1796401288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w+hgJlk3ft7t0vsJ2JiPJq6ODHgyZUiozMpbINzdfCI=;
        b=MOk6ObkzWZPXpFw7LNAjiOYzK9Lu7cFwXVbKEbBHznuANCVA4YGte7Wf0nJdk65nhs
         nOVP0pu724iCYBX5o4/bh6Ty1PEpZM6gMqOW+GZmTEzc9x6coC9FfjZjraZbBrt1Iaok
         TOq8ImdE17UZIoFZ87Sd5Qq+WkKasqyhTUeOuNkicWmzFEHFihlu5D7F5wX3qu7e7Ukp
         KRVlwrVQq5KxOsYWe7nCCXbE3wsjvUEI4V+qFSIIi/bgKx5VfCEDiazeIBcnSyBVbAjH
         oPuPAkajqrFVGQeuMA0fRPD3uX47s1iBA0tB2zoHGOQo3SlskEcfB4hWQCnPIjn8aaUr
         b8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795796488; x=1796401288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w+hgJlk3ft7t0vsJ2JiPJq6ODHgyZUiozMpbINzdfCI=;
        b=XvH0HmbSyvB0MTZHB8Wj48gKdc0v9A6vUcqVl4oACmXembtZOwvIU5hT0YfPZNnzIr
         XZXe2YbAYqT2GXdczr0zSgzXlrahrKLcgX+NrMEADpryilp+oVpH3T1lhFgi3Bh+ROwZ
         4n9dYafk3/bKPhyIZDcRigNalFVF8B2mJeKymi9nSEC9iaTVgWp5lvkdXwhBJtQD//q4
         pzNSotpdnWo2PG7kbAMte5ec8b6gcI44Nrr2hqn2cwo5WMc+AzZhUAZPIUAzR1mLBJrD
         cG+tTn3YF2J8vVqSPpcUGBLQjvMKzuxB1KDDUbGTYzLLxSFtPwiPOELB1j1xZXBJlx/b
         dlsg==
X-Gm-Message-State: APuU4Z9vPsDO9TNvqNL23V5z1cb2kdR0OhVFm1sKGyzV4u7rD4/AgJql
	eoplwYgMRcumwQijbpyKcrACI2U0DTuYwlpkxae2T8LzQ88y0hFMmcHpbzhJ9Q==
X-Gm-Gg: AZFdTZfjeZKEMWsFSopxtK+/ShjArAG7xp0WA5aJJlFz3gLh7Yr60OjpQughekQfb8n
	yzlYYvLbJ+DisxJIDNKZRnCPAwPMDo3KwzRGiuwcRY9fJIMHJVYtScl8Hx0cq0SED2tKnwLG/Pq
	Pl2PP8QC2J/yQ/rNm2CjRdqGmLRXQhQ8Sy0urBYmPSnsfmMnfH2gUHvyk6cDvlx6i1hKmze6IaI
	QkiDLvY3flsyXVwxNlGESU6khVBguAM+euAYe/WYDZAhxo5oGDyzelfjvVDHown8NcqRItEIgML
	3Z0ROhjKBBR3mqd1w7hP2JgmM4/vl0ok3FH8MX2uiYLNWkC2Of7i7YJ9UCQkt2P69wMHZnLtXep
	f7gS9FblmW4GBaD5V9+/MFi0ouirIG4dDwbtMUqXOW9Zvudpzi/qk9+MBTGikzdXJnvDUCoQYAc
	e0xrN9vrQCmrW7LSV0nL3Arlj94FepsoNIwGpBD8elwSeuaAESA2cK3iAjYbI9EhSsGS6wuxG6l
	aTU8UtlYonbWi3XZD1m2DTpxrL354j2nCPjyUu8qExWasaRmrwK9wJMiZsNp/6grZj7NiclyYJs
	yZ7aLl5QK8HE7COGAPZL+iVQB2Bp59aq0OqpA//jS3k6tyKo5RP1TJcZkya8oZ11BFgbJPvGfX1
	0dhevE7LotkAWfsWIKpqkIdthMjWspPRqjc4M
X-Received: by 2002:a17:90a:e705:b0:3a7:f4d:b23d with SMTP id 98e67ed59e1d1-3b41c97ca8fmr22625260a91.52.1795796487645;
        Fri, 27 Nov 2026 08:21:27 -0800 (PST)
Received: from localhost.localdomain ([223.190.84.94])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde7f91c6f5sm10626085a12.27.2026.11.27.08.21.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 08:21:27 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Mike Beaton <mjsbeaton@gmail.com>
Subject: Re: [PATCH] dir: do not turn blank ignore-file lines into patterns
Date: Fri, 27 Nov 2026 21:51:22 +0530
Message-ID: <20261127162122.92766-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261106182945.1316297-1-aniketgupta3001@gmail.com>
References: <CAHzAAWSi9D1mRL=A5-9GxzqQwo9jJ=45Hmxj3hVAF=8wkNZLmg@mail.gmail.com> <20261106182945.1316297-1-aniketgupta3001@gmail.com>
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

Hi Phillip,

Adding you here since you reviewed the non UTF-8 exclude files patch in
January. This one is a small fix for blank lines in ignore files. Would
you be able to take a look?

Thanks
