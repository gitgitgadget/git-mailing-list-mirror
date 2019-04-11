Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B22D620248
	for <e@80x24.org>; Thu, 11 Apr 2019 11:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDKLRg (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 07:17:36 -0400
Received: from mail-yw1-f48.google.com ([209.85.161.48]:46444 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDKLRg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 07:17:36 -0400
Received: by mail-yw1-f48.google.com with SMTP id v127so1890897ywe.13
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 04:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CjWlyknICftdFVJEXlreeD5D9kEIryvfzlcj/CKf7bY=;
        b=ZF00HXgUy7TQUg8APUpMb10fAhuJvP+vJDF6reyNcozzqPVdlfciPMYKkmQmLx++5U
         QyDd7za7EfqYHLQGoR94szJbhZ6tMPs+699EeVP3iq2BGFdiycfLh51LFmZWoEhx2BI1
         /ATUMDRYPeH+Kfz/xqdFAuZWAPYjwvoNw3t7RTQrBqpU+SbWLYYibStCUmD9wjmvdoLc
         D1ttNuLc2r83F08Vp/P3GDsQ0rnSCqv4IP/uv35yS2pkPb4SYChq4EJoEKWx8NaWqUza
         8cnIRxaPJS3IZMyBLIeP5hgeQWxMfuyfv0yLVgiMugwp7PKbCzANy8ESWyjNEnEM8wpD
         2nXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CjWlyknICftdFVJEXlreeD5D9kEIryvfzlcj/CKf7bY=;
        b=T4iyl/g6Q3RRq4CLp97gzznKHa0ZYOyuVH13TBB8QDjub+R/Qfgnzl7b8oIPe5O19U
         jd7toDVrtCBP2UWWKltar8wQUs/Gt7wQl+e3y+oxi70ufmdaWpOJ10jAqU0hpunTvm/o
         1dwQQENhFG4v9vtYc18QODOibYcWfGyooiPIo4t7Hu9uZ9+HRjIRPv2l0zhmVAKppwar
         C1XU7C5eENszQL15SeAbP8No+kc6h85o0QA64Jj259jPhShycihLDQSxBzySY5GovWwG
         G32TcGptOuoUcKOKkyvjQ19EaBPOQZ44dL1d5oNuAKRlHrKDuQiV6l2zIqEB3Wvbug4Z
         08GA==
X-Gm-Message-State: APjAAAVSjOHYY4syZPDsPCSjm44KS2fWZOL3LD9o7PR3eXp5IZCTurzU
        paInBXrld6upIru5Pw2ZUJHvTc/n
X-Google-Smtp-Source: APXvYqzSSfh66k1oBw8souX1XVFKVgG48PrnmCJfY5zWZ3Dv3Q0Updb2o7KCIWSQpWFLCYatGJ0YNQ==
X-Received: by 2002:a81:a113:: with SMTP id y19mr21012183ywg.200.1554981455470;
        Thu, 11 Apr 2019 04:17:35 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id p75sm16668330ywg.36.2019.04.11.04.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 04:17:34 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 11 Apr 2019 18:17:29 +0700
Date:   Thu, 11 Apr 2019 18:17:29 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: incorrect range-diff output?
Message-ID: <20190411111729.GB5620@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Try

    git range-diff from...to

with those two branches from https://gitlab.com/pclouds/git.git. The
interesting part is this

      diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
      --- a/Documentation/gitcli.txt
    @@ -120,10 +111,11 @@
        * linkgit:git-commit[1] to advance the current branch.
      
     -  * linkgit:git-reset[1] and linkgit:git-checkout[1] (with
    -+  * linkgit:git-reset[1] and linkgit:git-restore[1] (with
    -     pathname parameters) to undo changes.
    +-    pathname parameters) to undo changes.
    ++  * linkgit:git-restore[1] to undo changes.
      
        * linkgit:git-merge[1] to merge between local branches.
    + 

This particular hunk comes from giteveryday.txt, not gitcli.txt. And
the b/Documentation/gitcli.txt line is also missing.

I'm in the middle of some other things (and don't know range-diff that
well) so I'm just dropping a bug report here.

I've tried all 'master', 'next' and 'pu'. Same result. Tried
--no-pager too in case the pager ate something up.
--
Duy
