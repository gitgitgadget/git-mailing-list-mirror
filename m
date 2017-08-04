Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D5382047F
	for <e@80x24.org>; Fri,  4 Aug 2017 22:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbdHDWAB (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 18:00:01 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33503 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbdHDWAA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 18:00:00 -0400
Received: by mail-pg0-f44.google.com with SMTP id u5so12661463pgn.0
        for <git@vger.kernel.org>; Fri, 04 Aug 2017 15:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yChvmK69mdZIuUgVWpy65UOoPuYKa01REBE48YcPxAE=;
        b=nccz8pO0zQFAEw+7jEmeJxurO53zjQ2v7peGLBB7lr2r8pQ2uqEbiv/jDDz9m5KAoC
         29RHnsNaL3l/vgG4yc1UqYDJTUNVWX6sflppqkZbTd2FxHdU0/+gdlTlYjIX7fY+K24j
         qiYgX00O/oKI69hMzuTjiBrxEQJ2HtYAFjCQcEo6n9Z1DGhNPHRAZfc0448WyBuhngty
         Nr/A+aca9p8xjV63B9WeHaYLafXkAcb8WCubmbmzvqC/SGv+UGd6Btk9P4Zca/hr6+2b
         0/Qnbygw7RbhUKCZt1L7L/t2EB2NBkItJ/lXqjDgkcVOkgsHDCazmbQY03e9bc1Blq2n
         3Ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yChvmK69mdZIuUgVWpy65UOoPuYKa01REBE48YcPxAE=;
        b=ACqJGP+4M5Ps221e/vCSFxOvmSVJomPBCZ/6IaMiuf2d8wKvaZt9AX9MMCO8WRxsZ8
         4/pujhZ/ipxneEMY7YgmiHCexKlfv5sbEMZ97GZG/UWpF1/2E8n/FzwqGtbWHSUFG7fa
         MRvpyZYl9bfJWkMba6wn7uQTwiOgHB1HsLvi2uTfVcuxHTNWJef19TDe926C+sw2iOID
         q9nNM+vU06xwFGjtxxWxYP5SkdzNjd4eAQfbQ9wWlGbWryImnjIgR9oXHamhjBlOhTge
         9db8VU8ludMM1sTVOxuLZ4KJ+8QGBqBiPPapK5XDfxcDFKM4StucWBbi+KUNFKBAk4XJ
         IFqg==
X-Gm-Message-State: AIVw113jAhsfndOoKPv7TPqrOJHhfhuadattrc6l5TpY5v/xxIaAUgR3
        40cq0viUBAld1IRD
X-Received: by 10.99.126.69 with SMTP id o5mr3871916pgn.2.1501883999438;
        Fri, 04 Aug 2017 14:59:59 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:12e:3e2a:b3e7:da91])
        by smtp.gmail.com with ESMTPSA id p27sm4448679pfl.23.2017.08.04.14.59.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 04 Aug 2017 14:59:58 -0700 (PDT)
Date:   Fri, 4 Aug 2017 14:59:56 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        Jens.Lehmann@web.de
Subject: Re: [PATCH v2 10/15] diff: stop allowing diff to have submodules
 configured in .git/config
Message-ID: <20170804215956.GC126093@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170803182000.179328-1-bmwill@google.com>
 <20170803182000.179328-11-bmwill@google.com>
 <xmqqlgn0wfjt.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlgn0wfjt.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/03, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Traditionally a submodule is comprised of a gitlink as well as a
> > corresponding entry in the .gitmodules file.  Diff doesn't follow this
> > paradigm as its config callback routine falls back to populating the
> > submodule-config if a config entry starts with 'submodule.'.
> >
> > Remove this behavior in order to be consistent with how the
> > submodule-config is populated, via calling 'gitmodules_config()' or
> > 'repo_read_gitmodules()'.
> 
> I am all for dropping special cases deep in the diff machinery, even
> though there may be submodule users who care about submodule.*.ignore
> 
> Does this change mean we can eventually get rid of the ugly
> DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG hack and also need for a patch
> like 03/15?

I think that this is a step toward getting rid of that.  We can either
do two things: 1) deprecate submodule.*.ignore and don't respect it
anymore or 2) flip the polarity of that flag so that by default we
don't respect the submodule.*.ignore config and instead callers must opt
in instead of the current opt out behavior.

> 
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  diff.c                    |  3 ---
> >  t/t4027-diff-submodule.sh | 67 -----------------------------------------------
> >  2 files changed, 70 deletions(-)
> >
> > diff --git a/diff.c b/diff.c
> > index 85e714f6c..e43519b88 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -346,9 +346,6 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
> >  		return 0;
> >  	}
> >  
> > -	if (starts_with(var, "submodule."))
> > -		return parse_submodule_config_option(var, value);
> > -
> >  	if (git_diff_heuristic_config(var, value, cb) < 0)
> >  		return -1;
> >  
> > diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
> > index 518bf9524..2ffd11a14 100755
> > --- a/t/t4027-diff-submodule.sh
> > +++ b/t/t4027-diff-submodule.sh
> > @@ -113,35 +113,6 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)'
> >  	! test -s actual4
> >  '
> >  
> > -test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match) [.git/config]' '
> > -	git config diff.ignoreSubmodules all &&
> > -	git diff HEAD >actual &&
> > -	! test -s actual &&
> > -	git config submodule.subname.ignore none &&
> > -	git config submodule.subname.path sub &&
> > -	git diff HEAD >actual &&
> > -	sed -e "1,/^@@/d" actual >actual.body &&
> > -	expect_from_to >expect.body $subprev $subprev-dirty &&
> > -	test_cmp expect.body actual.body &&
> > -	git config submodule.subname.ignore all &&
> > -	git diff HEAD >actual2 &&
> > -	! test -s actual2 &&
> > -	git config submodule.subname.ignore untracked &&
> > -	git diff HEAD >actual3 &&
> > -	sed -e "1,/^@@/d" actual3 >actual3.body &&
> > -	expect_from_to >expect.body $subprev $subprev-dirty &&
> > -	test_cmp expect.body actual3.body &&
> > -	git config submodule.subname.ignore dirty &&
> > -	git diff HEAD >actual4 &&
> > -	! test -s actual4 &&
> > -	git diff HEAD --ignore-submodules=none >actual &&
> > -	sed -e "1,/^@@/d" actual >actual.body &&
> > -	expect_from_to >expect.body $subprev $subprev-dirty &&
> > -	test_cmp expect.body actual.body &&
> > -	git config --remove-section submodule.subname &&
> > -	git config --unset diff.ignoreSubmodules
> > -'
> > -
> >  test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match) [.gitmodules]' '
> >  	git config diff.ignoreSubmodules dirty &&
> >  	git diff HEAD >actual &&
> > @@ -208,24 +179,6 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)'
> >  	! test -s actual4
> >  '
> >  
> > -test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match) [.git/config]' '
> > -	git config submodule.subname.ignore all &&
> > -	git config submodule.subname.path sub &&
> > -	git diff HEAD >actual2 &&
> > -	! test -s actual2 &&
> > -	git config submodule.subname.ignore untracked &&
> > -	git diff HEAD >actual3 &&
> > -	! test -s actual3 &&
> > -	git config submodule.subname.ignore dirty &&
> > -	git diff HEAD >actual4 &&
> > -	! test -s actual4 &&
> > -	git diff --ignore-submodules=none HEAD >actual &&
> > -	sed -e "1,/^@@/d" actual >actual.body &&
> > -	expect_from_to >expect.body $subprev $subprev-dirty &&
> > -	test_cmp expect.body actual.body &&
> > -	git config --remove-section submodule.subname
> > -'
> > -
> >  test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match) [.gitmodules]' '
> >  	git config --add -f .gitmodules submodule.subname.ignore all &&
> >  	git config --add -f .gitmodules submodule.subname.path sub &&
> > @@ -261,26 +214,6 @@ test_expect_success 'git diff between submodule commits' '
> >  	! test -s actual
> >  '
> >  
> > -test_expect_success 'git diff between submodule commits [.git/config]' '
> > -	git diff HEAD^..HEAD >actual &&
> > -	sed -e "1,/^@@/d" actual >actual.body &&
> > -	expect_from_to >expect.body $subtip $subprev &&
> > -	test_cmp expect.body actual.body &&
> > -	git config submodule.subname.ignore dirty &&
> > -	git config submodule.subname.path sub &&
> > -	git diff HEAD^..HEAD >actual &&
> > -	sed -e "1,/^@@/d" actual >actual.body &&
> > -	expect_from_to >expect.body $subtip $subprev &&
> > -	test_cmp expect.body actual.body &&
> > -	git config submodule.subname.ignore all &&
> > -	git diff HEAD^..HEAD >actual &&
> > -	! test -s actual &&
> > -	git diff --ignore-submodules=dirty HEAD^..HEAD >actual &&
> > -	sed -e "1,/^@@/d" actual >actual.body &&
> > -	expect_from_to >expect.body $subtip $subprev &&
> > -	git config --remove-section submodule.subname
> > -'
> > -
> >  test_expect_success 'git diff between submodule commits [.gitmodules]' '
> >  	git diff HEAD^..HEAD >actual &&
> >  	sed -e "1,/^@@/d" actual >actual.body &&

-- 
Brandon Williams
