Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DE681FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 19:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbdBFTgD (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 14:36:03 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33101 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752037AbdBFTgC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 14:36:02 -0500
Received: by mail-wr0-f196.google.com with SMTP id i10so3647675wrb.0
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 11:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SH2mrGHzbI7nqffKcPLLjpqRzPZbi1N6mk/jLcK1LDo=;
        b=e2y4ZQWuhQ5h+m2z9O5hgFQJ6I+/S8yaAK0z7oeEjs8VzPaFQ9EcZdAQOGi9r/s6cS
         dp/CfmwPzLn1mBg1ezdWrsgR/ZgUGx9Nnq6eowxEU/HJQuXzm/np6ZuYQTcEJcWQrKtz
         yEBdQW2JaB5n6FhWzVWJdqWs8DxjQkEf14ZBdhIOQq+4WTdTX2vE1EiW2e+8Drp4tDVh
         ULrmYVqy9OM65pHtXmXWDNVy7MTlRUVPCjRi8LpqBZOa35FSlBxlhAuIIXhqwdkisES0
         AjyZ3tYJKswprzVdzdwTqWRg59WDBfN381TgZKfuRLpDjVXwI4MDGZznZJ/eKrWGvbk/
         X7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SH2mrGHzbI7nqffKcPLLjpqRzPZbi1N6mk/jLcK1LDo=;
        b=c+tHVjnUVM1cZIrx6GWNuRsd1CyV6QD29c+jt6xA0d5JYOvpV7K0XzDlXu/CoillDz
         IOC6weyne4BJNUFA4p2G1w0P92UDghM0Ksebt6T7r2wvwg5Z1Nwru6NY1vewS8TZw02g
         rou+5ImW/SD+p3WJfSMSKDY2MgVTM7GiwSbUBvfcuteQBnWBpFLEPC885CSqH5l3hWyv
         RUwQovwqRMF3/A8VPLvaCr7vDJXLD8nCK4jlT8FO4RFggKhfoebVNLMwvZpDiFOVEqpg
         gGi67idJlh/V9U+xntr/vaoZYKWO5a83khe9A5WOLS1b/BzicNfxa49kcLrVZYzT9hKR
         +Czw==
X-Gm-Message-State: AIkVDXL67tMR9IC2XUhxKZ4RPC8lrc95JWKjjEQlzwC361wnSpMzKg/nOlyeAvapZcFNEUU2ExPLyBCFjjde8g==
X-Received: by 10.223.128.3 with SMTP id 3mr10585065wrk.58.1486409760683; Mon,
 06 Feb 2017 11:36:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.249.8 with HTTP; Mon, 6 Feb 2017 11:36:00 -0800 (PST)
In-Reply-To: <CA+P7+xrAVM8C1dnEaY1VnTUwiCzoMzh+rbMqBknyBG27grs-uQ@mail.gmail.com>
References: <20170203025405.8242-1-szeder.dev@gmail.com> <CA+P7+xqhjVQMXtO4gtQ_2VAVd3qrpVLncH6YpFHreVV2mHORxg@mail.gmail.com>
 <CA+P7+xpeyebN3pmSX09Avh1EvYVjALpBCQ9r2==q3SWTu3GMSw@mail.gmail.com> <CA+P7+xrAVM8C1dnEaY1VnTUwiCzoMzh+rbMqBknyBG27grs-uQ@mail.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 6 Feb 2017 20:36:00 +0100
Message-ID: <CAM0VKjm-HQFtDypcWgOdQrLyjAicOVLUsFby5_wE1hvTE1pTRQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] completion: speed up refs completion
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 6, 2017 at 7:31 PM, Jacob Keller <jacob.keller@gmail.com> wrote=
:
> On Fri, Feb 3, 2017 at 7:15 PM, Jacob Keller <jacob.keller@gmail.com> wro=
te:
>> I haven't had a chance to further investigate, but I tried this series
>> out (from your github) and it appears that this series (or the
>> previous series for __gitdir work) breaks "git log" ref completion.
>> I'll have further details when I am able to investigate a it more.
>>
>> Thanks,
>> Jake
>
> At first I had the same problem, but I verified by re-installing the
> completion script and the problem appears to have gone away. I suspect
> what happened is that the original time, I forgot to actually install
> the new version of git, and only installed the completion script, so
> when some of the commands were run with new options they (silently)
> failed and the result was missing completion values.
>
> Once I properly re-installed everything it appears to work as
> expected. I haven't found any other issues yet.

Thanks, that's good to hear.

Still, I'm a bit puzzled as to what exactly might have caused your
problem.  Considering new options:

  - the __gitdir()-related series added the 'git rev-parse
    --absolute-git-dir' option, but only ever used it if you invoked
    completion after 'git -C some/where'.

 - The refs completion speedup didn't add any new options but started
   to use two that it previously didn't:

   - 'git for-each-ref --sort=3D<key>' option, but that's with us since
     the earliest ever 'for-each-ref' version from more than a decade
     ago...

   - 'git for-each-ref' format modifier 'strip=3D2', which was
     introduced in v2.7.1~15^2 (tag: do not show ambiguous tag names
     as "tags/foo", 2016-01-25), only about a year ago.  Were you
     using a pre-2.7.1 version when seeing the problems?

G=C3=A1bor
