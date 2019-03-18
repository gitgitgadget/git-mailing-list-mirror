Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4729420248
	for <e@80x24.org>; Mon, 18 Mar 2019 17:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfCRR6T (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 13:58:19 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44028 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfCRR6T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 13:58:19 -0400
Received: by mail-io1-f68.google.com with SMTP id x3so3525546iol.10
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gr0a1EYktu4z++/bWKacleFDHfAAvFQSg3rlaimWp1Q=;
        b=b2q7QZE5suW4Px4YK2SWL1JBdApcegYzoogUnvudLkrOYfhnFcQI0wijKaeeWo7MjP
         3CXL0xzJDK4XPGYyQTkQvIDsySwuted6GXPy+pZ16dgK8JwD3k3FYOaXUiAp2bjmFXca
         c4JgfhoN76yY/68mtVCSIKPMdoVYpWtl1GgjINfeGKRd3Q5REzYBMN3ETr3FYhSU4e6O
         kcSkBSXubt3Rfe6VKCJYuu1mXjz9pTzALVRGfIJuLevFtzL9Fa/nA3+niv0xuctaexzQ
         g3GzDRXz8Vew5RfBLvsRLFjQfeNHJj09QAhl+pocyDu0oyuA6WqC4n1N0HExzJ+dv5lF
         1bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gr0a1EYktu4z++/bWKacleFDHfAAvFQSg3rlaimWp1Q=;
        b=qLP8GBNen0qnh1/pyH2Occ+dIFlw4NhTr90FBnDAY5+zNi6kaorGlRM4Fboddhkh/6
         COjDPD3F7Hg7FuZFog4hsVAZhky0dlvDRWEWPC/aYRrJK0SpCoaPp+0+fi4ELtbajfSc
         Jau7eHzP+yT6KsQpGvq3wpMb4ZeXaoh3GDN42PinQX9zmr4XuYD1s3/jaUSIFGVFYV2n
         e4vkA6NsX1qsWGNZHXKBS5aePAxvkKizbVUDhLsBrDBy5jv7MrwqPexvsnY495QkJaIZ
         1XTDKMb+CuZU419+7QJesE62RlgSbS6aKPz/Ws9TVHvDFcEZ2foYF39SoUWOYkcXrOem
         RhZg==
X-Gm-Message-State: APjAAAUMD/mDUHGlxvngs4kyJCJ9dLJDqaKmN49ZVKH6teRWD6Vsq6tf
        dnzmBNUoKrahX4b0mwV4MBedVzrtDsLiXiousiQ=
X-Google-Smtp-Source: APXvYqw9l+GChGchxGo9rF9j1jQvCJsY6T8D3mWlFHSpS7rqIsqmGY2pl41f5s1gx8prcD6BwI3U8sjfwxwDblfsLQA=
X-Received: by 2002:a5d:85d9:: with SMTP id e25mr13092316ios.31.1552931898262;
 Mon, 18 Mar 2019 10:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190316104715.27138-1-tboegi@web.de> <30c8b265-d6bf-3265-b2ae-029aa60d63e5@jeffhostetler.com>
 <20190318155459.nrog5r5y3ci3bz3x@tb-raspi4>
In-Reply-To: <20190318155459.nrog5r5y3ci3bz3x@tb-raspi4>
From:   Morten Welinder <mwelinder@gmail.com>
Date:   Mon, 18 Mar 2019 13:58:07 -0400
Message-ID: <CANv4PNm_9W9cqUdcx7vxOnafT_BR1grzOwsepLk+m3KRh0btoA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] trace2: NULL is not allowed for va_list
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        GIT Mailing List <git@vger.kernel.org>,
        jeffhost@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> And I couldn't find any hints that va_list and pointers can be mixed,
> and no hints that they can't either

C99, Section 7.15, simply says that it "is an object type suitable for
holding information needed by the macros va_start, va_end, and
va_copy".

So clearly not guaranteed to be mixable with pointers.  And not
prohibited from being mixable either, for that matter.
And, nit-pickingly, NULL might be a valid value representing some
sequence of arguments if the two are mixable.

M.
