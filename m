Received: from black.banana.relay.mailchannels.net (black.banana.relay.mailchannels.net [23.83.217.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094B228F531
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.217.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745434776; cv=pass; b=l21oygyKIFuqapCRKlQJnlpmMke+oU2vVd1IUJosGBYALhAdVNw+zmb7fEXwBdojKctnN7BAXpKWh0KZb0h/isRDhdNCY3eyXck88tZmOx8nXj1oZ953mU90YdL8HuN6nWS8oNFQFdUKvbaXDUSuPIIo9SMOmzgkkqX/XWepyeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745434776; c=relaxed/simple;
	bh=Xt3uUQo8Ww5ePVrvK66r68YiGWyJtTGyehifyIoBR+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nF5HxZTCOo5jDP/1vga611chSRS4NMeFacvRwGq6w5rIi03DyNz8wMkyCXei5X+UT+8XQWJDulOu/1YndArl0GgK+rA2Jfuyb6EIpAI8vWc9qY7xgFXwWK6HflDzRLT1cREm2zTMJDCqSjUHqwaIFBx7ezKB8zUCBuGts1+NbKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=kF8HqLqT; arc=pass smtp.client-ip=23.83.217.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="kF8HqLqT"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2BF2922FC1;
	Wed, 23 Apr 2025 18:59:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a316.dreamhost.com (100-113-64-21.trex-nlb.outbound.svc.cluster.local [100.113.64.21])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A5B8A23C56;
	Wed, 23 Apr 2025 18:59:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1745434772; a=rsa-sha256;
	cv=none;
	b=mjOwBZI4Azdls1FN8KflU7tah5A3lyp2xxHsmZnU864Tzzc6DrfX0eIokAB4X/zzs5ZTfD
	A4N7ElyrwlUeuyZEfVeddMS67qvhHVk44x4wdj92YAzK5agPL1s+apB6ufx5GAc4ddEbLs
	lycKtoO+DHbUSTP0u0JHqyFejUPII8Vkn+6Bv1ULJBd42hbQrpj07iQnubdRwlgwDDOLMT
	MFYgJ8Nw3EA8XOOGgulJ5h3QQqo/ewcFbcLCqu0H3Z7E8m+vA2znyZ4JIcCP28aI1W+SPU
	GKrYKNg9SA76dyPI4XUimWfSj626jwcQaM1UPs3Q/2UnBSwq2IO3v5DE2UYX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1745434772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=mtz9UoCQnSjUCQ4KNdjyLwUFX3nFLameEoBVzw/VG6U=;
	b=dUb+HtKMIAf3/RCJQ2WLWJ4SbBszr3PcsD7EeKAw1WKYr3vezMnYL48RdpCBOqwGZPBsrt
	a+z4MBppnKzUnUbZ9OQWCmV+TeKVFLCotYwNm9gj174Z8bjkdUrvjvGiIRbUTLNj3NQykP
	0RLLWycLH1+r90bVEvcNzaF9INLrCuge0MezhYgMgo26F6OsAH0WYinpzf4/fBuUQsYO5d
	mZYIr8mZOh+HdVo5yqMcuPl4FS+1jBgr/dyr3R4Xnc+8A5d+rkxnNEhRXsUo30TxwGSnYV
	B/dixfkR+Miq1BRbG5GEnVFXwgXzNOZgcOxaZhK+vqL4OYlWzwVSBON+NqEu0g==
ARC-Authentication-Results: i=1;
	rspamd-5cfcf5665-q67w8;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Bad
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Oafish-White: 26b976431909c2f4_1745434772962_190441919
X-MC-Loop-Signature: 1745434772962:3735667830
X-MC-Ingress-Time: 1745434772962
Received: from pdx1-sub0-mail-a316.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.113.64.21 (trex/7.0.3);
	Wed, 23 Apr 2025 18:59:32 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a316.dreamhost.com (Postfix) with ESMTPSA id 4ZjT1H3H4Fz7f;
	Wed, 23 Apr 2025 11:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1745434772;
	bh=mtz9UoCQnSjUCQ4KNdjyLwUFX3nFLameEoBVzw/VG6U=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=kF8HqLqTYkZjBnIzTHaTEbOj0ptjAMuWGKnPfgZi5rdg+cpmYowgFJ15l7zJRe/Q9
	 Csep7KnwfBhX7cyBNzN9OBs4Em1iaJmKTcPKmuC4Ao8gRvx5bItBVB7kdmJSfXQK8l
	 s8mNFsLQGIT3u4M+XNs9/WJY7NSjVG5UYpIQTTOGDLhCakQPKMYEPfsk+zSqVdocQH
	 RZp7XAFBrMNDgo/TzZ741oi6v+Md6d+1wM0vxRUjOBE2sVUdPdRdUXDJeBQw8fTiBK
	 xMJAKTM5MrcVcKBZUorE/Hjx1KJqcig7a1Wc8OHXDYRryu7ghojc0kaeJTqp6w1Qas
	 ndfbotfUHiOWw==
Date: Wed, 23 Apr 2025 13:59:29 -0500
From: Nico Williams <nico@cryptonector.com>
To: Toon Claes <toon@iotcl.com>
Cc: Remo Senekowitsch <remo@buenzli.dev>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: How GitLab does/doesn't need change IDs (was Re: Semantics of
 change IDs)
Message-ID: <aAk4kf2EM9pXaHZG@ubby>
References: <Z/VGYrrVZYQ13TLj@ubby>
 <20250409121924.GA148735@mit.edu>
 <Z/amMj/eg0RbXdkS@ubby>
 <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
 <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
 <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
 <aAgWytQNqtLzg2TU@ubby>
 <D9DLAQTMJYU6.RJLLVMQZOICK@buenzli.dev>
 <aAg4JR+rCDqO5ljV@ubby>
 <87cyd3f306.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyd3f306.fsf@iotcl.com>

On Wed, Apr 23, 2025 at 02:58:49PM +0200, Toon Claes wrote:
> Nico Williams <nico@cryptonector.com> writes:
> 
> At GitLab we keep track of the commit IDs a branch has been (maybe only
> if there is a Merge Request for that branch, I'm not sure). [...]

Do you mean "we keep track of the commit _hashes_ a branch has _seen_"?
But it can't be commit hashes, and there's no commit IDs, so GL could be
assigning synthetic, internal commit IDs based on commit similarity,
which proves Junio's and Theodore's point that similarity checking can
be enough.

> > The point is that GL demonstrates that these things can be done.  And I
> > don't see how a change ID would have helped GL much except in cases
> > where one re-does all the commits with different subject lines etc, but
> > leaves the actual patches mostly the same.  Now it does happen that I
> > split and squash commits, but it's rare that I completely redo them.
> 
> That's because GL stores history about a branch ref (outside the Git
> object/ref database). If you don't do that, you can't. Having a
> Change-Id embedded in the commit, retains that information in Git's DB.

I.e., GL has an internal reflog on the server side.  I've sometimes
wished that I could push and fetch reflogs (or subsets thereof anyways).

When doing code reviews I use [local, obv.] reflogs to see the diffs
between an earlier version of a branch that I fetched and reviewed
earlier and the latest that I just fetched and am reviewing, and
generally I don't need to see any other versions I never fetched, but
occasionally I've wished I could fetch those other versions, but since
there are no server-side refs for them, I can't.  [Or maybe I'm about to
learn of some feature I didn't know about :)]

I agree that change IDs / commit IDs in commit headers can help one keep
track of versions of a branch w/o a server-side reflog, but how would
you keep track of their chnronology?  I.e., how do you know which is
version 1, which is version 2, .., and which is version N-1?  (Version N
being the head of the branch.)  If you don't index these then finding
them is a full table scan, and if you index them then you've implemented
a server-side reflog.

Which makes me think that all that's needed for a good CR tool here is
a) a server-side reflog, b) similarity checking for commits.  (a)
doesn't seem like a radical idea (that can be implemented with server
side hooks), and (b) is also not radical given that file rename / copy
operations are detected by Git using similarity checking already.

From a UI/UX perspective not having to take extra steps to get those
change IDs into the commits is nice and user-friendly.

So I've come around to not wanting a change ID header :)  For the back-
and forward-port use-case having commit subject conventions that make
use of "ticket IDs" or similar is a 90% solution that many users have
been living with for decades.

Nico
-- 
