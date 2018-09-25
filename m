Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4F6C1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 02:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeIYIk4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 04:40:56 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44125 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbeIYIk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 04:40:56 -0400
Received: by mail-yb1-f194.google.com with SMTP id y12-v6so5932621ybj.11
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 19:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BbLOUIipf8DVSnofKEiejdwfULG7zA6bA+8oAXp1AlQ=;
        b=emhLLpn1PBuSwquK02MOC17ILEfJ+FKe14LrPaaWhwwbCtxBR8vnDru/b8FW5DZCOs
         5myGd3V+nUXghSha9jjL8QIc8dnkOGhKXuZMWpU0zx5TfYTZsYKYGLoVL1fCzPSBd0OT
         Z2oMxDA5Mqr3mpe1Vw07YEBa8xWbAtIbjDL6SyLYqvvRlkhMktNVzKw0VA2PArVLr77Y
         F3l48emT3dwnTPB7BCv3+FTItQ4w1V0niZKIPF0M2ElHw8Fb5DBxW5j/EMSbY/5QOdI0
         mUgVeVrEU0XHUgKYGfoHdusKBVKvx7CmhqdqT/uFYCVmR9cs38NQjOWhpVMTfmIfa0mU
         0qIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BbLOUIipf8DVSnofKEiejdwfULG7zA6bA+8oAXp1AlQ=;
        b=kdH8Vlu+gPkT5oKkuszYrTVtByINSmSYkdDDvxk+s+/nNRcCOM1PmYEwUpfMEIjv+6
         lFHLmNRdXJMOB5+D2/u1BvKvt7fkTgqI8VaxlEJnVB6mw0RlCPjweyVbFJlH4Vj9S9DB
         iEORjjx4tIEgb81ptqgHOqgoqNqiZAqwVeeyY8VkHy8nF60tMx8ZorIqiSJTHhGciF9t
         6RfyUZ5164GZ+05SWjARdTHQMLSYUkbf782tOTIuIobN8Uw95aevFrxyBiMpGOIt18/W
         /22B9krg1z7ti4C06EnZXFzUcT4FQFoxfbvohcGs2MBZ7qSM7tDPhtSP9RPhAkCsIJn2
         3xqg==
X-Gm-Message-State: ABuFfoiI12vIcwbP+KP4FyBg1OxFw9BYG4NcRB+g/+9HEPlA0O6oT1n2
        tGI5sKQLo82PoyTDuCcGH/urwqvq/VrRp6M9IK2snw==
X-Google-Smtp-Source: ACcGV61xFgpPQMfrPHHVIBobl5KnFgso81XwOHOPFkKg4aaktw2TNKxIXj6CquffFmgxWwGiQWlI6ZRBOkb0ynZj5VI=
X-Received: by 2002:a25:e481:: with SMTP id b123-v6mr765968ybh.416.1537842940175;
 Mon, 24 Sep 2018 19:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180922180500.4689-1-pclouds@gmail.com> <20180922180500.4689-3-pclouds@gmail.com>
In-Reply-To: <20180922180500.4689-3-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Sep 2018 19:35:29 -0700
Message-ID: <CAGZ79kZF1+0PTEgF_NwM_AwttJ0sedAP8CT834L5ZGJpxZ+G_Q@mail.gmail.com>
Subject: Re: [PATCH 2/8] Add a place for (not) sharing stuff between worktrees
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 22, 2018 at 11:05 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
>
> When multiple worktrees are used, we need rules to determine if
> something belongs to one worktree or all of them. Instead of keeping
> adding rules when new stuff comes, have a generic rule:
>
> - Inside $GIT_DIR, which is per-worktree by default, add
>   $GIT_DIR/common which is always shared. New features that want to
>   share stuff should put stuff under this directory.

So that /common is a directory and you have to use it specifically
in new code? That would be easy to overlook when coming up
with $GIT_DIR/foo for implementing the git-foo.

>
> - Inside refs/, which is shared by default except refs/bisect, add
>   refs/local/ which is per-worktree. We may eventually move
>   refs/bisect to this new location and remove the exception in refs
>   code.

That sounds dangerous to me. There is already a concept of
local and remote-tracking branches. So I would think that local
may soon become an overused word, (just like "index" today or
"recursive" to a lesser extend).

Could this special area be more explicit?
(refs/worktree-local/ ? or after peeking at the docs below
refs/un-common/ ?)
