Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 678251F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 17:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436639AbfJQRfM (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 13:35:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34097 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbfJQRfM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 13:35:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id j11so3333388wrp.1
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 10:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wU6udtJLxIS2hE5eQ+GhSllpnGME+kZvACQIpKKREmM=;
        b=f/aAzui/cG+zTOF28bMfFMNwr2kuBHsWnx+0EN88Huezb9qpPjDzqMvukD382SPy8A
         RXSfIUy1nHO0JyNaYgQtpsymWlqZ7Ufeok4DGPRkLggo4cFlDgdwyQOktSmXISZQseGX
         bxoMrwoLuEqZ298ue1KH8zi+BjGZ4piBuzVEmCfdTDsfRCQWJbuDjd3pYuLaqOvFpm2U
         aFlcYqG3kyc3sbsh1Bn0XkjGLt2+lHqCbKJ9mKWReOUmt3akQR2jA26BS8xaFHsgNrmX
         wtPgDHjqACimGeK5KJYd9QxBb9p/wXaoyhz6DQI+Oj0DWoS6yG9ep4JxMIwzV7mOtXEU
         efWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wU6udtJLxIS2hE5eQ+GhSllpnGME+kZvACQIpKKREmM=;
        b=AEAt/leuEZehR1Dh+K3Jw7JEL70w3xCbYkpcuAD3L4xxPoHHPvbaVCNqZ+PYrTgxRE
         I7d//ygfOI+sNwn8wOJMBbp5BlAZz3xsLn/P2ci91JP5HQfYaexo2hmP/pcAhcMjj7hq
         CdcGTsUcg4F51LXbphepFKfJItD/yuj/KCsx38U+gov/pdP/NuVqdaOczDUjtj91T+tn
         dz/7Y0fqqiUBieADNEQb11R9igDr9AAj8CACIbFMNzz4k3NxoJOAs6c8doWDXe65dHnL
         dXMhTIOXRbSr/4CGvZoL7p7lYfbDjYUCfLHJJRjrBvVt6HZamvJjSm3XoZGfWV1fer7Z
         29Dg==
X-Gm-Message-State: APjAAAUyYV6GM6UN3ld+ZuHOYl/E+SCC/B8gnFQTEhYlWEOldPvNDkGT
        aK84dkFRe5waaWk0UzmBmak=
X-Google-Smtp-Source: APXvYqyjCtT408pz72oTkcTnSfRqsHPROSAxg0fMSQ7nhOLIWjEIRC/ovle7LxkSg/5COptoi0p2lg==
X-Received: by 2002:adf:a497:: with SMTP id g23mr3889578wrb.135.1571333709684;
        Thu, 17 Oct 2019 10:35:09 -0700 (PDT)
Received: from localhost.localdomain (x4db41bda.dyn.telefonica.de. [77.180.27.218])
        by smtp.gmail.com with ESMTPSA id f20sm2599876wmb.6.2019.10.17.10.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Oct 2019 10:35:08 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/6] completion: improve completion for 'git worktree'
Date:   Thu, 17 Oct 2019 19:34:55 +0200
Message-Id: <20191017173501.3198-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.1084.gae250eaa40
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Complete paths of working trees and refs for 'git worktree's various
subcommands.

The last two patches do the actual improvements, the first four are
preparatory steps.

An early version of the last patch was already sent to the list as a
PoC over four years ago [1], but I didn't like the part completing
options for 'git worktree add', and thus never seriously submitted it.
I still don't really like that part :), but it is really useful when
working with working trees, and at least other parts of the completion
function got simpler (thanks to automagically completing --options
via parse-options, and after the preparatory steps in this series).


[1] https://public-inbox.org/git/1440190256-21794-1-git-send-email-szeder@ira.uka.de/


SZEDER Gábor (6):
  t9902-completion: add tests for the __git_find_on_cmdline() helper
  completion: clean up the __git_find_on_cmdline() helper function
  completion: return the index of found word from
    __git_find_on_cmdline()
  completion: simplify completing 'git worktree' subcommands and options
  completion: list existing working trees for 'git worktree' subcommands
  completion: list paths and refs for 'git worktree add'

 contrib/completion/git-completion.bash | 117 +++++++++++++++++++------
 t/t9902-completion.sh                  |  57 ++++++++++++
 2 files changed, 148 insertions(+), 26 deletions(-)

-- 
2.23.0.1084.gae250eaa40

