Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A738520254
	for <e@80x24.org>; Mon, 27 Feb 2017 22:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbdB0Wfn (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 17:35:43 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33218 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbdB0Wfk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 17:35:40 -0500
Received: by mail-pg0-f47.google.com with SMTP id 25so19742013pgy.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 14:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8IP3kGXqFZ9HN6Nf3Ll1qILahJ1V71EvnnPc58wY7Ss=;
        b=a6ZG0u7aEgEGhCdqSggU0qC8wkEV/WqP92JN6WwcVqkBnLC4r+iWweTdWu+iSkqcXx
         QTQDMD2mjXROtSIoeaZ3BivsH8NHOTjtaQgsojGO3lqx86Zn9lfEs4jKgknswqG7sfwb
         PQZ6kFFYdnCvnECldEjwpOJAJf0X0rBjC8uQ0cubQldRjkA9//+QM41sf5kqQXkfC6T2
         bGVYWw1pvbuxlhkdoMpPf1TxQ+FDj4hmUXWoOIWRN+vhqZSd3jlAWmz1H5q90cJMQNul
         q7cr+FxGgESuhPtBBIy23DVzg5jLYhSVdfLCsaFGMEiX0GE6V+x1vLhpVwfRTvZkSzjU
         BxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8IP3kGXqFZ9HN6Nf3Ll1qILahJ1V71EvnnPc58wY7Ss=;
        b=OCTdOVMnmg2SQQHF4nRVc0zntQYyuJ9NH96QGW2dEZHm3SYASJ0ZgESdWUJY8apU0I
         CVcier+qqKgkPNOdhfTXaJxqFk+z260ndojJDUhAVQWwIQR2qDCqAl47tHqbn2k0wt2/
         ZfER6bL2m1DtwAvtN8SQB3eLvbNjgND18ujyHAv2WtKOUmVqAbjVsnmsOdQIpH6lgKC4
         rT14D83EgZVQyKyYB4H/7nSQDVTuh3MMJUDaWRXilyO9uicDgw0FojGr5OnRiK9WMu3P
         YjeQDfyqA0NXo00IPolFhX05Cx0wA0scU+9QqpgfJIamkKiMClGXcly3lftkI2uNfj+3
         Ltsg==
X-Gm-Message-State: AMke39k09utcwrvFMfIPKYIwBaLX42VHnCXcF4bD8Z03LJ8ndcLJWsnh07JKwMvtdrWSEP9O
X-Received: by 10.84.197.1 with SMTP id m1mr26403913pld.123.1488220539032;
        Mon, 27 Feb 2017 10:35:39 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:5d0b:b83e:e4b4:f20d])
        by smtp.gmail.com with ESMTPSA id p6sm32198652pgn.40.2017.02.27.10.35.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:35:37 -0800 (PST)
Date:   Mon, 27 Feb 2017 10:35:36 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 05/10] submodule--helper: add is_active command
Message-ID: <20170227183536.GD153455@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
 <20170223234728.164111-6-bmwill@google.com>
 <CAGZ79kZKH_e2NLd=A=og452f-1bfFcSoi5=SM5oetu87TT766Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZKH_e2NLd=A=og452f-1bfFcSoi5=SM5oetu87TT766Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/23, Stefan Beller wrote:
> On Thu, Feb 23, 2017 at 3:47 PM, Brandon Williams <bmwill@google.com> wrote:
> > There are a lot of places where an explicit check for
> > submodule."<name>".url is done to see if a submodule exists.  In order
> > to more easily facilitate the use of the submodule.active config option
> > to indicate active submodules, add a helper which can be used to query
> > if a submodule is active or not.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  builtin/submodule--helper.c    | 11 ++++++++
> >  t/t7413-submodule-is-active.sh | 63 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 74 insertions(+)
> >  create mode 100755 t/t7413-submodule-is-active.sh
> >
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index df0d9c166..dac02604d 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -1128,6 +1128,16 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
> >         return 0;
> >  }
> >
> > +static int is_active(int argc, const char **argv, const char *prefix)
> > +{
> > +       if (argc != 2)
> > +               die("submodule--helper is-active takes exactly 1 arguments");
> > +
> > +       gitmodules_config();
> > +
> > +       return !is_submodule_initialized(argv[1]);
> > +}
> > +
> >  #define SUPPORT_SUPER_PREFIX (1<<0)
> >
> >  struct cmd_struct {
> > @@ -1147,6 +1157,7 @@ static struct cmd_struct commands[] = {
> >         {"init", module_init, 0},
> >         {"remote-branch", resolve_remote_submodule_branch, 0},
> >         {"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
> > +       {"is-active", is_active, 0},
> >  };
> >
> >  int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
> > diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
> > new file mode 100755
> > index 000000000..683487020
> > --- /dev/null
> > +++ b/t/t7413-submodule-is-active.sh
> > @@ -0,0 +1,63 @@
> > +#!/bin/sh
> > +
> > +test_description='Test submodule--helper is-active
> > +
> > +This test verifies that `git submodue--helper is-active` correclty identifies
> > +submodules which are "active" and interesting to the user.
> > +'
> > +
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'setup' '
> > +       git init sub &&
> > +       test_commit -C sub initial &&
> > +       git init super &&
> > +       test_commit -C super initial &&
> > +       git -C super submodule add ../sub sub1 &&
> > +       git -C super submodule add ../sub sub2 &&
> > +       git -C super commit -a -m "add 2 submodules at sub{1,2}"
> > +'
> > +
> > +test_expect_success 'is-active works with urls' '
> > +       git -C super submodule--helper is-active sub1 &&
> > +       git -C super submodule--helper is-active sub2 &&
> > +
> > +       git -C super config --unset submodule.sub1.URL &&
> > +       test_must_fail git -C super submodule--helper is-active sub1 &&
> > +       git -C super config submodule.sub1.URL ../sub &&
> > +       git -C super submodule--helper is-active sub1
> > +'
> > +
> > +test_expect_success 'is-active works with basic submodule.active config' '
> > +       git -C super config --add submodule.active "." &&
> > +       git -C super config --unset submodule.sub1.URL &&
> > +       git -C super config --unset submodule.sub2.URL &&
> 
> I think we'd want to unset only one of them here
> 
> > +
> > +       git -C super submodule--helper is-active sub1 &&
> > +       git -C super submodule--helper is-active sub2 &&
> 
> to test 2 different cases of one being active by config setting only and
> the other having both.

Will do.

> 
> I could not spot test for having the URL set but the config setting set, not
> including the submodule, e.g.
> 
>     git -C super config  submodule.sub1.URL ../sub &&
>     git -C super submodule.active  ":(exclude)sub1" &&
> 
> which would be expected to not be active, as once the configuration
> is there it takes precedence over any (no)URL setting?

The last test, tests this functionality as the URL settings for both
sub1 and sub2 are in the config.  You'll notice in the tests where I
unset the URL config, that they get added back at the end of the test so
that future tests have a clean state to work with.

-- 
Brandon Williams
