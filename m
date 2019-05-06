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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8223B1F45F
	for <e@80x24.org>; Mon,  6 May 2019 11:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfEFLD6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 07:03:58 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:43296 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfEFLD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 07:03:58 -0400
Received: by mail-ed1-f50.google.com with SMTP id w33so12553604edb.10
        for <git@vger.kernel.org>; Mon, 06 May 2019 04:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=N+NYjUxTqsO3xv4vKWQBzG7sO6tWS6NqDxzMtscFo+Y=;
        b=GgHJe9kBIaioeYO5t5qk3X8Xh4Dz6zx6Hpmu/dmPdNC6NbdzAm05BB1Cf+mOed1MEE
         BonEPqullX/U+XkefuzgAi0RKYRRQydFBhVn5/ArlANktIqpbwjT3cExo/1jzid2/AIU
         tw96v5l4coO6dpvhNYInn0sLnGVtVxLLl+3vLypTdRej4zN+Cz/o73ZVkS/b/VDlgdn7
         ZIdRmQtAc4zw+UUzmvPwB7ujXYGB9aMvl+BG/XSNYgFntK5lp9vfeZQqSk7urcvnFBYG
         CU9ujhKq6Sde+cMoqWh09v1OhoFlZVgTHrWWML8e3782nDBk9bVm+TkOdeNBxOD3RNeN
         g8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=N+NYjUxTqsO3xv4vKWQBzG7sO6tWS6NqDxzMtscFo+Y=;
        b=Rt5NlQDaEQhYnzwJXIGz6ndyonQbZfprtu0Gn4daQxyl8+KIkS8cY6ZDjSRiVo5iez
         PugYPnb0Wa5sbwcpoTfU0jR/dKyIl8ISZFOXzdPSh2O9TlzM+WUw53RUje1Vds8Es1kF
         goSLM+e3hR8+gsvlVgieGPH7atuJVR3tRZJ2PhL9r57KjBXQPjzgVuVtVC+tJtP105GD
         ZUCEHd/2WrxvGV9hL/dBW6VSrJqybPLYvIsVMWehxREc5IFfXuzTSSo8J+Fgak74DzDZ
         4JH7ujmMzniG/xmbidC9uJjVj1CIt0abdimFQdZzOLI8Xdz967N+K7E/ssraQRqHPsST
         nGAw==
X-Gm-Message-State: APjAAAVXA4Ca8gt8MA7tmq396yGoNUjuhplilMqQQ3HwT46yZTo2tFDF
        W6dIgFxD8glZ4kSL/OvKQhFKOmVjpk0=
X-Google-Smtp-Source: APXvYqwQ4EyTmthdTLeNfokevL7oXmAe40yVDlNShTqvP8uIy0SNyKQ9sENEifKwKkYffQYlemKv9A==
X-Received: by 2002:a50:8eb6:: with SMTP id w51mr25080418edw.34.1557140636038;
        Mon, 06 May 2019 04:03:56 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id s6sm1515328eji.13.2019.05.06.04.03.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 04:03:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 0/3] *** SUBJECT HERE ***
References: <cover.1556062365.git.liu.denton@gmail.com> <cover.1556526308.git.liu.denton@gmail.com> <20190429083042.GA22366@archbookpro.localdomain>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190429083042.GA22366@archbookpro.localdomain>
Date:   Mon, 06 May 2019 13:03:54 +0200
Message-ID: <877eb3j145.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 29 2019, Denton Liu wrote:

>> Subject: [PATCH v5 0/3] *** SUBJECT HERE ***
>
> I forgot to change the subject... Embarassing.

Do you use git-send-email with --force? We should detect & stop these
being sent out otherwise. See a03bc5b6ad ("send-email: Refuse to send
cover-letter template subject", 2009-06-08).

Don't worry about the E-Mail itself, shit happens :) Just wondering if
that detection case is buggy, or if you used --force, or maybe sent the
E-Mails through another method than git-send-email...
