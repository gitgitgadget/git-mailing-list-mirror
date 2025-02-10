Received: from ext7.scm.com (ext7.scm.com [49.12.148.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD77381741
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.148.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739192517; cv=none; b=gKhpGqydH46J+jj6O+PK7e20+/2jknRhfGQ72Qu3/0FleVmeBsJz7enQdVeVXSYM4qZZW4S05k6UuWKtni3n1z4lKEEag6cGs4pGQS1o1VcDn5wDs4otlsK5xfL6TUEP5GclsxTSy5XYbWgnFjn4QQwphjO5QYi3MoNCIe95ej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739192517; c=relaxed/simple;
	bh=epMqHT0Dlv6lNrJuTmF+qnQ+in9g73QtVlxOB201s0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fk41CtiLMDX9rb6nj8lqzLE7Q24cMBIXCnoRWPe3cBgZBSBbvpC3UxVa5j0FPxn4YIN5iACgiBaBekXDWzN9sA+BwQnNN0WsoI5OnaBV45UMFKhia3gyssDR9gvgQiq5MelDEhnk/uMR6ir4EAK4MNd0P6gV2kZhpAv+5P8EExM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scm.com; spf=pass smtp.mailfrom=scm.com; dkim=pass (4096-bit key) header.d=scm.com header.i=@scm.com header.b=jy43I5dY; arc=none smtp.client-ip=49.12.148.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=scm.com header.i=@scm.com header.b="jy43I5dY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scm.com;
	s=ext7dkim24; t=1739191966;
	bh=SyCG8A+l50eSZeZrLcHw85OjsRZxIOSW5IDc6YReNvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jy43I5dYYCrUlbY4TJATXr85npoR5n9hvfoZdI3iic9CY/VKOCOMyZ9DBlTj2CcKd
	 xGAK87HA1uKS5m+hQcsW3jI6TlVbZlywXoa5gIVeGMmPnRp6z1msCWE/BhmGfp8SvQ
	 DxGFXqH0SssaZO/SsETeuE3qIIQc9cJuutSGu1ar1k8AOWoJOnCzX3YDZmJK/MS9HC
	 W5WEUCTYtr/gdMg7PQDx6unHGKOIWdYuAGsWxxCOiO+jN/37wp/jxgy3SNu6q6jKgX
	 Itbr9dW9aOHPForCOHpOt6pBq+GecBMeMBQCAdIoNwphrECcivUBF0F9It5brxpa4x
	 6nLkyb7zF5yeVUSlwemRCBZyrxrrZ5iKIcMVrAlpl71vldzNnQAKnI7byX9+bqlqPH
	 4ACAXJRw0Pfx2Rrk1Fh9Pfd0FkQGHF6X8zBJAKEWJtKRK6XuuSZWNgQvwPBF4H6d0P
	 J2hANIB1HPt9IfrF7d1sQPlonsKTUcK1RkTkPPUCDQtX1SQAsDhBU9kKW8WHBd0JH9
	 y1kg0r7j1NWgwjIbuOHA/mgqZtj2Pnrgsa+Jzhc5qn3n5TGpv7gEFPP3/+HBc22Wah
	 FKV1bKzMOXRWcuBsprlEANPLg6fol2RKV8Y2BZI/kCoh6witWJhIvjeF/CkNsPMptV
	 C/0vU9+7/c16/MBhvlc+5cfQ=
X-Virus-Scanned: Debian amavisd-new at ext7.scm.com
From: =?UTF-8?B?VG9tw6HFoQ==?= Trnka <trnka@scm.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org
Subject:
 Re: [RFC PATCH resend] builtin/repack: Honor --keep-pack and .keep when
 repacking promisor objects
Date: Mon, 10 Feb 2025 13:52:40 +0100
Message-ID: <2289498.vFx2qVVIhK@electra>
In-Reply-To:
 <CAG1j3zH1xngk0NZUjHA9Akx526yfEiQ=KsdfyRjE9XAewWV=Sg@mail.gmail.com>
References:
 <2728513.vuYhMxLoTh@mintaka.ncbr.muni.cz>
 <CAG1j3zH1xngk0NZUjHA9Akx526yfEiQ=KsdfyRjE9XAewWV=Sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 10 February 2025 12:38:17, CET Han Young wrote:
> We repack promisor packs by reading all the objects in promisor packs
> (in repack.c), and send them to pack-objects. pack-objects then write a
> single pack containing all the promisor objects. The actual old promisor
> pack deletion happens in repack.c
> 
> So just simply copying the keep-pack logic to repack_promisor_objects()
> does not prevent the keep promisor packs from being repacked.

I don't know much about the internals so maybe I misinterpreted what I saw, 
but the patch seems to fix the issue I observed:

I have two 40 GiB promisor packs, and as soon as I accumulated 50 additional 
small packs (due to fetches), gc triggered a repack including the two big 
packs, despite them being above the bigPackThreshold so they could be kept. 
Repacking them is very disruptive, both because of the CPU and RAM load this 
produces, and also because this is on btrfs with snapshots, so rewriting those 
80 GiB into a new file means consuming that much extra disk space for no good 
reason.

With my patch, gc did not touch these two big packs but still collected all 
the small ones into one new pack as expected. Everything else also seems to 
work fine.

According to the man page for git-pack-objects, it seems to me that this is 
how it's meant to work, because the description for --keep-pack says "This 
flag causes an object already in the given pack to be ignored, even if it 
would have otherwise been packed." (and something similar for --honor-pack-
keep). To my untrained eyes, it looks like that's also how 
want_found_object()/add_object_entry() in pack-objects.c handle it.

2T


