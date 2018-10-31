Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EB7D1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 12:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbeJaVwr (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 17:52:47 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:35585 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbeJaVwr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 17:52:47 -0400
Received: by mail-ed1-f47.google.com with SMTP id d6-v6so5423832edi.2
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 05:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=x/MQZnxK0nbcGWQpSP09VvRlE784aN4Awfbgu4LrGsw=;
        b=qAMdEA4a9/h8SiW4IZzWaR7ZXAazzOxNp5CCN7UbamnNmOC4mIG4YW+xZ42MMRl4Nr
         87Hugl7aQoKeaIsAhfNwguIVIyWWCSU7fAO3M2NP2dFS2iKK4JADmdDWFziqxn5t6Zzr
         s7B0iUMAKowrgmh/G/L5vH7mXC3GdAnL5iqH2fXiYdIsAPYa8AK+Udq2EyT2kCagVV2L
         47lNX+EqaMGpPnL3UbsURhD/eoDC2x3NTRYkaY7oKYAbI8MIvlCH9UaTZz2QpPT2aos4
         2ypou3HzIWMKCc1EtMlETMorOPtxVo/0fPDIIIApMlQUt+t6kU258svXQwE4u4yXZO+6
         8cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=x/MQZnxK0nbcGWQpSP09VvRlE784aN4Awfbgu4LrGsw=;
        b=L7pAqx8Ce76Xb5XJWJGaSgB7FFOhwyx6t+GicrGjeSofxV9mPflTnWX9WpUWfkqoZ5
         7z5RdzvyPy4eD7khlm9DeZrH7edK5zRJ3D2DtyARedZlQNcwkl14JmQGXacr2idZh31k
         P3d8uNJQvImTQyEunlyPyMEZKErMohxD5FviqghPkODVNRcIpXLcjNkZ3Z8D40czKy3j
         5ocMTGOnr3Bdwk2LVeCBBXJORrg6nGhJq5esu1/yl+ls0Xmm4Z2q5uG9+8QBa4i/l8OM
         u7B3Ki3/Ev3EYVcRiTp4oUHOPdXXG0S4wTteF3s7ah6ZvjRLkbAk2pE5g91BubgFOKUp
         +LMg==
X-Gm-Message-State: AGRZ1gLg9VVaMKdCfYNSDCX1TQIJj0we9WQ4TufvBrFGwS6czokeUC7C
        W7Vk5WOy5ZrGRSIy8Kp2sB0=
X-Google-Smtp-Source: AJdET5dX1NuYuuF+zfR/3LzO3h2Uqhzsd8g3lOS8cuUctORWKHm2Kn772v5qMHBZ8+BLf2UJ1YdiWA==
X-Received: by 2002:a17:906:25d3:: with SMTP id n19-v6mr1423094ejb.191.1540990491557;
        Wed, 31 Oct 2018 05:54:51 -0700 (PDT)
Received: from evledraar (223-81-146-85.ftth.glasoperator.nl. [85.146.81.223])
        by smtp.gmail.com with ESMTPSA id i5-v6sm432116edi.29.2018.10.31.05.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 05:54:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [RFC] Generation Number v2
References: <6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com> <xmqqy3ag13us.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqy3ag13us.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 31 Oct 2018 13:54:48 +0100
Message-ID: <875zxil1if.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 30 2018, Junio C Hamano wrote:

> Derrick Stolee <stolee@gmail.com> writes:
>> In contrast, maximum generation numbers and corrected commit
>> dates both performed quite well. They are frequently the top
>> two performing indexes, and rarely significantly different.
>>
>> The trade-off here now seems to be: which _property_ is more important,
>> locally-computable or backwards-compatible?
>
> Nice summary.
>
> As I already said, I personally do not think being compatible with
> currently deployed clients is important at all (primarily because I
> still consider the whole thing experimental), and there is a clear
> way forward once we correct the mistake of not having a version
> number in the file format that tells the updated clients to ignore
> the generation numbers.  For longer term viability, we should pick
> something that is immutable, reproducible, computable with minimum
> input---all of which would lead to being incrementally computable, I
> would think.

I think it depends on what we mean by backwards compatibility. None of
our docs are saying this is experimental right now, just that it's
opt-in like so many other git-config(1) options.

So if we mean breaking backwards compatibility in that we'll write a new
file or clobber the existing one with a version older clients can't use
as an optimization, fine.

But it would be bad to produce a hard error on older clients, but
avoiding that seems as easy as just creating a "commit-graph2" file in
.git/objects/info/.
