Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37F8320248
	for <e@80x24.org>; Wed, 10 Apr 2019 19:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfDJTAw (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 15:00:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41273 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbfDJTAw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 15:00:52 -0400
Received: by mail-ed1-f65.google.com with SMTP id u2so2994059eds.8
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 12:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=fKPa919f+5LJtIG4iMfO9WxqDh2q5tQ4WR1ZSjBh5qk=;
        b=eCPttNkqFKXgI/QVx8z8N2eAk6lUAbWSHfCwOzHlGWI/Vj+V6W29xqbxaM59g8/fxS
         TJJnz+A7zd+2e4ata7cFx5vJEHqZyDwJrj9de0HhAOK9fS9nKONQZYJFRFucjUZZ+3JI
         KIFH8jkEjgv2fwenPPb/h4WFyAyDdxyq/VSXIYn8QCrUf8H6pBujs11ErhJ5X8nBnXXU
         3puMqhggNdCNqWYpUuIZOQXq0MPF1gD0GpXxp5rY4nn1qvIBgb0eIp/akeEjQ3krBooO
         he6C5LQrCvovW8HXRYqm2rCgc2XnY0j2+nua8N8LRHr8qjnVvo2TOsSpDbDPinEgHhCc
         Tjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=fKPa919f+5LJtIG4iMfO9WxqDh2q5tQ4WR1ZSjBh5qk=;
        b=WdAv37CMjX1ObxT87K7LbjgFQCO3NRrVohiizIHXJNWmkn2JhQcpiaNywJt63T7pMT
         t5/dxifn9kKVWk7LK4dpbOyO3sP4DQHUBoq9tfUIiFVq4E78MAbZzts4uxQgY4YyNBgD
         NEUnlt/SreRSFukosXc1+ol8L6dWi9m6THAVqSB4/smKzOS1Wl/k6F8RXGlLZHBvUUFU
         E6n+OZ0CeYpSdHvWxzXPXwVaUm8XaXzWPlQprElXMURBYY5R8+PkJI57ra2++W/nmGdx
         iIkw+r94XtpjH6ios6gDIhAiue5RbUzTICv4kPXFbY3OYjmM7O9gJQ4vrA17D1DGkOHX
         TlBw==
X-Gm-Message-State: APjAAAXkfYRem8i6Dw3Ny6I0oOY7Wn5WUXXfVqnCF/vMnEj2NcupI1Sv
        Yf53/Bqs1IfCh0RZWBINaQ4=
X-Google-Smtp-Source: APXvYqz5lb0anqHe0cEFCEn5XioBJNkc3jOAcBj8Hu2SuMaljlv0p4HoaRljxSyoPP3HE8OIGibthg==
X-Received: by 2002:a17:906:3612:: with SMTP id q18mr24960117ejb.147.1554922850588;
        Wed, 10 Apr 2019 12:00:50 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id s14sm62055eda.26.2019.04.10.12.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 12:00:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Barret Rhoden <brho@google.com>
Cc:     git@vger.kernel.org, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Michael Platings <michael@platin.gs>
Subject: Re: [PATCH v6 3/6] blame: add the ability to ignore commits and their changes
References: <20190410162409.117264-1-brho@google.com> <20190410162409.117264-4-brho@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190410162409.117264-4-brho@google.com>
Date:   Wed, 10 Apr 2019 21:00:48 +0200
Message-ID: <878swhfzxb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 10 2019, Barret Rhoden wrote:

(Just skimming)

> revisions for commits that perform mass reformatting, and their users
> have the optional to ignore all of the commits in that file.

s/have the optional/have the option/

> +--ignore-revs-file <file>::
> +	Ignore revisions listed in `file`, one unabbreviated object name per line.
> +	Whitespace and comments beginning with `#` are ignored.

Maybe just say "Ignore revisions listed in `file`, which is expected to
be in the same format as an `fsck.skipList`.".

> +	the `blame.ignoreRevsFile` config option.  An empty file name, `""`, will
> +	clear the list of revs from previously processed files.

Maybe I haven't read this carefully enough but the use-case for this
doesn't seem to be explained, you need this for the option, but the
config file too? If I want to override fsck.skipList I do
`fsck.skipList=/dev/zero`. Isn't that enough for this use-case without
introducing config state-machine magic?

> +	split[0].unblamable = e->unblamable;
> +	split[1].unblamable = e->unblamable;
> +	split[2].unblamable = e->unblamable;

I wonder what the comfort level for people in general is before turning
this sort of thing into a for-loop, 4? :)

> +	nr_lines = e->num_lines;	// e changes in the loop

A C++-like trailing comment.

> +	grep "^[0-9a-f]\+ [0-9]\+ 1" blame_raw | sed -e "s/ .*//" >actual &&
> +	git rev-parse X >expect &&
> +	test_cmp expect actual &&
> +
> +	grep "^[0-9a-f]\+ [0-9]\+ 2" blame_raw | sed -e "s/ .*//" >actual &&
> +	git rev-parse X >expect &&
> +	test_cmp expect actual

The grep here is a bug. See my 4abf20f004 ("tests: fix unportable "\?"
and "\+" regex syntax", 2019-02-21).
