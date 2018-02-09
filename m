Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D69E01F404
	for <e@80x24.org>; Fri,  9 Feb 2018 20:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752719AbeBIU5w (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 15:57:52 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43666 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeBIU5v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 15:57:51 -0500
Received: by mail-wr0-f195.google.com with SMTP id b52so9490190wrd.10
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 12:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4udurA3/HU9fWH3HEp3VSfX5snjfZsD/Lus7db5NFfM=;
        b=El1n2o3h0gXwTTZtUcpUPOmcjMVxkmDR+j9MR3Afjpvqc86zHiyziyxpkTV3jQ7gmu
         W2meuDVKQHJEjzxE2z5tFx+BWyif+fbrbsXUVViN1qy/ibWaiJlo+HlNBa7zBLwEx2d6
         YZpCo0mvqXUBNhY3ybgC9v05/lFPh+b1628f/AnUmRffMn0iuQ+kpNJTm0/nLLlg9C5B
         BQBC5qY6ojEI4J2NQP8DVFseFIHVhJH+vNabIha4j57srTbrIax9Sijm1RKC0Om5Uywg
         QTFOHqmugNX5nUjYS46zKK/11jRImUZerVYm4hubH+3l/VqxvAS386Dv5GQIsWkhLiyv
         PN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=4udurA3/HU9fWH3HEp3VSfX5snjfZsD/Lus7db5NFfM=;
        b=J66sN+5IYJTfr6HLYaMoAQBcXfC95RGBy7ZXIissQ4ROWqrD2K7uRDFG/biPmiXBqG
         YJcUdxisgot7ZsVqNCTBb7ABMsdmT8JNGeCh1+e+2Km2fdIYJTXjcYlKnyGqqAdhtBEN
         LvmFYtbUtBcwc0z5WFzfEI9PzxX/k7k9cHyLRVz8Dt0J+rOToD3DJtD7Jp3NJKpUxcup
         GU3oAxGh8T96qaQUY5TyivyBK62A4FMnimDbnB7cbOHhkzfsGuMA6lY0Nr/TgBUOAxcx
         QRZS1Tj3IjrCLu7zJRTx+U7IvGu5hU0ITLCIQ7s4WjfaQdkdSVH+e4zyJFw6NBm5Rd/r
         1U1Q==
X-Gm-Message-State: APf1xPAaxqrBe0j3uumeOAGAYmU6r1GgEe8KQZtvQUNZK9tTCHs2f8o3
        UXBDNcKntdw+YWzT5whRU8A=
X-Google-Smtp-Source: AH8x2255OjYQUR+541aBFV6AVunvy7hG9uDiDO1QiTwIWW9U+x1qSLcoBhpcWuSejXnxJ07moZ3WHQ==
X-Received: by 10.223.164.23 with SMTP id d23mr3565342wra.72.1518209869658;
        Fri, 09 Feb 2018 12:57:49 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 81sm3169274wmi.26.2018.02.09.12.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 12:57:48 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 11/17] fetch tests: fetch <url> <spec> as well as fetch [<remote>]
References: <20180123221326.28495-1-avarab@gmail.com>
        <20180208161936.8196-1-avarab@gmail.com>
        <20180208161936.8196-12-avarab@gmail.com>
        <CAPig+cS4xhyYSnUHXshB=2SPYELe_HXUwxL-OGU4zx=PMFXdqg@mail.gmail.com>
        <87zi4ikjyr.fsf@evledraar.gmail.com>
Date:   Fri, 09 Feb 2018 12:57:48 -0800
In-Reply-To: <87zi4ikjyr.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 09 Feb 2018 21:05:00 +0100")
Message-ID: <xmqqfu69x4mr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>>> +               key=$(echo $1 | sed -e 's/^remote\.origin/fetch/')
>>
>> Faster (thus more Windows-friendly) assuming that $1 always starts
>> with "remote.origin":
>>
>>     key=fetch${u#remote.origin}
>
> Tests fail with this and I'm not excited to be the first user in git's
> test suite to use some novel shell feature, no existing uses of
> ${u[...].

s/u/1/, I think.
