Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 376DA208B4
	for <e@80x24.org>; Mon,  7 Aug 2017 16:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbdHGQep (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 12:34:45 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34044 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdHGQen (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 12:34:43 -0400
Received: by mail-pg0-f65.google.com with SMTP id y192so822123pgd.1
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 09:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aRb47QNdZ7cYqCiROEc/zdtWI88G+rduNf+IbNwj6H0=;
        b=W8vMB4lAhSglbluCwj+jLtvJZ0CxVzG/N8OzgAGJIkfeD1R4wtEgLBwOQVDOTxdj49
         PvwqgDv9oILT0I/5H8I4MbVvWIgwLIW7gut3JbCFoDDhqttu67g7tJN9Ev7d7CHV/5mf
         uyPgm7bwLZ8WHTNiCl0DgzZxP6pyoDPwI6V6x9zSu1uDcZdn6Lax3/mq+39Pxf+AMk3C
         IteuJV8IrLJLoOR5xkJandVKgQs/CVnEhGSRucUQNKUilNNlMgS1eHdBs17MP1FH04Q+
         JjHWB+QbQeaI/kU4J3Bh2nJ6Nmr2kLNHbvKwFUKLauRRTUNBTjGl4F/dfya1Pp1iR10i
         HQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aRb47QNdZ7cYqCiROEc/zdtWI88G+rduNf+IbNwj6H0=;
        b=On8Op7TzG1f7eztlMBPx/eJfxxTmS86drSguEiV7Q17Q8pis+xWLvECdZEx4+wNf5t
         uaXS9DCKUNKDpfsODelAphFlYnqWqhEv3PE1YLkZ4pe1ySsnExLyE6g/sjNmruGGOYvg
         Ubtbv2m6pdLEgUKUerTdbvHOozICk02U9nwNwsyuk1hdgBB8IThcDH7MYb9/gJTc/O1B
         2lfF95lrsGHRKjTrtUGFpOKt502m0u/s6xkOmRaPsqqqJFl70iV6dk7L8Q7s2UKj6aOQ
         Mnoa9w81FPl9dufAStGOi7uez+WlXrnr5a5DKJcYn69R2IpQkUcifswMRRcBbPriJk3s
         OaXQ==
X-Gm-Message-State: AHYfb5gWEhlOe8ddM7Ytx3QqEvK6WnVFrZoHo/Xlb3EEqybX7SltI59G
        p0Ip7n9wA/dnWZMaGjHO9uj1SgS5Pw==
X-Received: by 10.98.89.140 with SMTP id k12mr1197554pfj.71.1502123683256;
 Mon, 07 Aug 2017 09:34:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.238 with HTTP; Mon, 7 Aug 2017 09:34:42 -0700 (PDT)
In-Reply-To: <4a1f931c-9813-36a5-9c37-63b8abc4fecd@morey-chaisemartin.com>
References: <c74c8c386f2c2d8b6cebd4addf925d0121986067.1502114584.git.nicolas@morey-chaisemartin.com>
 <4a1f931c-9813-36a5-9c37-63b8abc4fecd@morey-chaisemartin.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 7 Aug 2017 18:34:42 +0200
Message-ID: <CAN0heSqyiisjWyDBXLJcyx=Hh3NA562DoFqP8rpFyi_zuGKLEA@mail.gmail.com>
Subject: Re: [PATCH 3/4] imap_send: setup_curl: use server_conf parameter
 instead of the global variable
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7 August 2017 at 16:04, Nicolas Morey-Chaisemartin
<nicolas@morey-chaisemartin.com> wrote:
> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
> ---
>  imap-send.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index 682a06551..90b8683ed 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1415,37 +1415,37 @@ static CURL *setup_curl(struct imap_server_conf *srvc)
>         if (!curl)
>                 die("curl_easy_init failed");
>
> -       server_fill_credential(&server);
> -       curl_easy_setopt(curl, CURLOPT_USERNAME, server.user);
> -       curl_easy_setopt(curl, CURLOPT_PASSWORD, server.pass);
> +       server_fill_credential(srvc);
> +       curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
> +       curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);

Here you change the server_fill_credential-call that you just added.
Maybe do this patch earlier, perhaps even as patch 1?

I'm snipping lots of s/server/srvc/-changes... There's a less noisy
way of addressing the fact that srvc is unused: dropping it. I'm not
saying that's a good idea, but it could be considered, then explained
why this approach is better. There are some other functions which
access "server" directly, and some which take (and use!) a "srvc".
Maybe make the whole file consistent?

Martin
