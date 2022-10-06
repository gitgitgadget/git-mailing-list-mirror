Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B5DC433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 07:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiJFHK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 03:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiJFHKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 03:10:25 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F5831EE1
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 00:10:23 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a10so1231336ljq.0
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 00:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wERr5OhHSQLBqaOEqNMN8fu9ogQGn/4q4rW5mOipONQ=;
        b=iZszmVLlkI8yB6/iYYJ5aSrQ3+WEFZV1j2V1B7O8vXALZ4vcgak/ZRW7HKecvKJ40N
         fg8dK837AJCbZRhU4GkScfTqHQTogv0dllhiEmWGMCeDaWSfWerXSoPg1t4r9Wfs/Lql
         +FdjJa+pT8GPkhcG7CkC2fycLLmMA/x26iIGdtklHUKvuwReHJzPP7rNePN6BdOU7CaJ
         LAEGjA4wZXflK5y9MhmJfsLfyreeUAAMk2HAIS5G2zpwoV+ceJPHTAPRoHZura8Vt3zc
         dZ0MWGbiC3HlSmDR/RCMK7BDty8nVGZSwxM+mb6X8+Qo/djCAnSarMq80DryRlH3Y5CE
         leNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wERr5OhHSQLBqaOEqNMN8fu9ogQGn/4q4rW5mOipONQ=;
        b=kCUzLxTQvQgJV+1xl2BulhHUWRsDdx9EDF6LzZ7OnbmMn+6MM1edptv4pOi/64xutC
         Lb0toa9Z19CsPpX0CKe1P2sw/m6ZUwiZpvtvTA2WgE0tNCKeqrVCeD5QGdWgm9ZISdJf
         XiUaA/G3OkryFzVnNl1RKU1tgYl/wO+DRBep4Ij6Ewssk2fJZQNX5mJlZLJPrU0SKgTc
         dgK16wWNTwnFTFsOcOzxwX5v6ujc9vKAQm7dS/EmA12m6hNcn22yr1Bj4zSYycsjYYF6
         qGrBRqnhsjbhCdOgwuJMHX8ds232YXabvYGiTTBlY6EtgSy11U7IWQeuu60PEIRf8fax
         Asgg==
X-Gm-Message-State: ACrzQf1q6jOL5K7VYYdLBDR7dR5RjYYam08/SlWFPITnZIiO0TK28qSw
        P02/nsx5F7k0HlHU/qcdaxADJkohE3E6vKOI20Y=
X-Google-Smtp-Source: AMsMyM5O8m5JOFxfxhMetnNOupnTXg/vVfrll4LQaKdgmjIPLSJCFcpky6nnDZuwP3qV/9id2ykqz1M8sfReLNU1B9Y=
X-Received: by 2002:a2e:7804:0:b0:26c:463c:493c with SMTP id
 t4-20020a2e7804000000b0026c463c493cmr1247256ljc.521.1665040221807; Thu, 06
 Oct 2022 00:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
 <07a25d48-e364-0d9b-6ffa-41a5984eb5db@github.com> <CABPp-BEjVv1ASdQhXGh6KuDfPt_nhZpRO_Q0i1pCqrV2wVQ9yQ@mail.gmail.com>
 <5d926706-6ca3-ce07-f8f2-771fe126450b@github.com>
In-Reply-To: <5d926706-6ca3-ce07-f8f2-771fe126450b@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 6 Oct 2022 00:10:09 -0700
Message-ID: <CABPp-BGoJqtx_=p+GfqAhgs+4Zic1mcbs6pkMKy7QAnxTwB4AA@mail.gmail.com>
Subject: Re: [PATCH] sparse-checkout.txt: new document with sparse-checkout directions
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 28, 2022 at 6:22 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 9/28/22 1:38 AM, Elijah Newren wrote:
> > On Tue, Sep 27, 2022 at 9:36 AM Derrick Stolee <derrickstolee@github.com> wrote:
> >>
> >> On 9/24/2022 8:09 PM, Elijah Newren via GitGitGadget wrote:
> >>> From: Elijah Newren <newren@gmail.com>
> >>
[...]
> >>> +  * Commands whose default for --restrict vs. --no-restrict should vary depending
> >>> +    on Behavior A or Behavior B
> >>> +    * diff (with --cached or REVISION arguments)
> >>> +    * grep (with --cached or REVISION arguments)
> >>> +    * show (when given commit arguments)
> >>> +    * bisect
> >>> +    * blame
> >>> +      * and annotate
> >>> +    * log
> >>> +      * and variants: shortlog, gitk, show-branch, whatchanged
> >>> +
> >>> +    For now, we default to behavior B for these, which want a default of
> >>> +    --no-restrict.
> >>
> >> I do feel pretty strongly that we'll want a --no-restrict default here
> >> because otherwise we will present confusion. I'm not even sure if we would
> >> want to make this available via a config setting, but likely a config
> >> setting makes sense in the long term.
> >
> > You've got me slightly confused.  You did say the same thing a long time ago:
> >
> >     "But I also want to avoid doing this as a default or even behind a
> > config setting."[A]
> >
> > BUT, when Shaoxuan proposed making --restrict/--focus the default for
> > one of these commands, you seemed to be on board[B].
>
> I'm specifically talking about 'git log'. I think that having that be
> in a restricted mode is extremely dangerous and will only confuse users.
> This includes 'git show' (with commit arguments) and 'git bisect', I
> think.

Thanks, that helps me understand your position better.

I'm curious if, due to the length of the document and this thread,
you're just skimming past the idea I mentioned of showing a warning at
the beginning of `diff`, `log`, or `show` output when restricting
based on config or defaults.  Without such a warning, I agree that
restricting might be confusing at times, but I think such a warning
may be sufficient to address the concerns around partial/incomplete
results.  The one command that this warning idea doesn't help with is
`grep` since it cannot safely be applied there, which potentially
leaves `grep` giving confusing results when users pass either
`--cached` or revisions, but you seem to not be concerned about that.

I'm also curious if the problem partially stems from the fact that
with `git log` there is no way to control revision limiting and diff
generation paths independently.  If there was a way to make `git log
-p` continue showing the regular list of commits but restrict which
paths were shown in the diffs, and we made the --scope-sparse handling
do this so that only diffs were limited but not the revisions
traversed/printed, would that help address your concerns?

> The rest, (diff, grep, blame) are worktree-focused, so having a restrict
> mode by default makes sense to me.

I was specifically calling out diff & grep when passed revision
arguments, which are definitely *not* worktree-focused operations.

Also, blame incorporates a component of changes from the worktree, but
it's mostly about history (and one or more -C's make it check other
paths as well).

[...]
> I think the biggest point is that the implications of behavior A
> saying "I don't care about any changes outside of my sparse-checkout"
> leading to changed history are unappealing to me. After removing that
> kind of feature from consideration, I don't see any difference
> between the behaviors.

Indeed, the differences between the behaviors is (mostly?) about
history queries, be it `git grep --cached`, `git grep REV`, `git diff
REV1 REV2`, `git log -p`, etc.

And I understand it's unappealing to you, but I haven't seen an
alternative solution to disconnected development in partial clones.
Nor have I seen an alternate plan for users who want to really focus
on their small subset of the repository.

So, maybe you don't want to use a configuration knob and always want a
certain default, but I very much want a knob.

> > Anyway...I will note that without a configurable option to give these
> > commands a behavior of `--restrict`, I think you make working in
> > disconnected partial clones practically impossible.  I want to be able
> > to do "git log -p", "git diff REV1 REV2", and "git grep TERM REV" in
> > disconnected partial clones, and I've wanted that kind of capability
> > for well over a decade[H].  So, don't be surprised if I keep bringing
> > up a config option of some sort for these commands.  :-)
>
> Now, if we're talking about "don't download extra objects" as a goal,
> then we're thinking about things not just related to sparse-checkout
> but even history within the sparse-checkout. Even if we make the
> 'backfill' command something that users could run, there isn't a
> guarantee that users will want to have even that much data downloaded.
> We would need a way to say "yes, I ran 'git blame' on this path in my
> sparse-checkout, but please don't just fail if you can't get new objects,
> instead inform me that the results are incomplete."
>
> I think the sparse-checkout boundary is a good way to minimize the
> number of objects downloaded by these commands, but to actually
> remove the need for downloads at all we need a way to gracefully
> return partial results.

There may be some merits to a partial clone with shallow blob history,
but I've never really been all that interested in it.  I know that
partial clones only really implement that kind of feature, but I've
always wanted a full-depth sparse clone instead.  I tried to create
that alternate reality[H], but didn't get the time to push it very
far, and in the meantime others came along and implemented both
shallow clones and partial clones.  I still want my thing, but at this
point rather than introduce a new kind of clone, it makes more sense
for me to reuse the existing partial clone framework and extend it --
especially since it more gracefully handles cases where additional
data outside user-specified sparsity is needed (such as for merges).

[H] https://lore.kernel.org/git/1283645647-1891-1-git-send-email-newren@gmail.com/

But you've got me curious.  You seem to be suggesting that partial
results are okay if the user is informed.  I have suggested making
diff-with-revisions, log -p, etc. show a warning that results may be
incomplete when restricting them to the sparse checkout based on
config.  So, aren't you suggesting that my proposal is safe after all?

Anyway, if someone wants to implement something like you suggest here,
while I might not use it, it sounds reasonable to me.  It'd probably
fit in as yet another config setting.  Then, for history queries, our
config would select the default between --scope=all (for behavior B
folks), --scope=sparse (for the behavior A folks) and
--scope=sparse-and-already-downloaded (the behavior you suggest above,
though it probably needs a better name).  Also, it sounds to me like
implementing --scope=sparse would be a step along the path to
implementing what you are suggesting here, if I'm understanding you
correctly.  (Also, this idea makes me like your --scope= naming even
more, because it's awkward to add a third option to
--restrict/--no-restrict.)

> > I figured we'd have one or two places where all of us had some
> > disagreements on the big picture, but more and more I'm finding we
> > aren't even always thinking about the problems the same (e.g. the 3+
> > different solutions to the `am` issues).  All the more reason that a
> > document like this is important for us to discuss these details and
> > work out a plan.
>
> With such a massive doc and an ambitious plan, we are bound to have
> misunderstandings and seem to self-contradict here and there. This
> discussion is helping to drive clarity, and I appreciate all of your
> work to drive towards mutual understanding.

Thanks for taking the time to read through it and respond in detail!
