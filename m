Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0595F20964
	for <e@80x24.org>; Tue,  4 Apr 2017 23:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755209AbdDDXDW (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 19:03:22 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35253 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754421AbdDDXDV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 19:03:21 -0400
Received: by mail-pg0-f53.google.com with SMTP id 81so165053284pgh.2
        for <git@vger.kernel.org>; Tue, 04 Apr 2017 16:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zd1G2mO7/eV6D7TgtUwaAajK/iX1C81F1N+/kHVPJ5I=;
        b=M0KwuMA2zAqCTVg2NM+wSZU8cAGB1o/RsxrihwBWJTRP9tYT7ZGchTnIc0W5u47Khk
         +UgDkWJ25vQTuSU+Xco1rcMThfhOmFCu3GeWTHY2u9ZmRJto2D/3U+Y3U5Swh/E9p76G
         D+7UFsuuPJGegfmUxAv/s90z2QIhYhhYO6T063lx4jmdYpdbX/sIUpUJWSb0pm2WzQKO
         QixiQolnQoBYP+apUSqjCwI7N9O9lCM1q20Tp1pwafQz3VMK5YvL9aNy8iiFAqhW6f9J
         W6ST2YeLMV9yvopvQcCYdlD52CkcH8qHr6po7NXQceAHEzY+HNSrmjEGkTk433l5SqY4
         /MHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zd1G2mO7/eV6D7TgtUwaAajK/iX1C81F1N+/kHVPJ5I=;
        b=it2mgzcI8w3azGymNH5XLyFz9KwP/Qsz8tMFAdmMZbAxobA6fYusHzBqhTtqb5qzo+
         BAusakWiFd6h5czmy0xcNMtOOSacQfX1lzbfR1nMGRPLcelhfu0+vbUNumW2z2/105qb
         yf4TGXQ7ZBeAqH3QzCNTPEUnqioqo5e3OjQZ3EcBIiYB0x9hulixsKJyfDosp6iXPP1P
         rNW8DIfaICecLjZlGexCwydZ8w0lmxKF0TB1XQWmmPJ03xYBB6dhC5qXhlR31EjMqUwg
         ekxHpbVu7EyYOIalQhT9CaCDfig5/g0uKd4mQ31RKdWBgPler896o+0f5nNOFC/y15zI
         C/aw==
X-Gm-Message-State: AFeK/H2b0Z27PwLesDofesy9xnqQsUTcy1U//Ko8p6t4WF91Dj1tR9WpcrI+ZOQv6V/Y4ndKKi1yiSklaeDefpyn
X-Received: by 10.99.44.140 with SMTP id s134mr26184699pgs.178.1491347000448;
 Tue, 04 Apr 2017 16:03:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Tue, 4 Apr 2017 16:03:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1704050043370.4268@virtualbox>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
 <CACBZZX78oKU5HuBEqb9qLy7--wcwhC_mW6x7Q+tB4suxohSCsQ@mail.gmail.com>
 <20170404083341.uajswm3qdzyvzxsp@sigill.intra.peff.net> <CACBZZX5D2cYf0-ob_Da0EsxRtZHfegezPtCGA10-sjfi0A+AoQ@mail.gmail.com>
 <alpine.DEB.2.20.1704041351350.4268@virtualbox> <CACBZZX6W+fbCg7xXKuM=iqnSYFENBYxYT1WJmoOvYYCBEkX=hQ@mail.gmail.com>
 <20170404165321.GC189807@google.com> <alpine.DEB.2.20.1704050043370.4268@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Apr 2017 16:03:19 -0700
Message-ID: <CAGZ79kb5VeKCzzafw+nEcRda2apuit-K=qZxxZ3Li96MiMdOXA@mail.gmail.com>
Subject: Re: [RFC] dropping support for ancient versions of curl
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>, frank@gevaerts.be
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2017 at 3:46 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Brandon,
>
> On Tue, 4 Apr 2017, Brandon Williams wrote:
>
>> I'm all for seeing a patch like this applied.  I agree that we can't
>> expect the world to be running the most up-to-date version of curl but
>> we should be able to select some "oldest" version we will support which
>> can be bumped up every couple of years.
>>
>> I mean, ensuring that you are running with an up-to-date version of curl
>> is really important when it comes to all of the security fixes that have
>> been made in each revision.
>
> I am not in the business of dictating to others what software they have to
> run. I am in the business of maintaining Git for Windows. And part of that
> job is to drag along code that is maybe not the most elegant, but works.
>
> The patch in question resolves such a wart. Sure, it would be a cleanup.
> Is it a huge maintenance burden to keep those few #ifdef's, though?
> Absolutely not.

Keeping them around is the easy part, the hard part is promising to users
that the software you maintain is as good as your reputation, when e.g.
we find out that certain #ifdefs don't even compile.
(See Frank Gevaerts answer)

So from my point of view it ought to be easier to maintain software that
is fully compiled and tested by a lot of people, and not have a long tail
of niche features that are not well tested.

Initially I thought I had a similar stance as you ("A well written line of code
is cheap") but I kept quiet, as I do not have a lot of experience with dealing
"old" Software.

Maybe the git community would want to take a look at the kernel community
(or other similar communities), how they solve the "long term stable" problem
of computer science.

And there are different things to be considered:
(1) the kernel community has "stable" maintainer(s) that are not the same
as the maintainer of the bleeding edge branch. So I would expect that these
maintainers have expertise in "dealing with old stuff, particular from
$DATE_RANGE".
(2) one of the kernels rules is "don't break user space". However sometimes
they do remove code[1]. And then their policy seemed to be: Wait until someone
shows up and we can revert the removal.

[1] http://lkml.iu.edu/hypermail/linux/kernel/1212.1/01152.html

So I would propose to take this patch, but be prepared to revert it in case
some user yells.

Thanks,
Stefan
