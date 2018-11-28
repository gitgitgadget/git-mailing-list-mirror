Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4B601F97E
	for <e@80x24.org>; Wed, 28 Nov 2018 02:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeK1N0P (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 08:26:15 -0500
Received: from mail-it1-f177.google.com ([209.85.166.177]:51565 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeK1N0P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 08:26:15 -0500
Received: by mail-it1-f177.google.com with SMTP id x19so2007257itl.1
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 18:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u8LKRczsuvmOVW2viXqQqq6jH3/X8Y7oojyWATUrpfo=;
        b=g8EFacIiT68PxR0IdZyqPv3LGvaBEuGtt7UimtHq4fkkdLRQSgXDY+S4ioyv4yxACe
         K7sB3F0YQCl7QHp19IcXJmvbH0hg+Wqcp+3D8z1z7jrN46kmA6XCWQMG1R/LcKksnBub
         7tvDoxKwJpMAoksCuDJp7khfl/NEX/jXxerIhsQKSB1V7LCPtdUeBZbSOews22PuaqWT
         SpREgRml/5Q1GYSTiEnBDCBadN+erSuuyPZdHO2s4Vrav93LIdkwBDk8OBMLLlue9kuR
         hvD/EFuDesq83Pk0oR22xLHpHncWfUIxccbPKL7cpzyO1IvAHS3VeGa+P3cowRfYAYb3
         JIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u8LKRczsuvmOVW2viXqQqq6jH3/X8Y7oojyWATUrpfo=;
        b=RFLVM7LnqWlR0ZlHzKrLpUX8t08MnE4wRy6dPcDmUH9Gyz34qWpZ021FwwtsjIO2ob
         3KNBRZwzG2xJUt5urutXd5XPZk/vyafwtzD02sx/oArXTLW0dmXsxUWry0z6ztzBKQDz
         4AwaRYhdQcrN6k23V+RBlpNnWm2GqG09VpTmTt5IP0gXQe/nSd73mzHdnAIgy4HQ9Lkv
         aHavbamASxs+XXWwym6WjkJ3MauyGQkgFcWHV0MxOXAck1YMnehPgNoXLlYTCuLuAOte
         BRxcVaapk1YgobWETRwG2GRUiD10m6GvSKQ5JwHGmSRPSxJPmWa/SvKMIFYJD8A+psP+
         +p+A==
X-Gm-Message-State: AA+aEWY5lvD51+bvk46qjVxzNpf/BSl518hdXWukPdx1Ffo4ZqzDhM72
        uiltTHd0Yxj3aLNL7dzsqsFSjT46S8OPEFOHV86WMA==
X-Google-Smtp-Source: AFSGD/X9qLeyb8Jyb8A4QItq5ByX78jDW2CGKd28PHM31XWtJc8GfO1Jp8EoiHhvMORDZ286aBRb1RRfW6Z4+jgUo+M=
X-Received: by 2002:a02:c943:: with SMTP id u3mr19509886jao.96.1543371978960;
 Tue, 27 Nov 2018 18:26:18 -0800 (PST)
MIME-Version: 1.0
References: <CAGyf7-F6BiqSa7LOWxvHZPfO+UaohQR78rCgvN9En+1P4du2Nw@mail.gmail.com>
 <87efb6ytfj.fsf@evledraar.gmail.com> <CAGyf7-F-zs9Xyx623HizpOrv80y3PydReFYw-64w3T7Xfr3CNg@mail.gmail.com>
 <87d0qqysay.fsf@evledraar.gmail.com> <CABPp-BFBLKU5jnpr7scXJdj==qNtHJZ8R+LLMRE7qXT47eXXDg@mail.gmail.com>
In-Reply-To: <CABPp-BFBLKU5jnpr7scXJdj==qNtHJZ8R+LLMRE7qXT47eXXDg@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 27 Nov 2018 18:26:07 -0800
Message-ID: <CAGyf7-FwGRVtFYbOGW8DmY9F-cgun0n5K-ZWBjXCR=wvWh=8dQ@mail.gmail.com>
Subject: Re: Forcing GC to always fail
To:     newren@gmail.com
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 27, 2018 at 5:55 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Nov 27, 2018 at 4:16 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> >
> > On Wed, Nov 28 2018, Bryan Turner wrote:
> >
> > > On Tue, Nov 27, 2018 at 3:47 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
> > > <avarab@gmail.com> wrote:
> > >>
> > >> On Tue, Nov 27 2018, Bryan Turner wrote:
> > >>
> > >> >
> > >> > Is there anything I can set, perhaps some invalid configuration
> > >> > option/value, that will make "git gc" (most important) and "git
> > >> > reflog" (ideal, but less important) fail when they're run in our
> > >> > repositories? Hopefully at that point customers will reach out to =
us
> > >> > for help _before_ they corrupt their repositories.
> > >>
> > >>     $ stahp=3D'Bryan.Turner.will.hunt.you.down.if.you.manually.run.g=
c' && git -c gc.pruneExpire=3D$stahp gc; git -c gc.reflogExpire=3D$stahp re=
flog expire
> > >>     error: Invalid gc.pruneexpire: 'Bryan.Turner.will.hunt.you.down.=
if.you.manually.run.gc'
> > >>     fatal: unable to parse 'gc.pruneexpire' from command-line config
> > >>     error: 'Bryan.Turner.will.hunt.you.down.if.you.manually.run.gc' =
for 'gc.reflogexpire' is not a valid timestamp
> > >>     fatal: unable to parse 'gc.reflogexpire' from command-line confi=
g
> > >
> > > Thanks for that! It looks like that does block both "git gc" and "git
> > > reflog expire" without blocking "git pack-refs", "git repack" or "git
> > > prune". Fantastic! The fact that it shows the invalid value means it
> > > might also be possible to at least provide a useful hint that manual
> > > GC is not safe.
> > >
> > > I appreciate your help, =C3=86var.
> >
> > No problem. I was going to add that you can set
> > e.g. pack.windowMemory=3D'some.message' to make this go for git-repack
> > too, but it sounds like you don't want that.
> >
> > Is there a reason for why BitBucket isn't using 'git-gc'? Some other
> > hosting providers use it, and if you don't run it with "expire now" or
> > similarly aggressive non-default values on an active repository it won'=
t
> > corrupt anything.

We did use "git gc" (sans options; its configuration was applied via
"config") for several years, but there were some rough edges.

The biggest one was that "git gc" has a canned set of steps it runs
that can't be disabled, even when they add no value (or are actively
detrimental).

For us, the biggest issue was "git gc"'s insistence on trying to run
"git reflog expire". That triggers locking behaviors that resulted in
very frequent GC failures--and the only reflogs Bitbucket Server (by
default) creates are all configured to never ex[ire or be pruned, so
the effort is all wasted anyway.

Counting objects: 3, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 270 bytes | 0 bytes/s, done.
Total 3 (delta 1), reused 0 (delta 0)
remote: error: cannot lock ref 'stash-refs/pull-requests/13996/merge':
ref 'stash-refs/pull-requests/13996/merge' is at
2ec6a74b453d76f7a5247baa9f396361027ffdf=E2=80=82but expected
1678f303202010c6d7e6201226df08dc8fc49ae3
remote: error: cannot lock ref 'stash-refs/pull-requests/13996/to':
ref 'stash-refs/pull-requests/13996/to' is at
bd32d53e4fe63b15be029085f1b6d795d526adbc but expected
f55ec06e89a11b8bdbcd97680a900361307d28c4
remote: error: cannot lock ref 'stash-refs/pull-requests/14006/merge':
ref 'stash-refs/pull-requests/14006/merge' is at
1cc907e2a7082033d70a164f222d3cce17a453a9 but expected
ae057003d7ed7d096b5b952191d784113f25b982
remote: error: cannot lock ref 'stash-refs/pull-requests/14006/to':
ref 'stash-refs/pull-requests/14006/to' is at
bd32d53e4fe63b15be029085f1b6d795d526adbc but expected
f55ec06e89a11b8bdbcd97680a900361307d28c4
remote: error: cannot lock ref 'stash-refs/pull-requests/14043/merge':
ref 'stash-refs/pull-requests/14043/merge' is at
a2e510b1b2b583b273f6d6d28e13151619e8d143 but expected
7735a5bde21815d307c68244e8fd2d67a09d5a39
remote: error: cannot lock ref 'stash-refs/pull-requests/14043/to':
ref 'stash-refs/pull-requests/14043/to' is at
bd32d53e4fe63b15be029085f1b6d795d526adbc but expected
f55ec06e89a11b8bdbcd97680a900361307d28c4
remote: error: cannot lock ref 'stash-refs/pull-requests/14047/merge':
ref 'stash-refs/pull-requests/14047/merge' is at
bd4f0e9bcbed34fd9befa65763f5aee6c9ebd8ce but expected
649dea948e8e6b54506615e5d61c6779c242d5af
remote: error: cannot lock ref 'stash-refs/pull-requests/14047/to':
ref 'stash-refs/pull-requests/14047/to' is at
bd32d53e4fe63b15be029085f1b6d795d526adbc but expected
f55ec06e89a11b8bdbcd97680a900361307d28c4
remote: error: failed to run reflog
To https://...
=E2=80=82=E2=80=82 f55ec06..bd32d53=E2=80=82=E2=80=82master -> master

(Note: That example was from when "git gc --auto" was running attached
to a push, because auto-detach doesn't always detach, but our explicit
"git gc" processing would fail with the same "cannot lock ref"
messages.)

The worktree and rerere cleanup "git gc" does is also unnecessary
overhead, but was less of a concern because it wouldn't make GC
_fail_.

Another issue with the canned steps for "git gc" is that it means it
can't be used to do specific types of cleanup on a different schedule
from others. For example, we use "git pack-refs" directly to
frequently pack the refs in our repositories, separate from "git
repack" + "git prune" for repacking objects. That allows us to keep
our refs packed better without incurring the full overhead of
constantly building new packs.

It may be possible to make "git gc" run more targeted operations, but
even looking through the C code I couldn't find a way.

>
> ...assuming no other repo has this one as an alternate, which I
> suspect is the issue at play.  (I wrote an alternate-aware gc script
> years ago when using Atlassian Stash to try to workaround this issue,
> but think I only used it for a couple repos and never got around to
> deploying it in prod for continuous use, probably worried I had missed
> a corner case.  Had meant to, but at some point the powers that be
> decided to push us toward a different repository manager tool, and
> I've long since forgotten most details.)

"git gc" should be perfectly safe to run in a Bitbucket Server
repository which has forks; we "simply" configure it to never prune
(and that's applied in "config", so even if an administrator runs "git
gc" manually, _as long as they don't provide explicit arguments to the
contrary_, it still won't prune). When Git 2.10 or newer is installed
on the server we use "git repack --keep-unreachable" to prevent
writing unreachable objects as loose, and we skip running "git prune"
at all. For older versions of Git, we detect where the "objects/17"
heuristic would still want to run GC immediately after GC has already
run and we stream the loose object IDs to "git pack-objects" to write
a "garbage" pack, and then run "git prune-packed" to remove all the
loose objects.

It's on the backlog to actually start pruning again, even in forked
repositories, but there are some other design changes we need to make
first before we can ship that. (Not to mention the enormous amount of
testing we need to do to ensure it's safe...)

Bryan
