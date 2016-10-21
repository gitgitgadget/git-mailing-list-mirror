Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 517F220229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754097AbcJUML6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:11:58 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:35295 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbcJUML5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:11:57 -0400
Received: by mail-it0-f45.google.com with SMTP id 4so236072633itv.0
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 05:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HyXVkHfNtNN/r/PZvIHAkT1ACfIB686yV7uFUe9FWT8=;
        b=Mh+96yTD33sIe73r9GVeUOVAoxrILScSImSHOjiT58g2Kv94/qcJbnIuGRME5oJVhA
         FvRvBR+u5EHSb0TcDb7QYYAYN/HI1aRHATb81QYiqvr3NDMwJFEpYPAHOEM20R0KzVPF
         tDrAq6owby8odVFq8uJ7j0SplcoQw5JbpJe8r/oEFOHgRYUXhN2OJNEGELnoUj+fjX0K
         7mJgy4mPCYtxVRrWg/AGZ6jU+Hx6b+rqB48jCP02zo9gy0rScwaFoH4AMqyZHVjfPc7k
         sV9pq9ErZew3f8An3aO+dC47epDBxNvQuGbYk+DdaKom6p9Q/kfwDExEcfimUNRGGmEa
         tDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HyXVkHfNtNN/r/PZvIHAkT1ACfIB686yV7uFUe9FWT8=;
        b=CRHqUDLXE4hGpKb/SV2TWs/GpF2WbfhuRhjdiv+mEABqiEE+1n/kA1UYwWLrDtMGsb
         vR615pymUCICNGOSXkJ2GR/HIUPISqWlcJyMcG42IBtCB+lhNvyBz2ToVKKwx3X1IL6M
         e7zeHY5BODY8iHtuDNXnv/oawkHBgv/KOBO4ECn5/8UONuH0eMAD9os0XhDoJWMLtIgG
         zXCkL4+3eZHPb74IT7NpXaOJZ2/cgKHaV6I5wux1ErQi4SMyaKhF7A/lXa9XQhG4WgJ9
         Li/xqvRRFKkmljYz+v084K7O12asEGtGfB96L5IHWQpiC1IfArqQkWB+pEkAzwKQH7Pi
         KbXg==
X-Gm-Message-State: ABUngvc3vVYN3nwY2NGmqET2r77Nxjqohs2CB3rNgjySmnCH0pWG0dOlgnJgyf0aHTVVOtffR0knRX5bkK9PaQ==
X-Received: by 10.36.70.142 with SMTP id j136mr558308itb.50.1477051916808;
 Fri, 21 Oct 2016 05:11:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Fri, 21 Oct 2016 05:11:26 -0700 (PDT)
In-Reply-To: <20161021002654.qo6kcya4gocp73rs@sigill.intra.peff.net>
References: <20161021002654.qo6kcya4gocp73rs@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 21 Oct 2016 19:11:26 +0700
Message-ID: <CACsJy8Bxn1qV+xXNnCpuOQ7qWNsz3oLt5-VG=VXZvV9dvJVvTQ@mail.gmail.com>
Subject: Re: [BUG] fetch output is ugly in 'next'
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 7:26 AM, Jeff King <peff@peff.net> wrote:
> I recently started using lt/abbrev-auto via 'next'. This is the fetch
> output I saw today:
>
> $ git fetch
> remote: Counting objects: 332, done.
> remote: Compressing objects: 100% (237/237), done.
> remote: Total 332 (delta 182), reused 64 (delta 64), pack-reused 31
> Receiving objects: 100% (332/332), 351.53 KiB | 0 bytes/s, done.
> Resolving deltas: 100% (184/184), completed with 26 local objects.
> From git://github.com/gitster/git
>  + fb65135d9c...16ab66ec97 jch                                  -> origin/jch  (forced update)
>    fd47ae6a5b..98985c6911 jk/diff-submodule-diff-inline        -> origin/jk/diff-submodule-diff-inline
>  * [new branch]      jk/no-looking-at-dotgit-outside-repo -> origin/jk/no-looking-at-dotgit-outside-repo
>  + 3a8f853f16...1369f9b5ba jt/trailer-with-cruft                -> origin/jt/trailer-with-cruft  (forced update)
>  * [new branch]      pt/gitgui-updates                    -> origin/pt/gitgui-updates
>  + 7594b34cbb...be8e40093b pu                                   -> origin/pu  (forced update)
>  + 7b95cf9a4e...76e368c378 tg/add-chmod+x-fix                   -> origin/tg/add-chmod+x-fix  (forced update)
>  + c4cf1f93cf...221912514c va/i18n-perl-scripts                 -> origin/va/i18n-perl-scripts  (forced update)
>  * [new branch]      yk/git-tag-remove-mention-of-old-layout-in-doc -> origin/yk/git-tag-remove-mention-of-old-layout-in-doc
>
> Yuck.

My eyes!

> I could maybe get over the wasted space due to the longer sha1s,
> but we clearly need to fix the alignment computation. I haven't dug on
> it at all; it's probably low-hanging fruit if somebody is interested.

Yeah.. replacing the 4 DEFAULT_ABBREV in fetch.c with something
sensible should do it.
-- 
Duy
