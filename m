Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A633D0908
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 22:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790892127; cv=none; b=tJceHxsQ9e99Vt9o9UA2Y0pr8zeX01hC77YLEaibRcD5aJCHenVX4mG0+zz2Y69pK6Wgjb3tzV65D3tWKr1XpvGSnABkTnJLc3QeNn/9hHWW4QzvZZqhmJ8vtgvW6FByq7Bgb099Y+DqBjky4nwq/Jbg6cDBGwXlXngPsMfCKpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790892127; c=relaxed/simple;
	bh=OqQILaHd8RmCZZOv/wNthxALhCFTeqyHp/64164eYx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJ8nFU8vNDBiXpI6t5cOCjnFp0M6GX9TpYGsv2Qakpab04yQ1XM+72L3ehtaX6Ctvpl5Zd56LwbGtznyp/xKtThACQt3brS6m1ghdRKRkdN2QpzYANVS42vK6kjvDoT5dFD14yWalYNAn/36ubfTn/7etxVVYLM64ASaDu1E7B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=ueA2pwcp; arc=none smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="ueA2pwcp"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2E2A34C2AB3;
	Thu, 01 Oct 2026 21:35:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (100-96-9-38.trex-nlb.outbound.svc.cluster.local [100.96.9.38])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id CBB8E4C0D0E;
	Thu, 01 Oct 2026 21:35:25 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Tart-Zesty: 405a7d5939aee566_1790890530017_3656308450
X-MC-Loop-Signature: 1790890530017:3473367550
X-MC-Ingress-Time: 1790890530017
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.9.38 (trex/8.0.2);
	Thu, 01 Oct 2026 21:35:30 +0000
Received: from ubby (unknown [24.28.102.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4hwlZP2L84z103c;
	Thu,  1 Oct 2026 14:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1790890525;
	bh=LO1FuEQs2tShW2oj3sVboUyYNl24EB64TLmbgKVOznk=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=ueA2pwcpvv/CapLoqTGFmz4FHXWJNbyZXD4n5tpWaqEIkvyvTd/i3ha8yiaV7Qkw1
	 K8Ikad8Dvox0bp8bmm8GSk83jm0hlSeP49QyP+BVgopsr08JCiGoedmPxiy5db5BVj
	 pRrvvehvovkdtyruyvB7wYwPtF2ek8/vMRlKQgLWmGIcnEx+tqv5hdCvdUUZQYy4fW
	 Gc1eqbR1oRTz0Wa2YuWYL6SHO4ImfQysuSmhZxMWnFG2aHuVKa8XkwqyQtzNljRqHq
	 WEmcwemR7xqPSAGuyMRegwnIeWJBbpHHEEIHuDm4VDh9UvOsYRbiVxBUnuQN72gcWO
	 9sIgAmyTKQFqQ==
Date: Thu, 1 Oct 2026 16:35:23 -0500
From: Nico Williams <nico@cryptonector.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: git@vger.kernel.org
Subject: Re: git-rebase-walk
Message-ID: <ar7SG6UKJTu1EmJr@ubby>
References: <ar5KL4_IKXYbx3Sb@debian>
 <ar6GExDLasWWFajm@ubby>
 <ar6LUeH3AjxbiMgd@debian>
 <ar6a8OkGhmYVoM7E@ubby>
 <ar69ZZ4r9ZxISIHz@debian>
 <ar7KDbV2ra7Rtzl6@ubby>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar7KDbV2ra7Rtzl6@ubby>

On Thu, Oct 01, 2026 at 04:01:01PM -0500, Nico Williams wrote:
>                                       though.. it's fairly obvious

Concisely: repeatedly try to rebase to the new base, then fall back
on bisection to find the upstream commit that causes conflicts.

`bisect-rebase` is kind of a misnomer, because the best-case behavior is
O(1), and worst-case is O(N log N) when _every_ upstream commit
introduces conflicts, whereas one would expect O(log N).  Still, it's a
reasonable name given the intent.

Nico
-- 
