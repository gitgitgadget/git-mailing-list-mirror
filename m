Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBDC20ED
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737723366; cv=none; b=GIMiMdWQ6wlWOaacXV504jnOe/xJN/Os1uk6V1GdicwDUMo+nVhdxwJCDi58nEfsXePEIJG3mxiFzNK/nmSAjDtwYdZlwBqJSLZStr5q/LkJhcwl3u2jiNKdSuYE9JezC782Vu9VOb66sGONb7d2qnojfhgD2MbzFUbEFqUu0Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737723366; c=relaxed/simple;
	bh=PWuzB2zQdYU7gim0k8LiWsSO7VmRFWEGV87HGnk8PAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UoDKAZ+qyxPr8hTb0Ji1Ioee3zbLaTKK+9Tgz+LxBLDqJ3NkiQQZ43S2pXCIIuO1j0AWq51B5LD6I13TFQc5/99eYicTK2GB0lxYhWK+A2Xlkzl6aoDSX4foch2cuNtROujVHGnDEzn1CT6JKLzAQcZFcfnfcKcMk9DcE6DOXAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=hzu4doE3; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="hzu4doE3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1737723351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cz800jg/uupD3rxuCRL8p5t47FTU8NklILE1S7zXFe8=;
	b=hzu4doE30qzYwS+mSXfiAntnMad5hZxSaBNRMZHwSYV79lRVrZDwuQRCRX1SCfWZOs5D1Y
	agsrZvHI6CiIsXAsjkZKjrdv9TpiCTuQUuUJbwXPpbiDRQsnC3wyy5c6a7Ez1h26JQWb0L
	/zWZ1OLQoEbJkw263k4gQyYia+aoLFI=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #06; Wed, 22)
In-Reply-To: <Z5MuCd_GbbLK_puS@pks.im>
References: <xmqqbjvyv510.fsf@gitster.g> <Z5MuCd_GbbLK_puS@pks.im>
Date: Fri, 24 Jan 2025 13:55:39 +0100
Message-ID: <874j1o5q2c.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Jan 22, 2025 at 02:48:43PM -0800, Junio C Hamano wrote:
>> * ps/build-meson-fixes (2025-01-22) 12 commits
>>  - ci: wire up Visual Studio build with Meson
>>  - ci: raise error when Meson generates warnings
>>  - meson: fix compilation with Visual Studio
>>  - meson: make the CSPRNG backend configurable
>>  - meson: wire up fuzzers
>>  - meson: wire up generation of distribution archive
>>  - meson: wire up development environments
>>  - meson: fix dependencies for generated headers
>>  - meson: populate project version via GIT-VERSION-GEN
>>  - GIT-VERSION-GEN: allow running without input and output files
>>  - GIT-VERSION-GEN: simplify computing the dirty marker
>>  - Merge branch 'ps/meson-weak-sha1-build' into ps/build-meson-fixes
>>  (this branch is used by ps/zlib-ng.)
>> 
>>  More build fixes and enhancements on meson based build procedure.
>> 
>>  Will merge to 'next'?
>>  source: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
>
> Ready from my perspective.

I can't really vouch for the last commit about Visual Studio, but the
other commits are ready for me as well.

-- 
Toon
