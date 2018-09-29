Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A650C1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 18:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbeI3A4x (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 20:56:53 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38787 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeI3A4w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 20:56:52 -0400
Received: by mail-it1-f194.google.com with SMTP id i76-v6so1060516ita.3
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 11:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eLGoR8XY8pf/MFUM7Q8+fd5zwEUNuRoqaA9/kYoyJqs=;
        b=PsYJTXhCnEnqTimsEgT9XMH0T0IJjMURS7SXpI1F9pn5nCbUC8FnjwkvWJ9BvkGtkn
         uWvDrCoy/QTD48DJ+AlYkaroaxpj2LWCftXD9L+VYD5+Ie7Hbapbp2MOit/3CK58Ho5p
         94kcqAxmFBPB1PBhCYpBbG8l3/W3yrQSzXbyZEWwGg5qsgbt/Y6qkbcut6m0ZVhaNTeI
         dacrFP1hmI5gF5++6xYVRo+md1o5cQWoHiK0j4q32LHBC0No1WjaXcEXvI6TS3S9LtkR
         H6LiZ5DhGZgugU4oUB4derAhIqIGrQtyQG/wUsC4MnQpUZrAeUYXYRzZxXgAOxsWtXKW
         jICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eLGoR8XY8pf/MFUM7Q8+fd5zwEUNuRoqaA9/kYoyJqs=;
        b=EfKacG5L4zw1xwmlMBmIff0Rb7XBtn76cd+2Az/uDXOl79GPUW0rXX4sGrSGupaf1e
         J6XYPLsJi9Im7sRNSbs5nEKe00A4zJRFF41XHteBwBBMyiD4zU6WKE6Bowx/STN5VqHn
         8tgVkVWFM5V70jM7wm7P2jwba7xX+SG9iEJq/BQ4ijTLdY+OPfCJE9ClrV2ojUEb1b95
         vSf5UiWDO9aQxU1MhSj7ilctBxBXRHo5eaQaYPnrplRH9GXDJKKo8ioeVl2AzxSoxJEa
         NNJQ4mqk3TfaY5L4+Gbo+NDMWG19P38xfNOUUg3HLUjoWZzhifhaSjiB7uy00e7qJtyj
         ZPcQ==
X-Gm-Message-State: ABuFfoj2Nkp8bjMYmsx4fGtPLGxRVJ308duMg9SxX9Q3aUTNvrkz6yEe
        dbqi10y/ByLVWm8gngP11xmSlJTulCMON7CP6BY=
X-Google-Smtp-Source: ACcGV62fEewWJdBtmUbUlydn91lJ73lhQIbBDWN/GHBvVub3OiYXd84XxPuBtt3XfDZvfJowIfc2rmMM8SuZsTxSKBs=
X-Received: by 2002:a02:49d7:: with SMTP id p84-v6mr3072957jad.97.1538245646207;
 Sat, 29 Sep 2018 11:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180922180500.4689-1-pclouds@gmail.com> <20180922180500.4689-4-pclouds@gmail.com>
 <xmqqy3bpnupm.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy3bpnupm.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 29 Sep 2018 20:26:59 +0200
Message-ID: <CACsJy8AiVdXHNz362rixeUWj0Y4HknU93qqcT2EFMWVbsjwpJg@mail.gmail.com>
Subject: Re: [PATCH 3/8] refs: new ref types to make per-worktree refs visible
 to all worktrees
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 11:16 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > The main worktree has to be treated specially because well.. it's
> > special from the beginning. So HEAD from the main worktree is
> > acccessible via the name "main/HEAD" (we can't use
> > "worktrees/main/HEAD" because "main" under "worktrees" is not
> > reserved).
>
> I do not quite follow.  So with this, both refs/heads/master and
> main/refs/heads/master are good names for the master branch (even
> though the local branch names are not per worktree), because
> in the main worktree, refs/bisect/bad and main/refs/bisect/bad ought
> to mean the same thing.

True. I think the ambiguation here is about the main worktree versus a
secondary worktree that is accidentally named "main". Then suddenly we
have to worktrees of the same name, and accessing them both via
worktrees/<id>/HEAD will not work, and there is no other way to
disambiguate them.

>         side note: Or is this only for pseudo-refs
>         (i.e. $GIT_DIR/$name where $name consists of all caps or
>         underscore and typically ends with HEAD)?

Right now, due to implementation limitations, only pseudo refs (or
loose refs in the case of refs/bisect) are accessible. But I don't see
why main/refs/heads/master should not work.

> The disambiguation rule has always been: if you have a confusingly
> named ref, you can spell it out fully to avoid any ambiguity, e.g.
> refs/heads/refs/heads/foo can be given to "git rev-parse" and will
> mean the tip of the branch whose name is "refs/heads/foo", even when
> another branch whose name is "foo" exists.
>
> Would we have a reasonable disambiguation rules that work well with
> the main/ and worktrees/* prefixes?  When somebody has main/HEAD branch
> and writes "git rev-parse main/HEAD", does it find refs/heads/main/HEAD
> or $GIT_DIR/HEAD, if the user is in the main worktree?

The rules are not touched. But it looks like everything still works as
expected (I'm adding tests to verify this)
--=20
Duy
