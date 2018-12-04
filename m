Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35377211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 18:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbeLDSSI (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 13:18:08 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39844 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeLDSSH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 13:18:07 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so15928636itl.4
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 10:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F2WvuCVV4VDHhUVmCrajfuu1A8J7zTTXJBDQywd7ysA=;
        b=s1/6SQ+AcIFZJaZAfLsLfvF4De55prRJKC86tGFZwfpB3T+5Dwy3ex3QiLBqMVFU5Z
         ag49pC0PtB2ib8adI4I81EAzgwIhDqdIV72MEBMQUB+sm8YQhAEB+aFAFmBXoTVnkX4B
         dmRpFDgfIN8z8nxLpSPLTqnQklk9I4BuIpuSy359qHXTGkjzpGMgNzwcPn7EU0htBmsE
         x1dgNlMj2HUDDeUGHd7CgAMOK7ioxug+ob6kmoN5YrZWemdeRIIhpaD4Ueg+kLIfCOW2
         dnx+TQs2/huILeKyju7HC2/OyBB3c6/XuI9koq/Vz23aS4CMZjZjK3OTgPwQptrDVYs6
         YFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F2WvuCVV4VDHhUVmCrajfuu1A8J7zTTXJBDQywd7ysA=;
        b=UWXgcF0SutfW68dx6EqpFzY8DvIIddjhKrCK8uft4vHbJ+qYCJXcPClIw42oNf6JCw
         ZNK7UVK2xz5GgL22iK3IBzm0FNTYEqaE2TsPrAYmtQT9TDGSSnr65TGyLlSQuuTKnFRk
         H+ah+dr1Rv0Tyu2ZvUgN9uW7rCoT+0Vqs8VkNrruy009jkgmFo04Adfidy4EV0862MnW
         0BhHbuU8/45ChIvKNETIZ6ONYQ34xugW4iKUJc8wIapg7kT8sU8OM3JoQd73jWRiyMSU
         hh1nHPfTJ1mBasKMrbVzFBNFBBnYQcLVJIA0FnYC+omudckB8F26B5y0TOxDw/HpAret
         8XRw==
X-Gm-Message-State: AA+aEWaNO4jeCUYpoOiIVJCWKkzZAHN0jw9DX8CL7V2MjZ95hI5r3Rqv
        zTHeyVTFJe3MremBEWi0bCHRnte02KBWVlaxLRQ=
X-Google-Smtp-Source: AFSGD/XYb1Bs/bCftSj04Drnt/kY5cN3XEAMEpt72UKHY+8tA6XZIPcxRThl+j4c2UK6fZ+gRlOGuEaks2dfOw8244I=
X-Received: by 2002:a05:660c:81a:: with SMTP id j26mr12489449itk.70.1543947486278;
 Tue, 04 Dec 2018 10:18:06 -0800 (PST)
MIME-Version: 1.0
References: <20181127165211.24763-1-pclouds@gmail.com> <20181129215850.7278-1-pclouds@gmail.com>
 <20181129215850.7278-8-pclouds@gmail.com> <CABPp-BHQ68pkvO8yXYuy=0D6ne8u=5CUMDqiN0jtRrxCL55n2g@mail.gmail.com>
 <CACsJy8BTs+WKzTTEF2XVTT-LVJk_exYCz_hN+hXU1Dw+oquBpA@mail.gmail.com> <CABPp-BGRcaiiD-aks1kaLr7ATLQ_oGSyooQBDD+2acgerA+Phg@mail.gmail.com>
In-Reply-To: <CABPp-BGRcaiiD-aks1kaLr7ATLQ_oGSyooQBDD+2acgerA+Phg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 4 Dec 2018 19:17:39 +0100
Message-ID: <CACsJy8D9Rgsf-E6yweQxpopFaOVZ1bgihEbg200yS1gup+Gt7Q@mail.gmail.com>
Subject: Re: [PATCH v3 07/14] checkout: split into switch-branch and restore-files
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Stefan Xenos <sxenos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 4, 2018 at 6:43 PM Elijah Newren <newren@gmail.com> wrote:
> > > > +--ours::
> > > > +--theirs::
> > > > +       Check out stage #2 ('ours') or #3 ('theirs') for unmerged
> > > > +       paths.
> > > > ++
> > > > +Note that during `git rebase` and `git pull --rebase`, 'ours' and
> > > > +'theirs' may appear swapped; `--ours` gives the version from the
> > > > +branch the changes are rebased onto, while `--theirs` gives the
> > > > +version from the branch that holds your work that is being rebased.
> > > > ++
> > > > +This is because `rebase` is used in a workflow that treats the
> > > > +history at the remote as the shared canonical one, and treats the
> > > > +work done on the branch you are rebasing as the third-party work to
> > > > +be integrated, and you are temporarily assuming the role of the
> > > > +keeper of the canonical history during the rebase.  As the keeper of
> > > > +the canonical history, you need to view the history from the remote
> > > > +as `ours` (i.e. "our shared canonical history"), while what you did
> > > > +on your side branch as `theirs` (i.e. "one contributor's work on top
> > > > +of it").
> > >
> > > Total aside because I'm not sure what you could change here, but man
> > > do I hate this.
> >
> > Uh it's actually documented? I'm always confused by this too. --ours
> > and --theirs at this point are pretty much tied to stage 2 and 3.
> > Nothing I can do about it. But if you could come up with some other
> > option names, then we could make "new ours" to be stage 3 during
> > rebase, for example.
>
> I don't think it's a naming issue, personally.  Years ago we could
> have defined --ours and --theirs differently based on which kind of
> operation we were in the middle of, but you are probably right that
> they are now tied to stage 2 and 3.  But there's another place that we
> might still be able to address this; I think the brain-damage here may
> have just been due to the fact that the recursive merge machinery was
> rather inflexible and required HEAD to be stage 2.  If it were a
> little more flexible, then we might just be able to make this problem
> go away.  Maybe it can still be fixed (I haven't dug too deeply into
> it), but if so, the only fix needed here would be to remove this long
> explanation about why the tool gets things totally backward.

Aha. I' not really deep in this merge business to know if stages 2 and
3 can be swapped. This is right up your alley. I'll just leave it to
you.

> > > > +'git switch-branch' -c|-C <new_branch> [<start_point>]::
> > > > +
> > > > +       Specifying `-c` causes a new branch to be created as if
> > > > +       linkgit:git-branch[1] were called and then switched to. In
> > > > +       this case you can use the `--track` or `--no-track` options,
> > > > +       which will be passed to 'git branch'.  As a convenience,
> > > > +       `--track` without `-c` implies branch creation; see the
> > > > +       description of `--track` below.
> > >
> > > Can we get rid of --track/--no-track and just provide a flag (which
> > > takes no arguments) for the user to use?  Problems with --track:
> > >   * it's not even in your synopsis
> > >   * user has to repeat themselves (e.g. 'next' in two places from '-c
> > > next --track origin/next'); this repetition is BOTH laborious AND
> > > error-prone
> > >   * it's rather inconsistent: --track is the default due to
> > > auto-vivify when the user specifies nothing but a branch name that
> > > doesn't exist yet, but when the user realizes the branch doesn't exist
> > > yet and asks to have it created then suddenly tracking is not the
> > > default??
> >
> > I don't think --track is default anymore (maybe I haven't updated the
> > man page correctly). The dwim behavior is only activated in
> > switch-branch when you specify --guess to reduce the amount of magic
> > we throw at the user. With that in mind, do we still hide
> > --track/--no-track from switch-branch?
>
> Ooh, you're adding --guess?  Cool, that addresses my concerns, just in
> a different manner.

No it's always there even in git-checkout, just hidden.

> Personally, I'd leave --track/--no-track out.  It's extra mental
> overhead, git branch has options for setting those if they need some
> special non-default setup, and if there is enough demand for it we can
> add it later.  Removing options once published is much harder.

Slightly less convenient (you would need a combination of git-branch
and git-switch-branch, if you avoid git-checkout). But since I don't
think I have ever used this option, I'm fine with leaving it out and
considering adding it back later.

> > > I'm not sure what's best, but here's some food for thought:
> > >
> > >
> > >    git switch-branch <branch>
> > > switches to <branch>, if it exists.  Error cases:
> > >   * If <branch> isn't actually a branch but a <tag> or
> > > <remote-tracking-branch> or <revision>, error out and suggest using
> > > --detach.
> > >   * If <branch> isn't actually a branch but there is a similarly named
> > > <remote-tracking-branch> (e.g. origin/<branch>), then suggest using
> > > -c.
> >
> > I would make these advice so I can hide them. Or if I manage to make
> > all these hints one line then I'll make it unconditional.
> >
> > >   git switch-branch -c <branch>
> > > creates <branch> and, if a relevant-remote-tracking branch exists,
> > > base the branch on that revision and set the new branch up to track
> >
> > Hmm.. this is a bit magical and could be surprising. If I create (and
> > switch to) a new branch foo, I don't necessarily mean tracking
> > origin/foo (I may not even think about origin/foo when I type the
> > command). So tentatively no.
>
> Yeah, if you're adding --guess then I'm happy.  I do think, though,
> that if the user runs switch-branch to a branch that doesn't exist, we
> should check if there is an associated remote-tracking branch so that
> we can provide a better error message and help users learn about
> --guess.  (Also, will there be a short -g form?)

Yeah better error and suggestion is a good idea. And yes the short
form -g is already added (I did try to use it and find --guess too
time consuming even with bash completion support).

> > > > +-f::
> > > > +--force::
> > > > +       Proceed even if the index or the working tree differs from
> > > > +       HEAD.  This is used to throw away local changes.
> > >
> > > Haven't thought through this thoroughly, but do we really need an
> > > option for that instead of telling users to 'git reset --hard HEAD'
> > > before switching branches if they want their stuff thrown away?
> >
> > For me it's just a bit more convenient. Hit an error when switching
> > branch? Recall the command from bash history, stick -f in it and run.
> > Elsewhere I think both Junio and Thomas (or maybe only Junio) suggests
> > moving the "git reset" functionality without moving HEAD to one of
> > these commands, which goes the opposite direction...
>
> Fair enough.

I'm actually still not sure how to move it here (I guess 'here' is
restore-files since we won't move HEAD). All the --mixed, --merge and
--hard are confusing. But maybe we could just make 'git restore-files
--from HEAD -f :/" behave just like "git reset --hard HEAD" (but with
some safety net) But we can leave it for discussion in the next round.

> > > > +--orphan <new_branch>::
> > > > +       Create a new 'orphan' branch, named <new_branch>, started from
> > > > +       <start_point> and switch to it.  The first commit made on this
> > >
> > > What??  started from <start_point>?  The whole point of --orphan is
> > > you have no parent, i.e. no start point.  Also, why does the
> > > explanation reference an argument that wasn't in the immediately
> > > preceding synopsis?
> >
> > I guess bad phrasing. It should be "switch to <start_point> first,
> > then prepare the worktree so that the first commit will have no
> > parent". Or something along that line.
> >
> > You should really review git-checkout.txt btw ;-)
>
> I did after writing several of these comments, and yeah, it really
> needs a clean up.  Seems like something someone would do when writing
> a (partial) replacement or simplified alternative.  ;-)

Heh ;-) Fine I'll do it. I have to read and re-read git-checkout.txt
anyway and already queued up a couple small fixes.

> > > > +       new branch will have no parents and it will be the root of a new
> > > > +       history totally disconnected from all the other branches and
> > > > +       commits.
> > > > ++
> > > > +The index and the working tree are adjusted as if you had previously run
> > > > +"git checkout <start_point>".  This allows you to start a new history
> > > > +that records a set of paths similar to <start_point> by easily running
> > > > +"git commit -a" to make the root commit.
> > > > ++
> > > > +This can be useful when you want to publish the tree from a commit
> > > > +without exposing its full history. You might want to do this to publish
> > > > +an open source branch of a project whose current tree is "clean", but
> > > > +whose full history contains proprietary or otherwise encumbered bits of
> > > > +code.
> > > > ++
> > > > +If you want to start a disconnected history that records a set of paths
> > > > +that is totally different from the one of <start_point>, then you should
> > > > +clear the index and the working tree right after creating the orphan
> > > > +branch by running "git rm -rf ." from the top level of the working tree.
> > > > +Afterwards you will be ready to prepare your new files, repopulating the
> > > > +working tree, by copying them from elsewhere, extracting a tarball, etc.
> > >
> > > Ick.  Seems overly complex.  I'd rather that --orphan defaulted to
> > > clearing the index and working tree, and that one would need to pass
> > > HEAD for <start_point> if you wanted to start out with all those other
> > > files.  That would certainly make the explanation a little clearer to
> > > users, and more natural when they start experimenting with it.
> > >
> > > However, --orphan is pretty special case.  Do we perhaps want to leave
> > > it out of this new command and only include it in checkout?
> >
> > I started this by simply splitting git-checkout in two commands that,
> > combined, can do everything git-checkout can. Then suggestions to have
> > better default came in and I think we started to drift further to
> > _removing_ options and falling back to git-checkout.
> >
> > I think we could still keep "complicated" options as long as they are
> > clearly described and don't surprise users until they figure them out.
> > That way I don't have to go back to git-checkout and deal with all the
> > ambiguation it creates.
>
> Fair enough...though I think it may make sense to also review the
> complicated options and determine if they are overly complicated.  I
> think --orphan qualifies (I stumbled with it a bit for years the
> occasional time I needed to use it), and my small suggestion above
> would simplify both it and its description.  We should probably also
> consider just removing <start_point> as an acceptable argument to
> --orphan; if people want files from some revision after creating an
> orphan branch that's a simple extra command.

It is good that you pointed it out though. I still have to digest this
option before I make more comments, but generally if there's a simpler
(even if new) way to achieve the same thing, I'm all for it.
-- 
Duy
