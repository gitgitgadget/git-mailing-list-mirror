Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8684C4DAF99
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 20:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799893; cv=none; b=ehg3IjNYImPHed5xkpFHXpssYqxwoCbAxY7TB8CfSyhFjmEsKXcm51xyNcd8KEy6P2sSGLq4vt224PuX3kWLRxHiaHJ/ynzH2b7+vq2elG4zAS1bQGh0DnvysXUYEh3XYatOyDsmc4bscUarXE0k5ATum8lHyT6BsnFM9hb2kUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799893; c=relaxed/simple;
	bh=ZNnE21VbZEdHGEnJRg+LMAENhYdJlfFjsDNgdRYoduM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uh3LnYRgr5eJNLDd+EWCyejdeLFnNwpFSKJv0ZjCuGnFG6nY9G6xdEZaF41tOI9ZqDPi0Le48Ux+LrThYHVXGWc6SEUinzaOba5dbvkD07MME3chHiT0hVc2LBipyt3+IjuNt8Th+rAj8WN9/OyVmYjlHNPpARR2BjMvjvVa+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4hw63G5lnnz7Qf2W
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 22:24:42 +0200 (CEST)
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4hw63571Q1zRpKh;
	Wed, 30 Sep 2026 22:24:33 +0200 (CEST)
Message-ID: <223c99ea-64d9-46da-9631-ed8035f1a062@kdbg.org>
Date: Wed, 30 Sep 2026 22:24:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] checkout -m: recreate conflict labels
Content-Language: en-US
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: Elijah Newren <newren@gmail.com>, Phillip Wood
 <phillip.wood123@gmail.com>, git@vger.kernel.org
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 30.09.26 um 11:48 schrieb Phillip Wood:
> When "git checkout -m <path>" recreates a merge conflict, it uses
> the labels "base", "ours", "theirs", rather than the labels used by
> the original merge. This short series teaches the ort machinery to
> write the labels to ".git/MERGE_LABELS" when it switches to a merge
> result containing conflicts, so that "git checkout -m" can then read
> that file and use the same labels.

Would an index extension not be a better place to store auxiliary
information about merges?

-- Hannes

