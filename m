Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 405331F453
	for <e@80x24.org>; Thu, 21 Feb 2019 10:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfBUKxl (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 05:53:41 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38444 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBUKxl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 05:53:41 -0500
Received: by mail-ed1-f67.google.com with SMTP id h58so22694238edb.5
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 02:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=udyGE2O7bYer0AwMLNCk0mHXs7CpAw5KE52IsyulFj0=;
        b=cV3CLbaiTvIBtIzZpJzFBAxx4fXIuTz7yLZOuS35+AqAfwQs3USA2xj7Lsr2lQWM/v
         vmDK+UV3E5fAsVRCOY2Lp7VQ+14V9DaIy6fERwAojvq6FT61JxFJNIRcW9fTfGFHdLFU
         zkv8AfM88zh3vNwokcmHsetbm0UOxzChIvYv/f9CxKFrHPduTgAN2VHbfIvifimROevQ
         t1f2D5jKiBKYaFWuEsHqQJLnC8GNBJ2uUXtJ6rFbpQUGEssdYvzk+gZEXtMVgp1/aROm
         o9SBtwFj39wis0RxwLD8aZRV64gsvNDa8IopcKRXNZ58nnCG/COzLKd0jhjatqcDz6ny
         irSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=udyGE2O7bYer0AwMLNCk0mHXs7CpAw5KE52IsyulFj0=;
        b=I/dmpguxJSTZSG6uqRt4UWNekkTuWA0FvwD9NvhzxCIgAcC+hfp9Soh2hO45Co/LZd
         R+ekib/qzfjk1CoHys3a3+PVK7xSiWCkb8BMvb82LO8gZ6fcU3r/xQ7DYZyLEBsVH4Zm
         aVqnL7A5U14uBMBOO0LtdsEn4902nn0Sra7bQHB8DNnqWJy93H6imzyJbZ65vHfn9y42
         JKo2j1/fpDVJepQuqdWA5pBHhwa4LVglSi10CZ+qtQ41Hmffl5S7dqveykxSqmeY1TIT
         J3ZAX3Q1vyFPb8qAonYk9mYsx+q8Dz6suz+eG7tRsBrDPIrTa0hlt4FlU6bherwgCKxH
         DhpQ==
X-Gm-Message-State: AHQUAubfGRXdGboVFR+QOyr5Aowo8qX+LYV8WN5q0XUzJfPXi8GIpVEd
        gDtctOFpsoruPY1vRND46CHu21B4+28zx6RCkKBTuz1hor7CNF1T
X-Google-Smtp-Source: AHgI3Ib0zzpLsDkQFqXSS5mB+cHHLemvXFqZzJnz3UM6uT6G0jocE+Dz/y5tcTNot/nVJ7MjftTHFBQNW2fO2YN31Cc=
X-Received: by 2002:a50:a48f:: with SMTP id w15mr6020243edb.91.1550746418917;
 Thu, 21 Feb 2019 02:53:38 -0800 (PST)
MIME-Version: 1.0
References: <CABUeae_N3NFXn-E1+LHORL3RDf5iTCFn=zyuOo3c2Aot2QF7pg@mail.gmail.com>
 <20190221021825.GB488342@genre.crustytoothpaste.net> <CACsJy8BKhroHhVWCj5fvwxk2z4XsdSK_pSQ=o8hxZcZsAn3R-w@mail.gmail.com>
 <20190221041756.GA28389@sigill.intra.peff.net>
In-Reply-To: <20190221041756.GA28389@sigill.intra.peff.net>
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Thu, 21 Feb 2019 11:53:12 +0100
Message-ID: <CABUeae81zRSZrAce86R7OQgGFoc3R1Lk2X8Ujg4ZPUAGVVSknw@mail.gmail.com>
Subject: Re: "Submodule registered for path" output with config aliases mixed in
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 21 Feb 2019 at 05:17, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 21, 2019 at 10:47:45AM +0700, Duy Nguyen wrote:
>
> > > > I managed to identify where that garbage injections come from:
> > > > from git aliases I've got configured [1]
> > > >
> > > > Could anyone explain what is happening here?
> > > > Is there anything wrong with my ~/.gitconfig [1] ?
> > >
> > > I see the right behavior on my system (Debian amd64/sid) with
> > > 2.21.0.rc0.258.g878e2cd30e and with master. I've built with ASan and
> > > don't see any memory warnings on my system.
> >
> > I ran valgrind yesterday (gentoo amd64) and didn't find the problem
> > either even though it clearly looked like some dangling pointers. I
> > also audited this code and couldn't find anything obviously wrong. My
> > only suspicion is maybe some strange getenv() behavior on Windows
> > (_if_ the super prefix is used, but I can't see how...) and that's
> > just a dead end for me.
>
> Certainly we fixed a bunch of getenv() problems in the upcoming 2.21
> release, including 8aac69038f (get_super_prefix(): copy getenv() result,
> 2019-01-11).
>
> Mateusz, can you try with the one of the v2.21.0 release candidates (or
> the current tip of "master")?

Jeff, I have just tried git version 2.21.0.rc2.windows.1 and
I no longer see the problem.
It seems like a bug in earlier version indeed, that has been fixed now.

Brian, yes, the .gitmodules was perfectly correct.

Brian, Duy, Jeff, thank you all for responding; the problem has
been solved for me now.

Best regards,
-- 
Mateusz Loskot, http://mateusz.loskot.net
