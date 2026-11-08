Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794105461;
	b=Ckn3SpYzr/EjT/9lNoZ223wotKrXdYIT+Si1ZokRp+pwSCckk6i3A7BseqxuM7fDpv3d
	 zG2DJqh/rRBNBfldcIK1T82RZoB6crcArNgTV98Gk7L7ANXew8i1AtDYs5rxfOCQrOpqq
	 5tlp5+vUP605nqvx4YzOsLh8VexVExrNaupYVF1K0kvuEh2ihtQC7N3BE+YDAKw4t/UjI
	 u4MeAXvAyR/3LvwpAwO5z4BS+TCr3aC9F6tNSFrHg5DzFy/Hojzlv5D0R1onbZpI1C8hK
	 qRM+ePaBgDunhS4FBSMtstO/R9cExwyat3qrXdb4SIONQkwx77sMaBHjFDC0keWaWIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794105461;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=clPnBE6m+TY1AR8AvdQruSWxpd+2gfgc+iz/aNzWoeM=;
	b=C2rueBgSstnkoQ/nOOukXn3dV6A3SBwCW3xG4pTtcoVHfKiax9lP4pOP0W/zHYEDxrQ/
	 C6u2zFrZpwRTQC/a8Up9EW9OBS1AajApQ26yqxmnfKksC9QYNh2Znn9JxwXE/vVNUyrqn
	 jDj4b9CwUpj7CFuW2QpZNFJFNnl87gRbpC0Df20+dci+j0VzvZmjMC9UeLIhguBPTBM+Q
	 FnvHScIj766Qy6mT3OFoTxyg/6wT7RORIjAhgohV80xCpnvvWlR3bzcoifnlnW8teJTw5
	 evyYE7o1aX2YtkwE1mDSxRAgnaGRsgNVB4xO7QAAerAVcC5PeODGkPbBo7GsOGMhW6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=T+Irp7Ex;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC58C606A31A
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 02:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC58C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=T+Irp7Ex
Received: (qmail 65044 invoked by uid 106); 8 Nov 2026 02:37:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=EIW79xWngQM2bBo8TY/Bj8zdFg27nR5WQ4VuCPbj24E=; b=T+Irp7ExoyM4qrj6qPaRaNBA1zY2761HVtugyYfYdGZhOqBXdCI2whiahpVUQl1XUlPKCgjrWv86UVkP7Np/59JNnCeaD/JIA3hc8e+GwGewFUBT0Q0AyU7gUFwlgFPNNoQWqWA97i9J3DC25ytRe3kMR7/O04B1RrIKAJp7r13Or4Ln0/5inUmTeFaXatip7SEt+hoexgmLRr1ogwSKzUI7o3GqmAfwGvuQqz5XicVIq/VBABUzfWwFMGfBL32rqFoh8Y+VOYkGbjfiHY3MOF9xAt+wBdR+RdvpjE9EcOqtj+6o7aPo/DZif7mwrQO/79HtGoMmt5nTgRTGESakgQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 08 Nov 2026 02:37:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 117431 invoked by uid 111); 8 Nov 2026 02:37:31 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Nov 2026 21:37:31 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 7 Nov 2026 21:37:30 -0500
From: Jeff King <peff@peff.net>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2] doc: git-diff: rewrite EXAMPLES section
Message-ID: <20261108023730.GA1242909@coredump.intra.peff.net>
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
 <pull.2293.v2.git.1793893217889.gitgitgadget@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2293.v2.git.1793893217889.gitgitgadget@gmail.com>

On Thu, Nov 05, 2026 at 03:40:17PM +0000, Julia Evans via GitGitGadget wrote:

> +[[name_only]]
>  `--name-only`::
>  	Show only the name of each changed file in the post-image tree.
>  	The file names are often encoded in UTF-8.
>  	For more information see the discussion about encoding in the linkgit:git-log[1]
>  	manual page.

Sadly this syntax seems to work with Asciidoctor, but not Asciidoc. The
latter doesn't create the anchors, and then xmlto complaints that the
result doesn't validate.

Doing it like this works in both:

  `--name-only`[[name_only]]::
	...

but...yikes. It's pretty ugly. This of course tempts me in the direction
of ditching python asciidoc support, but I'm not sure if you want to
hold up your series for that.

> @@ -417,6 +420,7 @@ endif::git-diff[]
>  	Ignore changes in amount of whitespace.  This ignores whitespace
>  	at line end, and considers all other sequences of one or
>  	more whitespace characters to be equivalent.
> +[[ignore_all_space]]
>  `ignore-all-space`::
>  	Ignore whitespace when comparing lines. This ignores differences
>  	even if one line has whitespace where the other line has none.

This one is describing the ignore-all-space option of --color-moved-ws.
Did you mean to put it alongside -w / --ignore-all-space?

-Peff
