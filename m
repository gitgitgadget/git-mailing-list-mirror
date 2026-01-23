Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D223F513
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769202407; cv=none; b=dMGZSuxRLZQvNXPnqRz+8J2LWw+gFjdas6v7DuvPw7ui4nfmJAkDaVU10TtvvUrcxkXQo8v+hHKz+uWahi13djNfHEixZayhTx5nqUhObxs3nCki3tSPVA2Q2Bquc7d/MQf0DcBDfaNm/gD4banfdNqIok210FsGkkQ9IewaY3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769202407; c=relaxed/simple;
	bh=TCScTwN58qMyiazx1gPxK5gD5isv5z0cQ8iTuVjDRa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkUK3WeZR8JxImQ0tV9CYAA6xj587PhisudV+1lKqqVTvTErYRAOeQtOAAYoOVirZI4M751T95q0O7kYrXxmRgbsvbt8mSRHi6tQQRAi7yh5SBX3Iz0azzv/7Dme62/xwm8HZwN0lef4+uVJNonp7fXGIC3QsQiXSXne6NohKCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TChsLevx; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TChsLevx"
Received: (qmail 138817 invoked by uid 109); 23 Jan 2026 21:06:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=TCScTwN58qMyiazx1gPxK5gD5isv5z0cQ8iTuVjDRa0=; b=TChsLevxMipeYYONGZecw+V9uUpVqXuc2vMwJY1du/nhDPCaGFZs/ZPNDbMwemkb8NepkcjMe+/qmvkJhxfoOnqu8W2gK6sjdQ1UmOdE+6x7SH3QHoYvXhVA9dNnK2RYTbiPkemJFy412LYj4AZh4xLjfPCeJJxylN18eq7ccLrlC2lcDqlLp0Th7K7X18ZKmdb76ibe86IvvOCD57h29CTCaHw1yIsqe5MQgJ9DlA0O+kNaXlTet/CC/zyJOG+jeaZ7r9qB3i/lO7Lacu/cDQeYf72pM+idBuy5zHmxsLPmSAlBjegS+nt7i9E2MX9ThqQcf3U2j9tOzHCjs1u3Dw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Jan 2026 21:06:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 262524 invoked by uid 111); 23 Jan 2026 21:06:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Jan 2026 16:06:45 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 23 Jan 2026 16:06:43 -0500
From: Jeff King <peff@peff.net>
To: Klaus Sembritzki <klausem@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: The SHA256 of "xy\n" (ASCII, no CRLF) contains 1337, ACBAD in
 za, and I am 1aa
Message-ID: <20260123210643.GA2728629@coredump.intra.peff.net>
References: <CADMnYXDDbVBwZgETsFhwkOyn8cM8QU4+YQs2rRfTac6ec49-5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADMnYXDDbVBwZgETsFhwkOyn8cM8QU4+YQs2rRfTac6ec49-5A@mail.gmail.com>

On Fri, Jan 23, 2026 at 09:16:46PM +0100, Klaus Sembritzki wrote:

> $ # My initials (ks): 1aa
> $ echo ks | sha256sum
> $ 1aa44e718d5bc9b7ff2003dbbb6f154e16636d5c2128ffce4751af5124b65337
> 
> $ # 50566750337
> $ echo thinking | sha256sum
> $ 50566750337beb9e98e553fd9196d10576f9eb0cbc6b66e2586b9d73af4f352f

Oh man, I've got deadbeef!

  $ echo jk35252822 | sha256sum
  33f1a74529870456c56ad97c59cfed6bdeadbeef9b9bc3f4ff49bb203e36f96b

What could it all mean?

-Peff
