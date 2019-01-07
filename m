Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76D661F803
	for <e@80x24.org>; Mon,  7 Jan 2019 14:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfAGOC2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 09:02:28 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35646 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfAGOC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 09:02:28 -0500
Received: by mail-ot1-f66.google.com with SMTP id 81so393889otj.2
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 06:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dqxtech-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=dEvEf5danmhcGtAuPNv7ALfCe4atew/kbNoINVbDjMs=;
        b=iefGrLOEdovTbpkFN/iC0zBh0m069hnF8dO6siHc3Z4v7IcEKWd2sYCyHZ/9riAfnv
         I7gwvJNr1oxE+n8a+OrDkTinXlTlxIQtlr3JJyb1acEmqQ+xyPb00WQiqp8xAvPwfCnP
         VsmKY3nIyTZcq9c10fxdVdCq8PZUTI6cvmuMCZpCZ75va7rW4SFcflLMafWYppHo50dm
         JGucLMNL5FCaaLhVXAaFZ019AGWBl2puKm+SLbeQWB3oqp2S0EQs1uf8OCeNJriNmd/w
         xJ4jFnhbzdbMPk3IdtAYgjgV3aBqSuBWfw8DR3sDL2SCymqGFZsv/Ocwf3T+WdlP/VEl
         szOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dEvEf5danmhcGtAuPNv7ALfCe4atew/kbNoINVbDjMs=;
        b=TaX7YMvvnwDh8sLZo0IZlJADJbktv5SxN+B3FofIx0yR0axlxKycJZRrKLd9eq4CBF
         4z9RtjXmXIponff7nbPL8i4D2ONS1kiW+IE35QM6OL/fWWKBCIuwmQZp86Xn1XPyQass
         +sIwW3c/EZdJN3dKbjC9ImwgnHTIhbiLigOnKq9CnjgcYMhk9m+sphlMtFWFqceQKyZX
         zEdbud6M/Kt5yjAZX1jyS4M2pkXvYW2Dp1/phEZtIWQQJBQPu0yoQ/dlbCfN5fYZsdXi
         bLqOEE7FrxN17zskS8UhmDujhPxXwIJEwqUFDv2XLd0niTd7t9H+h1mDhfuBSINadupQ
         VgaA==
X-Gm-Message-State: AJcUukcSNddAwfLoCOkAIf4g3Ao4HVQLKC7QCzw4LIBAPdEXagFYndsr
        XO06l8Lop8sVzV+KGKJsii24fRdkEz8=
X-Google-Smtp-Source: ALg8bN7C64qHtYyU1MGqIf7TKP82+tgqkkzV68sdpgp3oZknwOKr+z7vBH/bcDtyvH7UPld5Ff6UpQ==
X-Received: by 2002:a9d:6419:: with SMTP id h25mr45436049otl.34.1546869746798;
        Mon, 07 Jan 2019 06:02:26 -0800 (PST)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com. [209.85.210.50])
        by smtp.googlemail.com with ESMTPSA id t2sm29763903otl.4.2019.01.07.06.02.25
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 06:02:26 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id t5so396332otk.1
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 06:02:25 -0800 (PST)
X-Received: by 2002:a9d:638f:: with SMTP id w15mr25177613otk.230.1546869745691;
 Mon, 07 Jan 2019 06:02:25 -0800 (PST)
MIME-Version: 1.0
From:   Andreas Hennings <andreas@dqxtech.net>
Date:   Mon, 7 Jan 2019 15:02:14 +0100
X-Gmail-Original-Message-ID: <CAH0Uv3Eu7bGSVaJKu6kDjp0BPRe0yROucDfJ8QHV3X_ZjNJT7g@mail.gmail.com>
Message-ID: <CAH0Uv3Eu7bGSVaJKu6kDjp0BPRe0yROucDfJ8QHV3X_ZjNJT7g@mail.gmail.com>
Subject: Feature request: --preserve-merges to add "exec git merge ..."
 instead of "pick ..."
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
(this is my first message on this list, so hello everybody. I hope I
found the correct channel.)

I recently discovered the --preserve-merges option in git rebase,
I think it is nice, but it does not always do what I intend.

I am proposing a variation of this option which would behave differently.

## Use case

We have an acceptance branch that is frequently rebased on master.
At any given time, the acceptance branch should start with master, and
then merge in those feature branches that were selected for acceptance
testing.
Nobody is supposed to work on acceptance, it is only meant for
deployment on the acceptance server.

This means we need a rebase operation where:
- The commits of the acceptance branch itself are being replaced.
- The commits of the feature branches remain as they are.

A "git rebase --preserve-merges" almost does this, but not really.

## Proposal

Add a new option for rebase, similar to --preserve-merges, where:
Instead of "git pick MERGE_COMMIT", we get this line in the rebase
editor (if using the -i option):
exec git merge MERGE_COMMIT^2 -m"Merge FEATURE_BRANCH into acceptance."

In --interactive / -i mode, the developer can leave these lines as
they are, or replace them manually to merge a more recent version of
the feature branch.
E.g. replace this
exec git merge MERGE_COMMIT^2 -m"Merge FEATURE_BRANCH into acceptance."
with this
exec git merge FEATURE_BRANCH_RECENT

This would achieve the behavior as described in "Use case".
I have not thought about a name for this option yet, I first want to
see some general feedback.

Possibly related:
https://public-inbox.org/git/87y3jtqdyg.fsf@javad.com/
I think the author of this RFC has different expectations what a
rebase should do, so it is not really the same.


------------

I hope this was the correct way to propose this kind of feature. If
not, let me know where I can find more information.

Greetings,
Andreas Hennings
https://github.com/donquixote
