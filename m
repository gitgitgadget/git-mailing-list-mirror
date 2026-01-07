Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5916F341674
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767811507; cv=none; b=VBd0hKSJgcJ3JnF/xoj1izv4YZh1fJMcCDJZQCDqcjH1XCcuh+cdkElixPMfQ2wS+20LmhS+t92xFJYppSB5ZraNc92j0pEZ12tui/tYT1yxpjkiIn4cDj4IBMQbtezlYWnufDK5+S7yBFm2ucxs9KJcph27slewcMaci8cCmu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767811507; c=relaxed/simple;
	bh=IgLro9I116IcffuPQaNGaKJI190UOk6/OdIK5oYBl+8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qRgiF5gvTkg8gGhECubYjSXbri78T5317YeCFjfsjI5FtfW/lKm+nJcufk712nuY4L+NEK4ZfBZnaYx4QhNLt5y0wzkQWhSZpvzc89zVVTQe4UqnzoZEJzpTTwQyLiIQgpgqE459eiPn8XiWVKljWWIfvS96q443PMmnN5+Wy+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=QI4Gt0bq; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="QI4Gt0bq"
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:5e36:599a:5e38:8283])
	(Authenticated sender: jn.avila@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 027D02003DA;
	Wed,  7 Jan 2026 19:44:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1767811493;
	bh=IgLro9I116IcffuPQaNGaKJI190UOk6/OdIK5oYBl+8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QI4Gt0bqh7wcIv9OGGI6VTYZsng2qKDXlySqJSx55Ln70Cw6DY/qHknM6T4fLleyU
	 h7RqlO0yNYaIQM3Ib8xAug9fLQdEsj/Y2rRlhhMcAgXcI9aNqhRCmOaU50RmETV78z
	 PK4eiMw5ukAt+WncSLlWB6XmcK/v44J7tvgJ/WL4ERFwBBQpW0YVyaFwXbnPGZFBRB
	 /89nOTqN2LVj3gNnjv8V+meliAdd9dLm0SsFy36sKucBGeH5GUycXc5rS0hefwY/pG
	 YL77sH2tvcNWwXrMXcNLBcLU5jz2I2zR3qheDn6T+7sHP2EUltrp1pjPk0viv8PHtX
	 TMZYy6i9AMh1A==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Michael Lyons <git@michael.lyo.nz>
Subject: Re: [PATCH] doc: git-blame: convert blame to new doc format
Date: Wed, 07 Jan 2026 19:44:51 +0100
Message-ID: <2395053.ElGaqSPkdT@piment-oiseau>
In-Reply-To: <9123496.T7Z3S40VBb@debian-mbp>
References:
 <20260105230220.519303-1-git@michael.lyo.nz>
 <7894506.EvYhyI6sBW@piment-oiseau> <9123496.T7Z3S40VBb@debian-mbp>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday, 6 January 2026 22:16:02 CET Michael Lyons wrote:
> > Here, let's transition to the <placeholder> format: <start>..<end> and so
> > on.
> 
> This is the continuation of my question on `<start>,<end>`: Do these also go
> to backticks or keep the underscores? My impulse is backticks, but let me
> know: `<start>..<end>` or _<start>..<end>_?
> 
> The start/end change from rev/rev makes sense.


Definitely backticks here, because this is a complex synopsis span.


> 
> > > -	marked with a '*'. In the porcelain modes, we print 'ignored' and
> > > -	'unblamable' on a newline respectively.
> > > +	marked with a `*`. In the porcelain modes, we print _ignored_ and
> > > +	_unblamable_ on a newline respectively.
> > 
> > If the words are printed "verbatim", then the format is backticked:
> > `ignored` and `unblamable`.
> 
> Another one where I had backticks originally and switched them. I'm not 
super-
> familiar with the porcelain parts.
> 
> > This diff is quite large. If there are no other reasons to split the patch
> > according to some semantic reason, then please split file by file.
> 
> Okay. Next try will just be blame-options for now.

You can push two commits in this series.

> 
> > That's very good for a first try. Now, I hope that you will be ok to 
review
> > my patches :-)
> 
> That's very kind. I'll probably need a couple more rounds before my changes
> pass inspection, let alone be declared competent to review yours. :)
> 
> For the purposes of re-submission, should I be doing something with scissors
> on this thread, or make a new thread?

Usually, the reworked series is pushed with v2 as reply to the first mail of 
the first submission, using for instance:

git send-email '--in-reply-to=<20260105230220.519303-1-git@michael.lyo.nz>' 
v2-*.patch

JN


