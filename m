Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C3CD1F404
	for <e@80x24.org>; Wed, 27 Dec 2017 21:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbdL0VmG (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 16:42:06 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:46953 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751871AbdL0VmF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 16:42:05 -0500
Received: by mail-vk0-f65.google.com with SMTP id m15so23712665vkf.13
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 13:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Nkf3QN/9uxUvg07VsiEAA+GKcK8kQA4VllDyWwq57vg=;
        b=tlvUF4PgYCvvbTToCgP2IXUdgM4klznhV8q723peOzUPu5Gjy3PXYcK9zHqEyQ5DmR
         19OcrDqtwiOSPWtBbp2BKI0MDppeTyOvBVgVqzpn7ZwYhF+3P5uDh+U9NF31Hg28HRNR
         qLf9ALtid//6DzOJhS0+GBqMe2HJ8oUC0hcfB4fJwZaOnab5s3GjG9eFEWGrwurCKCQk
         W9QChN8l+kR1klKza1M+5O82nEimDQFCt9s8FfuMKHw01TWVq9UjEDOEG8SykUryM1wW
         OwXvI66xT1byb+zhrZpndS1XCqxm+8itaeGiYwWFqYgg7Swp6pjIQ8+0kOud2QnU2x5F
         y/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nkf3QN/9uxUvg07VsiEAA+GKcK8kQA4VllDyWwq57vg=;
        b=sRSOXYzfaGaQFM25LQuXJtnqj6ep5hL9t1lxTIZ+S+eCbXvdEblefEBl/RkBVFNixq
         L+f+skXxEBaY9abToCCj0BsEwFaZf4ViNTY6bPgsZZzXwtDuDrAxztOMY3q0PzPlnaco
         OZe9KjBrO1pdH0pfNKzhCqfcK5Zp/a/Le7t9vO/xDBOZbbmLR+nA6KnQLiK4e3y72YfF
         eALQ8vN92hogEGDCg53XrlwZ+SFy4dSTvt8j0+qrJZospRt315UFO35+E32HfsYaTDtr
         QQsOGjCLvE3/YA8l7DysuSfpyq1/IYWYQmLnopnS/qbEByMSzT2Vxgf/nM11Q64ii7rN
         chCQ==
X-Gm-Message-State: AKGB3mL2ispdDJ4Ku7OwIJHvgXNtO2ra0ucis88dBlHOrcjs1XkdMxGE
        F3bWQagrREKn//zcHJTE9FO8C6p6MLqSgKRjhJ4=
X-Google-Smtp-Source: ACJfBoswyvlcvdtQkHb6vAvl8mWCCsSNFZEF9HYjxL0S+NF0EmCPUWV3RgwfOZKJZac6+wj5H1+4KB69kNu+mb/Oeds=
X-Received: by 10.31.124.205 with SMTP id x196mr12424029vkc.119.1514410924896;
 Wed, 27 Dec 2017 13:42:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.83.46 with HTTP; Wed, 27 Dec 2017 13:42:04 -0800 (PST)
In-Reply-To: <DB47DCB3-DF66-437A-BF0B-4DF1838C2F7F@gmail.com>
References: <20171216125418.10743-1-szeder.dev@gmail.com> <20171227163603.13313-1-szeder.dev@gmail.com>
 <20171227163603.13313-4-szeder.dev@gmail.com> <DB47DCB3-DF66-437A-BF0B-4DF1838C2F7F@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 27 Dec 2017 22:42:04 +0100
Message-ID: <CAM0VKj=3ZQhjwtUFXFsMPzFrs7CYntrjJOcdQfOZ+0jjVVGVog@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] travis-ci: save prove state for the 32 bit Linux build
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 27, 2017 at 7:46 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>> +     --volume "${HOME}/travis-cache:/tmp/travis-cache" \
>
> I assume "${HOME}/travis-cache:/usr/src/git/t/.prove" would not
> work because that would be a mapping in another mapping?

't/.prove' is a file, but '.../travis-cache' is a directory.  It must
be, because Travis CI caches whole directories.

G=C3=A1bor
