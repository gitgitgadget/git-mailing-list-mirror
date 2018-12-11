Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C01F320A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 01:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbeLKBnt (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 20:43:49 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:55246 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbeLKBnt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 20:43:49 -0500
Received: by mail-wm1-f54.google.com with SMTP id a62so535486wmh.4
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 17:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zlUPKO81lTrSgzV5AGvoHSwuW2jnFYleG6uFYtWl3wo=;
        b=kzisx760GiWUEHI56orFNwWhIN4J6+p799P5IINqjZn7Ztfp/wv65uDVP7higtvLoo
         jVq4qgs595RKn5GR8nfC0+tja40VpAS//hEDs8Su7y47VnojWSfQJhfz63eJYd3k+g2s
         v/D54/PSZE15ifJ0euFstrEq4ok+NZFpGDCmdKBxHptxjOah5An0AHqDt86mR5FGFkxR
         j9bgghtfm1PrrmUvJjCmPFFchw7sGWyAvj7hkgQpcLfCB8GPNqdg/m5YFAvuXKHHUawP
         YZwPyP8ouhBe0FdMIkoLJbW04REj6x3MbO7cdTmkpizlS/feY/hHm5lPGUV5zsiYxqg6
         GuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zlUPKO81lTrSgzV5AGvoHSwuW2jnFYleG6uFYtWl3wo=;
        b=GQnJZPPlbxFh/n4K0VCXVzf1ZnVS6U//A5NYMQPoBH3sdkBiPOd9rjA0evOibZ4E8L
         ffumQVsa1BRJVHO/qixyZkVl1QXvAgGFisfY4kljvcxUTtk2bNe3XQWq8VQdsyvr3bph
         BFOz/qp8pP6cisBK4AqP4jdEc56R/VF+kHzeefqpCJ51/fW2QXw4kZmQQCzeYkGuxXV3
         Aq7tSyb5+PEgSF8eLJ8HeoDoyd9eOs9L3dFJySRAf8+lAatMQDTyo62AcMDcl78AV/uS
         Jfu2HzwagpwNgNUinEw/Gw0+5qSZFSIzjUGOHB7Mc8nhROaEHbSiMRCFJnUwJ4lTYkRN
         PdNw==
X-Gm-Message-State: AA+aEWYRbbg0MpzI0qDRI+juIp53Y+2QYxqAsZ3+HJLxESBVn7cOLUxK
        Xkrz2guC42Hb7ID5hqwxc34=
X-Google-Smtp-Source: AFSGD/VaKWZ3+3IG6dwbFUzn6UiQ/SkJCXR7u5xJgSp1UiOlxmexnkQ9Wl9g98xbvduIZMflIba37g==
X-Received: by 2002:a1c:5f8a:: with SMTP id t132mr568814wmb.40.1544492626668;
        Mon, 10 Dec 2018 17:43:46 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m4sm436881wml.2.2018.12.10.17.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 17:43:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2018, #01; Sun, 9)
References: <xmqq8t0z3xcc.fsf@gitster-ct.c.googlers.com>
        <20181210185321.GB37614@google.com>
Date:   Tue, 11 Dec 2018 10:43:45 +0900
In-Reply-To: <20181210185321.GB37614@google.com> (Josh Steadmon's message of
        "Mon, 10 Dec 2018 10:53:21 -0800")
Message-ID: <xmqqwoogn8ha.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> On 2018.12.09 17:42, Junio C Hamano wrote:
>> * js/protocol-advertise-multi (2018-11-17) 1 commit
>>  - protocol: advertise multiple supported versions
>> 
>>  The transport layer has been updated so that the protocol version
>>  used can be negotiated between the parties, by the initiator
>>  listing the protocol versions it is willing to talk, and the other
>>  side choosing from one of them.
>> 
>>  How's the doneness of this one?
>
> I'm not sure if you're asking me specifically or the list in general,
> but I haven't heard any complaints about this, and there are no
> outstanding requests on the review thread.

It is both but more of the latter ;-)  "I haven't seen any problem
reported, and all review comments have been addressed" by you is
also a welcome feedback.

>> * js/smart-http-detect-remote-error (2018-11-17) 3 commits
>>   (merged to 'next' on 2018-11-18 at 5c6edfcb85)
>>  + remote-curl: die on server-side errors
>>  + remote-curl: tighten "version 2" check for smart-http
>>  + remote-curl: refactor smart-http discovery
>> 
>>  Some errors from the other side coming over smart HTTP transport
>>  were not noticed, which has been corrected.
>> 
>>  Will cook in 'next'.
>
> Masaya had a series that addresses this as well:
> https://public-inbox.org/git/20181127045301.103807-1-masayasuzuki@google.com/
>
> To combine these, we'd want to drop the diff to remote-curl.c in the
> final patch of this series.

OK, I'll kick the topic out of 'next' when reopening the tree for
the next cycle.  Could you work with him to feed me the result of
combined effort to replace these three patches?  Thanks.
