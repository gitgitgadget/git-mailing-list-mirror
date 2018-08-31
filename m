Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 661471F404
	for <e@80x24.org>; Fri, 31 Aug 2018 20:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeIABIw (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 21:08:52 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41375 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbeIABIw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 21:08:52 -0400
Received: by mail-qt0-f193.google.com with SMTP id t39-v6so16033153qtc.8
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 13:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=osURWGufpj/mmhvfOK+Jf8bzDHN/UZ3ZNms1NcN0Nx0=;
        b=km84NikHO6fb8ltgSYZY5djyD+fvvdVLfThkFG0hru/mslds09NR59NPiaQr4wHcQv
         H+wgdRhwjlZpvdqHy5p0CkNJ+J4OD0I+0qUGy+PcQftDC8BIJCnk0kNceBedxgUCGVT0
         f0VwjmrM4rICUc1JbmYcT/09hQ0b9bAJiz2hsQjjUMbKvnmeH2gYzZmQTyQ0QHH4HEho
         vPKvgMKJ0DNM+bHG2pHD9wcI1Ls5T0U0lAGRWAMekKkpGl+O8/F6MKw/COPsyxPv2k1B
         CPbhPol9BFQgj7+mSpIdMfB7Ip7qquOvfY5uvTM+8uAaLGdEOkWVKDcgqdjoqTBSc6XD
         qqHw==
X-Gm-Message-State: APzg51DA8Ep+J1y7U2zbJpOm21ROOIH+A/UoAcQvmxpMSHgHalV87q5E
        APjTtBtOoAtcNaR6fT9HIRCmVsvpf0hAEHdFiVU=
X-Google-Smtp-Source: ANB0VdZxZwixPV00m2DwmvW22Fkw4x+8bU2e+eivztz6n2Po6XAh203UJ9XgzGSzBwMNi6Ek0OmBavajkuyeo8lCFpY=
X-Received: by 2002:a0c:c503:: with SMTP id x3-v6mr16854334qvi.82.1535749176985;
 Fri, 31 Aug 2018 13:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180805075736.GF44140@aiede.svl.corp.google.com>
 <20180831083342.34836-1-sunshine@sunshineco.com> <20180831170013.GA41433@aiede.svl.corp.google.com>
In-Reply-To: <20180831170013.GA41433@aiede.svl.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 31 Aug 2018 16:59:25 -0400
Message-ID: <CAPig+cRfakQqNP3ih4Sp0uzvkSNkqpsxBVFSnB9HYmqvavGuxA@mail.gmail.com>
Subject: Re: [PATCH] config.mak.uname: resolve FreeBSD iconv-related
 compilation warning
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 31, 2018 at 1:00 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> > From: Jonathan Nieder <jrnieder@gmail.com>
> > OLD_ICONV has long been needed by FreeBSD so config.mak.uname defines
> > it unconditionally. However, recent versions do not need it, and its
> > presence results in compilation warnings. Resolve this issue by defining
> > OLD_ICONV only for older FreeBSD versions.
>
> I think it makes sense for you to take credit for this one.  You
> noticed the original problem, tested on FreeBSD, wrote the
> explanation, and figured out the firstword hackery.  All I did was to
> say "somebody should fix this" and run "git log -S" a few times. [...]

I'm fine going either way with authorship, and I can re-roll with that
minor change (if Junio isn't interested in tweaking it while
queueing).
