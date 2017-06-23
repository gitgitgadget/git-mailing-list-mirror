Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 477F420282
	for <e@80x24.org>; Fri, 23 Jun 2017 15:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754541AbdFWPNo (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 11:13:44 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34612 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753528AbdFWPNm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 11:13:42 -0400
Received: by mail-lf0-f52.google.com with SMTP id l13so32658568lfl.1
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/D0wFo6JWTzjjJzYzPkKZp0H0wSJjbVvnbP/7sBpISw=;
        b=MBeFLKNZyuP4mkjF4KhE7tj6a43t09z6/d73fs3il2iraIc83jDmt30u1pOgIeMm7W
         ZmuNIdmTv5/f3LOnL1fkB9cm/w7tM7N+hcH0YCH3Uos6gKL+YwLzRF7p9A3xG9UIbynH
         HbyEVRqcqNGAlyhkD2gOh5QEUxr/p+eIK7LVRKZgnCMfJtc6RieaHfCVs3/Vm1st2ADz
         KVoxvL20U1RFo+kiCoX+q0Hoom0LEDPKCLzAasBFtcHotqHATxAEYCRuopkbeMaQvwT+
         JuoaNxAkIqco95tFTm/19pC06CJFJZt9v19o9NWYRTKZKNU5ayy2uDS7ytWvcSw9b9jK
         C3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=/D0wFo6JWTzjjJzYzPkKZp0H0wSJjbVvnbP/7sBpISw=;
        b=FCyQ4ghabEcxcKFlsZ10n3C5fGWIk4geebNJZjqToL3P6YCoFvLMAmOE57lkCrFhHc
         dCHIXH+ZJATbK2ekd5PVNiPRqM0InIck3eWyoBOouBpxnmG77ebgVmqHb7bkJyGrAybT
         QngJjI3Evn13m06aJc+t11urhAUZJME/1zlaYw8n2ORxMT6chAtMl0FnypSq4XAVCjxC
         q1A3pnk84OAP7siXqEf/4zt6T/U5uIXYwyXYcEETZvzrs8thW8g6lFNlkX/TQv4xNekw
         JkKqRo3Zi5N/HoQeLuUd9D5KBQbvJo0kEzInfu1mVJmef/ZaDqcEh/HDp5blvCFHsgQN
         Qt5g==
X-Gm-Message-State: AKS2vOwiYqqR41m24IaAkywDWkZAYCbEet0cD32813qexvKE5Kqp/ZGj
        UiR7/807WVb8UZ9DU9M=
X-Received: by 10.80.166.101 with SMTP id d92mr6569307edc.132.1498230820740;
        Fri, 23 Jun 2017 08:13:40 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id f40sm1592738edb.2.2017.06.23.08.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2017 08:13:39 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dOQHC-0002Me-Ht; Fri, 23 Jun 2017 17:13:38 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] strbuf: change an always NULL/"" strbuf_addftime() param to bool
References: <20170623144603.11774-1-avarab@gmail.com> <20170623145102.h7rt6zaqajfzuhsk@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20170623145102.h7rt6zaqajfzuhsk@sigill.intra.peff.net>
Date:   Fri, 23 Jun 2017 17:13:38 +0200
Message-ID: <8760fmka8t.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 23 2017, Jeff King jotted:

> On Fri, Jun 23, 2017 at 02:46:03PM +0000, Ævar Arnfjörð Bjarmason wrote:
>
>> Change the code for deciding what's to be done about %Z to stop
>> passing always either a NULL or "" char * to
>> strbuf_addftime(). Instead pass a boolean int to indicate whether the
>> strftime() %Z format should be omitted, which is what this code is
>> actually doing.
>>
>> This code grew organically between the changes in 9eafe86d58 ("Merge
>> branch 'rs/strbuf-addftime-zZ'", 2017-06-22) yielding an end result
>> that wasn't very readable. Out of context it looked as though the call
>> to strbuf_addstr() might be adding a custom tz_name to the string, but
>> actually tz_name would always be "", so the call to strbuf_addstr()
>> just to add an empty string to the format was pointless.
>
> The idea was that eventually the caller might be able to come up with a
> TZ that is not blank, but is also not what strftime("%Z") would produce.
> Conceivably that could be done if Git commits carried the "%Z"
> information (not likely), or if we used a reverse-lookup table (also not
> likely).
>
> This closes the door on that.  Since we don't have immediate plans to go
> that route, I'm OK with this patch. It would be easy enough to re-open
> the door if we change our minds later.

Closes the door on doing that via passing the char * of the prepared
custom tz_name to strbuf_addftime().

I have a WIP patch (which may not make it on-list, depending) playing
with the idea I proposed in
CACBZZX5OQc45fUyDVayE89rkT=+8m5S4efSXCAbCy7Upme5zLA@mail.gmail.com which
just inserts the custom TZ name based on the offset inside that `if
(omit_strftime_tz_name)` branch.

That seems like a more straightforward way to do it than passing the
name to strbuf_addftime().

>>  /**
>>   * Add the time specified by `tm`, as formatted by `strftime`.
>> - * `tz_name` is used to expand %Z internally unless it's NULL.
>>   * `tz_offset` is in decimal hhmm format, e.g. -600 means six hours west
>>   * of Greenwich, and it's used to expand %z internally.  However, tokens
>>   * with modifiers (e.g. %Ez) are passed to `strftime`.
>> + * `omit_strftime_tz_name` when set, means don't let `strftime` format
>> + * %Z, instead do our own formatting.
>
> Since we now always turn it into a blank string, perhaps "do our own
> formatting" could be more descriptive: we convert it into the empty
> string.

Then we'd need to change this comment again if we had some patch like
the one I mentioned above, I thought it was better to just leave this
vague enough that we didn't need to do that.
