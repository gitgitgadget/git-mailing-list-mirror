Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E3AC202A5
	for <e@80x24.org>; Mon,  2 Oct 2017 10:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751162AbdJBKU7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 06:20:59 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:57110 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdJBKU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 06:20:57 -0400
Received: by mail-pf0-f174.google.com with SMTP id g65so2689833pfe.13
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 03:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jAmAUTtxorLlvVY3yeZUD3eZhYJmwZmqmE68Z4YwJiU=;
        b=uP8JB012q8WAttVSr9m3u/CggAKKin4KGdo4bcDVhJDBdozbuHMR/HAQJWTNDMiUHv
         ngbALnbH8DnMqKaSOU7No2vVv5kTZz8ibOkoJiB/NLI7bphkQHSm85Qasf7u9ikrJFjI
         bzdhzBI2O3XVvioJBisFEy31fTfeHEKe9bxE0VGWumquqkofVmdrElmRet6OgGpJnXI0
         1kf+y8qvkA61NPliVMyflODRq09M2ZBV7esy6BUvgzfacFUEn+wDcpV5NaYh9ZBgKMSA
         kMjZIzOSNPkij5xKWPR7pIOF6XART8T5RMSmG+U7sWbs/JTwvHK2nsvm7EmjGsqD6eWb
         GYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jAmAUTtxorLlvVY3yeZUD3eZhYJmwZmqmE68Z4YwJiU=;
        b=rocO8UmgyL5nmHuKx+EDXkKQ2v2IbmpHMPXv1wCb+HNms9uFuXvSfH12RhxbhM4qFk
         vL45JExtrKgiBbGY3e+VQJnka5Xuvm3lw2nWOjNPpOlRe5wutMot6df5RulrYePrJb9f
         09ZOx13Mgx6a6JOmtTzL0y7gyFuNS8iA0bD+WDyV7+1XrPfm9uZPZn/QsNTB9A/3lUZY
         tHravRKdzpn76PBgfRwo0F6F1tXV7LTePDcp5Mex0RQX8e+6TSzkXYJwmCQEO2wWybcx
         AszpXBsSEG+3gyFf4EWUn90nM7JjESI2kev5gF5tiDArhh3pSSre1Zwtx+p6Om1Tfza6
         gxqg==
X-Gm-Message-State: AHPjjUjxFS1wO/+bkkDwoaHD/qBas7nEmAK67rgjFRXVEyiMdUkMY884
        33hRcfVE5VKEM8OeEVHvz9o62wUzXt0ssQJhwPI=
X-Google-Smtp-Source: AOwi7QAROH+HPOi6Lhc0fPkQxsu/kxJAhBXTMivdynKNAYqZ6MXHJwht0ujbsp+T9hLPv4A7lDeotfHqTqUWoQVU5Lw=
X-Received: by 10.101.81.135 with SMTP id h7mr12445138pgq.48.1506939657463;
 Mon, 02 Oct 2017 03:20:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Mon, 2 Oct 2017 03:20:56 -0700 (PDT)
In-Reply-To: <20171002062528.naa5hrqoao5sifs3@sigill.intra.peff.net>
References: <20171001174208.1693753-1-martin.agren@gmail.com> <20171002062528.naa5hrqoao5sifs3@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 2 Oct 2017 12:20:56 +0200
Message-ID: <CAN0heSoson-KkbgVnRPdTmRL2MMDU1+L6XdOHhi6xcZS5rwQcQ@mail.gmail.com>
Subject: Re: [PATCH] builtin/: add UNLEAKs
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2 October 2017 at 08:25, Jeff King <peff@peff.net> wrote:
> On Sun, Oct 01, 2017 at 07:42:08PM +0200, Martin =C3=85gren wrote:
>
>> Add some UNLEAKs where we are about to return from `cmd_*`. UNLEAK the
>> variables in the same order as we've declared them. While addressing
>> `msg` in builtin/tag.c, convert the existing `strbuf_release()` calls as
>> well.
>
> It might have raised Junio's eyebrows less to say something like:
>
>    ...convert the existing strbuf_release() calls as well (they're not
>    wrong, but they also accomplish nothing and create an inconsistency
>    with the UNLEAKed variables).

Most likely yes. Sorry about that. I have yet to be critiqued for
writing *too much* in a commit message. That should tell me something.

> Seeing hunks like this makes me happy with the UNLEAK() solution. It
> would have been a real pain to do this via actual freeing.

Yes, I was very happy to have it handy. :-)

Martin
