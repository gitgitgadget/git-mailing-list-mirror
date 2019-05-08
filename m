Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5804D1F45F
	for <e@80x24.org>; Wed,  8 May 2019 21:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfEHVwn (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 17:52:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35892 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfEHVwm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 17:52:42 -0400
Received: by mail-ed1-f66.google.com with SMTP id a8so202292edx.3
        for <git@vger.kernel.org>; Wed, 08 May 2019 14:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=X4WcWBVzVHbOGSXmogxE3P14suHrT7b/zFs3nfJE2zc=;
        b=rDB41VJETVtyN1wiCyRCzc2BxxldcAOkRR6gkmfYC+Ia0TW1uVQYXEkSbtPJFBeCKk
         n80L53vFI6diwWnlEcPtPJbp7yxMoNJy/qGDQtwCREA5z09bLBi65x56Rgd4j7gOVFTu
         yKLUStgMCBdH1IAMUGkPxMkhnKkRI3xOsHidwbTtmtoQPphs7JILuJNAcMVarLjaC6yo
         HqDWRrwffgAK1VgJFvMeYwVyQb/DASUZPKAprjZlq/pFhYjpGNDpqE6ZNrc/t5m/ou10
         6HLWs5grxzbyRzvjegtngQi2YYdpyRSDMlqv2u9kdPPs1/R1bSo4C0ak8/FydNYbCrXE
         pHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X4WcWBVzVHbOGSXmogxE3P14suHrT7b/zFs3nfJE2zc=;
        b=V4NVlojgRDy7KNfEVj04/DGretVj1l4FNGsnaOQL6gdOuPcji7h9Sr0HEsNV7q/jJ9
         CuAweruM7j4rvpYXVs4tgk7Pt6OtkFPy+/A/Ls3C/nTUMeq6GaEHGWD2ZimXgLibqJSv
         WYT2e1TvUzUlsA1sBuU+RqRsXQ21nxF8utDBUkEn5eZWYEtvQ49b5f2tlh5GG3Uz6o/9
         ORYJVAGE+NpasyJOPgz6JrizPYSGuu/LnfhflP00oTkvGQvNkOVQcX1UaZgGfhcjLgZS
         zPfq4ZlyeWYmU9DgZUhEiUA3+DaltedhQZHQzEdvrshsvFoNbnpdYCoycLmSG+t07x7k
         ielg==
X-Gm-Message-State: APjAAAWG2YY0ePmhEINoIcAOoiWr8Ii7lSSHsCuDJqFApp6puanDt7C8
        QH65YF4pJRszV/54UIafy4yk/jQMG3A=
X-Google-Smtp-Source: APXvYqyl7Tpd2mkULeqfP1gzZyUSV51EDWCW29x2Tfb9P78J+1dWBQh7BsSACFCVvUrOy3GBbu8GXw==
X-Received: by 2002:a50:deca:: with SMTP id d10mr52442edl.25.1557352360959;
        Wed, 08 May 2019 14:52:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r8sm48837edh.39.2019.05.08.14.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 14:52:40 -0700 (PDT)
Date:   Wed, 08 May 2019 14:52:40 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 21:52:38 GMT
Message-Id: <pull.186.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] difftool: --no-index is incompatible with --dir-diff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While debugging why a straight-forward backport of the js/difftool-no-index 
branch onto Git for Windows' master does not work as expected (spoiler: it's
due to git diff --no-index now implying --ext-diff, a change that is not yet
in Git for Windows' master), I ran into quite a few segmentation faults
while trying to make --no-index work nicely with --dir-diff.

And this was a much bigger project than I thought it would be: the worktree 
is NULL and causes a segmentation fault, make_transient_cache_entry() 
returns NULL instead of a cache entry, while looking up replacement objects
there is a crash because git_replace_ref_base is NULL, during 
checkout_entry()'s life time, the prepare_alt_odb() function tries to
dereference the_repository.objects->odb (which is NULL, of course). I'll
stop here with all the segmentation faults.

Even worse, when trying to compare ../1 to ../2 (as we do in the regression
test for difftool --no-index outside any repository), we run afoul of 
verify_path() complaining that this is not a valid path for an index entry.

After figuring all of that out, I took a step back and guess what: it turns
out that it does not even make sense to combine those two options. The 
--dir-diff option exists to enable diff'ing subdirectories of a worktree
while pretending that untracked and ignored files in them do not even exist.
And without a worktree, there simply are no untracked or ignored files, so 
--dir-diff is not necessary.

Still, we should address those segmentation faults. And I think we address
them best by explicitly telling the user that they cannot use those two
options together.

Johannes Schindelin (1):
  difftool --no-index: error out on --dir-diff (and don't crash)

 builtin/difftool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


base-commit: 20de316e33446f37200e51aa333ba7d824dfd478
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-186%2Fdscho%2Fdifftool-no-index-extra-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-186/dscho/difftool-no-index-extra-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/186
-- 
gitgitgadget
