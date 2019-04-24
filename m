Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9A881F453
	for <e@80x24.org>; Wed, 24 Apr 2019 09:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfDXJuV (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 05:50:21 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34843 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfDXJuV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 05:50:21 -0400
Received: by mail-it1-f194.google.com with SMTP id w15so5187458itc.0
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 02:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gF6nGM+5dCdXF5NzbQdcnnbg5EoCTzcPsUBrQOPjLhQ=;
        b=XXVqQy9a9MJW3jAuI6/zAoG2zm8l31gLtRoiMGePNNfhrC86PlKbYJrXr39bQYcJq0
         zVd9xP8CMavDwSwdOnxSuDV40KWQ9z399RUnLQheOe3uKfmuZD4gSg2OsYD0XgACezp3
         Dx1jRaxr2M8L92GC+IgD34VDK4aofRaPakNCgOMlMnGb63B2E/oHf13MBw4O27wJnA4Y
         LNqT+wl+56Wt0Y1OVUexr1ORa4I7e5z9UylPnCaMYdVlfWrsHdNyJjKgJIeq4mfdBuay
         AkRcMT5zlfJyZwXzdb/4BY9qiTibTJQn/6cZVbBy/BU9mvhU79Ck0Me4CCqfyiHPUBGt
         NimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gF6nGM+5dCdXF5NzbQdcnnbg5EoCTzcPsUBrQOPjLhQ=;
        b=YoC1LDBF7ghC0sDIk/cwaPJoFmTLKa7EwsA5JmkYA+mJhXx+pI/dmly8BRmGZaUvsJ
         +1TIsyszSR1gGj2ORfhQGM3s53JZ4yXhrwyO/R3czLjm58GMSSYDmzGVpQ+igjjQTEqL
         mwfkkq/9Uq1tRhPDjrDz66OFSY/S2WZ6X5MvpBh3nizY1v1hhuin4iSnrUag/7/sHyFy
         ix5D7oiND7/Ga/qGx57AnikEWenX9rHOsP5zmTma8WENS5KVQYbwIzug/H20CCFdclrh
         p6dJNZx/gqVZYRZm19cidF1wt321ugY8vT+n+1OEPLTCDTL1FHuZPrp5fu49LSg0lRCo
         e5Nw==
X-Gm-Message-State: APjAAAW+Fj7ymjkcWAxvpPHfj+O2IEHOQDp7U7zoJTgaYwmsyw4gmJvm
        bLgzHui1zEHVEbnYE/7dcZAooYdZk4A/TJ2J0nM=
X-Google-Smtp-Source: APXvYqwtzc5EP/cZF1VpAHB7qQgvX8W67c1dqITMd7RXhaUWfBwjeuElbtDdRxVkK5i9iYa6HlTih2gnZRbgCTDQ54M=
X-Received: by 2002:a24:478a:: with SMTP id t132mr4974545itb.123.1556099420393;
 Wed, 24 Apr 2019 02:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
In-Reply-To: <20190424004948.728326-1-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 24 Apr 2019 16:49:54 +0700
Message-ID: <CACsJy8CKwiNknEkEH_-DxuXYiBmpYvfdRAZvmSJCcqko_OYnTw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Multiple hook support
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 24, 2019 at 7:54 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Oftentimes, people want to use multiple of the same kind of hook. This
> may be because software or a project they use requires a given hook, but
> they would also like to have a custom hook, or because they're using
> multiple pieces of software that both require involvement with the same
> hook.

Heh you beat me to it. My config-hooks branch [1] has not been updated
for half a year. I only skimmed through quickly so no useful comments,
but I went with a slightly different design, introducing
for_each_hook() instead (see run-command.[ch] in the last patch).

Back then I wasn't sure what would be the right policy for running
multiple hooks. By keeping the hook loop in one place, we could change
that policy much easier later (e.g. continue anyway in case of
failure, or stop as soon as you see a problem, or even run some
special hooks at the end even when there is an error earlier).

I'm not saying that should be the way to go. Just pointing it out. You
decide. Personally I think open coding the loop is just as well.

[1] https://gitlab.com/pclouds/git/commits/config-hooks
-- 
Duy
