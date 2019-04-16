Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DEDB20248
	for <e@80x24.org>; Tue, 16 Apr 2019 14:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfDPOOL (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 10:14:11 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43141 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfDPOOL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 10:14:11 -0400
Received: by mail-ed1-f66.google.com with SMTP id j20so7826093edq.10
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 07:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ETI89QpkinjGZXxQjM+aakw8AVV4fXOFmiGYt8dkweQ=;
        b=MqXk8ZY0T1KgUXb2letiw/ktdSRVzKJOgR1EQIOfQtd8m4LAAXxN1hZeKrPnaYPpP5
         hGiJcKYVtrZMlZWemiou2XMQaSJN9uV05FIocJ1rgNvxXukXvQ4dcXzeN1CAtsEvsT40
         sHpRja0bFqJfP8QGYOAqRW3GC5KAzvfIb80uh4xbV3faj/b3TjLWWaJ+sa7HHx+UrqCs
         BpyzP0RSnY5KYgScTZxp4MMpwSa5SqWuRaIXxfOu8JSr4udMxInRf7JcyiXjkQS5J6Pm
         CF3QdnXpdgY1c6v9rXZxcwE/DU4HYn1ve9pQ1DevYrcTelt+3n1v9vOHttzct45z3oV+
         3n/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ETI89QpkinjGZXxQjM+aakw8AVV4fXOFmiGYt8dkweQ=;
        b=LiceYITRgx9Mk4om6lLI5l6ThtMXimmYvaXxsjjdYNOIjFMiFpI9L0nAhlY9rL6Nlj
         Jdw96mrpE2wI99wtvNdT7g6RgjiNqtofVYyRwQUbenPzZzHT9N5sN3ooNiK51cwx5Poj
         nPJnIQz63VTWmD7JyYQs2I/eyII4ju+B4fugz+PWGBjOKXbeWEtQfvpeAUBmGiWPKc7d
         QZaONidFGf9DAT0g6r5irqL8W3EOMSBJABfCy99a2ZVPgQ8iAOG0BLD7dHBnQil3IuB+
         s0I1TNlv2lmIMkJih1KTxGpwLADXRsYv/dWywcZGavyYIvVJ+LnfwJ3kGYLrhmCauhAk
         Avew==
X-Gm-Message-State: APjAAAX2Y2X3jfyLkwjyQd/doKmA+iRuam+xgB0FDbJ9cs1+qN0ppYdO
        t6H8PMocQ0ftPypZSCXh1304ZEwWAoEu03jRr92qSo5b
X-Google-Smtp-Source: APXvYqxzHlivLnRhpJF8YgCwPnB943f/rxaz3Z29cfw6MgApxaigHrtB9CAsCJzzPtU9wi/sBin9OJoO28bvC+4tRWE=
X-Received: by 2002:a17:906:6050:: with SMTP id p16mr43532195ejj.173.1555424048970;
 Tue, 16 Apr 2019 07:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190415210416.7525-1-damien.olivier.robert+git@gmail.com>
 <20190415210416.7525-2-damien.olivier.robert+git@gmail.com>
 <20190415220108.GD28128@sigill.intra.peff.net> <20190416123944.vtoremaitywtmkhj@mithrim>
In-Reply-To: <20190416123944.vtoremaitywtmkhj@mithrim>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 16 Apr 2019 16:13:57 +0200
Message-ID: <CAP8UFD1OuhTrCcD43wLQ8m94sZbVAn_8_r3Jjuj0XTsmvx9BhA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix %(push:track) in ref-filter
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 16, 2019 at 2:42 PM Damien Robert
<damien.olivier.robert@gmail.com> wrote:

> You are welcome. What's the standard way to acknowledge your help in
> the Foo-By: trailers? I did not put a Reviewed-By: because you reviewed the
> previous patch, not the current one :)

We often use:

Helped-by: Jeff King <peff@peff.net>
