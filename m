Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBF0C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 13:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbhLTNGv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 08:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhLTNGs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 08:06:48 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87CEC061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 05:06:47 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id m21so10852713edc.0
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 05:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=jkhcMgNBRBIDbaqIyDEaTg0dOP8W0FM+UR7jmyEmtVk=;
        b=VwayK/JQ0olW44J6FJim4Dobjb1YAUUszr+vQXv6YdrV1l6Te+9Nuo04ZxujJOqQxK
         l633IBZ1ojB3+Ip8lfj97lIOLHHVnAQ5W9XbzdkDr1jxCegCrGAgTCHgLG5XBkNrqzIt
         62QMr5XEAIfcCz8ypGZs/U+CMDaF/J3bCU4Ycx3J4qwuepG5zxpy7hKRHwJmdkRWkScs
         0s6ulpW+U4R709QrpDqOxzCetPrNxth9YOLQFsHyzzH8lsPqF77mbLOGbVIkWqxsqPnN
         f7o5LB1SgyT9yp604KtY9X1hiSxO8lpFPv8wxVpXY9PothvmGY5s9J6WANnXwT1GypSa
         EqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=jkhcMgNBRBIDbaqIyDEaTg0dOP8W0FM+UR7jmyEmtVk=;
        b=usbDMfM0lcADhGgMZeqJHWU2QtsdjpPN9QlSZ0iBVkXXLBRfZVrzS1x75NRsF2n4EZ
         LuWlNqA50U16OLiWMnbGIElFeFc6wOyuN7ufepyogk5XOTgAMizvoVagd2K7fnR5RK0o
         TPn4qeACgl+/Nl68wb0nArFuvN/J4s9eJYQkZD0qCYw8V2GJ4C8tt5AfgN/m5OnM3aS2
         cOGGuZe1DdHVvUJtNbLeQu2UqHNcZUGctqao4jaKDBWIihdoUnzjnB8E8SgmH+gO/nSz
         juhd/DocK0mefxVHi0k95L5CMwxCq5DrcFXTxoljIEJE+/tYkiLpCIak+ElIyPXvNryR
         A/JQ==
X-Gm-Message-State: AOAM5309oLuW6NnegI5p9vG+FPZBEjzYpXjBevHW6RcXXZZNXgHHs31w
        t6370Mllhdy6IPzV/Qvhwew=
X-Google-Smtp-Source: ABdhPJxiKMGtqDu3jJ5WkQ/Gwrmms9TdKi6P+UQnuJ0ANdD/esyM2w1hsl0G/o9RFO6oqN0eP/bcqA==
X-Received: by 2002:a17:907:86a6:: with SMTP id qa38mr4989809ejc.170.1640005606299;
        Mon, 20 Dec 2021 05:06:46 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gn11sm883461ejc.67.2021.12.20.05.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 05:06:45 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzINI-000PYS-TP;
        Mon, 20 Dec 2021 14:06:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: taking a break from Git
Date:   Mon, 20 Dec 2021 13:45:05 +0100
References: <YboaAe4LWySOoAe7@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <YboaAe4LWySOoAe7@coredump.intra.peff.net>
Message-ID: <211220.867dbzwhln.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 15 2021, Jeff King wrote:

Thanks a lot for everything. Your contributions, advice and example have
been invaluable.

I wish you all the best. I hope this isn't goodbye as far as interaction
with this project is concerned.

>   - I really am going to stop reading the list. Even if you cc me. So
>     please don't get mad if I don't review your patches, or respond to
>     bug reports. :)

A couple of practical questions:

Do you have a preference either way for being kept or omitted from CC?
I.e. if/when you'd come back to have that E-Mail backlog, or for us to
stop CC-ing you? Clearly you'd still get some traffic, but at least us
list regulars could take that into account.

You have various WIP code in topics at https://github.com/peff/git. Some
of which has your SOB, some not. I keep it as a remote and sometimes run
into prior art with "log --all <path>" and the like.

You noted a while ago (IIRC, haven't dug up where) that inline patches
of yours to the list could be assumed to have your SOB, does the same
apply to what's sitting in that repo?

I picked up/stole some patches from it recently for the e48a623dea0
(Merge branch 'ab/http-drop-old-curl', 2021-08-24) topic. It might be
useful for me/others to similarly pick WIP work from there in the
future, obviously while clearly communicating that this is based on some
WIP patch that sat in your repo, not something you submitted on-list.

