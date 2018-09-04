Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4CC61F428
	for <e@80x24.org>; Tue,  4 Sep 2018 17:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeIDVoH (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 17:44:07 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34979 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeIDVoH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 17:44:07 -0400
Received: by mail-lj1-f196.google.com with SMTP id p10-v6so3840154ljg.2
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 10:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mJSMta4hzHE7jgnkP05GE6WBu7MhWljBJ60vbqWtinQ=;
        b=AThFmYIi8hPjBtndlXCjRINyIRPfieDPLErc7Ym+9L//+DigpcysV6a2TkInLGlpt/
         wHfIJaJ+SLvwbhD1/2Cerc+7dRjHfwAjFZUIfPsiNYpdB2x+DtVOCwc/XpwEXPmbv7bz
         3xe75znspc7W/DQSmQEgu7LV/8ZcPAY0ZHVygyVXLSC2Pl6hyYiWthlPwINCHpc+eTKH
         32pAWMVj4xKeTk2OySLE8dsGeD7s6mxu7hn53HT6YmoB8SwbLSc9yGNEzGO4/O9jfl3A
         i4jlV1vmcUthtFoQVfz67aj07gyN/0NkUhUHb2BRBS9rlRzrOpFy+S+eBg2VSoR+kNy3
         w1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mJSMta4hzHE7jgnkP05GE6WBu7MhWljBJ60vbqWtinQ=;
        b=iT7TMLZK4sLIotsxfnz9u73qQB6c0TBhf2M/YKvz333bMnkOaRonAgfJIbNB+mP4jl
         +qjpE51L7nN4Q15D8Cco3DM29LsMyMeCr8gF94MaU2hnKjOP3Apo9VcgyTocWYCSqeuv
         Vew/2+ZHd7DByTfovCvgnznZ/B7NVb83MOXIog9CxWKBIOgHpT4STQdYEvDLjJkgLX1P
         75JApfjBojRKCCCKDlm2hVv9JA56I9MbqEbhD7tJpnx9uBZnPLbICWfmABJhm3HJTjTk
         c/fezAK8TPM1gpcfU2eH+Eomd+BcrJdvc+mhoqrhFGpt5gOWSNbPGqhtX2kN/99xrF2Z
         xNpg==
X-Gm-Message-State: APzg51CeXyMFNZWcJ75Xf/W9YiGPQ3Ut1cN2fvjsTz1Suik1P+qjMlOq
        e1Mk/zdsJSztcL84brROQ2GpmouP
X-Google-Smtp-Source: ANB0VdY1TBzxxJiTJI53atnvv9K76XCKW3eErhJm0N1pbPF4Jijwv1f9z200JyM0WLq9lSqzqfzknw==
X-Received: by 2002:a2e:4782:: with SMTP id u124-v6mr22360118lja.40.1536081483891;
        Tue, 04 Sep 2018 10:18:03 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id w14-v6sm4056967ljh.71.2018.09.04.10.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 10:18:03 -0700 (PDT)
Date:   Tue, 4 Sep 2018 19:18:01 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     gitgitgadget@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/1] Define GIT_TEST_COMMIT_GRAPH for commit-graph
 test coverage
Message-ID: <20180904171801.GA31791@duynguyen.home>
References: <pull.26.git.gitgitgadget@gmail.com>
 <pull.26.v2.git.gitgitgadget@gmail.com>
 <CACsJy8DRzhnxJHXr+zRpBX+rfGPakgbVHYWRDb-XiatFsstfpg@mail.gmail.com>
 <faebdf82-7e9b-b662-2884-1398d90ab26c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faebdf82-7e9b-b662-2884-1398d90ab26c@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 04, 2018 at 01:12:55PM -0400, Derrick Stolee wrote:
> On 9/4/2018 12:49 PM, Duy Nguyen wrote:
> > On Wed, Aug 29, 2018 at 2:49 PM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >> The commit-graph (and multi-pack-index) features are optional data
> >> structures that can make Git operations faster. Since they are optional, we
> >> do not enable them in most Git tests. The commit-graph is tested in
> >> t5318-commit-graph.sh (and t6600-test-reach.sh in ds/reachable), but that
> >> one script cannot cover the data shapes present in the rest of the test
> >> suite.
> >>
> >> This patch introduces a new test environment variable, GIT_TEST_COMMIT_GRAPH
> >> . Similar to GIT_TEST_SPLIT_INDEX, it enables the commit-graph and writes it
> >> with every git commit command. Thanks, Duy, for pointing out this direction
> >> [1].
> > Any reason to not add this new flag in ci/run-build-and-tests.sh
> > (which is used by Travis)? I see your note about VSTS but I don't see
> > why it has to be exclusive to VSTS.
> 
> I only wanted to volunteer resources that I know are available. I am 
> looking into an additional test run in Travis CI builds, but didn't want 
> to presume the extra resources would be available.
> 

OK I think there's a misunderstanding. You would not need a separate
test run for this, instead the second (existing) run just activates
both split index and commit-graph together. The run may be a bit
slower (doubtful since commit-graph is all about speed) but it would
not cost much more resources. Such a change would look like this

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 2a5bff4a1c..185305e3e2 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -15,6 +15,7 @@ then
 	export GIT_TEST_FULL_IN_PACK_ARRAY=true
 	export GIT_TEST_OE_SIZE=10
 	export GIT_TEST_OE_DELTA_SIZE=5
+	export GIT_TEST_COMMIT_GRAPH=yes
 	make --quiet test
 fi
 

--
Duy
