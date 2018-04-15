Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CB2D1F404
	for <e@80x24.org>; Sun, 15 Apr 2018 16:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeDOQE4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 12:04:56 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:41522 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752371AbeDOQEy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 12:04:54 -0400
Received: by mail-oi0-f41.google.com with SMTP id 188-v6so12398895oih.8
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 09:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P1CjvmeMoP6lE3s4fXZhz2viUsZigsA9PLJTVC7w7pM=;
        b=GXF/u1MO4b/5An2+dMe0dYimNKyl9p8N1Dcs3lMak/c4ZxsMmQG3lNrne/939zeCl0
         qFQWUhYH3qDYFKWwq1/ELGDNOGBB5TK2/9xjbaoz53Zq1NQ+NA3eZrpOyrl/o94dJfS7
         ob7BwRrKCt6V4ktTEr9xNL2THR6Vh5Q9bSelTkG9LXRQzBnEPnI8H49clYQyFaLZv0p0
         ZmaJ7VQzfirkmPfPMwNdxMcbPDqpCOb37xLw5bv+p1KYeB7qPyIVsMKU4eCmEgstS+k/
         Vynwpba+JxMnSh7U4eQS3PogjLGHnHGWOfGf9KGVdbobPiaiQ4lWQrehhkpKwEVa57wA
         Hrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P1CjvmeMoP6lE3s4fXZhz2viUsZigsA9PLJTVC7w7pM=;
        b=XTcGW3PL1pmXk30uWPRr6VeLqZyY7X6PicCjLnZwXKGfO4hhQqkQb2AxIhIuMpDlOR
         z9gkMlhDuWop+7TbBiFpH171aUdQgxk8kiEE3nedgHcWlidGrQ+JzPzk6/GS6oRWBk/k
         ZTdFwMG0wWYDXkuvl0DZFCOBcfjm/zrQWuR29KcHOsF+DXDrH7b++EjA2Can2bWOw1jr
         N+zsfoV+pFDIcql+YLFBiRL/xO1zJp0iCk2MFRrlkDxmZHMtbW5lZfoDLaTIvGkHNcTv
         EegBJO/rMC1myN13XVMwUIEnixYYxDEIF0Ae9E8fk5O/GCR7ESL8g8dkMbzZQCDoNFWA
         IMJg==
X-Gm-Message-State: ALQs6tBimq5Je70t0ooXOiuwNaz0kia+lSMPdxilBCdyuvmuQeG2Tg/y
        wqpTRPYNBWmeRQXtYuT87VKzFxELP5HrVd9Cxpc=
X-Google-Smtp-Source: AIpwx49aj5Qka4Ze0MQzN5FjRo6Wbqmp8KjmhE784g87QVpObZM2tXMzfQZ6WT5Oz2ZwMvxqT29FOUZQNlIUZuYU9Xw=
X-Received: by 2002:aca:4a53:: with SMTP id x80-v6mr13269622oia.228.1523808294228;
 Sun, 15 Apr 2018 09:04:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Sun, 15 Apr 2018 09:04:23 -0700 (PDT)
In-Reply-To: <CAPig+cQHzB3zLqhRmDKuYk_w8283202x80BcuH7Mu3NqL95cZQ@mail.gmail.com>
References: <20180326165520.802-1-pclouds@gmail.com> <20180326165520.802-4-pclouds@gmail.com>
 <CAPig+cQHzB3zLqhRmDKuYk_w8283202x80BcuH7Mu3NqL95cZQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 15 Apr 2018 18:04:23 +0200
Message-ID: <CACsJy8Drekqn7J0S1F1awaxwLGzrhHy8eUgGQqKAsT-eL-wmMQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 3/5] generate-cmdlist.sh: keep all information in common-cmds.h
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 9, 2018 at 6:59 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> +awk '{print $2;}' |
>
> At one time, Junio expressed concerns[2] about having an 'awk'
> dependency in the build system (in fact, with regards to this same
> generation process). Whether he still has such concerns is unknown,
> but it should be easy enough to avoid it here (and below).
>
> [2]: https://public-inbox.org/git/20150519004356.GA12854@flurp.local/

I'll stick with awk to avoid too much headache with regular
expressions (replacements are welcome though). We do use awk in our
test suite so it should be ok (who builds git and runs it without
testing?)
-- 
Duy
