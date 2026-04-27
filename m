Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD6C39B497
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777279025; cv=none; b=asp2NrQZFbwqQVooBRnzNPd9W9952EMotbvoWsDa5qg/CPaa169V64UT3RnByDcLTwLxQ/T5M+B3lAnnKqSxdrfZD8+GDGENUsFq3GDjnZjNqZTt9UjnUT/Szedjid50Jg17kZM7B5xA1heCH1989itfTQyqzpQRnKs/hT6Et0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777279025; c=relaxed/simple;
	bh=xAVMsYNB3GVqVggxoaeZJL2Q7z7ooSF1rKwCzDxvl4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BW7JaO0eQFP35luJ4yO+eTaga3RvFjHc1qTZ/5VuJ0DUjlIgiWxIBKgTHsTJembcmUO3op6xGwcTzcIYL8mt6CpCjw7Oa44CHd9ho6+eodH71GEeBl2p3qb1V2Jvn+hI/yEJ5401MdqhAAAqnSNe8r4buiNMyG8Y7XvEyDk7X74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=UGzaW7wL; arc=none smtp.client-ip=79.136.2.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="UGzaW7wL"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 8B0743F6CA;
	Mon, 27 Apr 2026 10:36:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: pio-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gnTnqi0jMd6g; Mon, 27 Apr 2026 10:36:54 +0200 (CEST)
Received: 
	by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id EFB113F603;
	Mon, 27 Apr 2026 10:36:53 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3204BB26B3;
	Mon, 27 Apr 2026 10:33:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1777278842; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=w5VyHnhVdm+bmN5vCQIGEYD8za54/eSavXV49LWfN0E=;
	b=UGzaW7wLwVJ887xJJIbAD/pnnkp/B/8eQBl5An5kMWFWQxdIiFBq0njnlWP9r2hWKIkpNl
	Y2hHAyCOj8I0ssui0BKDhcjz+lqRackbCx4FQsTGSXp6dUmFQlyK0OAWKGdy1ujK85pKxl
	6KXy7HwVkVCYUDROIOYv3sPMyPzIAqjSYn0sSXTLcjiUw3+CGOVZo0MRkwIpTMqIne0Xgy
	hCsV/sF3WMcwp7OKYEooUVI3R4NkKSIJQmGUXbtJHZG6t8nIUEr1ms0cWmp29a9LjHFDs7
	AHhoKyL34Kv8nv0wKiBxLQgfGlXl5224cuBFNgr9v8YKDA3YNGgnCbSrPuvv+g==
Message-ID: <d1170f92-3690-4fa4-8070-75ac9f119174@jontes.page>
Date: Mon, 27 Apr 2026 10:36:55 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] alias: restore support for simple dotted aliases
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, rsch@web.de,
 michael.grossfeld@amd.com
References: <PH7PR12MB73313034573C59C73F821BBFE52A2@PH7PR12MB7331.namprd12.prod.outlook.com>
 <20260424151053.917066-1-jonatan@jontes.page> <xmqqpl3ovuvq.fsf@gitster.g>
 <40408c99-7e2a-4cf6-b9b2-6d0e0da3b2c5@jontes.page>
 <20260425232916.GA29816@coredump.intra.peff.net>
 <4a130a23-fa32-460b-a338-409d85d18166@jontes.page>
 <20260426230125.GA218434@coredump.intra.peff.net>
Content-Language: en-US
From: Jonatan Holmgren <jonatan@jontes.page>
In-Reply-To: <20260426230125.GA218434@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Sorry, that wasn't a "hey we should deprecate this" code-wise, I was 
asking from a documentation point of view, i.e. was curious how you felt 
about what is "advisable". Shouldn't've included that in my email
