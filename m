Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D182AD16
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 20:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767816963; cv=none; b=J6HR0qww3ckdpxyrDtrjLqLJNafpb05ftxenOzjaqGtyrvlX04AGhq9N6qRBqsdzHyqJ6xHbgW0b8wEmJf94iN5IpouNrWCNzI8XsJhRSUYD5sGqjAk9ORo0PCydWTJ/AxwsO5OHmWMdVCz1obIuLbxIrqQ0oIc2b9itjOEnCt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767816963; c=relaxed/simple;
	bh=XsGIkmc4kDEe9+KZ7RR7/eunX2T0nd+lzuk9i8m6x88=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iE4gimtxmqePJOWPjlHHwBLhd7HIy4NajaRFsvGK1AfLwTAfbDHGlDL1aBvnZvY5m6rS1diK8BoSrXfUc3yguZOUb+zvzesJElUj6iiUnnQMdE8UdXP2q3uIFPNlUFWiWlTlm9iecSKIZrxKAsQrbxySulOPtefISRb8sjwYwGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Pshuxf8h; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Pshuxf8h"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1767816956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yj+lxzr9UaXxYYaOdp026ssnENjjJNvXFaxcgH7NEYE=;
	b=Pshuxf8hF1P+k0juLxDkHCNiF8s5xr60i7+k3Wq9tfS25zqqHMHKkl8G1+9akZIRw5de5X
	5EB1Du56Hq7jeko1ezyD6kG2wom6negzqNpuw9kJtmm5TL3hfUS6i967RzE6Nq8bnIdEaq
	+hLVA50qbrk5/FmXHoUbn0bqFHtLihI=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2026, #02)
In-Reply-To: <xmqqbjj8koe8.fsf@gitster.g>
References: <xmqqbjj8koe8.fsf@gitster.g>
Date: Wed, 07 Jan 2026 21:15:37 +0100
Message-ID: <87wm1tnpqu.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> * sb/bundle-uri-without-uri (2025-12-19) 1 commit
>   (merged to 'next' on 2026-01-05 at 62d0a58199)
>  + bundle-uri: validate that bundle entries have a uri
>
>  Diagnose invalid bundle-URI that lack the URI entry, instead of
>  crashing.
>
>  Will merge to 'master'.
>  source: <pull.2134.v2.git.git.1766160106521.gitgitgadget@gmail.com>

Cool! I had this one in my backlog to look into, and now I did. Looks
good to me, as a matter of fact, I had a similar patch somewhere in my
local worktree.


-- 
Cheers,
Toon
