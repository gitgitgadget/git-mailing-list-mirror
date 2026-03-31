Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A183DA5C6
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943814; cv=none; b=bFhmfemlIW6DB+Z1GVt0OTLKSVxYwOH6/ddJnDOwDzpFS1CQmmLDWi6uvS3dLaUVuxdPJF8sOUCb/Lky8QwDlyFcKbyAsCJYkzQES2qqGs2sGI7KKTijBrNvb3XCIxW2NP9LPmOpNA+1XJGNW1Ez7qI3xaeOAhIVTQV/lmM4AJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943814; c=relaxed/simple;
	bh=l+MnKFWjYxjYVK36KjflUOCWDzyavw2beetTfUVdkE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yxu2Gp2wTRCYU09Q9GznaklCq54at18u1OE/GKVDV2v6peELsuP/dgsLFtOx9IYzWoKKYJ1yoBHIWFXLt9R6Mw0w4Km9V+33AQdxDqbzcHPSBWPOCHPrK2haIUERgXI48AM9eyC9/ZR8/xUP1jh9s4bCoSKuT/ePHv80yj++ZSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=QuM/Uq+d; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="QuM/Uq+d"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774943809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k/LZwnPSjaR6aANV7GVwGSBBydO0sRqn/JOwxQz7Bf0=;
	b=QuM/Uq+dMUfHrKdntWd8els4Cr3Ys2y7aa973vyysUEuVFkG68LzBgnxXTx8I5Af1Mzn55
	jPLnEMxB/ASBVi9tJ1LoKYU4cfqVHi5jN+r9wLhsr/Mgpy/ZqLKvKATdUhSJSw59og3Jxm
	TzCDE2cfta2vFpPOZOd5MIosTtwpQGU=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>, Siddharth
 Asthana <siddharthasthana31@gmail.com>, Yee Cheng Chin
 <yeecheng.chin@gmail.com>
Subject: Re: [PATCH v2 3/3] replay: allow to specify a ref with option --ref
In-Reply-To: <xmqqwlyzu4ua.fsf@gitster.g>
References: <20260325-toon-replay-arbitrary-ref-v2-0-553038702c9c@iotcl.com>
 <20260325-toon-replay-arbitrary-ref-v2-3-553038702c9c@iotcl.com>
 <xmqqwlyzu4ua.fsf@gitster.g>
Date: Tue, 31 Mar 2026 09:56:41 +0200
Message-ID: <87qzp0l9dy.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> In the modern documentation style, this should be `--ref=<ref>`::
> but let's consistently use traditional style and leave the clean-up
> until the dust settles and when the command becomes more quiescent.

Yes, I noticed various things aren't up to stadard. I'm happy to include
a patch that cleans it up. But agreed, the dust needs to settle first.


-- 
Cheers,
Toon
