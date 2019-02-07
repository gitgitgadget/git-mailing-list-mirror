Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D1DF1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 22:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfBGWew (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 17:34:52 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36835 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGWew (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 17:34:52 -0500
Received: by mail-lf1-f68.google.com with SMTP id q11so1154422lfd.3
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 14:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=362+k/Al2oAaCEeMyl5KSDi6ALf0BD6WgX8rtT6EwUc=;
        b=gXac/ZOycL/77T1p80oICkIS010mVZ1jhbORnucWJDymLtivKx9o0Qgl1jSO7O1wgd
         hib1puiv1SaZE8ZLDdhV4q43PE0TiztK1V2VI+L4UIPAPURrw/bUrPOAuER58Z4zF88e
         CwZqvrr4sAOHHEovDA+Wgfs+PJGM3VnhATEkq7c/gDhGDy+w/gO5FzQtELrMYwIt3Ycz
         CGH2xEZSwPl2N9gi+8UTTbA7/zg7aqgSZEg//rbYPORRMsFDSfcwjURJ9oPow5PO2cFX
         bV0pnmJrM3SEG/szJii7VuJLqTnveDlBnh+2EpP8Ba6ryy8n0j6LYPZSbLrHhcIHqp5r
         TwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=362+k/Al2oAaCEeMyl5KSDi6ALf0BD6WgX8rtT6EwUc=;
        b=fSM3i21QfQNjQGVxvlsguGhxN0pRWSKXB0L1gBJLzYnx1Hmn9EhYa4usqnXzLEG86w
         7n2HgzWqMU40v1TqGXYfVW1DP0+IieIy7PCCh2ZL482u74mIdN+273Q22k49zlUvbRDb
         AEWdiF8euCUZ/25sZX5HJmdgaJ0URzhsI1J1434aMGpbuVi9S1ciSU8RU+RiOT1Xgrms
         OSgPcbSQMlmqUyVN9qrSlqfaqGSiUUrFr0ijiviIMjIaq+n48RjkTLljGbPbGxk0tVFM
         /CKz85vcPkzvIZ1MKaXLQ/y1c6eTKyPkK13bUH9vFrct9w2QtIhqxA9GYxSPz60zB/52
         ebJQ==
X-Gm-Message-State: AHQUAubdzYjvcJRhEpeNjoOP4tRLTV/E6TMwR6iV7Awdot7fFyeMR3Ri
        5TPG+QLXrONhz/UOvW+USi6UuVVW0NHX/eEoJQVPNbKBBUk=
X-Google-Smtp-Source: AHgI3IZRefJQNjPSXaUFm15n1UHPayJUPi992RZYxOSGrKuqD6c00i+/64eZQ2wn9zW4D60VFG+tMxy+Nard5e9fEgg=
X-Received: by 2002:ac2:55a3:: with SMTP id y3mr11485951lfg.93.1549578889802;
 Thu, 07 Feb 2019 14:34:49 -0800 (PST)
MIME-Version: 1.0
References: <cfd86853cce8a2cd5fae9e6fb9a84f1e3d6daaf4.1549538392.git.liu.denton@gmail.com>
 <xmqqftszpgy1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftszpgy1.fsf@gitster-ct.c.googlers.com>
From:   Avery Pennarun <apenwarr@gmail.com>
Date:   Thu, 7 Feb 2019 17:34:38 -0500
Message-ID: <CAHqTa-3bDnAm=49uBDLWxLrpOMd6sh1ve1fmmnf5kCbVxHsawg@mail.gmail.com>
Subject: Re: [PATCH] contrib/subtree: ensure only one rev is provided
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 ]0;joe - On Thu, Feb 7, 2019 at 1:54 PM Junio C Hamano
<gitster@pobox.com> wrote:
> I am not sure if the other caller is OK, though.  cmd_add_repository
> can get more than one revs, and uses the first one as $rev to read
> the tree from, expecting that this helper to ignore other ones that
> are emitted from 'git rev-parse --revs-only "$@"'.
>
> For that matter, one of the early things cmd_split does is to call
> the find_existing_splits helper with $revs, and it seems to be
> prepared to be red multiple $revs (it is passed to "git log", so I
> would expect that incoming $revs is allowed to specify bottom to
> limit the traversal, e.g. "git log maint..master").  The addition of
> "ensure_single_rev" we saw in an earlier hunk near ll.191 makes such
> call impossible.  I am not a user of subtree, so I do not know if
> it is a good change (i.e. making something nonsensical impossible to
> do is good, making something useful impossible to do is bad).

I think this generality is probably not useful and it will probably confuse
people less if we prevent it.  It was just one of those "if you don't have
any better ideas, just let people do whatever complicated thing they want"
approaches I used when I was first writing it and didn't know how people
would end up using it.

> In any case, I do not use subtree, and the last time I looked at
> this script is a long time ago, so take all of the above with a
> large grain of salt.

I don't use it very often either.  To be honest, I've noticed weird
behaviour in the version installed with git 2.11.0 in Debian, so I went back
to my own version at https://github.com/apenwarr/git-subtree.  I've been
meaning to investigate further to see what patch might have happened that
caused it to act weird; maybe it's since been fixed.

But I don't see any major problems with the patch in this thread.

Thanks!

Avery
