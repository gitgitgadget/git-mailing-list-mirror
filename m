Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FA213FEE
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774008947; cv=none; b=bAiWkmj4JIDmBDcQOg6ElqICB9U/51xPZcA8EUzJaS+O+4Rp1lEqWBHrhxSFex+eiToThLRE9rXby+WEOltx49AAQUqJ7xUCuoaOikAOh8rlBA/UQFnubUt/MK6ULkSzuhAACSXSZuvSGvfq1ZDQ0i0oLpm0VXVQblzAmPNCRtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774008947; c=relaxed/simple;
	bh=DZMc4GMxNHrAH1fSrJp0kmZxRrx02gDsgvFzGAMkB2E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BAgkRHEWwLc8OLRlTVH4vJBIvGUsaa5Sq9D+PJLkrz1YiXliIfVzA+BPWm0iL0yc8zKv8q6iXGDwWdGUDKM8lho7SCvRZAGPIHAwJUj/86J+hdWhx7DvjAo62BgH28UmyEROG1OSqzkoF6eEf4Zuu0LPKgmbqNxFIiSxmyWN8Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=tiSuph6t; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="tiSuph6t"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774008942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ORbOHDbfILNStfOgVu6YJ1Gci1oWLC4zuEdBg+8PIe8=;
	b=tiSuph6t/L2NF44Pel4EGahUou/ly9dqaEk5kYtPstq2Pnl71A7LB20tCFH8mwmN9CxnHv
	5/PKxR/A+LOpLs/66vWM7QDW5isW29O4lXypjoVrnEsuB9nG+jyXXXe+UeOnGD2QcrFxZG
	NQuSvU4C52NMZxhSt685RoHDBCHoSUc=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>, Junio C Hamano
 <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 3/8] contrib: move "coverage-diff.sh" script into
 "tools/"
In-Reply-To: <20260319-b4-pks-build-infra-improvements-v3-3-82f5fb3edc3f@pks.im>
References: <20260319-b4-pks-build-infra-improvements-v3-0-82f5fb3edc3f@pks.im>
 <20260319-b4-pks-build-infra-improvements-v3-3-82f5fb3edc3f@pks.im>
Date: Fri, 20 Mar 2026 13:15:37 +0100
Message-ID: <87341u3dee.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The "coverage-diff.sh" script can be used to get information about test
> coverage fro the Git codebase. It is thus rather specific to our build

Tiniest nit s/fro/for

> and test infrastructure and part of the developer-facing tooling. The
> fact that this script is part of "contrib/" is thus rather misleading
> and a historic wart.
>
> Promote the tool into the new "tools/" directory.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  {contrib => tools}/coverage-diff.sh | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>
> diff --git a/contrib/coverage-diff.sh b/tools/coverage-diff.sh
> similarity index 100%
> rename from contrib/coverage-diff.sh
> rename to tools/coverage-diff.sh
>
> -- 
> 2.53.0.959.g497ff81fa9.dirty
>
>

-- 
Cheers,
Toon
