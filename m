Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9880A20281
	for <e@80x24.org>; Thu, 29 Jun 2017 17:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbdF2RuG (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 13:50:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35664 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751936AbdF2RuF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 13:50:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id u23so3926431wma.2
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 10:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6TYPzfneM7y1nPaseIQcVnjxFgRB4vePLKflM9HGuLg=;
        b=tCMyzORKLNo2qr6MJmwFvKe/AoAc968xRN9JtWiO3YR0PWkUDf21CwBhWBH1OBo6Rr
         SWUsjAAG7shDer9xekDJDsj0fXKPa5MVOYkHc2wyK+SgsqMUZ1RWgWM3+xfyt3q44eQx
         FmJsbmdXjrgVz41BiULPDDYB+eG1Y3zVYpHIhOHuAIl8of7kNGbFyv0jFvBTVF0Cy+/V
         YO1HD4lFdvso5PcBqTs8yW1Cj6kPRHPSu0T3SfIo7z/EFwYhZI9zzXli/Yy3c6pQLv+4
         /TNkKYignMDXh4gkaSU5hIuPs5xwabiXZSETJXBe8S+2/gdqrmcJ9OuzfwNPFAckd1h4
         7K4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=6TYPzfneM7y1nPaseIQcVnjxFgRB4vePLKflM9HGuLg=;
        b=hcz74R0xlUrsk84p9dh2YcOaFYnuy7dLZhoorAx/9hEEDw43PiO51KNEZGqFeJyZkV
         zucrboOav80XG9m1zT/JrKbXsWHLPn89Wd6XBs+QfEbl7kkIsayVirtQwv4GtXMR+m8R
         nOaGnTHqGovPHGv4xt0FD6MXlEe0tm+qdHsexi36qq9vGp9pY7wbkkmr94HL2KPrVW6M
         WUBIYL9cSiLq7YoQ0rvvJFN9dflUvKHSH4zkMxB3JrLAQgfNbgLf3MjnmuX72B+h3HnO
         ac6KoeMTv1R1ZfwxK2/8V9XCJ28c5LZiYMn7oqiyD3EylDK7vxBC241zDscEvSDrbT/C
         5qYA==
X-Gm-Message-State: AKS2vOztf94gx7cIRucdwWssqS3UNmYEQp3N1W1InBZ9fjS6CWv4eVSQ
        4bhlPgfRDQLqeg==
X-Received: by 10.80.159.78 with SMTP id b72mr2559795edf.150.1498758604125;
        Thu, 29 Jun 2017 10:50:04 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id s45sm927823edb.19.2017.06.29.10.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jun 2017 10:50:02 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dQdZq-0001Uj-8L; Thu, 29 Jun 2017 19:50:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, J Smith <dark.panda@gmail.com>,
        Joe Ratterman <jratt0@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH 2/5] grep: remove redundant grep pattern type assignment
References: <CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com> <20170628215809.23060-1-avarab@gmail.com> <20170628215809.23060-3-avarab@gmail.com> <CAGZ79kb0a2EEALj3eEAMUwQSWamhGuOFOYPrWbv6uCtC7EXgAw@mail.gmail.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <CAGZ79kb0a2EEALj3eEAMUwQSWamhGuOFOYPrWbv6uCtC7EXgAw@mail.gmail.com>
Date:   Thu, 29 Jun 2017 19:50:02 +0200
Message-ID: <871sq2k7jp.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 29 2017, Stefan Beller jotted:

> On Wed, Jun 28, 2017 at 2:58 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> Remove a redundant assignment to extended_regexp_option to make it
>> zero if grep.extendedRegexp is not set. This is always called right
>> after init_grep_defaults() which memsets the entire structure to 0.
>>
>> This is a logical follow-up to my commit to remove redundant regflags
>> assignments[1]. This logic was originally introduced in [2], but as
>> explained in the former commit it's working around a pattern in our
>> code that no longer exists, and is now confusing as it leads the
>> reader to think that this needs to be flipped back & forth.
>>
>> 1. e0b9f8ae09 ("grep: remove redundant regflags assignments",
>>    2017-05-25)
>> 2. b22520a37c ("grep: allow -E and -n to be turned on by default via
>>    configuration", 2011-03-30)
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>  grep.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/grep.c b/grep.c
>> index 29439886e7..6614042fdc 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -80,8 +80,6 @@ int grep_config(const char *var, const char *value, void *cb)
>>         if (!strcmp(var, "grep.extendedregexp")) {
>>                 if (git_config_bool(var, value))
>>                         opt->extended_regexp_option = 1;
>> -               else
>> -                       opt->extended_regexp_option = 0;
>>                 return 0;
>
> Instead of having a condition here, have you considered to remove the
> condition alltogether?
>
>     if (!strcmp(var, "grep.extendedregexp")) {
>         opt->extended_regexp_option = git_config_bool(var, value);
>         return 0;
>     }
>
> This does not have the effect of not assigning the value in case of 0,
> but it may be easier to reason about when reading the code.
>
> This would also conform to the code below in that function, that parses
> grep.linenumber or grep.fullname

I didn't think about that. Good point. I'll do that instead in v2.
