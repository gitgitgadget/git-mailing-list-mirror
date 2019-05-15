Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 057441F461
	for <e@80x24.org>; Wed, 15 May 2019 08:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfEOIOp (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 04:14:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54308 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfEOIOo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 04:14:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id i3so1615777wml.4
        for <git@vger.kernel.org>; Wed, 15 May 2019 01:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvBm43AedIuLtrhVZzzRBfk2J4/nxBfJ80+iFFFffXY=;
        b=BeMvuFBdESR+B8cpS+CG7T8MyJt5PLkyIGHN4yF4XD4jleqyltu06VshjcxtiLsKEU
         73Pg09Chj7ZAWASSq02bbdOSPOXL6MtEPD2pRtKE042wCZRrT/jMvOcR1YecaE8M32aW
         psWKwk0AQbEP/r4IhJ60IcbbRu/CZtag3qcTYh3c/MZV7N19D+FSuZO0D4VbCoH52Ypx
         ktIomcNxxYjIvmbdpcwYM/Mm3k9NU6SZ/XQmTIqogr7PdjByAcdDkcRk52LBArbNmliv
         x+FSd+oTkouWit13dagDN8K03Xt3+ZWGorsP2S2WM0pFrGFA8MgRTXN6zZTkLAuw6cFR
         PpGg==
X-Gm-Message-State: APjAAAW5VR+qoHZY7hI7HleYWJ8ppZguBQIh7+wx8cCnNcknx7JFhnS4
        8ODNji2enR0NQchD/4FpTM8pEcxZbL7KhRfIQ68=
X-Google-Smtp-Source: APXvYqxHNLKhvZXbqPvPe8+Rv1LjsUOawz8XbpE0r2qja4Xx4ZYXme7zG0WS8MioydCD5PsRnCt2Bf/KtoJppM8Zolc=
X-Received: by 2002:a1c:760f:: with SMTP id r15mr9190945wmc.134.1557908083510;
 Wed, 15 May 2019 01:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <7bd330d7-81f1-52b4-52d3-b74b128af83a@iee.org> <20190515081112.12340-1-philipoakley@iee.org>
In-Reply-To: <20190515081112.12340-1-philipoakley@iee.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 15 May 2019 04:14:32 -0400
Message-ID: <CAPig+cQ4FZeOxbVU-5qTrQm8Q-khwHuCwekAr-aGtbLKAVzY0Q@mail.gmail.com>
Subject: Re: [PATCH v2] git.c: show usage for accessing the git(1) help page
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 15, 2019 at 4:11 AM Philip Oakley <philipoakley@iee.org> wrote:
> It is not immediately obvious how to use the `git help` system to show
> the git(1) page, with its overview and its background and coordinating
> material, such as environment variables.
>
> Let's simply list it as the last few words of the last usage line.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
> diff --git a/git.c b/git.c
> @@ -33,7 +33,8 @@ const char git_usage_string[] =
>  const char git_more_info_string[] =
>         N_("'git help -a' and 'git help -g' list available subcommands and some\n"
>            "concept guides. See 'git help <command>' or 'git help <concept>'\n"
> -          "to read about a specific subcommand or concept.");
> +          "to read about a specific subcommand or concept.\n"
> +          "Use 'git help git' for an overview of the system.");

If you want to be consistent with the wording shown for "git help
<...>", you might want s/Use/See/.
