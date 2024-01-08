Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DA054F89
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1lP6VGk0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFB9C433C7;
	Mon,  8 Jan 2024 18:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704740213;
	bh=j2y/RWtzjhjDx0451GzSA3E3WjDWNrM6Mlkb6O9hJKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1lP6VGk0SPd1VfTctAyeYuec2FdJky4sl2EUHsDRpCnlYgH289eXZZZjh2XXogBHu
	 SbHP15ntx6rBgGDZ9G3xAQXP0b3r2SNRRxffo3obDa82zVlOkZaqtsNIeioczzYiLt
	 oMCi4BGhcUVFW5QOkJmJy9LflKiv7bbOUap8Vnu4=
Date: Mon, 8 Jan 2024 13:56:52 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Stefan Haller <lists@haller-berlin.de>
Cc: git@vger.kernel.org
Subject: Re: Storing private config files in .git directory?
Message-ID: <20240108-affable-azure-goldfish-b91d1a@lemur>
References: <8e344dee-f84e-4a2c-835a-406ee72d129b@haller-berlin.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e344dee-f84e-4a2c-835a-406ee72d129b@haller-berlin.de>

On Sun, Jan 07, 2024 at 02:03:20PM +0100, Stefan Haller wrote:
> Our git client (lazygit) has a need to store per-repo config files that
> override the global one, much like git itself. The easiest way to do
> that is to store those in a .git/lazygit.cfg file, and I'm wondering if
> there's any reason why this is a bad idea?

I have considered the same question for b4 as well, but I chose to just rely
on git's config file handling instead of any other option. There's a large
number of people who tend to deal with weird repository situations by blowing
away the entire repo and then recloning it. They may remember to back up the
.git/config file, but not really anything else.

So, that would be the only consideration against keeping anything in the .git
directory.

-K
