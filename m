Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEE1C1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 19:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfGaTxx (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 15:53:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51222 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfGaTxx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 15:53:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so62082546wma.1
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 12:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=k3CKXwGiWUPmFRoHxk5Va/5AcAjQG+92W/PFzjFAQ7E=;
        b=mRNREW8J5QbyRT9S3B5+Mh8BNYfSmFk6OmBhwRNkwszMleVS84IbDNWo5QCTXpf1Jf
         Wi4XlVYetWcItHzxqR0WbUtGRm9xIRxosv61kZnfb2cuJIQHx5BfmiGTrqHz1bZbiK7M
         sqCF12KECq5dJ8bCK3ur1Dr6yX9KyjpVW8R7z4NKvp1Qhf+JyHj+TCK7e8aB5lAZTE74
         Qi43Pu/Aqp4iwvOTN+LYWyzfW8DCfNclR5U8z0eVo80zX446BJA3OrZo/vGQTuBfRLOo
         CekudPM64mC2vHq8UdAWiLUPDLAL0nM24gUJXhBooX6BpRIqd7YtzZH5DDgRSu11+M+K
         Ad7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k3CKXwGiWUPmFRoHxk5Va/5AcAjQG+92W/PFzjFAQ7E=;
        b=tEckC9Bqkv80rSS/AQFTjGTYFBqqhEV7BL0WWvkcCzEtXFDlBcTzPcB9FW++TTyfpI
         PVwL5KrPYn5Z1HDhU+90jjJrzxcAQY/rlZcZILE/oNfSXr2agkfLriZ+sK5e9rWchsin
         ZPVpAbF4DtJ0vckapd5X9f0RID80JOHUcAWY7xOaI0B72fivxAS6n0hvpYbHKLZnfcKR
         Z7vNSim6dVC+jQoJ1PwWnRpKXodQA/1Cbgl3qATGzWnJ3XI/XtUytEvSF7BfpzrZn7yp
         lS60ZJM16Uk2eNbwzgNR8cXIervT6vyO6DUsDSNcqgefP0WQQTt2iTz8ASIuFMs3gUcm
         fb/w==
X-Gm-Message-State: APjAAAXzQjE1IGKXtlVrEyl4HJinWSLRW3iFuS/h1dZmCmJIuxpDOP6n
        PlJ3qBnPAPOSoGoAvVlkYig2ApXj
X-Google-Smtp-Source: APXvYqxeTSm9pGXnA47K9GaRxIg+0jyYVAb6OJVoKvRcbJFpx9JJ5WsTuzyfjVj9gDo9KeHuF67KeQ==
X-Received: by 2002:a1c:3883:: with SMTP id f125mr107835228wma.18.1564602831536;
        Wed, 31 Jul 2019 12:53:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z19sm51629669wmi.7.2019.07.31.12.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 12:53:51 -0700 (PDT)
Date:   Wed, 31 Jul 2019 12:53:51 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Jul 2019 19:53:49 GMT
Message-Id: <pull.300.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Make the includeif:onbranch feature more robust
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

I actually stumbled over this while rebasing the VFS for Git patches, in
relation with the pre-command hook that we still support there (we're slowly
migrating toward Trace2, of course).

Once I figured out what the problem was, I hunted for a way to trigger this
bug in plain Git, and git help -a is the one I settled on. It had to be a
command that uses the early config machinery (and git help -a uses it to
list all aliases), and it had to be a command that does not discover a .git 
directory automatically (cmd_help is listed without any flags in git.c, so:
check).

Of course, part of me wants to just go and dig into the refs part of the
code to introduce an equivalent to the "early config" machinery (calling it
"early ref store"), but:

 1. We're really in feature freeze, and I want this bug fix to go into
    v2.23.0.
 2. It is actually a pretty obscure thing to want: a branch-dependent config
    that is used that early that the Git directory was not yet discovered. I 
    could imagine that some power user wants to play some games at some
    stage, say, with the pager depending on the name of the current branch,
    but even then, to run into the issue with this here patch where it
    simply ignores the includeif.onbranch: setting in the early config code
    path, a command has to be run that does not immediately set up 
    the_repository->gitdir but still wants to use the configured pager.

So yes, this patch introduces a known issue, but it does fix a BUG() where
no bug should be reported.

Johannes Schindelin (1):
  config: work around bug with includeif:onbranch and early config

 config.c                | 3 ++-
 t/t1309-early-config.sh | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)


base-commit: 026dd738a6e5f1e42ef0f390feacb5ed6acc4ee8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-300%2Fdscho%2Fonbranch-and-early-config-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-300/dscho/onbranch-and-early-config-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/300
-- 
gitgitgadget
