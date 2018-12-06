Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C255B211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 23:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbeLFXgb (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 18:36:31 -0500
Received: from mail-yb1-f201.google.com ([209.85.219.201]:56566 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeLFXgb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 18:36:31 -0500
Received: by mail-yb1-f201.google.com with SMTP id a14-v6so2005263ybk.23
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 15:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Bae2ZIerKVoETqVOXBJR9emj7d8OCR+KJVbrydjoE8s=;
        b=C5hGZBdaiGxpV6lJrjmA5/GkJKQG+M7GSgQZxPankmM7sNWlG4geGNP2bL1jiVTNqv
         cnR3KQ+mZFQsNfIm//TpSYRwUmv4vTWfMaWMU7VfqTxllWF0X3tmzpV87mn/6CLSmQ1S
         zjSZ0dyAFlntZxqdIw/ODDfceB7x3sO/ezc6w6B3vbnm+1uP0rT1ecX5zBsbNBAAMoAJ
         7yB9ClUouS+UA+BCrNyYWXgFXoxcpLSqxRvFiNyd46QfbRroGJLpFYv7Kzg1yA04jFBR
         PKnkk4Oe92USc3/lDljO3kSqYDFabjVdqLPfm8jz1lg0MTbo7kcc7waoCz3sE3dktxmb
         RLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Bae2ZIerKVoETqVOXBJR9emj7d8OCR+KJVbrydjoE8s=;
        b=lveqZ8DtuiNfLNUEDXOTuQmbTatropXO7pZLW38ZJSOFXgvBLitZ+cJebPsBVwn68z
         JHuLSOqRyTzBeUBRp53q93pLHzZrIazKYJVdvLtI3955MIqW+D6q4npY8wl/MmGjVBDY
         te2oBH4D+fintHUFJEy4EWvqjjF2rjQnupf8lDNtYEsakLt4DDnpxYDgI15ipTQ1AmSQ
         6GyvQBdSXAZSaW6UEoW1Cs/1+ej5fvO8Tq82TU4RM2tgG6LOF92IGilGxKAXIiQ5X9xm
         fzmG60lJVY2+2F0qjBZYW2IpT6Z5ry2QV4mDpnZt4oW5e6U64QoRdci3Q61ObRoVaNkz
         dCow==
X-Gm-Message-State: AA+aEWbwOtzdMCRxmoUvIZpQxgdbSF5nQIFP8lUl1N2SuAU8D9h/Ql1E
        9kfIjkyQOgxFZpbForV86jLTV8QmehUfH5w+5Ee/
X-Google-Smtp-Source: AFSGD/UdSWoCP4jjY/zx/duhN9tULexXjMTike+Wn+q5Pqf1GZyXcu5Bp3jQdAbII/AGeod0NW4psnMOBodwhmq+RIob
X-Received: by 2002:a25:748a:: with SMTP id p132mr3383499ybc.103.1544139390317;
 Thu, 06 Dec 2018 15:36:30 -0800 (PST)
Date:   Thu,  6 Dec 2018 15:36:26 -0800
In-Reply-To: <CAGZ79kYOOk2ODYgRcSZgDUqBfx2HeywnEGpbJB9BrrVzEUi_JA@mail.gmail.com>
Message-Id: <20181206233626.144072-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAGZ79kYOOk2ODYgRcSZgDUqBfx2HeywnEGpbJB9BrrVzEUi_JA@mail.gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH on sb/more-repo-in-api] revision: use commit graph in get_reference()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > This is on sb/more-repo-in-api because I'm using the repo_parse_commit()
> > function.
> 
> This is a mere nicety, not strictly required.
> Before we had parse_commit(struct commit *) which would accomplish the
> same, (and we'd still have that afterwards as a #define falling back onto
> the_repository). As the function get_reference() is not the_repository safe
> as it contains a call to is_promisor_object() that is repository
> agnostic, I think
> it would be fair game to not depend on that series. I am not
> complaining, though.

Good point - I'll base the next version on master (and add a TODO
explaining which functions are not yet converted).

> AFAICT oid_object_info doesn't take advantage of the commit graph,
> but just looks up the object header, which is still less than completely
> parsing it. Then lookup_commit is overly strict, as it may return
> NULL as when there still is a type mismatch (I don't think a mismatch
> could happen here, as both rely on just the object store, and not the
> commit graph.), so this would be just defensive programming for
> the sake of it. I dunno.
> 
>     struct commit *c;
> 
>     if (oid_object_info(revs->repo, oid, NULL) == OBJ_COMMIT &&
>         (c = lookup_commit(revs->repo, oid)) &&
>         !repo_parse_commit(revs->repo, c))
>             object = (struct object *) c;
>     else
>         object = parse_object(revs->repo, oid);

I like this way better - I'll do it in the next version.
