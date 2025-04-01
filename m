Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBB5126C17
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525043; cv=none; b=fXGhMe0EO6maxsqlHGbYM4zsXNi6lBnWCCNGFgItc9NUALuEp7uVAbLqX7gdbxczUsV/6kY8Geg4JRQYAMjr0Av63KLwatFx2AA5NfJiIbUPbUhpuXRY+2INZrh6tDy13HsutQqqan+vvsB9pUKaW6c4R91hve7clnBFXOrTnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525043; c=relaxed/simple;
	bh=ASGb7BexuFgPBdhyzWik6Tlro9KwxS2C9zJOZ1eeQxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pSdIQjlpdzJ9u3hg5r6C8S/hdBaydgUt5bNK1n6XGgmmJZBbKCfNaRhSz8tQb4adE95nGdqjJ1zJkD75FbwgdfNv+m6TiMJvDxGz/MgaHbNJrDcXBniGlT8yrnGdMhDWciVx+9E67rkhHu31cg068TCou827UIfuV7th1RfySYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=HpzfMfLU; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="HpzfMfLU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1743525036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sQadPGShYrt9A0gkHj9wEGMN2cExfV0hC4Oy9Ri7/cM=;
	b=HpzfMfLUNjYhOOhTPjpJMhnbGbXDkVL+kdyoVlvKD8CMtCFahjCNkSaNRzfbb/KbuUqcof
	uO7YHvgU0vZ6g2kmNEkdkLyGe5+mIEMhBUpeUX7T+H4yqf7M7pjdnKQ3v9ifde1pCiLdhg
	Ra3fxOe1gf/yj/pTdpSd2wFkJIW45Ow=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Sam James <sam@gentoo.org>, Eli
 Schwartz <eschwartz@gentoo.org>, Thorsten Glaser <tg@debian.org>, Peter
 Seiderer <ps.report@gmx.net>, Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/5] gitweb: fix generation of "gitweb.js"
In-Reply-To: <20250331-b4-pks-collect-build-fixes-v2-2-6b06136808f3@pks.im>
References: <20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im>
 <20250331-b4-pks-collect-build-fixes-v2-2-6b06136808f3@pks.im>
Date: Tue, 01 Apr 2025 18:30:22 +0200
Message-ID: <87ecybg7z5.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> In 19d8fe7da65 (Makefile: extract script to generate gitweb.js,
> 2024-12-06) we have extracted the logic to build "gitweb.js" into a
> separate script. As part of that the rules that builds the script
> has gained a new dependency on that script.
>
> This refactoring is broken though because we use "$^" to determine
> the set of JavaScript files that need to be concatenated, and this
> implicit variable now also contains the build script itself. As a
> result, the build script ends up ni the generated "gitweb.js" file,

Tiniest typo: ni -> in

But that's all I've got about this patch series. :+1:

-- 
Toon
