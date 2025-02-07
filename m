Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291242A1D8
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738960462; cv=none; b=I9E+Ov+BP9CAmGO/QYJZ4wtp0IkiAJh2QrOEOH1D8FnlNh5DjiJl6Qv9BaA89YmiIfPIVIu2SnlVM5PaYMNkttRqVBWoi6FNvjSNa1CUgKKq1d2GDBmQoDcKS4E9MyXhSFkkhzei46s+bqaf12aaCQVSGjT9l9dIj5kFf5v1BJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738960462; c=relaxed/simple;
	bh=zh+w5NP7PxJ/K/w6EvNFAmZN8fMidahWqAYK0t/mI6M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5gqRATRAlIXfp83pktyXQLi+UFjO6mxLjpTu5naZN34EXtNvd0MMqbmPIdjoxjMnegKmdLadrodRSRdNlco1MiYryvE3r+WQ8fSmfZ0aBN5ioMODbDWaCsc47WciYng9eiGfT+Sg39CK0JbRSyh8Ot7NQYsXvwvLz1MUSCafNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de; spf=pass smtp.mailfrom=raven.inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raven.inka.de
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1tgV3I-004SHj-Q7; Fri, 07 Feb 2025 21:34:16 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id BAE6A60115; Fri,  7 Feb 2025 21:32:48 +0100 (CET)
Date: Fri, 7 Feb 2025 21:32:48 +0100
From: Josef Wolf <jw@raven.inka.de>
To: git@vger.kernel.org
Subject: Re: renormalize histroy with smudge/clean-filter
Message-ID: <20250207203248.GG30202@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <Z6PsXGnxM3UBR3nM@tapette.crustytoothpaste.net>
 <20250205235931.GB30202@raven.inka.de>
 <Z6QCX1QZxxwC7RVQ@tapette.crustytoothpaste.net>
 <CABPp-BFZ3oyKiryKMPph+nfokC=sFa7wn1wdas863273bzy7pA@mail.gmail.com>
 <20250206134006.GC30202@raven.inka.de>
 <20250206200418.GD30202@raven.inka.de>
 <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
 <20250207104510.GE30202@raven.inka.de>
 <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
 <CABPp-BFnx2m75jsa3_kTPet97HY+xwb_6JmPiKM5+OARPy=mGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BFnx2m75jsa3_kTPet97HY+xwb_6JmPiKM5+OARPy=mGA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Feb 07, 2025 at 06:01:43AM -0800, Elijah Newren wrote:
> On Fri, Feb 7, 2025 at 3:13 AM Chris Torek <chris.torek@gmail.com> wrote:

> renormalizing
> all files proactively in the merge machinery whenever a merge or
> cherry-pick is done would be orders of magnitude slower for any
> decently sized repository; it's simply out of the question.

Sounds like trade of time against correctness?

See, I am sitting here trying to get this repo into a sane state for about
two weeks now, and I keep getting conflicts and/or errors thrown onto me on
every single attempt I try. I'd be happy to drink a whole can of coffee while
some hypothetical "git renormalize-this-repo --force" is running.

-- 
Josef Wolf
jw@raven.inka.de
