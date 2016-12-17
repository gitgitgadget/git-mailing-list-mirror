Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B5281FF6D
	for <e@80x24.org>; Sat, 17 Dec 2016 07:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbcLQH5C (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 02:57:02 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:35766 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbcLQH5B (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 02:57:01 -0500
Received: by mail-it0-f53.google.com with SMTP id c20so32074553itb.0
        for <git@vger.kernel.org>; Fri, 16 Dec 2016 23:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4X16ZTPx6aczWmux7UxT/vnVopiMMunBjvWcydKLEss=;
        b=KkjCc7WNuHI3QAL6MyvK2gNi3uvbY5W0XY0clQ+26Ri3yXHtlaZjyPcRQ/YoS5Nnv6
         2qWCtW6HYs3WeStuT9heBCTxgXgHEZ2deVcoM9jDsdreeYrUCN+S1OSbizs9j4BCa8vZ
         +pWhyQkkE8DkSCoAcy+FQZz0oCZZ9Rd2ZKDqDs956Ru3EULUOHKW59CKCO5sMWdi+AbJ
         jGCTSoa/lPfnZ59Rw8HKewFptsqtSUUPfKQVZds++nEduJztU7wqCo/dO7eEKsLVaEFC
         EsYSfe0kALlF7c4KdHbhuq99dG65Nv8egRIfsgaIpva7lUKfTA1YqUkoOE+2LaoTC7NN
         vu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4X16ZTPx6aczWmux7UxT/vnVopiMMunBjvWcydKLEss=;
        b=bVpRCXtMIE7/HwDTmsyfY+HQ9nvaw4/yIP8XF5kYV6pfQuOiiroDh9XZNWBLXLGfjC
         X0gpgzJAtRzMGfnw8uqnGZ83hm2w/1HvIi/kD2H2hMAdEpwyWTTSnMTBX/E/4awklyz/
         EKRVtaVzOTXUx0+/HxV+JR0xiM0ahO6XO5/LPtoN3l9RteKHmA3L7mti1o7bBaK6uSAQ
         2udfG9i2sfH59IHKR8FPkbsLNwxIGAJMkcwHqdmKV6jQVSTt03mOgZRUapFzQ8Ox2BZ1
         moZjV0+BoNSGa9cq8xKWmfb6ES2dhi/37NcptmzU+N0ZSizlYwPqi1A1i+HvjcZRE82N
         Utvg==
X-Gm-Message-State: AKaTC03NkIV2vLa+tcy4qvb2BIofPKJlxZgQlP0yX+CtlZpwKdg5Y/e2LQVSlIx+yRpCqJVuc4NgZATvgkv28w==
X-Received: by 10.36.26.148 with SMTP id 142mr7763129iti.74.1481961420556;
 Fri, 16 Dec 2016 23:57:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Fri, 16 Dec 2016 23:56:30 -0800 (PST)
In-Reply-To: <xmqq1sxb66t5.fsf@gitster.mtv.corp.google.com>
References: <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
 <20161212195222.rxnabok6amklt2zf@sigill.intra.peff.net> <CACsJy8B52ZDRTUjGLqub_1wELtugv99xbDnBg1PX1LUTb6nVMQ@mail.gmail.com>
 <xmqq1sxb66t5.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 17 Dec 2016 14:56:30 +0700
Message-ID: <CACsJy8BuLu+A8UBd4OOzQkcQOsWYo-jDi2+MKgH5ujvOSdOO8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] alternates: accept double-quoted paths
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Klaus Ethgen <Klaus@ethgen.ch>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2016 at 1:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> At least attr has the same problem and is going the same direction
>> [1]. Cool. (I actually thought the patch was in and evidence that this
>> kind of backward compatibility breaking was ok, turns out the patch
>> has stayed around for years)
>>
>> [1] http://public-inbox.org/git/%3C20161110203428.30512-18-sbeller@google.com%3E/
>
> Seeing that again, I see this in the proposed log message:
>
>     Full pattern must be quoted. So 'pat"t"ern attr' will give exactly
>     'pat"t"ern', not 'pattern'.
>
> I cannot tell what it is trying to say.

It's another (bad) way of saying that quoting must start at the
beginning (so the closing quote must be at the end of pattern, i.e.
the whole pattern is quoted).

> The log message may need to be cleaned up.

Yeah. Next time I'll write more or less "Look at Jeff's commit, this
is basically it" when Stephan re-rolls sb/attr
-- 
Duy
