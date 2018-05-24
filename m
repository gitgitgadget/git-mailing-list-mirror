Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15D471F51C
	for <e@80x24.org>; Thu, 24 May 2018 10:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030521AbeEXKgM (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 06:36:12 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38135 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968579AbeEXKgI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 06:36:08 -0400
Received: by mail-ua0-f193.google.com with SMTP id y8-v6so753976ual.5
        for <git@vger.kernel.org>; Thu, 24 May 2018 03:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VJr+w0BFKcEjUcDDK2qGs52pbNkiinNNMNXLW/d//00=;
        b=X5Kpn7FAKSnzqLaSMa9Lhj8C5NDYqPTH/P11A2/hyk3zcovjknCy2psZD/sGhJ9m6A
         pyh/XcPuTGiMnVJVuNQjq4P7OLUuUlYQRMwlzHxHNglr1E4qWBBz+zSCHlJ4Wcw7aHLJ
         h4gevDR6IfmRnZVYAaR59bQMFjZhWl3Bd3hZgYhcoj+DDR1ezcclv6wdDxSbO0R1WXzb
         k7tleOOwvdZpIsI3MOReEcUiWYQSzqR3cZMw/KVlbBAW6QhCERpZQhAnEWlag7Hqpxf/
         VHyMfSmXDxNpdLyWz8IZIGodgMSKi8aa4A+uFfdwmH2757GdwaaGsdQZkWJFQ7yFbiri
         1oIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VJr+w0BFKcEjUcDDK2qGs52pbNkiinNNMNXLW/d//00=;
        b=UwffIxf4brYjsg61uGx9jmfRBvsSlSgbM4Y71mMlsdtqzCQ/OkHB61cR8R1M4MsStr
         gQyazDWP1YlC+cHu28uAJsrFb0kdmrUvAZdgVEQojsrSY/YHFroKXfQ1FpWqJF2wIo9v
         PLGIhDfPzthHotfCc087NWcju8kwwSJ2dJHLrZq5YgOwFRT12CstDXougjkYAn9M3v+b
         tlIJGqkfvMNvJEiV7tCV6//e3TxuDCpN8VHNQjqz3xTK4QiduXq8tEVAmzTy4j2B3fzC
         L/5Q9sQBWw80itqS9p1+/PthQzd6pB16qg48bpKCFe/9g+Z0h25UBj8FaN+ABF/uUQiN
         u+nQ==
X-Gm-Message-State: ALKqPweFayXvqaTN+QYKM5GFQaRpX7QzuIk27XN0LvA2WDuEbnVsmnlo
        i40oXy8ORWek0lxWSe7ui33AHUDlZOC85ipxaMU=
X-Google-Smtp-Source: AB8JxZreHzMPY91d7v8JIwYsloM91TASaYZ0md1aK+bBMYNja40YfcsZDI5lE3cGh/PccFKQuJ1MQcDJYhdy9g00+b8=
X-Received: by 2002:ab0:19cf:: with SMTP id r15-v6mr4508650uai.149.1527158167205;
 Thu, 24 May 2018 03:36:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:16d4:0:0:0:0:0 with HTTP; Thu, 24 May 2018 03:36:06
 -0700 (PDT)
In-Reply-To: <20180524100507.32305-1-szeder.dev@gmail.com>
References: <20180524070439.6367-1-newren@gmail.com> <20180524070439.6367-3-newren@gmail.com>
 <20180524100507.32305-1-szeder.dev@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 24 May 2018 12:36:06 +0200
Message-ID: <CAM0VKjmTVTA8JV=_6EVDGi1mD3VJXSJL7GxQJ0G2F5SaH-HWDQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] t6036, t6042: use test_line_count instead of wc -l
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 24, 2018 at 12:05 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ---
>>  t/t6036-recursive-corner-cases.sh    | 102 ++++++++++++++++++---------
>>  t/t6042-merge-rename-corner-cases.sh |  99 +++++++++++++++++---------
>>  2 files changed, 134 insertions(+), 67 deletions(-)
>>
>> diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corne=
r-cases.sh
>> index cfe6a99771..3e659cff28 100755
>> --- a/t/t6036-recursive-corner-cases.sh
>> +++ b/t/t6036-recursive-corner-cases.sh
>> @@ -65,9 +65,12 @@ test_expect_success 'merge simple rename+criss-cross =
with no modifications' '
>>
>>               test_must_fail git merge -s recursive R2^0 &&
>>
>> -             test 2 =3D $(git ls-files -s | wc -l) &&
>> -             test 2 =3D $(git ls-files -u | wc -l) &&
>> -             test 2 =3D $(git ls-files -o | wc -l) &&
>
> Here 'git ls-files -o' should have listed two untracked files ...
>
>> +             git ls-files -s >out &&
>> +             test_line_count =3D 2 out &&
>> +             git ls-files -u >out &&
>> +             test_line_count =3D 2 out &&
>> +             git ls-files -o >out &&
>> +             test_line_count =3D 3 out &&
>
> ... but now you expect it to list three.  I was about to point out the
> typo, but then noticed that you expect it to list one more untracked
> file than before in all subsequent tests...

Hrm, not all, actually, because there is this one exception:

>> @@ -426,10 +444,14 @@ test_expect_success 'handle rename/rename (2to1) c=
onflict correctly' '
>>               test_must_fail git merge -s recursive C^0 >out &&

Note that the file 'out' is created here ...

>>               test_i18ngrep "CONFLICT (rename/rename)" out &&
>>
>> -             test 2 -eq $(git ls-files -s | wc -l) &&
>> -             test 2 -eq $(git ls-files -u | wc -l) &&
>> -             test 2 -eq $(git ls-files -u c | wc -l) &&
>> -             test 3 -eq $(git ls-files -o | wc -l) &&

... so this  'git ls-files -o' already lists it as well, ...

>> +             git ls-files -s >out &&
>> +             test_line_count =3D 2 out &&
>> +             git ls-files -u >out &&
>> +             test_line_count =3D 2 out &&
>> +             git ls-files -u c >out &&
>> +             test_line_count =3D 2 out &&
>> +             git ls-files -o >out &&
>> +             test_line_count =3D 3 out &&

... therefore the number of untracked files here remains unchanged.

>>
>>               test ! -f a &&
>>               test ! -f b &&
