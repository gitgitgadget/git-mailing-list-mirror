Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1ACE1F424
	for <e@80x24.org>; Mon, 18 Dec 2017 15:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758194AbdLRPr4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 10:47:56 -0500
Received: from mail-yb0-f175.google.com ([209.85.213.175]:46070 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752858AbdLRPrz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 10:47:55 -0500
Received: by mail-yb0-f175.google.com with SMTP id r4so11327547ybd.12
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 07:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=K7LZToK294QkcPswDcwXQSab0vBEE1PvXIkTR5dP+eU=;
        b=ju4/rTAHR4LZlsGIrpfuFTYTLVJHEd+1H+tFPx8CgAwRhkhn2g/K5frJlcTSpFC535
         BQGRg65Oa734+To5u+YUn5pq1ndfv2lLRRnr5Ww7uqZcU8arwR7/EZSs9w560TrOFBX/
         w/X4TKN3MfcAATlMpRkEY1sWCeuQtRspDWI0YTa32U34d/jkwgHIHH5uoatIksbM+AGs
         uSUXKcCmzFUMVfOsxcp0GXbUHutkcUSEFJK4wLgzqkLzHDhaNNabog/DohhmyShegao3
         uZQRrxYf+Wpg0LzTj143SR2Tta9bXaXJK3eagIZk/dzKqfzR5CK7A1f2Ru1NGPHYVYXa
         dNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=K7LZToK294QkcPswDcwXQSab0vBEE1PvXIkTR5dP+eU=;
        b=mxdJcyBHK2KX3shKDbLMECYSchkVX0X2nnj1isQhtC9u3CajKA4iLDayV7856Uva7z
         WqLuxyufaAOao4M5FXbs/bt0dTLc022NZnpeKy3QH1sRXcAA+kaQEhQdfiMLrmb0lHFF
         wEISWhQqDPFG1DdkYYIAOMjdz8uRJJcQwdL7ME1hLyJPQIHhQEfUWin5nazNH4aoiDXX
         nMtx9eMsL0MhkjLNqPTSowUxucrU7RfoGd6XOAZoFuEAugBclI0VBPEGPjO73eydrnZi
         uYdZ7G3UWSlOPFltQOiaLYjYIOg4bUwwgsfURLJ8CYQpAJiKWppxXsJqFTRxU4znqbSu
         /wkQ==
X-Gm-Message-State: AKGB3mKbv+hvntPdxON0dItG5t15QAXxSMyfJh/fJRdPBvjbjqIkbgiS
        FNis+pGTp7Kibp+2pQbp+DzsoyvKwt1pYGYtIZzHQyMQ
X-Google-Smtp-Source: ACJfBosvfQSF7ATC/pahiS0kQIU8+7c+Lue0f1d/G4S+D3poPdq5w4SYeZWGs9ALJPGcJNC/KND5LHMFN0s9BRm7bOs=
X-Received: by 10.129.152.134 with SMTP id p128mr141675ywg.438.1513612075011;
 Mon, 18 Dec 2017 07:47:55 -0800 (PST)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.129.103.65 with HTTP; Mon, 18 Dec 2017 07:47:54 -0800 (PST)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Mon, 18 Dec 2017 09:47:54 -0600
X-Google-Sender-Auth: pj-tkWnuut7tc5ZAMfFd70Nqif0
Message-ID: <CAHd499BwrEAxoGX++xRJz_p-_7Uh7vm=+FstRbCv1+wqeCiYbw@mail.gmail.com>
Subject: Usability issue with rebase fork-point option
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When upstream is not specified for the rebase command (e.g. I just do
`git rebase`), `--fork-point` is assumed which results in commits
regenerating SHA1 even if the merge-base would otherwise be identical.

Here's my scenario:

I set my remote tracking branch to my parent branch:

$ git branch -u origin

I do a status to see that I'm 1 ahead:

$ git status -sb
## feature/foo...origin/master [ahead 1]

I then execute `git rebase`:

$ git rebase
First, rewinding head to replay your work on top of it...
Applying: Fix state machine hang after integrity checking

Since my merge-base is already the tip of `origin/master`, I expected
it to say it was up-to-date, as it would if I disabled fork point:

$ git rebase --no-fork-point
Current branch feature/foo is up to date.


The expected behavior is that if merge-base does not change, even with
--fork-point enabled, that SHA1's do not get rewritten.

As a workaround, I've created an alias that always assumes --no-fork-point:

[alias]
    rb = rebase --no-fork-point


Possible long term solutions I'd be happy with:

1. A config option to disable fork point completely, something like
`rebase.forkPoint` and I can set it to `false`.
2. Change rebase to always assume `--no-fork-point` as a default,
which is opposite of the current behavior.
3. Assuming the behavior I'm observing is a bug, put more priority on
a matching merge-base instead of the reflogs, not sure of the
internals of how this fork-point behavior is implemented, but this
feels like the issue to me. The most ideal outcome is that this is a
bug and no interface or config changes are needed.

Would love to get feedback from the Git community on this. Thanks for reading!!
