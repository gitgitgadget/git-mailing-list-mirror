Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8353F1FF6D
	for <e@80x24.org>; Sun, 18 Dec 2016 21:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753629AbcLRVem (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Dec 2016 16:34:42 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:36842 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753429AbcLRVel (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2016 16:34:41 -0500
Received: by mail-qt0-f177.google.com with SMTP id w33so131773352qtc.3
        for <git@vger.kernel.org>; Sun, 18 Dec 2016 13:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m45Vb0Es1sUrUg5H7hOfoxqXWwNuD70PJpZSBYHRHH4=;
        b=f7ZNPURDetkdbRdpH/hdKPuQN8kQpUeVrWlCPNBSy6Lwm8tWY3KuA8Z4NORil9T2L5
         yu6fLc9LpAax8YCoOVvpu+Qnuu31LTOWuQrN2ED9kGnKx+bLQHJyMwoRfCizcAyuIHsv
         m3pyxY6TYXefe7AiIXVZB+G7WWu2SgzazJj1m3+WfTpdnnK5bvrM//b2gIYlT6I2hCPA
         o9vGC7m6EQ8fHpV8rpKFw2bAqRCQjFg9NopOBGGqf3jZzVA384J0f8lzC28OL8x1L5LO
         DQlSM+JT7X9n43K5Uwu96ladKfw+OSnVTnQY4UpHKA2fjS6hs+QmBy4/Q4oBwXfAsj6N
         YArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m45Vb0Es1sUrUg5H7hOfoxqXWwNuD70PJpZSBYHRHH4=;
        b=DhZDbwViXg2hhQC8QQbpCRo4NewmeWpo/rgKzghWqUibJEhyDJ6MBl5vIg5+4i6/MI
         iSlXri+i7lkAAj2z7Y2vDVjglpmskbNMAl+Y+l8Dph9X/v/Fgd/pZbVC5VWjslPim4De
         av05aseZ1BulLYK+GzQuUmEPVYB680YUQ7WpJ2Fs3DmsU0fIr1KpNaqo/q3ISq2J96B9
         OvctxAl6ywMhaYjGaEvIgRtW4K5OTKc+No9lvYr2yvvI0tghiHZHXrP7jkb4onIupxt+
         ZQ8K4lT1TIBujo/07VRK77L9T03PHEB4hxh4BJQpi7ZKdXdt/loh5zq798Am/gaCViV/
         NjUA==
X-Gm-Message-State: AIkVDXIqSlQ4H3wLLP3tEJylvWPDkldfakhWp5kjwuqzF2QmNmozJ5EL51MbNnIB0xD7ZbMnPpT/zjS5Nfsd3+AD
X-Received: by 10.200.53.9 with SMTP id y9mr11963452qtb.176.1482096880731;
 Sun, 18 Dec 2016 13:34:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Sun, 18 Dec 2016 13:34:40 -0800 (PST)
In-Reply-To: <CAFAcib8yauNRB6UbO8qS2_Ff4fDt-7mMsmgop8d1V0j=RoTBSA@mail.gmail.com>
References: <CAFAcib8yauNRB6UbO8qS2_Ff4fDt-7mMsmgop8d1V0j=RoTBSA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sun, 18 Dec 2016 13:34:40 -0800
Message-ID: <CAGZ79kZ=QK5s0_94+4GNs3M5oo49GLm-KkT5K=yZktxX8C4UCw@mail.gmail.com>
Subject: Re: Bug report: $program_name in error message
To:     Josh Bleecher Snyder <josharian@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 18, 2016 at 12:36 PM, Josh Bleecher Snyder
<josharian@gmail.com> wrote:
> To reproduce, run 'git submodule' from within a bare repo. Result:
>
> $ git submodule
> fatal: $program_name cannot be used without a working tree.
>
> Looks like the intent was for $program_name to be interpolated.

Which version of git do you use?

>
>
> As an aside, I sent a message a few days ago about a segfault when
> working with a filesystem with direct_io on, but it appears not to
> have made it to the archives on marc.info. Am I perhaps still
> greylisted?

Both emails show up in my mailbox (subscribed to the mailing list),
so I think that just nobody answered your first email as the answer
may be non trivial.

>
> Thanks,
> Josh
