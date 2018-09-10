Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E87711F404
	for <e@80x24.org>; Mon, 10 Sep 2018 22:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeIKD3D (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 23:29:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55648 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeIKD3D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 23:29:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so23098169wmc.5
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 15:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OWA8+LAv05KDqlQIj6s3iYkzZfqf5VDpTXtbBJEfKIA=;
        b=E99W/fplbg/twSbOvGwqOA6mdD8ABZuq/kPWRK1w+z/SuaDLMaN7x5Cs3Fe63HwUJI
         d7CY0edqMZKwRJXEba5ARUK3hn4T9ufW0pCr7v4eAkBlmNGgYKzBAIk7LKIvU5EkEyIR
         nBK3oiaSzb4AQpXaI37a1EYHoMQayp35prNjgryjBqzD0MBHxrr+IbG8LejhqkTo1ESZ
         9v+Ojr6X0bn7DmsHmXfKseIgbpADw/Ignp/tvD9sMR6GuUkui4rHdaKJhhsQpgL/Q9n6
         K+U1CVcsvQZrftyvbBFxc7WMEUzuVqw/UF6D5M9a4CKPGzOeLLp3kcg6H/YwSFxt394z
         pSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OWA8+LAv05KDqlQIj6s3iYkzZfqf5VDpTXtbBJEfKIA=;
        b=RdgxNN7hMp1Jpm9el1F34yRGlnIrCLM4xLW4RzXqVutXosLA9kgSn54bsXjIMgfRHn
         tiqub7axINqkT79igiPUFr2keTxtY29WqC7kVn1W2Uqxk+a4QIldliCbqSyLLjgX1+lk
         px1unMqslfO38qPfoRRyiDu5gghifx1flaE+JMjd7s0Zrx3ueD6gUacR9K17dnH6Vxbo
         OBj05Tcrn54WQ5WduNTse58ZOJlmjVxiNcsT7y/0by0cXLiic2QHGfy+TQjnfCgTqKpd
         IE55amIJyOfKgGb+6UIb8cBpzt7ehnqIK90OS4cWiUQx3hxwkPRTxOt1XzSU5KXe32S0
         gnoQ==
X-Gm-Message-State: APzg51AK32QR4q7KTiNcQEOyP+t4Sf8VHi9A5bFQrkQG9cfp8XN7vyQw
        wAWtnjKrpzyWnaIK2KYodrk=
X-Google-Smtp-Source: ANB0VdYDsr1lWZBmYrMFmTdLWpZSJQthK9fiHJJL/ojW+qc8MwiReHtlpD0XuQUAV+0lChsgmjZXew==
X-Received: by 2002:a1c:8c08:: with SMTP id o8-v6mr2208258wmd.60.1536618768637;
        Mon, 10 Sep 2018 15:32:48 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y203-v6sm15033774wmd.1.2018.09.10.15.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 15:32:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 1/2] trace: add trace_print_string_list_key
References: <CAGZ79kbObDXyaRLADQpvMMSitOLCDwb030Q6UBiX-7Y-XWnqog@mail.gmail.com>
        <20180910215831.17608-1-sbeller@google.com>
Date:   Mon, 10 Sep 2018 15:32:47 -0700
In-Reply-To: <20180910215831.17608-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 10 Sep 2018 14:58:30 -0700")
Message-ID: <xmqq36uhrnjk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I separated this from the other series, making it into 2 patches:
> This first patch adds tracing for string lists and the next patch that
> removes the unused function from the string list API.
> That way we can decide on these two patches separately if needed.

Of course, even though these are 1/2 and 2/2, only one of them and
not both would apply.

Thanks for sticking to the topic.  

Given how simple that "dump them to standard output" code is, I am
inclined to say that anybody who needs to inspect the contents of
string list at various points in the code under development can
create one from scratch even if we did not have this implementation,
so perhaps 2/2 is a better choice between the two.

It is not costing us much to leave it in the code.  It's not like
the function costed a lot of maintenance burden since it was added
in 8fd2cb40 ("Extract helper bits from c-merge-recursive work",
2006-07-25), so the alternative #3 might be to do nothing.

I have no strong preference between #2 and #3.  The benefit of #2
compared to #3 is that, if we remove it today, there will not be
somebody else in the future to come and propose removing the
otherwise unused function, which would cost us time to review and
discuss, so unless somebody stops me, I am inclined to say we'd take
2/2 ;-)

Thanks.




