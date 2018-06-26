Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D16001F516
	for <e@80x24.org>; Tue, 26 Jun 2018 19:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbeFZTFE (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 15:05:04 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:55914 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbeFZTFD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 15:05:03 -0400
Received: by mail-wm0-f54.google.com with SMTP id v16-v6so3137649wmv.5
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 12:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DqTDd6+9j6AYvI9rFgQUsS+whLUIYRH1LnebVj2qKgM=;
        b=nBvQOgEENYdDDG9984TXT28EKHH9glsLcTzWE+mVppF8XsNdngLpPGplJ9V36eXs4N
         XlE0KtiTIiKETx9W2DlYYMjqVq6+gTFOpexQvVQPlXT+jsLrFmoxoYJsTIETawTU8fhA
         pQhKPS0HzBWJ7kkVpNmvCmZhB4c2PVB7Cw0FvSqGBmXffsjoCq0ZOnhxUnnA6Cq0qPG+
         vdbuMO7ectuA1BFR4xSavHPSwgaQv/hxi+D5NwqPFc9QoSSuErXkpCsQiOS2i3IjvS/e
         iONwERnpedWm+k3v19P8/VPhpaV4e+YGI7WW5v949qKryYBHKWjWqlXfjQXYiMkb79HV
         99DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DqTDd6+9j6AYvI9rFgQUsS+whLUIYRH1LnebVj2qKgM=;
        b=TsrMqCiUPr0vLP8gr0ALdBj85EU3idzaVvAZzGgomJDllNU3X+ec7l7Aj9Dn9JUAqh
         oUQX1uxfm9hphxZLCFQ+FY9XNcHJeCXb9218xEK6cC3p45JC3cV/oxS5Op+lYb88EkNc
         wEA8ezhblYYjFBGkmRHn8xas1jpcpRBN5+uWlUOujceLscA7yTZT73Xo6FBM2xk0gMMs
         nldKxJqpmm7XCHINgUB9mq3w0pJcgTsmlaiqoTpTJCfTzSUTjz9wuxH1wR/bMMNISrZU
         w9G4Pp12A+h9dzbs3ILLzPyi6GrBt13PNVuO+8N4UTmMWW81KSQEIFKXS47DdmYGVmwY
         VjcQ==
X-Gm-Message-State: APt69E36yaTReeqtLfxaaJvlgBQgoPksVYCVtiZQhtwUyfdijcogHcKe
        jrUBEIFCXLLid9EhSKz9MOk=
X-Google-Smtp-Source: AAOMgpcy3pjOiEUSjfU1aUtP5Taz2U8+AdYrE02qhz01UNZdAbJvV6Padpf15WURJvieOxrWkhIvNg==
X-Received: by 2002:a1c:ac89:: with SMTP id v131-v6mr2416807wme.121.1530039902528;
        Tue, 26 Jun 2018 12:05:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n18-v6sm5287116wrj.58.2018.06.26.12.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 12:05:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Dechesne <nicolas.dechesne@linaro.org>
Cc:     git@vger.kernel.org
Subject: Re: git rerere and diff3
References: <CAP71WjzHffLRCDbjvF7qpexjXDMFcJkaPpEn=AtbSMCJd6QkBQ@mail.gmail.com>
Date:   Tue, 26 Jun 2018 12:05:01 -0700
In-Reply-To: <CAP71WjzHffLRCDbjvF7qpexjXDMFcJkaPpEn=AtbSMCJd6QkBQ@mail.gmail.com>
        (Nicolas Dechesne's message of "Tue, 26 Jun 2018 15:25:28 +0200")
Message-ID: <xmqq1sctl676.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Dechesne <nicolas.dechesne@linaro.org> writes:

> i have noticed that merge.conflictstyle has an impact on the rerere
> resolution. looking briefly at the source code, it seems that git
> tries to discard the common ancestor diff3 bits, but what I am seeing
> is that if i do the following then it fails:
>
> 1. from a clean rr-cache state, with merge.conflictsytle=diff3, git
> merge <branch with conflict>, resolve the conflicts, then commit
> 2. undo the previous merge, remove merge.conflictstyle=diff3 (disable
> diff3) and merge the *same* branch, then rerere won't fix the
> conflicts

It is possible that the conflict left when making the same merge are
actually different when using these two conflict styles.  IOW, if
the merge produces

	<<<
	side A
	|||
	common
	===
	side B
	>>>

when diff3 style is chosen, but if the same merge results in

	<<<
	side A'
	===
	side B'
	>>>

where side A' is not identical to side A (or B' and B are not
identical), then we will fail to find the previously recorded
resolution.

