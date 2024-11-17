Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F998831
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 02:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731811397; cv=none; b=beP3io8mwliiJAfSs/gPA6OQ7DMVJl9ToFRIhGvS7zitYM/Cq484e7VExYe1HWHibKGX9TrJvxpZWOLLsUtOJCTIxhtjWAfO6oolpwkkkrZg+0BVSt9Mj1rkvp8YNhYwwzl/hdf8EUHv+MqHtjnXAjqtiMcqIAliZYyFxzHwqlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731811397; c=relaxed/simple;
	bh=7BG2BMPgdKI6ZQIZ0XCFp7cJ1iaWalPg001MP1KrRqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LOn5MO4myeg/fz2grbmYKfiXLFEnoHuk3Xs5yYBrdIeG/22SucLqtx7ply226Rh37l+0brZcAB+9kvnC/lvAXmeDQTXqUlkOo6Xd02yDDboeD+AgrPwlSe0TccZPv2UhvjiwYJOGODBsKm8A2NSL2UYT0sLmtm/tDP6mAqm2g8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] C23 compatibility
In-Reply-To: <20241117013149.576671-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Sun, 17 Nov 2024 01:31:47 +0000")
Organization: Gentoo
References: <87ed3apy2u.fsf@gentoo.org>
	<20241117013149.576671-1-sandals@crustytoothpaste.net>
User-Agent: mu4e 1.12.7; emacs 31.0.50
Date: Sun, 17 Nov 2024 02:43:11 +0000
Message-ID: <875xompolc.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Most of our code works fine in C23, but there are some new additions to
> the standard that conflict with either our struct tags or functions.
> With this series, the code compiles and passes the testsuite with
> -std=c23 on GCC 14.2.0.
>
> brian m. carlson (2):
>   index-pack: rename struct thread_local
>   reflog: rename unreachable
>
>  builtin/index-pack.c | 10 +++++-----
>  reflog.c             |  4 ++--
>  2 files changed, 7 insertions(+), 7 deletions(-)

Thank you for the fast response! It both works and the fixes look
correct.

For the series:
Tested-by: Sam James <sam@gentoo.org>
Reviewed-by: Sam James <sam@gentoo.org>
