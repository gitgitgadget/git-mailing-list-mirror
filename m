Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC9913D503
	for <git@vger.kernel.org>; Sun, 19 Apr 2026 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776564630; cv=none; b=JIvd+P+sFazY9iiYDZvZuwZY7NeZ9KU0rQr9zD1wBTp0j2Pn6SUmt62b7/VDa2B4KKDtZe75n7grp+miOK9mz/BgCnvk3ZBTRD7UwXs8bjD0TAFbciJrfM/lDbv0MYixaRod+15CJN4TXdD766i9xORLs+crSQxAeHVFIfwPuDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776564630; c=relaxed/simple;
	bh=gG29Gca4/wE+zWv0f+H4N76Fiw+sNXqg9xaVWGQFjbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leySJ2RvaQ9lU8/Bs6Q3crQowAJzFZu/k7zYsQhwYof1TFFD8Ll5ptlsC/PMgp5l8B2AR5KUdDEZmj4LRiAkvFLCm1BxzgMTsYacQZI+JVUUAvtdXGKQapRw2X5sKRCobSPLdVWuSeQNO5mJvxqDniWV+pCfprkcq2cqYnK7i78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cR4+WN4Y; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cR4+WN4Y"
Received: (qmail 394106 invoked by uid 106); 19 Apr 2026 02:10:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=gG29Gca4/wE+zWv0f+H4N76Fiw+sNXqg9xaVWGQFjbE=; b=cR4+WN4YQtVmxbIz/lEgqLLP+RdKpqcPvZa3RmmGX7Gsc1yQ3N/76BmhSDElCsiSOvcqi1PJFE5YvFVmYAdeEVj3RcFYTQHKk7dBxnXMfzIDZzRnQhxvQ2WFYW8aSHxT0qlTD+a6ZCW6by/acSnejxNY2JMU+6HTXg4HeVDhVWDU/9/JyHWkBqBte8F/aKztsdTAOYxJBqsGzVD0yZZA00GSiIZxYf6sPbY2NIpVQyDpHaNuJX7PyXRGMhIUMHao+0XagvfyR4R9KIao87g4LYPspYA/uyhlQVEOWhiZis79F0xNUdVj5ayr6dEyO2d12J3aBqML7CxFFxS0Pl+bTg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 19 Apr 2026 02:10:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 898926 invoked by uid 111); 19 Apr 2026 02:10:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Apr 2026 22:10:27 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Apr 2026 22:10:27 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Ben Knoble <ben.knoble@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?R8OhYm9y?= SZEDER <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 12/12] t: detect errors outside of test cases
Message-ID: <20260419021027.GA1079904@coredump.intra.peff.net>
References: <20260418065009.GA2619713@coredump.intra.peff.net>
 <AA6F33AD-25C2-4AB0-A624-35C7B0BE0F66@gmail.com>
 <aePY1x9uO39p6WDI@fruit.crustytoothpaste.net>
 <20260418213043.GB9632@coredump.intra.peff.net>
 <aeP9stvssuTv0FD7@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeP9stvssuTv0FD7@fruit.crustytoothpaste.net>

On Sat, Apr 18, 2026 at 09:54:58PM +0000, brian m. carlson wrote:

> > So we are inside a conditional, and the usual global "set -e"
> > suppression should happen. It sounds like it is not happening in your
> > version of mksh, but I was unable to get t1410 to fail at all using mksh
> > 59c-43 (from Debian unstable) or 59c-41 (from stable).
> 
> It does fail with 59c-43 under `make prove` or if you do `sh ./t1410*.sh
> --verbose`, assuming that `sh` points to `mksh`, but since the script
> has a `/bin/sh` shebang, you need to invoke it explicitly with the shell
> in question, or it will use the system `sh` (dash).  (I made this
> mistake when reproducing the problem.)

Doh. The problem was none of that, but that I was using Patrick's
version of the patch that only turns on "set -e" for bash.

So yeah, after actually enabling "set -e" I do see the failure.

> It does seem like this _is_ a bug in mksh, though, which I've reproduced
> with a test script, so I'll report it there.

I looked up your report in Debian's system. I think you're right that
the eval is the problem. The smallest reproduction I came up with is:

  $ dash -ec 'eval "false; true" && echo ok'
  ok

  $ mksh -ec 'eval "false; true" && echo ok'
  [no output]

So it respects "-e" within the eval, which is wrong, and then doubly
weird that "-e" bails from the eval but not the whole script.

-Peff
