Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08DE81F453
	for <e@80x24.org>; Fri, 25 Jan 2019 22:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfAYWOU (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 17:14:20 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51323 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfAYWOT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 17:14:19 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so8210810wmj.1
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 14:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=srIHRaY527TGA2zzBKcC9MGVtxv77GsXvZDRaI18iIk=;
        b=uHJ6msWlKRHStHpHqCLIYbxDqksOKjmk+d9jTVBFRZFit2rWEMC/5s+Zz1aPHZ0QuX
         puI0IjU4FuY23rLtvVHLt5UHNMA7um0TRkgvTl9ucur7OPcAzmtFzerX2XGdQvoEnSFa
         /Rk1fMQMEhGqZCiPd805MpeY9s5STN35VzM+yA1B5cgALTROk0Izntuqh2xK+gWCxVCv
         HofZuMGIaaU8TYYtl2DEV5NeUkWY2hAureCCUlaJiF3+RTF/FYm8ivw6SSA4PUGHMzzu
         2DqMKh97KPAb4n7mKPqaYanm72EQgCx8N7XDt/sTtg6fADduSxOJL6ldkzW5goaVTZGf
         mvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=srIHRaY527TGA2zzBKcC9MGVtxv77GsXvZDRaI18iIk=;
        b=pCllg/n9yOWhNdzrkky2mYXDACvHt+Nus5oA0p/NtQnFwTXGOxfc/FwMz4sK969W+T
         nXVZlfWmhAMJu12GLCt23LULPINbeVnT2NJlyk4pmj5Q7Q8QbjEhj6OZEW8RQg+SeNKl
         RYWkBEg25mahDWcPvwvXhArFjPAdpuZe9nJ5TFzYerjmLOcJF0MoGp6Dk5mdQDoN6WEP
         uipU21pThYODIuJ3PesMqklqgZrXCFgdflp3gM4ExrDOVqhzKUlz1Knwry+O4EtHRRSU
         KM/HeDxa457vrs+z9Pvwy3V9VkDnBN33d3x7j3l0OwpDogs/WimqL7nJbtW331Q3jhnd
         g7fw==
X-Gm-Message-State: AJcUukdgRLeDM1Co3NAP6AZfMA+3IHEzPUE7mAeqsG2N1NuHR4TSXI/W
        ti9DbgS2eGl45HUGGXUi9VU=
X-Google-Smtp-Source: ALg8bN4hP4pqkoRWUjyXzsNRM4OSdrdriNKZBX8SCTn2O8u1OIutMMaMMd682LNSGhu2rpW4x56cNw==
X-Received: by 2002:a1c:22c5:: with SMTP id i188mr8309498wmi.39.1548454457302;
        Fri, 25 Jan 2019 14:14:17 -0800 (PST)
Received: from szeder.dev (x4db9b7c2.dyn.telefonica.de. [77.185.183.194])
        by smtp.gmail.com with ESMTPSA id x12sm84436951wrt.20.2019.01.25.14.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 14:14:16 -0800 (PST)
Date:   Fri, 25 Jan 2019 23:14:14 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Regression in: [PATCH on sb/more-repo-in-api] revision: use
 commit graph in get_reference()
Message-ID: <20190125221414.GG6702@szeder.dev>
References: <20181204224238.50966-1-jonathantanmy@google.com>
 <20190125153348.GF6702@szeder.dev>
 <CAGZ79kZRnuTU3ukP1UdBUZD1x+nubYSwLxYgJse1mcj8JUOa2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZRnuTU3ukP1UdBUZD1x+nubYSwLxYgJse1mcj8JUOa2g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 25, 2019 at 11:56:38AM -0800, Stefan Beller wrote:
> > Have fun! :)
> 
> $ git gc
> ...
> Computing commit graph generation numbers: 100% (164264/164264), done.
> $ ./git version
> git version 2.20.1.775.g2313a6b87fe.dirty
> # pu + one commit addressing
> # https://public-inbox.org/git/CAGZ79kaUg3NTRPRi5mLk6ag87iDB_Ltq_kEiLwZ2HGZ+-Vsd8w@mail.gmail.com/
> 
> $ ./git -c core.commitGraph=false describe --dirty --all
> remotes/gitgitgadget/pu-1-g03745a36e6
> $ ./git -c core.commitGraph=true describe --dirty --all
> remotes/gitgitgadget/pu-1-g03745a36e6
> $ ./git -c core.commitGraph=true describe --dirty
> v2.20.1-776-g03745a36e6
> $ ./git -c core.commitGraph=false describe --dirty
> v2.20.1-776-g03745a36e6
> 
> it looks like it is working correctly here?
> Or did I miss some hint as in how to setup the reproduction properly?

How many refs are pointing to the commits you tried to describe?  In
the git repo, with an all-encompassing commit-graph it seems to be
important that more than one refs point there.  I could reproduce the
issue in a fresh git.git clone with Git built from commit 2313a6b87fe:

  $ git clone https://github.com/git/git
  Cloning into 'git'...
  <...>
  $ git commit-graph write --reachable
  Computing commit graph generation numbers: 100% (56722/56722), done.
  # 'HOME=.' makes sure that this command doesn't read my global
  # gitconfig.
  $ HOME=. ~/src/git/git describe --all --dirty
  heads/master-dirty
  $ git checkout origin/pu 
  HEAD is now at cb3b9e7ee3 Merge branch 'jh/trace2' into pu
  $ HOME=. ~/src/git/git -c core.commitGraph=true describe --all --dirty
  remotes/origin/pu
  $ git branch a-second-ref-pointing-at-pu buzz ~/src/tmp/git
  $ HOME=. ~/src/git/git -c core.commitGraph=true describe --all --dirty
  heads/a-second-ref-pointing-at-pu-dirty

I could also reproduce it in other repositories lying around here, but
could not manage to reproduce it in a minimal repository.

The smallest I could get is the test script below, where the last test
fails, i.e. the clean worktree is described as '-dirty', when the
to-be-described HEAD is not in the commit-graph.  I suspect this is
the same issue, because it bisects down to this same commit.

  --- >8 ---

Subject: [PATCH] test

---
 t/t9999-test.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100755 t/t9999-test.sh

diff --git a/t/t9999-test.sh b/t/t9999-test.sh
new file mode 100755
index 0000000000..cd1286e157
--- /dev/null
+++ b/t/t9999-test.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description='test'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit one &&
+	test_commit two &&
+	# Two refs point there.
+	git for-each-ref --points-at=two &&
+	git config core.commitGraph true
+'
+
+test_expect_success 'full commit-graph' '
+	git commit-graph write --reachable &&
+	verbose test "$(git describe --all --dirty)" = tags/two
+'
+
+test_expect_success 'partial commit-graph, described HEAD is not in C-G' '
+	git rev-parse one | git commit-graph write --stdin-commits &&
+	git status &&
+	verbose test "$(git describe --all --dirty)" = tags/two
+'
+
+test_done
-- 
2.20.1.642.gc55a771460

