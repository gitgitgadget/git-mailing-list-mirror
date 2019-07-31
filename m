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
	by dcvr.yhbt.net (Postfix) with ESMTP id F38DB1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 14:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388177AbfGaO56 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 10:57:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40586 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387639AbfGaO55 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 10:57:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so65964842eds.7
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 07:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=T2kUUaP7Ml4d7oe/WDbjelN4Lmeq+8b3gLVJFLaPb+Q=;
        b=XVP8mMpl3vtLRDtiHcq0Pz38OkqbAXrjADyEcj4JlLejR6Jnbr7X9MYzIyzmfaNmQY
         c/nHKIMtxpcixn37KbCwtuC/n4CFGQ016LXI/gg/OB2+d90m+O8E/U2e+C60CssVldsP
         QsvGWjyFzYGr+aaeHAXxI4dWRQ+IlRLdHZZZ/sCgBKBM44QrCPwRbQY5EPGcCdxl54k7
         kSVSPL1WQUZDFFHZQuDtoN/R5swr2heVAebMnjBz6QHdzrEZEeUIYw7aHRVNVJfLO6zi
         QKZ6cqg8AN16pe78T1rFm0q01yvH/4X/cmoDZA4f6dLSJLVuNkWpPh5VI9cKBSC7YOhC
         Oz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=T2kUUaP7Ml4d7oe/WDbjelN4Lmeq+8b3gLVJFLaPb+Q=;
        b=EsPm61rXjDa6gocS3uE1u4UPy0PvUJnFLb0+7B8eFvquBxcuX7xQNyBwrho5qEbDdN
         RguDBz9jYi15PdgO15kG+BvSDEEYKQyfmWANDu+tbQdFulsF6P5uiLfuBwdbe8Bz+jxu
         cB7Q2LCCKt4Gy5BdMpU+a+uUQAizxpoPG2uhD3TtStVjlcGx/WShOFT9BiqBJ2Swk7GT
         3EhQI/2I3IyVmMGYOg4y6NiiU+VuV/C/EG+jN0t+D6C87+3TLoOYXbbKRvnkoYUSGKmg
         IqB4ziCMbMs1NWp+cv4jG5YHNbcFBn9F88creiy7hJKp5LU/RLlyAkWN4SQCw6UoqyiF
         jjcQ==
X-Gm-Message-State: APjAAAVkowo7YtvW3RwQPXnhJ/xKV1krU1Uv4SpfGQsw0nuiwQDLwPTL
        J4ecuyb6NMrOrYReIA/RHVI=
X-Google-Smtp-Source: APXvYqxqbz1rs1fhlYmJZ0XuO/9J40zZ6xmzBQWKQoUXpE5aT9A+EOpppKo3gOsQNan/QnfMG/zxrQ==
X-Received: by 2002:a50:eaca:: with SMTP id u10mr106103065edp.42.1564585076042;
        Wed, 31 Jul 2019 07:57:56 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id w24sm17506077edb.90.2019.07.31.07.57.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 07:57:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        gitster@pobox.com, dev+git@drbeat.li
Subject: Re: [RFC PATCH v2] grep: allow for run time disabling of JIT in PCRE
References: <20190728235427.41425-1-carenas@gmail.com> <20190729105955.44390-1-carenas@gmail.com> <nycvar.QRO.7.76.6.1907311426290.21907@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1907311426290.21907@tvgsbejvaqbjf.bet>
Date:   Wed, 31 Jul 2019 16:57:54 +0200
Message-ID: <87o91a5k0d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 31 2019, Johannes Schindelin wrote:

> Hi,
>
> On Mon, 29 Jul 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>
>>   $ git grep 'foo bar'
>>   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
>
> My immediate reaction to this error message was: That's not helpful.
> What is `-48` supposed to mean? Why do we even think it sensible to
> throw such an error message at the end user? Can't we do a much better
> job translating that into something that makes actual sense without
> knowing implementation details?
>
> But then, I realized that -48 must be a well-known constant in PCRE2,
> and my reaction transformed into something much more hopeful: why don't
> we detect the situation where the JIT'ed code was not actually
> executable [*1*], and fall back to the non-JIT'ed code path ourselves,
> without troubling the end user (maybe warning, but maybe better not lest
> we annoy the user with something pointless)?
>
> Even after finding out that -48 disappointingly means
> PCRE2_ERROR_NOMEMORY (as opposed to something like
> PCRE2_ERROR_CANNOT_EXECUTE_JIT_CODE), I like the idea of not bothering
> end users and doing the sensible fallback under the hood.
>
> Ciao,
> Dscho
>
> Footnote *1*: Why anybody would think it sensible to build a PCRE2 with
> JIT on an OS that does not allow executing code that was written by the
> same process is beyond me. Or is there a mode in OpenBSD that *does*
> allow JIT'ed code to be executed?

We do detect if JIT isn't supported and fall back. That's what the
pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on) code in grep.c
does. This and is the subsequent pcre2_pattern_info() call is how PCRE
documents that you should do this.

What hasn't been supported is all of that saying "yes, I support JIT"
and the feature then fail whaling. I had not encountered that before.

So far that seems like because Carlo just built a completely broken PCRE
v2 package, so I don't know if that's worth supporting on our
side. I.e. this isn't something I think could plausibly happen in the
wild.

That should *not* be confused with me thinking other stuff Carlo's
raised is a non-issue, e.g. running into the JIT stack limit etc. Some
of that's clearly bugs in our/my grep.c code that need fixing.
