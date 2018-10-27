Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 657301F453
	for <e@80x24.org>; Sat, 27 Oct 2018 07:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbeJ0QUo (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 12:20:44 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36576 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeJ0QUo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 12:20:44 -0400
Received: by mail-io1-f65.google.com with SMTP id o19-v6so2118386iod.3
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 00:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/gkbzviPUANSCGhnw9S2TU1tf1qyYrTOkTN/0qfGgHE=;
        b=MM60jSuy8Z2nzFgQBQ6CeR+iaIJwlMwu0soqW7qUVGGKLYLTeS0JypIo1uNo3RLyry
         QJh672O8s48GlVwVgWWaBpUBoLozWIZ2qtouE69vrmMUngKHTo+74fOhmq+bUtjPsiDQ
         85q3O9DzxHIWcXQ2A+BHAfHjbR5rYVy09inJd+gV5kjPrJa0apqw4zbGY8rHPH4bcpwW
         BD1sx+se+mkQlKIGnjGYwRF5Sm3ke96FzO7pZJMHh2c6TGICyr92dkYTglozPgycPGhC
         Ya/kMWMz1MajS1bx0dTquAfdXHQ2K40nqvFUWZXRDeWzeKIaLFosYhO06tpErpgGjYXc
         8Exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/gkbzviPUANSCGhnw9S2TU1tf1qyYrTOkTN/0qfGgHE=;
        b=Ei/DirYWJcRo4JYQMLhwXDdNN90ieMPJKDUp5emwZTribmKpiy1tsMgR80CudkBMnl
         zNypEWJ3ZkXXyekYdlIy2kybBQkO+YBi6D2+3+T4XgbZlInqVzD0tWtxWfdgBr6WispR
         bRXcaXC2UzxRbiJ1rtZntcc+qvv2KiTGGHlhSa9mSL9aM52ftDK/TyF5UX57EU908bzx
         Bcyg3VVVLt8jJDrBo3XPcX2ijAKZD48UG6OBLMlHfTxPiCm1u2Buqu/wYIVJ6Aep+3fT
         UH4tHEciCCIR3C5ZJW+XyUnAvBkqpWJ4TcnTAxs5Q1WLLbNQUv/+tDxT8icvJr8VcOXE
         NFuA==
X-Gm-Message-State: AGRZ1gKKPWWxllBhONf+PNnNybaQcqSZNaJR/5fVUq+kOF1lUzxAAsum
        5hdhzRkQBWjtkYjEAP12NR0bbRaHt0BwUXzzrWcwaVTx
X-Google-Smtp-Source: AJdET5eavYc/uVOAIWOURmOYftwOiTyzmiOPZbsRJ6Jf5KtCyORNp2peyKyhfLZ7+UI8sIw4elIg4QNXRC2iEpxdmaI=
X-Received: by 2002:a6b:9383:: with SMTP id v125-v6mr3387021iod.282.1540626040135;
 Sat, 27 Oct 2018 00:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181027071003.1347-1-pclouds@gmail.com> <20181027071003.1347-2-pclouds@gmail.com>
 <20181027073125.GB26685@sigill.intra.peff.net>
In-Reply-To: <20181027073125.GB26685@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 27 Oct 2018 09:40:13 +0200
Message-ID: <CACsJy8AA8ABmV5myBEETWP0uSNNFjvUP5mE705OV9=JtyHgTkg@mail.gmail.com>
Subject: Re: [PATCH 01/10] thread-utils: macros to unconditionally compile
 pthreads API
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 27, 2018 at 9:31 AM Jeff King <peff@peff.net> wrote:
> > +#define pthread_setspecific(key, data)
> > +#define pthread_getspecific(key) NULL
>
> We expect to be able to store a void pointer here and get it back, which
> should work even for a single thread. Do we need something like:
>
>   extern void *pthread_specific_data;
>
>   #define pthread_setspecific(key, data) do { \
>         pthread_specific_data = data; \
>   } while(0)
>
>   void pthread_getspecific(key) pthread_specific_data

The data is per key though so a correct implementation may involve a
hashmap or a list. It does simplify index-pack which has to fall back
to nothread_data when pthreads is not available. But with index-pack
being the only call site that can take advantage of this
(run-command.c probably will use real pthreads library anyway), I'm
not sure if it's worth really implementing these functions.
-- 
Duy
