Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0132C39E6F9
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944547; cv=none; b=gaObk+0lmw41nkjKbyYmYNz7OuBbPrEoMhcjK+vnieJwwg4e1Czmm3Yf140kzHTJfLHZR7G+0aSywBcUQNKhtWh+g9B82R2Ghl7ijK0T/UoZmaoCzZDsent8YlwI7nRfJ5Av2/w+OmImBNTmGonoDTGC0T1zXHd8gJ0E2aSdGSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944547; c=relaxed/simple;
	bh=TmguYxDDuxDPZwv57WrX6Flfmz3c+dgWsNUU///tOxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FS+rwhzkIUTAU0ij0esFqDbQhwiQqHOYhuAUD71p3ZMgpT6M6QKItazQyakoRoggKEgQlPTOacCL2vf19Z3pKaQWYGT+Lze6KpjAXWJr6NrtEffRsFlv1d0sw9lqSe6O9KXRH7498fQ0vwGBcOmkqOL20i6u6zHU795+7jZGsdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=jSacbqYl; arc=none smtp.client-ip=79.136.2.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="jSacbqYl"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 76E8943749;
	Tue, 24 Feb 2026 15:48:57 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: pio-pvt-msa3.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tYchUtYucEh2; Tue, 24 Feb 2026 15:48:55 +0100 (CET)
Received: 
	by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 02D7B409A0;
	Tue, 24 Feb 2026 15:48:54 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB1ABB1FDB;
	Tue, 24 Feb 2026 15:47:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1771944456; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=TppuKcEdPDG1nmAHs8BcuPLDebGe4VlAGhRH3smNRhE=;
	b=jSacbqYlAmKHmDFwUlE/z5ebKi5ljwdILZA4YPm++tuaRNbrvSV6SvEtgCYq8rn8kBq0xw
	lxQ2pPSuzMneOY4GXfDvj8aKkzpCTcrmLGTMnh0yDYV4lS/pqeBMlwNV4rXqaEQJ9M+ekn
	eNGNSq3EUE0cewLbcIb6K6Io0G2wvvHuedSHNWTAQUc5AFHkTgxbxszuytEWDDXcYypn3k
	UVXmK2N/bRUpP/q/2MYKkErLPCKvRRY8KpBmwP31X6im1VogirBr64x+kuoL/+iv67/0ta
	WhwhclIiTiO/Q2hQV4BF5VAWOPFB0FNlykLF0gDmVFDcs1dHfgZapOOB0RkQqA==
Message-ID: <4b80f709-d883-4565-9fe0-d92c80a7ef0f@jontes.page>
Date: Tue, 24 Feb 2026 15:48:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] alias: support non-alphanumeric names via
 subsection syntax
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 "D . Ben Knoble" <benknoble@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260218215737.1181147-1-jonatan@jontes.page>
 <20260218215737.1181147-4-jonatan@jontes.page>
 <f1f37010-2e93-4e11-8298-420cd8931d62@app.fastmail.com>
Content-Language: en-US
From: Jonatan Holmgren <jonatan@jontes.page>
In-Reply-To: <f1f37010-2e93-4e11-8298-420cd8931d62@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

> Is this `rätta till` supposed to have a space in it? 
Absolutely, as a demo of space working fine

> Is the intent to use quotes for the command (in e.g. Bash)?
Yup, or "\ " which is what my shell defaults to. So the user would type 
"git rä<TAB>". Does that not work on your machine?

Jonatan
