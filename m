Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD6151F453
	for <e@80x24.org>; Mon, 11 Feb 2019 03:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfBKDrG (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 22:47:06 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32933 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfBKDrG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 22:47:06 -0500
Received: by mail-qt1-f196.google.com with SMTP id z39so856640qtz.0
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 19:47:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hsR+4eKLwtm2MeSiun0Pm3zkolfOn6BgKk3GW1TX8w=;
        b=l0qfulsjqunpHCz2wQor1N3oAXBy7OmxR7Ux8seA6cNsGp0ZImSHiw2n740R/x6vCJ
         Ke/2H6KJL+9hvQ+bf80tioBSuNpvkpwlaN3StB4X6GwiFBxetLXjiAxoQ+uAnQs6KUnU
         1KQyYZf5iePzqiYVAOGPfLn5KMGmYJx6uD9dGSlsWa7QRRbPp3b/xe93V5zq1FUOVjNi
         DDEyY0kXJm7G/iKn/V/5KielDGcNPrdvK/vJWJlcaQ+YMahT3YXF8weoQ85Xjsb3kzsZ
         NkZEBLYn1X2+P2qh6Nqch65fahl0fv+WHhFqnZqD+28SJlB6Z4vYL7CrbTsl/WFpkUK1
         8yXg==
X-Gm-Message-State: AHQUAuYVUMDba8CnO3vV0OBUiYHHbaRV6kY/LnFiB/ysGtLd0MvUphUz
        q4R4y7kJWpYkWOPjleP101Zh3goQ2b1jOmBcr8M=
X-Google-Smtp-Source: AHgI3IYpjYEzqsceM9lQ+UeqGBMUbmx0rbA8vATFEkozWL7lTg6Rfh1qiQbLArE40G9jQMlyXTLkmppBM4L9KtHeF58=
X-Received: by 2002:a0c:90cb:: with SMTP id p69mr1319247qvp.62.1549856825062;
 Sun, 10 Feb 2019 19:47:05 -0800 (PST)
MIME-Version: 1.0
References: <20190211030639.18761-1-worldhello.net@gmail.com>
In-Reply-To: <20190211030639.18761-1-worldhello.net@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 10 Feb 2019 22:46:54 -0500
Message-ID: <CAPig+cSB3Z=tqfN+Homjc-DYCnbNPuY-v=FJRZqrLPR+v8YwWw@mail.gmail.com>
Subject: Re: [PATCH] Fix typo: "git bisectreset" -> "git bisect reset"
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 10, 2019 at 10:07 PM Jiang Xin <worldhello.net@gmail.com> wrote:
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> @@ -173,7 +173,7 @@ static int bisect_reset(const char *commit)
>                         return error(_("could not check out original"
>                                        " HEAD '%s'. Try 'git bisect"
> -                                      "reset <commit>'."), branch.buf);
> +                                      " reset <commit>'."), branch.buf);
>                 }

This duplicates a change made by [1], although that patch was
withdrawn (temporarily).

[1]: http://public-inbox.org/git/20190209213044.29539-1-jn.avila@free.fr/
