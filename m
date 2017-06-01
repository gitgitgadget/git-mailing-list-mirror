Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 141BF20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 19:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751130AbdFAT6G (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 15:58:06 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:32962 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdFAT6G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 15:58:06 -0400
Received: by mail-it0-f48.google.com with SMTP id w68so4436903itc.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 12:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T5P/j9C+36H4YH5gUFmWtYlaI9Dq5dVmlyGHbfOa0CQ=;
        b=Yb/C3IXrQ+pqn5MPw3dNXVGJj0fFz7eMX2flo+oMwJ51x+S7hWD3bfjLZipNMCVZo5
         VqlCdXuUKWJNIRYmxJwzQKJCLzsA7XdcBeOjQ/8EJwb71mCyK+A27YW9aHnzgcyXOmln
         emF1vKejtZEuV0QFIe8JB0uh3xUL+dA6cl5hKCTtZG+G8Ojqc+BfDdb1uZ2eThewA9gN
         D9+9TE8Iz76VcclAOa8jPU1N4+xIZqOtltKHmKodS3RFGRPNuXOwR0aOnxfr5MuNJt+p
         4i5prshI44Ab1uivrqhlo4HkMMXM4qAIif3iU7KyT4SVsvBqy0N9LSRU2Nn1rs6gR6hG
         DI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T5P/j9C+36H4YH5gUFmWtYlaI9Dq5dVmlyGHbfOa0CQ=;
        b=HPwQa5D06rKfhkJaljqahqZ8Q9JmmqbpOFMHZpNviZi6zcEHz2BUpN8Qe5othQGC2o
         s8gsUfe/xiLI+S7wMggXLRMgQPqvNX7KlgCbA1+HGMn1/f1JRO+P21Lq4ECkeNBSvevf
         abh5ngq0q5utI+tmoJxD0cCHGdcDk0b7KOwY7eGvrtqnBaoDNsRW4fErbdojQwNb40JY
         69OALWA8RyW0JN0BkUqvGeP1Xq9l+qmag7bD27XGQGKGC1Y295u55aUlUC2ZMAIqra5q
         eDEOiIimiOr01b/cUC+AyD5EiskdXJluqpBPuhjLJtzS9qbsu27r0urwXUoapCpTLzSH
         s6Fw==
X-Gm-Message-State: AODbwcAmF18rVWoh8JcS2dhuuGZw42YD9aVMCnJfNuXpZj5jvCISNvgK
        17cyEn/RfEFVk5RlFR0wkMjx0gtcHQ==
X-Received: by 10.36.53.79 with SMTP id k76mr1024889ita.71.1496347085141; Thu,
 01 Jun 2017 12:58:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 1 Jun 2017 12:57:44 -0700 (PDT)
In-Reply-To: <20170601155105.28356-1-benpeart@microsoft.com>
References: <20170601155105.28356-1-benpeart@microsoft.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 1 Jun 2017 21:57:44 +0200
Message-ID: <CACBZZX6+V6=gSs0pdN9WU+LPZv5qSAmE5u_f=NFYht2dT-hxEQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Fast git status via a file system watcher
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 1, 2017 at 5:50 PM, Ben Peart <peartben@gmail.com> wrote:
> Changes from V3 include:
>  - update test script based on feedback
>  - update template hook proc with better post-processing code and make
>    it executable

Thanks, exciting stuff, do you have this pushed somewhere? I didn't
spot it it in your github repo. I had some issues applying this on top
of master @ 0339965c70, on 5/6 I got

    $ git am /tmp/original_msg.txt
    Applying: fsmonitor: add documentation for the fsmonitor extension.
    error: patch failed: Documentation/githooks.txt:448
    error: Documentation/githooks.txt: patch does not apply
    Patch failed at 0001 fsmonitor: add documentation for the
fsmonitor extension.
    The copy of the patch that failed is found in: .git/rebase-apply/patch
    When you have resolved this problem, run "git am --continue".
    If you prefer to skip this patch, run "git am --skip" instead.
    To restore the original branch and stop patching, run "git am --abort".

But it worked with patch, weirdly enough:

    $ patch -p1 </tmp/original_msg.txt
    (Stripping trailing CRs from patch; use --binary to disable.)
    patching file Documentation/config.txt
    Hunk #1 succeeded at 410 (offset 21 lines).
    (Stripping trailing CRs from patch; use --binary to disable.)
    patching file Documentation/githooks.txt
    Hunk #1 succeeded at 456 with fuzz 1 (offset 8 lines).
    (Stripping trailing CRs from patch; use --binary to disable.)
    patching file Documentation/technical/index-format.txt

The 6/6 patch failed due to an unknown charset y, you have
"Content-Type: text/plain; charset=y" in the header, worked after
manually munging it to "UTF-8", although it gave a warning...
