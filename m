Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26B401F404
	for <e@80x24.org>; Mon, 12 Feb 2018 22:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932590AbeBLWR5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 17:17:57 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38625 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932504AbeBLWR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 17:17:56 -0500
Received: by mail-wr0-f195.google.com with SMTP id t94so16736805wrc.5
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 14:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CpR4gmaJq/OGNuiFJG818mM3OALtznNkOY+TCgoVYhw=;
        b=ALGxNN32cyJQ/l3j/d+cDz4Si8darqViDsUcAsJjyjTZ+1wh9InXj8EctvcXDFoi3V
         KZ3CJVkcAuXnNPPqq7CIaCcz45V6fqL5ibP84KFp6fI/qYU4tT3Vuslv5fyvWo1u6Mgw
         0xc0dfHqUnYE33krHWhrTS0sW+eW4iYQQTMNjZh1WWIyKJvnBYglWG28goC0HksASbG/
         fk4Ihuh7K/GcLTDzlrJf+HhCkH4p5sR+QPIpY5ntZfsWizzszQbk17smTJZOzmqM9xdZ
         t/50dbOgT7C1V/UausyIIAyJ/tyeDVXNijm5EdQY2ttxznLzo5N478SYjDxOR69cJxUV
         oXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=CpR4gmaJq/OGNuiFJG818mM3OALtznNkOY+TCgoVYhw=;
        b=iP9IqYsSZSpO23/ew8fNBGI8ryPKPhJN1bR9zPb5PpyIUjyPyuivYw/0LrCk4jjLZl
         ZM2AaNxhwogmC5dCQo3O7j5kMy7YOvmwN8WID1y57YhRgbSJbtLvyjSfDZ+hkS556vly
         ycUZbUWUzhKkhkdMKINJKtyPxGfVSDHUA/g6JLruWYCJbInAf+a+G2dRtOsCc/j5eGia
         gR180g52Tq03RNnUxKeQUTIS1anKB/JBYaU9nSpJMDk1JYU4F8KsBG9xh153cw8T/GA8
         JqUjlUlT622JR4cycyb2U55LF+lvy7AXLFm/ftSFlOXwqSXKF4dqp0JzpJSbYTnM9F+p
         ZDmQ==
X-Gm-Message-State: APf1xPD77L9m1vq/rzvqQRbBQABKKPWIPvpT0jT3AE69i/XrxY7+/eBc
        sAgtWabuC8lwNr1uZTh15o0=
X-Google-Smtp-Source: AH8x225AFcrhUlqjxjD5mscAeU94r9UKmsttSvTImRaxABqRbrDhL3QjYss/DDhqyRMTB668gDn3sQ==
X-Received: by 10.223.201.3 with SMTP id m3mr9957802wrh.117.1518473874269;
        Mon, 12 Feb 2018 14:17:54 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m86sm7123179wmi.40.2018.02.12.14.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 14:17:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] t7006: add tests for how git config paginates
References: <450ff45707b58d6796d55cd594b50686e5d62fc2.1518365675.git.martin.agren@gmail.com>
Date:   Mon, 12 Feb 2018 14:17:52 -0800
In-Reply-To: <450ff45707b58d6796d55cd594b50686e5d62fc2.1518365675.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Sun, 11 Feb 2018 17:40:23
 +0100")
Message-ID: <xmqq4lmlsvhr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> +test_expect_success TTY 'git config respects pager.config when setting' '
> +	rm -f paginated.out &&
> +	test_terminal git -c pager.config config foo.bar bar &&
> +	test -e paginated.out
> +'

I am debating myself if this test should instead spell out what we
eventually want from the above test and make it expect_failure, just
like the next one.

In addition to setting (which will start ignoring pager in later
steps), unsetting, replacing of a variable and renaming/removing a
section in a configuration should not page, I would suspect.  Should
we test them all?

> +test_expect_failure TTY 'git config --edit ignores pager.config' '
> +	rm -f paginated.out editor.used &&
> +	write_script editor <<-\EOF &&
> +		touch editor.used
> +	EOF
> +	EDITOR=./editor test_terminal git -c pager.config config --edit &&
> +	! test -e paginated.out &&
> +	test -e editor.used
> +'
> +
> +test_expect_success TTY 'git config --get defaults to not paging' '
> +	rm -f paginated.out &&
> +	test_terminal git config --get foo.bar &&
> +	! test -e paginated.out
> +'
> +
> +test_expect_success TTY 'git config --get respects pager.config' '
> +	rm -f paginated.out &&
> +	test_terminal git -c pager.config config --get foo.bar &&
> +	test -e paginated.out
> +'
> +
> +test_expect_success TTY 'git config --list defaults to not paging' '
> +	rm -f paginated.out &&
> +	test_terminal git config --list &&
> +	! test -e paginated.out
> +'
> +
> +
>  # A colored commit log will begin with an appropriate ANSI escape
>  # for the first color; the text "commit" comes later.
>  colorful() {
