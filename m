Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EB41EB48
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731923922; cv=none; b=jN/isY3Y7UsfMwNE410mNW9TfhN4ldoO+uEdkrrDJFoZE5cGZSWSlydXAXkvxVRkfWv650b47Bc3XigkgJlV7pfjRIqeQwUxAr0u2LLwWZE4ep2lcdVNk7X+NzyZZJUzs3ag7v4giDNPiWfAUJY9jG+FH+NMj5WuonxRCYmtoi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731923922; c=relaxed/simple;
	bh=24H/KRvGr1GKn8bz6E5ZnLXanNB2mR7Zsjd2CkXY+K0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mFlJxpdO7eUwdS4IA2IzbUdCwwcEcEw6rDcAcl2wHiXYsG3u5wivLjv9fQ3bX19AzWlRV5MFIg+f1P0uFk3QDwNkjQga9ccyF25TWyU04q0J7AMthpIuWRzHxxf4zTRTwFMcRy9vzo3sN7x6ntSgbV8RkDvTUdi+BLi4nZscShw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: -Wunterminated-string-initialization warning with GCC 15 in
 object-file.c
In-Reply-To: <20241118091948.GC3984843@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 18 Nov 2024 04:19:48 -0500")
Organization: Gentoo
References: <87wmh2o9og.fsf@gentoo.org>
	<20241117090329.GA2341486@coredump.intra.peff.net>
	<ZzoT03rsx7MTqSFl@tapette.crustytoothpaste.net>
	<20241118091948.GC3984843@coredump.intra.peff.net>
User-Agent: mu4e 1.12.7; emacs 31.0.50
Date: Mon, 18 Nov 2024 09:58:36 +0000
Message-ID: <87v7wkkgmr.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Sun, Nov 17, 2024 at 04:03:31PM +0000, brian m. carlson wrote:
>
>> On 2024-11-17 at 09:03:29, Jeff King wrote:
>> > Here are some patches. The first one should fix the warning (but I don't
>> > have gcc-15 handy to test!). Please let me know if it works for you (and
>> > thank you for reporting).
>> 
>> Just so you know, since I believe you also use Debian unstable, you can
>> install the gcc-snapshot package (which is, admittedly, rather large)
>> and use `CC=/usr/lib/gcc-snapshot/bin/gcc`.
>
> Thanks, I was stupidly looking for a "gcc-15" package in experimental,
> not realizing it had not actually been released yet. I reproduced the
> problem with the snapshot (which is from 20241004) and verified that my
> series fixes it.

Sorry for not saying that explicitly -- I always try to balance some
long blurb of background and FYIs with not being verbose :(

I'll include it in future reports, sorry again!

>
> -Peff
