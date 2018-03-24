Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4B421F404
	for <e@80x24.org>; Sat, 24 Mar 2018 12:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeCXMvD (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 08:51:03 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34955 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbeCXMvC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 08:51:02 -0400
Received: by mail-wm0-f43.google.com with SMTP id r82so7969494wme.0
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 05:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=2VAwPcEeEEZKXIgemtwsIgdV1Y7TRx8w1BGq/q16XsQ=;
        b=RNioOXkQzmZ4YOX7JmlmAZlG2O5kmB3dDZD2NWl/JCsYnGx4LHANP/586778wTMv0D
         WoglVgJPK0NGWt0+uoV7fuaWdfaxCVUZ+UaIl4KfGIxV0EMLMOySCFwLWDqbmoqMstiC
         GXw5QqF/RodPW0hErH6MmI55I9HBvqw0UHcZzmQtI6ilo58rjwLmuLBrLqSTgV5qXe2y
         N2fVOAM5rZrpQKw39Y4UQuFpeYFLqTUUmrKyJBbmGaObmpGkdWSDZvMPJTAaWWRMRr8z
         YLD+0h9bOa1EnKD1ETrhEIJnaIIEqAk3q+rcwVv8RvgZ9Y9xH9dqxMZiuCG6ITPCb8Nq
         mMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=2VAwPcEeEEZKXIgemtwsIgdV1Y7TRx8w1BGq/q16XsQ=;
        b=rtu/0O3o6zZ0P+wllEwT+LkvG2DfYMp1C7tBUjXNnx5NZpEbCTvWm7qvdvzvGLGOPy
         7VT072/mjaAMI6KocTheEB3NDqOjxUE/T0Lo6x1DNOCsW7WKYZbUfZeau4vcPlVqV0Ry
         8RH9Ljxe+5nLpt+IwDdZHG5J8BbBA6Umjn4XM33mKRk+poBb7AoYsBd2TtwT/QDfyjqi
         ekE2uUvAHCZQzhe8TGskVcSZSgbM6XjBT7mQ5a7ZXPv/ENcZ+kt68NbnLZ+Dpcy+TAhU
         kVg0YN24WEaSSPHse+L0TYqHFbBUziRoF8wwt9oTed8jCCFqb2LxdvL9Mi8bidapGlQr
         EmGQ==
X-Gm-Message-State: AElRT7F6jg3O+OC2pqcGfL3UO3BNDZYLCtcoOoYeA4NMczGbyKCLTywL
        ERcX6ZkA1NIHUwnTKEQVt1M=
X-Google-Smtp-Source: AG47ELuqxmYbnYFQyePSvS0YQ8I+n4RDTVmAMzDK9x4oCNGvit4vLaY1oWrLt3hk7UomykeWFv7Rfg==
X-Received: by 10.28.132.133 with SMTP id g127mr11758795wmd.50.1521895861379;
        Sat, 24 Mar 2018 05:51:01 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id o70sm11153365wmg.3.2018.03.24.05.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Mar 2018 05:51:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/36] Combine t/helper binaries into a single one
References: <20180317075421.22032-1-pclouds@gmail.com> <20180324074505.19100-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180324074505.19100-1-pclouds@gmail.com>
Date:   Sat, 24 Mar 2018 13:50:59 +0100
Message-ID: <87bmfdy6vg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 24 2018, Nguyễn Thái Ngọc Duy wrote:

> v2 fixes a couple of typos in commit messages and use the cmd__ prefix
> for test commands instead of test_, which avoids a naming conflict
> with the existing function test_lazy_init_name_hash
>
> [the previous v2 send out was aborted because I messed it up with some
> other patches]

This whole thing looks good to me, and I've applied it to my own build
and run several modes (normal, split index etc.) of the test suite with
it. Didn't get any problems.

Micronit: If you M-x sort-lines (and I assume similar in other editors
that have a function to sort stuff in ASCII order) the test-tool.c list
you get this diff on top:

    diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
    index cd5e28b045..c38939b93e 100644
    --- a/t/helper/test-tool.c
    +++ b/t/helper/test-tool.c
    @@ -32,8 +32,8 @@ static struct test_cmd cmds[] = {
            { "revision-walking", cmd__revision_walking },
            { "run-command", cmd__run_command },
            { "scrap-cache-tree", cmd__scrap_cache_tree },
    -       { "sha1-array", cmd__sha1_array },
            { "sha1", cmd__sha1 },
    +       { "sha1-array", cmd__sha1_array },
            { "sigchain", cmd__sigchain },
            { "strcmp-offset", cmd__strcmp_offset },
            { "string-list", cmd__string_list },

I think it makes sense to keep such lists in ASCII order (" before -)
for subsequent edits where one or more things are added to the list and
then sorted before submission.
