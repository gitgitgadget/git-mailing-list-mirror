Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137BF2609C5
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784315627; cv=none; b=dIOldSmErLABuaRGEbggMtYp8oV0meJmfME+SH7guzpkfDBn41jo4i2KNK0Ks6Gup1Mc99Ms8r3pcpHK7bXD3KBGfRE6MXtEAdjr5va7ZOpZ3KhY5mb4sUewUlApSOKtXUBVvP5U2nXFDzliIH3pkKMgEtF+8l7knarEJX6H8og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784315627; c=relaxed/simple;
	bh=GRQK6DcrSwkorh9uwrxphHJmKWiuc6eXr1XRVmmLI7k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uSQ/BKfz0AHl2mJ69gUHHWycQqz4hVrA7WL20HlsnnGnz/IaglsrQU2eiyDJqegVUfIxeBdAOjtO1tc7ewgKM/wQ7JCrIpimNvKsSwrytgzo9oR9IOwgjuQkXH0QfyWQdpRpXuoLCiU1g7oQyQ1jra3jtNUcTJl/3dumJ3Zeg0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ZXtIkSsR; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ZXtIkSsR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1784315623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xm9OQ1m0Oj9uf6/EbrDZY09NL+Ak9aeNm/zyStyNXSA=;
	b=ZXtIkSsRf/oXHfTxeEK4ZqQ2tFiWa2idp4oW8COV54wAtsFl/tWxbKr9gDEaBNU5yYNYBf
	GkqX3jPaKqgCoqKPtgPfFam5cJJd1pf5lorXiFwEoiUdpTGmgBdmkXjCElXI6iD14PnYvp
	5lZz51jr5PSGVO8RzJOHEVqyAbNb+c0=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] last-modified: use the pathspec's Bloom key to
 pre-filter commits
In-Reply-To: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
References: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
Date: Fri, 17 Jul 2026 21:13:35 +0200
Message-ID: <87cxwl1lb4.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Toon Claes <toon@iotcl.com> writes:

>  - Patch 3 uses this new helper in git-last-modified(1).
>  - Patch 4 is bonus change, which optimizes when working with wildcard
>    pathspecs.

I just realize I forgot to add Helped-by or Based-on-patches-by trailers
for Peff. I'm happy to add them on reroll.

-- 
Cheers,
Toon
