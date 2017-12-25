Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83BD51F406
	for <e@80x24.org>; Mon, 25 Dec 2017 12:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbdLYMsc (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 07:48:32 -0500
Received: from mail-ot0-f179.google.com ([74.125.82.179]:35771 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751681AbdLYMsb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 07:48:31 -0500
Received: by mail-ot0-f179.google.com with SMTP id q5so7371440oth.2
        for <git@vger.kernel.org>; Mon, 25 Dec 2017 04:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uPzstSZB8z48uLhZe9ACynIq2bRI7/XGNx1ND2aVmpA=;
        b=ISYz2A/lv2LubTCo/s2f8kiq6YISMkUsfxsDhcoJFDtgukobXHL2IkEKNdOTKflXCX
         omeqV0OcIwUeDWmh9cXSDopLv0HhJarVeslxJM205B1OF0e0NLnM9oMhmK45qfQfzao5
         yakQAPGqf97pdnh9XxApvyvw2hHhhVzaPLsAEit6h+KS3RlMBHUcXCePfvsPrSviBnEt
         BZ1gAOSs/SbkkhF2hNRQxfEUjA4KayLhWI32y7rBblMiV1Ya7YDwH4rcuDztj93ee25d
         KOgc0jZ67JlJxKaAv3dfPP4/OfIKYNEDoA4WcYMAvQ+UUqHkHsiTroCI1jqVGaGjxuxr
         BDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uPzstSZB8z48uLhZe9ACynIq2bRI7/XGNx1ND2aVmpA=;
        b=cmed7OE1ZPlgUq5LvaXdJh3q7sNDSvVB+bNKepewto5i6qXLmOXVk56mwcrTc0Es3z
         xA7+8gkvn919zfilwyjaSdm26uHIwgYKv+Xz2ep86rB8kN7qW/2yUkEXYGbgQStw40KO
         z3QfEMn5mpE0nvEDODnb3Y0eaW6WS7ycXypGeeY/jqJf0MRii9k+Wzi6GfxOQlulsRJ7
         Aq1cMTCJj9y6EQjvxtMaJv3aZ7CaSYd+4F3gJJfuJoACShtZViYkN92HZuAInroZLI8G
         XFsGzxAqaz/UE0SUK6l/LOlCViYkOpUifQgmYhxDZHaazZV44/sY4JyIT/9ClYA/BzMw
         MiEQ==
X-Gm-Message-State: AKGB3mKnQlTZpFz46CTO3ab7G5xYWN5kS8jXJOAqLFIbUxcucPM1luLG
        EsclDyDuxWtVR0OtXKd1MHNlexj4ZpEzBKm3NDg=
X-Google-Smtp-Source: ACJfBovC44l22SZZ8aAHY/waaJxXnQ5IEETe+mpAYblgDmcrNPkZMIWCxoyMmk7juDLjZus8NsQEbfbcZsJ4RqLdsqo=
X-Received: by 10.157.49.92 with SMTP id v28mr10637115otd.151.1514206111013;
 Mon, 25 Dec 2017 04:48:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Mon, 25 Dec 2017 04:48:00 -0800 (PST)
In-Reply-To: <20171203221721.16462-9-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com> <20171203221721.16462-1-liambeguin@gmail.com>
 <20171203221721.16462-9-liambeguin@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 25 Dec 2017 19:48:00 +0700
Message-ID: <CACsJy8B3U0_sJeEt+gLy9HJKszO5-uRZsssL3ZFdkKbSM9yWDg@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] rebase -i: learn to abbreviate command names
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 4, 2017 at 5:17 AM, Liam Beguin <liambeguin@gmail.com> wrote:
> +static const char command_to_char(const enum todo_command command)
> +{
> +       if (command < TODO_COMMENT && todo_command_info[command].c)
> +               return todo_command_info[command].c;
> +       return comment_line_char;
> +}

    CC sequencer.o
sequencer.c:798:19: error: type qualifiers ignored on function return
type [-Werror=ignored-qualifiers]
 static const char command_to_char(const enum todo_command command)
                   ^

Maybe drop the first const.
-- 
Duy
