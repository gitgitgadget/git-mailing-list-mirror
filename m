Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51444C433E7
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 21:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F34D2078B
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 21:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgIAVoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 17:44:08 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:34544 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgIAVoH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 17:44:07 -0400
Received: by mail-ej1-f46.google.com with SMTP id d26so3799742ejr.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 14:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kG9ZtjRr6p7QDqcpvUknyUOpa6Yc0ZdVpx8dkrzcevY=;
        b=aeFwMq99XxGaBz9rCLvf3V6Cq6S+zZwVI+lFLXilUgAVID0AfcWkjnGZbIQ4OQsyPZ
         VJPXDJFtDEscj2sD7990GgZffB20VfuxPz1u2xcKnDGKzXfsw0PwsdeRV5Wn0vlwR4Ks
         BDO01VP4rQ+uIN5dIqICV3YJdjAvqvVsxy/yU4+3gDJmRQmM1Kj5VoSK48HE2jjkfQNT
         eilV2PKztIczJTrdQoL0C7x2RMk9C9CSEYS3sDi6/ZrafHtlY0uNbFL9D2wOdLCgggeE
         aiObtwIXfTuVKQ/4s2NVi0DTCF2DXRGPGf8hDlaeyjrwQbWLOlUgxB96hyDxaUX9XSxo
         Tscg==
X-Gm-Message-State: AOAM5321Hl/wcf1Og8lP8KBbELsb4AMj3RGZFCG4UGBOCbku6eLBTSlB
        Sc4kdnEVn6pNbTLgDa3Zp4tEbx/fZJiyeEP/6/k=
X-Google-Smtp-Source: ABdhPJwLoaJ0OBI5wPods12PO0zRmJhSZo6b5Dwxquz/uEXOQPQstj6OY5pXcCgFmuAaApj/aeJk7JBb5BiK3hB4dOU=
X-Received: by 2002:a17:906:a18e:: with SMTP id s14mr3412035ejy.168.1598996645539;
 Tue, 01 Sep 2020 14:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqblipchk6.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqblipchk6.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 1 Sep 2020 17:43:54 -0400
Message-ID: <CAPig+cTUhLoPvs+ygnc0Y4Ez3M3tfGncPzON0ejb=xEOMBixHQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2020, #01; Tue, 1)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 1, 2020 at 5:30 PM Junio C Hamano <gitster@pobox.com> wrote:
> * jc/run-command-use-embedded-args (2020-08-26) 1 commit
>  Various callers of run_command API has been modernized.

s/has/have/

> * es/worktree-repair (2020-08-31) 5 commits
>   (merged to 'next' on 2020-08-31 at 604825c5e4)
>  + init: make --separate-git-dir work from within linked worktree
>  + init: teach --separate-git-dir to repair linked worktrees
>  + worktree: teach "repair" to fix outgoing links to worktrees
>  + worktree: teach "repair" to fix worktree back-links to main worktree
>  + worktree: add skeleton "repair" command
>
>  "git worktree repair" command to correct on-disk pointers between
>  the repository and its secondary working trees.

I wonder if this could be reworded so it's clearer that "git worktree
repair" is a new command, and to mention fixes to "git init
--separate-git-dir". Perhaps like this?

    "git worktree" gained a "repair" subcommand to help users recover
    from problems arising from factors outside of Git's control.
    Also, "git init --separate-git-dir" no longer corrupts
    administrative data related to linked worktrees.
