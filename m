Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFF3D1F404
	for <e@80x24.org>; Fri, 13 Apr 2018 00:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753200AbeDMABN (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 20:01:13 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:56126 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752604AbeDMABM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 20:01:12 -0400
Received: by mail-it0-f49.google.com with SMTP id 142-v6so1099655itl.5
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 17:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=VsMjO5fvlXHY08ENtg8y2XWHIfd5AhzROaHx2ipGnYU=;
        b=cLTtPZK/BRZvGkdfV3bJQrDZ/r4n1gGHSQ1p44sAQsBsNF0+oeJYQlDKu3Ip8UZ0BS
         sNXXroqJKSSRb+hRbTucXGRXn9PcFyK8U7HrxEV8FAgqSPFArYzdXBUhfyujSvg28Dnm
         wK9bF/Uu0KVqh2X5YTY8+RdEojzV0cKMiinAI+hbdeeAeiq0Z9FeHkxq5xFslwdqiNKf
         /9Jr9vAc8/w8kgrTA+d+Idrwbt+LM/Ft7fdtR4Ku9HtpgkwdZQOOlvPoWJKEuiYAU4Vs
         Xz/D2TKyHIpEw1tsSmk9Li8fLvjcnes3KW0GGldAuyBNxblQZJ8owiGXRxayJSSeEvT6
         eUVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=VsMjO5fvlXHY08ENtg8y2XWHIfd5AhzROaHx2ipGnYU=;
        b=DBEEsCVusspxUTY1nXuL7gEn4xLvH9Z4OytmV5aju2RXsZ+bKWz0MBNu3PEZNNscNS
         QNL0ieWEV0025a+J09BeZ/L6yewXfOoxnaPWrTOx36CRZjm6xtXfvOP2eTXdQQUl6wb6
         XYQBOEsjXKHJsJog22KOZx0uT9tLwPv8fVWac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=VsMjO5fvlXHY08ENtg8y2XWHIfd5AhzROaHx2ipGnYU=;
        b=pvn49b1xLT9IzTYBng+uXILJOw3phgrFVG5kOD2MTDQsgqgSyIHtUFR1v/fHl3mO+W
         RoHCxV+/BfKkdgqDGIXYIRwLJZa7AkJy03x2hdxzKtqhbT4wKRc83/3+2q6G/F0rmDaB
         1VXckg8p0yAJUmOtgAzvkyrXm17tGBqSgdSzjk+Y7dAW1FoHRws8imyqy2dABiYWpFlD
         nPMwcw+4eKpOca3ck37bObN7IvPLKZVcJCGMHAI5DRn5iu4Lxl2XdtjdKt+bVI2r3Y40
         PBcSZjawicPZeiqEa3l2u7ErtXl/58ReXVQ06wnKUe5yjb1qSBgwWYoH1t5Fl1xKKaBY
         kzug==
X-Gm-Message-State: ALQs6tBqmxzG35ZjcwVC0JyfeK4w0KJU4U/+mUcj9RCjO3NdHjMeSp7l
        YHXsePuvMdDR15TWU+B7kOQNnLpKup7eRY1lCEQ=
X-Google-Smtp-Source: AIpwx49SkJVKGLYLhnztI27y5pbjB42WA25K6xXKFHUL8JfQEEgjsy3Fs5PQ74oBS7rx2PByHaU82IzZhf88F0vhubk=
X-Received: by 2002:a24:7693:: with SMTP id z141-v6mr3084774itb.113.1523577672042;
 Thu, 12 Apr 2018 17:01:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.95.15 with HTTP; Thu, 12 Apr 2018 17:01:11 -0700 (PDT)
In-Reply-To: <CA+55aFw5mpEcEpPTOWych-kjNLc8pEn8FdjJHe2u7HUBBLy-Fw@mail.gmail.com>
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
 <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com> <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com>
 <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com>
 <CA+55aFwM2CaafNGq8_=GkYAw9inpm-4xcyHUmKprLv4Gb3-aVg@mail.gmail.com> <CA+55aFw5mpEcEpPTOWych-kjNLc8pEn8FdjJHe2u7HUBBLy-Fw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Apr 2018 17:01:11 -0700
X-Google-Sender-Auth: Z4Ee2LWYPB0mLIlF-qTprVZs7Hg
Message-ID: <CA+55aFwwVZDetd-SobOzzLQW4_GEwm3krxEGR+cpqzkzK-yiwQ@mail.gmail.com>
Subject: Re: Optimizing writes to unchanged files during merges?
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[ Still talking to myself. Very soothing. ]

On Thu, Apr 12, 2018 at 4:55 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> [ Talking to myself ]
>
> Did it perhaps mean to say
>
>                 path_renamed_outside_HEAD = path2 && !strcmp(path, path2);
>
> instead?

Probably not correct, but making that change makes my test-case work.

It probably breaks something important, though. I didn't look at why
that code happened in the first place.

But it's nice to know I'm at least looking at the right code while I'm
talking to myself.

           Linus
