Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E639233689D
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777016160; cv=none; b=btNxqnrxSXZg+v8FcFtBEMTVtA9y+OL5w0HtjwDrz5ZFhWfCK3M+g15PL4xwbEdZItiMMxZQxpT+Zpvkifh2XVX799KiGlrQg7lJBCGp1dgFV11VYBG/0pRKFS9khqhefJ+rj9PwfYS36YTAIvi14bPC5qhAK+5nwxfK0GZ2Bkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777016160; c=relaxed/simple;
	bh=ixaR+5s5shjtsyM4nYXn2LjcO22jl3XWzBFD8nt7QBg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=kqJD0+B3tcB8Nk4HDwASubXYI7mhnYbAMLl1WNw5CC6IbdjwOFUZ0Vw6yJGdCfFxIZuDVu6C8e7/EzyQ+QPJslPQO84azNPWyZU8tYS333gA2XBqCg2nETK4xz3wWFx0jKbGW3eoUZFFFhb3x8MeLmkzf8uf9DuSG2K+/JJEIIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=Fa59vFXl; arc=none smtp.client-ip=79.136.2.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="Fa59vFXl"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id BF3A73F728;
	Fri, 24 Apr 2026 09:29:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -0.7
X-Spam-Level:
Authentication-Results: pio-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n8cd64zTn99e; Fri, 24 Apr 2026 09:29:29 +0200 (CEST)
Received: 
	by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 6A32E3F345;
	Fri, 24 Apr 2026 09:29:29 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90C35B1ABD;
	Fri, 24 Apr 2026 09:26:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1777015602; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=+YxbnKpLargc6ylDJLD0MH8M+R/v3Qwqyt5s0iYWNYE=;
	b=Fa59vFXlHA8LNeyNCgwGku1qvgMojDmgOWjdOA6xDjNnZ2uZcVI1eAeItLRGjMjBApwTu8
	UXXHZbe4LTA/ipF7Zq+XhA2SdSMRYIQEXYxIovVgmkqzchk06Tf8N9okR9mdzibfy5bZCT
	iohP+ZO5WSVrqcjcQ9KUCZUCb5To6UJnFwbL5lrCKYuqHLX15jgA1VEp3OUzhgj7doA9pM
	z8XycFG8kfqA+Ua5bjPqT1RkSIz++IsLzopgjedxjYe5+5eYkN9/j1gLMmA9l6sfslvvz3
	EhZ1Ubd4of4e/o34zbqU6mkkdhXe47/HkAktKn6GNst5myneMTSNU+FKQntdvw==
Message-ID: <c81fb8a8-f9dc-4922-82bd-3c7769a44fbd@jontes.page>
Date: Fri, 24 Apr 2026 09:29:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: michael.grossfeld@amd.com
Cc: git@vger.kernel.org
References: <PH7PR12MB73313034573C59C73F821BBFE52A2@PH7PR12MB7331.namprd12.prod.outlook.com>
Subject: Re: Bug: Hierarchical Aliases no longer work in 2.54.0
Content-Language: en-US
From: Jonatan Holmgren <jonatan@jontes.page>
In-Reply-To: <PH7PR12MB73313034573C59C73F821BBFE52A2@PH7PR12MB7331.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

That's a curious bug, sorry to hear I broke you/your team's workflow.  
Yes, three-level aliases were previously accidentally supported, now 
explicitly but with a new syntax (this was to support non-ascii 
characters). I'll send a patch fixing this but a release cycle will 
indeed take time.

Thanks!
