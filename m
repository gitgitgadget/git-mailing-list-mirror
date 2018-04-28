Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A70821F428
	for <e@80x24.org>; Sat, 28 Apr 2018 14:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbeD1OYE (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 10:24:04 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:34386 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeD1OYD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 10:24:03 -0400
Received: by mail-oi0-f52.google.com with SMTP id l1-v6so4075764oii.1
        for <git@vger.kernel.org>; Sat, 28 Apr 2018 07:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7Vzm+DIJrG0q/AWPjGg1xkJywxU+KUZEgDB1WukdgBE=;
        b=txGFlDrNWHMp38fUA//Vq3c8TpAVXoay83pCLdfBmxkCtkkLyb7XmN2+a2XFp6+HJJ
         BXtSb6QBqCGYnZ7FrDopGnJ5UBfB+3Lgal/qmlEUmAwnGkxQpc0RlgTW+20jIN49+xkZ
         7RT5ZQG0iYZN54mWLT5cZ19eh6nzzEBM8yE7E4WqgqxjHXD5WMM5DaBuzWS2UaJVRx6v
         u9LY6OnxOiwWI3Y9ZQWwGOZuJ3/6hgyCalKaC8k7bN6tdLTaPD665T9A5KOS51DV02yU
         0Dbl54G1aD21+IQVtEZzMVDyLk2+X50lKYtA9l9/a+qQpFC/pXXoCwxSkaQ6ZQPzDzBH
         AXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7Vzm+DIJrG0q/AWPjGg1xkJywxU+KUZEgDB1WukdgBE=;
        b=rs4A9Tsisfo8vLwK+5NB3NZNM+qm8GTpoEhFklgbkVCCebHsplkAgNvAb7DpYxOBak
         OO+90IZACJT+9r0m/ZC3wPZxn8hm4F+OObqaJVfo+4JrGHNWFVbM+Am6CQr1gzpev2XI
         JFxxLDP/uGBa1HcZGIb4K1CfGKNs/wdAT/ADCpkioEX6mudeamh12+2DLmwBYP5+shpL
         yX2qn73+k0flz7Qs1CMpBjmJaGtzC9BtottAfnmMZp1tVJKHcOI8LPmgI6EWBHWSEqrV
         SrNcrNtZyeDaYqNgRsnPDGsR3dpevq7rFPSueF9rl/43hfW5KkS0mE6GvhdwHKSC+1oo
         AKGA==
X-Gm-Message-State: ALQs6tD4jJ8/36GVz6A0egzION+sgwK4XCZOf3CHn1vNq78zraoZnG/y
        PiUErL1WM3dXbTBG0rpUgO3zdDiTjP8K2mwDkf4=
X-Google-Smtp-Source: AB8JxZp1S3YoTHzfkNA7T0PJmxcg1lEaZ54Jq6LpSGEX6tYL8bwjuf5g9JadujrUffpuhDHLBOBHgdkWoyqQoV+ypdE=
X-Received: by 2002:aca:aad3:: with SMTP id t202-v6mr3769372oie.30.1524925442435;
 Sat, 28 Apr 2018 07:24:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Sat, 28 Apr 2018 07:23:31 -0700 (PDT)
In-Reply-To: <1524753972.1088.9.camel@gentoo.org>
References: <20180413170129.15310-1-mgorny@gentoo.org> <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
 <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com> <robbat2-20180425T060717-325652820Z@orbis-terrarum.net>
 <xmqqin8f4qoq.fsf@gitster-ct.c.googlers.com> <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
 <xmqqefj24v3c.fsf@gitster-ct.c.googlers.com> <1524753972.1088.9.camel@gentoo.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 28 Apr 2018 16:23:31 +0200
Message-ID: <CACsJy8AfE4XMgTLuM=9aWV7eX5Hd8CqmFMuEgQaSxsLfGoBb5w@mail.gmail.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
To:     =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 26, 2018 at 4:46 PM, Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org>=
 wrote:
> For the record, we're using this with ebuilds and respective cache files
> (which are expensive to generate).  We are using separate repository
> which combines sources and cache files to keep the development
> repository clean.  I have researched different solutions for this but
> git turned out the best option for incremental updates for us.
>
> Tarballs are out of question, unless you expect users to fetch >100 MiB
> every time, and they are also expensive to update.  Deltas of tarballs
> are just slow and require storing a lot of extra data.  Rsync is not
> very efficient at frequent updates, and has significant overhead
> on every run.  With all its disadvantages, git is still something that
> lets our users fetch updates frequently with minimal network overhead.

I assume you're talking about the metadata directory in gentoo-x86
repo. This specific case could be solved by renaming metadata to
_metadata or something to put it on the top. "git checkout" always
updates files in strcmp(path) order. This guarantees time(_metadata)
<=3D time(ebuild) for all ebuilds without any extra touching (either in
git or in a post-checkout hook)

The behavior has been this way since forever and as far as I can tell
very unlikely to change at least for branch switching (major changes
involved around the index). It's a bit easier to accidentally change
how "git checkout -- path" works though. I don't know if we could just
make this checkout order a promise and guarantee not to break it
though. For it it does not sound like it adds extra maintenance
burden.
--=20
Duy
