Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 271091F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 00:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbeJGHxq (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 03:53:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45078 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeJGHxp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 03:53:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id q5-v6so17041380wrw.12
        for <git@vger.kernel.org>; Sat, 06 Oct 2018 17:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=YcONVYaHcNROiZk7JE/JGBPUoSmsmza56+mYnVENHcA=;
        b=g22G+gOcbOC+NrzfESTnyt1R04maiAIjpvFbViIsqxGIWIZV1cBLU4tZaalv9kHe8Y
         phqKb45pVUdWOTVvs1ZYsyOk/4Bhx6iT9NhaCgrd4T2yXLK0+jCwlc8dgT7R8Z/Sysf4
         mcV8gfQczv/S1VO9GaYIl9M3Twt6PzTIvIFo+sF2WnLaD1gl7/ZJvXgH2pFQvZV8ovfX
         QnSfB6i+2Y+NceV+I87tAenkE+cJcl5N6pYUs3ppyh57vxorR5FJHaOaR5I0V9Vckpw2
         O3QbjeyKhKM/pTPXeXdw2zyY2jNefuv1u+q9N8/tVkHVs0TovDMUivp9AxNuVEvguUsN
         UFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=YcONVYaHcNROiZk7JE/JGBPUoSmsmza56+mYnVENHcA=;
        b=O6WLsF1bJKgWuyJIwuBzUlJMKUjzIt3kZc/XdNlHh8NZjnxR1i8UmvRgg4rb9FcEKr
         hPueEiTipKR9n1Gl7Wx55Cvn9YqfPJoA/TQ8TAD9jN5+424UqsI8yQ7Uw/23blZKrS91
         27nsDohHU6hcCUKIElsEi7kxDYzu8PAWVPcT5zsvYhMWwNejFmKi+Yg9W1qFPGcgS0+z
         rQ9V0N/+86qzUG3mo1U8uZWwPfzENu/1Q0G0eTVlYBAqENpgq1a8P3hsq3qCBe9ZDYrH
         l0Vy/oEJ4dJpwYPRmpGL9bWixvqRkPI0PHNmh6Ucs+OqluHPL+d7q1GJmIimAKyUYVbK
         4A9g==
X-Gm-Message-State: ABuFfoj2HYmkBp0iGpRy5rxq35RjdIphrgsl+j4/hjw7awd/A19q/+xX
        BUDt41N5AgcNAtaPwTkX1UM=
X-Google-Smtp-Source: ACcGV61rE9XXVlVQyp7i4xu/9arrkoF8RMcODdmbOGyoenoj+OJ6LsC5UIqZ7PTayyjm0ebac8YyJg==
X-Received: by 2002:adf:ee06:: with SMTP id y6-v6mr13005718wrn.318.1538873305478;
        Sat, 06 Oct 2018 17:48:25 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u191-v6sm5859244wmd.31.2018.10.06.17.48.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 17:48:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git log -S or -G
References: <alpine.DEB.2.21.1810061712260.2402@hadrien>
        <CACBZZX6PmG=-8563eYE4z98yvHePenZf_Kz1xgpse0ngjB5QyA@mail.gmail.com>
Date:   Sun, 07 Oct 2018 09:48:23 +0900
In-Reply-To: <CACBZZX6PmG=-8563eYE4z98yvHePenZf_Kz1xgpse0ngjB5QyA@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 6 Oct
 2018 18:22:57
        +0200")
Message-ID: <xmqqd0smvay0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Sat, Oct 6, 2018 at 5:16 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
>> Git log -S or -G make it possible to find commits that have particular
>> words in the changed lines.  Sometimes it would be helpful to search for
>> words in the removed lines or in the added lines specifically.  From the
>> implementation, I had the impression that this would be easy to implement.
>> The main question would be how to allow the user to specify what is
>> wanted.
>
> As far as I know this isn't possible. The --diff-filter option is
> similar in spirit, but e.g. adding "foo" and then removing it from an
> existing file will both be covered under --diff-filter=M, so that
> isn't what you're looking for.

I agree with Julia that UI to the feature is harder than the
machinery to implement the feature to add "I am interested in seeing
a patch that contains a hunk that adds 'foo' but am not interested
in removal" (or vice versa) for -G.  You tweak
diffcore-pickaxe.c::diffgrep_consume() and you'are done.

Doing the same for -S is much harder at the machinery level, as it
performs its thing without internally running "diff" twice, but just
counts the number of occurrences of 'foo'---that is sufficient for
its intended use, and more efficient.

