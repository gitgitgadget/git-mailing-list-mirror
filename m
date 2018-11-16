Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3117B1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 19:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbeKQFfz (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 00:35:55 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45797 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725729AbeKQFfz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 00:35:55 -0500
Received: by mail-ed1-f67.google.com with SMTP id d39so17260463edb.12
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 11:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=TOSevxcEscOUjF7f+R/afwasM+irTMK1xPfIf0A1Ro4=;
        b=TJFSWuojRIZ7PuFTfEdhFSokXvoCdOsxs7bRLwhRGsiVFSVzSWmiu7qTfdHg5Dk4NG
         ZPqwvVKm2t7bYsXujA4j+iTxQM6uF4PUNuqC3aCamc3amwoE3eiiyOxwZuD+wjM8Yb/l
         7O0dtxsacCTLkCr3gwn7bf9/6K8lcBTKCDn59ovDDQVlcak6Uy7c3BFC5f5CfBDAVsdk
         1wXKf3u8qbGxEq4R5Pz5PvUWHyhMboq4E5BLnCTAGelmAnh2zGejZlUZAzf44o8NM1Wk
         J0Fb6yPAXwXt4SfpatPH3/131ZMNFWzhg9z0zPkKWep0v4xBv8GK/csQYFg2GOs/4nal
         NmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=TOSevxcEscOUjF7f+R/afwasM+irTMK1xPfIf0A1Ro4=;
        b=FAYXA9hWbt/a52j984yUFt1lQ1r/fTK0LFEbd+zXLC3EktgrFzVz7vG9S9ViMZ2N0I
         DyfJ4PQ7nV3esvgz9kzfjj/vv+pUlJsGofc6Hob3wKtCl5umq0S/y1+5NeLSzDWdfPbR
         O2biMFsGT4PG7zd0WVQeMBB1DzUyarivZWUxakpK6PzCBgWtyiaDPp4JQ8oNFKLOD4zA
         zIqQYIb6BRAsgpBxViNggyQZVMblM1/H/iYD2Kd6+DVswvL+ZgKwsoFxrbr1+XZBsok5
         idtBLO5EU/SnZZTxMRsQc0bPClIGtjUnMIbQznuC0qHXwEcmJj7stDNOKKcxUFqKs2cg
         APTg==
X-Gm-Message-State: AGRZ1gKUA8fKe3OtK5L8y1oV2OUrlBdJi8IcFyMMbKurYza9pXHL2mN5
        MxT4ZZHBodXm/9Y01dwQW0c=
X-Google-Smtp-Source: AJdET5eavCbJKfzkiURD197p0enuY5nz4n/ty/AZNQKXkw5+XYVOKAyGKze2EobzgqQ60aNC0HEikw==
X-Received: by 2002:a17:906:49c2:: with SMTP id w2-v6mr9671651ejv.117.1542396134031;
        Fri, 16 Nov 2018 11:22:14 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id 49sm4186666edz.59.2018.11.16.11.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 11:22:12 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     mhagger@alum.mit.edu
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, dnj@google.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        prohaska@zib.de, john@keeping.me.uk, stanhu@gmail.com,
        richardc@unixbeard.net, Jeff King <peff@peff.net>,
        Joey Hess <id@joeyh.name>
Subject: Re: [RFC/PATCH 0/5] stop installing old libexec aliases like "git-init"
References: <87efkkdwcv.fsf@evledraar.gmail.com> <20181102223743.4331-1-avarab@gmail.com> <87k1ld1f51.fsf@evledraar.gmail.com> <CAMy9T_EVh5Xa7wZFRSM+uGAKV7WSPRALRRaZhPaj_bg9v7Ohfg@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAMy9T_EVh5Xa7wZFRSM+uGAKV7WSPRALRRaZhPaj_bg9v7Ohfg@mail.gmail.com>
Date:   Fri, 16 Nov 2018 20:22:11 +0100
Message-ID: <87in0w25gc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 16 2018, Michael Haggerty wrote:

> On Fri, Nov 16, 2018 at 11:38 AM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> [...]
>> A follow-up on this: We should really fix this for other
>> reasons. I.e. compile in some "this is stuff we ourselves think is in
>> git".
>>
>> There's other manifestations of this, e.g.:
>>
>>     git-sizer --help # => shows you help
>>     git sizer --help # => says it doesn't have a manpage
>>
>> Because we aren't aware that git-sizer is some external tool, and that
>> we should route --help to it.
>
> That would be nice. This has been an annoying for several tools named
> `git-foo` that I have worked on (e.g., git-sizer, git-imerge,
> git-when-merged, plus many internal tools).
>
>> Non-withstanding the arguable bug that things like git-sizer shouldn't
>> be allowing themselves to be invoked by "git" like that without
>> guaranteeing that it can consume all the options 'git' expects. When I
>> had to deal with a similar problem in an external git-* command I was
>> maintaining I simply made it an error to invoke it as "git mything"
>> instead of "git-mything".
>
> Hmmm, I always thought that it was intended and supported that an
> external tool can name itself `git-foo` so that it can be invoked as
> `git foo`.
>
> Which git options do you think that such a tool should be expected to
> support? Many useful ones, like `-C <path>`, `--git-dir=<path>`,
> `--work-tree=<path>`, `-c <name>=<value>`, and `--no-replace-objects`,
> work pretty much for free if the external tool uses `git` to interact
> with the repository. I use such options regularly with external tools.
> IMO it would be a regression for these tools to refuse to run when
> invoked as, say, `git -C path/to/repo foo`.

I don't mean we should forbid it, just that if you have an external
git-foo tool meant to be invoked like "git-foo" that and not "git foo"
it might be worth to save yourself the trouble and not support the
latter. I thought git-sizer was one such tool, since it docs just
mention "git-sizer".

But yeah, "-c" etc. are useful, and we definitely want to support this
in the general case. E.g. for "git-annex" and others that are meant to
be used like that.

So maybe we should just document this interface better. It seems one
implicit dependency is that we expect a manpage for the tool to exist
for --help.

Or, keep some list of internal git tools and treat them specially. But I
see now that would break "git annex --help" in the other direction, but
maybe that would be better. I don't know.

As I recall I stopped supporting "git" invocation for the tool I was
fixing a long time ago because of some funny interaction with terminals
& signals. I.e. git itself would eat some of them, but the tool wanted
to handle it instead.

But I don't remember the details, and can't reproduce it now with:

    $ cat ~/bin/git-sigint 
    #!/usr/bin/env perl
    $SIG{INT} = sub { warn localtime . " " . $$ };
    sleep 1 while 1;
    $ git sigint # or git-sigint
    [... behaves the same either way ...]

So maybe it was something else, or I'm misremembering...
