Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 957921FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 17:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbdFMRbq (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 13:31:46 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:38756 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbdFMRbp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 13:31:45 -0400
Received: by mail-it0-f51.google.com with SMTP id l6so33363458iti.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W4MnsQ1K38BdSOjUmWRIDtoBYYoL1ObLg4QI5iwxF2I=;
        b=vMweMMjixYd+JQaEHRBk3DXatUX5VHIfUh21MPw3a8hnFaMuI7MJsZiTx8ark752bl
         my267NK5BYqV8d9OdKGBNDVntv/+M5zmEZPF5Oksh1LFL7sYa0HaO93mdg8Yxg6sDtl2
         WWt1evN9bcRl1NdeNM/64QFcP71tritA/BKcB9GrymrI+ufWnalSxSBMQ5BuzAorf53F
         rcR2tIn7rbpdyhHHQ9NRQtX9v3F0ydEpvMkKeaNpYMlydLLjhUnvFHiknPp4MdsAUUBI
         4TQR85pNRjgUBdcad/FI+N0KUgtdO5tRVmF7qaBNexZqRyDu859MYBIZ0IZLoeBlWSQF
         J+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W4MnsQ1K38BdSOjUmWRIDtoBYYoL1ObLg4QI5iwxF2I=;
        b=eAp1fNu+9XkRRQlmYsECP5XAg0D3rtV3AyYRISNUlO7iTPOSttBMuwsyg7vHA3Bugu
         SMSZvx9cLnEECq8zybVofZvOAYtB5Se2XJRgtiO0qOMAhpzWGM6b2e0hoIL98jTa8H69
         qtdVnfjFiSLLvmqxsPTSgU7vZDYkiMFF9hIvxrEINTzphoRojbnx+zAu9BwclrtPguYH
         +OHB/43ozH0U8azyZwGxHeMWMHm0WE7V9EKQP9rIPfDtksHJmctcOwc8JdqeHfl3lyDC
         X21+qC2UioQ6Jyx5qlmlQ1dwLfXni4WYO+17jjeZeCzpr6b7u05E3TDqC1ghSi5SyTvP
         GD3w==
X-Gm-Message-State: AKS2vOyD0IYAZ7wx8C4vLL6iBleS00QL0rClXplffpnwlUZlZ0ggYF4d
        u8a8qfzt8ufZXy9KKPxPgVcF9ic5VVpc
X-Received: by 10.36.233.198 with SMTP id f189mr1316905ith.94.1497375104680;
 Tue, 13 Jun 2017 10:31:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Tue, 13 Jun 2017 10:31:23 -0700 (PDT)
In-Reply-To: <xmqqwp8f7r01.fsf@gitster.mtv.corp.google.com>
References: <0102015ca23f0488-7423db93-b65f-4214-8221-af6a1bb4c2e5-000000@eu-west-1.amazonses.com>
 <0102015ca23f0529-c860f75d-e3bb-48b0-b2c0-502f7ab9d667-000000@eu-west-1.amazonses.com>
 <xmqqwp8f7r01.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 13 Jun 2017 19:31:23 +0200
Message-ID: <CACBZZX5e1cGKeHZhA1vWebdZek=a+TdYzXc5GuXaDi8SpL1YXw@mail.gmail.com>
Subject: Re: [PATCH 2/3] branch: add test for -m renaming multiple config sections
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sahil Dua <sahildua2305@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 7:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Sahil Dua <sahildua2305@gmail.com> writes:
>
>> +     cat >expect <<-\EOF &&
>> +     branch.dest.key1=value1
>> +     some.gar.b=age
>> +     branch.dest.key2=value2
>> +     EOF
>> +     cat >config.branch <<\EOF &&
>> +;; Comment for source
>> +[branch "source"]
>> +     ;; Comment for the source value
>> +     key1 = value1
>> +     ;; Comment for some.gar
>> +[some "gar"]
>> +     ;; Comment for the some.gar value
>> +     b = age
>> +     ;; Comment for source, again
>> +[branch "source"]
>> +     ;; Comment for the source value, again
>> +     key2 = value2
>> +EOF
>
> Indenting using <<- would make it easier to read.  I.e.
>
>         cat >config.branch <<-\EOF &&
>         ;; Comment for ...
>         [branch "source"]
>                 ;; Comment for ...
>         ...
>         EOF

I should have added a comment for that, I can't find any portable (but
suggestions welcome) way to do that and preserve the indentation, so
the test_cmp would still succeed if the moving/renaming function
munged all leading whitespace in the config with -\EOF as opposed to
\EOF.

>> +     cat config.branch >>.git/config &&
>> +     git branch -m source dest &&
>> +     git config -f .git/config -l | grep -F -e source -e dest -e some.gar >actual &&
>> +     test_cmp expect actual &&
>> +
>> +     # ...and that the comments for those sections are also
>> +     # preserved.
>> +     cat config.branch | sed "s/\"source\"/\"dest\"/" >expect &&
>> +     grep -A 9001 "Comment for source" .git/config >actual &&
>
> Where does 9001 come from?  Is that just "an arbitrary large
> number"?
>
> Besides, "grep -A" is quite unportable.  Would
>
>         sed -n -e "/Comment for source/,$p" .git/config >actual
>
> work equally well?

It's just a sufficiently large number, I thought -A was portable
enough after grepping the test suite, but on closer inspection it
turns out those were all git-grep invocations, oops. Yeah all I need
here is all lines after a line matching a given string, so that sed
command works, will fix it up to use that.

>> +     test_cmp expect actual
>> +'
>> +
>>  test_expect_success 'deleting a symref' '
>>       git branch target &&
>>       git symbolic-ref refs/heads/symref refs/heads/target &&
>>
>> --
>> https://github.com/git/git/pull/363
