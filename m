Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795423216;
	b=VSOOg2ZSb7ZeMqMQ4tfZTvSfRruZMyjg6voZnu5zg1CgNlDRJRrb38DFX1a6vMOekezy
	 zjfXA4R3Cn8TphCxgKgURX2xddVAVnLxvslqjKpjYhLwE4+qRu8uD9QeELEGnEgR8V6A8
	 eXhF9Q7Kbt7ajtpv4nrwy4IVqyy6TiuUgR6ZOVwNcbM0D32i8Z2OdmDH5riltEy2ZddGK
	 2LGBZ+1RVc25hcauyXhQ+oGNYLtYGZCWfXxxs6r0J4Ii3MYRT/34mO95UXr+xDbD0RVkZ
	 y0qcTf7kHb3FAJ1v+4OWy1CarmmkzhwKeOlYaBUQudacnFspJSiuHk3iEWWCDkK4mAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423216;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=gGXCBKqgv6jfsoj+Qi+kYMLPEQlZNSbdKaPYESI6x0I=;
	b=2sOseD1syQDAPHyIVwFr38Pty5NF1dJodXHbRjvA/fFal6fb00D2bmtlG0lbue9Cr1Ye
	 rbbiMUo6ajLejGlFYvU34E4Hp8Mi7FFxYwMjK2gUzywLoC/VVC72ryuGgyiXjer28JGyx
	 dPuQjo1rw8t6aZtZtaABbUuLDCTHTXN8xDRupzB9deGueOsqrTZ/HtNsjagEzEkOTaIQF
	 5qjK06H5rPknReUlxvwD2KA/oMCdxP7OFRVzkrmFXlvuo3ODc8i/Co22b+JEMIA7ON4C+
	 XUTddiayeQRPcrIFBDZhQrmrH/jYnGB57rKtT+GjYqEBS9BjQRFDhU8ajB1wszh0jtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b="oL/cF+iH";
	arc=none smtp.remote-ip=95.215.58.198
Received: from mta1.migadu.com (out-198.mta1.migadu.com [95.215.58.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E26606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 08:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3E26606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=oL/cF+iH
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZmnjLxSgZnQZMlwXL3ar7aSHoHLClh+4mxBxmxEzFVI=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795423212; v=1; x=1796028012;
 b=oL/cF+iHXjWLienVriOJj//gRQAOOamkYXXS11CRRvohgO1IIOTPUiBKZEny/0wmq1NZkRX/
 hUwpwYDcyPm6BHdmoaVklK0wQ6/dQX9ymH0IjCNihIfxx9V55zDwnVS5/5US7/srVJ5Ia8+8zho
 mmIRYuo9+fGtuV2frVDScKsE=
X-Envelope-To: git@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 5bd612a63571a9cd;
	Mon, 23 Nov 2026 08:40:11 +0000
X-Mizu-Trace-ID: 5bd612a63571a9cd
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Aniket Gupta <aniketgupta3001@gmail.com>, ps@pks.im
Cc: phillip.wood@dunelm.org.uk, nikita@nbobko.com, git@vger.kernel.org
Subject: Re: git-history(1) fixup broken with worktrees?
In-Reply-To: <20261120163712.64814-1-aniketgupta3001@gmail.com>
References: <87jyqt1m6g.fsf@emacs.iotcl.com>
 <e7dbcede-4486-459c-aa64-e44690e01fe0@gmail.com>
 <87y0evcjpp.fsf@emacs.iotcl.com> <aob_LsfI9cO3PewF@pks.im>
 <20261120163712.64814-1-aniketgupta3001@gmail.com>
Date: Mon, 23 Nov 2026 09:40:06 +0100
Message-ID: <8733ssj5zt.fsf@dev.null.iotcl.com.invalid>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Aniket Gupta <aniketgupta3001@gmail.com> writes:

> Hi Patrick,
>
>> I've created an issue [1] for this scheduled for the next release cycle.
>> Happy if anybody else beats us to it though.
>
> It seems nobody has picked this up. Can I send a patch so that git
> history refuses to update a branch that is checked out in another
> worktree or is getting rebased when the update would change its tree?
> This should cover Nikita's report.

At GitLab we currently don't have anyone planned to work on this. So
yes, you're welcome to pick this up. Feel free to Cc me for review.

-- 
Laters,
Toon
