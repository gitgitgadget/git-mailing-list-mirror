Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E04CF1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 15:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbeKTBzk (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 20:55:40 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37431 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729696AbeKTBzk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 20:55:40 -0500
Received: by mail-it1-f196.google.com with SMTP id b5so8008597iti.2
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 07:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=27biO53jTP4JMnE9liOxzhLPpuNUJwHEM+SZHctvmPA=;
        b=oeUEEtr6v4G5qPThks+uhhMBcERttJvDuMCUG0dTjQ0u3Tj7rKeGJl+X71BDDIXI47
         3T+bZ/9Z7i67L8uNp7azmMnRJngGTuXge/V12rGGrGAvJjBswtFiyR+Wb2yqdKyxzWYF
         u9Kuec473a7M5NxTe0bRwsPIjN704qv6upZ7T9saZ5YjspJCiX/2TPTeHWROD7K9EjyR
         2OgZXItJiuBU6Bbp8VekgJGZRo100GNUl7MjAefMdQ8+RZLyjWM1vCIIBZofsRE18NjX
         rg48QpdDU6tt4KDtOtTVV8EZAkAPBXlDoCON2md1zOwk6wft5w+aZ1rwsEx5Y7pDgu71
         mdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=27biO53jTP4JMnE9liOxzhLPpuNUJwHEM+SZHctvmPA=;
        b=C5RY0sTljE1RekPNjsmkZAxpxzOMd4Wuvd3+ucMwgW2VzrvGP+eHHqjPQD9C7HJw+B
         tcd/ry3GFYQaEZ2l8vKzQtaGhWgwornFK8UtvPeSV06O/ZijXop2xUB+PHpO5m7T5uIU
         P+d+lhj6uOGwuPV3BY+u5BzpAA3igYrulOJzU5EENjn4n6o0asl0ZoqsqU2CWTwEABzs
         nJOfBErRYBJagKqa1t/pdv+aa/80dAqCa9wrhq/0yOswWvgqx4qBBn1ugWGIpV8ZipcY
         4lFBNEp1SqKOzpFHPhnYi6PL5btk7f1BFBBt2K+unh5LyBxhgVC3dm46iv6Mkd6AX2Kf
         RnQQ==
X-Gm-Message-State: AGRZ1gLhEBreNIp0YFRabJ9UEHa0uzHbPWiaK5thJLZmJHyamURYZbFX
        WrvZdjcIzK7qDwZu8NP/Nks2l0I1fF/f1bpHSnA=
X-Google-Smtp-Source: AJdET5dJi0q9/0Lf51qtKd8vMTTda/CNAuL3veGTiFaFBYOI/PJs8P9iBf7++dvFx72apnGfD0YCTCZsB+wCsgPZEVY=
X-Received: by 2002:a02:9d27:: with SMTP id n36mr19221979jak.30.1542641503221;
 Mon, 19 Nov 2018 07:31:43 -0800 (PST)
MIME-Version: 1.0
References: <20181118164800.32759-1-pclouds@gmail.com> <877eh91egn.fsf@evledraar.gmail.com>
In-Reply-To: <877eh91egn.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 19 Nov 2018 16:31:17 +0100
Message-ID: <CACsJy8B=-7Z6qP6UwoKnQSugxDi8o1t2aKXHWzf_ST0Qo5kezA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Make :(attr) pathspec work with "git log"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        bmwill@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 19, 2018 at 12:42 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Sun, Nov 18 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
> > When :(attr) was added, it supported one of the two main pathspec
> > matching functions, the one that works on a list of paths. The other
> > one works on a tree, tree_entry_interesting(), which gets :(attr)
> > support in this series.
> >
> > With this, "git grep <pattern> <tree> -- :(attr)" or "git log :(attr)"
> > will not abort with BUG() anymore.
> >
> > But this also reveals an interesting thing: even though we walk on a
> > tree, we check attributes from _worktree_ (and optionally fall back to
> > the index). This is how attributes are implemented since forever. I
> > think this is not a big deal if we communicate clearly with the user.
> > But otherwise, this series can be scraped, as reading attributes from
> > a specific tree could be a lot of work.
> >
> > The main patch is the last one. The others are just to open a path to
> > pass "struct index_state *" down to tree_entry_interesting(). This may
> > become standard procedure because we don't want to stick the_index (or
> > the_repository) here and there.
>
> Another side-note (this thread is turning into my personal blog at this
> point...) I found an old related thread:
> https://public-inbox.org/git/20170509225219.GB106700@google.com/
>
> So this series fixes 1/2 of the issues noted there, but git-ls-tree will
> still die with the same error.

If you mean BUG(), not it does not. There are just a couple more
places besides tree_entry_interesting() and match_pathspec() that need
to be aware of all the magic things. ls-tree is one of those but it's
well guarded and will display this instead

$ git ls-tree HEAD ':(attr:abc=3Ddef)'
fatal: :(attr:abc=3Ddef): pathspec magic not supported by this command: 'at=
tr'

If you mean making ls-tree support :(attr) and other stuff, it's not
going to happen in near future. It may be nice to switch to
tree_entry_interesting() in this command, but if it was easy to do I
would have done it years ago :P
--=20
Duy
