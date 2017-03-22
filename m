Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B081420323
	for <e@80x24.org>; Wed, 22 Mar 2017 22:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbdCVW2L (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:28:11 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36137 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752424AbdCVW2J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:28:09 -0400
Received: by mail-pf0-f178.google.com with SMTP id o126so97173143pfb.3
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 15:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Gl6ZPpqmmHdOQpZls62B5rHykcUUoa8ziMavhmgsvUw=;
        b=icJ7F1t+AiJ43GxdQm0Q09WPH3MNXRl3QPqPNuSCpHgR9cNoRdvf1Jq2lCXf0HiveX
         m0HfqkoPyqBtvE5c3cpmdSEzHgxFqZ7T/0fLAOD8TZ9XRSG1umPBYRizMinlIcWc19ek
         XOTc4SNu+6lEtTcnrtpDDEM/8fnYma49ws4bpB7vWSdILP++4rksLqEqhUXWj3J1fAYw
         aVc4kPmHj1+d3ezX20hLswInJEqvw6M9Odu1hnKTtR6PYmW6Rk+HLhcOrgSW3Jng5heL
         ibQERW5sZGQBFS8JGprNUHgw8b4jRB2PSVLGyb8aHJ+vsFrrng7IqYy90ahLhKKOsYqD
         RP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Gl6ZPpqmmHdOQpZls62B5rHykcUUoa8ziMavhmgsvUw=;
        b=mQ1bcx9OIJG87SoTBNukdH5Q3zwmlxZH5wJT+uhrzDPgOVucAsyjPymFLIjISoS2qg
         TsrT8+5GX8/X5xIg18Zj0hshlbGnfy9Cj+0XrXeCQxqKuaxo2SXMZXel+0cK+2syYxkk
         EunDLqEAqlsNeyq39rpxockzrqlPZH6vRpeH/ObM8Nm/n/cCkC4FB8XGuJu9HW7KWZdO
         mjZyslUDLHwyeCo+eFyfswALgykiAkyo6aKsiUMq1pP/fB7gAdBAU7OpIT9uSX7laO3o
         FeE3LncVa2ddvwrgARH+pm8wAwHF1I2R8OjDHNx3V91ck4Th3FlePowcUZXcplC6Z6x7
         WW5A==
X-Gm-Message-State: AFeK/H1gL2ZL9/5giCDDN54oykqFXHN+xjk7MT6yu0mDf4A2ec/zD0pZGAoK0JAfUBP78vy0aeJHTYMVp2HJBbQK
X-Received: by 10.84.231.135 with SMTP id g7mr37642499plk.12.1490221688407;
 Wed, 22 Mar 2017 15:28:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Wed, 22 Mar 2017 15:28:07 -0700 (PDT)
In-Reply-To: <20170322222404.jl3smvai2a3r6tzc@sigill.intra.peff.net>
References: <20170322213953.oddbgw5nfrvmzjgm@sigill.intra.peff.net>
 <20170322214948.12015-1-sbeller@google.com> <20170322215951.f4xbxehzvsd64c4y@sigill.intra.peff.net>
 <xmqq37e5hsg8.fsf@gitster.mtv.corp.google.com> <20170322222404.jl3smvai2a3r6tzc@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 22 Mar 2017 15:28:07 -0700
Message-ID: <CAGZ79ka_kErObJAuJrvFxnEMsESCr_2jc+RQ1AMuWx_urWs1mQ@mail.gmail.com>
Subject: Re: [PATCH] t7406: correct test case for submodule-update initial population
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jan Palus <jan.palus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 3:24 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 22, 2017 at 03:12:07PM -0700, Junio C Hamano wrote:
>
>> >   sq=\'
>> >   test_expect_success '...' '
>> >     cat >expect <<-EOF
>> >     Execution of ${sq}false $submodulesha1${sq} ...
>> >   '
>> >
>> > but I'm not sure if that is any more readable.
>>
>> Yup, my eyes have long learned to coast over '\'' as an idiomatic
>> symbol, but I agree that it is harder to see until you get used to
>> it (and I do not think it is particularly useful skill to be able to
>> spot '\'' as a logical unit, either).  ${sq} thing may make it easier
>> to read but I think the one you did in the first quoted part in this
>> reply is good enough.
>
> Sounds good.
>
>> -- >8 --
>> Subject: t7406: correct test case for submodule-update initial population
>>
>> There are three issues with the test:
>>
>> * The syntax of the here-doc was wrong, such that the entire test was
>>   sucked into the here-doc, which is why the test succeeded successfully.
>
> This version looks fine except for the repetitious repetition. :)

When I wrote it, It sounded more convincing, but we can drop the
"successfully".

Thanks,
Stefan
