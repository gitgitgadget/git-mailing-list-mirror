Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D450B3932EE
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.80.101.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777111052; cv=none; b=W1ctbBvfVaVVPcYB9rZnwlU4EYtnSKghrfh5AhCF54pxxj1YNpTodFAJWeUFYfqlAsU9oAgqunOd/ndFxAMhLyBxklrNWpBuvJ7XaKumvvCyGODrubZOGBc0RDEFfqFVD3+OuwMEkqYhRjxrqO+HrGgprWKhqcKR8+nfD5gkSg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777111052; c=relaxed/simple;
	bh=yoIxBMAMuZLuvm4VL9tQIW3WrEOoI4be6iY0VHM9bJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJJWQlCALnM+fuotN9UYFeVyAvV1zC44UbzO6zx74N0wimncN30WanigivcdsHDFpZ9Wo12zuOXyhTkkJOG+bO/FNMFtMROEMhIC6fo9/lbY49NACmZaIMhrdir0MXoZaikL20lRkkmXDCFVIxx74zmG+7tNCMmEII/FNP5yRxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=VsSjB55N; arc=none smtp.client-ip=213.80.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="VsSjB55N"
Received: from localhost (localhost [127.0.0.1])
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id B60A33F843;
	Sat, 25 Apr 2026 11:57:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Authentication-Results: ste-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3EN_5BavOG8J; Sat, 25 Apr 2026 11:57:27 +0200 (CEST)
Received: 
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 63A3B3F804;
	Sat, 25 Apr 2026 11:57:27 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5103DB26DC;
	Sat, 25 Apr 2026 11:54:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1777110878; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=M2wvKCS9PWIs6q3USNgxFlYKIPiQxnrOwdrI+/yIn0A=;
	b=VsSjB55NU0Su31dD9+VJDGvP+wwlOyBAcJxbAdeF1dgZaWPQ4RG8DJ+uf9u8dD6w4DF50Z
	b/wONUwhxvV8SGUbsg87w/8OkG6QbneLSYfAk7vmheCtRGzL7VE/MU/BRSw+qHW9K7c+Pl
	+d/+O+uTwZzEtUpisNxfS5Lka8DyAfVeR33po3dyc5WXQ4f1ssedeCa61tiRl4VHxlelZj
	ZiQ/pnRtRl3MhrbWIJYHGf3ErzRA7GFImt7yuUI4h7uXoWrzNetchcLsta6uyUvixhpDVd
	7pkJp6CylFRAPVA2PST7cpMMZMtd0rORm4bXVVVexwXfQ3BizEOMYFH9fP61ZA==
Message-ID: <40408c99-7e2a-4cf6-b9b2-6d0e0da3b2c5@jontes.page>
Date: Sat, 25 Apr 2026 11:57:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] alias: restore support for simple dotted aliases
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, peff@peff.net, rsch@web.de, michael.grossfeld@amd.com
References: <PH7PR12MB73313034573C59C73F821BBFE52A2@PH7PR12MB7331.namprd12.prod.outlook.com>
 <20260424151053.917066-1-jonatan@jontes.page> <xmqqpl3ovuvq.fsf@gitster.g>
Content-Language: en-US
From: Jonatan Holmgren <jonatan@jontes.page>
In-Reply-To: <xmqqpl3ovuvq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

That is a challenge we are going to have to consider. I think reserving
`command` is a worthwhile compromise, but obviously we cannot do that for
arbitrary future keys such as `help`, `hidden`, etc.

One possible compromise would be to reserve `command` and `alias-*`, as
neither seems very likely to exist in users' historical alias names.

A new namespace makes the most sense from a namespace-pollution point of
view, but I struggle to see that as good UX. Even a separate namespace
only for alias metadata would make more sense to me than moving aliases
entirely, since subsection aliases with just `command` will likely be 
far more common than any future metadata keys, but this is not something 
I see as a good solution either.
