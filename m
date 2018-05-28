Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED1E91F51C
	for <e@80x24.org>; Mon, 28 May 2018 09:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754210AbeE1Jp5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 05:45:57 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38347 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754194AbeE1Jp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 05:45:56 -0400
Received: by mail-wr0-f196.google.com with SMTP id 94-v6so19242944wrf.5
        for <git@vger.kernel.org>; Mon, 28 May 2018 02:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HayUyhKVC1jV71lVDMj+V/y5mp9NsHvPTMD4HY4DZqo=;
        b=eZhiEhpq4oBP9XIENA1mFqAkU/hqsdSBdwCuG3tcW5DLO4B/7/+AWCvEcLez2FngM5
         al87JU30iDD0rRipB+zGyFGxnr/HLjan6DVCswGY/NYBmhycOjvJ6p9VYDInMugjWC4A
         MWQHP/SfB9lC/4CMRm9eI8HrT9kbSvzuHMZ21D+tcXHPN6RLpIKHksC39fBGyFr994LN
         nFMSMQ7QC9wC3pfwkZtvOBSIagWmab/NmMsU1gF+A6QLpmV4HOALedNHKn1WVPjDXbz6
         E/mkMVYdILAiJJSacDrTVeYbQ5hVGE4B9XpodEkAOgOEq5ikhsKHXf9xL0n8OXAt7Uwp
         +cbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HayUyhKVC1jV71lVDMj+V/y5mp9NsHvPTMD4HY4DZqo=;
        b=OmbFBizPDKrwxD8xGtT7Nm0p6Wqfyr8zjp9vnFGkEyDUMg699tw90mw2pp9qyJsj0R
         iyXix+yMEiBd6K7Mo8080YYY4nzVmu5HeKg78dynLoK6W8AsDbCL7sh5F0xpr6wGpLI0
         Jfo+bLVq8rRwu0hjmHox6ti/cKEJIpI8HV+RCbTVirpRz7eWD4ptBpJZhw5Fk6JBhw8y
         /O9/9N71WyIykTcQQ5O4eK0OTR1JTNMArZqsNeYXh1QY32E2bdfvbGdQm+eqzjzjDq6b
         LxEWymMH6qgUWDDPk78GerOWWZnmpOUE/tV7cxF5rx4rKA39Hl4eFeicy0tJ1HrQKXEE
         HShQ==
X-Gm-Message-State: ALKqPwdsIZkFyr7FjQenrlVM2PXnKBuXYCa2JUgP+ei2om9XSetsEWvh
        41iP8mYx98w54i8OjZHxwsY=
X-Google-Smtp-Source: ADUXVKJ0oyd90jjJWCXfIuatoWpMLf8t6825uQuD+LM+B6zW4JBfNqJuM/DukCdA0aKWuc9QTERUKA==
X-Received: by 2002:adf:8af5:: with SMTP id z50-v6mr5597646wrz.22.1527500755145;
        Mon, 28 May 2018 02:45:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g75-v6sm22315573wmd.15.2018.05.28.02.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 May 2018 02:45:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/5] config doc: unify the description of fsck.* and receive.fsck.*
References: <20180524193516.28713-1-avarab@gmail.com>
        <20180525192811.25680-1-avarab@gmail.com>
        <20180525192811.25680-3-avarab@gmail.com>
        <CAPig+cT=i0XYOrMymNjsBJqcLfJ38Ft_=MZPZD3N-AMo8raAHQ@mail.gmail.com>
Date:   Mon, 28 May 2018 18:45:54 +0900
In-Reply-To: <CAPig+cT=i0XYOrMymNjsBJqcLfJ38Ft_=MZPZD3N-AMo8raAHQ@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 25 May 2018 17:16:38 -0400")
Message-ID: <xmqqa7skjep9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> @@ -1554,23 +1554,42 @@ filter.<driver>.smudge::
>> +Depending on the circumstances it might be better to use
>> +`fsck.skipList` instead to explicitly whitelist those objects that
>> +have issues, otherwise new occurrences of the same issue will be

I had to read the "instead to ..." part three times before
convincing myself that this is a good description, and I agree with
the assessment.  Perhaps we would want to make the recommendation a
bit stronger, even.

	In general, it is better to enumerate existing objects with
	problems with skipList, instead of listing the kind of
	breakages these problematic objects share to be ignored, as
	doing the latter will allow new instances of the same
	breakages go unnoticed.

If the project has some tool constraints and have to accept new
"broken" objects on ongoing basis, then fsck.<msg-id> facility may
make sense, but that is probably a very narrow special use case.

>> +hidden going forward, although that's unlikely to happen in practice
>> +unless someone is being deliberately malicious.
>
> Is it worth mentioning buggy tools and/or other buggy Git
> implementations as sources?

Or old Git implementations we ourselves shipped.  I do not think it
is worth mentioning it, but I do agree that "unless somebody is
being deliberatly malicious" is misleading, if that is what you are
getting at.  One use of fsck is about noticing that you are under
attack, so "unless someone is being malicious" there in the sentence
does not make sense.  When somebody is attacking you, you do not
want to use fsck.<msg-id> to ignore it.

But that becomes a moot point, if we were to follow the line of
rewrite I suggested above.
