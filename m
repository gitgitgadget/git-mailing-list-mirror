Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83E0A1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 17:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753451AbdKJRiC (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 12:38:02 -0500
Received: from mail-ua0-f177.google.com ([209.85.217.177]:43749 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753194AbdKJRiB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 12:38:01 -0500
Received: by mail-ua0-f177.google.com with SMTP id q18so6304677uaa.0
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 09:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aDOOu4wNaP8HmzCZB11dKhbwm9MYuoKo0MLs7/09/28=;
        b=d0iTzcWM+tATb5br2JdYvp7GlZJrdbLioDYsAhP26naQPNRIOzyiC0OucJZ/lM2dUa
         KJQX3l500fIttZfvoWK+qnSN4xfX9En+ePilXiYHt8O23uaYVMl9I4PvJZyhGvJBWZoE
         YqPIW9ed/68qlTAwoW1XCgoVEjn25v8qUPuFWemmDZ1TwXrIxIt5Jia0ht6bMWZnk1Ol
         kbbT8uaLE9eHLRWPGMB9LdBnFhWOq4SVg1vta+30k8soO5x0fvu0ZdEhcWiIh3dOMkX4
         qe/hdOZ8xCPia3VRYvvWNmcDNWP/lKZJgPm8EjsVfdGcvi+nGKhXp6vbbDnoWTQ/eghC
         pcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aDOOu4wNaP8HmzCZB11dKhbwm9MYuoKo0MLs7/09/28=;
        b=XNtvC04MtuW/eZQ3vEBnMEdxnXIhzZy3ltkcvpUI7H9NzHeZ/7HJ7245UD2Y2rR+aF
         Eleka3a5QBTShtjSDTIQBz0QnbsQBdnw6c/Amqu5lggsw4XqDeWG+KhhGFw1S3kNx8wf
         ZmhrTZe0dwQnzIYkvg8izYATlO3Q3rV/MCgHULimTjPdf0Jtd0ed+8EsqrQJhb6oa3hX
         4usHDKt/Oz1yoKK8MLgxsRqSzfpvGRJO7LxJyVahgspmPaxt/+ywsysTXYE+F6LzEqKD
         70SFrez+nViSVIGS4wxwW/RpznqZzt9jJsOkeOBtdrgkjuqMmgM2SzsRT9zTKIfAlARn
         YY2A==
X-Gm-Message-State: AJaThX4b0YA19i4dNu1bjPdkDkBVx/ORLr+rGcwha7xHQg+cRY0oqo+8
        4HXmd+3atlNjK3eOd8UFG9gYafXSZl7jMsTlzKk=
X-Google-Smtp-Source: AGs4zMbAdmg54tR2tXcwZYyGiijzuzfD/3PFx9YaE0a0uvtE5II+o2zkVbsBJ+ZL3iKkjSNBuFi8dbgS5D0MSVoimd4=
X-Received: by 10.176.85.152 with SMTP id v24mr1013629uaa.147.1510335480334;
 Fri, 10 Nov 2017 09:38:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Fri, 10 Nov 2017 09:37:59 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1711101436270.2391@ds9.cixit.se>
References: <alpine.DEB.2.00.1711100959300.2391@ds9.cixit.se>
 <20171110102011.yqtka6a3wmgcvkl6@sigill.intra.peff.net> <alpine.DEB.2.00.1711101333030.2391@ds9.cixit.se>
 <7e242038-50e5-2cfc-e810-401af78b8cdc@gmail.com> <alpine.DEB.2.00.1711101436270.2391@ds9.cixit.se>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Nov 2017 09:37:59 -0800
Message-ID: <CABPp-BH4LLzeJjE5cvwWQJ8xTj3m9oC-41Tu8BM8c7R0gQTjWw@mail.gmail.com>
Subject: Re: cherry-pick very slow on big repository
To:     Peter Krefting <peter@softwolves.pp.se>
Cc:     Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Interesting timing.  I have some performance patches specifically
developed because rename detection during merges made a small
cherry-pick in a large repo rather slow...in my case, I dropped the
time for the cherry pick by a factor of about 30 (no guarantees you'll
see the same; it's very history-specific).  I was just about to start
sending my three series of patches, the performance one being the
third...

On Fri, Nov 10, 2017 at 6:05 AM, Peter Krefting <peter@softwolves.pp.se> wrote:
> Derrick Stolee:
>
>> Git is spending time detecting renames, which implies you probably renamed
>> a folder or added and deleted a large number of files. This rename detection
>> is quadratic (# adds times # deletes).
>
>
> Yes, a couple of directories with a lot of template files have been renamed
> (and some removed, some added) between the current development branch and
> this old maintenance branch. I get the "Performing inexact rename detection"
> a lot when merging changes in the other direction.
>
> However, none of them applies to these particular commits, which only
> touches files that are in the exact same location on both branches.
>
>> You can remove this rename detection by running your cherry-pick with `git
>> -c diff.renameLimit=1 cherry-pick ...`
>
>
> That didn't work, actually it failed to finish with this setting in effect,
> it hangs in such a way that I can't stop it with Ctrl+C (neither when
> running from the command line, nor when running inside gdb). It didn't
> finish in the 20 minutes I gave it.
>
> I also tried with diff.renames=false, which also seemed to fail.
>
>
> --
> \\// Peter - http://www.softwolves.pp.se/
