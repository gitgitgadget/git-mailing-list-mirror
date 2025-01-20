Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97B81E9900
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 20:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737405455; cv=none; b=tzBfkWXPmb1Q12atvU8wW0JxXH9NlU8SVPRUVMMikwT8Ddr2e0+JBNNGGS8Y2RZ3ACPBeiMI9hH4Bp4ReOkQQ1WzR2Ws+0adaGf28RI2zjKJSCARHrot/U57ZNBKFtNdKtFqsvq0GvEzznhfFSjTIb1dsMwn3mrN+8QyQ2xtmZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737405455; c=relaxed/simple;
	bh=D4FYc0Y2il/iK0msWjAE1OiX9Zm6HZRDCwxUtG2Lc0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8d3eTVgeSW8ZMgCoHNvq7X0aMlb79HxnODaTMBWtlNguXtIzPGKAs2wPX3KTlDQyl5ZF9otWyeuElNnRloGJ0iLgXxDHaJgZJ+CtsgQH8c6pPa6kX/Sc0nL0Xj05Dx5/FeuZY3sWzlAtuDa/awibnw8z6BkFgK6fscGkACzOKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=RTxz7SNc; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="RTxz7SNc"
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 5EDD8428D52
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 21:37:22 +0100 (CET)
Received: from [192.168.3.122] (unknown [87.149.37.23])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id F0356B0053D;
	Mon, 20 Jan 2025 21:37:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1737405434;
	bh=D4FYc0Y2il/iK0msWjAE1OiX9Zm6HZRDCwxUtG2Lc0U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RTxz7SNcDA+5A8IYlOhEFwQWzdBo1zaTOAf0/DSJP0J6aKmnV/ubC+l7Bj4Ole3EZ
	 OyMt9/lBCxpV0NZDLiomQRRP8riWtwRp2OTg1kvKTqYy2sqp65CHacwfVD5kLn3uKO
	 Kx4cjCYS7OvNXaSdn9EqpCkbDrOi+2m/pBQkYDU06Tf1TE7cmHpHBtx3NLcirRJJ7J
	 QyvE/PCUOeq6NahMkTROnQeNgU7kgY8LgZp4kdlLWukBX/6UTqlX0RLUs41nwsT4sJ
	 AR9bZ/oUMzjwNn+3lW0lOzlYEAYe+tB46WJSwhKVbxLF/I1wNDvnVi0dVQl1SXhSXQ
	 zzXRcy3wXlkqg==
Message-ID: <46cec27d-ee66-4dfb-8271-953b032d0b2f@free.fr>
Date: Mon, 20 Jan 2025 21:37:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] doc: use .adoc extension for AsciiDoc files
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, M Hickford <mirth.hickford@gmail.com>
References: <20250120015603.1980991-1-sandals@crustytoothpaste.net>
 <20250120015603.1980991-5-sandals@crustytoothpaste.net>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <20250120015603.1980991-5-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 20/01/2025 à 02:56, brian m. carlson a écrit :
> We presently use the ".txt" extension for our AsciiDoc files.  While not
> wrong, most editors do not associate this extension with AsciiDoc,
> meaning that contributors don't get automatic editor functionality that
> could be useful, such as syntax highlighting and prose linting.
> 
> It is much more common to use the ".adoc" extension for AsciiDoc files,
> since this helps editors automatically detect files and also allows
> various forges to provide rich (HTML-like) rendering.  Let's do that
> here, renaming all of the files and updating the includes where
> relevant.  Adjust the various build scripts and makefiles to use the new
> extension as well.
> 
> Note that this should not result in any user-visible changes to the
> documentation.
> 

Maybe for users of the end product of the documentations compiled here,
but there are other users who use the source files and this change
breaks their workflow pretty bad. I am one of those users for the
git-scm.com website and the manpage translation projects.

If the purpose of this change is clear, the breakage of backward
compatibility is an issue. When documentation writers know how to turn
on the asciidoc mode in their editor, they surely know how to enable it
on .txt files in this specifically in this directory.

For instance in emacs, create a `.dir-locals.el` in the Documentation
directory with the following line:

((auto-mode-alist . (("\\.txt\\'" .  adoc-mode))))


Maybe a smoother transition could be performed by creating links between
txt and adoc files.

JN


