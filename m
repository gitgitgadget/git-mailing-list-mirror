Received: from cyan.ash.relay.mailchannels.net (cyan.ash.relay.mailchannels.net [23.83.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C8A25776
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 04:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743739776; cv=pass; b=aJUZ8FLhS2jZ8F5bqJtbAVjWE16mG2ZPGnfzI8jSRN11vyslaVGyGISkoc46OgtFyuUmxQewbsP+CGf0O/kZfaL0hOms0WFOhaK1Ary5m4Ni7iDvHUNjVxlQVqP1pb5fapj3+1HtKCqtKe5Dt+8ILadD9Ni974q/gej0IpEgVIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743739776; c=relaxed/simple;
	bh=wc712aEgLtHbuhEyFvRysOXlGKDcUw3j0IAIhMVhasA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBzcrewusQJdKDkoy8PbMh2qZaRzaR/qYquwms6dI5AxibIZxUzTEPPqWxOyNT5u/fSYkmT9mCkQPtxCZHe0Hswb3ODuhXD3ivQSo3bjPwxscRdHXtqCw0w32FYB/ZqHPvw+9VV818mQ5IIIkkjqehIBBs6CE0skQerl1qPELnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=XqOnBbfc; arc=pass smtp.client-ip=23.83.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="XqOnBbfc"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5CCC42C3EAE;
	Fri,  4 Apr 2025 03:52:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a259.dreamhost.com (trex-9.trex.outbound.svc.cluster.local [100.99.62.49])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E51312C3ED5;
	Fri,  4 Apr 2025 03:52:31 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1743738752; a=rsa-sha256;
	cv=none;
	b=FwTAymUxwarl2rt2KjVsaDqVkmPsrMlCHqu+Sj3yFO7mkMun8xIW2AyROfxT/JaTnId/0D
	V4EHP38xFb0gm2Nf1//F4DfU7NzCMui40csjU21yJpQNizcF193YV81U922Y8TP9LuG4YD
	fdo5c9z4lQ7ewzuFMSigj6evkS2W6zxYJNTDLPlbtyqa9Wl13NUWdpxBdzLFNzQ1UeMtGA
	iwJrO2IH9TjeRAp4GJdsqFHoTsWtkosAB/5OcBoffOrmtc8/tX/dUKwHHCstdTuzfnib4O
	GaP/Uy6O1TeBZ0pLWFiuJXJH2M+Uxy507vyJgvW9HXrazPuL4v+NU1WgrUIIvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1743738752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=XpJXuvqJAMlh4ZDzrOIgQPlPe71eAURukEgnlhIl68g=;
	b=dtEcjg/wbWFgN70DhqWgr4TY5T92DlSchUrejj6EnctiE/InZXXkP5naav1aG6R/RUAgkX
	ud/ilOU+qlAFHxzl3ksX2pe0F3TyMk9hLkv2AkBdt3a0unpDt2gqgojiaPTmbEscvI620m
	kEwRYKhNHNiddL9Vm1mY/F+FZh11ud0QEvRfedTb6lo/ITzUikKdBlrHAZ2tjfFCYO82bL
	bFZP29hMeXzF6I0umDIfyjrSq7Gf0FyYnvNaktkJHU4dHbgIxaE40TZl8X8WwlpJXLPdbT
	L3plcrT45/I7UBdS01bmQdzpKIp+WUOVygIk1GxXS93VKRKMwfa2GRAHMoueww==
ARC-Authentication-Results: i=1;
	rspamd-5c8769d675-tqsm8;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Interest-Whistle: 609a01410f2b9359_1743738752307_4189050821
X-MC-Loop-Signature: 1743738752307:3615059431
X-MC-Ingress-Time: 1743738752307
Received: from pdx1-sub0-mail-a259.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.62.49 (trex/7.0.3);
	Fri, 04 Apr 2025 03:52:32 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a259.dreamhost.com (Postfix) with ESMTPSA id 4ZTPnV5bkCz2r;
	Thu,  3 Apr 2025 20:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1743738751;
	bh=XpJXuvqJAMlh4ZDzrOIgQPlPe71eAURukEgnlhIl68g=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=XqOnBbfcmOkg4Jw8IMqoQg6OvgyAIvw8rGNPsTcu9Kypz4T+Cg3rYaN5fIw5zK7kk
	 x2kLPOpCASkz4o42O/gPPC36hoDh7Ko2/cN3BkOrtJLyUpYb9C66TNk5j7xHH43Du6
	 NRzuujOqLQdsGY92qzQWqblblZ3nv2KgNGVbSpPgg/aSqEPEFTKN835RnAy8IhDFrF
	 RK8GGT3sQWhX1IRyGm/kdQ5CNlrY8u5Vl6lH6V0K8X6RhqIjlCHigm6YNrKOHl6R4H
	 0a7I5MFUjyrfUGtqv8/PNx9SbOBEhiUyO7SSB8Kl7by+m1dT26gio/t+1jfFcq9e8F
	 hguEr0nzj1lYw==
Date: Thu, 3 Apr 2025 22:52:28 -0500
From: Nico Williams <nico@cryptonector.com>
To: Remo Senekowitsch <remo@buenzli.dev>
Cc: Elijah Newren <newren@gmail.com>,
	Martin von Zweigbergk <martinvonz@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
Message-ID: <Z+9XfLtodUOvqnse@ubby>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>
 <Z+7PDi5y4wXJBK4r@ubby>
 <D8XC02N85O7W.2LQY7B8Q2Z98G@buenzli.dev>
 <Z+8GoNrdaJlmNpGm@ubby>
 <D8XEYQ9TRB10.L5S89IAC2LZ9@buenzli.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8XEYQ9TRB10.L5S89IAC2LZ9@buenzli.dev>

On Fri, Apr 04, 2025 at 02:05:13AM +0200, Remo Senekowitsch wrote:
> On Fri Apr 4, 2025 at 12:07 AM CEST, Nico Williams wrote:
> > If I cherry-pick a commit then I absolutely want its "change ID" to be
> > preserved by default.  If I want to drop that I can always ask for that
> > or amend the commit to remove it.  I will want the same behavior for
> > rebase and cherry-pick.  Having to remember different defaults and
> > options for the two would be a cognitive load I do not need.
> 
> Yeah, that's a very valid argument. In Jujutsus CLI, there is a very
> clear separation between "rebase" and "duplicate", so there's no risk
> of confusion if one preserves the change-id and the other doesn't.
> [...]

"no risk of confusion"?  It's higher cognitive load for the user, and
higher cognitive load does lead to confusion.

I don't understand whence the need to introduce a new name for an old
feature.  Even Fossil -which lacks rebase- did not introduce a new name
for cherry-pick.  Given cherry-pick one can always implement rebase, but
Fossil's devs hate rebase workflows and love merge workflows, so they
won't implement or accept rebase.  But still, they did not think up a
new name for cherry-pick just to be different.

Mercurial also went through a phase of "we hate rebase", then later they
added: light-weight branches (i.e., Git-style branching), rebase, and
histedit (because mixing history editing with rebase is scary please
no!!), and the end result was just more unnecessary cognitive load.

I hope the next better-VCS project has more empathy for its users.

> Making them behave the same way can be seen as simpler.

Yes: because it reduces users' cognitive load!

Here's an example: Git's rebase, cherry-pick, and am commands have the
same --abort, --continue, and --skip options because they all do similar
things.  This means I only ever needed to learn that once for one
subcommand and then that knowledge carried over to the others.  For all
the UI hate Git gets it gets things like that right, and I love that.

> >>                 [...]. The ways rebase and cherry-pick are most often
> >> used are semantically very different from each other. (interactive)
> >
> > How do you know this is "most often" so? [...]
> 
> I haven't conducted a study, this is my impression from talking to peers
> and reading chatter from other Git users online. Maybe the impression is
> wrong.

Rebase is notionally built out of cherry-pick, therefore they are
semantically similar even if users don't notice it.

Be careful with "chatter".  You might only be hearing from merge-happy
users who don't use rebase and rarely use cherry-pick.  Many users
prefer merge-based workflows because that elides the rebase/cherry-pick
cognitive load.  I won't deny that rebasing requires more thinking than
merging, but leaving behind useful history always requires more thinking
than merging.  I recommend watching huge projects like OpenSSL,
PostgreSQL, or Illumos to get a good idea of how power users use Git.

For example, Illumos uses the same policy that Sun used to: strictly
linear history only in the upstream master branch, with no merge commits
ever.  You can have topic branches, naturally, and release branches too,
but in each branch linear history only, which means you have to rebase
before pushing to upstream branches.  If you've never run into users who
use or have to use such rebase-heavy workflows then you might reach the
wrong conclusions about what is common.  But at any rate in this case
the fundamentals make it clear that you cannot have just one commit with
a given change ID and you should not have different defaults for copying
change IDs for rebase vs. cherry-pick vs. am.

> Yeah, I was (over-)simplifying. rebase is the swiss-army knife of git
> commands. But for all of these operations, it holds that the previous
> version of the patch(es) won't be reachable in the commit tree anymore
> after the rebase is complete. (assuming potential descendant branches
> are also rebased, which is usually the case) So rebase doesn't generally
> cause duplicate change-ids, which is what I wanted to get at.

> it holds

Not so.  For example, when forward-porting our local patches to
$external_open_source_project from 1.2.3 to 1.3.4 I do the following:

: ; git checkout 1.2.3-patched
: ; git checkout -b 1.3.4-patched
: ; git rebase --onto 1.3.4 1.2.3
: ; <address merge conflicts...>
: ;
: ; # Now branch 1.3.4-patched has the local patches from 1.2.3-patched
: ; # but is based on 1.3.4.

and now I'll have multiple commits with the same change IDs.

> > When would you not want to preserve a change ID on cherry-pick?  I can't
> > say I would ever have wanted to do that had Git had change IDs from day
> > 1, and I've been using Git for more than twenty years.
> 
> That's not exactly how Jujutsu thinks about the change-id, but it's a
> useful piece of information. Gerrit does indeed use its change-id to
> track cherry-picks. I am in favor of measures to track that metadata
> (although duplicating change-ids is not my preferred option for that).

Say you insisted on adding a prefix or suffix to the change ID when
"duplicating" commits, how would you have Git enforce repo-wide
uniqueness of change IDs?  The only tool Git has for this is refs, so
you'd have to create a ref for each change ID that points to the commit
with that change ID.  But now you've defeated the whole point of change
IDs beyond code review, so I would insist on a multitude of types of
change ID so that I could have one that lets me have more than one
commit with the same change ID.

> Let's assume the change-id represents the origin of a patch. What should
> happen if a patch is split in two? Should they have the same change-id,
> because they ultimately have the same origin? Maybe.

I, the author, get to decide whether a) they both keep the same change
ID, or b) one of them gets a new change ID, or c) both get new change
IDs, and/or maybe even d) with support for multiple change IDs I can
track that both came from the same original commit but also they now
have different additional change IDs.  If it's just a header I can do
this by convention.  If the VCS was going to implement global uniqueness
for change IDs then my life would get more complicated in this case and
I would not appreciate it.

> I don't attach too much semantic meaning to the change-id. It's a
> normally unique identifier for a change that persists as the change
> evolves. That's useful. The more commits with the same change-id as
> others there are, the less useful the concept becomes.

But it's perfect for all the other use-cases I mentioned, such as
backporting and forward-porting.  Those are the use-cases that most
would benefit from change IDs.  But even for the code-review-only case
the fact that you could look at a commit and use it to find
corresponding code review(s) is nice, even if you've had to cherry-pick
a commit for backports or for forward-porting.

> >> doesn't preserve the change-id for that reason. So if cherry-pick
> >
> > I have _never_ used cherry-pick to cause there to be duplicate commits
> > in the same branch.  Therefore calling it "duplicate" seems terribly
> > wrong to me.
> 
> Well, obviously not in the same branch. I meant duplicate among all
> visible commits (reachable from any branch). That's the issue we're
> discussing w.r.t. change-ids not always being unique identifiers for
> a single commit. What would you like me to call that siuation instead
> of duplicate?

Cherry-pick.  Because that's the name we already have.

> Can you maybe give some examples of how you use cherry-pick? I'd be
> interested in your use cases to maybe better understand where you're
> coming from. [...]

 - [take over someone else's work and] decide to pick some of their
   commits and drop others, but maybe do it in a new branch because the
   old branch is still useful due to dropped commits still being useful
   history (e.g., in case they are ever needed in the future)

 - fetch a branch from one upstream and pick selected commits onto
   another branch that normally tracks a different upstream (I keep
   local commits always "on top" of the upstream, rebasing as needed)

 - backports

 - forward-porting (this is arguably symmetric with backporting)

 - maintaining multiple related but different branches when researching
   different ways to implement some feature

>       [...]. I myself almost never use cherry-pick, simply because I'm
> not involved in any backporting. I've seen cherry-pick used to get a
> bugfix from another branch onto your own, in order to avoid having to
> wait for the other branch to be merged. But that practice has always
> rubbed me the wrong way. [...]

You may not have worked in sufficiently complex environments/projects.

In my world cherry-pick is an essential tool I cannot do without.  Where
a VCS was forced upon me that did not implement cherry-pick I've simply
used patch(1) to apply diffs from the commit I wanted to cherry-pick --
it's precisely because this is possible _and_ necessary that the VCS
might as well provide it.  Given cherry-pick then rebase follows, ergo
the VCS might as well also provide rebase.

>                   [...]. I feel like the correct thing to do in that
> situation is to extract the bugfix to a separate dependency-free branch
> and make the two feature branches depend on it. That way, both feature

"extract the bugfix to a separate [...] branch" -- that's exactly what
cherry-pick does!

> branches can more easily track changes in the bugfix by rebasing. If the
> bugfix was cherry-picked, it's much harder to keep the two versions in
> sync. (And finally, the latter approach probably makes the bugfix land
> faster.) So yeah, interested to hear your use-cases for cherry-pick.

I don't see how using a built-in cherry-pick feature vs manually
"extracting" a commit makes it easier to "keep the two versions in
sync".  On the contrary, manual operations always involve more cogntive
load that automated ones, and at any rate the thing that woul dhelp you
"keep the two versions in sync" is.. change IDs!

Nico
-- 
