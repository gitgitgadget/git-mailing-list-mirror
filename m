Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A33FD20229
	for <e@80x24.org>; Wed,  9 Nov 2016 09:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbcKIJWq (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 04:22:46 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:36788 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752558AbcKIJWn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 04:22:43 -0500
Received: by mail-it0-f68.google.com with SMTP id n68so13844122itn.3
        for <git@vger.kernel.org>; Wed, 09 Nov 2016 01:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NUkXxZSAqOUDKhfjZUGpotW4iotsMijq8c8IAsR7jRc=;
        b=q7t151MNEPSO5pn6C1sV9ywuIL5/At0oLYOu7vgcLmbOc43dc18Zz2u+r9/t9W7yHP
         IUbF3EM8pY+o4AFlv+yjaeRRMJv23TSaBWxwnMzIci7MUC+YmKheIg3eWw8Yhb9LvO8H
         5lRHyufWdDcoAt2BWlfZL1Txq0XXV9n8+svtC+4vD4kwwnj44ikRZxPQwe/fnuW3Jm3t
         Zm6xqcin76HM5l949fdeJrHI6kkboAc+kxlgV4LmOErrF56aOWhgUbDAYJ1IoH+6wy+T
         Jc/gGjMzd/runeFF4Pmu7Zqmq67P3Pex04pMqredymXNRs61Us7BkEAiqS4xQ66r7tcz
         0PVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NUkXxZSAqOUDKhfjZUGpotW4iotsMijq8c8IAsR7jRc=;
        b=e75+3kj2cwDR4onHTGAHoJ6TxuRb2UZDuDG3Dvm700waJRZecbN0yKhsFkUR9UeAaG
         0z21etGxnZKWfKGQDi5LbLaDz7BKor9/rsxLJ0ZBNV8iNShMnYAak3oaYmBxA5paIfPQ
         DJrE4dTeocbEgfboAwHty7EhdcpUQfu1G1gjOvoZuxpW3V4y17JHaqrzAR1mXQh8VLPP
         IyMU+L2eGcFJjJMoLzlyV3NbS3SujmwnAvBfm/ylgoPCJQOGQ0bPvAABiqjmqvSJ4Rcm
         DdQIkQM6TmXvyoegkPi0Kq3L0jP31PagdeiJAJC54bVhQ8fhgsSjRLuJyma5LVuJCT/h
         ZN3A==
X-Gm-Message-State: ABUngvcaf8Kcl4sREzW5+xE2SjS3D65awCZyxQ4TcbEcjO0W8hs/VgxdYurpUCTClZuHhaomBqWLPqwHktTsBA==
X-Received: by 10.36.26.78 with SMTP id 75mr13855233iti.74.1478683362585; Wed,
 09 Nov 2016 01:22:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Wed, 9 Nov 2016 01:22:12 -0800 (PST)
In-Reply-To: <20161108222127.mejb74maewzhn3qg@sigill.intra.peff.net>
References: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
 <20161102130848.qpigt4hxpoyfjf7x@sigill.intra.peff.net> <CACsJy8AO2KtpxFu=wRjW1DoCA9bfpF1VoJUn__2ib-ML0XT66w@mail.gmail.com>
 <20161107211010.xo3243egggdgscou@sigill.intra.peff.net> <20161107211522.vzl4zpsu5cpembgc@sigill.intra.peff.net>
 <CACsJy8BoEXDjwe=ZX5ZOC_mvaMjYrB3i7wcMmiOP3mm5-rwC5Q@mail.gmail.com> <20161108222127.mejb74maewzhn3qg@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 9 Nov 2016 16:22:12 +0700
Message-ID: <CACsJy8ASMBk+Yak7LyybANFYkoU_Poi1ZGY=ufKtq1vSkoYCXQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] attr: do not respect symlinks for in-tree .gitattributes
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 9, 2016 at 5:21 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 08, 2016 at 08:38:55AM +0700, Duy Nguyen wrote:
>
>> > Another approach is to have a config option to disallow symlinks to
>> > destinations outside of the repository tree (I'm not sure if it should
>> > be on or off by default, though).
>>
>> Let's err on the safe side and disable symlinks to outside repo by
>> default (or even all symlinks on .gitattributes and .gitignore as the
>> first step)
>
> Both of those are actually much harder than you might think.
>
> For matching specific names, we have to deal with case-folding.  It's
> easy to hit the common ones like ".GITIGNORE" with fspathcmp(). But if
> this is actually protection against malicious repositories, we have to
> match all of the horrible filesystem-specific junk that we did for
> ".git".

We could realpath() it and check if the result path is inside
realpath($GIT_WORK_TREE). The real work would be done by OS. We will
need to check if it points to .git/something, but I think we have that
covered. The approach is a bit heavy for such a sanity check though

> Symlinks are likewise tricky.  If we see that a symlink points to
> "foo/../bar", then we don't know if it leaves the repository unless we
> also look at "foo" to see if it is also a symlink. So you really end up
> having to resolve the symlink yourself (and when checking out multiple
> files, there's an ordering dependency).

We do have this dependency problem right now (e.g. files A and
.gitattributes are checked out at the same time and .gitattributes has
some attribute on A). It looks like we resolve it by reading the index
version at checkout time. We probably can do the same for gitattribute
symlinks.

> I think it might be enough to check:
>
>   - leading "../" tokens in the symlink's destination can be checked
>     against the symlink's path. So "../foo" is OK for path "one/two",
>     but not for path "one".
>
>   - interior "../" can be disallowed entirely. Technically
>     "foo/../bar/../baz" _can_ be a fine symlink destination, but why?
>     It's identical to "baz" unless you are following a bunch of interior
>     symlinks. And if those are interior symlinks, it's still confusing
>     and unnecessarily obfuscated, and a good sign that somebody is
>     trying to do something tricky.

Sounds good.

> So one reasonable fix might be to have a config option like
> "core.saneSymlinks" that enforces both of those rules for _all_ symlinks
> that we checkout to the working tree. And it could either refuse to
> check them out, or replace them with a file containing the symlink
> content (as we do on systems that don't support symlinks, IIRC).

I wonder if anyone want core.saneSymlinks on, but they have some links
that do not meet the above checks and still want to follow them
anyway. One way to add such an exception is mark the path with an
attribute "follow". Yeah I have a dependency loop :(
-- 
Duy
