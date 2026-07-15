Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5381448CEF
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118717; cv=none; b=R8zBLbvLKDUrdrg3EDdguk4uGa+XgR9u0Y6hGDMsOQqk/GllG/NBUPglHXo4qqGeZT7ALr2bS498Vz9FhZ8ZBxjiR64vxFrZ+5erOKTN/ARXXipUUGzve40VSwenjefmPEcZsi8L5utdlr18UVMmKRJCsHKnyWBvW8lYlCRlsXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118717; c=relaxed/simple;
	bh=TKFYJbARrIJxhjgqtloH95Vut0IXo6qFv0RP0Npf/uU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aMlDo9pPWkzpYdCGIWkSuoUK6ON3QByLySclEedx8vCSZaaT3MnGrdCO8l8Z4Sl/DBmcWkwSSXNAW8C9MiT4yPgd5ldsajIco7JeMaOL0XJhmw1PmZaz0gYXOOWraNFs8hHofYhY13YGovNdsz2ec+Uaz6f3iGDye5DLbLtgKFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=asiVa9fV; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="asiVa9fV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1784118714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LiURGbOnAqk5XPSHw2KdJYVegMcmYLq7zBkPSxXo6gs=;
	b=asiVa9fVwRJVstX7lPopbhrhryYJBEScXeMr8Xx+RlhBVVprD/OKErjFWddjw43HvReHvr
	HRsmv2O4s3NYBluHNISq5FqrLlPomcrGoX9ScDMzsNrepkLTMuQJvYE/FPKJ7sQi19J8Zh
	8eHVAL0Yhj7t3B/+b5ks1UXmOm83KLU=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/7] refs: remove use of `the_repository`
In-Reply-To: <20260715-pks-refs-wo-the-repository-v2-0-d00d364f5a3e@pks.im>
References: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
 <20260715-pks-refs-wo-the-repository-v2-0-d00d364f5a3e@pks.im>
Date: Wed, 15 Jul 2026 14:31:48 +0200
Message-ID: <87y0fcfn7v.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series refactors the ref subsystem to drop uses of
> `the_repository`. These patches were part of a discarded attempt to
> make the initialization of the refdb eager. I guess they make sense by
> themselves though, so here we go.
>
> Note that these patches contain a slight tangent to also adapt
> "worktree.c". This is one of the subsystems that caused problems with
> eager refdb initialization because of `has_worktrees()`, so I refactored
> this subsystem while at it.

Changes are all very straightforward and, except from the small comment
on the commit message of [PATCH 2/7], I approve this series.

-- 
Cheers,
Toon
