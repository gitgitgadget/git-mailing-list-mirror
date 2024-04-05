Received: from silly.haxx.se (silly.haxx.se [159.253.31.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0540A175548
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.253.31.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712352638; cv=none; b=kWty1CdQpescXfIqgpcvvE5gwaRO87GMM8uOSarzBqfHJjWVMjRd986dreIfAIjuSdllDBVto9HfGxLowm5rM0OiI7PMW0l10iVB/atbct8dK9xILifnhaUo5juGfreUmad6+I1A5I220tq2swaNGh1odpk2/Of1n2zuj9aM3AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712352638; c=relaxed/simple;
	bh=HQQOaC/VVkQ0qY1f1+Pm2fdaVvD431mRv/N3m0sFijk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PX50f7L9D3W32KjDap3ssn+HlKBoUquIvGePAK+lrHKpRu0GQTd+4ZsCnQ4WLKpgiYaokWJtOyhN07UnKGu074FOj4UKQv5jxfN3oo81DBnnxgTMqQNe+9jERize9AplPP7ei4aaRqbgYNdLguDsRbwfvlTYMiVRGXhD40tAtTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haxx.se; spf=pass smtp.mailfrom=haxx.se; arc=none smtp.client-ip=159.253.31.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haxx.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haxx.se
Received: by silly.haxx.se (Postfix, from userid 1001)
	id 6F65265797; Fri,  5 Apr 2024 23:30:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by silly.haxx.se (Postfix) with ESMTP id 6EA687F2EB;
	Fri,  5 Apr 2024 23:30:27 +0200 (CEST)
Date: Fri, 5 Apr 2024 23:30:27 +0200 (CEST)
From: Daniel Stenberg <daniel@haxx.se>
To: Jeff King <peff@peff.net>
cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] remote-curl: add Transfer-Encoding header only for
 older curl
In-Reply-To: <20240405200451.GA3700566@coredump.intra.peff.net>
Message-ID: <n18qon6-9r33-9224-6rs4-64onqrp4794o@unkk.fr>
References: <20240330000212.GA1261238@coredump.intra.peff.net> <2n7sn76-p413-5632-4o2s-o5n2p1rqnr5@unkk.fr> <20240402200254.GA874754@coredump.intra.peff.net> <20240405200451.GA3700566@coredump.intra.peff.net>
X-fromdanielhimself: yes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 5 Apr 2024, Jeff King wrote:

> Here's a final patch on top that gives us a workaround for the HTTP/2
> half of this. It's a cleaned-up version of what I showed earlier.

+1 from me.

(and appologies for this regression, but you know...)

-- 

  / daniel.haxx.se
