Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6EB33DF
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 02:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744682750; cv=pass; b=tc5Bk00KzbGGZdLrLLTS+BzNYcfv4lspXmlm7HAUirZi31e10JaJE2b7op7ISjv3DhW62P4VkkAVBiSi2lPxT/t9cmmSfdgIKVz04JFveEdbbiWU7E4cZ5N40LaJF+2mIQj/oCNg3H3etofhOfi7afWZruaqjJbTIceosj/upL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744682750; c=relaxed/simple;
	bh=K3GeW1afEV9gfv0NZSiMuLJfaxfaHf4R9yeIgOJm77U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+TCgFyYWpM6k1aWtJ+3eCrdUJxJZi6KjQ5rlnhqHfmEsxkVk7L/w7eQt2kPITJhB0end8hWQMbnsQVXd3unwz0UNMGLpSNEJ73i2K0VNcYs+K8cDCI5XHAWSgO/CEdSDihJ+89306APIqvjcVP1AKM/A2BC3JMr3AKYRaMNnDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=kFHNf640; arc=pass smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="kFHNf640"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 51AB82C4C04;
	Mon, 14 Apr 2025 21:34:40 +0000 (UTC)
Received: from pdx1-sub0-mail-a229.dreamhost.com (100-110-114-166.trex-nlb.outbound.svc.cluster.local [100.110.114.166])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id AD1102C5C11;
	Mon, 14 Apr 2025 21:34:39 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744666479; a=rsa-sha256;
	cv=none;
	b=H0AYrn1/5gbLXK6JSB5RRKarCXXi1vCGyP1GiepFI1XSnTmJri+LvRs+MyAbD3R2dxLYP1
	dtZNQU9BkPv3x2cY0QAUHEyARfow1qDmLulT//p69XfRXqnubR/ZICwh8AL3QQUj04fDGi
	WiPeNtR2cWUlKuMUZl3YdsrImetfbv4gnpuz6584c2zalrvgfjVwGPfyFq79WfUrC2+aKg
	6L80Fw7YVp60KXtn7n2iq1LMY3wjn58GkDuXZVpFEuPfMiqzJoA84JQRmTgGRITqHqF/zu
	ULwF+jkeEa7sYoaACAq/jbYSYqH3nlULRZisfDmuRTTpU63iuihyVVa6BVcTrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744666479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Jr1PuPoMu2S5zZPFf5wKb2eGhyzMY4LjTqtzAjHwwoE=;
	b=o3GcIDF4W0nBtbTSqJJGcJyqhcnHMOMJYZh7KtdNtacdaokpAVqeN+o4HAkOOEOJW6X4lh
	JEnYlkbjuIaZQweQ6GK7x7h1IKPiMlerdZ+qdgOEYQKWpcDVfTMWkZaonNYFgLLcn8yEPQ
	DnqJKwNMgl8Bnm5OBHCHcnSyZQhu3i4OPGgMLn7hJsiW/l6x4mZMxxKf8AI+VfIaA59rV0
	0Z+JNo42XRs3OjQDyqcUJCue69kkctEhlxIuH66I2YmG3VGgJhw3WLR6UMZsgDDcOJux7X
	0FGydvqv9WlTSzwg2c72BocFc+09G1l6ZYrBtMKw3zaA4R9HZ7MtIwsDTXghyA==
ARC-Authentication-Results: i=1;
	rspamd-865c984fb5-86dhv;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Tasty-Wide-Eyed: 3c47fb5721b9ceaa_1744666480007_1063638679
X-MC-Loop-Signature: 1744666480007:197056578
X-MC-Ingress-Time: 1744666480007
Received: from pdx1-sub0-mail-a229.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.114.166 (trex/7.0.3);
	Mon, 14 Apr 2025 21:34:40 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a229.dreamhost.com (Postfix) with ESMTPSA id 4Zc0tQ4TSRzFs;
	Mon, 14 Apr 2025 14:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1744666479;
	bh=Jr1PuPoMu2S5zZPFf5wKb2eGhyzMY4LjTqtzAjHwwoE=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=kFHNf640YQT+KuUlgIk74oBsVdCKHDsZsCGa9MbBEechNqBgL4bW97ec7zq6DNC07
	 gXbadMv+eRI7Pyto09lkG8lYpVe5IcpRBnVGEuji1ppCVwNiFMJt/p88fjIYPi2ie9
	 kEYmU5B+lLLQnAF/cP0Q4VIWVTHk8+WU1bN2Z/1vupPllTh5NpFTXoaTaanbyp8BMM
	 uxl9opACN0OBayM2bfGUZKB6PjrpWMtqrjoFesFUyeT4djzUP/egYv+Fb7VJNjYi/n
	 X7Y/6TulrRzZmY5+0cP022CWX+RgAFg8jeLeZJEIBf1JhZdRW7OGd4BoPIYTdh0huD
	 wTOpS528s5kQg==
Date: Mon, 14 Apr 2025 16:34:36 -0500
From: Nico Williams <nico@cryptonector.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
Message-ID: <Z/1/bDQnWc8Lj29S@ubby>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g>
 <Z/RFQY433muaCW44@ubby>
 <20250408125521.GA17892@mit.edu>
 <Z/VGYrrVZYQ13TLj@ubby>
 <20250409121924.GA148735@mit.edu>
 <Z/amMj/eg0RbXdkS@ubby>
 <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>

On Mon, Apr 14, 2025 at 03:54:23PM -0400, D. Ben Knoble wrote:
> Using URIs [to code reviews] looks to me like it makes some
> assumptions about what creates or consumes these headers, right?
> Especially since the URI should point to a code review… Is there a way
> to do that which is downstream-agnostic?

You could tag the URI(s) with purposes, but URIs are already pretty
agnostic as to what is being referenced by them as they are merely the
reference.  That said, if you need to decompose the URI into specific
subitems then you need to understand the underlying application's
local-part (and q-param, if any) scheme.

> Further, and maybe this is my ignorance of Gerrit showing: how would
> you attach a URI to a local commit when authoring it? You don't have
> the review URI when running `git commit`, do you? (Maybe I
> misunderstood; I'm seeing an odd chicken-egg problem here.)

Excellent outlook-changing question.  Local tooling would be needed,
which would be annoying if that tooling were not Git itself, but if it's
Git then how would it interface with Gerrit or any other such tools?
We'd have to define APIs for that, and that too would be annoying.  So
it has to be `git commit` (or `git rebase -i` and then use a new verb to
stop and set a commit's change ID metadata, like `reword`, but for
metadata), which means the user has to acquire a CR before creating the
CR, so the CR tools would have to support that.

On the other hand if it's not CR URIs but more like ticket URIs (as in
JIRA, bugzilla, etc.) then it's much easier.

People already use ticket IDs all the time, typically in the commit
subject, else in the commit commentary, typically using some specific
form.  For example Illumos has devs put one ticket ID in the subject and
if there are more ticket IDs then the body of the commit message must
start with each additional ticket ID on a line by itself with the
ticket's synopsis following the ID.  E.g.,
https://src.illumos.org/source/history/illumos-gate/ (I think they
don't allow any actual commentary in the commit message body, with all
commentary having to be in the tickets).

Typically tickets have to exist before the commits get created, and in
cases like Illumos' tickets have to exist before the code review is
created, and the commits have to reference the relevant ticket(s).

OTOH in the Illumos case you see that in a CR one might have multiple
commits for different tickets each, and still all be related.  A change
ID/URI could be used to link those together without having to go
spelunking in the ticket system.  Also ticket IDs (and URIs) could be
handy as a header in the commits because otherwise one has to know the
commit naming conventions of the project.  Illumos, for example, could
link tickets by ID in the subject and commit message body and by URI in
commit headers (or footers).

> Which begs another question: what/who applies the initial change ID to
> a commit and when?

See above.

> I've skimmed most of the discussion, and I think a unique ID for an
> in-flight series could be useful for ergonomics and to support more
> tools that link between versions of the series.

Also to ease back- and forward-ports.  Though to be fair that's a mostly
solved probalm as when users do those typically they start with a
ticket, find a CR linked from the ticket, find the corresponding commits
in the main branch, then go from there.  A change ID might not be more
helpful than that.  Then again, if you're doing a second or third
backport then one could find earlier backports that might be easier to
port from than the main branch commits, and here then a change ID might
help.

> Re-reading the original post [1] (which didn't mention this kind of
> ID?), I'm having a hard time seeing the problem statement. [...]

It mentions a "change ID".  I'm supposing it could be a URI, but I don't
care if it's not, and if it's easier then ignore the URI thing.

> It looks to me, an outsider, like the problem is some combination of
> "I want to track a commit's evolution" and "I want to see related
> commits in review, esp. when it's an identical and already-approved
> commit." But I might be misreading, and clarifying the problem
> statement might help bring us to a better core solution?

I'm the one introducing the second of those, and perhaps I should butt
off.

> [1]: https://lore.kernel.org/git/xmqqh62tm5fo.fsf@gitster.g/T/#m038be849b9b4020c16c562d810cf77bad91a2c87
> 
> Cheers,
> D. Ben Knoble
> 
> PS This discussion feels somewhat related to the classic GitHub
> problem of not presenting interdiffs/range-diffs: GitHub shows a
> too-flat source diff on force-pushes. Perhaps better web UI tooling
> about interdiff review (which I think is one of the things Gerrit
> does/wants to do?) makes change IDs less necessary, since interdiffs
> help connect evolutions of commits?

Nothing here could force GH to make their UI nicer and more featureful.

Nico
-- 
