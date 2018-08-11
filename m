Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4C91F404
	for <e@80x24.org>; Sat, 11 Aug 2018 19:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeHKW3a (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 18:29:30 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:45825 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeHKW3a (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 18:29:30 -0400
Received: by mail-ed1-f52.google.com with SMTP id s16-v6so6348389edq.12
        for <git@vger.kernel.org>; Sat, 11 Aug 2018 12:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=DtR98XblXqoJx8G7hU4Tri+hHjGR1QXySVDz5bN3tGo=;
        b=tPiWRb5U2ccisGDgKY/BQ5TA2+CfLlFpsjbq3hSBh/eRZ/U2kox0LGdW4+63pnkb+/
         31wV75YBcUUOsJT5Wrne2gm0f6Mi6A7Ky91aKDSKmKR6ZGclnxyUGva51EutnuszWbr7
         iZOtNMdCC11ebESxM4VaWtIuExPYvkgELN35XGVG7ylgZldS7KBjXdeHBsMA6k6BXhWe
         OA9+m7ryWVqjJpS5cC52ENcUWtUmmEKsyuKegTdAUFfOQSQlQu0riWUWYXWnw5SD58ms
         yp3KYY6Th/HbdpmleIVm0kg8v7z5KjzCxMdRe36QAzNiewaSlJSHQWqdpyySpqscpg2X
         i16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=DtR98XblXqoJx8G7hU4Tri+hHjGR1QXySVDz5bN3tGo=;
        b=XXCLvtLdZ2J8tPaanpIqomrLiVil25FtD7I+VtCHM2zncmdmQHWQ0g2cnct+/ywXHR
         URCFHPxGauipqL+QKQpXWbay0EHtoZ/s19uJfLUY9LmckGaXiTdfHGSZvm6Wg84Lc84u
         uqSN4XgT9wJ6u05wb4I8vCE89pxiwH0S13yaX0eTC7MpkbTrLMOX4x1Dyz7qRxy4Kiq1
         VUEpyM8aSyDQPSW12yz1j4r0G34D89GC3+oUul0T8+LuqwwdW/Pcs2VUolOPD49+ji6k
         Oszzs3hpNaGQjywhmeP2E5TgIDHM64zNY1KKoHHOCF0g+ovC77rFtTf2DRxB+hMlH9Cx
         YlhA==
X-Gm-Message-State: AOUpUlEHfMG3cVAN7VKBBUMx/J53ynE98KdebAwKoRF5zhImQ7DFg+KT
        ZY7jtwl9HztoNKcRTNUImFQuVZzG
X-Google-Smtp-Source: AA+uWPyE5H27taROo8Zkwi6D8IIKPJtF/8x+ALSJcWaqjDaM5pL3qV6F8JvANegMPi8tJ18h/2PFBA==
X-Received: by 2002:a50:8327:: with SMTP id 36-v6mr13849147edh.305.1534006443725;
        Sat, 11 Aug 2018 09:54:03 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id f42-v6sm6252474edf.19.2018.08.11.09.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Aug 2018 09:54:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fsck: use oidset for skiplist
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de> <54a5367f-f832-402c-f51b-3225c92b41ad@web.de>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <54a5367f-f832-402c-f51b-3225c92b41ad@web.de>
Date:   Sat, 11 Aug 2018 18:54:01 +0200
Message-ID: <87lg9csv2u.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Aug 11 2018, René Scharfe wrote:

> Object IDs to skip are stored in a shared static oid_array.  Lookups do
> a binary search on the sorted array.  The code checks if the object IDs
> are already in the correct order while loading and skips sorting in that
> case.

I think this change makes sense, but it's missing an update to the
relevant documentation in Documentation/config.txt:

    fsck.skipList::
    	The path to a sorted list of object names (i.e. one SHA-1 per
    	line) that are known to be broken in a non-fatal way and should
    	be ignored. This feature is useful when an established project
    	should be accepted despite early commits containing errors that
    	can be safely ignored such as invalid committer email addresses.
    	Note: corrupt objects cannot be skipped with this setting.

Also, while I use the skipList feature it's for something on the order
of 10-100 objects, so whatever algorithm the lookup uses isn't going to
matter, but I think it's interesting to describe the trade-off in the
commit message.

I.e. what if I have 100K objects listed in the skipList, is it only
going to be read lazily during fsck if there's an issue, or on every
object etc? What's the difference in performance?

Before this change, I wanted to follow-up my ab/fsck-transfer-updates
with something where we'd die if we found the skipList wasn't ordered as
we read it, but from a UI POV this is even better.
