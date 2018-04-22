Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E95651F424
	for <e@80x24.org>; Sun, 22 Apr 2018 21:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeDVVmw (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 17:42:52 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:42765 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753529AbeDVVmv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 17:42:51 -0400
Received: by mail-wr0-f179.google.com with SMTP id s18-v6so35955081wrg.9
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 14:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=v7V8GcrhAGCbRf10rqDQGjWeq5RU4AL1Dlkk3q8MW+M=;
        b=UbobS0Otg2AsFAMpcKJSddeju8hr226csvGeF2ryVR7m0EnSSfLJYDI303JIoZ2mHF
         Q4hgEMoCUWupLt4L1UTOx8c6q8CcyVlmg6EzQYmHzgc84800kS5V1qe/xwngYRIek9/w
         oPyVMD0dwlsVJRcBY6Fy3LG7DdbQ5OUDuQsUhQIRdbHxX9awjjBBkchLUKyVdxRI63uc
         2WWESFfO9Yh6ycyqaJzNnTTJ+AH0nlb0NBiT3iu4v4aAN0ZxWmjPxGCiYYzbHiM29+M4
         0KxD3YxwkYKBhNuxTGJxtQZftzDZcrhks/ubCYr6qh7aHPx1UAm/c1BdkvMxtf5M4D0t
         OTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=v7V8GcrhAGCbRf10rqDQGjWeq5RU4AL1Dlkk3q8MW+M=;
        b=H8FvDfeVJEAiQMjk0D+KwDKrhDWsXrma/iMwWkDELouazurD7ooC6sHvf5nNbptMf3
         RRxaR3GYVlIg5eBJbanwNXl7Jw3U7JlkhONe83G7d5c95vLr1IzEOvQhVlL5tS+DqJfV
         FlbGQTnYHAFQQGdLxpHN7ercrf8Pmz3QnbqRtx7du9AOIwWZnzCQutUM50F+L80U50g1
         UCiOPwiVkzw81yLOS0WNQ1CtfUJ7JZJPzfrdlUv2fa/LTSrC2XPKQcyvcWbTV2ifZ/Pc
         Ila7Wz7aU5olJZd51GnIpNJdKQtqS8vDZ2Zz9TOpIF28i+6+C4QZwleKGvI7UUxHl2aL
         vXEw==
X-Gm-Message-State: ALQs6tBt1JTKIQl5+xl0cREym17ngYqmOY762GQg6GhhgTQ2XArYFt50
        Y4jrqakIlbPmy0cMfMCGII8=
X-Google-Smtp-Source: AIpwx4+TdlemuL2p8oVth0sveIpkDl8SEhdU78M91m9P94aqrjMojMYvxUIvp6Jcv+sKfJd/Yi8pAA==
X-Received: by 10.167.208.210 with SMTP id u18mr10124441edo.97.1524433370567;
        Sun, 22 Apr 2018 14:42:50 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id h13sm6565365edi.91.2018.04.22.14.42.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Apr 2018 14:42:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net
Subject: Re: [PATCH v2 3/6] grep.[ch]: teach columnnum, color_columnno to grep_opt
References: <20180421034530.GB24606@syl.local> <cover.1524429778.git.me@ttaylorr.com> <47f06ae36ce6af48fca06b140bdb5af2582116e1.1524429778.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <47f06ae36ce6af48fca06b140bdb5af2582116e1.1524429778.git.me@ttaylorr.com>
Date:   Sun, 22 Apr 2018 23:42:48 +0200
Message-ID: <87a7tuex47.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 22 2018, Taylor Blau wrote:

I think [345]/6 would make much more sense as just one patch. Comments
on them to follow...

> In preparation of adding --column-number to 'git-grep(1)', we extend
> grep_opt to take in the requisite new members.

Just a nit: Makes sense to refer to these camel-cased in docs & commit
messages.

> diff --git a/grep.c b/grep.c
> [...]

All of the boilerplate looks fine.
