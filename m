Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2DCE20248
	for <e@80x24.org>; Sun, 24 Mar 2019 12:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfCXMeC (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 08:34:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36528 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfCXMeC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 08:34:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id y13so7091151wrd.3
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 05:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=9nwn4AuHYHIG2Bj4DGY3re1MhDtlRPl498PjhBZ4jZU=;
        b=uM7F5M1maWDK9UeQ5TQIE7CqXMGiN1g4oes2OZcvUmaZOvpGXTpAWeA5ISU/ZVO83f
         XPGo0IPWWe7IIpzPoCNNWfK0FGibEUhU2w5pcGJfhN7Hi6sW+9Bpyaw/S9RExba6BxJA
         /y9n/w7N7F8WgUIR+KLC9MCVDunqL8PwqWObrEttjwklaNr3OGftqejUpZ2CzTbQqLvU
         NhwpbWMtXAO8AFso0rOJf6SS/QY5QhWDwqlwHMeMKFbjaMhfkYvbdz+Zz+6wlv5NE7uc
         6j3u8CVo8HlrJc+xhyIzHmrpqkzKCRj+uRNDvy7ST8JbbgPMcgtnO6Qe6QTENFY1WVfT
         8aVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=9nwn4AuHYHIG2Bj4DGY3re1MhDtlRPl498PjhBZ4jZU=;
        b=Z7Q6ltOfPcfIJR8mALFH3RYw8B8qlFckkUPI1pZS78FoxiP7I9Fge0pGZOynUQqn0K
         erxMMmOBl88IXrkx8+fypeTjLr1IMXTHvkEyBwUT6xu/ErInKiCm68g3JjlCw7V4Ny2D
         V+zx3jecpS7rS/uBQbvfGBRE1nmyy2XMGqscjIwxbVmyl43wzQkq+9WQBBhoHSU9wWpp
         w81+szEO0Q09H6WhSheXZ14EK6KfbdycNGD7sedz4BiJIOYHV8U60RdRT5X6f0CzwZ3D
         l2YmxcvHHuL/wxLHsC9vvrHlxnV4KxcP6XaPD/L7FmcntiwZelkZF9cdTzMqQesk7JtA
         rsiQ==
X-Gm-Message-State: APjAAAWqyzSQB6G7gaUMOava7Y4YxPx5ewGXkFApfQ0B81CZaZxIYwsJ
        rsg/3t9PuWE8Qv9w9sG2jS0=
X-Google-Smtp-Source: APXvYqwtmEXfdzU7jdZCuzqk7lEvrrVkWhCZKYRtezK6BZs9Sa+1plt3jl0FxdN7hk8go9JomRYFhA==
X-Received: by 2002:adf:f5c7:: with SMTP id k7mr12058885wrp.197.1553430840129;
        Sun, 24 Mar 2019 05:34:00 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id t14sm6259622wmi.16.2019.03.24.05.33.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 05:33:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH v3 1/1] trace2: write to directory targets
References: <cover.1552519463.git.steadmon@google.com>
        <cover.1553202340.git.steadmon@google.com>
        <ce5258610ffbc2e498ff33336c5c89b69468d4fd.1553202340.git.steadmon@google.com>
        <87bm21coco.fsf@evledraar.gmail.com>
Date:   Sun, 24 Mar 2019 21:33:58 +0900
In-Reply-To: <87bm21coco.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 23 Mar 2019 21:44:39 +0100")
Message-ID: <xmqqlg14pi2x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> The reason I'm raising this is that it seems like sweeping an existing
> issue under the rug. We document that the "sid" is "unique", and it's just:
>
>     <nanotime / 1000 (i.e. *nix time in microseconds)>-<pid>

If it is just that, then it cannot be unique, can it?

Let's just fix the wrong doc and move on.
