Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3A901FAE2
	for <e@80x24.org>; Thu, 15 Mar 2018 08:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeCOIg2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 04:36:28 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35949 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbeCOIg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 04:36:26 -0400
Received: by mail-wm0-f50.google.com with SMTP id i194so8752564wmg.1
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 01:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=3KS1q1ME8AvuZsyl71bu+3SG8aHN3NVCi1jrkTSXzD8=;
        b=LVpAsy/OsG0y7bFuwlfZmU9NKu27Z/6EuiqVgEpNoCnupAnqAXpv1M+/iVCUeomsUJ
         nKFyGU3KHdY+lGzw0vqh7zkcecklJw1i7Mr9n4ActYLesiz90XyMHMJHBP8sNUrqN1Ln
         OCkPanadjWY+bLEcuicbZ2JxmGyoYrPrkJRp2KTNYYlFE7FeYZjkq71ZPbb7IdKaTvyH
         WfQ46E/opgiu9iJkr4oJ/qg+42gscuESxNemFARPQqaFjJJqz4k6bNYus8kyujRAHkTr
         nvDwVZElf6gmbRKKpJF+50/CIgB8qvf3ehTpmLKWf/S7KZK5xQBck18xDNSMRRxe24R+
         VKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=3KS1q1ME8AvuZsyl71bu+3SG8aHN3NVCi1jrkTSXzD8=;
        b=dPvRajIhfWgGJFryXpuKV+Lg5zRb6z31yMsVL8ktcFCulxfIpzjKBDic7fBPTofzSK
         iAukPkRUdKUePjPsyfI3+Kyo+x95Guo7D9VbzdV39kZYuZfWegsr35dFVirJVBDRGdbl
         /DXoIVdpwbCoRaLJLVKs4KV5/rhacqWBC/WYxOveQGvvX4AMSQE6cx5T0QRMzsh8bBFq
         vSGwaJaRO0rLeb+eL4moPFbfilHquFItdPAV24sSm4z1T/SneUHEntXME/KGP7kvaqL/
         O8+tUeNf+fMHEEwfGxPEXnE2rX3bvISMrUXCCn+hEmLjxd9jsTAhPBx4+QQYtFu70GMW
         1HLQ==
X-Gm-Message-State: AElRT7FtJmLW+eqy/yd+UYJVaaBqryNzaVq8VYcefM1vah2io4ocaJOd
        RZSp9kss2PxNJXvPHwb4XoY=
X-Google-Smtp-Source: AG47ELtMyhIRf4dfze7b0qgByRFhKhFRGl0IWucrIJAPqlVizfLANMEUlZKRWe43xCxi++EGh/aMQQ==
X-Received: by 10.28.29.194 with SMTP id d185mr876169wmd.9.1521102984736;
        Thu, 15 Mar 2018 01:36:24 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id z3sm4151512wme.3.2018.03.15.01.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 01:36:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Takuto Ikuta <tikuta@chromium.org>, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: What's cooking in git.git (Mar 2018, #03; Wed, 14)
References: <xmqqefkm6s06.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <xmqqefkm6s06.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 15 Mar 2018 09:36:22 +0100
Message-ID: <87r2olenw9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 15 2018, Junio C. Hamano jotted:

> * ti/fetch-everything-local-optim (2018-03-14) 1 commit
>  - fetch-pack.c: use oidset to check existence of loose object

Looks good to me, and great to have such an optimization in.

> * ab/pcre-v2 (2018-03-14) 3 commits
>
>  Will merge to 'next'.
>
>[...]
>
> * ab/perl-fixes (2018-03-05) 13 commits
>
>  Will merge to 'master'.

Given 2.17-rc1 next Tuesday according to your calendar, what's the
status of these two landing in 2.17?

I'd like to annoy packagers with all this perl/ stuff in just one
release instead of spreading out out over two, and without ab/perl-fixes
they'll need another hack to avoid installing our Error.pm.

The ab/pcre-v2 is less important, but given the minimal nature of it
would be very nice to have in 2.17 as well so we get off the
mostly-unmaintained v1 sooner than later.

> * nd/repack-keep-pack (2018-03-07) 6 commits
>  - SQUASH???
>  - pack-objects: display progress in get_object_details()
>  - pack-objects: show some progress when counting kept objects
>  - gc --auto: exclude base pack if not enough mem to "repack -ad"
>  - repack: add --keep-pack option
>  - t7700: have closing quote of a test at the beginning of line
>
>  "git gc" in a large repository takes a lot of time as it considers
>  to repack all objects into one pack by default.  The command has
>  been taught to pretend as if the largest existing packfile is
>  marked with ".keep" so that it is left untouched while objects in
>  other packs and loose ones are repacked.
>
>  Expecting a reroll.
>  cf. <CACsJy8BW_EtxQvgL=YrCXCQY7cEWCQxgfkeH=Gd=X=uVYhPJcw@mail.gmail.com>
>  Except for final finishing touches, this looked more-or-less ready
>  for 'next'.
>
>

As I noted in 87a7vdqegi.fsf@evledraar.gmail.com and
877eqhq7ha.fsf@evledraar.gmail.com (both at:
https://public-inbox.org/git/?q=87a7vdqegi.fsf%40evledraar.gmail.com) I
think we should change the too-specific behavior here to be more generic
(and am happy to do the work pending feedback from Duy on what he thinks
about it).

I'm also interested to know from those at Microsoft (CC'd some) if the
mechanism I've proposed is something closer to what they could
eventually use to gc windows.git.

I know that now it doesn't GC now, and they have some side-channel
mechanism for pre-deploying large (daily?) packs to clients, if it's
adjusted as I suggest gc could be told not to touch packs of that size,
leaving only stray small packs from "git pull" and loose objects to GC.

I may also have entirely misunderstood how it works, this is from brief
in-person conversations at Git Merge.

But as far as mainlining some of that eventually I think it would be
good to get feedback on whether the mechanism I proposed would get in
their way more or less than what Duy has, or be entirely irrelevant
because they need something else.

Thanks!
