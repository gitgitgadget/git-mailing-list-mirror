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
	by dcvr.yhbt.net (Postfix) with ESMTP id 79A531F461
	for <e@80x24.org>; Sat,  7 Sep 2019 14:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391199AbfIGONO (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 10:13:14 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37750 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388458AbfIGONO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 10:13:14 -0400
Received: by mail-lf1-f68.google.com with SMTP id w67so7255760lff.4
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+dh2i0E3KjHBj7pMpck6dZTbMGXpcIqTR2OEAjdwFgE=;
        b=OPOxDri+gkwLFX5433rH4UYvku/zDBgmjBTYzW7OT1Qu+YBq9PhSI5eCMdI/dVzmCA
         y38QOtoMdFUfwgB35743xfdAm+ZBuvVoXQGAczpOaNJ27M2+8CJNqmmYAzitXxAAKzBn
         HoWU5G9FyVcNBJe3AcM08/J1k5R/3cJ6P0LR0Kcwp55rNshjlNdUvyT8+2V/XrKNjnGy
         GL70jXmxJItSZEqU08oJHq6T3v7Z+UruXNPukoSfewv9+1BvPvFFumnmPLowpjVGcwqX
         uKkXHI8UMxnB3ycDtKSfK7pLynY27kUzip9lfk869J6mjPjH0NEVsOVSymOhWDdakuh2
         orhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+dh2i0E3KjHBj7pMpck6dZTbMGXpcIqTR2OEAjdwFgE=;
        b=EN+aXbD+5kyikaLD4Pm9jFpewaWqzHOypuuklTYAWzGFb1T7BrEtBGJ6YRZzBBxE4Z
         +An5JbIG1EiyqDPg+STGon9J6P4gVMf8IS73fxNteMcnJxqNPZQrhshT1K+oIvTW4CB7
         fMuBWoagn3EpHK0rQlynBWIlg7rWTnNrdVAyePSxF9wAqcDMpIcNCaayBlc9PEipco84
         WJMKDaQfmaB5dwmQF+MgPzkYXn1KRwlgRx3E4XKd5f7nsu9lxrZ/eUvRjJDzqRmQv5t8
         3I/AIGm3165EsQydUQftrK3WKEz9lNEpUNH3Hfg+IyDmKBt1zPnEEfZjDqQO3n+yQmYf
         6HSQ==
X-Gm-Message-State: APjAAAUjmz6jmTgio+t8fJjyhF1yAveJnIl20kg1GFdua+nDYWDYvdyO
        tLbMPS6748pWObi6xL6e4hHIKy5h
X-Google-Smtp-Source: APXvYqx/+xXLIAaVH5d6rsAD43x5OQzhbnZT0Pr7exUrDZ5wxsYN1KGoE35/yQww7WQBgeb2SS4yJA==
X-Received: by 2002:a19:6455:: with SMTP id b21mr10386280lfj.167.1567865591511;
        Sat, 07 Sep 2019 07:13:11 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id u10sm1741316lfk.34.2019.09.07.07.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 07:13:10 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 0/7] Fix more AsciiDoc/tor differences
Date:   Sat,  7 Sep 2019 16:12:46 +0200
Message-Id: <cover.1567707999.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series roughly halves the line count of `./doc-diff --from-asciidoc
--to-asciidoctor --cut-header-footer HEAD HEAD`. Together with my recent
(independent) mini-series [1], I claim that Asciidoctor 1.5.5 now
processes the manpages better than AsciiDoc 8.6.10 does.

Patch 6/7 actually changes the rendering with both engines, so that they
look nice and the same. The other patches are all no-ops with one engine
while fixing things with the other -- they all improve the situation
with Asciidoctor (which is what I care most about) except patch 1/7
which goes the other way (it reduces the doc-diff, which helps).

Patch 7/7 has an element of black magic to it. I wouldn't be too
surprised if I've managed to appease my particular versions of these
tools while not fixing -- or maybe even breaking? -- some other versions
[that people actually use]. That's where I think a quick test would be
the most valuable.

I've based this on maint on the assumption that these are bugfixes. (I
know I've been bad on basing similar work off of maint.) This causes a
conflict with master and pu in config.txt, which has learned about
"includeIf onbranch:foo-branch" in the meantime. Maybe I've made the
wrong call here -- Junio, if you'd rather have me submit this on master,
just let me know.

[1] https://public-inbox.org/git/cover.1567534373.git.martin.agren@gmail.com/

Martin Ågren (7):
  Documentation: wrap blocks with "--"
  git-merge-base.txt: render indentations correctly under Asciidoctor
  Documentation: wrap config listings in "----"
  git-ls-remote.txt: wrap shell listing in "----"
  git-receive-pack.txt: wrap shell [script] listing in "----"
  git-merge-index.txt: wrap shell listing in "----"
  gitweb.conf.txt: switch pluses to backticks to help Asciidoctor

 Documentation/config.txt           | 84 ++++++++++++-------------
 Documentation/git-commit.txt       |  8 ++-
 Documentation/git-config.txt       | 56 +++++++++--------
 Documentation/git-ls-remote.txt    | 32 +++++-----
 Documentation/git-merge-base.txt   | 98 +++++++++++++++++-------------
 Documentation/git-merge-index.txt  | 26 ++++----
 Documentation/git-receive-pack.txt | 52 ++++++++--------
 Documentation/git-send-email.txt   | 12 ++--
 Documentation/git-status.txt       | 18 +++---
 Documentation/gitmodules.txt       | 15 ++---
 Documentation/gitweb.conf.txt      |  6 +-
 11 files changed, 223 insertions(+), 184 deletions(-)

-- 
2.23.0

