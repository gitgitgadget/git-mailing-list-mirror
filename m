Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F02C2E1C44
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753898365; cv=none; b=gnzE0JorPrHLKd5MSMVzBbbDqCFN1pZgXwhjEzfEWQe5JTJbyD4QCX7xvJ+c4Wqvy60O+MqrulP3hllrbhtTZwr4ArBsqAqgBYQBPwnZ3z6M3gNngT70gxrIN/91cCnSC1zfRSnr/ySdCY6PV/qjOWZ1UQFAcQO9LTzYPSP4p9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753898365; c=relaxed/simple;
	bh=SNkfYU1iN436enAbZ0+Fp5uxFACgBBq7N3JnOEs4guk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dvc/U3SmNASdKWKgFBsR7/ReX9HASrX/aHCSWli79SpmTrBLAxjxPA9CJ/Hv/EiBauvgIxKpt6W/W4jiHiaeYyGVbA6z7RKWOr7zEx+ztPdJGrSMie5xb22rLJN0eIf6bN6hPQH0+29DOhv6tjxzoRPARM5ssd3exNPLbeD6Rhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=3GETKXGO; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="3GETKXGO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1753898360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+G1KpbGgSBPLTQQ7xzJFW+K0kqfBs0t7bjocpHqF9Qo=;
	b=3GETKXGOcHTWAnz6Jj+hjsqXyb9FkVYBkszTRvMLeveyANntQpbjqPYO3wBLS7ZI5haD2r
	hT7+lpWGun9Y/EMf9WP7QxuBdUSJ4I1OrUkjIGG9IfFzwA2h7UD/aoGtccYVjVOSOLqjlh
	kqCuVVAGGgFCPaO7XpIRqbRwx5hBsoA=
From: Toon Claes <toon@iotcl.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Derrick Stolee <stolee@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/6] Introduce git-last-modified(1) command
In-Reply-To: <87a54wkzll.fsf@iotcl.com>
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
 <20250716133206.1787549-1-toon@iotcl.com> <aHmJmwvYmAyi3Nlh@nand.local>
 <87a54wkzll.fsf@iotcl.com>
Date: Wed, 30 Jul 2025 19:59:10 +0200
Message-ID: <87h5yta7bl.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Toon Claes <toon@iotcl.com> writes:

> I've had this patch included in version 2[1]. I'd love to include it,
> but it didn't give the results we were expecting. Over time I became
> more confortable with these changes. Let me see if I can get more
> insights about it.

I've spent a considerable amount of time on this, I didn't get to any
breakthrough. I just submitted v6[1] again without these patches. I
still love to figure it out and bring in the improvements, but for the
first iteration I think we're okay without.

[1]: https://lore.kernel.org/git/20250730175510.987383-1-toon@iotcl.com/

-- 
Cheers,
Toon
