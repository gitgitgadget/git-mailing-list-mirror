Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8DB71F453
	for <e@80x24.org>; Sun, 30 Sep 2018 07:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeI3Nrp (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Sep 2018 09:47:45 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35333 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbeI3Nrp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 09:47:45 -0400
Received: by mail-it1-f193.google.com with SMTP id p64-v6so507232itp.0
        for <git@vger.kernel.org>; Sun, 30 Sep 2018 00:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O4CJ8/Sh8512utbDHqcpfugNuCaxeDlZj0UkbOv0A98=;
        b=VcImprjNfgqGfrwRggivOzuMw3ppZgZz2LTlaqhRYXSI98+pmuZPCt1OE209QB7Tsk
         3E2G576OQtsVLZnMgGPJ++AAAh8vHe1O2YF3eaz5dyiiUnWk9q5AyY+atx+Pv0XqW0Kk
         mx3RIqPaWSR+F56jdsj7cnqHQbPjKr5eZI0998nrhmrV52IH8hfG04PBDLlY2tbfInmb
         ERuAO+QcI6VlrdH0lI+CdQctgX3CTlt5NbtO6TSgW3WuVggJWBVJfIT37lUGUgb1dWic
         sddV7IKV8I35XKX98EIFN+G2O1KHXENi94NEARRYM4B3k1g9oqh0Yi1g/QsAhPzDrmbR
         f5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O4CJ8/Sh8512utbDHqcpfugNuCaxeDlZj0UkbOv0A98=;
        b=WR2+wDIlqB39s48JP0PtmaL0vCbnCEnGSCyWSvcrskVubksONlxZEVR4kZacfk9gJQ
         4yNIUUTeedg4fanT758BSKkFXb6npBC4o2JQa2nuBke6FHbsgOn9tX575v6cfj4Hyy0h
         6KYXp65IGgPGzpqcl4lXKC13rV87Lw+rockeeZRzrClBFE4zBbPtewUrb4PydYPTEU4s
         ucd/y6g/f4sdUBJc/r4ABVDkVTFZZdvdhAZlxygQOVdMLUu4rvXNDP9cRjKAEeFgubgB
         RRAIcf4vAQ+xfFfZGoWQG6eLpHtOWXCKYbRN2cRTNvwdshIOQ5jg4U9gSbBhYlRbbzxe
         4M7w==
X-Gm-Message-State: ABuFfojA/beau5JaV+qQSamXnOOaKOVlD6Nvvw1W+tZCB07mhi8/XXPT
        TSvK7cecOQKPPByi4zQSW/tLuzr904kVGEZDh3d4Fw==
X-Google-Smtp-Source: ACcGV60rPsmcFnbY8K/MKqnehhxBxYRhtQlBFd/ZfvcNuOdbYI+oxG7HOhxFYHH52CpCIwCnPf/6IQspbPi/gKNHLkQ=
X-Received: by 2002:a24:aa41:: with SMTP id y1-v6mr6778317iti.91.1538291755589;
 Sun, 30 Sep 2018 00:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180923170438.23610-1-pclouds@gmail.com> <20180929153005.10599-1-pclouds@gmail.com>
 <20180929153005.10599-3-pclouds@gmail.com> <CAPig+cSv4P99ZJ=CtCC7HctfSg5W6sadiknhk9yXSaBDZ81ctw@mail.gmail.com>
In-Reply-To: <CAPig+cSv4P99ZJ=CtCC7HctfSg5W6sadiknhk9yXSaBDZ81ctw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 30 Sep 2018 09:15:29 +0200
Message-ID: <CACsJy8AVowvXDkOh_fjdRpNtcXWchxFULbE8m9ZPQN9BsJx5ag@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] worktree: add per-worktree config files
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 30, 2018 at 6:33 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > diff --git a/builtin/config.c b/builtin/config.c
> > @@ -645,7 +649,20 @@ int cmd_config(int argc, const char **argv, const char *prefix)
> > +       else if (use_worktree_config) {
> > +               struct worktree **worktrees = get_worktrees(0);
> > +               if (repository_format_worktree_config)
> > +                       given_config_source.file = git_pathdup("config.worktree");
> > +               else if (worktrees[0] && worktrees[1])
> > +                       die(_("--worktree cannot be used with multiple "
> > +                             "working trees unless the config\n"
> > +                             "extension worktreeConfig is enabled. "
> > +                             "Please read \"CONFIGURATION FILE\"\n"
> > +                             "section in \"git help worktree\" for details"));
> > +               else
> > +                       given_config_source.file = git_pathdup("config");
>
> I'm not sure I understand the purpose of allowing --worktree when only
> a single worktree is present and extensions.worktreeConfig is not set.
> Can you talk about it a bit more?

Unified API. If I write a script to do stuff and want it to work in
multiple worktrees as well, I should not need to do "if single
worktree, use "git config --local", if multiple use "git config
--worktree"". By using "git config --worktree" I tell git "this config
is per-worktree" and git should do the right thing, single worktree or
not.
-- 
Duy
