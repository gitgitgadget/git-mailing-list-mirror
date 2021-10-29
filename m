Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BF6C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FF3960ED5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhJ2SpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 14:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhJ2SpR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 14:45:17 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290F8C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 11:42:49 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id l7so11605574iln.8
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 11:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wwjvv4fI0tVzsTlOaN64wAUDOqaaV7H9vGUe9sNc1W0=;
        b=Y2SagTDULELNK7u2xr2xJRVtZ7AU8do4Be6StSflnh/XsQvrdLdt+XRk+BDzQDFOt1
         V3UQA/z+uH/myuPaO5IN8RR7X3srXy1VVvEhaGiw/09V2l6OBbqGctwF4HaPAO2jbGl8
         51bUFwuv4VckBOvD10rLuH6yOcL4tneAVOsjP8YLOnTXRlV3RcWzupynfJP3jlsUA1vE
         FfV4XCbUhIIB4wUHmqUM1zJKMrbmabX1lpHFoygXkBwAcHGIk97v3bnBxHmJX/P+syYd
         zghhS/v2kmWBF6xx3/YPjy5kwFmg9LKoQilZEEViytkxR7FlwrbxuLeX4q40w1ljhZhd
         IQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wwjvv4fI0tVzsTlOaN64wAUDOqaaV7H9vGUe9sNc1W0=;
        b=cDfKDGqsQJHvDzIIaG9Nd+lpGJ6pga6BKD8mab5vIvQTJ0xAjJLcWR4EU0loxrrOWa
         /7XnjwTJIBfvJ56dzwxLBqQL1ZmCGTug6DSh673ANSVaXhCFJCJzUm/GbXL/sAkOPsB7
         LnN4kJArPl7K2ZlpnZIDdnm9eHNqjdkrPvk06VCIXTAAsvIL4zkTGTqYNJY6BsHK0Jv/
         5sSqIO+39t0FnMqZcYa3/Khtf/mDBxms8vLplsGNgi1ikVLqxg7dFmkAWwqxF6A2r/IS
         n7rhObLLyOVNcgQp4HZU+LRQla+ZO4IBcMNLBoda/Rlken2uJ9+z4FsQYCC7mXV4TW8w
         Z/bA==
X-Gm-Message-State: AOAM530YIJz6uwmHv5VH6oxUHCIhDg2cHJwXc775aP2ZFYkxLSECDjul
        WYtZlIk1io00lgXbiPl+o5eG5wxxuPLQ39bQU/ukOw==
X-Google-Smtp-Source: ABdhPJxOmtvUs3JHe94bd9a21w7IIvELnjhkSHlGZsmPzQIpeo2F/5CcchZP8zYKoalASUZqqHaxfsEAJsTUz4ygxfI=
X-Received: by 2002:a05:6e02:15c9:: with SMTP id q9mr8946157ilu.298.1635532968349;
 Fri, 29 Oct 2021 11:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1052.v4.git.1635288599.gitgitgadget@gmail.com>
 <pull.1052.v5.git.1635461500.gitgitgadget@gmail.com> <c95b3cafcd66ce64a140b767664a8fc98eb535bf.1635461500.git.gitgitgadget@gmail.com>
 <xmqqa6isohve.fsf@gitster.g>
In-Reply-To: <xmqqa6isohve.fsf@gitster.g>
From:   Ivan Frade <ifrade@google.com>
Date:   Fri, 29 Oct 2021 11:42:36 -0700
Message-ID: <CANQMx9VXRnLjMgvYM63tq8aecvWNd-0cxi+XMSkkwm-iUeX+1g@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] fetch-pack: redact packfile urls in traces
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ivan Frade via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 28, 2021 at 4:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com> writes:
>

> > +     len = strspn(buffer, "0123456789abcdefABCDEF");
> > +     if (!(len == 40 || len == 64) || buffer[len] != ' ')
> > +             return NULL; /* required "<hash>SP" not seen */
>
> People may have comments on hardcoded 40/64 here and offer a better
> way to write it ;-)

Latest version uses the_hash_algo->hexsz:

+       if (len != (int)the_hash_algo->hexsz || buffer[len] != ' ')
+               return NULL; /* required "<hash>SP" not seen */

Thanks!
