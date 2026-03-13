Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63D8295DBD
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402770; cv=none; b=JOvBtDQwudMM4ztQXri6qv3MjQmCN2xV0Z70R5BQoC8ree/S1h+6TRcl59BTTqH/bE9MYdWXTzRDo9dqyHKPbZ9LKWOhn1xkbg34y2ndR+b/XEWmRXr/Q/mTyFUAqgEc9OZDILZkP8V/vACMKEObgTp81ZPL8VSp5cokFEVoB3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402770; c=relaxed/simple;
	bh=76nC83M4i3myvNxWP2vmGWQ3Ua7e+Op8d/HQO0ruPdU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HzXqVPHKYyo4zU2/Oh07bQbQL2jrxOEXB01qOsM/BWeyV20mkl3QSQ0bs5M0pHgGYCpVZcC9mOXOY7EyQxFGuWkG/eWddlM1eawDCYQWi50dh9m4zhDZY3ELm3OT3MFNcX6lUeAU958aipfryerBUmKIeTwUOQYmw7ZX289dVDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=MUtvVisV; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="MUtvVisV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1773402765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rwek0n/GnJKpTLzdb2D6boxkZZEsO+s0Vs+kAmxHruE=;
	b=MUtvVisVbg1el/nACziIa6YaLXlK6RWbstNh7jY3oR55Vj7ELtGDMwNOVrhGkKrWIEpY+c
	UApiXlIM1UDTvxqzySLU663uaIrtQKWreHcWSX4A+w970bXAGv+nCO5zTnqOpYglSpMjqR
	tY9DwXhOeV5NRxtOR0hGsU7ZKfrEkvU=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 0/6] odb: introduce generic object counting
In-Reply-To: <20260312-b4-pks-odb-source-count-objects-v2-0-5914f69256bf@pks.im>
References: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
 <20260312-b4-pks-odb-source-count-objects-v2-0-5914f69256bf@pks.im>
Date: Fri, 13 Mar 2026 12:52:36 +0100
Message-ID: <874imkt08r.fsf@iotcl.com>
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
> this small patch series introduces generic object counting for pluggable
> object databases. The series is built on top of d181b9354c (The 13th
> batch, 2026-03-09) with ps/odb-sources at d6fc6fe6f8 (odb/source: make
> `begin_transaction()` function pluggable, 2026-03-05) merged into it.
>
> Changes in v2:
>   - Properly initialize `out` pointer when counting loose objects.
>   - Fix a stale comment.
>   - Fix a commit message type.
>   - Link to v1: https://lore.kernel.org/r/20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im

Looking at the range-diff, all my concerns are addressed. Thanks!

-- 
Cheers,
Toon
