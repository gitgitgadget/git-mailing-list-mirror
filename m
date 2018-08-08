Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CC96208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeHHRmp (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:42:45 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45814 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeHHRmp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:42:45 -0400
Received: by mail-ed1-f68.google.com with SMTP id s16-v6so1428593edq.12
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GBkzCwGdsGKYvksIbDxh+ObwPRX94moxDD+JswjLQ3s=;
        b=Wp5e0xgVX3+YAiGnktFgvK+j8WAEC2qOTz5bR1lewO0zBocjVxf58X2cJBwixycl2R
         fLtyaCxOvDyW0yH/DlwYKRCRpdQWG5NhSw8qARAnb4dAMerz3tNX/chHBpshUQ0IrLMg
         ajCUH6dVSp9UDHXQxrpUtW8N9GbSbhDWZpIHfIrBE4bR56/3PoOTuICXiG2Uu5Ycmt3C
         sPX80sGVckWstHVyIWaA6ENFh8hrNB4Lf9SwEUYu916WP74z4bit8Np0QFFcFLltWV3E
         G9887LVosWLNLfOUTg31MABHA5+GpDJ1tACMrGTAtFRGXZrcxRXtugbORzLD1JlDZG7t
         dyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GBkzCwGdsGKYvksIbDxh+ObwPRX94moxDD+JswjLQ3s=;
        b=KM11NNQ8M22ns+xUyR1NxOFELv5vwKa3ZthapdoWrriEsFQ9+c+TqkzE1QGIUjqc3V
         Si1cJuQQyLVhhrrK3UZLDN6p5U93foonIDo90Q8gGwLWVdvC99b2Vg4Kx5LRP/m/Ei68
         sNSIMSWq0M94zGm1/Um/vds3YCdB97J3yGYg4k6NQsRyqBnQLBZ84E0hWUbqdU5HKW5T
         ggFZPPPFuYWAwdXT4aK+KEWCpIORynOFP+Jb+oDsGWPtfMi8qwVD6H6Mj3BUFrhExi33
         d15ZWGSwSihQ+tCmgz8VHEj3IMGwGg1xiTMeYJPA3RUlM+UQOdU+U2JFKnNE83gzEmux
         N6vg==
X-Gm-Message-State: AOUpUlGf/Mwg0C52QiJfdH5Nrs8l98YE/XTQgtU8QgEN2wBdJSBywCv5
        /Rk6egMi7wS5jDnN8rTX/w1TUf1A
X-Google-Smtp-Source: AA+uWPxaB3RgkqaVN26mK9VQqZcLiolQIRh3+QmpGu6WVzEdbc70ecTKQaBstVPxM+sMFLI3MxxtQQ==
X-Received: by 2002:a50:9182:: with SMTP id g2-v6mr3803695eda.24.1533741756668;
        Wed, 08 Aug 2018 08:22:36 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id v56-v6sm6058572edm.97.2018.08.08.08.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:22:35 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [GSoC] [PATCH 00/18] builtin rebase options
Date:   Wed,  8 Aug 2018 21:06:22 +0545
Message-Id: <20180808152140.14585-1-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series completes the support for all rebase options in the
builtin rebase. This converts the remaining command-line options.

The previous patch series taught the builtin rebase to handle different
actions, this patch series will continue adding functionality to
builtin rebase by teaching it to handle options handled by original rebase
i.e. `--signoff`, `rerere-autoupdate`, et al.

It adds the functionality to the previous patch series,
(https://public-inbox.org/git/20180808150622.9614-1-predatoramigo@gmail.com).

This is the fourth patch series that brings us more closer to a builtin
"git rebase".

If you like to view the development branch, you can view
(https://github.com/git/git/pull/505), where I have kept my commits up to date
and leveraged Travis(there is sporadic failures in t5520 for macos gcc and
isn't due to my patches) for extra testing other than my system.

The next in line patch series which I'll be sending out today are:

builtin rebase rest: The builtin rebase will convert all the remaining shell
scripts from the original rebase to C.
default to builtin rebase: This will turn on the feature-complete builtin
rebase to on.

These patch series are built on top of each other, i.e. they depend on this
order.

Pratik Karki (18):
  builtin rebase: allow selecting the rebase "backend"
  builtin rebase: support --signoff
  builtin rebase: support --rerere-autoupdate
  builtin rebase: support --committer-date-is-author-date
  builtin rebase: support `ignore-whitespace` option
  builtin rebase: support `ignore-date` option
  builtin rebase: support `keep-empty` option
  builtin rebase: support `--autosquash`
  builtin rebase: support `--gpg-sign` option
  builtin rebase: support `-C` and `--whitespace=<type>`
  builtin rebase: support `--autostash` option
  builtin rebase: support `--exec`
  builtin rebase: support `--allow-empty-message` option
  builtin rebase: support --rebase-merges[=[no-]rebase-cousins]
  merge-base --fork-point: extract libified function
  builtin rebase: support `fork-point` option
  builtin rebase: add support for custom merge strategies
  builtin rebase: support --root

 builtin/merge-base.c |  81 +-------
 builtin/rebase.c     | 449 ++++++++++++++++++++++++++++++++++++++++++-
 commit.c             |  81 ++++++++
 commit.h             |   2 +
 4 files changed, 528 insertions(+), 85 deletions(-)

-- 
2.18.0

