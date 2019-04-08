Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32B6F20248
	for <e@80x24.org>; Mon,  8 Apr 2019 12:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfDHMvf (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 08:51:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34170 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfDHMvf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 08:51:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id x14so11587809eds.1
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 05:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=d4qMWkq1SAQ6saSvzwpGMxtEuBsO5FzCfm2T1WDD/m4=;
        b=ENOE16fFDJg11u7F2eHetjtSCvMBiydHUGO0l7Y65vSoCBNMaGjrX2WfD6Dt3gEUUe
         VaeWfR9lvIsmQSIpEj2c1Rq0tpKqugFj8FZg+wiyJtXF3GQ+J2RI0RhjqynRAeBeHUQI
         k9CEm8hThQmVIPksnpIN/eBBIJ0VPtSEnRqEknzVU26C7nU2Sv3/0VEU1T7F8hS01MyR
         CPEs3p9fNtVB/Zwp8S3mBeD7DxKh0SsslEpJtHsJct8nF8t8VNHG4EGrtNXRAqJC3xcj
         lHdf/1GUjMo+H5wd/Wh9nWdsizJkXNMmlJl3P3SuJb5CRIrK0V/0B4XyrSYILN78dD1q
         HPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=d4qMWkq1SAQ6saSvzwpGMxtEuBsO5FzCfm2T1WDD/m4=;
        b=MtGciW1qxebfvrChcIqmmExnBHBYguQjBEA7VBFYs/mB94uNcM5lFlJdiUWNRnYVNY
         Tx3o4aQszcdLLMMmrI2ePh9I21y5V4128H2vYWHF3zOQnPzHkOxFc5awXX4hE89cqSzQ
         6aYt3MESI3vAa52tHmWaZ7Uvjq9UnVWwjs1gElcuMfj7MUf7b99Itr8cPctgF8lYAYaZ
         yITVGqi2VUWO6D7uoq9eaDEPVYRGphgGTr+wvbBZ1Q5H+70Ni52iWXUZKVLcByRw3BTt
         mJZdQOQwqaGfl1OW+dnVEpmQlAr/mBftr4Tz3g6okM3dBbUmQ0arAOJWMc75VKJAUdu4
         yZZw==
X-Gm-Message-State: APjAAAUvOIipbH1RwWI3KjhKZG+q0JHqQtfpPRE65QwaV41w4yPvMCqN
        KVODvnMCauy9iUfTHw9hAZ7lTOETBlE=
X-Google-Smtp-Source: APXvYqwMH5X3AcbqfKNcnBXS+bQOb1iZ2HAkxPSS8htqXwv1Ml9Rld0ZIxoleVVL/S1pZnzqsnmqHA==
X-Received: by 2002:aa7:cf8b:: with SMTP id z11mr1886064edx.154.1554727892925;
        Mon, 08 Apr 2019 05:51:32 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id r14sm8899166edd.87.2019.04.08.05.51.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 05:51:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Damien Robert <damien.olivier.robert@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: Pull without fetch
References: <20190406131200.xcd7gtf7dlc567uh@doriath> <xmqq4l79cmb4.fsf@gitster-ct.c.googlers.com> <CACsJy8B_-r-=LxzvdnY44H7Bnydijqu4+GvWOy3r+hP723uezA@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CACsJy8B_-r-=LxzvdnY44H7Bnydijqu4+GvWOy3r+hP723uezA@mail.gmail.com>
Date:   Mon, 08 Apr 2019 14:51:31 +0200
Message-ID: <877ec4acdo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 08 2019, Duy Nguyen wrote:

> On Mon, Apr 8, 2019 at 8:34 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Damien Robert <damien.olivier.robert@gmail.com> writes:
>>
>> > is there a way to do a git pull without it running git fetch?
>> > Looking at the source in builtin/pull.c does not seem to indicate so.
>>
>> The reason behind that is because it does not make any sense for
>> "pull", which is meant as a quick short-cut to say "fetch && merge",
>> not to run fetch, especially back then when 'git pull' was designed,
>> the world was much simpler.  There was no "fetch && rebase", our
>> branches did not know what their @{upstream}s were.  In that simpler
>> world, what you are trying to do would have been:
>>
>>         git fetch
>>         # did I get anything worth integrating?
>>         git merge FETCH_HEAD
>>
>> That obviously would not work for those with "pull.rebase", and I do
>> not think it makes much sense to teach "git rebase" the same trick
>> to read FETCH_HEAD as "git merge" does in the above sequence.
>>
>> Others may have a better idea, but I do not immediately see any
>> solution better than inventing a new option to "git pull".
>>
>> Another and better option that may be harder to arrange is to make
>> sure that a no-op "git fetch" incurs very low cost.  If you did so,
>
> Not exactly related. But I often wish to see the list of branch
> updates since the last fetch. There's no easy way (that I know) to do
> this unless you copy the last fetch's output somewhere. If this "fetch
> at low cost" could simply read FETCH_HEAD and summarizes it like a
> normal fetch, that would be great. And it should also be very low cost
> because we only replay the last part (making summary) of normal fetch.

The ability to have this is something reftables will provide (from my
memory of a comment by Stefan Beller), which Christian Couder is working
on implementing these days.

>> "git fetch && git pull" would perform just like your "git fetch &&
>> git pull --no-fetch", and we won't need a new option at all.
