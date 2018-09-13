Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F57A1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 14:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbeIMUJt (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 16:09:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38941 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbeIMUJt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 16:09:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id s14-v6so6153873wrw.6
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 07:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5UctodQWLUCSnAE3wjrNiHPW6s9OquyPeZfC15Pn6J8=;
        b=vL4YOVPxdAnqjiO9sbm6RN6MfOXv/p8aNXf1kzyDl5iqY8LriYXe+mfBQrdzpgqUEu
         Gpi6VsjFKf1Yx5nJBMFhE/y38htwxXBrTYrHKUZVIRNCR39DpJQuMJq7fL5odf/CAwEL
         qlrfjrf6Awqs92DnZEIm57qPhZQPOw1cv6jJM8LAUY6bdAuFavKVJxA2LM9esECdEpB9
         04xqoO8bGvW5wWTFYWXEyeSwoAuWHkybLcKYYpU3Q/UxcmPJM0+TGwfLE2zMuFwILUnu
         hJzXdkFrRrhzYl98jwng1MlRijjU5mPVJ6qLi6fmUJKTTXOfaeDpXB3w6zK9zIMRPaOv
         wrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5UctodQWLUCSnAE3wjrNiHPW6s9OquyPeZfC15Pn6J8=;
        b=L/QpG7LyJWpcUxJHa2ehc3Z+CL9RHLgnfeHTsA+k2ds2ZcdQEbNfTkGHdWz4uCpBvK
         tsUIwYxazUZnBT6EkyAoduG5ggs1DBERSK1cAynD2GN2xdTBxAV2rk8oNGxYD1K6we6Z
         ighuOTQJbb51+ywh3PQdA3u9ADKliWP7YfDUodKyqLLwOihmHGocUd7HFIo/3gOleE5t
         Qe+eDhJRTWZH9pTcw5lz0E1ZiMq4tFBHhN4JNO3SEujBnDvczMxF5bNZZFh+maJSZm27
         2xUb4jPm2erSEhQjEIf8n1nbqugzmJqo3t5sGuVeqRM5HxPSkpzCDXGP1yZg9dGd5MNS
         xoFQ==
X-Gm-Message-State: APzg51AgzYVnqQCH8OY/mA7EmbJ2fw/5c6TBBzJQJ2DoUntf3meGds/M
        uXM2LusoI4koNl2O+uvrYG4=
X-Google-Smtp-Source: ANB0VdaRDu5WfThEFvfcRtOJ6ryPSKZ1vSZfhkfKlyb5o1snUN5SnfE5cQpHVWyGAHadMjeui0nW1A==
X-Received: by 2002:adf:9b11:: with SMTP id b17-v6mr6154356wrc.119.1536850794781;
        Thu, 13 Sep 2018 07:59:54 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f17-v6sm3216600wrs.1.2018.09.13.07.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 07:59:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] contrib: add coverage-diff script
References: <pull.40.git.gitgitgadget@gmail.com>
        <e4124471e5494b737d99eceed25fb03e787d0b96.1536770746.git.gitgitgadget@gmail.com>
        <xmqqa7omjred.fsf@gitster-ct.c.googlers.com>
        <xmqq5zzajpi1.fsf@gitster-ct.c.googlers.com>
        <1e712541-3101-049a-acd2-b6d7c98bd1e2@gmail.com>
Date:   Thu, 13 Sep 2018 07:59:53 -0700
In-Reply-To: <1e712541-3101-049a-acd2-b6d7c98bd1e2@gmail.com> (Derrick
        Stolee's message of "Thu, 13 Sep 2018 08:21:14 -0400")
Message-ID: <xmqqin39igt2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 9/12/2018 6:54 PM, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>>>   contrib/coverage-diff.sh | 70 ++++++++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 70 insertions(+)
>>>>   create mode 100755 contrib/coverage-diff.sh
>>> I fully appreciate the motivation.  But it is a bit sad that this
>>> begins with "#!/bin/bash" but it seems that the script is full of
>>> bash-isms.  I haven't gone through the script to see if these are
>>> inevitable or gratuitous yet, but I'd assume it made it easier for
>>> you to write it to step outside the pure POSIX shell?
>
> I completely forgot to avoid bash, as I wrote this first as an experiment.
>
>>> ...
>>>> +	elif [[ $REPLY =~ \+\+\+\ (b/)?([^[:blank:]$esc]+).* ]]; then
>>>> +	    path=${BASH_REMATCH[2]}
>>> OK, it probably is easier to write in bash than using expr if you
>>> want to do regexp.
>> Just to clarify. I am saying that it is OK to give up writing in
>> pure POSIX and relying on bash-isms after seeing these lines.
>
> I'll try rewriting it using POSIX shell and see how hard it is.

Thanks.  Don't waste too much time on it and try to bend backwards
too far, though.
