Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065C14A4987
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361661; cv=pass; b=PYWjGEqUzHryg9sj+/US1HC1TZ5PI5/v+mHd6XSt8q8UHtg4fgZczREckn3J6udFmb1QwwQDpYKobI7uaItbYDJhNqS4DKrtpuqfzSuARdyMhhYLkS2GkdN5y6O1qQ2u1X7AAU+AJlS2KxivW9nloWVO6gYiFrUPgaA0zlsyolc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361661; c=relaxed/simple;
	bh=Zlk/RcpenvigxHvAFHXz4VBsulNZNQtTvpk4i6W4QG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQUjWdRXF+xVw94FYhfvLfg5kqakwW5GU17cl1fgSHTsDIi76VwomXBmVw0dRcOHHNxA/dYayo0uFEl2OF6mZo+lLJkf3OSP+UkAgc4y+Bjmo7BErV4YNCjMHL0bIU/GTbTGQtcXg8NVqd/F0sYJOYHCV1n34BXzFLQN0wI5OR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=iUB7UZnZ; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="iUB7UZnZ"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66f7f62e915so1377475d50.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 08:07:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788361655; cv=none;
        d=google.com; s=arc-20260327;
        b=fapb9QlmGZvnUVv+5nn1yORpZAG+yRVxxLjgDq0+oCV0sPRfVPnHrDFsVSp+S/uHJX
         2mMrVjE6qE+4kr75UYNUyi80727lIXnHbqBnGFKeMp6xGgRyUEMJ2raXQe2gok1v6yWc
         ulJpA1tsa9KKeNoeZY9bWoXdwAso16FjLCUPbd65MKNDfpzxdzzmtQ2FjiYdpRpI5v+1
         w4qllIx0lO/KDN+oXb1Ud4L7zA0l1f7F+AtAd0PoYjcP4b710Qu4Coyo9iEwXL6UoDF/
         ZuPB0aJsHxW16hdFhzLiKvXzU3E8TVVuyUOPHsieygwe9S+TzcAp6+K/cGXcWuxIMe9c
         vOFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=otIKvdX78pvpF8SeOBjiolDtIGx4T43+GtT92pidqtQ=;
        fh=aNhFkr8hwf9h88aHc/6XD0hEc5MhuWuPMeNwe8PUcrI=;
        b=rAceVbwM80qA1pebidpzE1JDVIdSqClZHL4h6uw2YEvUy0DqNT4GbR7EaYNHZhKIH+
         j9CXpxeTHpoeVkn7hhSRRGDyDDLD1S5wf52Ci3bd0ULO/7a3Xin26aEZknvxqWYultDe
         CC+oRO8XmMQFoWT99dvX7RDJn+XDKVpf8TluHl9bQGNhWdjJYD0BZ6o4tCJ2hUGdveEc
         dQWW31KSWwwba2lcm5FmwRgu74bLUQcQcGwvxKpqn8qw/Pj4qHoLV7F/MpwuqdRfqBup
         620q+3vD0or/0ftU0vT/7QWe/AWyWhyPu/BfHGC40OJ0kSOHvGLMpxzgjVpNvbe2d8hF
         WaHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1788361655; x=1788966455; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=otIKvdX78pvpF8SeOBjiolDtIGx4T43+GtT92pidqtQ=;
        b=iUB7UZnZ8Yium55r4NTPO5cQYvrZpejnh3qkqRGQZliPU4v8lRGkS6u5hBzaB55rwA
         xbXWJcR5zv4CwnVNl6DmrKrhIRTGVUjIadr//J/Ri34/1PMV2/Zo3ryD6umGSSAQOcXU
         ni1AnxntXH4jLrOHHv+qgvTqVGHHkDAXwn0ITrYvwS6EbCZmcCL/q+xaqpwAf7LFsQmQ
         P2/YcssVbLCS/WHZMFoGlEOMhEs85zV9NC7NDqYbwMSKS740H0MeKPC+7OiSGzcejQPa
         CZGLWGZjcXEJZar0C1nk1ZkEjWV9F+naNgw0m1NBRvZhP7ZXFH3Qloe+gMY5d8RVkTOm
         ofjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788361655; x=1788966455;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=otIKvdX78pvpF8SeOBjiolDtIGx4T43+GtT92pidqtQ=;
        b=KxJa9ob8PmDYM6gZ25abRdmb6Qr65sLrWuBPoS2aQ2tTwWPnBYmzUbwNR4ayQ7qEao
         i0Tkg3zI37IGI+C4hbeV+vNqmTlmBVEfTvhFrA8d9r/KN0gNp+95j2OxmSMi859u9Aoi
         Ssi1BaSTIILXqxSee+LzzFfqnLqChhoe1xSsYmWQIK05cNSCivX5aD9gnnO0nhEtZ/Wo
         YxTV7TQKBzjb3i5vUPmuVUkDMS0IKaLP2sRZ4mfxzQkx/IbkukjdsTmT26hww8gQjOgQ
         SWa+19KK28zuR9QVTYULV7ztDV13NYJIVCjx6/sQ772WcMq/IhPcMKLi9CVRvj3TGS41
         BOsw==
X-Forwarded-Encrypted: i=1; AKwUvBx48f5txbqhfcMtGXy8C8LyU7YnXWpbNQ7KKsoRh76r/AXM35sS+n/n8MDu1Lyh+a6vXwg=@vger.kernel.org
X-Gm-Message-State: AFuF++mmwFgOJ0Sb3HlunNJVyDIoo5kBo5Hs77Uzmvyfb9AZ3F0dYRs+
	GyscRAuGlUcPqdqT3O6zriNxkMowoA4eqISt4BK+PWQVlThjuAdRkqa+qVHv76B4Kjb2uDkYb/h
	PM+By8ydHQwGM5P+loGjdiIGcP5ZDN52RY1p0XoCG8w==
X-Gm-Gg: AYBFou185ROlhAe66gjrC6wgmndhRFOo7Mrj4tO/VqLIA/UD6Kjfc4CoD9sZHhUmn62
	qShzDvOzXQUBfAiXgYj62NXZR6bYj/RcbdD6mt6nklkOAmhfdt8XBuRStHgs8H7rUR1vrWvOdWC
	ohj7QlHmJIs1UirWk0PSx5jKvgNMlS3gLbj/DeES7OpFDnEnDX7KMd/dIPFNm37z+3O+KsmnnpO
	MuZ1ss/jEE2ot6LLE3kTp+OJKbTqUX4XJT2s8/TtzNFHLsgf44eFYIU+N/tjvZ+q5ofYIMCRT9Z
	FLi4zotfu+D8EjbVuLBnbFEidKJzZW4hrtLhlXg1mV+QOlCktkKaHJ9e7e+39PJmQx4yn+qdtXF
	OM1pXEK+Gi3wlZA==
X-Received: by 2002:a05:690e:248a:b0:66c:e893:9e73 with SMTP id
 956f58d0204a3-66f9b669571mr1700439d50.0.1788361655186; Wed, 02 Sep 2026
 08:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com> <fc8b288c-3d77-4cf6-adff-f981e6a7a7d2@gmail.com>
In-Reply-To: <fc8b288c-3d77-4cf6-adff-f981e6a7a7d2@gmail.com>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Wed, 2 Sep 2026 17:07:23 +0200
X-Gm-Features: AcwNN1VoWRRaIgAg28mqf-kynbbqvRgoAlPsP74lQvMgNuaHZ8VbzikYxBYbsnA
Message-ID: <CAA0xjtpYDGODpC9gJCZ_8KUvvtW53tTDed0iyDSZJCQchTWuAw@mail.gmail.com>
Subject: Re: [PATCH] rerere: keep a background gc from killing a rebase
To: phillip.wood@dunelm.org.uk
Cc: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Hi Phillip,

On 02/09/2026 15:27, Phillip Wood wrote:
> To me this is another reason why we should disable gc.auto while
> rebasing. To do that we need to pass "-c gc.auto=false -c
> maintenance.auto=false" when running "git commit" in run_git_commit()
> and also when running "git merge" in do_merge(). We should also pass
> those settings via GIT_CONFIG_PARAMETERS when running a exec command in
> do_exec(). That is largly papering over the cracks but until we have a
> systematic solution it does at least stop exposing users to this bug.

OK, I'll do that. It is also more consistent than it looks: the
commits the sequencer creates in-process via try_to_commit() don't run
auto maintenance at all, only the "git commit" child does (for a
resolved, reworded or squashed commit). What surprised me is that a
rebase with the merge backend then never runs maintenance, not even at
the end, because it doesn't go through finish_rebase() where the apply
backend runs it. Do you want a single run at the end of the sequence
in that patch, or keep it minimal?

FWIW, the tool I hit this with has been setting both for its whole
process tree since, and the failures stopped.

>> When it is the rebase, it dies in do_pick_commit()
>
> That's a bug us well - we should be returning errors, not dying
> -rerere_setup() should be returning an error, so we can clean up and
> reschedule the pick.

Yes. I don't think we even need to reschedule: when repo_rerere() is
called there, the merge result is already in the index and worktree,
the error and advice have been printed, and the return value is
ignored. If setup_rerere() reports the lock and returns -1, the pick
just stops at the conflict like any other, minus rerere's recording
and replay, and --continue works. I went through the callers of
setup_rerere(): all of them handle a negative return, because that is
what a disabled rerere returns, so this is close to a one-branch
change. It also fixes the stale-lock case (crashed process), which
disabling gc can't.

> As I understand it we now block the sequencer until the background
> maintenance has completed, or continue to die in an inconvenient state
> we timeout before the background maintenance finishes. That seems rather
> unfortunate as the idea of running the maintenance in the background is
> to prevent it from interfering with other commands.

Right, that's what it does. I copied the timeout from
core.packedRefsTimeout, but a ref update can't be skipped and a rerere
can, so the wait buys little. I'll drop rerere.lockTimeout.

What it did buy: the gc spawned by the continue's own commit needs
~5ms to take the lock, the next pick usually longer to reach its
rerere, so the gc is normally holding it by then. With only the
gc-side skip my repro still died 3 of 3 times; with the error return
those runs would survive but lose rerere at that stop. Tolerable, but
it is why I'd rather have the sequencer patch in the same series than
leave it for later.

> I think my preferred solution is to disable gc while rebasing. Returning
> an error from rerere_setup() would also help in the case where the user
> runs "git commit" and then continues the rebase. I'd be interested to
> hear what Junio and Patrick think about that.

So v2 would be two patches: rerere returning an error on a busy lock
(with "rerere gc" still warning and skipping as in v1, and a commit
message that talks about the fix instead of the trace), and the
sequencer disabling gc.auto/maintenance.auto for "git commit", "git
merge" and exec. I'll wait for Junio and Patrick before rerolling in
case they see it differently.

Patrick, one thing I noticed on the way: since 452b12c2e0
(builtin/maintenance: use "geometric" strategy by default, 2026-02-24)
every "maintenance run --auto" runs rerere-gc as soon as rr-cache has
even a single entry, stale or not. The doc for
maintenance.rerere-gc.auto says the heuristic may be refined; that
would make this rare for every command, not only the sequencer. Not
touching it in this series, just mentioning it.

Thanks,
Tom


Am Mi., 2. Sept. 2026 um 15:27 Uhr schrieb Phillip Wood
<phillip.wood123@gmail.com>:
>
> Hi Thomas
>
> On 02/09/2026 09:31, Thomas Bachem via GitGitGadget wrote:
> > From: Thomas Bachem <mail@thomasbachem.com>
> >
> > Since 2.54 unscheduled maintenance uses the "geometric" strategy, so
>
> That change really is the gift that keeps on giving
>
> > the "git maintenance run --auto --detach" behind every "git commit"
> > runs "git rerere gc" in the background whenever rr-cache has an entry.
> > That includes the "git commit" the sequencer runs for a resolved pick
> > on "git rebase --continue".
> >
> > rerere_gc() takes MERGE_RR.lock through setup_rerere(), which uses
> > LOCK_DIE_ON_ERROR, and so does the sequencer's repo_rerere() at the
> > next conflict a few milliseconds later. Whichever comes second dies.
>
> To me this is another reason why we should disable gc.auto while
> rebasing. To do that we need to pass "-c gc.auto=false -c
> maintenance.auto=false" when running "git commit" in run_git_commit()
> and also when running "git merge" in do_merge(). We should also pass
> those settings via GIT_CONFIG_PARAMETERS when running a exec command in
> do_exec(). That is largly papering over the cracks but until we have a
> systematic solution it does at least stop exposing users to this bug.
>
> > When it is the rebase, it dies in do_pick_commit()
>
> That's a bug us well - we should be returning errors, not dying
> -rerere_setup() should be returning an error, so we can clean up and
> reschedule the pick.
>
> There is a lot of detail here about what causes the problem which is
> helpful, but there is very little discussion about the fix. As I
> understand it we now block the sequencer until the background
> maintenance has completed, or continue to die in an inconvenient state
> we timeout before the background maintenance finishes. That seems rather
> unfortunate as the idea of running the maintenance in the background is
> to prevent it from interfering with other commands.
>
> I think my preferred solution is to disable gc while rebasing. Returning
> an error from rerere_setup() would also help in the case where the user
> runs "git commit" and then continues the rebase. I'd be interested to
> hear what Junio and Patrick think about that. I'm also not clear why
> gc.auto has to fork a separate process just to check if it needs to run
> or not, I've not been following closely but my impression is that that
> is the cause of quite a lot of the lock contention bugs we've seen.
>
> Thanks
>
> Phillip
>
> > with the index
> > written but before make_patch() writes rebase-merge/{message,patch,
> > stopped-sha}, and every later "git rebase --continue" refuses with
> > "you have staged changes in your working tree". When it is the "git
> > commit" of a later continue, that one dies in its post-commit
> > repo_rerere() after the commit was made. Before 2.54 the same
> > collision needed an auto gc to actually run, since gc runs
> > "rerere gc" at its end.
> >
> > A rebase with two conflicts in a row shows it. The filler makes the
> > pick slower than the ~5 ms the background task needs to take the
> > lock, and keeps the lock held for about 0.4 s. It hit 6 of 6 runs
> > here on 2.55.0, and a test suite driving rebases on toy repositories
> > with a single rr-cache entry hit it in both runs that were traced:
> >
> >      git init -q -b main r && cd r
> >      git config rerere.enabled true
> >      git config maintenance.auto false
> >      mkdir pad && seq 20000 | (cd pad && split -l 1 -a 5)
> >      echo base >f && git add -A && git commit -qm base
> >      git checkout -q -b topic
> >      echo b >f && git commit -qam B
> >      echo c >f && git commit -qam C
> >      git checkout -q main
> >      echo a >f && git commit -qam A
> >      git repack -adq
> >      seq 20000 | awk '{printf ".git/rr-cache/%040x\n", $1}' \
> >          | xargs mkdir -p
> >      for d in .git/rr-cache/*/; do echo x >$d/preimage; done
> >      git config --unset maintenance.auto
> >      git checkout -q topic
> >      git rebase main
> >      echo ab >f && git add f
> >      GIT_EDITOR=true git rebase --continue
> >
> > The second continue dies with "Unable to create '.git/MERGE_RR.lock':
> > File exists" while the gc spawned by its own commit holds the lock,
> > and after resolving C every further continue refuses. Maintenance
> > stays off during the setup so that no repack is pending: a repack due
> > at that commit runs ahead of rerere-gc in the task list and would
> > spend the window.
> >
> > The gc needs the lock: it removes every rr-cache directory it finds
> > empty, and a rerere that has just created its directory but not yet
> > written the preimage looks exactly like that. So keep the lock and fix
> > both orders. When the gc finds the lock busy, let it warn and do
> > nothing this time, the way "maintenance run" treats its own lock, so a
> > manual "git rerere gc" sees the warning and the maintenance task and
> > "git gc" see a clean exit. When the gc holds the lock, let every other
> > caller wait it out instead of dying at once, for rerere.lockTimeout
> > milliseconds with the semantics of core.packedRefsTimeout: 1000 by
> > default, 0 for the old behaviour, -1 for an unbounded wait. Walking a
> > 20000-entry rr-cache takes about 0.4 s here.
> >
> > That rebase now completes. The tests cover the gc under a held lock,
> > directly and through the maintenance task, a merge that waits a lock
> > out within a five second rerere.lockTimeout, and one that fails at
> > once with a timeout of 0.
> >
> > Assisted-by: Claude Fable 5.1
> > Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
> > ---
> >      rerere: keep a background gc from killing a rebase
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2214%2Fthomasbachem%2Frerere-gc-lock-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2214/thomasbachem/rerere-gc-lock-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/2214
> >
> >   Documentation/config/rerere.adoc |  8 +++++++
> >   Documentation/git-rerere.adoc    |  4 +++-
> >   rerere.c                         | 27 +++++++++++++++++----
> >   rerere.h                         |  1 +
> >   t/t4200-rerere.sh                | 40 ++++++++++++++++++++++++++++++++
> >   t/t7900-maintenance.sh           |  8 +++++++
> >   6 files changed, 82 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/config/rerere.adoc b/Documentation/config/rerere.adoc
> > index 3a78b5ebb1..8041a1587b 100644
> > --- a/Documentation/config/rerere.adoc
> > +++ b/Documentation/config/rerere.adoc
> > @@ -10,3 +10,11 @@ rerere.enabled::
> >       enabled if there is an `rr-cache` directory under the
> >       `$GIT_DIR`, e.g. if "rerere" was previously used in the
> >       repository.
> > +
> > +rerere.lockTimeout::
> > +     The length of time, in milliseconds, to retry when trying to
> > +     take the rerere lock while another process holds it, typically
> > +     a background `git rerere gc`.  Value 0 means not to retry at
> > +     all; -1 means to try indefinitely.  Default is 1000 (i.e.,
> > +     retry for 1 second).  `git rerere gc` itself does not wait and
> > +     skips its run instead.
> > diff --git a/Documentation/git-rerere.adoc b/Documentation/git-rerere.adoc
> > index 4e6ab9a27c..05935b0603 100644
> > --- a/Documentation/git-rerere.adoc
> > +++ b/Documentation/git-rerere.adoc
> > @@ -70,7 +70,9 @@ occurred a long time ago.  By default, unresolved conflicts older
> >   than 15 days and resolved conflicts older than 60
> >   days are pruned.  These defaults are controlled via the
> >   `gc.rerereUnresolved` and `gc.rerereResolved` configuration
> > -variables respectively.
> > +variables respectively.  If another process holds the lock on the
> > +recorded resolutions, for example a merge or rebase that is recording
> > +a conflict, `gc` does nothing and reports so.
> >
> >
> >   DISCUSSION
> > diff --git a/rerere.c b/rerere.c
> > index 8232542585..22d114262b 100644
> > --- a/rerere.c
> > +++ b/rerere.c
> > @@ -32,6 +32,7 @@ static int rerere_enabled = -1;
> >
> >   /* automatically update cleanly resolved paths to the index */
> >   static int rerere_autoupdate;
> > +static int rerere_lock_timeout_ms = 1000;
> >
> >   #define RR_HAS_POSTIMAGE 1
> >   #define RR_HAS_PREIMAGE 2
> > @@ -876,6 +877,8 @@ static void git_rerere_config(void)
> >   {
> >       repo_config_get_bool(the_repository, "rerere.enabled", &rerere_enabled);
> >       repo_config_get_bool(the_repository, "rerere.autoupdate", &rerere_autoupdate);
> > +     repo_config_get_int(the_repository, "rerere.locktimeout",
> > +                         &rerere_lock_timeout_ms);
> >       repo_config(the_repository, git_default_config, NULL);
> >   }
> >
> > @@ -908,12 +911,26 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
> >
> >       if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
> >               rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
> > -     if (flags & RERERE_READONLY)
> > +     if (flags & RERERE_READONLY) {
> >               fd = 0;
> > -     else
> > +     } else if (flags & RERERE_SKIP_LOCKED) {
> >               fd = hold_lock_file_for_update(&write_lock,
> > -                                            git_path_merge_rr(r),
> > -                                            LOCK_DIE_ON_ERROR);
> > +                                            git_path_merge_rr(r), 0);
> > +             if (fd < 0) {
> > +                     warning_errno(_("unable to lock '%s', skipping"),
> > +                                   git_path_merge_rr(r));
> > +                     return -1;
> > +             }
> > +     } else {
> > +             /*
> > +              * A background "rerere gc" holds the lock for as long as it
> > +              * takes to walk rr-cache, so wait it out rather than die.
> > +              */
> > +             fd = hold_lock_file_for_update_timeout(&write_lock,
> > +                                                    git_path_merge_rr(r),
> > +                                                    LOCK_DIE_ON_ERROR,
> > +                                                    rerere_lock_timeout_ms);
> > +     }
> >       read_rr(r, merge_rr);
> >       return fd;
> >   }
> > @@ -1237,7 +1254,7 @@ void rerere_gc(struct repository *r, struct string_list *rr)
> >       timestamp_t cutoff_resolve = now - 60 * 86400;
> >       struct strbuf buf = STRBUF_INIT;
> >
> > -     if (setup_rerere(r, rr, 0) < 0)
> > +     if (setup_rerere(r, rr, RERERE_SKIP_LOCKED) < 0)
> >               return;
> >
> >       repo_config_get_expiry_in_days(the_repository, "gc.rerereresolved",
> > diff --git a/rerere.h b/rerere.h
> > index d4b5f7c932..87964bb3c5 100644
> > --- a/rerere.h
> > +++ b/rerere.h
> > @@ -10,6 +10,7 @@ struct repository;
> >   #define RERERE_AUTOUPDATE   01
> >   #define RERERE_NOAUTOUPDATE 02
> >   #define RERERE_READONLY     04
> > +#define RERERE_SKIP_LOCKED  010
> >
> >   /*
> >    * Marks paths that have been hand-resolved and added to the
> > diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
> > index 1717f407c8..6b90294435 100755
> > --- a/t/t4200-rerere.sh
> > +++ b/t/t4200-rerere.sh
> > @@ -242,6 +242,46 @@ test_expect_success 'old records rest in peace' '
> >       test_path_is_missing $rr2/preimage
> >   '
> >
> > +test_expect_success 'gc does nothing while MERGE_RR is locked' '
> > +     mkdir -p $rr2 &&
> > +     echo Hello >$rr2/preimage &&
> > +     test-tool chmtime =$just_over_15_days_ago $rr2/preimage &&
> > +
> > +     test_when_finished "rm -f .git/MERGE_RR.lock" &&
> > +     >.git/MERGE_RR.lock &&
> > +     git rerere gc 2>err &&
> > +     test_grep "MERGE_RR" err &&
> > +     test_path_is_file $rr2/preimage &&
> > +
> > +     rm .git/MERGE_RR.lock &&
> > +     git rerere gc &&
> > +     test_path_is_missing $rr2/preimage
> > +'
> > +
> > +test_expect_success 'a held lock is waited out within rerere.lockTimeout' '
> > +     git reset --hard &&
> > +     rm -rf $rr &&
> > +     test_when_finished "rm -f .git/MERGE_RR.lock" &&
> > +     >.git/MERGE_RR.lock &&
> > +     {
> > +             (sleep 1 && rm -f .git/MERGE_RR.lock) &
> > +     } &&
> > +     test_must_fail git -c rerere.lockTimeout=5000 merge first 2>err &&
> > +     wait &&
> > +     test_grep ! "Unable to create" err &&
> > +     grep "^=======\$" $rr/preimage
> > +'
> > +
> > +test_expect_success 'rerere.lockTimeout=0 fails at once on a held lock' '
> > +     git reset --hard &&
> > +     rm -rf $rr &&
> > +     test_when_finished "rm -f .git/MERGE_RR.lock" &&
> > +     >.git/MERGE_RR.lock &&
> > +     test_must_fail git -c rerere.lockTimeout=0 merge first 2>err &&
> > +     test_grep "Unable to create" err &&
> > +     test_path_is_missing $rr/preimage
> > +'
> > +
> >   rerere_gc_custom_expiry_test () {
> >       five_days="$1" right_now="$2"
> >       test_expect_success "rerere gc with custom expiry ($five_days, $right_now)" '
> > diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> > index d7f82e1bec..a55ca2e829 100755
> > --- a/t/t7900-maintenance.sh
> > +++ b/t/t7900-maintenance.sh
> > @@ -885,6 +885,14 @@ test_expect_success 'rerere-gc task with --auto honors maintenance.rerere-gc.aut
> >       test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=0 maintenance run --auto --task=rerere-gc
> >   '
> >
> > +test_expect_success 'rerere-gc task succeeds while MERGE_RR is locked' '
> > +     test_when_finished "rm -rf .git/rr-cache .git/MERGE_RR.lock" &&
> > +     mkdir .git/rr-cache &&
> > +     : >.git/rr-cache/entry &&
> > +     >.git/MERGE_RR.lock &&
> > +     test_expect_rerere_gc git maintenance run --task=rerere-gc
> > +'
> > +
> >   test_expect_success '--auto and --schedule incompatible' '
> >       test_must_fail git maintenance run --auto --schedule=daily 2>err &&
> >       test_grep "cannot be used together" err
> >
> > base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
>
