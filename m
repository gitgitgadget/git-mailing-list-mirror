Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19BC91F453
	for <e@80x24.org>; Fri, 28 Sep 2018 21:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeI2EUS (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 00:20:18 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40197 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbeI2EUS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 00:20:18 -0400
Received: by mail-yw1-f68.google.com with SMTP id z143-v6so3264610ywa.7
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 14:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nx+VxArVL04szQx3/RGXgQECXRppHW4Z/1fAUUXU9SA=;
        b=S5ceQPIF3MY8t9g5jDgPUtfsybG8Y7USFOhDLJvcZrFQ0hDK5anhE+otxwxk/bAkb6
         mvEIP7OctkTi/IhHmsZp5fbBdK1bnnN0E3K3kMPok/6mzvocCRyIShEoyjtyQ00CH5YE
         e013uwiZHy/1DbgaTNEuJq/Faoi40tuF+fpKQoIJGJmJfc1dRWlRnoEBKkCkRaxoO9pN
         UUbuBJ69oa0SJu977KzzYnN3fgNZK2/BgalahvxMnIJQWYeXkzGkba0CEKWw9X6JJuLy
         AAiPan7zq/bXvBWijh5A/piRHl2ae9XaV7eQOlWyjn57q3hDwaqZdkIZ70nyC5q3JW1F
         9JAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nx+VxArVL04szQx3/RGXgQECXRppHW4Z/1fAUUXU9SA=;
        b=DnNjsSaAIPog6VAp/buyZmMfT59Hcpo+TpGQFGFlauiKQjUej6Hyn2dAmOxFC82N/q
         sdZ+BcoWpvrkOd+swwgIeioszag3t8I1oS+MaDkX9Yg9/xIy3/aSo2CitUvWzniUquzo
         rW9NLkNznc/bj5tPkI4pC3sV6tYmdfmVJ1mmZ9uFwXd7jmQXjZbEHizhPfny+pErlVuA
         3/JexsQXhue/KbbjBN7uaByfo8buBqdNmJIogyGfu4dS+kvxGcqkWhfiEf1+bHvRvngH
         TjudqTp+iqeFDceq7KmLHk3hPDYvGpjSh0Qm4pdC/qv7siJFOjLffUaDbjnebfi+Qoln
         IcCw==
X-Gm-Message-State: ABuFfoibYP3TLe2gzqML9+Yixrq9LygtOaEz+EkwwoEOV2d8pFxaGY6L
        ExKNjRlz+rDTk5b2g0lHt5mCAQsWwusnJpqTu90R1g==
X-Google-Smtp-Source: ACcGV63igzqQeH0H01GoU5FVerBwHTMGGcVzNWpa7e38qwtD50E+rmA2Ssa7vUcTm427+GMG+VGux2A8A/FXu2IwGZw=
X-Received: by 2002:a81:5bc6:: with SMTP id p189-v6mr327786ywb.370.1538171675668;
 Fri, 28 Sep 2018 14:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq5zypefcp.fsf@gitster-ct.c.googlers.com> <20180928173033.159192-1-sbeller@google.com>
 <xmqq4le9b8p6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4le9b8p6.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 28 Sep 2018 14:54:24 -0700
Message-ID: <CAGZ79kbV6QjsFKcD2uG_P9j1AvzSNQSi-_jXGQ9w0YU9fjhEGg@mail.gmail.com>
Subject: Re: [PATCH] strbuf.h: format according to coding guidelines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 28, 2018 at 2:42 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > The previous patch suggested the strbuf header to be the leading example
> > of how we would want our APIs to be documented. This may lead to some
> > scrutiny of that code and the coding style (which is different from the
> > API documentation style) and hence might be taken as an example on how
> > to format code as well.
> >
> > So let's format strbuf.h in a way that we'd like to see:
> > * omit the extern keyword from function declarations
> > * name all parameters (usually the parameters are obvious from its type,
> >   but consider exceptions like
> >   `int strbuf_getwholeline_fd(struct strbuf *, int, int);`
> > * break overly long lines
> >
> > Signed-off-by: Stefan Beller <sbeller@google.com>
> > ---
> >
> > Maybe this on top of Junios guideline patch?
>
> If we were to do this, I'd rather see us do a very good job on this
> file first, with "We are going to use this file as the best current
> practice model for an API header file" to begin its log message,
> and then recommend its use as the model on top.

I started going through that file and undoing "the naming all parameters"
and additionally started to remove any obvious parameter name
(mostly the first argument, that is of struct strbuf, and sometimes
was called sb or out)

But it seems in addition to all this we also want to re-read the
documentation and make sure it reflects the API accurately and
describes it well.
