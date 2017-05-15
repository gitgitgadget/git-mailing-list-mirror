Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A5FA201A7
	for <e@80x24.org>; Mon, 15 May 2017 23:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbdEOXJX (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 19:09:23 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36461 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752197AbdEOXJW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 19:09:22 -0400
Received: by mail-pf0-f181.google.com with SMTP id m17so70242113pfg.3
        for <git@vger.kernel.org>; Mon, 15 May 2017 16:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qC3Cp5MzXrJ6R7AND5dSEkmSNQ+ckhE75CczK3PekQQ=;
        b=XMQJccZGuSHKVEgBL4zYrvSFE+DkzZmTj6TRE7zFzQykeS+mB62iuO6O7qe+jeaIcY
         Iip84IEN+P8cu2yeAhchgq8/AxCNNhf7EPZNd9zwWXWidNkIH4kI5CFxarx00/UML5OL
         YOw2gp+K2n2hSEopFadmkIG6YKG0iExVmBC5qqe+UEjbc2Gz0loRTvsjDIN1m8e341wJ
         Wd7C4dGnOoQvLZAnMxAEzwu+6wH/MG33AT0GVspZfhcPc8L23Q/MpkyghkGPJWmiFeXr
         8B+iZMzVvlUHHKs4TIUgtiXxb3/QSl2UqETKYg717NroPSozphRPXRpycaW8N+br30fS
         1Mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qC3Cp5MzXrJ6R7AND5dSEkmSNQ+ckhE75CczK3PekQQ=;
        b=pp1w0ayWURspExUoFZxg0b71Mp+qSTfic84HQwSmJris+keWnyoo0/TzHV4F8JpZ/7
         dmN0Y2feoESmJz9gebQZ323cO++i+DinnCx8nCK8ueZlQMRGvucw6vJn3Kzf+R3QZH5G
         Tc+fBo0xu79deoR78MhftANsdbe6pa5NbMmyuRKXlf9HnUNdIVDg3+5epVABlhtKca/H
         w/pydzEYfM2q0zbqneOLZZO5SJdymxa7vlPZhn1k+z88c5CsDXXtLz1dynK8W/RR4JOF
         OlBg96lfL+9tDf0TT3/CBmUvlzYRpJbSKlP3h8upfTEOIlgJWdli2P5jt7zGZ56ZVDsd
         CkSQ==
X-Gm-Message-State: AODbwcAjlENnw3/W91OFhzufKTGpr/Gnra1KO8habEnyhQYpm0GpLkFl
        sc1QE248tYRJyat9
X-Received: by 10.84.217.141 with SMTP id p13mr11479589pli.59.1494889761333;
        Mon, 15 May 2017 16:09:21 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:8923:f8dd:f0f0:f864])
        by smtp.gmail.com with ESMTPSA id s16sm22534623pgo.39.2017.05.15.16.09.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 16:09:20 -0700 (PDT)
Date:   Mon, 15 May 2017 16:09:19 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] pull: optionally rebase submodules
Message-ID: <20170515230919.GF79147@google.com>
References: <20170511172437.96878-1-bmwill@google.com>
 <CAGZ79kYYX_AMZm7Di8cUA_eiDS+SSAGnJyrDLcC5U7POk7WdSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYYX_AMZm7Di8cUA_eiDS+SSAGnJyrDLcC5U7POk7WdSw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/11, Stefan Beller wrote:
> On Thu, May 11, 2017 at 10:24 AM, Brandon Williams <bmwill@google.com> wrote:
> > Teach pull to optionally update submodules when '--recurse-submodules'
> > is provided.  This will teach pull to run 'submodule update --rebase'
> > when the '--recurse-submodules' and '--rebase' flags are given.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >
> > Pull is already a shortcut for running fetch followed by a merge/rebase, so why
> > not have it be a shortcut for running 'submodule update --rebase' when the
> > recurse flag is given!
> 
> I have not thought about the implications of this shortcut, as opposed to
> actually implementing it in C (which presumably would contain more checks).
> Will do.

Well this would be a short up until we actually implement recursion in
merge and rebase.  For rebase we may want to wait until its completely
ported to C since that effort is still underway.  Alternatively we can avoid
this shortcut and wait until rebase is finished being ported.

> 
> >
> >  builtin/pull.c            | 30 ++++++++++++++-
> >  t/t5572-pull-submodule.sh | 97 +++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 125 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin/pull.c b/builtin/pull.c
> > index dd1a4a94e..d73d654e6 100644
> > --- a/builtin/pull.c
> > +++ b/builtin/pull.c
> > @@ -77,6 +77,7 @@ static const char * const pull_usage[] = {
> >  /* Shared options */
> >  static int opt_verbosity;
> >  static char *opt_progress;
> > +static int recurse_submodules;
> >
> >  /* Options passed to git-merge or git-rebase */
> >  static enum rebase_type opt_rebase = -1;
> > @@ -532,6 +533,17 @@ static int pull_into_void(const struct object_id *merge_head,
> >         return 0;
> >  }
> >
> > +static int  update_submodules(void)
> 
> Maybe s/update_submodules/rebase_submodules/ ?
> 
> > +{
> > +       struct child_process cp = CHILD_PROCESS_INIT;
> > +       cp.git_cmd = 1;
> > +
> > +       argv_array_pushl(&cp.args, "submodule", "update", "--recursive", NULL);
> > +       argv_array_push(&cp.args, "--rebase");
> 
> The --rebase could be part of the _pushl ?
> Also we could set
>     no_stdin = 1
> we do need stdout/err though.

can do.

> 
> 
> > +
> > +       return run_command(&cp);
> > +}
> > +
> >  /**
> >   * Runs git-merge, returning its exit status.
> >   */
> > @@ -816,6 +828,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
> >                         oidclr(&rebase_fork_point);
> >         }
> >
> > +       if (opt_recurse_submodules &&
> > +           !strcmp(opt_recurse_submodules, "--recurse-submodules")) {
> 
> So this checks if we pass --recurse-submodules to fetch and if it is not
> a on-demand/no.
> Maybe we'd want to use the same infrastructure as fetch does, such that
> parse_fetch_recurse makes the decision. (Then "--recurse-submodules=TrUe"
> would work as well, IIUC)

Agreed, it may be better to actually parse the switch properly.

> 
> 
> > +               recurse_submodules = 1;
> > +
> > +               if (!opt_rebase)
> > +                       die(_("--recurse-submodules is only valid with --rebase"));
> 
> I wonder if there are existing users of "git pull --recurse --merge";
> as of now this would fetch the submodules (on-demand) and merge
> in the local commits of the superprojects. It sounds like a useful workflow
> which we'd be blocking here? Maybe just do nothing in case of !opt_rebase,
> i.e. make it part of the first condition added in this hunk?
> 
> > +               ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
> > +
> > +               if (!ret && recurse_submodules)
> > +                       ret = update_submodules();
> 
> Instead of doing the rebase of submodules here, we may just want to pass
> 'recurse_submodules' into run_rebase, which can do it, too. (It already has
> a 'ret' value, so the main cmd is not as cluttered.
> 
> ---
> Before reviewing the tests, let's step a bit back and talk about the design
> and what is useful to the user. From reading the code, we
>   1) perform a fetch in the superproject
>   2) rebase the superproject (not rewriting any submodule pointers,
>     but that may be ok for now)
>   3) sequentially:
>   3a) fetch each submodule on demand
>   3b) run rebase inside of it.
> 
> 
> (A) On the sequence:
> If in a normal pull --rebase we have a failure, we can fixup the failure
> and then continue via "git rebase --continue"; now if we have a failure
> in 3), we would need to fixup the submodule ourselves and then as
> we lost all progress in the superproject, rerun "pull --rebase --recurse"?

Yeah this may not have the best workflow...

> 
> (B)
> As discussed offline this produces bad results if we have a non-ff
> operation in the superproject, that also has submodule pointer updates.
> So additionally we would need to walk the superprojects local commits
> and check if any submodule is touched.
> 
> 
> >
> > +test_expect_success 'pull --recurse-submodule setup' '
> > +       git init child &&
> 
> test_create_repo child
> 
> > +       (
> > +               cd child &&
> > +               echo "bar" >file &&
> > +               git add file &&
> > +               git commit -m "initial commit"
> 
> test_create_commit -C child
> 
> > +       ) &&
> > +       git init parent &&
> > +       (
> > +               cd parent &&
> > +               echo "foo" >file &&
> > +               git add file &&
> > +               git commit -m "Initial commit" &&
> > +               git submodule add ../child sub &&
> > +               git commit -m "add submodule"
> > +       ) &&
> 
> Same setup comment as for the child
> 
> 
> > +       git clone --recurse-submodule parent super &&
> > +       git -C super/sub checkout master
> 
> I wonder if we want to keep these two commands in each test
> as I noticed some test scripts are horribly messy others have
> a pattern to cleanup after themselves:
> 
> test_expect_....
>     test_when_finished "rm -rf super-clone" &&
>     git clone ... into super-clone
> 
> 
> 
> > +'
> > +
> > +test_expect_success 'pull recursive fails without --rebase' '
> > +       test_must_fail git -C super pull --recurse-submodules 2>actual &&
> > +       test_i18ngrep "recurse-submodules is only valid with --rebase" actual
> > +'
> 
> Side note: another place to add tests could be t5520 or t740*.
> 
> > +test_expect_success 'pull rebase recursing fails with conflicts' '
> > +       git -C super/sub reset --hard HEAD^^ &&
> > +       git -C super reset --hard HEAD^ &&
> > +       (
> > +               cd super/sub &&
> > +               echo "b" >file &&
> > +               git add file &&
> > +               git commit -m "update file"
> > +       ) &&
> > +       test_must_fail git -C super pull --rebase --recurse-submodules
> 
> As discussed above: We'd also want to have a reasonable state here,
> or some advice to the user telling them how to recover. Maybe in a
> first approach we can tell them to re-run "submodule update --rebase"
> after fixing the conflict?
> 
> Thanks,
> Stefan

-- 
Brandon Williams
