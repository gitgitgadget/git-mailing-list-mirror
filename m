Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3884D3C73D9
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117352; cv=none; b=D1JfGJXeYsvlMAlnAbSakXnJk0+Ni/NcmosUbqnrbG3Q76re4Zxe/SbqPk+ZRwqDHYHdbWSUHp7KlLRLa93KbzvdjCUKvlY5O7bI1kSSD9H6cMqzx/WWG3cvwvtIwaJXtlo3D73QJrJgkJdp5bXyVpbE3FzvhnM09P/nuJxlWp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117352; c=relaxed/simple;
	bh=MySaOadOmT86nGJi4OKCxYhq3m64aRT8R5y24aSXz8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HaYM6uhI8CUWwzPD1zZ7RU4I+cZW/NfXR4rlIqk4V+kLa1nSoPAPjv8ZLINnToXTSLgaqqWv741/oj6MM54tqowoSUOuNlmOnWuVkXCcbJpySnrgMZSrTAJSLpTNUpGEy/UL+r3SXJPUvaKVAJvEkC4Qy4c4hEbv244R13fsBpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=3NNQkwTf; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="3NNQkwTf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1784117340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mBDwEev8xhf71wW1Uj8eUO6gYPiTtFHKRnORsMVeQtc=;
	b=3NNQkwTfnWX5JTAe9QzabH6E0zATJBBzNGDSmjoeGwfZB1PdPtbMmLsqxk56mNIiDvXSfS
	hgyZabNCT758CpMfR2nLzd4sUHdu7xwbUVrNiVPT9AY8gNBF5ZZNX/53gInlRganok2gMr
	wga3curigIoavbY4pO35LoIjiorrlg8=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>
Subject: Re: [PATCH v4 0/9] odb: introduce object filters to
 `odb_for_each_object()`
In-Reply-To: <20260715-pks-odb-for-each-object-filter-v4-0-616d7adf7fb7@pks.im>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
 <20260715-pks-odb-for-each-object-filter-v4-0-616d7adf7fb7@pks.im>
Date: Wed, 15 Jul 2026 14:08:56 +0200
Message-ID: <874ii0h2uf.fsf@emacs.iotcl.com>
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
> this patch series introduces object filters to `odb_for_each_object()`.
> The intent of this is to make `git cat-file --batch-all-objects` work
> with pluggable object databases. Right now it doesn't because it reaches
> into internals of the "packed" backend to efficiently handle bitmapped
> objects.
>
> The series is built on top of f85a7e6620 (Start Git 2.56 cycle,
> 2026-07-06) with ps/odb-drop-whence at 8a7ad23e11 (odb: document object
> info fields, 2026-07-02) merged into it.
>
> Changes in v4:
>   - Fix references to an old function name in commit messages.

Thanks for fixing that! This version looks fine by me.

-- 
Cheers,
Toon
