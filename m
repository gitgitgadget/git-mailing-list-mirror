Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4D241FE90
	for <e@80x24.org>; Tue, 18 Apr 2017 09:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756540AbdDRJaA (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 05:30:00 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34571 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753314AbdDRJ3K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 05:29:10 -0400
Received: by mail-wr0-f196.google.com with SMTP id u18so23921773wrc.1
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 02:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G9nmyxCZR1jyrqeugFdG52hq7zLUHiYnVWVUcY99wxY=;
        b=oZSAwHzYvBIKlos/XUF/Xv+j0JUqSWi4sltQ2UKu3XtVCALDBsT/7WQkYHC7LIt5c3
         qoO51yKkBZpeECfhDhTGSuDBEY9o5sCt9BOylngj13JcwTqatCCgFpfE7mvH6JJKSZfk
         lDV+XyxnUYe6KSYoNNYhYapJbMMGyNrR8C67LSGxZaNehF2bbrtY2o6/bnWB4WsRz08W
         +ihkza2RnsZI+mpW6ZUHVF6+o2Qk7RHFhWFubE8LG58Ms6lWe3joP+8dnArvL86zbsId
         80CXmJ4kvTnWpQDIaeI0SaHNySJIQNWtw7OGIlPqaqYqx0nDezJLWLmzTDH75fVhyxOh
         ktWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G9nmyxCZR1jyrqeugFdG52hq7zLUHiYnVWVUcY99wxY=;
        b=rXYv02GW+zow1SvEXDeaPDltcYmli0XBnh/0RNN9DqDDaSYZtuPsWXa3eYnsxDJoNa
         yEn0r9PCWDKNp35jgNz6cHbAS5r/1kPQYX98OPwUUSqFbEy6KnePE1tQ/+dXw6JtceP4
         82wJwVG3OnLV1NfejqMJCO3jwYlu+VPNwX+OaBianTREyuv+K59Ylg7z/+mOXN7VSFFB
         mej6vnwLg8N16mG+MQFFlwa2/Fcw506ES6Fmyj82Ry3AoH1MTlkSzjo0MlFvCSZu1tSG
         s037I+f4lNShfKW0u/gibmsjtEjn3k+nIVyeabunf/i7TWhN52S+MUIW7FhcoRDpkLNQ
         2yaQ==
X-Gm-Message-State: AN3rC/7VyugT3b7w6Id2x2gZbLye3/9TpozSXaPOXgNeV18BmqjLfHhv
        oJGWr+pZhtAAR/Pb
X-Received: by 10.223.172.228 with SMTP id o91mr20992763wrc.122.1492507749392;
        Tue, 18 Apr 2017 02:29:09 -0700 (PDT)
Received: from localhost ([193.206.223.117])
        by smtp.gmail.com with ESMTPSA id o77sm18019032wrc.38.2017.04.18.02.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Apr 2017 02:29:08 -0700 (PDT)
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To:     Git ML <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH v4 0/3] rebase: --signoff support
Date:   Tue, 18 Apr 2017 11:29:02 +0200
Message-Id: <20170418092905.20097-1-giuseppe.bilotta@gmail.com>
X-Mailer: git-send-email 2.12.2.820.g78c033c3a1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow signing off a whole patchset by rebasing it with the `--signoff`
option, which is simply passed through to `git am`.

Changes since v3:

* --no-signoff is actually accepted;
* the paragraph documenting --signoff is now in the correct place and
  it mentions explicitly that the option is not compatible with
interactive mode.

The patchset is also available in the git repository at:

  git://git.oblomov.eu/git rebase-signoff

(Unrelated note: it just occurred to me while preparing this cover
letter that it would be nice if there was a way to combine `format-patch
--cover-letter` and `request-pull`.)

Some work about extending --signoff support to interactive rebases is
underway in the `rebase-signoff-ext` branch, but there's a lot of
corner cases to test and work-out, so I guess that'll be fore some
other time.

Giuseppe Bilotta (3):
  builtin/am: obey --signoff also when --rebasing
  builtin/am: fold am_signoff() into am_append_signoff()
  rebase: pass --[no-]signoff option to git am

 Documentation/git-rebase.txt |  5 +++++
 builtin/am.c                 | 39 +++++++++++++++++--------------------
 git-rebase.sh                |  3 ++-
 t/t3428-rebase-signoff.sh    | 46 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 22 deletions(-)
 create mode 100755 t/t3428-rebase-signoff.sh

-- 
2.12.2.820.g78c033c3a1.dirty

