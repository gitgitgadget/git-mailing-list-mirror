Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 425641F424
	for <e@80x24.org>; Thu, 26 Apr 2018 16:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756326AbeDZQo3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 12:44:29 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:40116 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754462AbeDZQo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 12:44:28 -0400
Received: by mail-ot0-f195.google.com with SMTP id n1-v6so111152otf.7
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 09:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=58QkSxseZGRwnRMWqVv6m/EJ8YpaVIcQ08cMIU8NEbM=;
        b=Yv6Cb+s8gGAz2SuHiaq3mcBQCRXegpF786SOphY0fIDvb3y1ztn01spFKr4mZHiAtQ
         h6rdikNdmO9NVOHHrFY/3ULf5YaJ6z7GfUwK+j3Vz6GIzgj8r4jqjTTVEas/zUF933zc
         NdJGQF8mh0/zJWLZD0ORODVFBd7un3PSrL4rlE8mKPQeN2Ye8rQCvtXETuNo66s0lhrS
         fNw0aBUra0eFMqnxw5ZSB0eaO4UQOXs34JRJ3Y+R/7x2FRx4lWfPzxZvnJVoM0mhHHLt
         HrMRmpkwH32m2Mo2HVfHtIyrcApP9mqViNyOTR9qAf/w3Si1Wfoum1OwLYETxAK35oa3
         eOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=58QkSxseZGRwnRMWqVv6m/EJ8YpaVIcQ08cMIU8NEbM=;
        b=JgHHMXWuKIyd0zEljWr8lt5T0xfBDkIdFYYvfKjlmW9xnasjuxW5tgyID8QWi0BaQd
         uD4mgCppeCaYm/YuzuIncFuRcchjMDjiYMdxgcOdOBjO3AUvt+pub6cXC30jxh8JEMDc
         2AE20qGtzFwBEf/Os0K6FK/OT9G7MTQdei67ysn7w/6cGKGlS1Ltvm+Ce8IhdV7DNGhB
         9Mz1FtvAtiC5nOp84c9Ttk2bb6bCp9vPraO1pzltx9tbrcWMB/ndvZHc47hVEBA6el9Y
         6dS6e/6GivgP/zIEmf5Krrzkdu+yyLSpxb/sSl+T6SuqrA1j1nNmuzdqFWA7FM3UcrHP
         5tjQ==
X-Gm-Message-State: ALQs6tCm4fKng+qWZpM9Sol0HDwVcf0zRdLbLxn0I3xUBBcN/TRrTjPO
        yfzJ945aNoJFtWFCpX69juT05rY4NktEK3witfI=
X-Google-Smtp-Source: AB8JxZp1W8WF0TCPn85sfgoYoUFM/944RMcwMDRTBp0a5dcCYOLUgGYjp0qrqk/GGhing4k1x3x+7zrekIBXN1GEihI=
X-Received: by 2002:a9d:1ee1:: with SMTP id n88-v6mr7013317otn.173.1524761067553;
 Thu, 26 Apr 2018 09:44:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Thu, 26 Apr 2018 09:43:56 -0700 (PDT)
In-Reply-To: <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
References: <20180413170129.15310-1-mgorny@gentoo.org> <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
 <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com> <robbat2-20180425T060717-325652820Z@orbis-terrarum.net>
 <xmqqin8f4qoq.fsf@gitster-ct.c.googlers.com> <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 26 Apr 2018 18:43:56 +0200
Message-ID: <CACsJy8ATwEPiCDpOr7e=wJxhZAr1R4OpSdOvb6EgpnyYonQYWg@mail.gmail.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 25, 2018 at 5:18 PM, Marc Branchaud <marcnarc@xiplink.com> wrot=
e:
> Are we all that sure that the performance hit is that drastic?  After all=
,
> we've just done write_entry().  Calling utime() at that point should just
> hit the filesystem cache.

I have a feeling this has "this is linux" assumption. Anybody knows
how freebsd, mac os x and windows behave?

> The post-checkout hook approach is not exactly straightforward.
>
> Naively, it's simply
>
>         for F in `git diff --name-only $1 $2`; do touch "$F"; done
>
> But consider:
>
> * Symlinks can cause the wrong file to be touched.  (Granted, Micha=C5=82=
's
> proposed patch also doesn't deal with symlinks.)  Let's assume that a hoo=
k
> can be crafted will all possible sophistication.  There are still some
> fundamental problems:
>
> * In a "file checkout" ("git checkout -- path/to/file"), $1 and $2 are
> identical so the above loop does nothing.  Offhand I'm not even sure how =
a
> hook might get the right files in this case.

Would a hook that gives you the list of updated files (in the exact
same order that git updates) help?

> * The hook has to be set up in every repo and submodule (at least until
> something like =C3=86var's experiments come to fruition).
>
> * A fresh clone can't run the hook.  This is especially important when
> dealing with submodules.  (In one case where we were bit by this, make
> though that half of a fresh submodule clone's files were stale, and decid=
ed
> to re-autoconf the entire thing.)

This to me sounds like something we should be able to improve in
general. The alternative is "git clone --no-checkout" then checkout
manually (which I see jenkins plugin does) is really not optimal even
if it works.
--=20
Duy
