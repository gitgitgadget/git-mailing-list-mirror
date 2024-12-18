Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF47165F18
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 08:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734510643; cv=none; b=AhnTXT2T3flQK/LmVE9+3rxNoJ3rAxu9zqpPmyCbjd9IjBfhEXp6VF7L+5dPb8wuyDhgVcemEpINCyKzq2bvgCdDLC/nLgK4FusNhbDn3OJZDcux1BJDH/caceGZjd1rOMTODtu4bAEmXfYo7FdPTahlK6Kt0rdrPgKP6hikPCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734510643; c=relaxed/simple;
	bh=dkgTovG17ZVW6qoXNoJoLDDcTfcUv0ieKUNNnE6A5Js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKcUSn3Lsl9fR4Vu29JFDNC8Ktdm1HnKVkHPlgnu0iWvhC9ge86z/oVRZTG/vM19tJeWamklVBfpjkhPMMFD8ef7MFQD32flRZjuCN/cwmozJPRh5xZfTRB5qpxd91fwWU/cfgPMIMYKnGEUogsC+EdjmojiDLAfTxOS6uQsEc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTj8cexa; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTj8cexa"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so406925a91.0
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 00:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734510641; x=1735115441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+jeJ3bIr9B6MYg2LQcAtd467SP7Fm/J3RcD/PSZ2wM=;
        b=GTj8cexau3J7QTk5BgpcIO7HFHhSRKVO2OwZUNM2Qyrfy4bHQIPvFhEvvBhQypBnBY
         Xr+G1/lCDjqtYfCY6eq7itUMQBRw9weFf31/0XLj2CznsZM3hycLJMbcbEtEYUy0FOpm
         8XGUovgN5EwqZ9vNT4CQiMKi/yRSgM1+j9eJQAnIAzTb15PaOubKsuUkqmtZI6xghSfv
         1ZHrPanknyYDz9UFw+RdzpOW0i+N6yg6VIEfhNGVsVtiVWDZtd+hVXW1UXxYg0M5Ynnq
         rdTbi2oHnZRl8DsjmpPjoX1Lct4QY3M+dAMng+ltAcQje2qww3oNPdf6qN8itV5p63bU
         pY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734510641; x=1735115441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+jeJ3bIr9B6MYg2LQcAtd467SP7Fm/J3RcD/PSZ2wM=;
        b=UZJ8pYUyvRyINtj0kpvjHvvwGtXFd6z/GNWDiNOmWkrBgByftW7XK5mOZ4lUtNn5Pm
         ztP1hqB+ABOJ90pNOYPLnpiWeWk3zL2YVMMbFgw5+l+t/uXYV52a+sLhJkvvCZOcJuJr
         E44DTCwCjJb6Szawb+FWL4PUfaNd5tzrHgKp5XGkMpOjZ6nMJyq8uBusqqZBI5ZKaYzi
         sTK/Nml6pTudGtJ6L81fLrmCXcqMx2nFGz2ChIsUVOiAMNiE4ovJuDvZSVGuS/pkVcM4
         qv3BsRt4/lWNE/WEtfCpxxJvdQfx0B/tQwgGzGUTSY5kmwDnBWrbUYbLJBzIhIhh9Gqx
         3Jaw==
X-Forwarded-Encrypted: i=1; AJvYcCWHLFWI9dMAImfdZIlthQcoR2ZVKZes5u8apu1vaOyiN6nlPDic8EXeMuQv4fk5EfDe4SU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/S5qrupaKRcLMo98I/F4/T/+XCvxNhJw+ZkBJJIcrVzfrWRvA
	Yg7SKvHyG9NmNmPbWagXBhlJNlh0/760R4LlUAnd0rPOwwIDNn98hzgCAFDC1E3MROspIJODomv
	dT1okjPIGq1D7XZ21XNV4mc+4ukMOmHUQ
X-Gm-Gg: ASbGncuoulfqOo2TBmfwulGZisGdokxlbrxzPs5Dz3271wQXqHhcN8X6QWeAkB35R4l
	+V9XYAiLREi98l/9k54mFlRGmlCGstyb4axStGEc=
X-Google-Smtp-Source: AGHT+IEONaNF/F9m4gLCtyL1aPtIcTqFxEKYXAJ5Yi80bv3iqTovrxXODPw17IrJ9p9gVI2gjVNg1sgOYWi/G9IDktQ=
X-Received: by 2002:a17:90b:4d0a:b0:2ea:8aac:6ac1 with SMTP id
 98e67ed59e1d1-2f2e966b703mr2854119a91.15.1734510640449; Wed, 18 Dec 2024
 00:30:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG=Um+0v=BmmYjvBAXs4r4My6zYvpJvcE+0U6SAnxKUcd1-A4w@mail.gmail.com>
 <Z2Emh42DJkHFGWq7@pks.im> <xmqqcyhq3ge7.fsf@gitster.g> <CAG=Um+1NwB=ymwg+oM62f_W8G=3Gt14UFGe+S2MM3gTOdUcuHg@mail.gmail.com>
 <CAG=Um+0yFYeBQGznkVG6TJeN-U+qySbt-0EbvM6Vd-BcvSCT4g@mail.gmail.com> <xmqq7c7y13tc.fsf@gitster.g>
In-Reply-To: <xmqq7c7y13tc.fsf@gitster.g>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Wed, 18 Dec 2024 14:00:03 +0530
Message-ID: <CAG=Um+0qGEf+pX0cjCA2Qti4NYwFeCb29zgS7k2Lu_0yfuEz-w@mail.gmail.com>
Subject: Re: Consider adding pruning of refs to git maintenance
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 1:26=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Shubham Kanodia <shubham.kanodia10@gmail.com> writes:
>
> > On Tue, Dec 17, 2024 at 4:51=E2=80=AFPM Shubham Kanodia
> > <shubham.kanodia10@gmail.com> wrote:
> >>
> >> On Tue, Dec 17, 2024 at 1:11=E2=80=AFPM Junio C Hamano <gitster@pobox.=
com> wrote:
> >> >
> >> > Patrick Steinhardt <ps@pks.im> writes:
> >> >
> >> > > If we want to have such a feature I'd thus claim that it would be =
most
> >> > > sensible to make it opt-in rather than opt-out. I wouldn't want to=
 be
> >> > > surprised by remote refs vanishing after going to bed, but may be =
okay
> >> > > with it when I explicitly ask for it.
> >> > >
> >> > > At that point one has to raise the question whether it is still al=
l that
> >> > > useful compared to running `git remote prune` manually every now a=
nd
> >> > > then. Mostly because explicitly configuring maintenance is probabl=
y
> >> > > something that only power users would do, and those power users wo=
uld
> >> > > likely know to prune manually.
> >> >
> >> > I am 100% in agreement with your reasoning.  If this thing is to
> >> > exist, it has to be opt-in.  We also need to add ample warning why
> >> > doing this asynchronously behind user's back while the user could be
> >> > working in the same repository is prone to cause surprises in the
> >> > documentation in big red letters.
> >> >
> >> > I however am OK with the idea of having it as an optional "task"
> >> > that is disabled by default in "git maintenance".  "git maintenance"
> >> > can be viewed as a platform-neutral way to set up scheduled tasks.
> >> >
> >> > A user may be a Git expert who knows what `git remote prune` does,
> >> > and understands and accepts the risk of confusion doing so without
> >> > explicit "do it now" from the end-user, but may not be a Linux or a
> >> > macOS or a Windows expert to know how to write crontab or its
> >> > equivalents on various schemes to define scheduled tasks.
> >> >
> >> > Thanks.
> >>
> >> Thanks for sharing your thoughts here. For some context =E2=80=94 I cu=
rrently
> >> look after git performance for a very large repository (60k+ refs)
> >> with a lot of active developers.
> >> I've observed that while power git users keep their repository tidy
> >> even without runnining maintenance, the majority of users infact don't
> >> know (or execute these), and
> >> run into performance issues. Easier fleet management was perhaps was
> >> one of the motivations behind adding this to `git-maintenance`.
> >>
> >> While its pretty rare that someone relies on a `refs/remote/*`
> >> reference (without creating a local copy of it in `refs/heads`), I can
> >> see why it can be surprising and an opt-in
> >> should be okay for me.
> >>
> >> Thanks,
> >> Shubham K
>
> If you want to mix a patch with other discussion, write a scissors
> line (e.g. "--- >8 --- cut here --- >8 ---" and nothing else on its
> own line) here before the patch begins, and tell readers that they
> need to scroll 50+ lines before they can see the patch at the
> beginning of your message if the leading part needs to be so long.
>
> > From aed935055aff819cce591eecbf6697f8e8e7b99e Mon Sep 17 00:00:00 2001
>
> Never include this line in the body of the message.
>
> > From: Shubham Kanodia <shubham.kanodia10@gmail.com>
>
> Having "From:" in the body of the message at the beginning of your
> patch is a good way to override the author identity and set it
> differently from what your MUA places on the From: header line,
> when you are forwarding somebody else's patch and want to record the
> author identity of the real author, but then this line would not
> have your name-email.  Another use case is when your MUA cannot be
> convinced to place your author identity on its From: header, but the
> message I am responding to has the same name-address in the From:
> header.
>
> So in conclusion, the above line is unnecessary in the body of this
> message.
>
> > Date: Tue, 17 Dec 2024 16:05:16 +0530
>
> Rarely it is a good idea to include this line in the body of the
> message.  The Date: header records the time the general public saw
> the patch for the first time, which is the author date as far as the
> general public is concered, much better.
>
> > Subject: [PATCH] maintenance: add prune-remote-refs task
>
> Overriding "Subject:" header of the e-mail with this in-body header
> is almost always needed when you are responding to an ongoing
> discussion and including a patch after a scissors line.
>
> So in short, "From/From:/Date:" should be dropped, "Subject:" kept,
> and insert a scissors line before it.
>
> > Remote-tracking refs can accumulate in local repositories even as branc=
hes
> > are deleted on remotes, impacting git performance.
>
> OK.  It usually is better to be explicit about the direction of the
> "impact".  E.g., "impacting git performance negatively".
>
> Have you considered using the reftable backend, instead of the files
> backend, by the way?  It is rumored to scale much better with the
> number of refs.
>
> It is possible that the user deliberately kept stale remote-tracking
> branches even after they are removed from the origin because they
> used them as the bases of their topic branches, in which case it
> would not be a good idea to blindly remove them, but I do not think
> that needs to be said here.  These users would not be running
> "git remote prune".
>
> > While git fetch --prune
> > helps clean these up, it requires a full fetch operation which is expen=
sive
> > for large repositories.
>
> It is curious why "git fetch --prune" is mentioned here, especially
> when you know "git remote prune" is much more appropriate operation
> for that purpose.  The real justification this paragraph needed to
> make is why it is a good idea to a new task in "git maintenance",
> rather than letting the user run "git remote prune" themselves,
> isn't it?
>
> > Add a new maintenance task 'prune-remote-refs' that runs 'git remote pr=
une'
> > for each configured remote. This provides an automated way to clean up =
stale
> > remote-tracking refs without requiring full fetches or manual intervent=
ion.
>
> Again, "requiring full fetches or" is probably out of place.
>
> > This task is disabled by default.
>
> If we wanted to mention "fetch --prune", it is probably not as an
> inferiour alternative to what you invented here, but as a different
> way the user can work that makes the problem you are trying to solve
> go away.  Perhaps near the beginning, after the "Remote-tracking
> refs can accumulate and impact performance negatively", say
> something like:
>
>     ... negatively.  The user can have the "fetch.prune"
>     configuration variable set to true when interacting with the
>     other side, and stale remote-tracking refs will automatically
>     pruned at zero cost.
>
> Of course "remote.<name>.prune" is a more targetted way that works
> per remote, but your prune-remote-refs works on all remotes,
> fetch.prune is a better contrast.
>
> In any case, stepping back a bit, for the population of user who
> benefit from enabing the prune-remote-refs task, wouldn't it be an
> even better solution for them to set fetch.prune?  You can tell them
> to run "git remote prune" just once, set that configuration
> variable, and then the remote-tracking branches will stay clean from
> then on.  Any future interactions with the remote make sure stale
> remote-tracking branches will be removed automatically.  Wouldn't
> that be a much better option?  I am sure I must be missing a use
> case where fetch.prune (or remote.<name>.prune) is not a good idea
> but background prune-remote-refs task works better.
>
> So, if we want to still add this new maintenance task, we should
> explain *that* use case after the proposed addition of "you can do
> with fetch.prune at zero cost" to the first paragraph.  IOW, before
> starting "Add a new maintenance task ...", we need to say something
> like:
>
>     There however are cases where pruning stale remote-tracking refs
>     at the "fetch" time is undesirable, yet keeping them indefinitely
>     is also unacceptable.  <<HERE YOU DESCRIBE THE USE CASE WITH
>     SUCH CHARACTERISTICS>>.  To help such use cases, add a new
>     maintenance task ...
>
> And if there is no such workflow where a background prune-remote-refs
> task is needed and fetch.prune would not work well, then we do not
> need a new task, do we?
>
> Let me review the change (assuming that there are cases where
> fetch.prune is not a good solution) below.
>
> > +prune-remote-refs::
> > + The `prune-remote-refs` task runs `git remote prune` on each remote
> > + repository registered in the local repository. This task helps clean
> > + up deleted remote branches, improving the performance of operations
> > + that iterate through the refs. See linkgit:git-remote[1] for more
> > + information. This task is disabled by default and must be enabled
> > + manually.
> > ++
> > +NOTE: This task is opt-in to prevent unexpected removal of remote refs
> > +for users of git-maintenance. It is recommended for power users who
> > +are comfortable with configuring maintenance tasks and understand the
> > +implications of automatic pruning. For others, running `git remote pru=
ne`
> > +manually might be more appropriate.
>
> "and must be enabled" is unnecessary---that is what "disabled by
> default" means.  Also, we probably would want to add a sentence or
> two to contrast this with setting fetch.prune to highlight why users
> would want to consider enabling this (instead of setting fetch.prune).
>
> Otherwise, nicely written.
>
> >  OPTIONS
> >  -------
> >  --auto::
> > diff --git a/builtin/gc.c b/builtin/gc.c
> > index 4ae5196aed..9acf1d2989 100644
> > --- a/builtin/gc.c
> > +++ b/builtin/gc.c
> > @@ -20,6 +20,7 @@
> >  #include "lockfile.h"
> >  #include "parse-options.h"
> >  #include "run-command.h"
> > +#include "remote.h"
> >  #include "sigchain.h"
> >  #include "strvec.h"
> >  #include "commit.h"
> > @@ -913,6 +914,40 @@ static int maintenance_opt_schedule(const struct
> > option *opt, const char *arg,
> >   return 0;
> >  }
> >
> > +static int collect_remote(struct remote *remote, void *cb_data)
> > +{
> > + struct string_list *list =3D cb_data;
> > +
> > + if (!remote->url.nr)
> > + return 0;
> > +
> > + string_list_append(list, remote->name);
> > + return 0;
> > +}
> > +
> > +static int maintenance_task_prune_remote(struct maintenance_run_opts
> > *opts UNUSED,
> > + struct gc_config *cfg UNUSED)
> > +{
> > + struct string_list_item *item;
> > + struct string_list remotes_list =3D STRING_LIST_INIT_NODUP;
> > + struct child_process child =3D CHILD_PROCESS_INIT;
> > + int result =3D 0;
> > +
> > + for_each_remote(collect_remote, &remotes_list);
> > +
> > + for_each_string_list_item (item, &remotes_list) {
> > + const char *remote_name =3D item->string;
>
> Is the patch whitespace-damaged?  The indentation seems to be gone.
> I won't comment on misindented lines and blocks in this review (i.e.
> even if the original had such problems, I wouldn't be seeing them in
> the message I am responding to).
>
> > + child.git_cmd =3D 1;
> > + strvec_pushl(&child.args, "remote", "prune", remote_name, NULL);
> > +
> > + if (run_command(&child))
> > + result =3D error(_("failed to prune '%s'"), remote_name);
> > + }
> > +
> > + string_list_clear(&remotes_list, 0);
> > + return result;
> > +}
>
> OK.
>
> >  /* Remember to update object flag allocation in object.h */
> >  #define SEEN (1u<<0)
> >
> > @@ -1375,6 +1410,7 @@ enum maintenance_task_label {
> >   TASK_GC,
> >   TASK_COMMIT_GRAPH,
> >   TASK_PACK_REFS,
> > + TASK_PRUNE_REMOTE_REFS,
> >
> >   /* Leave as final value */
> >   TASK__COUNT
> > @@ -1411,6 +1447,10 @@ static struct maintenance_task tasks[] =3D {
> >   maintenance_task_pack_refs,
> >   pack_refs_condition,
> >   },
> > + [TASK_PRUNE_REMOTE_REFS] =3D {
> > + "prune-remote-refs",
> > + maintenance_task_prune_remote,
> > + },
> >  };
> >
> >  static int compare_tasks_by_selection(const void *a_, const void *b_)
> > @@ -1505,6 +1545,8 @@ static void initialize_maintenance_strategy(void)
> >   tasks[TASK_LOOSE_OBJECTS].schedule =3D SCHEDULE_DAILY;
> >   tasks[TASK_PACK_REFS].enabled =3D 1;
> >   tasks[TASK_PACK_REFS].schedule =3D SCHEDULE_WEEKLY;
> > + tasks[TASK_PRUNE_REMOTE_REFS].enabled =3D 0;
> > + tasks[TASK_PRUNE_REMOTE_REFS].schedule =3D SCHEDULE_DAILY;
> >   }
> >  }
>
> OK.
>
> > diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> > index 0ce4ba1cbe..60a0c3f835 100755
> > --- a/t/t7900-maintenance.sh
> > +++ b/t/t7900-maintenance.sh
> > @@ -446,6 +446,50 @@ test_expect_success 'pack-refs task' '
> >   test_subcommand git pack-refs --all --prune <pack-refs.txt
> >  '
> >
> > +test_expect_success 'prune-remote-refs task not enabled by default' '
> > + git clone . prune-test &&
> > + (
> > + cd prune-test &&
> > + GIT_TRACE2_EVENT=3D"$(pwd)/prune.txt" git maintenance run 2>err &&
> > + test_subcommand ! git remote prune origin <prune.txt
> > + )
> > +'
>
> OK.
>
> > +test_expect_success 'prune-remote-refs task cleans stale remote refs' =
'
> > + test_commit initial &&
> > +
> > + # Create two separate remote repos
> > + git clone . remote1 &&
> > + git clone . remote2 &&
> > +
> > + git clone . prune-test-clean &&
> > + (
> > + cd prune-test-clean &&
> > + git config maintenance.prune-remote-refs.enabled true &&
> > +
> > + # Add both remotes
> > + git remote add remote1 "../remote1" &&
> > + git remote add remote2 "../remote2" &&
> > +
> > + # Create and push branches to both remotes
> > + git branch -f side2 HEAD &&
> > + git push remote1 side2 &&
> > + git push remote2 side2 &&
> > +
> > + # Rename branches in each remote to simulate a stale branch
> > + git -C ../remote1 branch -m side2 side3 &&
> > + git -C ../remote2 branch -m side2 side4 &&
> > +
> > + GIT_TRACE2_EVENT=3D"$(pwd)/prune.txt" git maintenance run
> > --task=3Dprune-remote-refs &&
> > +
> > + # Verify pruning happened for both remotes
> > + test_subcommand git remote prune remote1 <prune.txt &&
> > + test_subcommand git remote prune remote2 <prune.txt &&
> > + test_must_fail git rev-parse refs/remotes/remote1/side2 &&
> > + test_must_fail git rev-parse refs/remotes/remote2/side2
> > + )
> > +'
>
> OK.
>
> Other than that it is not clear if we want it, the change looks
> cleanly done and was a pleasant read (other than whitespace damages
> on the patch text).
>
> Thanks.

Let me address a few points here before I resend the patch in a more
ideally formatted manner.

> Have you considered using the reftable backend, instead of the files
> backend, by the way?  It is rumored to scale much better with the
> number of refs.

I don't think we've done that yet, but thanks for the pointer. In any
case, till reftable is stable (including support for reflogs etc),
we'd want to avoid switching all clients to use that,

> In any case, stepping back a bit, for the population of user who
> benefit from enabing the prune-remote-refs task, wouldn't it be an
> even better solution for them to set fetch.prune?  You can tell them
> to run "git remote prune" just once, set that configuration
> variable, and then the remote-tracking branches will stay clean from
> then on.  Any future interactions with the remote make sure stale
> remote-tracking branches will be removed automatically.  Wouldn't
> that be a much better option?  I am sure I must be missing a use
> case where fetch.prune (or remote.<name>.prune) is not a good idea
> but background prune-remote-refs task works better.

Let me expand on the context for suggesting this change:

I work with a large repository that has over 50k refs, with about 4k
new ones added weekly.
We have maintenance scripts on our git server that clean up stale refs
(unused older than N months).

Using `fetch.prune` with a normal git fetch isn't ideal because it
would cause git fetch to unnecessarily download many new refs that
users don't need. So we actively discourage that.

In theory, users could just run `git remote prune` once and carefully
avoid full fetches to keep their local ref count low.
However, in practice, we've found that full fetches happen through
various indirect means:

- Shell plugins like zsh/pure
- Git GUIs like Sourcetree
- Code editors like VSCode

among others.

These tools sometimes perform background fetches without users
realizing it, causing ref counts to gradually increase until users
remember to run `git remote prune` again.

Typically, most users care about:

- Their local branches (refs/heads) - usually a few hundred in number
- A small subset of remote branches they might work with from time to
time (>99% of active remote refs are irrelevant to any individual
developer in a large repo)

The goal here is to help users who can already run `git remote prune`
to do so periodically.
- If full `git fetch` is completely avoided, this will gradually
reduce the local ref count from tens of thousands to just a few
hundred active refs (even if the remote has 50k+ active refs) as old
branches on the remote expire with time.
- Even if not =E2=80=94say, if an errant tool or the developer executes `gi=
t
fetch` mistakenly, then the maintenance job ensures this doesn't
become their permanent state until the next manual remote prune.

Ultimately, this is about providing a better default for large-scale
repositories (& users who choose to keep refs pruned).
