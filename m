Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F397F20248
	for <e@80x24.org>; Wed, 13 Mar 2019 10:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfCMKDC (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 06:03:02 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51281 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfCMKDB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 06:03:01 -0400
Received: by mail-it1-f196.google.com with SMTP id e24so1914138itl.1
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 03:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UIznzcLb7aD8yB3/X+jCeMwumXqp8dwdV3XFgXI8n6c=;
        b=QCnTL+v66WOhBYZiSVkVtIWea21EHqHqJxrxQTB2lw0gcFm5RCME5r3OcLDGG7Fwx5
         2oKvuFmDM845eqkzYIXbeJRF+VLdMMMeOrWkRl2km6R+cudlS809ehKqJADBHLiOh4hc
         BXvS9g7C65wXtYxPY9MuBRdo7Hx7hri1GQCKUvsCOXcdbdnGFLrzRkCKw2+S4HUR7u24
         gXAklHaYUN1CVVmGmG1+33us9xJGJ2HPHERAy1HBGqlFvJn/rY8HtxAFHnSbULZfCDaZ
         u0OQNhJKcLfvwdrSAk7i8ZtoOeK4BJE2WmzW+vM8wZ+U95ioJe7DGR/RhQKZzPK7E/Kl
         tOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UIznzcLb7aD8yB3/X+jCeMwumXqp8dwdV3XFgXI8n6c=;
        b=miAojEpx9ks8B5q8NlKpfTJhgjalo8f6h9a8SLiJbs6JIzhevNbYVfe+UYLuLxRQUq
         cd74X9NZ1TXaQSNtVENy6DKVLPNrcZxvfbNWupagbewXNhs6wDcYelUMH+6eyd2PEuNz
         z3EWDxaG/R2nNr+JjFtWb5op9oHuQL5h9WTNW4fwdlRQjrJqV34FeVAE/9fyL6h6h14C
         a7BVkjBn0FojxWDj8Fm4FlI0jYdnE/CjobYK797tvWE0LN3A3gZ0AsFAnvI9q2AJLtI9
         3VY9TIsbq5SEmCd+dy7bkItjavnXETqA6pjbArZChrCTXlOWKvo2LIqUH08TZHcctXvo
         dtSg==
X-Gm-Message-State: APjAAAXPzzYb4We+8rwGFafZ4jq7tplRjX+8Nzbx8S39f7J2QdKXwCHC
        DWaS72uImP/4Y77Rrj0NRQcpld85NXtriCtGQVQ=
X-Google-Smtp-Source: APXvYqyRebXSAvEbf3Sk8YU0uGnzI9tv11+bo+zB8iNbuzZkNpDkqoAK7Cx3mDsWXU6kK6192f22gUrZ4ydZuwPVbyM=
X-Received: by 2002:a02:568a:: with SMTP id u10mr23959831jad.130.1552471380826;
 Wed, 13 Mar 2019 03:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-7-pclouds@gmail.com>
 <CABPp-BFv-a3Uw1g+ebLqTHRbCedsv1akZxxJ7QfeyXtXBdQuOw@mail.gmail.com>
In-Reply-To: <CABPp-BFv-a3Uw1g+ebLqTHRbCedsv1akZxxJ7QfeyXtXBdQuOw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 13 Mar 2019 17:02:34 +0700
Message-ID: <CACsJy8DBRMQq9fAepLkTQbvzhx2U3X2wdhv4xzPXyCnGxZSo2A@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] restore: add --worktree and --index
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 10, 2019 at 1:52 AM Elijah Newren <newren@gmail.com> wrote:
> > +               /*
> > +                * NEEDSWORK: if --worktree is not specified, we
> > +                * should save stat info of checked out files in the
> > +                * index to avoid the next (potentially costly)
> > +                * refresh. But it's a bit tricker to do...
> > +                */
> > +               rollback_lock_file(&lock_file);
>
> A total tangent: I see both FIXME and NEEDSWORK in the codebase.  Are
> there other 'keywords' of this type that we use?  Is there a
> preference for how they are used?

I don't think so. I've seen FIXME, NEEDSWORK, TODO and XXX. I think
it's often up to the author to pick one. We could unify and use just
one keyword, which helps spot these. But I don't think we keep future
other keywords out long term. This seems to pick up most of them with
a couple false positives

git grep '^\s*\* [A-Z]\+: ' \*.c
-- 
Duy
