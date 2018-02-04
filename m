Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71A031F404
	for <e@80x24.org>; Sun,  4 Feb 2018 18:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeBDSzs (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Feb 2018 13:55:48 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:40210 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751767AbeBDSzr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Feb 2018 13:55:47 -0500
Received: by mail-wm0-f50.google.com with SMTP id v123so21794908wmd.5
        for <git@vger.kernel.org>; Sun, 04 Feb 2018 10:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=QkZndu8j+n7r7B4Ug1nyiF/ID8nMkIji0rKNZtIwTqw=;
        b=ld7yZClhH70sqNP9dxkRaQ8+N/v5Vo8XCFezqmW2nqZugICU1s/UQVEAYzw1vskIil
         Yopz4CER4Pu4jxwCxUOVSyaFPV4Q6YFvzYpfO+/COgwMGvwNuUbzWYqrpu7M4GbhsqFB
         5GDkuotRn0zzvXD7aHraDnNitaQfC8Cx+8HBd7sfcqJ7AuqOI9aeydr37omfUEOu9rsU
         uF2kcHQMNpu6xWPlhU9uf73Gn8+kATZntH4Lf4n3CUWjd6fMSWyj7y44LjubYdJb6w35
         y+WClMd5IOFFPcbUf37IOK2QEYPe4XQ2Ha3tGvxw26TPgRjfWYzUD4nQeg8tu5ZKsfTI
         yEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=QkZndu8j+n7r7B4Ug1nyiF/ID8nMkIji0rKNZtIwTqw=;
        b=j+smhkkHnPIbtcqTwrWrDroeo/6iFW72QgrO+QgLAXk5TlScnRgm5gg8B2ZkwYU9Ij
         mrvYZ7cA82hAl/a2cg1JsqcmGbUltIJv0qW/yOp9W+T6bKUKdQumvrizhIlQhEa74BX3
         4HBa5nsvyLSOX5ehkvUsRDqYPc7bMOXleSrqoPJAHmImCbjLlcxsK5U44u0tLbY7cyPe
         f1WE7ekTZsRGtv+4unGXmUZx3OyrlfldmUs5qKogmsBE4BLHNN3FlhojeEOXRDQ3X6vt
         amLNpUGf08s8E7hk2zdDXD3eFp+5CdxXBvPYix+Vcd4ghvN32WYoSRJu3XrsuQi+vE8e
         nCgA==
X-Gm-Message-State: AKwxyteI/H4VAyNbeEKeo8sr0X+pgpdybSBpfQItQ2JVWjFHXRU6r4WR
        Yb6I53vMlEdvTOgIvtKbUaiP0frJ
X-Google-Smtp-Source: AH8x227xnGe24nHk2is59U0RSQ1IszpYBJ2lx7d0oX/vdQnOqZ6zb4SdmMBUQdXecHo9Qk5myZu6Kg==
X-Received: by 10.80.171.78 with SMTP id t14mr69191944edc.170.1517770546100;
        Sun, 04 Feb 2018 10:55:46 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id w2sm6245888edb.25.2018.02.04.10.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Feb 2018 10:55:44 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Lucas Werkmeister <mail@lucaswerkmeister.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v4] daemon: add --log-destination=(stderr|syslog|none)
References: <772ae5fc-5f92-3494-613a-a44c0073e8d7@lucaswerkmeister.de> <20180204183037.23162-1-mail@lucaswerkmeister.de>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <20180204183037.23162-1-mail@lucaswerkmeister.de>
Date:   Sun, 04 Feb 2018 19:55:43 +0100
Message-ID: <871si0mvo0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 04 2018, Lucas Werkmeister jotted:

>  	     [--inetd |
>  	      [--listen=<host_or_ipaddr>] [--port=<n>]
>  	      [--user=<user> [--group=<group>]]]
> +	     [--log-destination=(stderr|syslog|none)]

I micronit, but maybe worthwhile to have a preceeding commit to fix up
that indentation of --listen and --user.

> +--log-destination=<destination>::
> +	Send log messages to the specified destination.
> +	Note that this option does not imply --verbose,

Should `` quote --verbose, although I see similar to the WS change I
noted above there's plenty of existing stuff in that doc doing it wrong.
> +			} else
> +				die("unknown log destination '%s'", v);

Should be die(_("unknown..., i.e. use the _() macro.

Anyway, this looks fine to be with our without these proposed
bikeshedding changes above. Thanks.
