Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAE751F42E
	for <e@80x24.org>; Mon,  7 May 2018 10:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeEGKau (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 06:30:50 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:41595 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeEGKas (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 06:30:48 -0400
Received: by mail-pg0-f54.google.com with SMTP id m21-v6so19908896pgv.8
        for <git@vger.kernel.org>; Mon, 07 May 2018 03:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7C86Cn31Pyx7zrjnXQIFKKb/qZlwGfptkc6leQ03xDA=;
        b=Y4mHXC9szaCm8t/A3RCMf2K5XbVUvq2Lz5MJmdhdaxdgNuMAAjkoloA/TU/zTNEZbg
         YPBacX6L4/sh10dbNeyESiDi2vZHPNAyuJ7ReNOSAaP6B8psA1BuQnZd9T7amekhE98Q
         Wk4la8vI8NVqntn34FuY9MaIFr2ctCfgx6Y1sNEWCPIMP3C/r2pQ2tgHrscXVd+Hj1Cr
         0v3f/qtbQ4m067pIhiHGg3YqopCHDucFV18dr7bwv4EBxtWuNlfGVloK2ZMq+Hzv+GX4
         LPEJN6jV3gGqM9IA7wXbfDugHKYj85L9vYfCv2dAiBDdBZzSkO3nfdNho+arGat5pczc
         w02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7C86Cn31Pyx7zrjnXQIFKKb/qZlwGfptkc6leQ03xDA=;
        b=LHkCY8dOAd7Ua8cBtNFIPKXN6YgZtfwvT2Iky4x6bd1MNKXHYd1YWTxERrbtq2YNH9
         +xIpdLnRcZ5C0BoMJZ6zDPqcqe7HlH0x3CvHJEqrdEgaMsfR82UzznhcrYh1UlBwCBQ7
         NZDDNnLxyqsH//3I0Se8eit6UB7AnphpqcUrrWbZHQtKRAVTIgBI1fdKZB93YzvF9DCN
         EOxOray7NCwaSaiHJBfZWb95ytNMTHMx8MSdla31BkM2yDOnE4PxjM0IVoWAoumIDRCv
         +EZigRfrfZMpK4/jkPmWkgKAd3nqUDxRnf2WxxvvnIWpsQeA+hUjvqmw5NgmToYvsntp
         8bGA==
X-Gm-Message-State: ALQs6tCbsH0sbMdTigSIHQHbttZzf97heNzjAJhFIGQmoPW5GKAIpzY7
        s60RXfd6kvoA/woTgHJddEZeE/jAhFY7Gf+HTOu/NBmvSAQ=
X-Google-Smtp-Source: AB8JxZp8JmHI8euSAkl3GONRoRYPad+EJGRQNME6dLF0LO6Y4uogobxQcoVudkvliZ1vXkde7aldshDyeCu8FCGPOqE=
X-Received: by 2002:a17:902:9a90:: with SMTP id w16-v6mr37511755plp.390.1525689048281;
 Mon, 07 May 2018 03:30:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Mon, 7 May 2018 03:30:47 -0700 (PDT)
In-Reply-To: <20180506231752.975110-11-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net> <20180506231752.975110-11-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 7 May 2018 12:30:47 +0200
Message-ID: <CAN0heSrbG+Axs=xq=MdnA=m98Habi_uHS3hj6xweCHqufA7Vag@mail.gmail.com>
Subject: Re: [PATCH 10/28] t: skip pack tests if not using SHA-1
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7 May 2018 at 01:17, brian m. carlson <sandals@crustytoothpaste.net> wrote:
> These tests rely on creating packs with specially named objects which
> are necessarily dependent on the hash used.  Skip these tests if we're
> not using SHA-1.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  t/t5308-pack-detect-duplicates.sh | 6 ++++++
>  t/t5309-pack-delta-cycles.sh      | 6 ++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
> index 156ae9e9d3..6845c1f3c3 100755
> --- a/t/t5308-pack-detect-duplicates.sh
> +++ b/t/t5308-pack-detect-duplicates.sh
> @@ -4,6 +4,12 @@ test_description='handling of duplicate objects in incoming packfiles'
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-pack.sh
>
> +if ! test_have_prereq SHA1
> +then
> +       skip_all='not using SHA-1 for objects'
> +       test_done
> +fi

Add something like "FIXME please expand this test", either as a comment
or inside the skip_all? That probably goes for all patches in this
series that skip tests.

As it is now, it feels to me like this is simply stuffing tests away
that are failing. When your primary focus is to run the test suite with
another hash function, I can see why you need to do this change. But if
the goal is to eventually have another hash function and test things at
least as well as before, I think leaving some sort of note here would
help someone who later wants to resurrect those tests that this series
suppressed.

I realize this is related to my comment on the previous series formally
changing the on-disk format [1] and that this comment is along the same
lines as my comment there.

[1] https://public-inbox.org/git/20180427210823.GB722934@genre.crustytoothpaste.net/

Martin
