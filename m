Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60195C54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 20:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4318C20857
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 20:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgDWUto (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:49:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40305 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgDWUtn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 16:49:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id u16so8282392wmc.5
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 13:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ljjFojialDJOdQCZ8vSuyH4uWAjvER1Nb3tno/l6dKA=;
        b=N11+ewYvypQuaeh7aoDPIwpjOAvbuLJZa8qYeXCBmQCpGL8tppf4Sws2shF6fLnZti
         Ibp04uvtw5N51qhpwhKLk87DCgCRETsivLbuxwFd7rzZY3CiDPy6ZxEEHfj/yrgD1QLt
         PtGGq9ovDox8AFJPxG60B1WAT7zLr2La1Y2y3l5CJVV0ch2LyGQ7ZB1mTkfwA5T7iIeE
         ES7dXi2jEKObHhzNM+iK1sQal/sodJ/L3Zsl0EHTgQIzZbfIuEUusbBUfhGKi+34bou5
         HnBy/iQqsQxRFw6Xy9SAz+Tzg5/G+p/sxQa01tHufS3V6CrcgelWOdvYb2+f8XpC+WI0
         cZAw==
X-Gm-Message-State: AGi0PuZG7PV3SQ8Zds7KjZ5di73myohyC6INUuh8vC7EHf+erd0CkJH6
        57S1DkGUytn9oiUz2S9Je3gkUcgOM5ElGXXpbtM=
X-Google-Smtp-Source: APiQypJDThP0juUBCF3t+sYcGnfhyoMuNiEeHbFUmbP6386i830gEywJqaCH2qzMu+cKVDGP+j9rSV3WybwBjTF8Kgo=
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr6117560wmg.177.1587674981641;
 Thu, 23 Apr 2020 13:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.616.git.1587628367528.gitgitgadget@gmail.com> <CAPig+cSDQe7YDke=fyfdeSZOimcR5jj3FFk=Q4iOk6uiHsT-Zw@mail.gmail.com>
In-Reply-To: <CAPig+cSDQe7YDke=fyfdeSZOimcR5jj3FFk=Q4iOk6uiHsT-Zw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 23 Apr 2020 16:49:30 -0400
Message-ID: <CAPig+cSkr+2dExzETScru0N5_=JhjVR=QZKuY5CbhstwrUUk5w@mail.gmail.com>
Subject: Re: [PATCH] macos: do let the build find the gettext headers/libraries/msgfmt
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 23, 2020 at 12:17 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> I'm slightly leery of seeing these applied globally on Mac OS in
> config.mak.uname since various package managers on Mac OS install
> packages in wildly different locations, and these settings might cause
> the wrong version of a package to be picked up if a user has a
> preferred version installed elsewhere.

As a follow up, although slightly leery of applying this change
globally to config.mak.uname, I don't necessarily oppose it either.
Considering how widely adopted Homebrew is on Mac OS, baking in a bit
of Homebrew-specific knowledge would make it easier for a Git
developer to get up and running by eliminating some of the manual
fiddling and configuration currently necessary.
