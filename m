Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AF991F403
	for <e@80x24.org>; Wed, 20 Jun 2018 17:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932601AbeFTRKo (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 13:10:44 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36377 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932153AbeFTRKn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 13:10:43 -0400
Received: by mail-ua0-f193.google.com with SMTP id c23-v6so197689uan.3
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 10:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3rX4wvPXUnYOVONWxfrRVvwfJbw9o6/BJMGDv0nCcRE=;
        b=GZVXTHMgNJD9W/a+bJ9ZWnJhhfyWGoy6uE0mf8B9akA5uRQ4MMDnSOjI+lERnke8Hn
         H+9QulrCXQ8IKRHc8BGOC1rMzYfb0jYb6qGPw+qp55jqllsxhL3vjXUq7p5nqBAefTcL
         AZ2ZxsiNMSTQmnnwxlX3QQhXAK0+GL3Z6geDuHvd5Wn2OAn2FsTy7PuwotyU2mdkXDKc
         +Jfkebm+MYMzQgcXby6VkOsCr8/Q5bHttKKQGXUmnmaF8tgSx6uv3hYCqjAiQOlxX/FA
         XhRI6/eQqqw1K9LNusYtbQ2PAVe00cHDdskoI0DRaQHDlIpjkPRRWAIkZcQtYWZdLOo8
         qFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3rX4wvPXUnYOVONWxfrRVvwfJbw9o6/BJMGDv0nCcRE=;
        b=llS0OQ1TSCT2Mspfa3J2gkH+VlRkMPDbSNONzhsxr+lYKfOHXt4ObvHFVnsCS1+qra
         fuj/K5/N6Pi2+qE8n9E2IyYcmOaXcVH/LsmLWbvv8T2KVYlZdEAojKe11C7OBtUHDH9z
         52xE/xApJ3HyUqtoYjelTsEkS/5+7OzVMRBZZNhrMe4opAepp5YdcJRb2Nfw7tuk+XQD
         V0VC/ZSfKgryFKqg3d5AuhamM8PCEk+I3tC8ke6JttuP3QiLnqc+lW69vPzVDKCXirkM
         OPSOrcR9/tHRQ0ya9GztXkLdlgT019iSXk9+KDjRFnhhxGx+bm8rJTK93QWVgSF2wsdn
         IpIg==
X-Gm-Message-State: APt69E3PbIJwNjfDyXYQW09nSybfwzouKMP/cXSoWgmgvvsGYcj2x0YD
        Lku/niirUTJdvp10L180rfUOyyP32Vc1HaDBTPE=
X-Google-Smtp-Source: ADUXVKLflG4CBBHiQqkyHsA6cNXJlBUZViNOId9G+eQjQ9MdkWS77HCPzjsRQKAogE2ngiKV7UzaKWGO5KYQaTj9Ms0=
X-Received: by 2002:ab0:57c9:: with SMTP id u9-v6mr14715029uac.94.1529514642525;
 Wed, 20 Jun 2018 10:10:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 10:10:41
 -0700 (PDT)
In-Reply-To: <CAPig+cScoXgSrGQseX_u8SaXo1J-beb-fpZpF8V-rpwH5s-AUA@mail.gmail.com>
References: <20180607050654.19663-1-newren@gmail.com> <20180617055856.22838-1-newren@gmail.com>
 <20180617055856.22838-2-newren@gmail.com> <CAPig+cScoXgSrGQseX_u8SaXo1J-beb-fpZpF8V-rpwH5s-AUA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Jun 2018 10:10:41 -0700
Message-ID: <CABPp-BF0Qg8O3cQm51ptB6c7+CKUa+jND6zHdZsixOUMv+2ZxA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/7] git-rebase.txt: document incompatible options
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Sun, Jun 17, 2018 at 10:15 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Jun 17, 2018 at 1:59 AM Elijah Newren <newren@gmail.com> wrote:
>> git rebase has many options that only work with one of its three backends.
>> It also has a few other pairs of incompatible options.  Document these.
>>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ---
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> @@ -487,6 +510,51 @@ recreates the topic branch with fresh commits so it can be remerged
>> +Flags only understood by the interactive backend:
>> + [...]
>> + * --edit-todo
>> + * --root + --onto
>
> What does "+" mean? Is it "and"?

Yes, it means "and", though perhaps it'd be even clearer to write "in
combination with" or "when used in combination with"

>> +Other incompatible flag pairs:
>> +
>> + * --preserve-merges && --interactive
>> + * --preserve-merges && --signoff
>> + * --preserve-merges && --rebase-merges
>> + * --rebase-merges && --strategy
>
> It's somewhat odd seeing "programmer" notation in end-user
> documentation. Perhaps replace "&&" with "and"?

Yes, good point.  I'll make that fix.
