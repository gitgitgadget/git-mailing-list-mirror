Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DABB29DB65
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769778200; cv=none; b=mZvLf3FtWxPjW5YiTDohxquv9TXAZC6nbZd+ShQWmrtK7tWf8SKTeTLPYWjRi7r909kSE57Z2twKoX0F2kIhp9MZxZlQhTDPC42Rvsxvkb5ICZ88IaBefz0nIA0XwxQQe5K3WX1SujavozlsUrF4ELLK45mS3KHthJtDl9cA9yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769778200; c=relaxed/simple;
	bh=VV8TKK6mvNp/K6MXsIENC0dLDz88c9QaiKsiaktZcZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F5R4EhSNPjc5vTwmQktGxJ1sZgE4sfvb9Xcm/yDPQzWbrWo6N0AAtgnUMNQME/xRF8d1xKAod2yWgZrYoKjYCQBBZX4FoVwLIkxD1dcp9wjbkjYLTd8T7BMqatKwdKgN/1fr0kRLkeEam8J3jV1wldVgBKHaBwhAC3VdEINMGTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=z4oNUuI3; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="z4oNUuI3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1769778195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8GJKYJNTB3UhEqc7zMjkM7S4Wx8eJiTgYkcpZpwdZO0=;
	b=z4oNUuI3c6o2kynsv/y5ikEKNrVugLWcSK9evw4mK0EHu/Aoa+kKsbtnp39uXsMlZjMWSx
	QBs38TKrATuGC5X4fDPfNbSDGUMwydVli0sN4f8h24fS/2UHYrSmwK4WeOJrZC8grchXK5
	RjjxDDCo6Ul0SMzAiaNegqeDDvBuVjA=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, Christian Couder
 <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.53.0-rc2
In-Reply-To: <xmqqpl6vezt3.fsf@gitster.g>
References: <xmqqpl6vezt3.fsf@gitster.g>
Date: Fri, 30 Jan 2026 14:02:56 +0100
Message-ID: <87qzr7qmm7.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

>  * "git fast-import" learns "--strip-if-invalid" option to drop
>    invalid cryptographic signature from objects.

This is not entirely correct, the option is
"--signed-commits=strip-if-invalid".

-- 
Cheers,
Toon
