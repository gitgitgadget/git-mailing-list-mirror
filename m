Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E80FA1F576
	for <e@80x24.org>; Sat, 20 Jan 2018 11:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbeATL4B (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 06:56:01 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40184 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751063AbeATLz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 06:55:59 -0500
Received: by mail-wr0-f193.google.com with SMTP id 100so3867194wrb.7
        for <git@vger.kernel.org>; Sat, 20 Jan 2018 03:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3nymUQIEFFbZJ5DIm7oDDWQBg2wOUpZwpe4W+H3ESgc=;
        b=qq9mUUEn9OT4YJ6QCQTjwRa7G6KEl+LtXcmPwYgePdqvuG0Qe2YzfXw88Icc2zd8pl
         pLYStgYPakWgq2z3uYDssxP1XLEciiekLs0XpN+mcDRqUbrW9RuL2bb4f8kLenOwgAIe
         r5yADp8IyWzQ8JZhFEDcqbnLJvuewxk8LT2eC8jM0SJhzYERubVkv65J3ts8SvlDXsCQ
         CQsasQAb8Fc5bSVM/qHzWmwCyb9X2XALXJswFyCoDkMus+Scsp4Pe9FvYLn9Cy9yUPfP
         uwkZyOOcvs6zLx3OIi8F6cScQ/TJwGbrsJbyKjbp/jLf62gCnu3qfctg0Zn2GXEYmhn2
         4ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3nymUQIEFFbZJ5DIm7oDDWQBg2wOUpZwpe4W+H3ESgc=;
        b=QNmod/vQPfjIcvA6OxIvIQwj/yM0g6MMDb1z5mJVSsn8qCSAbjUByFbIE4PDLajBKJ
         zmw/A67KDAraQHcp/OK88UAwvcpB0aGAy6D0YECsGJ/g+BYIgn9r0C+Bph2HMKbdpnEP
         AadBwJ4Me7RiMEzE0AM4IXP8FbFpXPn6M+Xe5EPe/S/jCsooFmraLQnYy9Pd6vej97cI
         7nrPjfpKPz02e6N+ep7Fz4BG5AU8h3LBTA0KLo3BIblbXQJ4JIOeNuG4gu7oEQibRlBr
         gohv/TWpSORQf7o2iHXnBiLzr/UQu1hiPCNQO4PVKpHdD/KlY2/Zv+ibLzq+DY3nvkzg
         9ATg==
X-Gm-Message-State: AKwxytcv07KG7BvZH6b/FPKJkVGGI9wajV/zgKuMZ/lk3gfefifQ8iFP
        JOgfKIyv0h3uSRW93gok0yA=
X-Google-Smtp-Source: AH8x226pvjVMEHgzxzzEHtlRJNwZmOCEDbiZOwMCMdonXy7VdU8ipNMHTP2P9n2Qw+VGY0lFfPFYXA==
X-Received: by 10.223.183.43 with SMTP id l43mr1458959wre.181.1516449357671;
        Sat, 20 Jan 2018 03:55:57 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id e6sm5228833wra.41.2018.01.20.03.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Jan 2018 03:55:56 -0800 (PST)
Date:   Sat, 20 Jan 2018 11:58:19 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 1/3] read-cache: fix reading the shared index for
 other repos
Message-ID: <20180120115819.GR2641@hank>
References: <20171217225122.28941-1-t.gummerer@gmail.com>
 <20180107223015.17720-1-t.gummerer@gmail.com>
 <20180107223015.17720-2-t.gummerer@gmail.com>
 <xmqq1silpl4g.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1silpl4g.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/19, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > read_cache_from() defaults to using the gitdir of the_repository.  As it
> > is mostly a convenience macro, having to pass get_git_dir() for every
> > call seems overkill, and if necessary users can have more control by
> > using read_index_from().
> 
> This was a bit painful change, given that some changes in flight do
> add new callsites to read_index_from() and they got the function
> changed under their feet.

Sorry about that.  Is there any way to make such a change less painful
in the future?

> Please double check if I made the right git-dir to be passed to them
> when I push out 'pu' in a few hours.

I think one conversion was not quite correct, even though all tests
still pass with GIT_TEST_SPLIT_INDEX set.

The following diff fixes that conversation and has a test showing the
breakage:

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 6a49f9e628..4d86a3574f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -612,7 +612,8 @@ static void validate_no_submodules(const struct worktree *wt)
        struct index_state istate = {0};
        int i, found_submodules = 0;
 
-       if (read_index_from(&istate, worktree_git_path(wt, "index"), get_git_dir()) > 0) {
+       if (read_index_from(&istate, worktree_git_path(wt, "index"),
+                           get_worktree_git_dir(wt)) > 0) {
                for (i = 0; i < istate.cache_nr; i++) {
                        struct cache_entry *ce = istate.cache[i];
 
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index b3105eaaed..8faf61bbf5 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -90,6 +90,16 @@ test_expect_success 'move main worktree' '
        test_must_fail git worktree move . def
 '
 
+test_expect_success 'move worktree with split index' '
+       git worktree add test &&
+       (
+               cd test &&
+               test_commit file &&
+               git update-index --split-index
+       ) &&
+       git worktree move test test-destination
+'
+
 test_expect_success 'remove main worktree' '
        test_must_fail git worktree remove .
 '

With this applied what you have in pu looks good to me.  Does the
above help, or should I send this in another for for you to apply?

> Thanks.
