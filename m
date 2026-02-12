Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E59E573
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.80.101.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770910851; cv=none; b=pGhjsFz/pV1iT8DU4dV+k13dIU519ZG+6i6DxMeglkANJTxVpg8Tf6RSqgorl4YO5UK0q98TOKEmCZYie4a82joi7pCKN9iqd4R9tTe/WC8bj+7YgVliE+/ybHmfa0j7AH2igYslh61/s7dPSEZAwI7amaRQUBrUpKpg9WlxYDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770910851; c=relaxed/simple;
	bh=q03bEJp80n9vZeMNC8hUqdPxrzlYNJXQINIDopEodYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tEWxx8DoSnqKMEoatWCddhTh59SaenNFVPcaPx/lrh0TL9QWeZLtozUflb1VQfM7qB0AlXqOi3XR4FXbPj4aEqh7zQ6LaQy7v/WOJGjll+5ZRWkfhjwrhw32leNxZT7/y2jBG+2nqKH2trQUTO80WrpIhAeoZnNdsyzgMDD28/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=J0OehyOK; arc=none smtp.client-ip=213.80.101.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="J0OehyOK"
Received: from localhost (localhost [127.0.0.1])
	by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 7BAFB3F6B5;
	Thu, 12 Feb 2026 16:34:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: ste-pvt-msa2.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
	by localhost (ste-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V8xPaFIz6GZ8; Thu, 12 Feb 2026 16:34:20 +0100 (CET)
Received: 
	by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 2FA8D3F359;
	Thu, 12 Feb 2026 16:34:19 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 82682B1ECB;
	Thu, 12 Feb 2026 16:33:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1770910400; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=QwQ7fyySwXerma6fY0WSWArP4sido2/kS3zOGW1frkg=;
	b=J0OehyOKxtGaD1JwYZHHDOxssyeO1g6HTZZMYjym/im/yLVBCvofjpgmNkVobYEBbsIrsK
	f9jj2iKiNTBomBDqsIsCAevcLx7pBG5z0wPn6eC1c1xsyyofvNtZ5p3ftuI7eXjyTM4MXu
	CdXTWF8yUJQTVucusm6R9S1ILHspROA+hlQkvrueLxntxweit4HETwWODWpoDsGfRSRJcN
	KOVZjvRLV6bNqaCkXEcazcsixVboAtXHkj4G6pecyDsF24adxWX/VgShR3nTN3gQFCvMWT
	GnNQMdP2hX35siGF/oLxwMNPghMNiwe6LBMdhu+tiam2QTmul7cvzNk6hANpZA==
Message-ID: <27be3e00-ec44-46d8-a9d7-44160c1cf1b0@jontes.page>
Date: Thu, 12 Feb 2026 16:34:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] alias: support non-alphanumeric names via
 subsection syntax
To: Richard Kerry <richard.kerry@atos.net>,
 "git@vger.kernel.org" <git@vger.kernel.org>
Cc: "peff@peff.net" <peff@peff.net>, "gitster@pobox.com" <gitster@pobox.com>,
 "D . Ben Knoble" <benknoble@gmail.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260211211810.278806-1-jonatan@jontes.page>
 <20260211211810.278806-4-jonatan@jontes.page>
 <GV2PPF54105D07420C30078862ADC8F64109C60A@GV2PPF54105D074.eurprd02.prod.outlook.com>
Content-Language: en-US
From: Jonatan Holmgren <jonatan@jontes.page>
In-Reply-To: <GV2PPF54105D07420C30078862ADC8F64109C60A@GV2PPF54105D074.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Richard,

Good point regarding the distinction between the human and the character 
set.

I did actually consider that distinction when writing it, but I 
struggled to find a phrasing that didn't feel clunky, which is why I 
settled on the version I sent. However, I agree that your suggestion is 
more technically accurate.

I'll adopt your wording in the next version. Thanks for the review!

Best,
Jonatan
