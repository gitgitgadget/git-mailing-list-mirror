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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CE2F20248
	for <e@80x24.org>; Mon, 25 Mar 2019 22:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfCYWrs (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 18:47:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38285 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbfCYWrs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 18:47:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so4691198wro.5
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 15:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0oKEJfiEJcdRsP0l2p3HV6yFMDS5p6sXwOnaUqv3cac=;
        b=R9IMXKKqOSymcWtI9h6WFNnoFtREgeML/UR5/TiDRNT6fsOzHoGJAeGP0Sg5Fzn9u8
         XOxsxgFRwdNWhJj1B2z0LG2bhBOcYiBJtMd1f6Hjsx0WnnguHInhaCbjbQzlC82oDW4A
         5CjtJnOLHSQIIOHwfq7H2en+bVOs6bDiw8vzXT+XtLq/mVAZn98OFg1X8nLXGrvNgdah
         YBvyKZpVzIpvzuBTXH6CQ4sjalejJUeShfWmCLyd6cfqXDTdDBrR7Q3E99b8iPsb7cZQ
         KyupPPFQhJBzO7EqQy2QPEet3tsku/MM8Z/A9C3bfjeJWPj2ay6Ky6SauiLixUc/ewhe
         lUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=0oKEJfiEJcdRsP0l2p3HV6yFMDS5p6sXwOnaUqv3cac=;
        b=gERB6r/NKA0o2CmwZVodH6HeH+V//emdN6hQrBisxPNmMbcqPMi3FvyUj8ck0uluTo
         V2OKonJHnuRXtRqntadVL6nsRNjte8FjXXw3iFpQM4wbBh/BEqK73NzrbYADDV2w6xx6
         SU6LKOLC6L0RYGkdXaIntroQxr4niJJfpOzvy+koOM/7LGNjAYqAcAdgnPE2k+Tnwdfn
         Xmp89C42Sp5WDUf+Itr2rxckITG2uA3UkPGiC3GG0pKfFFoyMrSEFw2r7mMsD/Mk9Vet
         a6Lj/fF1pxR/X4PzmG571opmouuU0bFtl+/Sl9qJ1vkiUpHJPmJWaNuLi6/Qvpjw6YH3
         +ZVQ==
X-Gm-Message-State: APjAAAUyMxblIq8mSzb7vpcBDzbtOUjLduDZr+onHUy00oy1ItZTcqc1
        VkUq4VRQcD9RKaZLb55yhnE5+cz2CK8=
X-Google-Smtp-Source: APXvYqxhz+x/Rlxe8XQtqUqGJdRrShkD2OEGzwOzh4YSU8lKqbzcA8s2a0o/RRG0Dv7ut0GwXbbeQw==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr18115516wrp.72.1553554066409;
        Mon, 25 Mar 2019 15:47:46 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id j184sm26017692wma.47.2019.03.25.15.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 15:47:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 1/2] parse-options: allow for configuring option abbreviation
References: <pull.167.git.gitgitgadget@gmail.com> <20190325202329.26033-2-avarab@gmail.com> <CAPig+cR0Ldt3EpQ683ZFNFXggfsTrdeZ3R-V6pDBZNA1N3c+xg@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAPig+cR0Ldt3EpQ683ZFNFXggfsTrdeZ3R-V6pDBZNA1N3c+xg@mail.gmail.com>
Date:   Mon, 25 Mar 2019 23:47:44 +0100
Message-ID: <87o95ybmgf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 25 2019, Eric Sunshine wrote:

> On Mon, Mar 25, 2019 at 4:23 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> diff --git a/Documentation/config/core.txt b/Documentation/config/core.t=
xt
>> @@ -1,3 +1,15 @@
>> +core.abbreviatedOptions::
>> +       Defaults to `true` which allows options to be abbreviated as
>> +       long as they aren't ambiguous, e.g. for linkgit:git-init[1]
>> +       the `--bare` option can be abbreviated as `--bar`, `--ba` or
>> +       even `--b` since no other option starts with those
>> +       prefixes. However, if such an option were added in the future
>> +       any use of these abbreviations would break.
>> ++
>> +By setting this to false (e.g. in scripts) you can defend against such
>> +future breakages by enforcing that options must always be fully
>> +provided.
>
> I don't get why having a configuration option is better for defending
> scripts against this problem than a simple environment variable. It
> seems easier for the script prologue to contain:
>
>     GIT_TEST_ABBREVIATED_OPTIONS=3Dfalse
>     export GIT_TEST_ABBREVIATED_OPTIONS
>
> than for it to muck about with git-config or use "git -c
> core.abbreviatedOptions=3Dfalse ..." everywhere. The commit message
> doesn't do a good enough job of justifying the configuration option
> over the environment variable.
>
> Also, if this is now intended to be more general (aiding script
> writers) than just being for our test suite, then dropping "TEST" from
> the name seems warranted:
>
>     GIT_ABBREVIATED_OPTIONS

If we want to make something user-configurable we tend to add config
variables. The GIT_TEST_* variables are only intended for our own test
suite, see t/README.

I don't mind documenting this, but it's a well-established pattern, so
if we're going to describe how this works/why use one or the other it
should probably be some other series to t/README and/or git-config.txt

We traditionally *only* expose this sort of thing to users via config,
and not via env variables.

The config system is more flexible in every way. You can set it
system-wide, user-wide, repo-wide etc., and if you want exactly the
scope of an env variable you can do that too, just start your script
with:

    # These "''" quotes are not a mistake, it needs to be like this
    export GIT_CONFIG_PARAMETERS=3D"'core.abbreviatedOptions=3Dfalse'"
    git <some-cmd> [...]

So the reason we have GIT_TEST_* is pretty much because we can't just
whitelist GIT_CONFIG_PARAMETERS for the test suite, and to make it
obvious what test modes we have available.
