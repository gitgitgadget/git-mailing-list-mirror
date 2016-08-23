Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAEB91FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 17:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752954AbcHWR4m (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 13:56:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34886 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbcHWR4j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 13:56:39 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so19118560wmg.2
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 10:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QvMPpjqt++dBLmMjFt6N08w6rWZR+QILzoqhaPnLhKc=;
        b=hNNUAZM052u2Jqulnf+vCsSYnjHHCylLSGTaLBNiR87cSru/qLhIOW/1U4cj6XqlIH
         Y9rp603hkOwev73h8hLdFYNo1YeMrBGVkHEWGv3UZzus7rUVg2E5m4MRdDbtLGyEqzbm
         xRCiYH63AsJw17jZBbvbH9IAHGbqO/BQc6WvVOxOogtgny2I32lJdmMoxfbkVE+hnkC9
         9+8mKRMv3R7ZlWCnLc8DQur8LpwE4ml2NSxupiN5Ub9ScuKx0Ze3iZzYYJhSh+El+Tfw
         7ESsG4+e9x3/GD+b6ydhQcmFXqOOu6xI1Gsldgvi121UbwOLnQ57nj0MdUA7U42YJ11A
         JlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QvMPpjqt++dBLmMjFt6N08w6rWZR+QILzoqhaPnLhKc=;
        b=J3VlZSLSrsd/z5AQgq5brq4RaWgFEXcbSIig83/9AYvxDfOydmVcnivrec/Pbcb10C
         3snfZSjESHQ1u3yjo7dV5lGeCk0EK6BxS4l1R3Yghi35hsBAYMuncPLEjCzmi9zzEqcR
         E40mzNkypOVQSEo2NFn0o8xlYl0zVJ9I8etTXt1aDXtMlbTKFCuQZLoUuyCocfb4meIq
         UsAeVNgQVZBwgBT9NVS8+8V5AEWOP00m9RHas20Gj7fwQ2k/oKbZgMoWsYCkieRqed66
         GqDU0qwg8fv3dwUTHKLCPNXpitn0y/X9DGYcjKrhauuqCVNvYQmduIcEp+LK1or8wMlB
         A9gw==
X-Gm-Message-State: AEkooutKMic+WJ1fQlR6MZcFQ66rKqHSqu3QyfXQZYKQJNGyeVhAfanSFH9y+qQn5hDQM0kdOhXZ0gNvqFqz2A==
X-Received: by 10.194.26.166 with SMTP id m6mr22895153wjg.120.1471974086138;
 Tue, 23 Aug 2016 10:41:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.230.154 with HTTP; Tue, 23 Aug 2016 10:41:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1608190954461.4924@virtualbox>
References: <20160816162030.27754-1-ralf.thielow@gmail.com>
 <20160818185719.4909-1-ralf.thielow@gmail.com> <20160818185719.4909-2-ralf.thielow@gmail.com>
 <alpine.DEB.2.20.1608190954461.4924@virtualbox>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Tue, 23 Aug 2016 19:41:25 +0200
Message-ID: <CAN0XMOLTc5zzjXwnpDwhs-coP9BVD659CpYEJYp_v4789M2CpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] help: introduce option --command-only
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Joseph Musser <me@jnm2.com>,
        Philip Oakley <philipoakley@iee.org>,
        John Keeping <john@keeping.me.uk>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2016-08-19 10:32 GMT+02:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:

> So how about fixing that? I would suggest to do it this way:
>
> - configure help.format = html (for "man", the current code would always
>   add $(prefix)/share/man to the MANPATH when testing, not what we want,
>   and hacking this code *just* for testing is both ugly and unnecessary).
>
> - configure help.htmlpath to point to a subdirectory that is created and
>   populated in the same test script.
>
> - configure help.browser to point to a script that is created in the same
>   script and whose output we can verify, too.
>
> The last point actually requires a patch that was recently introduced into
> Git for Windows [*1*] (and that did not make it upstream yet) which
> reverts that change whereby web--browse was sidestepped. That sidestepping
> was well-intentioned but turned out to cause more harm than good.
>

So I'll pickup the patch you sent [1] to my series and prepare the test cases
the way you described to verify that the 'help' command works.

Thanks!

[1]
http://public-inbox.org/git/03ae6a9d47cb95a54960bfdc90c5392f890ff1e3.1471595956.git.johannes.schindelin@gmx.de/
