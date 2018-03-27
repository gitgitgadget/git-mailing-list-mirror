Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76C791F404
	for <e@80x24.org>; Tue, 27 Mar 2018 05:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751065AbeC0FH3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 01:07:29 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:40632 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbeC0FH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 01:07:28 -0400
Received: by mail-wm0-f50.google.com with SMTP id x4so6855922wmh.5
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 22:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4Wxvc65D9TjqGwJ45eVAhrwqeXWfKTR41TC6NvU5/Is=;
        b=ZkGAOFtL+uD4LHLwHdh2RYHy9NYHfmF/CseSw7z3hyteqjQ42522I+oUyCkovqaGCQ
         0i+tXpxjaWcEkx6+6V1aYWOpkk9RSws6E+C0Fhwjy+muBXZCkvFzIRB4hxXTbrHGOCM/
         iPW6JUM294YnD6StY8l/fd/wdyrdKv2W/2REQmBWrxHrnMfpuYhm6B4N1ZIU29W6J9GV
         CRsu6TBUGRGs+qK5RBWiIl2CtEX6wd6nTmYrTSsHmlc1kvJNXQNGTLhyTi72yiv0m0+h
         tlGl7rylKpJo7099TJj8kM4/xW7ZJCcyJng8UkDKIeEcwM4wz3GR3a30htLwnWaGaVbU
         v+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4Wxvc65D9TjqGwJ45eVAhrwqeXWfKTR41TC6NvU5/Is=;
        b=isM+RwdzYkVO+Xljq75y5g9ZlifEjqCu2BBpDXIHTn+Fo7MhkeNT2/SYgJLHuujgB/
         38Ru0F0HkZAJdu4W3XagcW3ZlDeBkAFzJviy0BerijirHiUlazTtX5HSuoN9ysKDw8QG
         uE2RWOpEtJ5PxExsH6NOkVDnI4cUdwkgkUd6vtlpjJgTsVOuG1SsCPc73g96fLwLzJzj
         6mxaq3CByrUmj0Xt7eFdo7wh18hNKBCvjOdH+PQ2bRQb5U4AMvAeKALM3NnRwqNEs+7o
         6nsLtCrWJhv8MyBSNMT0++XRWILYp/slCKrfUMz5/JoyRGX1YTAv1YY9NHvp0Bqs5ALC
         g2Xg==
X-Gm-Message-State: AElRT7GXHhtfqrSNnYiJMwHNP0QXLaH+WxhtanZDZlpI275kknO/egBd
        u8GbIbZ5nIoDp0eYJyCeyGU=
X-Google-Smtp-Source: AG47ELttkoJwnVBkY3iYZqynYk8EFnKyrWnikY7P+nymZF3LGNp3jBZlNim4e5wOzPo8+Ify3Ukvpw==
X-Received: by 10.28.19.193 with SMTP id 184mr15926132wmt.158.1522127246399;
        Mon, 26 Mar 2018 22:07:26 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u110sm1064725wrc.72.2018.03.26.22.07.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 22:07:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Wink Saville <wink@saville.com>, jeffhost@microsoft.com,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v5 0/8] rebase-interactive
References: <cover.1521779249.git.wink@saville.com>
        <cover.1521839546.git.wink@saville.com>
        <CAKk8isqj3OusAE8OJtcys0a-Yj9fgQNn=DtLe-ZGYNzcKp=-3Q@mail.gmail.com>
        <xmqq7eq2h0wa.fsf@gitster-ct.c.googlers.com>
        <CAKk8isoJQrikitO7ezRajgphUXYR6207k4UkXP6r57WJEFBaDA@mail.gmail.com>
        <CAKk8ispSgNgZxS7KfuOyxfU53tzesvNyLRaNXFZa3K7SCbaRkQ@mail.gmail.com>
        <xmqqzi2ude4w.fsf@gitster-ct.c.googlers.com>
        <9ca76d31-828d-0b6f-5069-375792c1f55d@jeffhostetler.com>
        <xmqqh8p2d8jh.fsf@gitster-ct.c.googlers.com>
        <d56a60a8-e735-b147-a2e6-4e48461ad701@jeffhostetler.com>
Date:   Mon, 26 Mar 2018 22:07:24 -0700
In-Reply-To: <d56a60a8-e735-b147-a2e6-4e48461ad701@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 26 Mar 2018 14:22:39 -0400")
Message-ID: <xmqqy3ie9kdv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> I did the uint64_t for the unsigned ns times.
>
> I did the other one for the usual signed ints.
>
> I could convert them both to a single signed 64 bit typed function
> if we only want to have one function.

I still think having sized version is a horrible idea, and recommend
instrad to use "the widest possible on the platform" type, for the
same reason why you would only have variant for double but not for
float.

intmax and uintmax are by definition wide enough to hold any value
that would fit in any integral type the platform supports, so if a
caller that wants to handle 64-bit unsigned timestamp for example
uses uint64_t variable to pass such a timestamp around, and the
platform is capable of groking that code, you should be able to
safely pass that to json serializer you are writing that takes
uintmax_t just fine, and (1) your caller that passes around uint64_t
timestamps won't compile on a platform that is incapable of doing
64-bit and you have bigger problem than uintmax_t being narrower
than 64-bit on such a platform, and (2) your caller can just pass
uint64_t value to your JSON formatter that expects uintmax_t without
explicit casting, as normal integral type promotion rule would
apply.

So I would think it is most sensible to have double, uintmax_t and
intmax_t variants.  If you do not care about the extra value range
that unsigned integral types afford, a single intmax_t variant would
also be fine.

