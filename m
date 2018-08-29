Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D901F404
	for <e@80x24.org>; Wed, 29 Aug 2018 22:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeH3CgI (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 22:36:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38507 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeH3CgI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 22:36:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so33052wmi.3
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 15:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=Iz3y/YzA51LR/pd40lgi+dAaCRlZbczZyMW1x9sAJuk=;
        b=qFdY0T/4tOzl++gShIqChHlXUVaxTonHoUglxl66yEK9oSi3/es8OGYx5WMYabz29k
         owpn0R+0Hpbg2fndPWqmCZrVkprb0nPcpjgvvjaoBpp65uQ2C+O0VZR+lDAdNvdaw6TV
         YLrtEIgYSNU+7AmkygQVi1A4epzQcwUcM1fDW1VkY2NmHunGdvFkRmkYHmS4uZ2lkLwG
         4aS+Ft4QoKLMw5h8fPsoCLOxCFjj2wemAjGUzqf4faPGVkKvVdAXN9GheB4AmFZmaw9t
         0AL9ESDcATO0UGFFdusrd8qkejNfu2dNYquxRTC53gE+VeuhjHwbmV2l71UD6xus4/Kr
         cLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=Iz3y/YzA51LR/pd40lgi+dAaCRlZbczZyMW1x9sAJuk=;
        b=UaknhsW8WULQ/pwXMW2oTVi1DxAy0kHClEAb+UMZD2eatQ6oUznB1b/hlX3JZ1XiKW
         4l/lyqHrnzbK1NTDoGw7FLn8W31Er8MCiD26exQoau1TStI4g1sm8LAKsCDUGlySAIS4
         u7/b7enAUbzwGt2K0SMc1beLeC97B/C9WBorD0IIkJit1qhT9GT3uuHTRwaGxwxqnGtj
         u7ieBKT1Lm0+3+PcPOdFPCpOPmdyIPBap/d/YxU8DGdG7euzR/0b8MaSK2QMHmnVQkdk
         Hqumz+9PCdybVyjbes9qNqLIUVYIW/BIY+KbY8Vs04ny+ocmddp/S+0O8kYOmtoH6MLG
         ZK1g==
X-Gm-Message-State: APzg51CNbQ8w3F+cvcJg/v/0zgW47y/7SmcaixNamzh/RCii+mp5znKH
        LvhVEbHeDzqR3hshnzk8uvWxhqup
X-Google-Smtp-Source: ANB0VdadN4Cc73eeFUzbA1qle5bDMy6qDdTod7NOZqgsQkwOchJU7Nf1jOZ3JxcNTuN8BiVev+GdCQ==
X-Received: by 2002:a1c:9616:: with SMTP id y22-v6mr37582wmd.72.1535582223728;
        Wed, 29 Aug 2018 15:37:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 144-v6sm5720wma.45.2018.08.29.15.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 15:37:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 1/2] rerere: mention caveat about unmatched conflict markers
Date:   Wed, 29 Aug 2018 09:04:35 -0700
References: <20180824221005.5983-1-t.gummerer@gmail.com>
        <20180828212744.18714-1-t.gummerer@gmail.com>
Message-ID: <xmqq5zzsajg1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Yeah that makes sense.  Maybe something like this?
>
> (replying to <xmqq4lffk3ez.fsf@gitster-ct.c.googlers.com> here to keep
> the patches in one thread)
>
>  Documentation/technical/rerere.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/technical/rerere.txt b/Documentation/technical/rerere.txt
> index e65ba9b0c6..8fefe51b00 100644
> --- a/Documentation/technical/rerere.txt
> +++ b/Documentation/technical/rerere.txt
> @@ -149,7 +149,10 @@ version, and the sorting the conflict hunks, both for the outer and the
>  inner conflict.  This is done recursively, so any number of nested
>  conflicts can be handled.
>  
> +Note that this only works for conflict markers that "cleanly nest".  If
> +there are any unmatched conflict markers, rerere will fail to handle
> +the conflict and record a conflict resolution.
> +
>  The only difference is in how the conflict ID is calculated.  For the
>  inner conflict, the conflict markers themselves are not stripped out
>  before calculating the sha1.

Looks good to me except for the line count on the @@ line.  The
preimage ought to have 6 (not 7) lines and adding 4 new lines makes
it a 10 line postimage.  I wonder who miscounted the hunk---it is
immediately followed by the signature cut mark "-- \n" and some
tools (including Emacs's patch editing mode) are known to
misinterpret it as a preimage line that was removed.

What is curious is that your 2/2 counts the preimage lines
correctly.

In any case, both patches look good.  Will apply.

Thanks.
