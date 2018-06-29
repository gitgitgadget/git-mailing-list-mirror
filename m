Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C10D61F516
	for <e@80x24.org>; Fri, 29 Jun 2018 12:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755271AbeF2MQP (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 08:16:15 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:37173 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754720AbeF2MQO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 08:16:14 -0400
Received: by mail-pg0-f48.google.com with SMTP id n15-v6so692900pgv.4
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 05:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rZNzH4/wuHcYLb06mXDiLf1QfSmntGcqrUDjGDLO9Jc=;
        b=PiAJOlzXg2jaQ9SMSBgmk3+aB9seVn+lIqQnRAVplRKoX/88RHBwTF/xTGetNuXZ1I
         nYa0YhiTzKCwG3W4nPQ54n1fJcTov0eaAIWvNC7F74DreizC2lsPNA3+xW/1/c3qwsfu
         CjwcWKfXNqYTBm4+HzqxXYxpBimSHUKaBQDQGG+WqEgHk0W7xxsUELZRCK6AdQ0tc+v8
         RyP1cfqfPt/ttxFWMmGOdRaxHjOlPpGlPhpYfFYX+WOgPEtEg29jzCb0NKu6DcR9vKoa
         VfZlSFxxutIGaqfiQx9XHD/C5OYksUK1+Z82y+QtpHa+vb4T9YevCHiU1D3jCWM0HoP8
         pk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rZNzH4/wuHcYLb06mXDiLf1QfSmntGcqrUDjGDLO9Jc=;
        b=YBiBq1SxH2twY+IJdmJz/ecNr8LFK/IcHM7ad0E3VdBBgGuH2tfABzau9eMidKkW94
         Ad62B+cvzSpw+typzHEidLuK8w4HVhDg3O/TboYQQy20WYydKneL+BpwEi4NPz9rQosw
         AM85iVaNjPDwQc+RVzuTxC8laZXxxwmsLo3piGTmHr/x+MjvjqIJ/UiNnx6hyVMhbcDk
         nB+moGPVA+WvuTXj2jkzZH8Wl51c8Ojos3Evj/dc8FtOeTV8I+kFoyoD5kiJq7K52MaF
         VgLk+vIgrJcbP0JHJ7CqjeyywZE0kNgjXD4i+JU0FS7GYUolgsKhbVaWLhRt0WyLW9us
         9aVQ==
X-Gm-Message-State: APt69E272IzYUwLiGydlstnTf3P1OQg4YFr2OaRMsrONPYdCEPPwjWyv
        u/nBPor0pd+DX+9vS6YZbJx3pg==
X-Google-Smtp-Source: AAOMgpeJAo4VFtwRYNd+Ji/84kPKOxbXIHbqvMCUeWCG6XTUEkQ35TBaDYdwwlTVNCm6O+ZP9mV0Cw==
X-Received: by 2002:a62:1f06:: with SMTP id f6-v6mr7157321pff.140.1530274573777;
        Fri, 29 Jun 2018 05:16:13 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id u13-v6sm12829816pgr.36.2018.06.29.05.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 05:16:12 -0700 (PDT)
Message-Id: <pull.7.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.7.git.gitgitgadget@gmail.com>
References: <pull.7.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jun 2018 12:16:11 +0000
Subject: [PATCH v2 0/1] Fix "built from commit" logic
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

When I tried recently to build macOS installers via Tim Harper's wonderful project at https://github.com/timcharper/git_osx_installer, it worked (with a couple of quirks), but it reported to be built from a commit that I first could not place.

Turns out that the git_osx_installer project insists on building Git from a .tar.gz file (even if I have the source code right here, in a perfectly fine worktree). And due to a bug in the logic I introduced, it did not
stop looking for a Git repository where it should have stopped. The end effect is that `git version --build-options` reports being built from  git_osx_installer's HEAD.

This commit fixes that, and also suppresses the error when no repository could be found.

Changes since v1:

- the commit message now sports an explanatory paragraph, copy-edited from Peff's reply.

Johannes Schindelin (1):
  Makefile: fix the "built from commit" code

 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


base-commit: e3331758f12da22f4103eec7efe1b5304a9be5e9
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-7%2Fdscho%2Ffix-build-options-commit-info-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-7/dscho/fix-build-options-commit-info-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/7

Range-diff vs v1:

 1:  e0e41d0b8 ! 1:  aca087479 Makefile: fix the "built from commit" code
     @@ -15,6 +15,11 @@
          Except that we got the quoting wrong, and that variable therefore does
          not have the desired effect.
      
     +    The issue is that the $(shell) is resolved before the output is stuffed
     +    into the command-line with -DGIT_BUILT_FROM_COMMIT, and therefore is
     +    *not* inside quotes. And thus backslashing the quotes is wrong, as the
     +    quote gets literally inserted into the CEILING_DIRECTORIES variable.
     +
          Let's fix that quoting, and while at it, also suppress the unhelpful
          message
      

-- 
gitgitgadget
