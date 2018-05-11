Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8AA71F406
	for <e@80x24.org>; Fri, 11 May 2018 14:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753105AbeEKOdp (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 10:33:45 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:44278 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752873AbeEKOdo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 10:33:44 -0400
Received: by mail-ua0-f193.google.com with SMTP id h15-v6so3726301uan.11
        for <git@vger.kernel.org>; Fri, 11 May 2018 07:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PCdoHXxz+yqdYO/5UaENRJV0JCEmXYLYi47OoO64DUQ=;
        b=V7wixZPe1y9Q/M/p/tvy7k+GXeDbVJ+y+MrpEQdRQlP9U4TFgry5YOXr4hHez1pHxf
         jIwrDX7w6RWFrCKkXsGysSkisd91ZbpFAwvTGBy4MqQ9aS+GhDfR+kOZARlPXcVMsX91
         twnk2uNWcbcgVcUeQenUeVkeiHmPrb9x9yitJMg3rj9lZRdH6U9SOsGgtTiY3KxDvTb1
         NKYlH8c6JwyNCi955N7xoV7pQBHdYpFM4VPwx0Is0DByoXGr8C/BF7hNMNynJ9IO/RB7
         kUiMvoIWox7PViID5kH712ura8giJoRxuO8acxpNcZQTm5x/sRH9IobQyOvXPhvZEr7/
         V1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PCdoHXxz+yqdYO/5UaENRJV0JCEmXYLYi47OoO64DUQ=;
        b=Qfyy/oQcto+eCKp/sQNPYvO4Z+4QGVIO+gxqCOPqWt6Zgv6HNRF+H9XB6OyNumO0Fk
         st+XkAvFSdzzDxe3WJ/fG2jbmaHCFetVq2T+5N7e7HpMqsEuXTCpDBotdLQgGWSWM2ZW
         T1VPwkRB0SpYvSWXpePUXwA/XtTMsErvBgInFlt8A6rq/GvAqviL2L+Q8w2MUS2jM7rD
         idYu7SEpXdJR9xG9YP4yzKoVn2Lj3S+eBbWFFOvu8U8C7f6zJZHZeGu9UXC9DS9I/1Pa
         ruiem3+grpgF8qTQqHVajQ7cT2tEZHPjA/m9xp8GXf9Q35BaFNFaM00EiJNLHKFi8fEn
         eHig==
X-Gm-Message-State: ALKqPwcAQCc7XuoonQarg+c5PikeDiCC4vzBEkTmAId9ynqSa4KDT6Vx
        YlmiHXJ696BaEoT9BXcDl5PPaW2ubJS5+x2ud0A=
X-Google-Smtp-Source: AB8JxZp8aSNjkKo9ERKtHhSykwT3/OLl5/TAcNmmbJ7p4u4cAYST8g8t/MHcTZZpw6AuGQV0hE/3voZEu0R0rdAKB1I=
X-Received: by 2002:ab0:5a30:: with SMTP id l45-v6mr1536023uad.79.1526049223777;
 Fri, 11 May 2018 07:33:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Fri, 11 May 2018 07:33:42 -0700 (PDT)
In-Reply-To: <20180511125623.6068-1-benpeart@microsoft.com>
References: <20180509144213.18032-1-benpeart@microsoft.com> <20180511125623.6068-1-benpeart@microsoft.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 May 2018 07:33:42 -0700
Message-ID: <CABPp-BFLUVB-gMparKd98v=dxBkmRdDRWCEkGweJ0fO-83DPWw@mail.gmail.com>
Subject: Re: [PATCH v3] add status config and command line options for rename detection
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Alejandro Pauly <alpauly@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Fri, May 11, 2018 at 5:56 AM, Ben Peart <Ben.Peart@microsoft.com> wrote:
> After performing a merge that has conflicts git status will, by default,
> attempt to detect renames which causes many objects to be examined.  In a
> virtualized repo, those objects do not exist locally so the rename logic
> triggers them to be fetched from the server. This results in the status call
> taking hours to complete on very large repos vs seconds with this patch.
>
> Add a new config status.renames setting to enable turning off rename detection
> during status and commit.  This setting will default to the value of
> diff.renames.
>
> Add a new config status.renamelimit setting to to enable bounding the time
> spent finding out inexact renames during status and commit.  This setting will
> default to the value of diff.renamelimit.
>
> Add --no-renames command line option to status that enables overriding the
> config setting from the command line. Add --find-renames[=<n>] command line
> option to status that enables detecting renames and optionally setting the
> similarity index.

Any chance I could get you to re-wrap this at a smaller column width?
Doesn't fit in my (80-char) terminal when I run `git log`; a couple
lines run over by a couple characters.  (Sorry for not noticing this
earlier)

> This patch depends on em/status-rename-config

I'd leave this line for the notes.  It's useful information now, but
won't be to someone looking at the commit a year from now, so it
probably doesn't belong in the commit message.


With those two changes:
  Reviewed-by: Elijah Newren <newren@gmail.com>
