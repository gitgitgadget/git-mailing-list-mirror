Received: from ra.horus-it.com (ra.horus-it.com [65.108.3.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4726254BFE
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.3.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710183888; cv=none; b=tfK6mPXpIpg3xmPWno21zuJ2FdXRsZssYGd4PJ+JH+bZuS89o9exE1fAPHD2tkbofCanZ36H1o/7o0uhurWQMKcbnBxre+Nf+4JX8uq6p0bM08aE9T59ggNy56CxvzXeJ3AVnfDGur68Gc0d6yUpZlsffHJj2cXBTYAtBAL0GEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710183888; c=relaxed/simple;
	bh=Ii2C6BFl89d1B/SxaVicJQps577hFFypF+udcq1KrxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAgtObL37KybTVhp84zXBslfYJZR+6VNwZBgLTljEpg2kmh+Sk1UlFhzYT1kSom8AOFy6FkBsoooEUy3hN475D1PAPgnV0yPVQpF1paf1xdZi7+IdKRUkLBcGS+U/dan2pN3SgprBVCle+OswafVr71SlyPJ7kb3U89R/YKnoEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de; spf=pass smtp.mailfrom=seichter.de; dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b=fvITXVoE; arc=none smtp.client-ip=65.108.3.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seichter.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b="fvITXVoE"
Received: from localhost (localhost [127.0.0.1])
	by ra.horus-it.com (Postfix) with ESMTP id 6886BBE006F;
	Mon, 11 Mar 2024 20:04:41 +0100 (CET)
X-Virus-Scanned: at horus-it.com
Received: from [IPV6:2003:e2:d73d:4900:956c:99cf:bf79:af42] (p200300e2d73d4900956c99cfbf79af42.dip0.t-ipconnect.de [IPv6:2003:e2:d73d:4900:956c:99cf:bf79:af42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "Ralph Seichter", Issuer "HORUS-IT Ralph Seichter - Primary Client CA" (verified OK))
	by ra.horus-it.com (Postfix) with ESMTPSA id 151EBBE003A;
	Mon, 11 Mar 2024 20:04:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seichter.de; s=k23;
	t=1710183881; bh=Ii2C6BFl89d1B/SxaVicJQps577hFFypF+udcq1KrxA=;
	h=Message-ID:Date:User-Agent:Subject:Content-Language:To:References:
	 From:In-Reply-To:Content-Type;
	b=fvITXVoE96/suHHIhQwJMZgoyEbLWaJEDq3cjzOjGjoMYmbOQA3H2ZzCLZL8U8MER
	 Nl2pescODh5JmJt1H8Jj+Q0yCcilqi1LOMh3KwWRng4VdXsXW+jMJSQz7xxKy9Aq8+
	 MXvd1eaEpJQsfdnTrKg08pPJnr8FzPv4sRrXdegX6FsvaHnFMMVXKsWdYec/hOgVDm
	 /tTsA5ULNZfED0vl9CT2XiRMOzm/lp1qeW0QiwY5mj2T2sQvmfm6zUDIL0QTUtCdUm
	 lqivErNU89IhXqbWkhCVPfIuEGGhhM/GFyFCyHpPq8SJZ93MlwbYae9byap0G6gu9X
	 m9yF1pbwQeChg==
Message-ID: <e645729b-a605-43b7-83fa-18fdec282b42@seichter.de>
Date: Mon, 11 Mar 2024 20:04:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] config: add --comment option to add a comment
Content-Language: en-GB
To: Dragan Simic <dsimic@manjaro.org>
Cc: Junio C Hamano <gitster@pobox.com>,
 Ralph Seichter via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, rsbecker@nexbridge.com
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
 <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
 <xmqqy1apudvv.fsf@gitster.g>
 <9166fa83-4ed5-41fd-83f7-337fd524d0e2@seichter.de>
 <52cbdb9d1cbdb254dfdac467711becbf@manjaro.org>
From: Ralph Seichter <github@seichter.de>
In-Reply-To: <52cbdb9d1cbdb254dfdac467711becbf@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

* Dragan Simic:

 > Perhaps that should be documented, so the users know what to expect
 > and how to ensure extra spacing, if they desire so.

Yup, better to be explicit than implicit. By the way: When it comes to
my proposed patch, I am having small difficulties finding a balance
between documenting things thoroughly and being accused of producing
walls of text. ;-)

-Ralph

