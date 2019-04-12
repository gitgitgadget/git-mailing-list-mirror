Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC88B20248
	for <e@80x24.org>; Fri, 12 Apr 2019 08:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfDLIjP (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 04:39:15 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41186 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfDLIjP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 04:39:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id g6so3645570edc.8
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 01:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vscCuUplgmc2SuSg37PhAgVhSDRmK0pI5QxZGSH/wrY=;
        b=BHu12zOjFuyASp7S0/zGQbaiuok8b/fgqqpWNFYH0YQ0SrZt1fq05b2rOQOsDzOreD
         2y7+DQhVKnVWvdZ9K4t7njlMfPuxjxZViNmVjcKnoh1pWIAuryIFMYaSOTO4AIF6bHm5
         M8I0eXBloCldvvu8OXvF7qJ+8aHIevPmaYs76A/36tS7u0DIyd9UiQF7P6b4LqK++Xfm
         GQTJwqI2ZBIou9KK6n5njdhgLBQ7H1NmndDBdrMi4XRlsdr4adUvzANeKg5yqIhM+l1f
         ROUzOOWAtoQg6CoL5pdT/Bw2JoCFvHOtWOVchWICUgct2ZGY2Z9N22IROnq9yCWQjS7N
         dIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vscCuUplgmc2SuSg37PhAgVhSDRmK0pI5QxZGSH/wrY=;
        b=lS9oben1Uw/B/aTC00XJN4dQzFpJfXpceUKK+gznSflqoH50TwqwbdV4W46sRUa7NI
         RTWW0f+505/rbqM0RCzaSVJl2bxRqp978r1/S01Fipl4DQr6r5Qqqi3Ysbd6mvP56alW
         J1Fg9IFdPuzFg0jYkcNvnq7wLyHRdeyW67juHxke3MGn/TntmCyEdQxB2BlkOR3eiwLX
         gwG+i42r8mwEsW2/YZF6feBMpSI1EJ9MS2cWPWgCrmkQGn4VzZbTL4u1I7wCK7YPdw8h
         bXLml2YSCpMg7N1ii1LYFa9tXVp7d327eVBI+C6zktGAsf064FG2JCBqIVNv/xp3YPbJ
         Uudw==
X-Gm-Message-State: APjAAAVUlvuhc82c3mgbsTeRc7Jo9JyRHNfn4bAp1mO/OUzBAwQLmG+U
        d9GcAvG6YgQ0wuDoJyxXoJS068KqiQt/0k+jxb11Fg==
X-Google-Smtp-Source: APXvYqynyKtSxZtHiJ5HuL6PTmRopg66PbDKk26P/ol/pQvtLpc+lG/4pWMrdXErA5rwjt3BCWrplaIy6Y4NsNWF9Ps=
X-Received: by 2002:a17:906:8604:: with SMTP id o4mr27955459ejx.178.1555058353290;
 Fri, 12 Apr 2019 01:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190411164440.GC12669@ikki.ethgen.ch>
In-Reply-To: <20190411164440.GC12669@ikki.ethgen.ch>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 12 Apr 2019 10:39:02 +0200
Message-ID: <CAP8UFD0bBBtOOz9ew_2URCp3nY1v0_OHMby1-N+T0nCDW82DRg@mail.gmail.com>
Subject: Re: fatal: unable to read after commit
To:     Klaus Ethgen <Klaus@ethgen.ch>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Apr 11, 2019 at 7:24 PM Klaus Ethgen <Klaus@ethgen.ch> wrote:

> I am a heavy user of git now at version 2.20.1 on debian.
>
> Since some weeks I have the problem that I get often "fatal: unable to
> read ..." and a unclear repository after a git commit. The commit itself
> is correct and so a git reset --hard helps to fix the issue.

Could you tell us at least which Debian version and file system you use?

Would you be ok to bisect it or at least tell us if it happens with
2.19.2, 2.20.0 and 2.21.0?

> Any Idea what could be the reason for that problem. I encounter it on
> different repositories so not limited to one.

Is it easy to reproduce even on very small test repos? Could you send
us a small script that reproduces it?

Could you also run the Git test suite on your machine?

Thanks,
Christian.
