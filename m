Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C34720248
	for <e@80x24.org>; Mon,  4 Mar 2019 12:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfCDMSB (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 07:18:01 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40267 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfCDMSB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 07:18:01 -0500
Received: by mail-io1-f66.google.com with SMTP id p17so3773816iol.7
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 04:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FTAKG0sF11jnoZp/U1p9WDKAPqzw8HwXgEE6336bD/A=;
        b=M4V3cWhA7HkV0N0DOcatttkbIXSlNZefXri8LkmSx307CQbwRxfK6GxfoSwzZJwV9i
         ihWdYUGZVkOd5ZK6un+kYNDPkJzwqM5eYd8lb+mceDs5luH8bS4Izi4Xk9jDQuffjvFb
         rGPylOa9zGo2f7QAR0tjcc5ZiTGoMaeDuXerbqE8jMufDvYPk/E2DY/1+jezgsWnwoLd
         XpizvGkidtF3KCpreHJtAnQ0ampBafKVyuqs/AsabIWWAC7GjYoKUMOJ8sfBgxiYqXq+
         IeUyl3YvM1qo5W3erUGVD9sSXDOPsLkXLv0EmGbhlgmDLjRDkaY1I0TDG0XtBvCjCuqs
         jjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FTAKG0sF11jnoZp/U1p9WDKAPqzw8HwXgEE6336bD/A=;
        b=Accc5UBm8pYM1hwfXNEfkf80GQgDrghnDd2jLYZwMGEKorzW7Fm2195haomPD2OcM0
         Ru6xUro0vnowtYpcA/DYG1JJi3Vs+8Zrfdj39ASJx+v8ysEtF94VHWsSjt88BdYwXdOH
         xjf0KlRcrGjXH/vhQqUo3uYqjLFUptwBtBzDs4+lZ/vPZn5k2JGyo+DpT/y1jzY/g59N
         Vl96sx0Gqdel4h9SXxy049IxkuSRY7/uEtbYCaLV2JuzzZ2sJf0A0PEZH2VG5bMfJjK/
         xpAXVnhe+O1PepegyXh5sDQ2x9LIa1+Zuit6hkW/XbL2GZTQb23GahdHpia4zH/56QQ4
         vo4Q==
X-Gm-Message-State: APjAAAV2OlMksDHvzt+rfTPK9pTrPU484XLF4SjPRVFmxJHkhfNAD+CQ
        330+xcc93Izfz1CogUwlmAlnLPvEJ2um/wQ2kJ4=
X-Google-Smtp-Source: APXvYqx9600ccrCNgQ2l+WmXPJr890JKb5KZNN3a+ufo1OO3OeRr69IzewiZcj4bPhDFuzvufTx25GiXBkFmcWsAPHo=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr8242268ioc.282.1551701880417;
 Mon, 04 Mar 2019 04:18:00 -0800 (PST)
MIME-Version: 1.0
References: <20190303200220.30009-1-brandon1024.br@gmail.com>
In-Reply-To: <20190303200220.30009-1-brandon1024.br@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 4 Mar 2019 19:17:34 +0700
Message-ID: <CACsJy8D60NXksKpYJeDJbYKP6JUmrHEJW8ubMeV12dij+jXKLg@mail.gmail.com>
Subject: Re: [PATCH v3] commit-tree: utilize parse-options api
To:     Brandon Richardson <brandon1024.br@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Andrei Rybak <rybak.a.v@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 4, 2019 at 3:02 AM Brandon Richardson
<brandon1024.br@gmail.com> wrote:
>
> Rather than parse options manually, which is both difficult to
> read and error prone, parse options supplied to commit-tree
> using the parse-options api.
>
> It was discovered that the --no-gpg-sign option was documented
> but not implemented in commit 70ddbd7767 (commit-tree: add missing
> --gpg-sign flag, 2019-01-19), and the existing implementation
> would attempt to translate the option as a tree oid. It was also
> suggested earlier in commit 55ca3f99ae (commit-tree: add and document
> --no-gpg-sign, 2013-12-13) that commit-tree should be migrated to
> utilize the parse-options api, which could help prevent mistakes
> like this in the future. Hence this change.

You probably should mention about the extra _() too (e.g. "while at
there, mark more strings for translation") just to be clear it's
intentional.

> diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
> index 12cc403bd7..d4a911acf5 100644
> --- a/builtin/commit-tree.c
> +++ b/builtin/commit-tree.c
> @@ -12,8 +12,14 @@
>  #include "builtin.h"
>  #include "utf8.h"
>  #include "gpg-interface.h"
> +#include "parse-options.h"
> +#include "string-list.h"

Everything looks good, except that I can't find where this
string-list.h is needed. Maybe just try to remove it and build to be
sure.
-- 
Duy
