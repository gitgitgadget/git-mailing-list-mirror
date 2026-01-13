Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764CC280335
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 21:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768340463; cv=none; b=kP1ubKnTCQtptWeoKXbR70J6YOayn15Q6Edv8JSjMqW4PJNkD94BdfeaHVpBaihW2Vom4Ah+iQfor/YkdIbGD1ucud/ssCOiIhXUikJLaz3eN9mSNHZ6Rqz3LTv+Qvf3QNUifXMnbuGCUyeRLX1Yo2FE3hI4aSHXiPhR+uLn8VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768340463; c=relaxed/simple;
	bh=pAvr0PPTIb0Sosffm0TFahSEHfOrhawj99HRBrHXjuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvcjEVw2H37bZRiVGeXRrTNh4H6z3i43dxBSDEWzkfR/OF3+LYF5NbYA+2MVrGyzyCnj4pk6ZGqye6HeKeUMcgwciWbZgGLn0tfMzJNDK6+2cjeW1646BlvGJtb7tqVJbnF6QnNXlXyvK5pqHv0OOOmM7ZOCDuueiQZOy/sksTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WG7nnL9T; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WG7nnL9T"
Received: (qmail 32686 invoked by uid 109); 13 Jan 2026 21:41:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=pAvr0PPTIb0Sosffm0TFahSEHfOrhawj99HRBrHXjuU=; b=WG7nnL9T//e8CrcmEmmXqrOvQnVcSzxEZWIe69trERb3OuAXIF4gCqJu02ZZEN3+acgIMNjlaG5OcU6UpjSDnTrnaQS7iDwayJiTBwx23FLrezO4SfCcNcj3GVfnSV3RBtfyGB2Ug6jWhNbbDJnGN/f7UxJ2WAXWR8gyDregWKWtjhtUHkdAC22Y2dXpBDbS+ad+JB56hH+Os+EUN4N5I7skh+GyFcuBTlBAOy+G+ENOBQTDwTYxiMlm42hSnzdC9a9xV+4qRGYEzgskn4OZqcQ6h4Fmbc6x7MTfz84hb5JfveZCv1lfIp/qzc6P+Pl5NUkq4eUPy2ETMibhjaBJBw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Jan 2026 21:41:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 54505 invoked by uid 111); 13 Jan 2026 21:41:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Jan 2026 16:41:02 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 13 Jan 2026 16:40:59 -0500
From: Jeff King <peff@peff.net>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org, gitgitgadget@gmail.com
Subject: Re: Triangular workflow
Message-ID: <20260113214059.GC288857@coredump.intra.peff.net>
References: <20260113170321.GA265671@coredump.intra.peff.net>
 <20260113183557.7991-1-haraldnordgren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113183557.7991-1-haraldnordgren@gmail.com>

On Tue, Jan 13, 2026 at 07:35:57PM +0100, Harald Nordgren wrote:

> > For my triangular workflow the ahead/behind for the push branch is just
> > useless noise. I treat my push destination like a mirror, where I always
> > just push up everything at the end of the day.
> 
> This seems like a sub-optimal workflow 🤗
> 
> May I ask where you normally push (unless you only ever push once at the
> end) of the day? If it's another branch than your mirror, why not set that
> as your push destination then, and push to your push destination with the
> longer
> 
>     git push origin my-mirror
> 
> It makes more sense to me to reserve the shorter and more convenient
> 'git push' for something you do many times a day.

I couldn't quite parse what you meant by "another branch than your
mirror", but I'll describe my workflow:

  1. My "origin" remote is https://github.com/gitster/git.

  2. Most branches have origin/master as their upstream, though
     occasionally I'll have dependent branches that use "." as their
     remote and the local base branch for the "branch" field.

     E.g.

       git checkout -b jk/some-topic origin/master
       ...
       git checkout -t -b jk/another-topic jk/some-topic

  3. My mirror is https://github.com/peff/git, which I call "github" in
     the remote (arguably confusing, but back when I started that
     convention I was pulling Junio's tree from kernel.org ;) ). I point
     remote.pushdefault to the "github" remote.

  4. My push.default setting is "current", so if I want to push up a
     single branch, I can just "git push". I hardly ever do that,
     though.

  5. I usually push once per day or so. After integrating my topics into
     a shared daily-driver branch, I run something like:

       make test && make install && git push -f github refs/heads/jk/*

     (it's not exactly that; I have a script which picks out the local
      refs, but it's the moral equivalent of that).

So I don't ever care about the relationship between a specific jk/foo
and my mirror's version of it. I don't expect anybody to look at those,
and they exist mostly for backup and CI purposes (though I don't run CI
on the individual branches, but only the integrated result).

And having the extra output from "git checkout" is just extra noise for
me, especially because it is easy to see only the second message (which
looks just like the upstream ahead/behind message, of course) and get
confused. The first time I saw it I thought I had misconfigured
something with my branch.

-Peff
