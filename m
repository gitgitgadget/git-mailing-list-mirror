Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 162C8201A7
	for <e@80x24.org>; Tue, 16 May 2017 00:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbdEPAuq (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 20:50:46 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36786 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbdEPAup (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 20:50:45 -0400
Received: by mail-pg0-f42.google.com with SMTP id x64so48425564pgd.3
        for <git@vger.kernel.org>; Mon, 15 May 2017 17:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xq0/Dc4pS+xgTGgyjHuX78DeiGZwIjBEAHVzJe1A0mI=;
        b=XhAAQ31grxRm4ECKODNeOZYlmdaOHVM77Xc8ba/9EyzesJMA1nobTkRIoqZn/i2OJV
         tn8ryAMITpGBIhJmPcSKMUhOK5GIzkVRU4P5aiVHHqKhQLDo/BnP1N8mExEIRVZ2uVRs
         mKq8qbfy808lXxpiCGvcrr47UtQw2l/6eDsE1gLZn3bFjuYyJ/xYTpK//s7U2Ai6Xk+1
         k2nNRNtrSzlw01v+qVgQNR3vg04Nq9+q8gel4WJ6LtcB6A+0F84nOSTb4/wCKgKV2MsK
         XLMb8U8szC+f2Pj4lzKf0DHfrJXYdzrmPvDcQlHVCsCaCQfo8bpsCKsTNnsnwDk7T567
         eJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=xq0/Dc4pS+xgTGgyjHuX78DeiGZwIjBEAHVzJe1A0mI=;
        b=YHuAmNWzKTIu0nz9clSuZibR6bgu84szpEUhquNuDEyCGq93Ek7ac97bEkRYS6yPba
         NqgyHyVZISfh2dqEvjlT7moOrjAA2iu44t11eXjqVfE/SXwHhXS61VnHbfrq1dyqudih
         9yfxeWUCabzRDOLSH13x7S6O969xyaIEC0SbHvhBDN4RJf+kZEg6hc9vEOwq6y50o1s7
         gsBNyHnhtT2LReI563vGqtXKxupHe9JnIK+GGfzR0cYsdxR5rJx4T1Mkv8DeExs8fQFn
         Gc7Y2JoOmSlxVwXLuCw4T7lq+ni2Iju2b2mXWr9YFsfjMUOTZtkKgk7rW5DJQ1nltpRP
         zqAA==
X-Gm-Message-State: AODbwcAllQsRXUWjsTGL9RvSc47HSzf3bdu6CLvMpM/gQLIbOPsvmdtZ
        6o1b8r6ysMeBgw==
X-Received: by 10.99.102.7 with SMTP id a7mr8863543pgc.216.1494895844602;
        Mon, 15 May 2017 17:50:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8dc7:ff72:325b:10d7])
        by smtp.gmail.com with ESMTPSA id r90sm21904263pfl.82.2017.05.15.17.50.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 17:50:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 04/29] log: add exhaustive tests for pattern style options & config
References: <20170513231509.7834-1-avarab@gmail.com>
        <20170513231509.7834-5-avarab@gmail.com>
        <xmqq1srqwwbu.fsf@gitster.mtv.corp.google.com>
        <CACBZZX4EfWCD3rwQbRJ1TokDkH=7EfoepMd_ipHr5NSv9kWOJg@mail.gmail.com>
Date:   Tue, 16 May 2017 09:50:43 +0900
In-Reply-To: <CACBZZX4EfWCD3rwQbRJ1TokDkH=7EfoepMd_ipHr5NSv9kWOJg@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 15 May
 2017 19:38:14
        +0200")
Message-ID: <xmqqy3tx4obg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Mon, May 15, 2017 at 6:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>> +             if test_have_prereq PCRE
>>> +             then
>>> +                     # Only PCRE would match [\d]\| with only
>>> +                     # "(1|2)" due to [\d]. POSIX basic would match
>>> +                     # both it and "1", and POSIX extended would
>>> +                     # match neither.
>>
>> OK.  BRE would match because the other side of "\|" is empty to
>> match anything?
>
> Yes. I'll clarify this. It's not just a POSIX basic feature. The same
> is true of extended and perl. E.g.:

Yes, but "\|" won't be taken as alternative in ERE or PCRE, and that
is why "[\d]\|" would match everything with BRE (as opposed to
others---PCRE matches "(1|2)" not because "\|" is an alternative but
because the pattern looks for a digit followed by a literal vert-bar,
and ERE does not match any because there is no 'd' followed by a
literal vert-bar).

I was mostly reacting to "BRE would match both it and '1'", which
singled out "1" as if "1" is special and gives a false impression
that it wouldn't have matched if it were "7".

>
>     git grep [-E|-P] 'foo|bar'
>
> Both match the same as:
>
>     git grep [-E|-P] '(foo|bar)'
>
>>> +                     git -c grep.patternType=perl log --pretty=tformat:%s \
>>> +                             --grep="[\d]\|" >actual.perl &&
>>> +                     test_cmp expect.perl actual.perl
>>> +             fi &&
>>
