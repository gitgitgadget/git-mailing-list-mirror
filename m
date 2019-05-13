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
	by dcvr.yhbt.net (Postfix) with ESMTP id 83C861F461
	for <e@80x24.org>; Mon, 13 May 2019 22:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfEMW0p (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 18:26:45 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35793 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfEMW0p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 18:26:45 -0400
Received: by mail-ed1-f68.google.com with SMTP id p26so19802099edr.2
        for <git@vger.kernel.org>; Mon, 13 May 2019 15:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=sxIDFaPdI9UnmOo2IYAOhTIginE4kEg2RRMxCsA9bqQ=;
        b=QMHm9SZvCqtBm6jW3YwKo2KpMhlYfHf0x/zNezNrQNHmRc8DFZ0SZOpfDsPyBAesbW
         ir9psncTR8LqRmkPXhATvGJ3seXDetkewS1ddZ9K5BBMYqePm2VYmJ0WyIchUtKnk2zk
         ZSqZ5UOQzfC0S72xnwq/aFcEqGNfQjEhO2DszEIt9cU4gpwyJ7U7JEabC6CvKtySEipB
         E2hQ7Pn3qCTM5f/ZWpoiXr7e3HNpO65RCsnKY5KVJ3IXDk61GJXVRbvLv/4x/q1W9xaq
         aixLMWY9BCgIkOBvkXfKAOtjrGbd3uhA5Dq7I/JDcGrEJYJ0n96fgmnB3HTQEJveZXwB
         W0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=sxIDFaPdI9UnmOo2IYAOhTIginE4kEg2RRMxCsA9bqQ=;
        b=pv4kI+x0rc1ZCQOyJosRN6n9zJQgEm9DID0aAWBJ8nrjKSaAjNBKJs5sHMyX4pZ3Qw
         yWj0mmLoU0i8igby1EiFUZRcJYoxSjS4EyuWV9Szo0tFkCPaErNa+1Zr11syALv16TId
         kRK+PRJRGoKOzUZVRpAxREViDMCB338K0O55JhZ+WAfr5QRmofyx+0n9wHd3gBA9PB+Z
         M0l9aBdQNDQ2pyelV/BcIpgTtl17OHZhPhsb09W8V22y9XgRdU4/s5UrN7Dob/3dskEj
         tzhcCtiw4HHxzhlmr2i5FxZqlwarsSzrrdtM2rj2PZtZdDYgk5WG5XtOIJQawf6MBt3z
         5P6Q==
X-Gm-Message-State: APjAAAXrwZZhi5fs74WPk1wX69F1ZXd2I9t5HjuuspyKdrR+K/idNfP/
        RgabgOg61OoJ0Igz/5446JQ=
X-Google-Smtp-Source: APXvYqy60DYUif2TY8RLwZ+6Y9lJGyFlBa3P23AsCHtdexkz0DXnRwGSLi7umrqD7+Q6gBrkqBch7w==
X-Received: by 2002:a50:ba13:: with SMTP id g19mr31745492edc.236.1557786403852;
        Mon, 13 May 2019 15:26:43 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id i33sm4108197ede.47.2019.05.13.15.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 15:26:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] Git v2.22.0-rc0
References: <xmqqef52baih.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqef52baih.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 14 May 2019 00:26:42 +0200
Message-ID: <87pnomvvml.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


-CC lkml & git-packagers.

Some suggestions for fixes in RelNotes & last-minute observations:

On Mon, May 13 2019, Junio C Hamano wrote:

>  * "git stash" has been rewritten in C.

I just noticed that stash.useBuiltin added in 90a462725e ("stash:
optionally use the scripted version again", 2019-02-25) doesn't have
docs like rebase.useBuiltin d8d0a546f0 ("rebase doc: document
rebase.useBuiltin", 2018-11-14).

>  * Mechanically and systematically drop "extern" from function
>    declarlation.

s/declarlation/declaration/

>
>  * The script to aggregate perf result unconditionally depended on
>    libjson-perl even though it did not have to, which has been
>    corrected.

Trivial, but maybe s/libjson-perl/JSON.pm/, i.e. use the Perl way of
referring to it, not Debian's package name.

>  * Build update for SHA-1 with collision detection.
>    (merge 07a20f569b jk/sha1dc later to maint).

Hopefully my just-sent follow-up to this will make it for 2.22.0...

>  * "git chery-pick" (and "revert" that shares the same runtime engine)

s/chery-pick/cherry-pick/
