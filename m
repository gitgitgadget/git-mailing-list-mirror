Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9A4120248
	for <e@80x24.org>; Mon,  4 Mar 2019 04:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbfCDE2E (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 23:28:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38482 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCDE2E (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 23:28:04 -0500
Received: by mail-wm1-f66.google.com with SMTP id a188so3275725wmf.3
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 20:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PlxZqkt/z8G5ZGraVnW+DsFEhdhKBIVn+dw2+tFg1ak=;
        b=JZI/WGJTc3eIK5Nhs4IbBieufHReRcU+lxCAlBsCGkPA+5z9KGHGC7ftdKu66euhCf
         M9MrgerprmefxxMmt55f3FdOgl/uYAAQcKiMN9sX2+p3eVV9Sm0D1yTj5u2KXme5uGsL
         q+qfq1nuDNJ4LBmzHr8DD0TEUCQoPQJOsgS0W3fL7SnURBBxRAHOU89KCSVAHNuSaUEn
         wn0SyQfBfXMZ5y4LLhS7kHwdzm+JAMVFgmxuj84jNJxsxhNc/9Gjar16+ucG5zUWYIvL
         pEGMNC8CZl27vc+cYFB1Bd1KnqpwsxTewngPk+d3e6IKSCIV23p/SouRQg9kJkxpzeI/
         mP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PlxZqkt/z8G5ZGraVnW+DsFEhdhKBIVn+dw2+tFg1ak=;
        b=swZ/l+sW1osHFmAzlYL/ZZtD1/zRuNZnXzqfRgk9Ed5sZvnH+3GQT/zdtyU492qK5J
         DzApwnnyb1j366OWXLiAlyirxlITnAH153n66WgEfNQ10rSh9asRboL0XTQPIVBgIbwR
         EeobIwX6gFFSw3KptWyjvvNS5rYS1cTVYzCYwI/DbIi69bkCr0sOWdkopmSyd1bbT652
         PPhgwKKjgdD4yNGMN5SiOqyuU2QdkWP6QujMlpKH1GF2q6e7ac/mSkRbaE4aQBxwETZQ
         20EC75Mp0H8+h/xBnkf3q3P5rGeJyIXJ7KIX9hP1y5C0oSCGFFnGmkQZ7QFowDlCsEGp
         So8Q==
X-Gm-Message-State: APjAAAUSo6huS83VrAFY6j2cZ8bfr68VAg+IQ1g3aePH2MYqP5dBxhL5
        jQt1v+LEhhMhHAF5kWYnHCEHQEpWlrU=
X-Google-Smtp-Source: AHgI3IaGx8KaHLW4LOwHVIr4F1sF4dhE8f7bpFnXyGdkOstaxR6vzIINje9cOzlZkgkUHRrbt9D+gQ==
X-Received: by 2002:a7b:c766:: with SMTP id x6mr9804463wmk.15.1551673682196;
        Sun, 03 Mar 2019 20:28:02 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d24sm16078541wrb.47.2019.03.03.20.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 20:28:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] builtin/config.c: don't print a newline with --color
References: <b5ca6391fd0273fb7d6b92bc5ada96df93bc5cf2.1551487219.git.me@ttaylorr.com>
        <xmqqtvgk69ik.fsf@gitster-ct.c.googlers.com>
        <20190303174214.GF23811@sigill.intra.peff.net>
Date:   Mon, 04 Mar 2019 13:28:01 +0900
In-Reply-To: <20190303174214.GF23811@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 3 Mar 2019 12:42:15 -0500")
Message-ID: <xmqqlg1vw9f2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm not sure I agree. Colors have always been special, and
> "--type=color" was advertised as a replacement for "--get-color". And
> "--get-color" never output the newline.

OK, that part of the motivation I completely missed.  If end-users
and scripters are happy with the behaviour of --get-color that does
not terminate its output with LF (which I think is a reasonable
thing to do, as "color" is special in that context, i.e. having a
dedicated --get option suitable for that type), as we advertise
"--type=color" is the same as "--get-color" (only better), we need
to special case it, and omitting LF at the end similarly does make
sense.

> With respect to backwards compatibility, my thinking on the matter was
> basically:
>
>   1. Since --type=color was supposed to be a drop-in replacement for
>      --get-color, it's a bug that they don't behave the same.
>
>   2. It's a fairly recent feature, so nobody really noticed the bug
>      until recently (and it was in fact me who noticed and got annoyed
>      by it). If it were an ancient behavior, we might think about
>      retaining even bug compatibility, but that's not the case here.

Now I think "we weren't consistent to begin with with --get-color,
and treating --type=color as a special case is justifiable"; and I
agree with the above two points.

Thanks.
