Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9918F4418
	for <git@vger.kernel.org>; Sun, 31 Dec 2023 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQunt9SA"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-680b16bd8c5so277136d6.1
        for <git@vger.kernel.org>; Sun, 31 Dec 2023 04:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704024876; x=1704629676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxMCGs1b59hjuTWdG2SmMrcO7a5Xy0f472wPnviTBUU=;
        b=JQunt9SAyMDGmzWbhCAevcpA/mb6mjQz/DZKOqPAzKzJqpzLCP0Ad4klQoeVA5mUdL
         itBlhdB2Blod14KUshE8Ait1cMPydpE7KbMjDJZeaj8BJpcT+800i5EDDmv/rVESZdro
         zXRKhWntx7i6N8t8UyUK4nlKSYIb3TxJO0yTWHrfGgaNx8i1cWzFTRNBGiJbIfwK0bGC
         p4LlabfCT3G5dGulKjpUw0TqLCvji3/3sVtXFIPBJC3yLhMZU2YLZmNC8hKWDwgSM2eG
         uP/v0+yGd/ThdBGxrItKMP0trhIxQyW0t+MvinI0biR63nBl0pYVtc0WAIAFaED5YW0R
         yI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704024876; x=1704629676;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BxMCGs1b59hjuTWdG2SmMrcO7a5Xy0f472wPnviTBUU=;
        b=RV7cJt3QGX5ZgpsO7wnYiK2eN3BK7wZ2srtU3zmXZ8pdcu5KPhf4IWFGPaAKP9gNXd
         UZ2GfOY44DcMmoUDBH/QAA3pBMJcWAoR4yOSuuwD1qTrOyKMUbwWCtmPbFnKhNy/68dq
         N1uw1jeGilTIFmzksUt839yLsUwDFUZ0goERYDn89V3bQNpAA+FZjD+Tbn6omJsldgjD
         IzPZtu//wuWg6L3oxH7lBvbZ2NjOE0/Tx8KZq6A/ceE1NiOKuiJ66Qv01ZU3mHbd6inF
         tPloinDGl50NjfNF3fKLSU4tfSvwaLPL/finvgDYEH6476sk3KnTTer1ByBVQGI18z5j
         dlCQ==
X-Gm-Message-State: AOJu0YzJPTkAT6DoWb0wR9avN+NTukr/vQzkTX8IzurT9AHP2C5BTBGK
	VQ9GIJQoJdvgJQUijHDrL3AlonfYVRA=
X-Google-Smtp-Source: AGHT+IEUwb7aLQSC5S4+4YYZaOQ4zLQ57a1dKOuRehKk3QiAUvCuS8mLzw+a9ehXj2wu/7j8KEWsaw==
X-Received: by 2002:a05:622a:448:b0:41e:a62b:3d28 with SMTP id o8-20020a05622a044800b0041ea62b3d28mr29728450qtx.4.1704024876250;
        Sun, 31 Dec 2023 04:14:36 -0800 (PST)
Received: from epic96565.epic.com ([2620:72:0:6480::d])
        by smtp.gmail.com with ESMTPSA id g5-20020ac85805000000b00410a9dd3d88sm10865674qtg.68.2023.12.31.04.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 04:14:35 -0800 (PST)
References: <m0sf3vi86g.fsf@epic96565.epic.com>
 <CABPp-BFbvRDCbMp9Gs9PuV7WfgoVNwyOOn1rB7fe_8UvEEdehA@mail.gmail.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Sean Allred <allred.sean@gmail.com>
To: Elijah Newren <newren@gmail.com>
Cc: Sean Allred <allred.sean@gmail.com>, Git List <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>
Subject: Re: rebase invoking pre-commit
Date: Sun, 31 Dec 2023 04:52:00 -0600
In-reply-to: <CABPp-BFbvRDCbMp9Gs9PuV7WfgoVNwyOOn1rB7fe_8UvEEdehA@mail.gmail.com>
Message-ID: <m0sf3itvpy.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Elijah Newren <newren@gmail.com> writes:

> On Thu, Dec 21, 2023 at 12:59=E2=80=AFPM Sean Allred <allred.sean@gmail.c=
om> wrote:
>> Is there a current reason why pre-commit shouldn't be invoked during
>> rebase, or is this just waiting for a reviewable patch?
>>
>> This was brought up before at [1] in 2015, but that thread so old at
>> this point that it seemed prudent to double-check before investing time
>> in a developing and testing a patch.
>>
>> [1]: https://lore.kernel.org/git/1m55i3m.1fum4zo1fpnhncM%25lists@haller-=
berlin.de/
>
> I'm very opinionated here.  I'm just one person, so definitely take
> this with a grain of salt, but in my view...
>
> Personally, I think implementing any per-commit hook in rebase by
> default is a mistake. It enforces a must-be-in-a-worktree-and-the-
> worktree-must-be-updated-with-every-replayed-commit mindset, which I
> find highly problematic[2], even if that's "what we always used to
> do".
>
> [2] https://lore.kernel.org/git/20231124111044.3426007-1-christian.couder=
@gmail.com/

I'm not hip with what most pre-commit hooks do, but I'll point out that
a hook like pre-commit assuming there is a worktree is the fault of the
hook implementation, not of the infrastructure that invokes the hook. I
imagine most folks on this list are aware that a worktree is not needed
to create a commit and update a branch to point at it.

FWIW, I would also find such a mindset to be highly problematic :-) I'll
take a moment here to thank you, Christian, and everyone else in that
effort for your interest in and work on git-replay; I've been trying to
watch its activity on-list closely in the hopes that we can adopt it
into our system once it's ready.

> Because of that, I would prefer to see this at most be a command line
> flag. However, we've already got a command line flag that while not
> identical, is essentially equivalent: "--exec $MY_SCRIPT" (it's not
> the same because it's a post-commit check, but you get notification of
> any problematic commits, and an immediate stop of the rebase for you
> to fix up the problematic commit; fixing up the commit shouldn't be
> problematic since you are, after all, already rebasing).

Indeed, and an

    --exec 'git hook run pre-commit || git reset --soft HEAD~'

would probably get you farther. I can certainly see an argument for
this, but from the perspective of designing a system for other
developers to use, such a rebase would have to be triggered
automatically (perhaps on pre-push).

> I see Phillip already responded and suggested not running the
> pre-commit hook with every commit, but only upon the first commit
> after a "git rebase --continue".  That seems far more reasonable to me
> than running on every commit...though even that worries me in regards
> to what assumptions that entails about what is present in the working
> tree.

It's worth noting the context here is to prevent developers from
committing conflict markers, so this would actually be exactly
sufficient.

Invoking pre-commit at this time would also be consistent with the
behaviors of prepare-commit-msg, commit-msg, and post-commit -- at least
when I reword a commit during a rebase.

However, post-commit is executed after each picked commit during a
rebase, so pre-commit there would also be consistent.

> (For example, what about folks with large repositories, so large that
> a branch switch or full checkout is extremely costly, and which could
> benefit from resolving conflicts in a separate sparse-checkout
> worktree, potentially much more sparse than their main checkout?

As it happens, a single checkout of our source runs upwards of 2GB, so
I'm exactly in the population you're describing :-) The main reason
we're moving to Git from SVN is that an SVN checkout can take upwards of
an hour for us today -- even with some real shenanigans to make them go
faster. On the Git side, we've also looked into (though I don't recall
if we had much success with) narrowing the sparsity patterns to just the
conflicts for conflict resolution workflows -- particularly when moving
feature code between separate trunks. So I guess I'm also glad we
weren't too far off in left field on that one! (As I recall, one of the
main challenges we faced there was ensuring there was enough stuff
'still around' so that both binary and project references could resolve
and folks could use that information to help resolve conflicts.
Hopefully git-replay can be smart enough to allow some customization on
that front. We found some success with feeding the list of conflicted
files into some arbitrary logic that spat out the sparsity pattern to
use.)

> And what if people like that really fast rebase resolution (namely,
> done in a separate very sparse checkout which also has the advantage
> of not polluting your current working tree) so much that they use it
> on smaller repositories as well? Can I not even experiment with this
> idea because of the historical per-commit-at-least-as-full-as-main
> -worktree-checkout assumptions we've baked into rebase?)

I'd be interested in reading more about this baked-in assumption. Are
these mostly laid out in replay-design-notes.txt[3]?

> While at it, I should also mention that I'm not a fan of the broken
> pre-rebase hook; its design ties us to doing a single branch at a
> time.  Maybe that hook is not quite as bad, though, since we already
> broke that hook and no one seemed to care (in particular, when
> --update-refs was implemented).  But if no one seems to care about
> broken hooks, I think the proper answer is to either get rid of the
> hook or fix it.

If I were to guess, this likely stems either from an inexact definition
of the hook in documentation (ultimately resulting in incomplete tests)
or folks incorrectly assuming what each hook should do based purely on
its name.

Which leads to an interesting point: pre-commit specifically states that
it is invoked by git-commit -- not that it's invoked whenever a commit
is created. So perhaps the correct thing to do here (if a hook is in
fact needed) would be to define a new hook -- but I worry about doing
that in the current state where there doesn't *seem* to be very rigid
coordination of when client hooks are invoked in terms of plumbing
rather than porcelain.

> Anyway, as I mentioned, I'm quite opinionated here.  To the point that
> I deemed git-rebase in its current form to possibly be unfixable
> (after first putting a lot of work into improving it over the past
> years) and eventually introduced a new "git-replay" command which I
> hope to make into a competent replacement for it.  Given that I do
> have another command to do my experiments, others on the list may
> think it's fine to send rebase further down this route, but I was
> hoping to avoid further drift so that there might be some way of
> re-implementing rebase on top of my "git-replay" ideas/design.

I appreciate your perspective; you've certainly thought a lot about this
space -- and I definitely share your goal of consolidating
implementations for obvious reasons.

So I suppose that leaves me with four possible paths forward:

1. Pursue invoking pre-commit before each commit in `git rebase` (likely
   generic in the sequencer) to be consistent with post-commit.

   It sounds like this isn't a popular option, but I'm curious to folks'
   thoughts on the noted behavior of post-commit here.

2. Pursue invoking pre-commit on `git rebase --continue` (likely on any
   --continue in the sequencer). This has the benefit of using existing
   configuration on developer machines to purportedly 'do the right
   thing' when its likely humans are touching code during conflict
   resolution. It's worth noting this isn't the only reason you might
   --continue, though, since the naive interpretation of this approach
   completely ignores sequencer commands like 'break', though it could
   probably just do what commit-msg does.

3. Define and implement a new hook that is called whenever a new commit
   is about to be (or has been?) written. Such a hook could be
   specifically designed to discourage assuming there's a working copy,
   though we're kidding nobody by thinking it won't be used downstream
   with that assumption. At least we could be explicit about
   expectations, though.

   This is *probably* a lot more design work than this little paragraph
   lets on, but I've not personally watched the introduction of a new
   hook so I don't have context for what to expect.

4. Trigger a rebase --exec in our pre-push. This is certainly the least
   work in git.git (i.e., no work at all), but it comes with the
   distinct disadvantage of playing whiplash with the developer's focus.
   During conflict resolution, they're thinking about conflicts. When
   you're ready to push, its likely that you're no longer thinking about
   conflicts.

Does the behavior of post-commit here change any minds?

[3]: https://github.com/newren/git/blob/2a621020863c0b867293e020fec0954b438=
18789/replay-design-notes.txt#L162

--
Sean Allred
