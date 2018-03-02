Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDFA41F404
	for <e@80x24.org>; Fri,  2 Mar 2018 15:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423013AbeCBPcT (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 10:32:19 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:45442 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422707AbeCBPcP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 10:32:15 -0500
Received: by mail-vk0-f51.google.com with SMTP id k187so5933167vke.12
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 07:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a27Jp9aPuJXfBCTOo9+1j4jafhU5Qyn14eA2mfl86Dc=;
        b=fDeLCDG4Ofm8gzLTQnTfmWhWFe90lbf59ykL1B6Kg9KKbtomgXjXBN+nRfRWZ/hZY7
         UvqDAW3qxGYDxQyu1+GMfdJ2Qu2ACijUjH5qCW9x6kMGoa2MOSL67PF+yvovbgvziwdL
         TEswQsO9yGTplbxdjwdXQ/lRCQdIeqE8Kq9kgtMXbN0UDDVP2+UWcjI8pxSd6RaTH+Nq
         wbx6y9CZz8NCmENJWt1T2eKQguGAlEn9Fmi8nKSpVE6sW5AZ4Ia1n16jeokpEc5rU0iD
         Lztd4JqhUnO3k4yDrcWXGJSRUX5HrnhY9ydGcspFcxdQF4KF7vXH+9d5LmGZqBqWmK9b
         yXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a27Jp9aPuJXfBCTOo9+1j4jafhU5Qyn14eA2mfl86Dc=;
        b=BSINjs/14BSnm/95QmXcOgGgbvl7dtPFxqT3AM06RjfR/JbOUOEuxsE0XWlQZaa9TK
         IHm00AhXmZ349nkUkb8uOwSdiMlVeXuGxElsydQxZDO2z9XEV8+5WBV8RSgvBUtkdALg
         +vA+RXgAmMxpjLnp1TtQumZPAJlYPeLSyhtfFka5gXuvEvZBVuuXAh2VD9PokjswYBTJ
         GzAv0MfjhaRMAZzpHX7T6lad5uMNALc3IKXkW7rcO3y7w8snfHacWU8J0/eA89r9ufRj
         V0iObcYQAWm57x2IrnunYkDd00+3V4bejC87QGkZLBzegfgxw7F97/vkw+qaMxMAXXJ5
         YhzA==
X-Gm-Message-State: APf1xPAcaELwtmDbGHn9jtNn809otQtRxAhg642beXVob7XWQQTgujjM
        ubPpR+G4CEEXT7IExUyfga0uHGAxGQKcKgMLp8k06Q==
X-Google-Smtp-Source: AG47ELtI8QYVJcgZKUQmb9EsxVgRpgnZamiP03hyfNp1Tajq5ymFv4KBVTGgIuaoLUBCJu3Q/r6RORD9WQSAjEgvAKY=
X-Received: by 10.31.51.73 with SMTP id z70mr3901706vkz.2.1520004733971; Fri,
 02 Mar 2018 07:32:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Fri, 2 Mar 2018 07:32:13 -0800 (PST)
In-Reply-To: <20180223233951.11154-1-szeder.dev@gmail.com>
References: <20180223233951.11154-1-szeder.dev@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 2 Mar 2018 16:32:13 +0100
Message-ID: <CAM0VKj=vvJubs0AdcrQAzDka6pe2nWtpJ_cwSEwWmhncjrkh3g@mail.gmail.com>
Subject: Re: [PATCH 00/11] Make the test suite pass with '-x' and /bin/sh
To:     Git mailing list <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 24, 2018 at 12:39 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
> This patch series makes '-x' tracing of tests work reliably even when
> running them with /bin/sh, and setting TEST_SHELL_PATH=3Dbash will be
> unnecessary.
>
>   make GIT_TEST_OPTS=3D'-x --verbose-log' test
>
> passes on my setup and on all Travis CI build jobs (though neither me
> nor Travis CI run all tests, e.g. CVS).

I installed 'cvs' and whatnot to run t94* and t96* tests, and sure
enough, 5 tests in 2 test scripts fail with '-x' tracing and /bin/sh.
I think I will be able to get around to send v2 during the weekend.
