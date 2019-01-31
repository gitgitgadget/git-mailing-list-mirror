Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B91191F453
	for <e@80x24.org>; Thu, 31 Jan 2019 19:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfAaTF1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 14:05:27 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52528 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfAaTF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 14:05:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so3650952wml.2
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 11:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BBS692LNMCjIHdbexKuhR2yXx1lTg4uBWc2YEAP9T6U=;
        b=ToNxmc0wjVehIwSpm09qzr+NUZSHnKzu0d6MGKHsHuj1yx6QWPPMxzEge7+hIXbM9Y
         sf+u4FCg0pKX+EUrhyFUrkrCg6fLTBu0HcOU5nE8XNzQtXvpC3Iii8s0uQeKJaAaKApK
         9W+i1JggoCCB/BjiGDlP8g9Z945PR83DdfXdSZ4ZfuuFa6aGFc1q3CrhrcMuybuflt9W
         wm9aorNhs9bU5if1WOsRoZKDqMbQSm8Oe2A+dD5UwTi1TKP0p9URUskvxl17fFzuohQj
         8HRHu3Y659b5/UL2QKORW6RNNbAnGz0kOoE2nIvWmMcdXQfhk3WMzFMwZWjyc04zId2r
         ATHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BBS692LNMCjIHdbexKuhR2yXx1lTg4uBWc2YEAP9T6U=;
        b=qatdkrLclMpn7omxSl1mME0+zq5tMyH23eIvdyLem3PQwMNJ1m6v3ojh/039CCc+uz
         xcIOdFsp7onjI3Aq4fwMQkWYl2pfbRKpr5XI5yMcR1+UWr6mAkIBPhQIUsgDszMeb/cV
         FZBIhsMmzeKCeTVUAD7MjBbjXk7hu7kH/yBQvcPIRDCiWJkzV6ZSjl+MP4P1yLCCvyLT
         WXvShPk72kbUSwG544AgznXMxZyrawtILOdOGodBUB0uYB9AxRq3aWdxTvBizOQVkiJR
         0rrj4gPW4GeEaKL6xanQd6YrJ8nwX3zcy1DhPRJalHfXKFAVi1vSJYpmOa32lLJCGHDM
         kdVA==
X-Gm-Message-State: AJcUuke7kSXcKNNgFXrZYsROrejJfBcshoZNSBA+pXBlx9HlblAgNBQh
        duxj/3HU1zhmT3yUwtbcc/ZxEpCP
X-Google-Smtp-Source: AHgI3IZXxbZVdggmIBUctfA2On/fqGoLVnU/vZqlAGgpvlTzsrcgGisuzQ3AsBpk0QPrRibmVEqqYw==
X-Received: by 2002:a1c:f518:: with SMTP id t24mr15366314wmh.26.1548961525221;
        Thu, 31 Jan 2019 11:05:25 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f191sm160123wmg.12.2019.01.31.11.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 11:05:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/8] checkout: add --cached option
References: <20181209200449.16342-1-t.gummerer@gmail.com>
        <20181209200449.16342-7-t.gummerer@gmail.com>
        <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
        <xmqqva40lps2.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
        <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
        <CACsJy8Bk=wbgzsE+Vo4w_u0E63PdUxxcvG-7e6Hq-8_jrmSErw@mail.gmail.com>
Date:   Thu, 31 Jan 2019 11:05:24 -0800
In-Reply-To: <CACsJy8Bk=wbgzsE+Vo4w_u0E63PdUxxcvG-7e6Hq-8_jrmSErw@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 31 Jan 2019 12:54:50 +0700")
Message-ID: <xmqq7eek3ax7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> I've changed my mind. I'm not using --index and --cached for "git
> restore" (formerly "git restore-files"). So how about this?
>
> git restore --from=<tree> <pathspec> will update both the index and worktree.
>
> git restore --from=<tree> --keep-index <pathspec> will not update the index
>
> git restore --from=<tree> --keep-worktree <pathspec> will not update worktree

An action to "restore" with an option to "keep" (i.e. "do not
touch") smells strongly of double negation.  We are restoring,
i.e. grabbing something that existed in the past out of another
place (like tree or index) and depositing it to the working tree to
recover its previous state, oh, not but not touching the content of
the working tree (or the index) intact?

It would be great if you can come up with phrasing that avoids
specifying what is *not* done, but instructs the command what is to
be done, perhaps along the lines of "restore --index-only", "restore
--worktree-only" and "restore --index-and-worktree (which would be
the default)".

