Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E35C2D5C68
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771603687; cv=none; b=ixcdVcuh7nLp1tbA1RBtZOxoxzWot0BBtGOJRoye9HBHfeaWRpbEl7p60FgfsHXrcRHkT7llldS5A6KM7n9VJkCFPPADHhRrr/mThbE0MxJzR2+pTJnIAb2Jf9uZcvjB0K0HuIBcZA300dn8MqV4cXZQLXSUc5qgmwnR5FtLVqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771603687; c=relaxed/simple;
	bh=oggRhx+k1x9n9D3cbt0kCu5WrYQ5bYUMQK9VXKZyNMc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nn1z5CTX0Bhds2EUlqFkpgKynuWUHRvFdaHvy8Z8+jxGCEr8x4YlQzbqrQYwmiXMKo+2NRfyB2tm7QQbhWn9CbHc3GDPaAnxc1bC2K+IUEHRZhFjntOV8UHsSYmBZfEZHgi3tVAXZXYJK6N+8c7Dil0ZUwLGSviytY3/pVRReIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=T4xlvkEs; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="T4xlvkEs"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1771603683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uZD0fYfIpR57fYfsLvzAmaqWhK17JTOEXyjWZ44qOdE=;
	b=T4xlvkEsa6/Op8lAaKZIcEpZ83YOzZ3WR1SjLwnhwLaXxoIZdVf55sKP2EJK/af+3dcSN7
	4rk1EepibcqO/3ys3606jcsjM+dWbF+NkXAC+7rakidlkxP6JrLJgNyK7hTGcAeN9qgQlx
	FH2NYjzcZUA89IWjMfaXGSDgV087oSw=
From: Toon Claes <toon@iotcl.com>
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH] object-file: use `container_of()` to convert from base
 types
In-Reply-To: <20260218210120.1146078-1-jltobler@gmail.com>
References: <20260218210120.1146078-1-jltobler@gmail.com>
Date: Fri, 20 Feb 2026 17:07:50 +0100
Message-ID: <87zf53e6uh.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Justin Tobler <jltobler@gmail.com> writes:

> To improve code hygiene, replace direct casts from `struct
> odb_transaction` and `struct odb_read_stream` to their concrete
> implementations with `container_of()`.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>
> Greeting,
>
> This patch is a small cleanup following discussion in [1].
>
> Thanks,
> -Justin
>
> [1]: <87o6m5rff8.fsf@iotcl.com>
>

Thanks for following up on this.

-- 
Cheers,
Toon
