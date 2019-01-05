Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5932F1F6A9
	for <e@80x24.org>; Sat,  5 Jan 2019 16:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfAEQ5s (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Jan 2019 11:57:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35647 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfAEQ5s (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jan 2019 11:57:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so3830595wmt.0
        for <git@vger.kernel.org>; Sat, 05 Jan 2019 08:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3PPt4nSKYr/VAWkyOTYHVoZhgzSvJsSp2w2Y8O71yg=;
        b=HWUgrQOptGqYo8s0ouUUWoy8+7wnCUffsaJfscVggEuLn9zlhuyXfg/5rwzGWcWhLJ
         Z2e2pmo1WEBouuBtfxBmL/nhPOEPNOoGniOs4qtgtw6UVzbW5o6grzBsI1bKGfmsuNX4
         ZmFv7WbKrKkZWGAIggQNcPimyWTEYo2XbF/wcmcun0Atu9nqs1ORvIKYL9q2aljKItPO
         Wu8oUlsb6dvJwzR9jpj+HpO/P6jvegImS8sU00VcK5mwgiaeacPHgjibO1/KLYatPko1
         T7nEYYrYp2FH/TuJcAPSwgYuLWytBiKtCiosvqLBS+wI8Q1IKiYn+mE6XWh5QPHCCh2w
         8hZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3PPt4nSKYr/VAWkyOTYHVoZhgzSvJsSp2w2Y8O71yg=;
        b=CKM5HvCnHg51DLQzjvMu/XRnqaALNMwskBJHL/VteGDQydARbP9Zhoxsmhrt0lD8ss
         QORyPzi9wwanqu14LDcQT1sZdMCRcriOMyT4zjdF47eeTDkM//XwtGya1VXtHkLlmFKI
         5q7c9fD1Jh/qnCVLaD9MzLp2GDY1NBp07WpVo2fnF49P1xcOVGxYPyBoPZl4jXO0AriN
         cWEzgAWw+SoEN5lf+Vzdm4kPjkzZarz1Shjx7K/6NV7fiU/83ZOyU+ZFe+XoEduzIr00
         UGYjfOms/pWUOj3ldKxam4MI/OZpoQjX9IJ6bEW4zjkip353AABdRw4dmP3B4EQ0JID5
         89lQ==
X-Gm-Message-State: AJcUukezQ8VIGVf+Z8nApNTnJXFKCQ1AMpNOtCoafKPZ/xPXWCcTVNFg
        vzNHGITQtxKM1a/kCy76C7lbeUpjJYT+IBqNO6M=
X-Google-Smtp-Source: ALg8bN5vrgGmbPaZ2WzmK0RK2zY3r9IF31ceCeV3/3N7y2cLHQhxRBfNFZtcL7pF5/2GfonF3c82Zb5vf4dWOapSL+Y=
X-Received: by 2002:a7b:cb18:: with SMTP id u24mr4178136wmj.138.1546707464526;
 Sat, 05 Jan 2019 08:57:44 -0800 (PST)
MIME-Version: 1.0
References: <1544922308-740-1-git-send-email-eedahlgren@gmail.com>
 <1545953789-15040-1-git-send-email-eedahlgren@gmail.com> <20190103051432.GE20047@sigill.intra.peff.net>
 <xmqqy381haup.fsf@gitster-ct.c.googlers.com> <20190104082558.GB26014@sigill.intra.peff.net>
In-Reply-To: <20190104082558.GB26014@sigill.intra.peff.net>
From:   Erin Dahlgren <eedahlgren@gmail.com>
Date:   Sat, 5 Jan 2019 08:57:32 -0800
Message-ID: <CAP_Smy0Phh83XW-m0_cGg6WuLpDySshP7Ys2OrD8no1hJzohpg@mail.gmail.com>
Subject: Re: [PATCH v3] Simplify handling of setup_git_directory_gently()
 failure cases.
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 4, 2019 at 12:26 AM Jeff King <peff@peff.net> wrote:
>
> On Thu, Jan 03, 2019 at 10:09:18AM -0800, Junio C Hamano wrote:
>
> > >> @@ -1132,7 +1142,10 @@ const char *setup_git_directory_gently(int *nongit_ok)
> > >>     * the user has set GIT_DIR.  It may be beneficial to disallow bogus
> > >>     * GIT_DIR values at some point in the future.
> > >>     */
> > >> -  if (startup_info->have_repository || getenv(GIT_DIR_ENVIRONMENT)) {
> > >> +  if (// GIT_DIR_EXPLICIT, GIT_DIR_DISCOVERED, GIT_DIR_BARE
> > >> +      startup_info->have_repository ||
> > >> +      // GIT_DIR_EXPLICIT
> > >> +      getenv(GIT_DIR_ENVIRONMENT)) {
> > >
> > > Same "//" style issue as above. I'm not sure how much value there is in
> > > repeating the GIT_DIR_* cases here, as they're likely to grow out of
> > > sync with the switch() statement above.
> >
> > It is unclear to me if the original code is doing the right thing
> > under one condition, and this patch does not seem to change the
> > behaviour.
> >
> > What happens if GIT_DIR environment is set to an invalid path and
> > nongit_ok is non-NULL?  setup_explicit_git_dir() would have assigned
> > 1 to *nongit_ok, so have_repository is false at this point.
> >
> > We enter the if() statement in such a case, and end up calling
> > setup_git_env(gitdir) using the bogus path that is not pointing at a
> > repository.  We leave have_repository to be false but the paths
> > recorded in the_repository by setup_git_env() would all point at
> > bogus places.
>
> Yeah, that matches my analysis of what the code is doing.
>
> Looks like this code (and comment) come from 73f192c991 (setup: don't
> perform lazy initialization of repository state, 2017-06-20). I'm
> guessing this was mostly a hack to quiet some test that complained about
> the other changes in that commit. And indeed, dropping the getenv() half
> of the conditional and running the tests in 73f192c991 gets me a failure
> in t1050, which does:
>
>   GIT_DIR=non-existent git index-pack --strict --verify foo/.git/objects/pack/*.pack
>
> But that's a bug in index-pack, which should be able to verify a pack
> outside of a repository. And I think (according to bisection) we fixed
> that in 14a9bd2898 (prepare_commit_graft: treat non-repository as a
> noop, 2018-05-31), and the tests currently pass even with this patch
> applied:
>
> diff --git a/setup.c b/setup.c
> index 1be5037f12..e2c03e9bbc 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1132,7 +1132,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
>          * the user has set GIT_DIR.  It may be beneficial to disallow bogus
>          * GIT_DIR values at some point in the future.
>          */
> -       if (startup_info->have_repository || getenv(GIT_DIR_ENVIRONMENT)) {
> +       if (startup_info->have_repository) {
>                 if (!the_repository->gitdir) {
>                         const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
>                         if (!gitdir)
>
> > > At first I thought this could all be folded into the "else" clause of
> > > the conditional above (which would make the logic much easier to
> > > follow), but that wouldn't cover the case of GIT_DIR=/bogus, which is
> > > what that getenv() is trying to handle here.
> >
> > Yes, but should GIT_DIR=/bogus even be touching the_repository?
>
> Probably not. And from my poking around above, I think we're probably
> safe to remove this hackery now.
>
> > It is a separate clean-up and does not affect the validity of this
> > simplification patchd, so I agreee with ...
> >
> > > So I think this is the best we can do for now.
>
> Yep, it's definitely orthogonal. But if we do this cleanup as part of
> it, we should be able to simplify further on top of Erin's patch, like
> this:
>
> diff --git a/setup.c b/setup.c
> index eb8332bc02..edf65c44bf 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1125,35 +1125,26 @@ const char *setup_git_directory_gently(int *nongit_ok)
>                 // !nongit_ok || !*nongit_ok
>                 startup_info->have_repository = 1;
>                 startup_info->prefix = prefix;
> +
>                 if (prefix)
>                         setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
>                 else
>                         setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
> -       }
>
> -       /*
> -        * Not all paths through the setup code will call 'set_git_dir()' (which
> -        * directly sets up the environment) so in order to guarantee that the
> -        * environment is in a consistent state after setup, explicitly setup
> -        * the environment if we have a repository.
> -        *
> -        * NEEDSWORK: currently we allow bogus GIT_DIR values to be set in some
> -        * code paths so we also need to explicitly setup the environment if
> -        * the user has set GIT_DIR.  It may be beneficial to disallow bogus
> -        * GIT_DIR values at some point in the future.
> -        */
> -       if (// GIT_DIR_EXPLICIT, GIT_DIR_DISCOVERED, GIT_DIR_BARE
> -           startup_info->have_repository ||
> -           // GIT_DIR_EXPLICIT
> -           getenv(GIT_DIR_ENVIRONMENT)) {
> +               /*
> +                * Not all paths through the setup code will call 'set_git_dir()' (which
> +                * directly sets up the environment) so in order to guarantee that the
> +                * environment is in a consistent state after setup, explicitly setup
> +                * the environment if we have a repository.
> +                */
>                 if (!the_repository->gitdir) {
>                         const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
>                         if (!gitdir)
>                                 gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
>                         setup_git_env(gitdir);
>                 }
> -               if (startup_info->have_repository)
> -                       repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
> +
> +               repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
>         }
>
>         strbuf_release(&dir);
>
> I actually wonder if the "not all paths..." bit is even still true these
> days (and if it is, I think we should consider fixing those code paths).
> Certainly that setup_git_env() needed to trigger for the GIT_DIR=bogus,
> but with that gone, any $GIT_DIR should have triggered GIT_DIR_EXPLICIT,
> and any "default to .git" should be handled as part of discovery, I'd
> think.
>
> So what next? Erin, are you interested in using the details of this
> conversation to take the cleanups a bit further?

Sure, no problem. If this is urgent, then I would probably be more
inclined to keep this small and do more cleanup in followup patches.
But if it's not urgent (that is my understanding), I'd be happy to
take the cleanups further. I'm traveling today through next week but
I'll try to post another version addressing the comments in the next
couple of days.

Thanks all for the comments so far.

- Erin

> If not, then I can try to prepare a few patches on top of yours.
>
> -Peff
