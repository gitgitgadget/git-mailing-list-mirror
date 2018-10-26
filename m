Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9203B1F453
	for <e@80x24.org>; Fri, 26 Oct 2018 06:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbeJZOqy (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 10:46:54 -0400
Received: from mail-it1-f175.google.com ([209.85.166.175]:51146 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeJZOqy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 10:46:54 -0400
Received: by mail-it1-f175.google.com with SMTP id k206-v6so318043ite.0
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 23:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W4gFagwe/G8VdrXuCUrfWmHBMFc67C9YLhroUJzelAE=;
        b=A0p8Rq5MLdeNW3bKzNkST2+2bhf7+ggLFina0Y4YJ4zYevE1dtf/sjPFzgWC01kJ1M
         m166i3qlpN47lN25/VfrIDodbs11b802mIRP+e+Qd7Rn4GRzNud/5haFXzVhc4zu6kQ2
         M30vIjWZdmZvOkr6tj/XQOH5fSWRBSld94q/OcFtAY7DPW+mix8B9Jh7itLGRbTLAR0w
         SKzCGVj5hF4iA61csljkvhFP+QIrMhfwkvktEwwSIMKpZ9leP5G6LHaUq5eJ9+A4/EHR
         x6Q4Z+tGpKXhUnoDf+ZzoRwyvxpAM2qK8XyVXShYA4Z2bTqqhEa4y43Wygm4E46a5x0K
         gXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W4gFagwe/G8VdrXuCUrfWmHBMFc67C9YLhroUJzelAE=;
        b=AEVnL0INbRTkm2ngskWFtgpdKCseqF1NtpikfSX2vO64GoJAJMbQAf26RspriOPvaQ
         F6c1h770wyxaHsDLmhBD8PzeiiS9zqjTbjjmUq/Tze//6WkaJPJiL4UVzq9E6K6hlV0C
         1iIyXoKSEbQph0xvBQ9AuGqJZEkzHbW7ACoOSm7yr5W9V2vr93GahKUC9FQcGNfktAtc
         kjAiC/2kkZqjXW98BamsbylkFsUwt6+doOn6vYxbhUolvdFcNv9xgoBhUp7ETb1zQwbn
         y7NYpB6KGot3egI5t4omlMwad1pRivmlazcVG4z3MhzaQQDvKU7DvZy1CWwasyLzMcKF
         YgBg==
X-Gm-Message-State: AGRZ1gJ/Ff63OrynPnJyOGsypeOiMT+lLUbwglhOn3BDmKuh545M11Ok
        cpQKzC2pShGBMzmGIKvJp4xRqjo5
X-Google-Smtp-Source: AJdET5clQb3Ljiset27/9ndcU/Gmiw9BvErjYE2qU65twmqm9W5Tv6CN+KJ0tCYCNbYje+pA0M74NQ==
X-Received: by 2002:a24:d703:: with SMTP id y3-v6mr3072967itg.154.1540534274288;
        Thu, 25 Oct 2018 23:11:14 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id u4-v6sm3651338iob.0.2018.10.25.23.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 23:11:13 -0700 (PDT)
Date:   Fri, 26 Oct 2018 02:11:11 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     liu.denton@gmail.com, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com, davvid@gmail.com,
        gitster@pobox.com
Subject: [RESEND PATCH v3 0/3] Add --gui to mergetool
Message-ID: <20181026061111.GA7242@archbookpro.localdomain>
References: <cover.1540398076.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1540398076.git.liu.denton@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a resend of patchset v3 where we add another patch on top of the
existing patchset in order to document the guitool keys for `git
config`. This way, the completions script will now be able to complete
these key values as well.

Denton Liu (3):
  mergetool: accept -g/--[no-]gui as arguments
  completion: support `git mergetool --[no-]gui`
  doc: document diff/merge.guitool config keys

 Documentation/diff-config.txt          |  8 ++++++++
 Documentation/git-mergetool.txt        | 11 +++++++++++
 Documentation/merge-config.txt         |  6 ++++++
 contrib/completion/git-completion.bash |  2 +-
 git-mergetool--lib.sh                  | 16 +++++++++++-----
 git-mergetool.sh                       | 11 +++++++++--
 6 files changed, 46 insertions(+), 8 deletions(-)

-- 
2.19.1

