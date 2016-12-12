Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF18A1FF40
	for <e@80x24.org>; Mon, 12 Dec 2016 05:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750968AbcLLFf3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 00:35:29 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:33131 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbcLLFf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 00:35:28 -0500
Received: by mail-qt0-f179.google.com with SMTP id p16so67050411qta.0
        for <git@vger.kernel.org>; Sun, 11 Dec 2016 21:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vdNi9k76GRm36ZqchqICEltF1r2YWc7WznuVhq8GLVI=;
        b=FdujUYoP5/Or9SHkna9RSvCtxlLXKABcyHiUqLpa0/KT+yJgvN2IJ373T8r6gzu1mV
         w/zjo1KRWNeUQ/QHn0QI8tYPHnav0yFTDeXoovUzS2lxZJ7DVdoqPHLyTWI6MeqEVwaM
         gTspEj2jmBHumTdXxhbzdbR8XoLUDBNevO2y8AxZcC2RmURHFz7c9SA4y1404lzCX8ml
         HBvMhA2rXkuUkrx+FOnzaLGU4xhCij0U4WurpIoZzpkd7/ViZJUFelTb/VbrVz5W0Vaq
         2vTJRnD3pMXWiHj2SYWO2TFAOCw6c/w5Ipityn4fB2K5ZEqJ8zLPfMsFuOO/ggtaKWmr
         Fmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vdNi9k76GRm36ZqchqICEltF1r2YWc7WznuVhq8GLVI=;
        b=lJaLNhNu8iAfSEb4lONZUuu88LpqCE2S3sDNLITbZvm51wMbWSYWkfFY1pEYsRJELy
         nTbgwP+nVTkdxk+safo7OsFKKSItJXb7f0Ove69/zUs4hUTPzBYDHaj35IOqRLyIf2u1
         qmTrqeSPyBvuHk+eUHF5ekcOltZJDw70zvOBihjs5wYEQpcngMQBEW5IlDnSkIW1OBGt
         AnjtLgni+nNWWfJHUA70SEC2oaAJ9ph+uhiGqtqa4C3ZPc/PW4eYPEo3ZVaxt5mDHgeV
         kz8+FE4qg5g8gdem2+0ffVbR3BnAh7TxByiaiuA/xDXOMh+2q3YJxb+lMtlD7y7RmHN/
         M17g==
X-Gm-Message-State: AKaTC01tU31/yWOwkEgSWqLY7taU2F91gN36xKr8tC5NZ7mJHt7t7hjf8KWuRXga/63naRpiyvIckq4x7xk7kzrE
X-Received: by 10.200.58.65 with SMTP id w59mr76997844qte.54.1481520927037;
 Sun, 11 Dec 2016 21:35:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Sun, 11 Dec 2016 21:35:26 -0800 (PST)
In-Reply-To: <12000496-2191-2915-8a9e-fe7c314c5676@gmail.com>
References: <20161208013814.4943-1-vi0oss@gmail.com> <12000496-2191-2915-8a9e-fe7c314c5676@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sun, 11 Dec 2016 21:35:26 -0800
Message-ID: <CAGZ79kYUbsy2TQ1noqS-9zLVUkQaeJbv6vwxykS+A_HHcxGnCw@mail.gmail.com>
Subject: Re: [PATCH] submodule--helper: set alternateLocation for cloned submodules
To:     vi0oss <vi0oss@gmail.com>
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 10, 2016 at 5:41 AM, vi0oss <vi0oss@gmail.com> wrote:
> On 12/08/2016 04:38 AM, vi0oss@gmail.com wrote:
>>
>>      Third review: missing && in test fixed.
>>
>
> Shall something more be done about this or just wait until the patch gets
> reviewed and integrated?

I have no further comments and think the most recent version you sent
to the list
is fine. However others are invited to comment as well. :)

Thanks,
Stefan
