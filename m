Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 965AF1F7D2
	for <e@80x24.org>; Sun,  4 Jun 2017 07:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbdFDHqs (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Jun 2017 03:46:48 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:38288 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdFDHql (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2017 03:46:41 -0400
Received: by mail-it0-f52.google.com with SMTP id r63so52106996itc.1
        for <git@vger.kernel.org>; Sun, 04 Jun 2017 00:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5uQkV+9zQ0LDeoqf2ELkamP2lS0jyzw2yhDxxX4E8DM=;
        b=P6gKNq9xsYXSdadRaLwGtOY7TEJG3vhJ7FR3P5zxESFrmJHrMdJz+q1bxts0Z+Wy/f
         /YaLmsEWdGGkkOEOBgSodWewRE9aOwDlZDgLgBSo/+zeS5qVMKOKG5pDL7OcGrlosyGt
         RbKG/4xrKAWbnju/aUAw7Zw08CzATvzw9qo9IbXhi/evGqdmUBY72QihJJYB8ljB8swe
         UB4jwyO+n2JGrS4oSMXMDXyOT7WeHJCDncG2nRmji09Gi2T5NA87pVLNg2pKw9mc1+I2
         orjIEGtJH2ng2olF9khu1ElQpFmIBq1Ims3NqxwMY17tyYBAo/7BYvYwl3SiI/O0MvQt
         315Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5uQkV+9zQ0LDeoqf2ELkamP2lS0jyzw2yhDxxX4E8DM=;
        b=qZXCN/2RJgUPBKZtVc4Gw4W4SNv6ybuNZnNWNflWMyOoTMrxeiXRO5ySl9nq3aos2T
         TCGGXh82Rs7fM4h3hpHVgq6/PKsr4548xsz31WIeY8idGkBPjnVpKykrWY8X2oY4yGnR
         WLWLb9h2I5ybwLHuECm6GEtvQUhGXlxZ0L+QJiqN2QtOLhTSAYG9uxiHM76fqAtzAReO
         kbCLtRta6ZqaOw/2e90iLWunD9ntywhzO8KMQobqdas2h84pZQ+3duQ7ITY0/qd2K/AB
         w76s12E1gG62SJHc4WVD8cJIGLl/ObzfqEKg2cpCiLiE6Nu1sd0Mhg1opd4fMhVo4C1g
         18CQ==
X-Gm-Message-State: AODbwcDpj7KMDUyxBaoGwLIvDer5EXdK2ZaME7jZoIgeghHXU43JVXq/
        alKzEMCuyLcjBJvVEu58/RZhuxaPlw==
X-Received: by 10.107.201.131 with SMTP id z125mr14098072iof.160.1496562400205;
 Sun, 04 Jun 2017 00:46:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Sun, 4 Jun 2017 00:46:19 -0700 (PDT)
In-Reply-To: <xmqq1sr0wm0i.fsf@gitster.mtv.corp.google.com>
References: <4c3fed40-774b-8ae6-fa1b-50efe6ef552f@gmail.com>
 <20170602102853.23073-1-avarab@gmail.com> <xmqq1sr0wm0i.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 4 Jun 2017 09:46:19 +0200
Message-ID: <CACBZZX4XOaN8o89vetoU8NMqRH+BaqHGkxq77MpqzvAM40exEA@mail.gmail.com>
Subject: Re: [WIP/PATCH 7/6] perf: add a performance test for core.fsmonitor
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Thomas Rast <tr@thomasrast.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 4, 2017 at 3:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> This is WIP code for the reasons explained in the setup comments,
>> unfortunately the perf code doesn't easily allow you to run different
>> setup code for different versions you're testing. This test will stop
>> working if the fsmonitor is merged into the master branch.
>> ...
>> +
>> +     # Relies on core.fsmonitor not being merged into master. Needs
>> +     # better per-test ways to disable it if it gets merged.
>> +     git config core.fsmonitor true &&
>
> Will stop working and relies on not merged can be read but I cannot
> read "why" explained, and I cannot quite guess what the reason is.
>
> If the code to read the configuration is not there, setting this
> would not have any effect.  If the code is there, setting this would
> have effect (either talking fsmonitor helps or it hurts).
>
> And I do not think we'd ever see a version of Git that always relies
> on talking to fsmonitor, i.e. "git config core.fsmonitor false" is not
> a way to disable it, so...
>
> Puzzled.

Sorry about the unclear brevity.

What I'm referring to is not a limitation of git (we'll always be able
to turn off core.fsmonitor), but a limitation of the perf framework.
There's no way to run a test like this:

    ./run master next -- p*.sh

And have some information passed to the test to apply different
runtime options to the test depending on master or next, or be to test
master twice, once with the fsmonitor, once without, which this
hypothetical feature would do:

    ./run master:"GIT_PERF_7519_NO_FSMONITOR=3DY" master -- p*.sh

So right now the test works because there's no core.fsmonitor in
master, so turning it on all the time only impacts avar/fsmonitor, not
master.

I started trying to add this to the perf framework the other day but
ran out of time, the option should also be passed down early enough to
be intercepted by the GIT_PERF_MAKE_COMMAND, so you could do e.g.:

    GIT_PERF_MAKE_COMMAND=3D'make CFLAGS=3D"$F"' \
        ./run v2.13.0:"F=3D-O0" v2.13.0:"F=3D-O1" v2.13.0:"F=3D-O2"
v2.13.0:"F=3D-O3" -- p*.sh

To test the same revision with different compilation flags.

A change like this would break the ability to enact certain perf
optimizations, right now we unpack the revision(s) you specify into
<sha1-it-points-to>, and e.g. make use of the fact that that directory
is already unpacked so we don't need to unpack it again.

If there was no way to pass a flag to specific revisions being tested,
then perf could just optimize:

    ./run v2.12.0 v2.13.0 b06d364310 -- p*.sh

To skip the b06d364310 run entirely since it's the same as v2.13.0. I
think breaking this minor assumption in the framework is fine, but
it's worth noting that it's an assumption we couldn't make anymore.
