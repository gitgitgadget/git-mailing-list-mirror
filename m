Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F0341F406
	for <e@80x24.org>; Thu, 10 May 2018 15:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966279AbeEJPoL (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 11:44:11 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42057 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966135AbeEJPoL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 11:44:11 -0400
Received: by mail-oi0-f68.google.com with SMTP id t27-v6so2144356oij.9
        for <git@vger.kernel.org>; Thu, 10 May 2018 08:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ra+MIW8HshawynnjjmArY8vGATrZFN2JB/5jYU9RMmk=;
        b=fTbLR+9mkyYgJUegtWSaPjsiRgoputK+WWPU/cs7REuilrQX7OqVqFfcQ0dNBP8OKN
         N6Xf5hNZ9FLLRV/HTU7T/XDeJofgqXPKTML3KLnQeRhM+5JaDHxQwHV/DzKY6RNSJbLk
         vXPvIg4+kxQO72GFUPKF1sLUan6CqM6qD9UiDcZfGeo7y10NXeW7Aa1OVJ0JxBR6pKZk
         sgXZ6RpUp3F2Eb+6361LCjNFZD1Nbaat2H6ZfEYPRLGZOb6Ba7UpQGEMBBlYpaxFD2Ve
         gXZpNSUatTqAZ+ndITvGdF9UeXj6QbiXXpsgTNKRvH+JHwOWYqvcCThIWCYXrfl3xvZc
         lIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ra+MIW8HshawynnjjmArY8vGATrZFN2JB/5jYU9RMmk=;
        b=t/YjfAqkCSHgrHCnoYp8o0heRt3Oz27b0PxFoiUvtCvtQPLujxGvDoqulLDAC0Y3qO
         TDIj3Ugll5GpTk4LlG7mqs5UMfDlZ0sa4V13XnRdDmJxhWNt1DLJGxWyp+dFzWlR9Mn2
         k9yu313DCXp/Ppmfe78x7KLaYb+3DIXW6cxqzwAf7v3mDsZEBTE7RZbcaZJVZE7afhiS
         8PfZKmwX+7L2GLaIWz+mByl963NlotAzeRqgI28O2bO1sta7E4yr8nRpHhI8/Wz0RTQP
         Dq3+eYN6aHw45jlSQ6U9i8mR9HX9nqGq2rApcNRy9dwmCHLOzfntKawk5POw/sZ4mkX1
         GyVQ==
X-Gm-Message-State: ALKqPweNP9zJQ6LRq1o0zI8bHfTX5Mm4sqvMwZP72bfikxT0liDHKQmd
        ZaEIBqYZYp5jGxfE5ljKO1HtkTt+0l/DOdvcIK0=
X-Google-Smtp-Source: AB8JxZqsvAwVgN4UXz2g+ybx5VnMMGKurF2m1JOGJaQiYREs6fnEU9cohOxOFyyaBJzX3+3FfEcHltS0azFb8dnVp+U=
X-Received: by 2002:aca:2e09:: with SMTP id u9-v6mr1144878oiu.228.1525967050524;
 Thu, 10 May 2018 08:44:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Thu, 10 May 2018 08:43:39 -0700 (PDT)
In-Reply-To: <CAGZ79kbYuodP12Y2WSwmF+EmStv0pHONwfVbqjDS7Kyhvx103Q@mail.gmail.com>
References: <20180507225916.155236-1-sbeller@google.com> <20180508193736.14883-1-sbeller@google.com>
 <20180508193736.14883-14-sbeller@google.com> <20180508130431.287a9f273a847c375b3b1e2b@google.com>
 <CACsJy8C7N2W821H8YR8VaKdCSOSCDtQi_YT7z8hHNDO-VxJmEA@mail.gmail.com> <CAGZ79kbYuodP12Y2WSwmF+EmStv0pHONwfVbqjDS7Kyhvx103Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 10 May 2018 17:43:39 +0200
Message-ID: <CACsJy8CJu-Og1Mn4Sn+eCyv+KkbJ__21oTYRaMyTdOsjAVxpqw@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] alloc: allow arbitrary repositories for alloc functions
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jameson Miller <jamill@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 9, 2018 at 9:20 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, May 9, 2018 at 10:18 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>
>> If you want to reproduce, this is what I used to test this with.
>>
>> https://gist.github.com/pclouds/86a2df6c28043f1b6fa3d4e72e7a1276
>
> This only applied cleanly after I created an empty file at
> t/helper/test-abc.c, using git-apply.

Right. I created the patch with "git add -N". I know exactly what the
bug is but I'll need to be careful with renaming a bit before trying
to fix this. Thanks for reminding me.
-- 
Duy
