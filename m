Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D8631F453
	for <e@80x24.org>; Mon, 29 Oct 2018 17:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbeJ3CIq (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 22:08:46 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50483 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbeJ3CIp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 22:08:45 -0400
Received: by mail-it1-f195.google.com with SMTP id k206-v6so10495695ite.0
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 10:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MwgjNY0vzQK4jaOy5dAGkm3kbyX+McO32U0qM2O4C+Q=;
        b=Yt0nzJL+Nw8NbCYkHhk9D2VwDkwjPMiBjtVPLJGEK7dYCFZyzkqFLY4Bh+1zVVM4e/
         uk7zjYvcV2404aU85uwi8e/VTe3QXYh+FWv69Qx/BfoTMwQQIMjBYfHKWtbkOrW3IJMG
         TK9qiS9taQXFmX1xE4IeS/M/Nl/16hiEq5JlK1cxRTjoeNqdApZeBFh96llrgH0F1s8E
         8O/6AtYdvjzUzlSaJ1OFn73R4uL8UPgDyhi7slN536zCzMcZrLWk0xKZrqJddZPNTuBr
         IPsRUi5ZY96vO+OyrwDRqS2K3opU8j3/diXnWA3FW01U1VyIpNsqLYzfz1k9YJ9nha0y
         +Fsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MwgjNY0vzQK4jaOy5dAGkm3kbyX+McO32U0qM2O4C+Q=;
        b=MASRQKr5j9ujsv5SYbELzoeqsIiEaEzMTD/NyWbI/DxKBPRkY2B9R0PJE4zN67DAxQ
         DgGOD7ciQFRE+IyOkTxXWrbDEX2gVMO/ajf7sjELQufr/kY4Ixb0vGsHrakbW9Z3jM3R
         Zvzl2YBdk1v/EP67GSZUdt5BwDpwf32b4k4Ak6RgY4FNGx3pH46cb+w3URz8ideI/aK4
         YMpYbwbngs9HRchNSjJSbBfy51R247Ev3BcpSieyssSxZbfNNLZWyLF2/HSXjmRFs+RU
         SkNsVAO8XAVbzpC1yuxzUWZcE2jxKGG8wiZtdgloliqQQIFITu6qCRFzQ8sTb9lnJvCP
         zXNQ==
X-Gm-Message-State: AGRZ1gJ7gS9Ua/RxoDgPtQ8xca8trrejNNtKPOyCJlkABCPi5JPpg7BU
        Gkj3H1qF4EsV5CswrGQY8kvcv9lMWVvDv3szKWE=
X-Google-Smtp-Source: AJdET5c3abGQaStWhOUemIsftJdWXJvsISvIQydnus0iMJbev/IIwoG8iojGcrYZm5o1K1Of3tkQX5qV+6IpRcjBcdg=
X-Received: by 2002:a24:7804:: with SMTP id p4-v6mr10821968itc.123.1540833554039;
 Mon, 29 Oct 2018 10:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180929191029.13994-1-pclouds@gmail.com> <20181021080859.3203-1-pclouds@gmail.com>
 <20181021080859.3203-3-pclouds@gmail.com> <xmqqin1uwqo6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqin1uwqo6.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 29 Oct 2018 18:18:47 +0100
Message-ID: <CACsJy8Bkjw-T4Aeb8WfdOcjr5OB4HdG1SFYJ9Sokt2JNc2fnOQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] Add a place for (not) sharing stuff between worktrees
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 6:28 AM Junio C Hamano <gitster@pobox.com> wrote:
> > When multiple worktrees are used, we need rules to determine if
> > something belongs to one worktree or all of them. Instead of keeping
> > adding rules when new stuff comes (*), have a generic rule:
> >
> > - Inside $GIT_DIR, which is per-worktree by default, add
> >   $GIT_DIR/common which is always shared. New features that want to
> >   share stuff should put stuff under this directory.
> >
> > - Inside refs/, which is shared by default except refs/bisect, add
> >   refs/worktree/ which is per-worktree. We may eventually move
> >   refs/bisect to this new location and remove the exception in refs
> >   code.
> >
> > (*) And it may also include stuff from external commands which will
> >     have no way to modify common/per-worktree rules.
>
> OK.  Establishing such a convention is a good role for the core-git
> should play to help third-party tools.
>
> Should this play well with the per-worktree configuration as well?
> Is it better to carve out a configuration variable namespace so that
> certain keys are never read from common ones (or per-worktree ones),
> so that people can tell which ones are what?  I know your current
> design says "this is just another new layer, and the users can hang
> themselves with this new rope".  I am wondering if there is a need
> to do something a bit more structured.

I actually find the layered design of config files more elegant. Even
before config.worktree is added, the user has system/per-user/per-repo
places to put stuff in. "git config" gives control to read or write
from a specific layer. We have to add layers to $GIT_DIR/refs to
handle multiple worktrees, but since the "API" for those don't have
the concept of layers at all, we need a single view where items from
different worktrees are accessible via the same path/ref name.

Adding variable namespace in config files does not look easy either.
Suppose we have perWorktree.* section just for per-workree stuff, what
do we do when the user just do "git config -f not-per-worktree-file
perWorktree.something foo" (or --global instead of -f)? What we could
do (and already do for some config keys) is ignore perWorktree.*
unless they come from config.worktree. Which does help a bit, but not
really perfect.

And a namespace like this means the user cannot have subsections
anymore (e.g. perWorktree.group.<name>.var is not supported if I
remember correctly). So yeah... perhaps we should wait a bit and see
what the user (or third party tool makers) comes up with.
-- 
Duy
