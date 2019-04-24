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
	by dcvr.yhbt.net (Postfix) with ESMTP id 85E1D1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 08:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfDXIPD (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 04:15:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45402 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfDXIPC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 04:15:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so23752582wra.12
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 01:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=SgJtHLJ+ChdWd6olRwf1K85Bev/D9n6hPoytWe1J7dw=;
        b=TFm+DWE07fXqoVrBGGR5JCh/4vO5cuve1nohoLI0UMbr3HKm1I/FaWocWAqzBIESHU
         OOilPohvO5TOZipilSERA17wVD2u92+lLBMXf0R6i+6L8pT2/S3Eln3BiumhvD/dBDts
         Pi3aeVS5Abu04OpN+zMxX+hfRGebn+/ZfpB/J3mNWH3clUKXNlJ2ElieLd3UVOEsKs7N
         EjQe8r9iQGz1s6FX1Wp4sA7SSu1Wz0ULbyAD5gIdJxc+WP3yem9zY3/8kcW9eoGWIhzn
         tUCIuJWk/D8H7+4W2He0i21/LB5vgLhoJX8ry8BJI3d3Iow4r1mUKPcNHEDYJLuoOlVU
         Tsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=SgJtHLJ+ChdWd6olRwf1K85Bev/D9n6hPoytWe1J7dw=;
        b=ApmqhZ1JwpSjBIwIDpJv+HOg64newvpqM5AV32NSlR9x9eaA0F47kRq72neys/BqEv
         wJS/yiGb7dlaJcmNnck065je4Xq4ewnpN4cO++0WL0YLYuQvzTGms9Zs3rWhfTYygALz
         jXjBZZq4wbrtmi4bhEEIUOUJXmAzDYT07r2Pm3HRhnEcDnQ2kPu7mCBBHLmFdb2LrJzZ
         UvjZjS0vjPFcEz7CQEbLZ+Mat01SSvxWXQNV4zxJX8QBFTz83AnHxrKQ4MbgAY5AdeAc
         VE8TzbcDXse1KXMHnk6kXPIpjKZsb2YZkyUEHwAGn6jqgCl6t+YMo1yiU+ZsYdPJGrZm
         ykAQ==
X-Gm-Message-State: APjAAAWnNPQEqpWHJHFC1lDb8L4wLIcYBXbZd3Cx6A6zEPSa5eR0oEMf
        r5gyNaFoR7+upLRpIzqKAoo=
X-Google-Smtp-Source: APXvYqwZndPecJ/Ej21nphjAi6oxXyd85nWTUsaPqBEfWbO3Ynd034UG9jkgw9Ls9FiRD4m439KIpw==
X-Received: by 2002:adf:9d90:: with SMTP id p16mr11827911wre.186.1556093700668;
        Wed, 24 Apr 2019 01:15:00 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id z11sm17085387wmf.12.2019.04.24.01.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 01:14:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Multiple hook support
References: <20190424004948.728326-1-sandals@crustytoothpaste.net> <xmqqtveo2lyx.fsf@gitster-ct.c.googlers.com> <20190424022240.GH6316@genre.crustytoothpaste.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190424022240.GH6316@genre.crustytoothpaste.net>
Date:   Wed, 24 Apr 2019 10:14:58 +0200
Message-ID: <87sgu7sttp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 24 2019, brian m. carlson wrote:

> On Wed, Apr 24, 2019 at 11:09:10AM +0900, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>
>> > To preserve backwards compatibility, we don't run the hooks in the ".d"
>> > directory if the single file is a valid hook (i.e. it exists and is
>> > executable). This is because some people already have multiple hook
>> > scripts configured, and if we ran them both, we'd run the hooks twice.
>> > This would be bad for e.g. the prepare-commit-msg hook. This is also the
>> > least surprising behavior.
>>
>> OK.  An obvious alternative may be to see if the expected hooks path
>> is a directory and use the contents.  If ".git/hooks/pre-commit" is
>> a single file, we know it is the single hook as before, and if it is
>> a directory, we know that is not a custom made (i.e. from the world
>> before this series supported in the core-git) multi-hook setup.
>
> That's an idea I hadn't considered. I'm interested to hear other folks'
> ideas on it, but that certainly avoids a lot of the problems in my
> approach.

Two things on that:

 1. As noted upthread we have some in-the-wild users who use the *.d
    semantics already. Would be nice to be able to migrate them, also
    *.d is a commonly-used pattern in other software.

 2. It's more of a pain in some configuration management systems like
    e.g. puppet to change a managed file to a directory than removing an
    existing file and adding a directory.
