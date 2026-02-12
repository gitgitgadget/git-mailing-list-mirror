Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5022BD001
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.80.101.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770910555; cv=none; b=q+6BmkOJgb7qND0/j8RM33uHHzJV85w7zO9sUeqi1OhfRuYTH+rdDP0x5ihqxOLcUnkzDfYu7ED276B3pE+VvpKRkHn4nxk7xdYhL9BVlL4H7Vc+70kAgrxKfcisWSgd+qETLn2AzGd6kC77Sm9lVpej4Q7gDPJof4d+mL74HFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770910555; c=relaxed/simple;
	bh=tf4cJuD1qUM2OP60E4/IYK2PW1Wgl5xSGCLK7fyVSGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmXEryhIFZ96zd0dUMvfOl7jgkSI6KKBhNxoq2cq/R/pm1G6CMW+gQsovbqQFJtnDir56Aj2/9BhhKxa629azBydsxq8waxPy3LdkRtWondhyjrt825ZEyH5QzfWnO2Zy8G56bGEpTvgfAq/ggBW9tTzrN0OWXDuEChQcvNZWnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=Yy0STB9S; arc=none smtp.client-ip=213.80.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="Yy0STB9S"
Received: from localhost (localhost [127.0.0.1])
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 73D873F7B4;
	Thu, 12 Feb 2026 16:35:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: ste-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s_b-xDCvoig3; Thu, 12 Feb 2026 16:35:46 +0100 (CET)
Received: 
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 1CE8A3F7AC;
	Thu, 12 Feb 2026 16:35:46 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 06F60B1E7F;
	Thu, 12 Feb 2026 16:34:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1770910486; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=tf4cJuD1qUM2OP60E4/IYK2PW1Wgl5xSGCLK7fyVSGQ=;
	b=Yy0STB9SQETYhM3nkDsS42HEB+4GiYQQQ7z0juR9HbhCo4srC+MV4YlJGipdN6A88wP4hD
	ALmeMzrloonB7WkeKxNd41SV66SSoSqWLCyMemCL+7xbzpU6kSelcrtEKLLdOqjS76ED2t
	PShUDPZjq5XUhFklggGNwraif+62cZ6NuhLiD+n5Tpb7MgRN1j3JYDbEWejvdyN7naFiox
	hKOzPRcZJATFwdXtI/oCtsPv8Um1VaO17C/9eb8c576nGF3ckpb1sIHGdSYKoR9sp3Q4aw
	tl4sh6QIYwclt8fFUD0S/iZ+oMSohCPG5n1SvQDg6Vl9G1adm5zh70WSth3ing==
Message-ID: <d25db846-c92a-4ace-acb2-0b77fc994b4d@jontes.page>
Date: Thu, 12 Feb 2026 16:35:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] support UTF-8 in alias names
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc: git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
 "D . Ben Knoble" <benknoble@gmail.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260211211810.278806-1-jonatan@jontes.page>
 <20260212102711.GA17587@tb-raspi4>
Content-Language: en-US
From: Jonatan Holmgren <jonatan@jontes.page>
In-Reply-To: <20260212102711.GA17587@tb-raspi4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello!

You should to see the patch from the public inbox at
https://lore.kernel.org/git/20260209135917.GD27241@macsyma.lan/T/#mfb25a7f945ceebb6c8619680cac46c990e4ea112

Best,
Jonatan

On 2026-02-12 11:27, Torsten Bögershausen wrote:
> On Wed, Feb 11, 2026 at 10:18:07PM +0100, Jonatan Holmgren wrote:
> []
> Is it only me who only sees the header message, the 0/3, and not
> the patches themselves, the 1/3..3/3 ?

