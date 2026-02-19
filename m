Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B83B253359
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 18:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771527262; cv=none; b=Lv1u+X5HiIVWlNfPgtB5s0QzEdjBLh96WD/jrgQBqrkG2KnIZY08yYszj0BmZ0I68l/G+OzyvlzhBHuIB0g2rvWH+/fMOiyWuPUMIt9G6qcFJUDvHs0WlI8Cv9nF8Mjwu/mwfRExzU/m6+N78HYLLoMCTml5hMSyUCVe5xg+F98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771527262; c=relaxed/simple;
	bh=BNuh4iZs6XcOa5onQ6rXP7f2akQoRYRDVHGfG5VU+lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkTZeOquMFxq0rUWAnMoidbYzBv+cggrAPQY5P6nG8R3W36bHUp3QtO+QV/b4tqAT/aTScr8eTxXDE76eyFCb80RqXsfxYkVx8dFHDQOCB6wRpcGHPBOpuB7VtSjrTty8hUiGEYIxbUaCUUPvOdmvDqH+hz1dCt+fqgRN8EJvoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=OLEmS6VP; arc=none smtp.client-ip=79.136.2.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="OLEmS6VP"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 04875407EE;
	Thu, 19 Feb 2026 19:54:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Authentication-Results: pio-pvt-msa2.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eqy0tNk7Nz4p; Thu, 19 Feb 2026 19:54:17 +0100 (CET)
Received: 
	by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id A21BE3F375;
	Thu, 19 Feb 2026 19:54:16 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 60B60B1AD7;
	Thu, 19 Feb 2026 19:53:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1771527186; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Vce0X1VoaqXaAWRFOgGQ4rnB8w2e4jVb3hW1ut8C4qU=;
	b=OLEmS6VPXKGQ28vKEj8BkKEURNOm/cGHdhpwojJMWgEh1w9ijlLTSoeUHM/u0NgiH+8GKc
	sayHxC8sbwvC24IJD2UCf3A5dKxOd4hdB1n6ETDyOPMUk7mC/k8du9ObbizGn+Y0K3cU+Z
	sobQLJ9WGiH2JI9Xk6Uk/We46gGCEbXPeTKs5vZ4/5Y4r7Xi/6wyjR/vfMUzyDQv6ZtsNi
	JcSVYmzqKO68wOG2UlfvvcazjEMFtbTq99rECstLCAAeLX4TS+Zd7HT0kC+BTr2E3MF/tI
	x2tVKP3ezATVKw1VKB7Yd8eCaGBnMvKdox12ZYSicUFj2JGYqi2cilbBFkvtmA==
Message-ID: <d59aa674-70b6-47ad-bac5-e247fa5ac21c@jontes.page>
Date: Thu, 19 Feb 2026 19:54:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/4] support UTF-8 in alias names
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, peff@peff.net, "D . Ben Knoble"
 <benknoble@gmail.com>, "brian m . carlson" <sandals@crustytoothpaste.net>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260218215737.1181147-1-jonatan@jontes.page> <xmqqpl6061k2.fsf@gitster.g>
Content-Language: en-US
From: Jonatan Holmgren <jonatan@jontes.page>
In-Reply-To: <xmqqpl6061k2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Thanks for the review and feedback everyone!  Excited to have my first 
patch land in Git.

Jonatan
