Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04BFC1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 15:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbfA3Pjz (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 10:39:55 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:42349 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfA3Pjy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 10:39:54 -0500
Received: by mail-io1-f46.google.com with SMTP id x6so19685246ioa.9
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 07:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lpy/NG0EE/lSchG/UvbhNvzSOAeog+VBtHz28XgQHq8=;
        b=k1ZD1rAg5k4DKdT2DjhkLYwsX+uOMhF+59pY/cJk+4RyTq4E1RycURq+7rSRsrPZ16
         mXiCgMWmCUNRwDpCUDH7Jmal48KXRe8i4Q9E5oHyuqht0cXWaLDGJUsxkkmCQp0jqkgX
         KrAIIck/COV05LRarSUXsrqe+xasxTMJReAZfSGh5qLHFx03LIe701SBcO+J2JTUBLMk
         j6q05SUDvD8uj4TvNtAYjK3s3rF2eTnsfqY9mWwnryHKpXaXrKFu3crYptSDdojZl/Z0
         uu+u3yS9j1d7v3np8gQJSwGIX16obMiox/nvHMBJbVclUvxs6tFe+NsAStM4rk/Csdzr
         0lDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lpy/NG0EE/lSchG/UvbhNvzSOAeog+VBtHz28XgQHq8=;
        b=KoHXN5VpQHYbrmBr+bNvtzy4vMC4Ya0KE7ypcji2HmlXl1lwKd6Ab85WK+tQn1qzL1
         HBHW1QaQVjYWE48z56ce6cyRWgejQjH+nrt3zI3OzRqRYf2s9suGLEKGKjLHVNxmAeQR
         DbobGv0+pN1HGzbNi+GE2uWSXoKClVIf2H33CcJZCMqDBNeFv9s3NddW0XQk168T3Y0j
         C3Ojhm7k2yyRQhDLu2aQvA2qb5RdS6g8mUS9EFe8/9d6RLU4a00MTRQqd5x4eu1lHz0r
         maYOirl1EwCkiLEcBrVlXH+QCNhZZsrE/E4Z8tbu7gUHRE37rwx/Qo5MWOcpyWD/F9jP
         z1kw==
X-Gm-Message-State: AHQUAuYBj5UzwgArSMhS53ZTF+80NHg/1JTkSu3k365GjqmEjpxphQpc
        9IXHHhLsTPS2A6MyWs6zHz5VhuHlV0YflhHGS8c=
X-Google-Smtp-Source: AHgI3IYqPU1ig43SENja0zw6XJzXNk0SzacxqVCvXAFiWQqVA5G46dkEvJAtBxxXwcCPkZ2GbJJcQXFgoPKQBFpOJcc=
X-Received: by 2002:a6b:2b07:: with SMTP id r7mr3181241ior.169.1548862793834;
 Wed, 30 Jan 2019 07:39:53 -0800 (PST)
MIME-Version: 1.0
References: <ba0549c5-25f1-efcc-e49a-d7e76be73fe3@ramsayjones.plus.com> <00e08dc3-a610-0429-e819-1d29d0ddb81a@jeffhostetler.com>
In-Reply-To: <00e08dc3-a610-0429-e819-1d29d0ddb81a@jeffhostetler.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 30 Jan 2019 07:39:42 -0800
Message-ID: <CAPUEspgs795iM3nseKYOD0RFcAh2qCdq-zVOYkTBVjO2zPe6zw@mail.gmail.com>
Subject: Re: [PATCH] trace2: fix hdr-check warnings
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 30, 2019 at 4:30 AM Jeff Hostetler <git@jeffhostetler.com> wrote:
> BTW, how do you find these?  I ran both "make sparse" and
> "make DEVELOPER=1" and it didn't complain about these items.

$ make hdr-check

available since ebb7baf02f ("Makefile: add a hdr-check target", 2018-09-19)

Carlo
