Received: from mail.cendio.se (mail.cendio.se [193.12.253.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B6C1E4A9
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.12.253.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724850765; cv=none; b=QjlVugbF+f5rQQ9HRoiQD/ov0t97r6jyvthMUPYVZ5YQOXkHn+psgQB3AV+BjBUtrhGMoELYuXWlKzhHDaJ0lSo4E3JWtsQJNpbXNZaCBtiA7YfNqAglNgPwszDSnSSIZCmU/uRysudgBDw+9qt7g7PSQlLgeszugDXXzNT1dH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724850765; c=relaxed/simple;
	bh=4aC+ODZDVYKBW4KPxz0WT7cx12FOija9FJSoezr1r1g=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=HwYKPTk6pL65tRtbsA1N9ZNyFvggvGWPtsgkccOHHxrmhCyFSMNEI0NdlBjL+hh6AbTBrLUJfNMoOb24eO2LXNnY4pAisINdcmsJcbUkp3ueT4fBIY31Kj2SOnMGYCZh3tr5xekYb/nQ5mKqVORBdu/ejXLPvX9Qu/SdM3NMMVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cendio.se; spf=pass smtp.mailfrom=cendio.se; dkim=pass (2048-bit key) header.d=cendio.se header.i=@cendio.se header.b=bpj9fvCC; arc=none smtp.client-ip=193.12.253.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cendio.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cendio.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cendio.se header.i=@cendio.se header.b="bpj9fvCC"
Received: from [IPV6:2a00:801:107:4700:e2be:3ff:fe9d:f27] (unknown [IPv6:2a00:801:107:4700:e2be:3ff:fe9d:f27])
	by mail.cendio.se (Postfix) with ESMTPSA id 05F641835BFE
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 15:02:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.cendio.se 05F641835BFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cendio.se;
	s=20240530; t=1724850176;
	bh=/39RDTDi/01yjPOSfGRkBwB7xTeNTCnSATxGYvIePGs=;
	h=Date:To:From:Subject:From;
	b=bpj9fvCCcaDrKcUYFY2ErLTji7r/C7CnOY2qiW3L64hUIRIQ+2SMfWFNgZCcbYrIu
	 /pbm8KLwsu9bDX08BJg430bpf68xeU1fLU8mA1waMG2U71YQXIX/goaoP+8trR6ZbW
	 9BJayyAaoBcfzDpVen31dWhqJ/lX0adEZr5fKMe+Yk9AaZM85iwtQop5wRdrJeCpjZ
	 5mPmdWQ6XIuK1gQB1aADSSSlbPFGnbYKgyiRWXUK/JoXkZaxpH42lhEkjFFarlzUtw
	 Z+qWM9mBFM968EMKzvxLYekUtXPghA22XfV5C4XzRmzLuS5IznF6r5mZSgqXSFDrt+
	 n+DYRWr5kgqRA==
Message-ID: <fddbaeb1-d9eb-4494-b196-94fd4b666471@cendio.se>
Date: Wed, 28 Aug 2024 15:02:55 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: Pierre Ossman <ossman@cendio.se>
Subject: RFE: Document "edit" in "git restore --patch"
Organization: Cendio AB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

"git restore --patch" is a very nice tool to clean up temporary gunk 
from your working directory. It has an "edit" mode, for more complex 
chunks. But it's confusing how it works, and that confusion is not 
clearly documented.

What it seems to do is apply the edited diff *in reverse* to the working 
copy. Technically understandable. But still annoying, and a bit of a 
brain-teaser, although manageable as long as you are aware of it.

I think it would be helpful if this is more clearly mentioned in the 
documentation for "git restore".

Regards,
-- 
Pierre Ossman           Software Development
Cendio AB               https://cendio.com
Teknikringen 8          https://twitter.com/ThinLinc
583 30 Linköping        https://facebook.com/ThinLinc
Phone: +46-13-214600

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
