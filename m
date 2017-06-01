Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B92E20D12
	for <e@80x24.org>; Thu,  1 Jun 2017 00:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbdFAAa6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 20:30:58 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36612 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdFAAa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 20:30:57 -0400
Received: by mail-pf0-f179.google.com with SMTP id m17so21555621pfg.3
        for <git@vger.kernel.org>; Wed, 31 May 2017 17:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M8vw1ETOAqTgx+vWEHoPD82RN9Sd12UffMfncOTbtIg=;
        b=p6AJnP7TjIfkrl3aAwwm5StzqhzibjxpAf8BgLTkqNoQDq2gJbmpprWlVlO4OsN7ct
         mWxySjVmCMK2JHp8x2qaNnQeky6+c1RT/oQ2uU+0O+ptHHhmLfZ3iQl0am1GcmQotQJM
         FV98VK2rj0+pIMbJYpTLuEy3d//WyNL+8Hr6bGqff8VJWi+PDO+23uhlKpleiA9dwnnM
         g2DDX3xN3N6JdOMY5y82qy89tvaWNpRsmEqj8d/apuKvKxR5B2UMbgIPsEP8hygzQSZN
         za7hVGdksh00T6a/hlRHOANKd4ZC43OxXvXxJE7oopWKbeCDE2e/kfrq6+kdPNHa3q0w
         pyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M8vw1ETOAqTgx+vWEHoPD82RN9Sd12UffMfncOTbtIg=;
        b=cJukOWnvliT+sscG/pRn4hkEph8QmEOrImKOzkyQuBFWxhX7pVzYnp++EqYq/gHist
         ZZ6tS/e5qEa96bQPwAPjDXM2OL0dA4vGxgBUuKli8+ZHl3YjTkdfQLihrnxKT9/s4cBw
         MNF4fknjC8Uu3bQMisEIHx/7juchJvkcMwPeoHo6Jlez5ioCNg9p35qSpoP9vVFqy6+d
         33Sg8gJJkPeD8Wby5RvtBJeeQNaRuBBaQvt6qIvwyaLgJ6pksmaP38GFEf40/kRfuNu6
         6a3c+Ac05gcC9E4cI19416es6Y2P+7AlmudUFEhjYOpgYwj1ctp261FfSIr5dUxR7gCu
         tvkg==
X-Gm-Message-State: AODbwcCKZAdiMeoUxHvPU2j0ACDuEVoHgrc26pFxZ+NLXBMz/s9C6esp
        QxUiJbwzO1CTb0Kd
X-Received: by 10.99.181.67 with SMTP id u3mr6104136pgo.89.1496277056481;
        Wed, 31 May 2017 17:30:56 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7872:b8ac:87ee:2203])
        by smtp.gmail.com with ESMTPSA id e80sm728428pfh.121.2017.05.31.17.30.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 17:30:55 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, git@vger.kernel.org, sbeller@google.com
Subject: [PATCHv3 0/4] A reroll of sb/submodule-blanket-recursive
Date:   Wed, 31 May 2017 17:30:46 -0700
Message-Id: <20170601003050.4221-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.17.gab62347cd9
In-Reply-To: <xmqqa85udi92.fsf@gitster.mtv.corp.google.com>
References: <xmqqa85udi92.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3:
* rerolling only the top-4 patches of sb/submodule-blanket-recursive.
  (base: 1d789d089280539ca39b83aabb67860929d39b75)
* fixes function declarations that should be static, thanks Ramsay!

v2:
* A reroll of sb/submodule-blanket-recursive.
* This requires ab/grep-preparatory-cleanup
* It changed a lot from v1, as in v1 the tests did not work,
  hence the code was broken. Now it actually works.
* it also includes grep, fetch, push in addition to plain working tree
  manipulators.

Thanks,
Stefan

Stefan Beller (4):
  Introduce 'submodule.recurse' option for worktree manipulators
  builtin/grep.c: respect 'submodule.recurse' option
  builtin/push.c: respect 'submodule.recurse' option
  builtin/fetch.c: respect 'submodule.recurse' option

 Documentation/config.txt           |  5 +++++
 builtin/checkout.c                 |  2 +-
 builtin/fetch.c                    |  7 +++++++
 builtin/grep.c                     |  3 +++
 builtin/push.c                     |  4 ++++
 builtin/read-tree.c                | 10 +++++++++-
 builtin/reset.c                    | 10 +++++++++-
 submodule.c                        | 23 +++++++++++++++++++++--
 submodule.h                        |  1 +
 t/lib-submodule-update.sh          | 12 ++++++++++++
 t/t5526-fetch-submodules.sh        | 10 ++++++++++
 t/t5531-deep-submodule-push.sh     | 21 +++++++++++++++++++++
 t/t7814-grep-recurse-submodules.sh | 18 ++++++++++++++++++
 13 files changed, 121 insertions(+), 5 deletions(-)

-- 
2.13.0.17.gab62347cd9

