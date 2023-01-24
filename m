Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AACBC54E94
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 22:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjAXWaR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 17:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjAXWaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 17:30:16 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031271BFD
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 14:30:15 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q9so12267640pgq.5
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 14:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VJ7nDtK8ui10xm6X1ejc9SDKtr9u0TH8z2hE3Hjx3K8=;
        b=plBJa8MSc1+f/DisEd/o5DhA6BBKPidbhNoV2dKl3Jhi9HSyuoGWSWYBBr5tCsAqsF
         +u6gGktj5amagAAtCs02eYu81zaS6RpDL+IU9H/cj92CIMKkqn36fUcBazHGSoCHlRx6
         NXbWHjlIyuGSvCnHthx2ZGDawT+VkB+VLeP46qEk1G37a25/Sct8blGC6MDvkYtKPdjF
         Zhw6HDuBXR3GCNECvbrm2jayBRIn2YPpt1f+GzW5ysDPPn6HnDrDiwWXTuY753QjVXiV
         kFCfrlhq6JjZqZq//6WMUZZ4CdQOUhnkF8WVsBn/HAC4nHOb4Ob9B/1NDx6C/lbh3UrT
         AgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJ7nDtK8ui10xm6X1ejc9SDKtr9u0TH8z2hE3Hjx3K8=;
        b=P8gHi6EkmgaxLh5nM9oCnA9NObXZ/iCygdGwfqQH0bXL7me8/tPBRE0Cp6QIbFeiqP
         WyMy/xQ2yhUgbG2gdZE2FISqSHyet4O39/LEhlpgE8xPKJ+ar1Tx7Ut69g/5U9WBlOzC
         ih7op5TPx6QApRx/+AzKIW2INIYQxTW/U54o4uOvsh4EcN3gPcINTDvAM3YWLU43yUcz
         Sr14Cd9HUFGmJVb/lbtopKz6fMWIos7hr7DDNGX/TyctcS96Vh4UHf3FWKfeqZBxMi3I
         qz9m1plN8AzXHxQnMzVPrFXsnLF076hr5HUyJzo3ft9Bdnx1kjTR1/sa6UtRaE6LxSGL
         mBxA==
X-Gm-Message-State: AFqh2kr23nzL1DtAlpXtBWpl7Rwrtq8Hyz5bn1FK5zch059QnxhA3Ebx
        W8euivdAKMb88+ziOwhSNDGqYLHAlJI=
X-Google-Smtp-Source: AMrXdXvjlF0Cg4qE6cugV8IOuQi/3yCh5CKWazwsCLbcjmSU2q9qCLcplwi4GC+SsYbFBIs3GVOmCA==
X-Received: by 2002:a05:6a00:26cc:b0:589:62bd:14d with SMTP id p12-20020a056a0026cc00b0058962bd014dmr29009576pfw.1.1674599414067;
        Tue, 24 Jan 2023 14:30:14 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a28-20020aa78e9c000000b0058193135f6bsm2114733pfr.84.2023.01.24.14.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 14:30:13 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: A summary of in-flight topics
Date:   Tue, 24 Jan 2023 14:30:13 -0800
Message-ID: <xmqq7cxbftvu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I hate to send out new issues of the "What's cooking" report too
often, but we have too many in-flight topics that are not getting
traction they may deserve, so let me send out a summary of the
topics listed in the draft I have for the next issue of it.

Those that are marked as "will merge to 'master'" won't be merged
immediately; they usually spend at least 1 calendar week in 'next'
(the second date on the line for each topic is the date they were
merged to 'next').

--------------------------------------------------

Expecting a (hopefully final) reroll.
 - ms/send-email-feed-header-to-validate-hook                   01-19          #2
 - cb/checkout-same-branch-twice                                01-20          #1
 - rj/avoid-switching-to-already-used-branch                    01-22          #3

Expecting a hopefully minor and final reroll.
 - ab/avoid-losing-exit-codes-in-tests                          12-20          #6

Expecting a reroll.
 - tl/notes--blankline                                          11-09          #5
 - ab/tag-object-type-errors                                    11-22          #5
 - ab/config-multi-and-nonbool                                  11-27          #9
 - cb/grep-fallback-failing-jit                                 12-17          #1
 - ja/worktree-orphan                                           01-13          #4
 - tc/cat-file-z-use-cquote                                     01-16          #1
 - rj/branch-unborn-in-other-worktrees                          01-19          #3

May want to discard.  Breaking compatibility does not seem worth it.
 - so/diff-merges-more                                          12-18          #5

May want to discard.  Its jaggy edges may be a bit too sharp.
 - cc/filtered-repack                                           12-25          #3

Needs review on the updated round.
 - ed/fsmonitor-inotify                                         12-13          #6

Needs review.
 - jc/spell-id-in-both-caps-in-message-id                       12-17          #1
 - ad/test-record-count-when-harness-is-in-use                  12-25          #1
 - cw/submodule-status-in-parallel                              01-17          #6
 - ab/sequencer-unleak                                          01-18          #8
 - ab/various-leak-fixes                                        01-18         #19

Undecided
 - rs/tree-parse-mode-overflow-check                            01-21          #1
 - rj/bisect-already-used-branch                                01-22          #1
 - ab/hook-api-with-stdin                                       01-23          #5
 - ds/bundle-uri-5                                              01-23         #10

Waiting for review response.
 - mc/switch-advice                                             11-09          #1
 - js/range-diff-mbox                                           11-23          #1

Will merge to 'master'.
 + ab/cache-api-cleanup-users                                   01-17/01-18    #3
 + sa/cat-file-mailmap--batch-check                             01-18/01-18    #1
 + km/send-email-with-v-reroll-count                            11-27/01-19    #1
 + pb/branch-advice-recurse-submodules                          01-18/01-19    #1
 + jc/doc-branch-update-checked-out-branch                      01-18/01-19    #1
 + cb/grep-pcre-ucp                                             01-18/01-19    #1
 + jk/hash-object-literally-fd-leak                             01-19/01-19    #1
 + cw/fetch-remote-group-with-duplication                       01-19/01-20    #1
 + jc/doc-checkout-b                                            01-19/01-23    #1
 + po/pretty-format-columns-doc                                 01-19/01-23    #5
 + jk/hash-object-fsck                                          01-19/01-23    #7
 + en/rebase-update-refs-needs-merge-backend                    01-22/01-23    #9
 + tb/t0003-invoke-dd-more-portably                             01-22/01-23    #1
 + jc/attr-doc-fix                                              01-22/01-24    #1
 + ar/markup-em-dash                                            01-23/01-24    #1

Will merge to 'next'.
 - mc/credential-helper-auth-headers                            01-20         #12

Will merge to 'next'?
 - en/ls-files-doc-update                                       01-13          #4
 - as/ssh-signing-improve-key-missing-error                     01-24          #1
