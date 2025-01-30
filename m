Received: from ext7.scm.com (ext7.scm.com [49.12.148.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB42D819
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.148.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738224583; cv=none; b=K5tZRcn6BOLhpj/VwNc3VA+Fn/SBBQh58YSrmDoSUKd8/RqTtAI1LwrIypc95S8/JQTxo7bHCr7zkpuH+x97CW7c7xWVIiv2OgkI/NNIc+wAC9SxV3FIXG1kt4+IL04h/vMgj7pMXUCjhM/icoeKEk1REDVww0cW8x5EGuxX85g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738224583; c=relaxed/simple;
	bh=G6YvynOVybU5zvJfXvzIaMwVAuzLKkRTz8P9oJnNeI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/mO0oC9pMY3WzT4CU12bA1FnVUtRQb0RAMvEi6SXtlS9sUs9a6154Oe35T16bj4zd7e/wmZNSOjHhizqPHAarU7iUYX2lC0hQCQ2+Cw+x/puzZBJWYLU/JEIY4y1e2hOlS5R48HYDF8x0rpWkI07LfxCKGr4WTTpe1gIlrh84E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scm.com; spf=pass smtp.mailfrom=scm.com; dkim=pass (4096-bit key) header.d=scm.com header.i=@scm.com header.b=MSPtlrVT; arc=none smtp.client-ip=49.12.148.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=scm.com header.i=@scm.com header.b="MSPtlrVT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scm.com;
	s=ext7dkim24; t=1738224574;
	bh=G6YvynOVybU5zvJfXvzIaMwVAuzLKkRTz8P9oJnNeI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MSPtlrVTB9zYKE4m+QGt+4jp/OGnm0B70guYHe9FvdnJ09x1xt11NG4ecZU7EG4SU
	 SKgxTVOAOw3oE8KxOp/5LyhAxCSvMAXJADKXvHqIaL2KL4ATY9EnG6cIxdWGSRfMRd
	 jTSxPOfhmSJWSqopbf1xHxVkPhSwfA7zQlvleyE/JsYUDT+Ls0FO7Rq8yA6uoaD7zD
	 kGnm7HpYmqDmSB33/LeGbEgnLzXGtBOVHJJo8lFLZzy4Z8flunUQviafHK/boR1ljU
	 adRe7f25aMhg8HljgPHdsAlmnBJSQ0iB5qptaqy0P3XvpuGtxUdlT8K17uIXPj8CJa
	 IDJR5eTwu3Gg6hpc/H/SR0YZon8CJTs9/zQfGjFRbZXwpFk5DG/zPgJ3pN2hW0q3B5
	 f10/xjxJ0FcORDjCdec0K4xDL72fEKRiM9VIv08+12NkdrZlcuGDPUDKFG3tEY4cNo
	 /8sXIWzE7rNYtnbnyaOoeLYfZAjPbUA7iQ5VWDRVaQ+jyzRN8DNqA1gVQm2biILBuu
	 DBK/1/pINhreKCR2I/6hdaAUbLEDxI7gNK3qS4LTcL6fw05zIS1lgUW+00qY8hqX1j
	 gRxQ4N4dDJAy4ef48qHnobj6J8pE7d/dL4cKnL/7fphs14wVTrd2Ad4edSix+DzXXO
	 UD/+p7lIQ0iAKOnYj65SwRL0=
X-Virus-Scanned: Debian amavisd-new at ext7.scm.com
From: =?UTF-8?B?VG9tw6HFoQ==?= Trnka <trnka@scm.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>
Subject:
 Re: [RFC PATCH resend] builtin/repack: Honor --keep-pack and .keep when
 repacking promisor objects
Date: Thu, 30 Jan 2025 09:09:32 +0100
Message-ID: <5706247.IbC2pHGDlb@electra>
In-Reply-To: <Z5rjSzjOXrV77_nJ@tapette.crustytoothpaste.net>
References:
 <2728513.vuYhMxLoTh@mintaka.ncbr.muni.cz>
 <Z5rjSzjOXrV77_nJ@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 30 January 2025 3:26:19, CET brian m. carlson wrote:
> I don't have a strong opinion about the technical aspects of this patch
> (nor sufficient knowledge to review it)[0], but I noticed that there's a
> couple of places, this line among them, which are unexpectedly wrapped,
> so I don't believe this patch will actually apply.

Oops, my sincere apologies to everyone. I'll resend once again.

(I messed up by not realizing that KMail will re-enable line wrapping when re-
sending my original message, which was formatted correctly.)

2T


