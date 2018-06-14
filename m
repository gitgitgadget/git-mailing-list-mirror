Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ED281F403
	for <e@80x24.org>; Thu, 14 Jun 2018 07:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbeFNHg2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 03:36:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33644 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752748AbeFNHg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 03:36:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id z6-v6so2042466wma.0
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 00:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=sbtQ876CCSBbtSegYeNCr8vzwvqd92snrJFRmRNRQ7o=;
        b=md2a2XqUgvNYgxDaw7wcAkFqF+YAxYtH+KkCxdwhKEyvn7zOHr9Vta6G9VjFQ+XuVV
         TdFiyHo5e+r3l0QDap0Ah7gwkT/rBpi+tCWu36/LOAjalRDWxETZMLQboIpLtgIfYeoX
         l4yyvl9NOmTO8JbbLgSLfJm8Sybo5ahf3Bz2a0HfXsOoXeBD3YcMlw2sy9mWP77rCbwV
         Q7wtPXF1WJW6z8xfGj3qFiCoBH2UF2c4XSbBQDpscaaXCUpgs0iBwxeAfrRX8GhHSKH+
         t6jRzzlBY9UChI03KklDsgdXlizKZAlz44bB588EDlnoDZMPk1TAVLZm8lWISoiyJ/TB
         4ShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=sbtQ876CCSBbtSegYeNCr8vzwvqd92snrJFRmRNRQ7o=;
        b=X6SycGGC98Ckh1fWvm/U+7YKy2LouIPSTDAvLr/0nTYAj46vDiHyRLXtJJD9xjb1fH
         adQDq70oWlAcgJ3QcnBJaYi6eSTHtC/1VnvMECX+k7MG/HIuKvWebYSNRpQQJTrvN9ko
         vMcLv25gRNkaOdhpNiZ/A3X1D11lamu789NJUxd+Dxlh8U5xJfaqiaBhUDrmwZM6ScbZ
         mYMMDBg00VLrFJfo15MIMI6+eqUshldY+ZnX96F6kVaNNwy1MwjuQEoVB64Z5pKDAf8q
         L7qTJFnHi4ocvmkr9AEaqYLS77EMPu4tANmDTMG8bcHAAkf9Lc58Q70l4Md9X5OJ0gF9
         uvDg==
X-Gm-Message-State: APt69E1l750mgDlS1hDH24ugasKW9J4+wBDS94SeU60cpQiBogbNaxfP
        E5N9q6sphimEY4hgOZG3u8o=
X-Google-Smtp-Source: ADUXVKI8tX64RmQa0qpwQ5RnAAcQcZ4WDv1GK9Q2dYeg4hohiAT/HJPVAvFYsT4dGnUtCpr/97+eFg==
X-Received: by 2002:a50:b2e1:: with SMTP id p88-v6mr1554042edd.297.1528961786681;
        Thu, 14 Jun 2018 00:36:26 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id y26-v6sm1895939edr.51.2018.06.14.00.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 00:36:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, johannes.schindelin@gmx.de, jrnieder@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 19/20] abbrev: support relative abbrev values
References: <20180608224136.20220-1-avarab@gmail.com>
        <20180608224136.20220-20-avarab@gmail.com>
        <xmqqvaan95os.fsf@gitster-ct.c.googlers.com>
        <871sdawcmh.fsf@evledraar.gmail.com>
        <xmqqa7ry5n9h.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqa7ry5n9h.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 14 Jun 2018 09:36:24 +0200
Message-ID: <87zhzxvmyv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 13 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> E.g. here's a breakdown of my dotfiles repo:
>>
>>     $ git -c core.abbrev=4 log  --pretty=format:%h|perl -nE 'chomp;say length'|sort|uniq -c|sort -nr
>>         784 4
>>          59 5
>>           7 6
>>
>> I don't have a single commit that needs 7 characters, yet that's our
>> default. This is a sane trade-off for the kernel, but for something
>> that's just a toy or something you're playing around with something
>> shorter can make sense.
>>
>> SHA-1s aren't just written down, but also e.g. remembered in wetware
>> short-term memory.
>
> That's a fine example of what I called "supporting absurdly small
> absolute values like 4"; I still do not see why you want "negative
> relative values" from that example.

Because hardcoding -2 is very different than setting it to 5, because
the -2 will scale to the size of the repository, but 5 is just 7-2 where
7 is our default value.

So, in general if you want less future proof hashes by some
probabilistic metric (whether you use core.validateAbbrev or not) you'd
use -2 or -3, just like you might use +2 or +3 if you'd like to have
more future-proof hashes (especially with core.validateAbbrev=true).
