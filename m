Received: from mail.marc-jano.de (mail.marc-jano.de [116.203.25.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF01649DB
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.25.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718205562; cv=none; b=iCV9Wuwv7RlwcRtdfzUTn5H731DWq5EsQ39dBQSP7mmyDmP/yBJT590ycoVZE0EDgVmwDH+Wzr8AkTQs0EiPPWz+ScCC79jjtqhbECjPFvGWtFyv0paRtmZnLxTqKDAiDW6gr/nnZ3A8WNpAJO4W4QVqIjGH7GMikhAomq0y3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718205562; c=relaxed/simple;
	bh=vqHMkKJfr/Sn+jx9PYwqtLgeuhlnfjNy3W+JdezdAbU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOUhpA3+ALtPDk4mxbq+bfe+6Z0ef6w5QCaMdGoIYn5tE4+1LDoxWyfDG+/slvW9TJgIhF0/3lKUvAngsObXoM/zgTllQa4pOn/U7eEeRMkzz0hBK3rpjYi1U/BdH/BzdX7hxcD0W++XJq5c/IgfDZf4Cn/6WZT++jN9owGekg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marc-jano.de; spf=pass smtp.mailfrom=marc-jano.de; dkim=pass (2048-bit key) header.d=marc-jano.de header.i=@marc-jano.de header.b=dTd7WeNo; arc=none smtp.client-ip=116.203.25.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marc-jano.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marc-jano.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marc-jano.de header.i=@marc-jano.de header.b="dTd7WeNo"
Received: from pc1.trash.bin (IP-195080053223.dynamic.medianet-world.de [195.80.53.223])
	by mail.marc-jano.de (Postfix) with ESMTPSA id 58ED17FF53;
	Wed, 12 Jun 2024 17:19:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marc-jano.de;
	s=default; t=1718205551;
	bh=vqHMkKJfr/Sn+jx9PYwqtLgeuhlnfjNy3W+JdezdAbU=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=dTd7WeNoZySHQIdaelaweQ4D3+NrVdapuDILmuwq+E0MGlyFoDokLRQQEiYyTKsxy
	 rvl+usce/tngbDWb2LubhSfH6Jk2ZXxn3rnFmwU8ZbXOK33P4MtXSF5AII7HOvmJU/
	 FP1pp93GWNxQE97Ke6LybpNJ/XZTOVz8+8a2m26D2RYAQUqygUe+tXGxH0VZOh8cVc
	 IZYZOu2dWAabJCg0mgCEKXG2eVqePgd7fEVEJ6ezMFQYiAC3Q9E+Lqwv3IfT3vrFJG
	 ruDQwvPLlzleptRxWUrwtmDULHLH2s8Mb9H8dMQUucRGir1NAR2ZX9ub0XFz3eO8n0
	 8cdFa3tIuZS7A==
Received: from pcdm2.trash.bin (unknown [192.168.4.89])
	by pc1.trash.bin (Postfix) with SMTP id 1FD0F1B0006E;
	Wed, 12 Jun 2024 17:19:09 +0200 (CEST)
Received: by pcdm2.trash.bin (sSMTP sendmail emulation); Wed, 12 Jun 2024 17:19:08 +0200
Date: Wed, 12 Jun 2024 17:19:08 +0200
From: Marc-Jano Knopp <y--gitbugs@marc-jano.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: [Wishlist Bug] git-shell: Support libreadline
Message-ID: <h2cf4cqfmnxkogeliqjjnqxbthwbjwqaaqsgyu36rgjyetwdb4@6fgdhhuzsbet>
References: <tovyij5wnnliqqn443n6ksjrnwgs7xthopxvqlieacix7jjdqg@2mnwgzlpj7fo>
 <Zmd1joZIqo217TBh@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmd1joZIqo217TBh@tapette.crustytoothpaste.net>

On Mon, 2024-06-10, at 23:52:14 (+0200), brian m. carlson wrote:
> On 2024-06-10 at 13:42:42, Marc-Jano Knopp wrote:
> > Hi all!
> > 
> > 
> > I would like git-shell to support libreadline:
> > 
> >   https://tiswww.cwru.edu/php/chet/readline/rltop.html
> 
> Unfortunately, I don't think we can do that.  libreadline is GPLv3+, and
> Git is GPLv2, so it would violate the license to distribute a binary
> linked that way.

Oh, it's a legal issue ... *sigh*


> It's possible that libeditline could be used instead to provide similar
> features, though.  If it's important to you that this be implemented,
> you can send a patch, or you can see if someone else is interested
> enough to do so.

Thanks for the hint!


MJK
