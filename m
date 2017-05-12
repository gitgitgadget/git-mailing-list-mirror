Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A9E71FF34
	for <e@80x24.org>; Fri, 12 May 2017 17:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758245AbdELRbf (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 13:31:35 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33984 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756241AbdELRam (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 13:30:42 -0400
Received: by mail-pg0-f45.google.com with SMTP id u28so33244230pgn.1
        for <git@vger.kernel.org>; Fri, 12 May 2017 10:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fAWl8DnH2MeqIh23KZUpJ8rTNmqUqWUKv3T0h1cYJ7Y=;
        b=uJqZeB6Gt/FKUwqxjRpu4pVjAoOZiFKJpvtMbmyOXKQkbYzZBbZp9EADDzGtG7EH/K
         gsfwjKcHLSM3DEBg/DcrmXJ3D9jXQ+gfOd1Ur8ll57JZYWQKBKzeXI2u+ozCWA4n/F4E
         qIZtKNwpRcP95Oh9iADxW1R76G3tvaMWZtmm6P6N2nbK8sXQptswyd+9onKbUeV9AViE
         iUucuEEMIpoUsfA9yw2u0FHhYrmG7nC6XCRpliNAr47FGaYQJJIuGZ2bUWe0xRXCgVq5
         Hpqk1V2ewCf3NsgsAt0g3SqbRKMIhfJlK2/MZEtlW2lzIMeV8Z+BErRtFbXpr4yEpGOx
         wI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fAWl8DnH2MeqIh23KZUpJ8rTNmqUqWUKv3T0h1cYJ7Y=;
        b=t2s0DJAyic/HsU2bxG6kl9PO2FlgpvdkqzqG79YSP4lHcP26+Qys7c8ZUQQqerc5Qk
         YswjUZv1p6mGWeWSds6NdUAi35h8avt8tn4UClOgJq0hlxI9/H7Xf0uzyf3oU7J1e6T4
         39tTM328vQgRcmBmpJcHBcyEd6Mo5p+YUyDx7o/zYnscxGRwejcD9fH6gxqTERIPE633
         +RTBmXmVWY4NYP+wivM+z+s/Wx05Z4C82cG0huk5zOKaSvI6tcQD376dwn+5PIOZG/uR
         1N7y9PcrAVOkQGtQlyCnypFlWlGw3kC7CdG4S0DFvTiaadBezSb/fjTGJf3sg8U4JPn2
         0RyQ==
X-Gm-Message-State: AODbwcDk+978dLL/bwYeEgSALmehH0RLwoR2e2TThTwTXL8Xz5Ry0gc1
        HGaB5y+cs1irogVz
X-Received: by 10.99.148.17 with SMTP id m17mr5526864pge.187.1494610241945;
        Fri, 12 May 2017 10:30:41 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c4e0:75e9:f5fc:bc05])
        by smtp.gmail.com with ESMTPSA id 20sm8622612pfq.42.2017.05.12.10.30.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 May 2017 10:30:40 -0700 (PDT)
Date:   Fri, 12 May 2017 10:30:39 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH] pull: optionally rebase submodules
Message-ID: <20170512173039.GC98586@google.com>
References: <20170511172437.96878-1-bmwill@google.com>
 <702FD1AB212642BA80B1ADF27D75916B@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <702FD1AB212642BA80B1ADF27D75916B@PhilipOakley>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/11, Philip Oakley wrote:
> From: "Brandon Williams" <bmwill@google.com>
> >Teach pull to optionally update submodules when '--recurse-submodules'
> >is provided.  This will teach pull to run 'submodule update --rebase'
> >when the '--recurse-submodules' and '--rebase' flags are given.
> >
> >Signed-off-by: Brandon Williams <bmwill@google.com>
> >---
> >
> >Pull is already a shortcut for running fetch followed by a
> >merge/rebase, so why
> >not have it be a shortcut for running 'submodule update --rebase' when the
> >recurse flag is given!
> >
> >builtin/pull.c            | 30 ++++++++++++++-
> >t/t5572-pull-submodule.sh | 97
> >+++++++++++++++++++++++++++++++++++++++++++++++
> 
> Shouldn't this also touch the documentation to say that this has
> been taught?

Yes it should, thanks for reminding me!

> --
> Philip
> 
> 
> >2 files changed, 125 insertions(+), 2 deletions(-)
> >
> >diff --git a/builtin/pull.c b/builtin/pull.c
> >index dd1a4a94e..d73d654e6 100644
> >--- a/builtin/pull.c
> >+++ b/builtin/pull.c
> >@@ -77,6 +77,7 @@ static const char * const pull_usage[] = {
> >/* Shared options */
> >static int opt_verbosity;
> >static char *opt_progress;
> >+static int recurse_submodules;
> >
> >/* Options passed to git-merge or git-rebase */
> >static enum rebase_type opt_rebase = -1;
> >@@ -532,6 +533,17 @@ static int pull_into_void(const struct
> >object_id *merge_head,
> > return 0;
> >}
> >
> >+static int  update_submodules(void)
> >+{
> >+ struct child_process cp = CHILD_PROCESS_INIT;
> >+ cp.git_cmd = 1;
> >+
> >+ argv_array_pushl(&cp.args, "submodule", "update", "--recursive", NULL);
> >+ argv_array_push(&cp.args, "--rebase");
> >+
> >+ return run_command(&cp);
> >+}
> >+
> >/**
> > * Runs git-merge, returning its exit status.
> > */
> >@@ -816,6 +828,14 @@ int cmd_pull(int argc, const char **argv,
> >const char *prefix)
> > oidclr(&rebase_fork_point);
> > }
> >
> >+ if (opt_recurse_submodules &&
> >+     !strcmp(opt_recurse_submodules, "--recurse-submodules")) {
> >+ recurse_submodules = 1;
> >+
> >+ if (!opt_rebase)
> >+ die(_("--recurse-submodules is only valid with --rebase"));
> >+ }
> >+
> > if (run_fetch(repo, refspecs))
> > return 1;
> >
> >@@ -862,6 +882,7 @@ int cmd_pull(int argc, const char **argv,
> >const char *prefix)
> > die(_("Cannot rebase onto multiple branches."));
> >
> > if (opt_rebase) {
> >+ int ret = 0;
> > struct commit_list *list = NULL;
> > struct commit *merge_head, *head;
> >
> >@@ -871,9 +892,14 @@ int cmd_pull(int argc, const char **argv,
> >const char *prefix)
> > if (is_descendant_of(merge_head, list)) {
> > /* we can fast-forward this without invoking rebase */
> > opt_ff = "--ff-only";
> >- return run_merge();
> >+ ret = run_merge();
> > }
> >- return run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
> >+ ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
> >+
> >+ if (!ret && recurse_submodules)
> >+ ret = update_submodules();
> >+
> >+ return ret;
> > } else {
> > return run_merge();
> > }
> >diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
> >index accfa5cc0..234a22315 100755
> >--- a/t/t5572-pull-submodule.sh
> >+++ b/t/t5572-pull-submodule.sh
> >@@ -42,4 +42,101 @@
> >KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
> >KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
> >test_submodule_switch "git_pull_noff"
> >
> >+test_expect_success 'pull --recurse-submodule setup' '
> >+ git init child &&
> >+ (
> >+ cd child &&
> >+ echo "bar" >file &&
> >+ git add file &&
> >+ git commit -m "initial commit"
> >+ ) &&
> >+ git init parent &&
> >+ (
> >+ cd parent &&
> >+ echo "foo" >file &&
> >+ git add file &&
> >+ git commit -m "Initial commit" &&
> >+ git submodule add ../child sub &&
> >+ git commit -m "add submodule"
> >+ ) &&
> >+ git clone --recurse-submodule parent super &&
> >+ git -C super/sub checkout master
> >+'
> >+
> >+test_expect_success 'pull recursive fails without --rebase' '
> >+ test_must_fail git -C super pull --recurse-submodules 2>actual &&
> >+ test_i18ngrep "recurse-submodules is only valid with --rebase" actual
> >+'
> >+
> >+test_expect_success 'pull basic recurse' '
> >+ (
> >+ cd child &&
> >+ echo "foobar" >>file &&
> >+ git add file &&
> >+ git commit -m "update file"
> >+ ) &&
> >+ (
> >+ cd parent &&
> >+ git -C sub pull &&
> >+ git add sub &&
> >+ git commit -m "update submodule"
> >+ ) &&
> >+
> >+ git -C parent rev-parse master >expect_super &&
> >+ git -C child rev-parse master >expect_sub &&
> >+
> >+ git -C super pull --rebase --recurse-submodules &&
> >+ git -C super rev-parse master >actual_super &&
> >+ git -C super/sub rev-parse master >actual_sub &&
> >+ test_cmp expect_super actual_super &&
> >+ test_cmp expect_sub actual_sub
> >+'
> >+
> >+test_expect_success 'pull basic rebase recurse' '
> >+ (
> >+ cd child &&
> >+ echo "a" >file &&
> >+ git add file &&
> >+ git commit -m "update file"
> >+ ) &&
> >+ (
> >+ cd parent &&
> >+ git -C sub pull &&
> >+ git add sub &&
> >+ git commit -m "update submodule"
> >+ ) &&
> >+ (
> >+ cd super/sub &&
> >+ echo "b" >file2 &&
> >+ git add file2 &&
> >+ git commit -m "add file2"
> >+ ) &&
> >+
> >+ git -C parent rev-parse master >expect_super &&
> >+ git -C child rev-parse master >expect_sub &&
> >+
> >+ git -C super pull --rebase --recurse-submodules &&
> >+ git -C super rev-parse master >actual_super &&
> >+ git -C super/sub rev-parse master^ >actual_sub &&
> >+ test_cmp expect_super actual_super &&
> >+ test_cmp expect_sub actual_sub &&
> >+
> >+ echo "a" >expect &&
> >+ test_cmp expect super/sub/file &&
> >+ echo "b" >expect &&
> >+ test_cmp expect super/sub/file2
> >+'
> >+
> >+test_expect_success 'pull rebase recursing fails with conflicts' '
> >+ git -C super/sub reset --hard HEAD^^ &&
> >+ git -C super reset --hard HEAD^ &&
> >+ (
> >+ cd super/sub &&
> >+ echo "b" >file &&
> >+ git add file &&
> >+ git commit -m "update file"
> >+ ) &&
> >+ test_must_fail git -C super pull --rebase --recurse-submodules
> >+'
> >+
> >test_done
> >-- 
> >2.13.0.rc2.291.g57267f2277-goog
> >
> >
> 

-- 
Brandon Williams
