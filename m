Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C832D1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 16:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeIQV5M (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 17:57:12 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:46912 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeIQV5M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 17:57:12 -0400
Received: by mail-io1-f51.google.com with SMTP id y12-v6so11946760ioj.13
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 09:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z8rovyCqUGG0VmdLA3xtaqEYiFR0Z47jYycjCSVSONc=;
        b=ku1EhslhYDrWNMyVHMT/v1rnGFQ35aEew6PNeUQ2x92+e4sgHiQN0qVTx8wo/3gY1W
         q3r1yXRs4QxUn/b5OtnqcQv0a+6hFxg+JRaENMl6UtYzagTlP/1XXynecIaTbcc2BGK+
         3hDfxl2fxQPPSYtd4LR531/PJRHk6WGcSuwqOvXVkF7rcTjV8lCvB2lR4gUzeCs8lper
         +XKU2icXp7dmhqIIKIR31dJoAunInX14WO62W5QH/6aDrcpyIcsSAKzt7WaX/QKbo/Rq
         yYHQOlz2J4byOJZYFsGAkGwLeaS1Z13WkMJWiKcUT7NjevChmzh3GqxScBglX842cQZ4
         1sUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8rovyCqUGG0VmdLA3xtaqEYiFR0Z47jYycjCSVSONc=;
        b=VscJOPxSXILV/Ya7/okjLzTVMqgfjRnY1RUoJ67c61dPHU8/++BwihDbZu21QcB5Ft
         RIAck2DgTk+Lf1vTP3UcJj/qyWjycdT9cFzpHNQUpO/Yy1V9ktCNqhH1L1xKGOOmqiS3
         9e9I7XpyN2Pn43QESQvuvQaafEntGqjMNlYE82Hm1evpENgRlkVNzAoyIotlVmJlA2E7
         4VH1xmJHXzvRTlZmuNR7BZXopOoIIoRWZbsTfNuiO2pSG+BXjMKW/UnR+z7AF/RSk5jW
         8sOzwUJqB57xJFiJKVPKTVZBS2ylxDtZfHVqfnXgb2rCWLUveOlGovR8p9MDOdF9ry22
         RT+Q==
X-Gm-Message-State: APzg51AUNPt16SvHiQcJLk01qVRx6bp/UMag6xlylojcjFzImRSjUTBj
        2fHEE/b35I+wxmmBphOs+ZdWaBO4P6cGE6cZZRo=
X-Google-Smtp-Source: ANB0Vdb5c61qCifJZbQzWxqTfdBA7aW8ISqLZK8V90IhgWGqlxGUmj3sdV5G9t4taoQFvCJIf9wR1wvJBYSjiE86n4s=
X-Received: by 2002:a6b:9885:: with SMTP id a127-v6mr19897063ioe.282.1537201746392;
 Mon, 17 Sep 2018 09:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180917015259.GA26339@sebastianaudet.com>
In-Reply-To: <20180917015259.GA26339@sebastianaudet.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 17 Sep 2018 18:28:40 +0200
Message-ID: <CACsJy8CAyXAaax8dSPUUzTFvpKVG19FDives3JthL4hBxgf=6A@mail.gmail.com>
Subject: Re: [Bug] Pathspec matching breaks the add command
To:     smaudet@sebastianaudet.com, Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 3:55 AM <smaudet@sebastianaudet.com> wrote:
>
> The following:
>
> git add -u :\(glob,attr:-someAttr\):src/**
>
> Produces an error that, according to the source code, should never be visible to the user. This attribute/pathspec *should* be supported according to the documentation provided by git:
>
> fatal: BUG:builtin/add.c:498: unsupported magic 40

Brandon, b0db704652 (pathspec: allow querying for attributes -
2017-03-13) added attr support to match_pathspec(), but this add.c
manipulates pathspec directly and (I think) does not support 'attr'
attribute, which is correctly caught here.

I think we need to update the parse_pathspec() call in this file to
declare 'attr' not supported. Then we get a friendlier error (or you
make this code work too, that's even better). You may want to go
through all parse_pathspec() call and make sure that if the pathspec
is not consumed only by match_pathspec() then it should reject 'attr',
otherwise we'll get this "BUG" again.
-- 
Duy
