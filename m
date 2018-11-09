Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 921F61F453
	for <e@80x24.org>; Fri,  9 Nov 2018 09:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeKITOB (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 14:14:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32898 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeKITOB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 14:14:01 -0500
Received: by mail-pg1-f196.google.com with SMTP id q5-v6so640080pgv.0
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 01:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=SjEKHtoZjBGQf1FyNtcB3kkpwBFlmX1kDu8qZ6Rt5+M=;
        b=oQNmu4uvcX4/v6V7j1sIX+bSVQYk+2rFM/XscvhuRV/iGD+Zo6591mxUSY2yykJpjy
         xHplDoLh4BHRcCcAxqTrON6qDvhNqwmFOVVE2JTOS3Pi1FG+L73GyC6TZnV4SO9I0ire
         ok0OJ76E0xNz4b+gFBOzjEI2Lge21xtaLHxC9N9aOPRJh9szcVoVtLCduvv64IBaJO8/
         mJUFXoEeYhqUSZMN2Izb+IHLadP9+LioI2vsgOypOqVobBZzvMkyCrcNCWb3Qbr5wfjf
         IIkmohudtwXDS1MEZrQit0/SdKfSyOro6sAVHg+aBfiC5jNdqwfb8UfNgq3tCyxSo+AJ
         zpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SjEKHtoZjBGQf1FyNtcB3kkpwBFlmX1kDu8qZ6Rt5+M=;
        b=SPLMkKuYSzOmXlrS8/Js0NS2S/lnAU5t2jM5KUljgAdbLEl1yEfOISuHLXHmcSrDmO
         RqcyIO5gUDjLb8pvD0d+TYsxlO0faE9nWPq/GW2XdE4MfCxnqUzWhL8H/jJvUH6gLlt3
         u+Z8SryYtaluiN9PGAbuZH1h3Jd9m+1BMPEwKnL+c4Z3MZdsLVe5Tz/DV5IDE+aqxVN1
         Nk2PPt4oNVcDj/7WjHBq215Ly80qSzjSI5xgLgnW+D/DZ6GBRFAERa6sR+oEgAE2i1Jq
         I2rzYsDP3Z4sSf3p6OYi7747N5VGVSMOEQM23me9tRnhRENJZoyWXPYEFSUUs69NexvC
         VB3Q==
X-Gm-Message-State: AGRZ1gKPInoF6Ep4f4JQN2ihNZEMuBJb5yUgt7hZPx35CM7rirMCevqz
        ui2il/gAMzuljgX+moRXchiXKhOG
X-Google-Smtp-Source: AJdET5fwlWrtlI7Q1OjXDR8Iy85oUbyUaMt2Nrfo//tvDNYKqc1E6JcIMGQWvi5TiI7zXZ7/Fi0Dtg==
X-Received: by 2002:a62:6c89:: with SMTP id h131-v6mr8227453pfc.12.1541756057228;
        Fri, 09 Nov 2018 01:34:17 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id l26-v6sm12256624pfg.161.2018.11.09.01.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 01:34:16 -0800 (PST)
Date:   Fri, 09 Nov 2018 01:34:16 -0800 (PST)
X-Google-Original-Date: Fri, 09 Nov 2018 09:34:12 GMT
Message-Id: <pull.72.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] Fix built-in rebase perf regression
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

In our tests with large repositories, we noticed a serious regression of the
performance of git rebase when using the built-in vs the shell script
version. It boils down to an incorrect conversion of a git checkout -q:
instead of using a twoway_merge as git checkout does, we used a oneway_merge 
as git reset does. The latter, however, calls lstat() on all files listed in
the index, while the former essentially looks only at the files that are
different between the given two revisions.

Let's reinstate the original behavior by introducing a flag to the 
reset_head() function to indicate whether we want to emulate reset --hard 
(in which case we use the oneway_merge, otherwise we use twoway_merge).

Johannes Schindelin (2):
  rebase: consolidate clean-up code before leaving reset_head()
  built-in rebase: reinstate `checkout -q` behavior where appropriate

 builtin/rebase.c | 60 ++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 27 deletions(-)


base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-72%2Fdscho%2Fbuiltin-rebase-perf-regression-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-72/dscho/builtin-rebase-perf-regression-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/72
-- 
gitgitgadget
