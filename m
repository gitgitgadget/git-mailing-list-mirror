Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0024DBA21
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770922380; cv=none; b=KbiVTxD6KxT6M+x6dEyx5MuSuV+CYWIyQr6nF1vc3tDQ35gzrzkx7RAGY/lY6S4zJNG3c7+/MtgSwT2DTrjFzV6QjGGD5HMjgoO746zeISvYFjs/hYMw2jCj+IFlN11UhOVrsJdv2CjsqIw2nNUvGLkGj3oQS4AKphOOGcK8fPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770922380; c=relaxed/simple;
	bh=POnf0Jmq34kK0cK2I7iMkbddbVdtOV4PpyFxpIWR5pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EI63do+d9zuIjPihrAptqvHpd1Lm90WO1IgzfllRmng/2E/fWsapoNhsa2g4uKtqzp4857REjboi2Hutl1ZIXyfAZhMljTd7jfPBgNErCbS9vPgWf79ogbYwmsSn9sGUF6aBg7z4iOdzWb8oL93JQba/m9PsArX0KERd7Yso4CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=g5ppJsZy; arc=none smtp.client-ip=79.136.2.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="g5ppJsZy"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 37E493F429;
	Thu, 12 Feb 2026 19:52:50 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: pio-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U_Bxo90VbJQU; Thu, 12 Feb 2026 19:52:49 +0100 (CET)
Received: 
	by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id E1B2B3F6BA;
	Thu, 12 Feb 2026 19:52:48 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B03CB1C4A;
	Thu, 12 Feb 2026 19:51:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1770922308; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=qH8RInBV2DsJg6yz9kscOVEKs52bWLkBooP7CYR6KTw=;
	b=g5ppJsZy4auqQ25yfQkYWVxoGICwkqCS7Ehz5RS3X/zfqBNqjAx9Z9eGUutB4OhrDmj4zX
	UTmPZHsiCMY/pKhQyovM56uXL/e4JtDX5MlGsjgp6qIaXbGONjmx1Nq2Jh7ugyO5brBe+L
	lVI6yLILHJhpAazg0ij0JyWhXF2UHqraCWBfY/6FYoip3yb2UP06ZrORfYQI8ZJ0BONkMI
	ebnrkDT2r5hzzXemD8sXXHu6yIr2U9MXYPfk8E7D/rn0yDGuoPDxAvnLugHh6g7s20u65t
	h5wRNIddrfllI5PgvxanQ3O63q0ccnTCc2121RwGldognZDkMSkO36uX+Z5f7Q==
Message-ID: <ed066558-a846-4c72-894f-f29b4f911589@jontes.page>
Date: Thu, 12 Feb 2026 19:52:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] alias: support non-alphanumeric names via
 subsection syntax
To: git@vger.kernel.org
Cc: peff@peff.net, gitster@pobox.com, "D . Ben Knoble" <benknoble@gmail.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260211211810.278806-1-jonatan@jontes.page>
 <20260211211810.278806-4-jonatan@jontes.page>
Content-Language: en-US
From: Jonatan Holmgren <jonatan@jontes.page>
In-Reply-To: <20260211211810.278806-4-jonatan@jontes.page>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

I have discovered that shell completion suggests the "<alias>.command" 
which is a bug. Can't believe I didn't test that. Fixing in revision 5.

Jonatan
