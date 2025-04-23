Received: from common.aspen.relay.mailchannels.net (common.aspen.relay.mailchannels.net [23.83.221.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B57A95E
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 05:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.221.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745385497; cv=pass; b=UK5ATfgyimZ8plFt1FXdqhuXTlmJxLw2XNeUy+VeuabB+lXixuU1OUf2RXHEbsXQ9j+sDNDq6UY7BZNAL1MAjLC5KwMg6jUcUMqdnPyoBM9QzCN9mBvcuXCdhgqRFJuV9pUx5Sc9zmnCmh7qaEMsuUOIkiqEneH039VgBJmLZxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745385497; c=relaxed/simple;
	bh=eIZutoYYjq1OsOYCNNvgoPYtQlo3zqQ91ijqMfQ9POI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f52es+zTNqvpA+NA3wA0EjbG1k+uFswjsumfo61theHwsw9nsYkbGZjOqUze+CUkpSVZEjEECL5NQ9wBUEqMMNLIwMw8rEOqOb7HuYqZRiO7TVTfI3GXZSFJ2w1z80eDbbM/ioAP2Wwmlqq5Hmz+gH8qwBOFNBLj3acNsWOBYtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=S/TACdBr; arc=pass smtp.client-ip=23.83.221.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="S/TACdBr"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 35891844A07;
	Wed, 23 Apr 2025 00:45:29 +0000 (UTC)
Received: from pdx1-sub0-mail-a256.dreamhost.com (100-109-34-4.trex-nlb.outbound.svc.cluster.local [100.109.34.4])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BD8F38453C7;
	Wed, 23 Apr 2025 00:45:28 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1745369128; a=rsa-sha256;
	cv=none;
	b=gcX+L6VGmQ4jthmplIyA8SZGmNnPeQ3QNxsCU4EmtjuKrysJLUMxLkwtdqKqrgioiFCruZ
	0jvJ7b61ZRapUZM08S3tY/3Q2lB0ho3xuTlk722VRb/BtsMRFzGBE3UsW/r+fnVZewwEYx
	/iBNJl7wwecqnqJqBEPXS9GlIKcWgrjA54lo59idWKIhPIGdSC7CCXEcHJ3/+iz3ldc85D
	Pr6HMIZtxbailwLaLJ2q5p/pwBwFZoJxu+TMY+DOn2MYTktzpWUPmdYtyPyjZXRanvxKZ2
	RlfD+hTG0V4oghwJcBgnjgIKiPGI9f+WirwC+0Gf/u2ZsD9/sSTm1yg9ueFRKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1745369128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=sZIXpTSwvWilVLpR/fNe8m/0X3XICz7eRV1ziHfq4jo=;
	b=RIBcId8DW/HuqKybPfdmhAwhRFraVDEgFHgM1PZUDZQiEXAfm3zkwBI1EmZnR0toFBGw/j
	wunpzdV0vch7S8/JLFxrfLnbixq2Tl7Eq/B0EIP2q7LCKm5H5VYidkCO/CQOC7CyEnn+gx
	wO5qgrIMfOIgTRQwEnDl6FGTm3nz9A0FIxbu9W0YZeSmLIYZ30vxyiZtL084NcUXpnYTGh
	I8kSV/T4BqY5q6lL5C19AW0Ke+ctkKlBoK3fCZU3fqFRvByl4qp4ykKdurAozQx+sdfdjF
	dHLul3UUIanfqxZ9R4eYM3ESEFqBqtZDU4HMUm0rq7bZGpG9A+NqXoj0ABi9XA==
ARC-Authentication-Results: i=1;
	rspamd-5cfcf5665-kj6cg;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Bad
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Celery-Tangy: 7c5322e022bedb22_1745369129043_2847848314
X-MC-Loop-Signature: 1745369129043:1645390500
X-MC-Ingress-Time: 1745369129043
Received: from pdx1-sub0-mail-a256.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.34.4 (trex/7.0.3);
	Wed, 23 Apr 2025 00:45:29 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a256.dreamhost.com (Postfix) with ESMTPSA id 4Zj0kv4yRQzFR;
	Tue, 22 Apr 2025 17:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1745369128;
	bh=sZIXpTSwvWilVLpR/fNe8m/0X3XICz7eRV1ziHfq4jo=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=S/TACdBrAzMttctJu/K+LWmn6d5sjPcaIGOltnvovOzSZVKWgrTZcMcI7N0cGRm+B
	 UTDOYZaAAZOJKMvRU/8Nq+7y/r2mA9Pr5o2/GbSj0GQPXWgf1F1syK6M4sC9sem2Tl
	 lSEO3gvcswaB5li0t14K99TMzYYnq+LSyFavzSX2KtGRvpqEDsGsGG90uqELHAUZjS
	 kiTgzGxeqQyYnTYnQRbSXrckOKRQHCoYk29YrALrlgGKjewaSN5hclKalyb25MKUMn
	 9ZVUVE9chPtg4wi6HuSjgfntT0zE5BYvxIsziBpt2Hga6qpvblaagV9ld4pngadgWX
	 eCtvZFDIwruFQ==
Date: Tue, 22 Apr 2025 19:45:25 -0500
From: Nico Williams <nico@cryptonector.com>
To: Remo Senekowitsch <remo@buenzli.dev>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
Message-ID: <aAg4JR+rCDqO5ljV@ubby>
References: <Z/RFQY433muaCW44@ubby>
 <20250408125521.GA17892@mit.edu>
 <Z/VGYrrVZYQ13TLj@ubby>
 <20250409121924.GA148735@mit.edu>
 <Z/amMj/eg0RbXdkS@ubby>
 <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
 <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
 <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
 <aAgWytQNqtLzg2TU@ubby>
 <D9DLAQTMJYU6.RJLLVMQZOICK@buenzli.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9DLAQTMJYU6.RJLLVMQZOICK@buenzli.dev>

On Wed, Apr 23, 2025 at 02:25:40AM +0200, Remo Senekowitsch wrote:
> On Wed Apr 23, 2025 at 12:23 AM CEST, Nico Williams wrote:
> > GitLab seems to figure it out -- an existence proof that it can be done.
> > So maybe Junio and Theodore are quite right that similarity checks
> > should be enough.
> 
> I haven't used GitLab in a while so I had to test it. I found the
> feature you describe and it's nice, but it falls short in important and
> somewhat predicable ways.

True.

> Firstly, it only happens when you make a comment on the whole diff.
> Then it shows you an interdiff between the version you commented on and
> the immediate next version. (I didn't find a way to make it show the
> interdiff between the commented-on and the _latest_ version, but that
> seems doable implementation wise.)

I suspect that's a UI design issue: how cluttered do you want the UI to
be?  GitLab's UI is already quite cluttered.  Often I struggle to find
the thing I want, and I use it often.

> But that's not really what we're talking about here. That's taking the
> interdiff between two versions _of the entire branch_ and selecting a
> relevant _hunk_ from it. Neat, but completely unrelated.

I think GitHub and Gitlab both can handle ... commit ranges, can they
not?  The problem is that then you have to find refs (or commit hashes)
for each version you want to compare, and once again UI complexity gets
ugly.

This is why I often do code reviews in the terminal, using `git diff`
and `git log --patch` as needed.  The problem then is that actually
leaving a comment on the CR requires going back to the browser,
navigating to the CR/MR/PR/WhateverR, navigating to the file and diff,
finding the relevant hunk, and finally authoring my comment -- this is
very painful.  In principle I want to be able to do everything in the
browser because I don't see how to design a TUI that lets me do all of
this, but I'm really a shell and TUI type of user, so if we could design
a TUI I'd rather use that than the browser.

> If you make a comment on a _specific commit_, the feature doesn't kick
> in at all. GitLab just tells you that this comment was made "on an
> outdated change in commit xyz".

I suppose GL could give you a link to a diff view of the same commit in
different versions.

The point is that GL demonstrates that these things can be done.  And I
don't see how a change ID would have helped GL much except in cases
where one re-does all the commits with different subject lines etc, but
leaves the actual patches mostly the same.  Now it does happen that I
split and squash commits, but it's rare that I completely redo them.

So I think I'm coming back to my original view, that change IDs are
useful for forward- and back-porting, and not much else, and that
existing conventions are probably good enough for forward- and
back-porting anyways.  Though I don't object to a change ID header, mind
you.

> A truly patch-based review UI would show the interdiff between the
> previous version of the specific commit that was commented on and the
> next or latest version of _that specific patch_.

I suspect most users are not pedantic like me and don't really go to
that sort of length, know they could, would want to, or would if they
knew they can.

> So, while I must say GitLab is doing pretty well here, claiming that
> they "figured out" patch-based review on top of git without change-ids
> is not accurate.

They've demonstrated that this is possible now and without change IDs --
that is very relevant here since the assertion has been made that change
IDs would help do better than most CR tools do w/o them.  GL probably
have done what they think their users want them to do.  GL might yet add
more of this functionality.

Nico
-- 
