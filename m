Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 059821F404
	for <e@80x24.org>; Tue, 11 Sep 2018 00:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbeIKFst (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 01:48:49 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35781 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbeIKFst (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 01:48:49 -0400
Received: by mail-wm0-f43.google.com with SMTP id o18-v6so23297820wmc.0
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 17:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=b2sZTIYju8ruWqscV4oMVv2X/WBAodd5oY5s/mxCTcM=;
        b=WedUGzxyS8r8ol7GExe/nFXCZZMrUANKCYrcgRTk707VM5EzOXdQ88r7dMXJcgRBND
         3KYQ0dIiVS0zH3sZT3MfzKTxOlaGhyvl9q7Owl19n+lJzBrS3jxIpdTiCVz/nhPEE9rh
         4v/wo2oZYl/F1lbFkTOY7Bb/BDkZrKgm4Fsa9DFkjMFX91EeYpgWYwQhHwvbfVy0s7Bq
         A6d5wpmJVquRbHiyf22Lscz4wLSfWCSkoei8cyNI89U/UjcXopi4ITALpghf6HM/tXpR
         T74i+kQNpGVMWQn5FOMfuOWvTQsuL2VUt2TQGFn6yF95UPlfjhDIMMf1tAxuxbIpeINy
         8+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=b2sZTIYju8ruWqscV4oMVv2X/WBAodd5oY5s/mxCTcM=;
        b=shMAsrPOJWyHiN91FjR6Q6DHh99eYmzb0iXucbL/6ik2/+abvH/+7xMFddNnNLkb63
         vnNGWmWaTwEdr7JtTUg+Z/HSgjS8cZvIEfClXU+oxeSctsqel6O1Aahsmi6YrpTvuYYz
         /th0SAqStFqAG6II5F47ziS7SsndOVKnl9Gl9yCDzljAAT54PK5PoZNP2Hrn5yeiKutZ
         4NZ/6Khx11EjkC3LfvvgQ5a/7YVmciitoiABggYITK83nELEcbskTWCL5AoCon/SLXdF
         Ed7cJ0m7nw81lLmANUFYpCcxT/cFI3KiF2HwOsZMetrrNOZ0WLONML3dRNS6tLLzmn/e
         OGRg==
X-Gm-Message-State: APzg51CL4xfes6meMu/wcU3wmv1oJpHEL3tpbE09mAjC7a2OquNXalSs
        3HL3anYXSzFPzUKHg+1jZRk=
X-Google-Smtp-Source: ANB0VdYeLniH4ledNNl8RwOVTq89BDZGHiM8tZyFRJrl7G/lGU+RAIAze9JoJRDBYV10m3B0I57m5w==
X-Received: by 2002:a1c:eec4:: with SMTP id j65-v6mr2230316wmi.143.1536627128429;
        Mon, 10 Sep 2018 17:52:08 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c10-v6sm32616217wrb.17.2018.09.10.17.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 17:52:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] trace: add trace_print_string_list_key
References: <CAGZ79kbObDXyaRLADQpvMMSitOLCDwb030Q6UBiX-7Y-XWnqog@mail.gmail.com>
        <20180910215831.17608-1-sbeller@google.com>
        <xmqq36uhrnjk.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kY2XpB4nJOJc0LLueqsutpncgwdN8uC=Wj0Uxu9Yjgd8A@mail.gmail.com>
Date:   Mon, 10 Sep 2018 17:52:06 -0700
In-Reply-To: <CAGZ79kY2XpB4nJOJc0LLueqsutpncgwdN8uC=Wj0Uxu9Yjgd8A@mail.gmail.com>
        (Stefan Beller's message of "Mon, 10 Sep 2018 15:38:49 -0700")
Message-ID: <xmqqy3c8rh3d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> Of course, even though these are 1/2 and 2/2, only one of them and
>> not both would apply.
>
> Or you could squash them once we reach consensus that both are good.

Ah, sorry, I completely misread the first one.  I thought that it
was extending the implementation of existing unused function by
using trace API, which explains why I mistook them as an either-or
choice.  I did not realize 1/2 was adding yet another unused one
without doing anything to the existing unused one.

So the choice being offered are:

 (0) take 2/2 only, keeping zero unused helper.
 (1) take 1/2 only, keeping two unused helpers.
 (2) do nothing, keeping the simple unused helper we had from the
     beginning of time.
 (3) take 1/2 and 2/2, replacing one simple unused helper with
     another unused helper that is more complex and capable.

Are you planning to, or do you know somebody who plans to, use one
or the other if available in a near future?  If so, it would be OK
to take choice (2) or (3), and it probably is preferrable to take
(3) between them.  A more complex and capable one would require
maintenance over time (trace API is being updated with the trace2 in
another topic that will start flying soon, so it would be expected a
user of trace API may need update), but as long as that is actually
used and help developers, that maintenance cost is worth paying.

If not, I would say that the option (1) or (3) are worse choices
than either (0) or (2).  It would be better to minimize maintenance
cost for unused helper(s), and the simpler one is likely to stay
maintenance free for longer than the more complex and capable one,
so (1) and (3) do not make much sense unless we plan to start using
these real soon.

>> It is not costing us much to leave it in the code.  It's not like
>> the function costed a lot of maintenance burden since it was added
>> in 8fd2cb40 ("Extract helper bits from c-merge-recursive work",
>> 2006-07-25), so the alternative #3 might be to do nothing.
>
> True, but ...
>
>> somebody else in the future to propose removing
>
> is what is actually happening here already, see
>
> https://public-inbox.org/git/1421343725-3973-1-git-send-email-kuleshovmail@gmail.com/
>
>> I am inclined to say we'd take
>> 2/2 ;-)
>>
>> Thanks.
>
> Feel free to take Alexanders patch from 2015 instead.

I prefer to take 2/2 over the one from 2015, especially if we can
explain the removal better.  We had three extra years that the
helper stayed unused and unchanged, which gives us a better
indication that it won't be missed.

Thanks.
