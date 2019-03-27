Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CD2E20248
	for <e@80x24.org>; Wed, 27 Mar 2019 13:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfC0NLy (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 09:11:54 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:45910 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbfC0NLy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 09:11:54 -0400
Received: by mail-ed1-f45.google.com with SMTP id m16so13932411edd.12
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 06:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WYlsE/qm0zZlFhbcmpf5JruYHmvGe9TkEOBhpnPOhBk=;
        b=KzD6kL/xlgjjPXBZ3pPc49p3liywysTdXG/6SlzOIPBmTtfzSZfHxFyLBjk0S9a3Rn
         Jidk5gYPG0qRdsBwX87w26fcDwGYjcTfwVM+81biEkgF5OuFFN1auDD8lk1pVPYDI84s
         nL6wBCaL/JeV3i1bZ8bMzLWlo2GQ2t9SsxNotIjaWGiQlVHHDCKxFLnNLDa5IcqqgTXS
         9GYp3O24l5AnkXTLWoXgNpBsLqubKvKoqT3f9N9nfAoxN6/Xe5rGq6+YCwGYZ3Gwyi85
         wXJnJieforgxjpTHHbXda8ju5IIy2Lq09RrOwGrqCL3mTPEwCuOSTsDFNetChm2tsM5q
         fvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYlsE/qm0zZlFhbcmpf5JruYHmvGe9TkEOBhpnPOhBk=;
        b=BhYoAJp9slmHHdq67fM0ls0n+irtmoo1IGuacWjssHBYMTcBFgbwLQxp0PoudMJF2w
         l6T5WYnw3q4Zrem+Yb5aRxGUj4MEdfOXlPNOIjqNl7IPqIrg6FwqE2UnlyCTrMIUdR2P
         oHI3emTY2PPDUtsc6GMI82ucQFA4vSyhtmc+NVjuZH6RDWk3t8+C6fly6syGI8YyYXvX
         oX4fd2ZRqIvNWcG3cemqiCofiRvKPn/op5Vz3DAVzmxXbVz7xD7qdyQ3hJ2LKhD9vUno
         2zLev5e73Ap5IQDfzNzK4Q5KQxu/klIK0+TbQvxLxcLkgW6QHJOavNZyBlvCqdpIdpKN
         zzmw==
X-Gm-Message-State: APjAAAXI197GIs+2Sqna7EoZHQVS0jOWQ4D0ArvobRv4odo6LPhoLVeP
        I8NR9TXdPkBfqLhSnp/kf22j0YDMt61ZBtYnl0g6gj/q
X-Google-Smtp-Source: APXvYqx9CjKSb2NF7huGFb8/TK08+akpjCWLXBTszbDwC60y2PHsT0X0WfXsrL9paYnyMaE3cbYX55JLyBayxNYyIpk=
X-Received: by 2002:a17:906:e201:: with SMTP id gf1mr21077932ejb.108.1553692312767;
 Wed, 27 Mar 2019 06:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <mvmd0mcsjkf.fsf@suse.de>
In-Reply-To: <mvmd0mcsjkf.fsf@suse.de>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 27 Mar 2019 14:11:41 +0100
Message-ID: <CAP8UFD1qU_kJ97MdLFwzx+g3F6Q+fQ9LWOBxd=1m4vSi-fxF=Q@mail.gmail.com>
Subject: Re: git replace --graft does error checking too late
To:     Andreas Schwab <schwab@suse.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 27, 2019 at 11:24 AM Andreas Schwab <schwab@suse.de> wrote:
>
> When running `git replace --graft A B' where B is a non-commit (eg. a
> tag) it displays an error,

Yeah, it seems that when A is a commit and B a tag I get:

"error: object A is a tag, not a commit"

which is wrong as A is a commit.

> but creates the replace ref anyway.  I think
> it should verify that B names a commit object before creating the ref.

Accepting a tag and using the commit the tag points to could be useful.

For example someone could look at the commit graph, then decide to tag
the commit(s) that should be used when replacing, and then use `git
replace --graft A <tag>...`
using the created tag(s).

(I checked the code in builtin/replace.c and it seems that we use
lookup_commit_reference() on each of the new parents, so we should be
safe in case one of the given new parents cannot be peeled into a
commit.)

So it seems to me that the issue is that it shows a wrong error when
it shouldn't show anything, or perhaps only a warning.
