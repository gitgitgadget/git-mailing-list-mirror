Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 167EF20756
	for <e@80x24.org>; Tue, 10 Jan 2017 22:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbdAJWBZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 17:01:25 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:36074 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbdAJWBY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 17:01:24 -0500
Received: by mail-qt0-f176.google.com with SMTP id k15so408700796qtg.3
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 14:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ttl3q+XDU2cRk9Zk19+OMw858ibrVlMNHsgFWBjDHRE=;
        b=IdH+O/Bs6vU4dax4gZRlqmIu0iq8q0mtjOaK0GakjIUACkaY3fpfRwS++X1D4AkJMy
         qxOzF8nvJE+fvjDSoi2g8ZHl+VZ+YuocfbApbB7IFlkEeOsWMuXr8gDfIS2YgzP/bDCZ
         DN2hP626fg/Gz8Jv3b8L3IqQw12zDUHoeKNtDw/CeWQQmXisOMk1Z+7jmtEa7FUAtbt3
         onxMM++7vf4UNjwK7AwCrZpEjTs0Yrb8ok2JSuQHSy/+Z65sfQYlqvkjA+T9iR8jMsNu
         o6FQJW30a88WpFVX6nL19uwG9TLxM+IhoQEVvrbKCuFswmV1CYNWgkvWjf7XjCrU8RCx
         7vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ttl3q+XDU2cRk9Zk19+OMw858ibrVlMNHsgFWBjDHRE=;
        b=A0PcAhXjAX5PKoe+uqb5lHpItkq2blZimF4Jrb7KXvCcVgVWbI/tGc42n6p1Wn9QHt
         XznV+/n1z3odESl7OgeQHQrpY/qnGwq9uo1h+AqSJTSd44tzvSVd3ruggCNvJUTua/B+
         gWpRrpv0W5W6gab9dtKeynBAny2aa+BcznUOs3rKq08LHBAgL0XlfeGAp5gxjNFEorNn
         2s0YkJGirratQ4iQdD8g22VQDFKFw24HGuVZngZ6L3IcFgVxOmaY5nEx4FFIOPp30j2H
         eYKfpk37GF4SQxJDFluerH1sX0omFxk0QVYWboWXDl6vQ6kMPDR3fUfqSyTcyInu8Dh9
         3GSA==
X-Gm-Message-State: AIkVDXJb3vfTrUze1/0KZ4SCtk5VLSBAsnoZ9t7GEKjXzcLJd+fhWMhsJu2sJ2320yhdBchO
X-Received: by 10.200.50.112 with SMTP id y45mr4743642qta.108.1484085683090;
        Tue, 10 Jan 2017 14:01:23 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([2620:0:1004:2:8459:597d:aa56:dd3a])
        by smtp.gmail.com with ESMTPSA id r131sm2480646qke.14.2017.01.10.14.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 14:01:22 -0800 (PST)
Subject: Re: [PATCH 1/2] diff: document behavior of relative diff.orderFile
To:     Junio C Hamano <gitster@pobox.com>
References: <20170110004031.57985-1-hansenr@google.com>
 <20170110004031.57985-2-hansenr@google.com>
 <20170110065816.pu325sxajbyuqpj6@sigill.intra.peff.net>
 <e100d30a-5ee8-8485-5012-f9b1c6961ffa@google.com>
 <xmqq4m16sm5v.fsf@gitster.mtv.corp.google.com>
 <xmqqziiyr7e9.fsf@gitster.mtv.corp.google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
From:   Richard Hansen <hansenr@google.com>
Message-ID: <9daa70e4-82b0-a82a-67b9-e893546638a7@google.com>
Date:   Tue, 10 Jan 2017 17:01:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqziiyr7e9.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-01-10 15:23, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Richard Hansen <hansenr@google.com> writes:
>>
>>> On 2017-01-10 01:58, Jeff King wrote:
>>> ...
>>>> What happens in a bare repository?
>>>>
>>>> I'm guessing it's relative to the top-level of the repository,
>>>
>>> I just tried it out and it's relative to $PWD.
>>
>> That is understandable.  When the user says
>>
>>     $ cmd -O $file
>>
>> with any option -O that takes a filename, it is most natural if we
>> used $PWD/$file when $file is not absolute path.
>
> Ahh, ignore me in the above.  The discussion is about the
> configuration variable, and I agree that being relative to GIT_DIR
> would have made more sense.  In fact taking it as relative to PWD
> does not make any sense.

I'll stay silent regarding bare repositories then.

>
> We should have been a lot more careful when we added 6d8940b562
> ("diff: add diff.orderfile configuration variable", 2013-12-18), but
> it is too late to complain now.
>
> A related tangent.
>
> I wonder if anything that uses git_config_pathname() should be
> relative to GIT_DIR when it is not absolute.

I think so.  (For bare repositories anyway; non-bare should be relative 
to GIT_WORK_TREE.)  Perhaps git_config_pathname() itself should convert 
relative paths to absolute so that every pathname setting automatically 
works without changing any calling code.

-Richard
