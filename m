Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C20251F406
	for <e@80x24.org>; Mon, 14 May 2018 15:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeENPnZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 11:43:25 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42800 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeENPnY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 11:43:24 -0400
Received: by mail-lf0-f66.google.com with SMTP id b18-v6so18014785lfa.9
        for <git@vger.kernel.org>; Mon, 14 May 2018 08:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jhKiq9Z7hZHVTJavWI8k+dij/GEaMxElGvC3OB/IUwU=;
        b=SqYwXXwywG+XNCw5200buPtzrnz+9ocD25UxKCXCeWt81OCGjJxiJ3u1S+DVlz6P7q
         qwv6Yr6b1EcQQmK+VUuXAWKK9sRnXFM9cYPTrp+HkKw7jD9ER4sfmYlXXw0bFOVEbcCl
         JakfaUq+c96fx8M1pX0Ug+uNzPJ+cbkZhgMXdOu4buOOMw4EHixrzMrJ+ExmA0HTHilA
         +gvTsL8N5rjKOreio78UlIw3T3ryG26ceWIyRvT8ZsxNjnrqAMY5e6LqnDI0DbL/AI0F
         +JvePp4neP14qLPUCVQLB9pPPjxKaef44p6+c5MDj3UICrJsU0NTYkhJPhn6HpnhR3FM
         Wn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jhKiq9Z7hZHVTJavWI8k+dij/GEaMxElGvC3OB/IUwU=;
        b=Ng1iC/S687VTYkFIJbxxldtCQh0ia1Pu+IsZLHIrAdFD9ll2bHp8CbebwL2yvnZ2ZK
         f0HZ34YuzcHuim5kEj+kl2p0sRCyvKZrf/CXuwZyxAM4hymmG2hE5K2SH2rbZXYRPUaD
         1wvnVPFfkm8ALG753gHyWdd2CtEo3qQk53o4HMLqX73sqE1Ab1ee4/TMNL9Szlqet0jq
         3ujGC5A3JKwF7pw7v2S3qJwdQ8Ne9G4dz0sBi1o3CxAIAdwN4V+62KYtTXl5XAUVXTJz
         IkK929FrYMADj5Q5DH1XXW6EYsFosvnt89jfz7C26TiyUYzg2Vm0MqI4LXlR4Qkspzs+
         Ysaw==
X-Gm-Message-State: ALKqPweEPdS9jCLveSjdqPRL1J2LX//Tb0piCwkU1r6MDQDeBLukMsov
        tT/hudFmoiCgssrPHjinyOE=
X-Google-Smtp-Source: AB8JxZokoyrLJf2/AR2BzX2VUJLPw8esjLUdW2JnZBDDtSj+cBR7OZuNk1ikedUGAk7C2hG37L4egA==
X-Received: by 2002:a2e:8948:: with SMTP id b8-v6mr4833095ljk.31.1526312602874;
        Mon, 14 May 2018 08:43:22 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o18-v6sm2484025lfg.16.2018.05.14.08.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 May 2018 08:43:21 -0700 (PDT)
Date:   Mon, 14 May 2018 17:43:19 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     Dannier Castro L <danniercl@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 1/3] checkout.c: add strict usage of -- before file_path
Message-ID: <20180514154319.GA424@duynguyen.home>
References: <1526178214-30956-1-git-send-email-danniercl@gmail.com>
 <20180513210233.GA18892@alpha>
 <CACsJy8B2TVr1g+k+eSQ=pBEO3WN4_LtgLo9gpur8X7Z9GOFL_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8B2TVr1g+k+eSQ=pBEO3WN4_LtgLo9gpur8X7Z9GOFL_A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 14, 2018 at 04:52:53PM +0200, Duy Nguyen wrote:
> On Sun, May 13, 2018 at 11:02 PM, Kevin Daudt <me@ikke.info> wrote:
> > One data point indicating this is giving issues is that today on IRC a
> > user was confused why `git checkout pt` did not show any message and did
> > not checkout a remote branch called 'pt' as they expected. It turned out
> > they also had a local file/dir called 'pt', which caused git to checkout
> > that file/dir rather than creating a local branch based on the remote
> > branch.
> 
> Now this is something we should fix. When an argument can be
> interpreted in more than one way Git should reject it, but I think
> this ambiguation logic does not take dwim (i.e. create a new branch
> beased on remote) into account.

This is a quick draft to make this happen

-- 8< --
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b49b582071..f4f6951f05 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -953,8 +953,19 @@ static int parse_branchname_arg(int argc, const char **argv,
 		 */
 		int recover_with_dwim = dwim_new_local_branch_ok;
 
-		if (!has_dash_dash &&
-		    (check_filename(opts->prefix, arg) || !no_wildcard(arg)))
+		if (!has_dash_dash && check_filename(opts->prefix, arg) &&
+		    recover_with_dwim) {
+			const char *remote = unique_tracking_name(arg, rev);
+			if (remote)
+				die(_("don't know whether to create a tracking "
+				      "branch from remote %s or to checkout path %s, "
+				      "use -- to disambiguate"),
+				    remote, arg);
+			printf("here?\n");
+			recover_with_dwim = 0;
+		}
+
+		if (!has_dash_dash && !no_wildcard(arg))
 			recover_with_dwim = 0;
 		/*
 		 * Accept "git checkout foo" and "git checkout foo --"
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 3e5ac81bd2..ea95fb8668 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -215,4 +215,35 @@ test_expect_success 'loosely defined local base branch is reported correctly' '
 	test_cmp expect actual
 '
 
+test_expect_success 'reject when arg could be part of dwim branch' '
+	git remote add foo file://non-existent-place &&
+	git update-ref refs/remotes/foo/dwim-arg HEAD &&
+	echo foo >dwim-arg &&
+	git add dwim-arg &&
+	echo bar >dwim-arg &&
+	test_must_fail git checkout dwim-arg &&
+	test_must_fail git rev-parse refs/heads/dwim-arg -- &&
+	grep bar dwim-arg
+'
+
+test_expect_success 'disambiguate dwim branch and checkout path (1)' '
+	git update-ref refs/remotes/foo/dwim-arg1 HEAD &&
+	echo foo >dwim-arg1 &&
+	git add dwim-arg1 &&
+	echo bar >dwim-arg1 &&
+	git checkout -- dwim-arg1 &&
+	test_must_fail git rev-parse refs/heads/dwim-arg1 -- &&
+	grep foo dwim-arg1
+'
+
+test_expect_success 'disambiguate dwim branch and checkout path (2)' '
+	git update-ref refs/remotes/foo/dwim-arg2 HEAD &&
+	echo foo >dwim-arg2 &&
+	git add dwim-arg2 &&
+	echo bar >dwim-arg2 &&
+	git checkout dwim-arg2 -- &&
+	git rev-parse refs/heads/dwim-arg2 -- &&
+	grep bar dwim-arg2
+'
+
 test_done
-- 8< --
