Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58CB21F462
	for <e@80x24.org>; Mon, 29 Jul 2019 08:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfG2Izb (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 04:55:31 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36915 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfG2Izb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 04:55:31 -0400
Received: by mail-ed1-f68.google.com with SMTP id w13so58638489eds.4
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 01:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=LxcoU82fU2E4a3wjGU72RkO0S2C8GoFyqEPslZnsgAc=;
        b=YG+jSyywlbVL1YI3nI1KpDjb3ODXKBUuyZ0AF1Fef2J5elp+08dk1YnVHM6rACPd3J
         rX48Vgf9sMYmKbQtlTCGryA9/9ViM+czs6sRg0nCgKZD1fFs3Z1arlu4r0DjRIoGmUWA
         kWW8zAlYK8rxvfWQ3FYvO93Co5oDpr6pDIGCBc8+5IfE5ihxLfSwKAO6vCQFXAEi+jns
         0hT5xDl0taqKCZTnoGijpxe1takwN1Zh2IY2jbBaITsZHVaOF/nziUGW+WAZ96/DGqg/
         Zz1lcUeZjD3rmfMnxkNt5ekB2kVu62KzhEHSLBY2CR8rwFT3XNpIl5CJ+HdpulHGlBmt
         0Idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=LxcoU82fU2E4a3wjGU72RkO0S2C8GoFyqEPslZnsgAc=;
        b=iJrMrEAnw1gzDNJoKVdiBljMJikx8YKNgKSkoRogRPBAIa6dw8JITpzfMPLoC/uskD
         u+uTLc1YII71KvGCm2knU6efSgoDiYe+MJKGbRlyppHURyonCkSfw8ugPDXVCtBsvxCy
         2i2V3ZEOBKI9I50XqDzffcntS5/3f4KJSR2zk2+NBJYPT/I7JXh+80Nzf36XRBQIr6IH
         BWbzudtMKuxI3mL60XmFgG/ZkcI4wljvchaCrMKRH9bhjTomn7qdvXSSlwwwaxCMCEnE
         vGx9yfBaXZrow9xk57CVPXjOdLjKS35dfMdml/P3NTKOju9qrPQ4tONmu8nBC8O7T8O/
         ki2w==
X-Gm-Message-State: APjAAAXYo51Bo4kuY/8nGZbJHTvRQH/VP8AciAJ0dSc1Q19FH3u4Fntw
        s/A2n/+tAuMllOg3e1WOQN8=
X-Google-Smtp-Source: APXvYqxLzirsqLebOjbBHneL4Ubv8blIyDCZhI9eIy50pa41qUpcgPh/D7hBjo8I1h+JYPY+RRzPpA==
X-Received: by 2002:a17:907:384:: with SMTP id ss4mr83864605ejb.166.1564390529158;
        Mon, 29 Jul 2019 01:55:29 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id si13sm11344951ejb.82.2019.07.29.01.55.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 01:55:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [RFC PATCH] grep: allow for run time disabling of JIT in PCRE
References: <20190728235427.41425-1-carenas@gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190728235427.41425-1-carenas@gmail.com>
Date:   Mon, 29 Jul 2019 10:55:27 +0200
Message-ID: <8736ip6wzk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 29 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> PCRE1 allowed for a compile time flag to disable JIT, but PCRE2 never
> had one, forcing the use of JIT if -P was requested.

What's that PCRE1 compile-time flag?

> After ed0479ce3d (Merge branch 'ab/no-kwset' into next, 2019-07-15)
> the PCRE2 engine will be used more broadly and therefore adding this
> knob will give users a fallback for situations like the one observed
> in OpenBSD with a JIT enabled PCRE2, because of W^X restrictions:
>
>   $ git grep 'foo bar'
>   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
>   $ git grep -G 'foo bar'
>   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
>   $ git grep -E 'foo bar'
>   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
>   $ git grep -F 'foo bar'
>   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'

Yeah that obviously sucks more with ab/no-kwset, but that seems like a
case where -P would have been completely broken before, and therefore I
can't imagine the package ever passed "make test". Or is W^X also
exposed as some run-time option on OpenBSD?

I.e. aside from the merits of such a setting in general these examples
seem like just working around something that should be fixed at make
all/test time, or maybe I'm missing something.

To the extent that we'd want to make this sort of thing configurable, I
wonder if a continuation of my (*NO_JIT) patch isn't better, i.e. just
adding the ability to configure some string we'd inject at the start of
every pattern.

That would allow for setting any other number of options in
pcre2syntax(3) without us needing to carry config for each one,
e.g. (*LIMIT_HEAP=3Dd), (*LIMIT_DEPTH=3Dd) etc. It does present a larger
foot-gun surface though...
