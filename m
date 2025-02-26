Received: from c2562.mx.srv.dfn.de (c2562.mx.srv.dfn.de [194.95.239.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D468917BA6
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.95.239.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574074; cv=none; b=CkXTWkwUZQ7Mo0fuBXVf/YeE8KHYYMMY4w1K+S4ZzATATn1y05LwTeFwl1aRRGhh7aFdC9sfAKtNw3oqVA/cpnjz1OdPDHbaVwShbcUbxotVo0/iz7yssjt0RI4o1NjGqo3EooMIGglTtljQDXERlZyTMtrAeq1larxoBwv44qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574074; c=relaxed/simple;
	bh=GRWPvE6DOQX28FMoYfYszrzZ6zWBGj376TRk6+JR88A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KumHqVcekbcZOafZ9rGBXKquMdP/5h/eFnb9pgBIA8sH0a6bc7lTXWvNd0Da6uEDkaLvRz4zm05LhvBADVvXJMcowkJ9ZPedBlAqj5NnP8mLGnJiwe7wZoJbrg/8kGC8m2HoVs7IZKgC7iVs/HNJC+JCQ2vFz15BDAt9M5k2wqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=physik.uni-regensburg.de; spf=pass smtp.mailfrom=physik.uni-regensburg.de; arc=none smtp.client-ip=194.95.239.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=physik.uni-regensburg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=physik.uni-regensburg.de
Received: from smtp2.uni-regensburg.de (smtp2.uni-regensburg.de [194.94.157.130])
	by c2562.mx.srv.dfn.de (Postfix) with ESMTPS id 4C0CA18005E;
	Wed, 26 Feb 2025 13:38:09 +0100 (CET)
Message-ID: <5d53acf4-9d46-4fa7-9430-ac9c5ce47862@physik.uni-regensburg.de>
Date: Wed, 26 Feb 2025 13:38:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] Fix netrc usage with WebDAV-based HTTP protocol
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>
References: <Z7UPYY24uk7lLzeP@tapette.crustytoothpaste.net>
 <20250223015331.588161-1-sandals@crustytoothpaste.net>
Content-Language: en-US, de-DE
From: Peter Georg <peter.georg@physik.uni-regensburg.de>
Organization: =?UTF-8?Q?Universit=C3=A4t_Regensburg?=
In-Reply-To: <20250223015331.588161-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/02/2025 02.53, brian m. carlson wrote:
> I will note, as an argument in favour of removal, that
> we have git-credential-netrc helper in contrib that users can enable if
> they want to retain this functionality, and we could even ship it by
> default without much difficulty.  For those reasons, I am not planning
> to add more tests and documentation here, but of course I welcome
> interested parties to do so.

This approach seems reasonable to me. I personally, for example, did not 
even know that the git-credential-netrc helper exists, but it obviously 
works for me. Thus it would probably make sense to somehow document 
this, at least once the undocumented feature of directly using 
credentials specified in netrc is not working anymore.
