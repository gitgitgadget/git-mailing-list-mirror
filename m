Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A300291C1E
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759950386; cv=none; b=MnXQJ33c6MHQQr1Uz3CTirmFCbq/rXfMk4qjWiMXMG0/p5fExLtl6WF2rnXMId+vkXwz/6bO2KewsldadUpTuHdhwYK0NQ2aSO4Ze4mf/0T61KDonIwpnXs0lu8i2MMd8okeG/eU+ptFtmfNebpjgm3gDG7F6UXNeyX2tzFVL8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759950386; c=relaxed/simple;
	bh=5uch/0TAfdDBTPZ0nX2ktguDxQBv/i1/EyCZdJuiZ4o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=INy5kthlWcLjmsHe7QLMWfU+d1xoHzTBIM5aUZTImU30vjyyo82nuNflDZ5Y5D6ErXJQq+0w2ESHxHH8o6pug3zJyMShj5h4vvGNJ6I7Tzxc33t/1/VWJ7f2Q6/AWkfCOPbH27P9YismYngbQ84toqxUTudvSI1M2Hj7WCDs/bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=frost.cx; spf=pass smtp.mailfrom=frost.cx; dkim=pass (2048-bit key) header.d=frost.cx header.i=@frost.cx header.b=jATYpp47; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=frost.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frost.cx
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frost.cx header.i=@frost.cx header.b="jATYpp47"
Message-ID: <d3f49610-bd19-4bbf-a3ec-c15be2c07338@frost.cx>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=frost.cx; s=key1;
	t=1759950380; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=nYgaa5rNCIWT59iiambb8yEuTuGjfLWNCJm/S7aP+IU=;
	b=jATYpp47hvFpJINi6TrupDNpgTU8nyQMRg/gqSYEpL7vu9+SctwbcmIamshCSEDmChAv+o
	jCRcUBruGWml6DpsMPBfuZa2HYWlGmxd8F+gd1XHGidT5uCL/iMzn0J2nq7s7WzXCJDt1V
	t8JQ48yGmQfpkAh4rckH43Q+3s4Md6k5a9ys1VS25bq9ztJJpMkDQlXpQuVwI2Xcc36mhl
	2NmehZNtfkYYZYjVHdsdoSXHi3KjCC+15Ca++8mcMkyAVO06JIdZ1kYi5Aco6/eEPXcoTn
	yBa2uuvSXNf1Xu1f/iqF1JZqKEVJ9NUqAnXQ1c0Yv6MfWd4oZd37ZPhF7red0Q==
Date: Wed, 8 Oct 2025 20:06:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: James Frost <james@frost.cx>
Subject: Re: When should we release Git 3.0?
To: msuchanek@suse.de
Cc: git@vger.kernel.org, gitster@pobox.com, luca.milanesio@gmail.com,
 me@ttaylorr.com, ps@pks.im
Content-Language: en-GB
Reply-To: aOTtPxsdzJLPCruk@kitsune.suse.cz
Autocrypt: addr=james@frost.cx; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

 >   - Implementations
 >       - libgit2
 >          - pygit2
 >       - JGit
 >       - Gitoxide
 >       - go-git
 >   - Forges
 >       - GitHub
 >       - GitLab
 >       - Bitbucket
 >       - Forgejo
 >       - Gitea
 >       - SourceHut
     - Frontends
         - gitweb
         - cgit

Should we also consider other frontends, such as gitweb[^1] and cgit[^2]?

[^1]: https://git-scm.com/docs/gitweb
[^2]: https://git.zx2c4.com/cgit/about/
