Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D541BC43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbiF0Sxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiF0Sxr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:53:47 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED031091
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:53:47 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e2so14399531edv.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=CBHrRbjUZsMBmVeoHA+J20/esBeBJUJiCupSKI10bJs=;
        b=l4o/aWTsr4fQjzHmqNiHafeJNCZuY5CY3CubFZnxNlNGCO9s0dqGolif7pBUNJBT/n
         RnIbNLJzUBfrk0WJdNS6Drl5xzDpXlTv0DlKzqUAYH3cuq6m0GmYv7vi2Y80Sb9c6Zia
         d7LFmIc1QCU2eNFSIqoFI9cpBYzl4uPjZtEi0+zipVaxNsGbW5SYI8+ktvrQfewm3w+a
         CPj/qhgrSWUMeYtsKCeMZ+Bm1LYKIh6EyVXpjxTYdQiR0dEJm2qIwU6MKBoNrTPJu5am
         1Y0wEl1IEq5g/2Z5XQ3OlozN+khzus8sLtXRITx7CZTOtEq+Q9wOUjHqSTZlIny6Xfh+
         7Wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=CBHrRbjUZsMBmVeoHA+J20/esBeBJUJiCupSKI10bJs=;
        b=42ujfvEhTOK8DBOCPSjtuxjXjdKLttRPHWfgKftAQIfGOr2v/O4QVKuLakL4U6BvGA
         AuWhlxH6a9K8hg9rDXmB5ksJVms6sfvvT2aX0pUndpw7zpOt1urgdIMcljw7TY4VrgOe
         +0eDfqGLnZilZbOokidntR9+m7yAXoRvSAjVdl5+sjaH4jqn9HBc7Tz0urV82Tig7WZF
         bYiVSDICZ2TtSE7rejFfs1bvBsvI4WxBJ3ch7oglPzab3uk/cSYano0M19bCV2O9OIRw
         6ORtco3CgJihmBQF66xrDtUAsxAl8NzFFi4vbltZxfT8JrS/nGNTqp5YLNGFy0eUd50o
         6ceA==
X-Gm-Message-State: AJIora85y3WvWBZ3lpqLH9MTXypXQLpuUVvrUR3TzLPpvjvaUaTceCBC
        KLKO+3oTM0lalxL3FIn4So4Wc92avZs=
X-Google-Smtp-Source: AGRyM1td9npjob4NlTQkTkVxSIkF5Yi5zoD11i5miaU0LruaFmc61L0TeTytWzCWChzxE3hZKo6vvQ==
X-Received: by 2002:a05:6402:190d:b0:435:9683:bffa with SMTP id e13-20020a056402190d00b004359683bffamr18893719edz.309.1656356025712;
        Mon, 27 Jun 2022 11:53:45 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id p15-20020a05640243cf00b0042a2d9af0f8sm7858534edc.79.2022.06.27.11.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:53:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o5trk-001ctu-IW;
        Mon, 27 Jun 2022 20:53:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/* topics (was: What's cooking in git.git (Jun 2022, #08; Mon, 27))
Date:   Mon, 27 Jun 2022 20:51:29 +0200
References: <xmqqsfnqnezx.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqsfnqnezx.fsf@gitster.g>
Message-ID: <220627.86r13agcp3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 27 2022, Junio C Hamano wrote:

> * ab/squelch-empty-fsync-traces (2022-06-23) 1 commit
>  - trace2: don't include "fsync" events in all trace2 logs
>
>  Omit fsync-related trace2 entries when their values are all zero.
>
>  Expecting a reroll.
>  cf. <xmqqh74byy19.fsf@gitster.g>
>  source: <patch-1.1-df87e515efd-20220623T154943Z-avarab@gmail.com>

Will re-roll.

> * ab/test-quoting-fix (2022-06-21) 3 commits
>  - config tests: fix harmless but broken "rm -r" cleanup
>  - test-lib.sh: fix prepend_var() quoting issue
>  - tests: add missing double quotes to included library paths
>
>  Fixes for tests when the source directory has unusual characters in
>  its path, e.g. whitespaces, double-quotes, etc.
>
>  Expecting a reroll.
>  source: <cover-0.3-00000000000-20220621T221928Z-avarab@gmail.com>

Ditto.

> * ab/submodule-cleanup (2022-06-15) 12 commits
>  - git-sh-setup.sh: remove "say" function, change last users
>  - git-submodule.sh: use "$quiet", not "$GIT_QUIET"
>  - submodule--helper: eliminate internal "--update" option
>  - submodule--helper: understand --checkout, --merge and --rebase synonyms
>  - submodule--helper: report "submodule" as our name in "-h" output
>  - submodule--helper: rename "absorb-git-dirs" to "absorbgitdirs"
>  - submodule update: remove "-v" option
>  - submodule--helper: have --require-init imply --init
>  - git-submodule.sh: remove unused top-level "--branch" argument
>  - git-submodule.sh: make "$cached" variable a boolean
>  - git-submodule.sh: remove unused $prefix var and --super-prefix
>  - git-submodule.sh: remove unused sanitize_submodule_env()
>
>  Further preparation to turn git-submodule.sh into a builtin.
>
>  Will merge to 'next'?
>  source: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>

I have a locally queued re-roll of this addressing Glen's comments. I
don't think there's anything broken in this as-is, but hopefully
clarifying the --super-prefix situation a bit more will help.

> * ab/test-without-templates (2022-06-06) 7 commits
>  - tests: don't assume a .git/info for .git/info/sparse-checkout
>  - tests: don't assume a .git/info for .git/info/exclude
>  - tests: don't assume a .git/info for .git/info/refs
>  - tests: don't assume a .git/info for .git/info/attributes
>  - tests: don't assume a .git/info for .git/info/grafts
>  - tests: don't depend on template-created .git/branches
>  - t0008: don't rely on default ".git/info/exclude"
>
>  Tweak tests so that they still work when the "git init" template
>  did not create .git/info directory.
>
>  Will merge to 'next'?
>  source: <cover-v2-0.7-00000000000-20220603T110506Z-avarab@gmail.com>

Discussed in
https://lore.kernel.org/git/220627.86zghygdtd.gmgdl@evledraar.gmail.com/;
I think it's ready, but you've got some reservations.
