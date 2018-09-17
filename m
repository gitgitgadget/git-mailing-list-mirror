Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAA3C1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 15:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbeIQUis (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 16:38:48 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:50673 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbeIQUis (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 16:38:48 -0400
Received: by mail-wm1-f50.google.com with SMTP id s12-v6so10073458wmc.0
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 08:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=V8CIJJ7P5dihSLgk+lyr9//nQ7FlSm0PtK6Rlk1JG3U=;
        b=p7W+XqiAAomGq05i0tC+jQBKTKorPyWIcteEp5aTO4TPCuRrlRQ6eZRNTqXTTyqvvc
         kO5GcRghiIzf9ZQhUNyPs0z2UJOCGWk645wyvfrFU7TEhvFhP64ALOR0kVp8q9EHi25o
         /3J6Y/UILy674bBRxeQ/ZE3Os5s+aQcvrPoTROcB+Ym6/+vbpEWjSNoJLPtK8LmHsi/+
         RatlG1H4GAyuAZhsV8J7Un5WPKe+wkQojZV2faHAVkUPE/2mFElKcZDS9vbzGzGHKrka
         qlrpakepZkBQGcTktkMHb+C54T3867/Do7uc4ngKol4dklX7Zx3LeyqUYKxzv4pio0jY
         YZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=V8CIJJ7P5dihSLgk+lyr9//nQ7FlSm0PtK6Rlk1JG3U=;
        b=iOBGKj4p56M2sETHTU+jA4dSpOU4M8yFeG2i5kEEschlWQNZgDyDgLGJEEzECXylYW
         IhRfwv/3UOyDXlzRQHZ6HYAg08Gk3keSU+rM+b82i1x6IhX8Zk1aWSP+VLOf9lxblLZa
         Of6vY/LEdJbQAm1StTMmDGE4dRb10ctjNzzI/piVQrRbrOmTdCcPLlAeDokLFIADPXz/
         jK3RcHe0YNsD4m4ExuN2SoxEPC+CvTVzwlDO9YdN6J2Je/3mAwFQiirCe/CFy2Jpeq/U
         VwaYnf5oMKQxBZKXm/KSb/6fOiY+fZhYi8UjIpeAG9epvecV9oHUb15GK1LMJ+DZv/FD
         QDsw==
X-Gm-Message-State: APzg51BnMBIR4fpHK2eEKnWGwxn/PeX4ElXblnEReUJu2KJW5gfxeJrq
        4oZRa15aj4Vve8oJg32K1L0=
X-Google-Smtp-Source: ANB0VdYpuAZlrFZR7qgz7xRLP/AZQ8N62rpdKSIdsvZQNLr3+sVx/BtQOfNwuwO3/Zkardtzgdu7jA==
X-Received: by 2002:a1c:8955:: with SMTP id l82-v6mr11637503wmd.110.1537197061024;
        Mon, 17 Sep 2018 08:11:01 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x23-v6sm5415293wmh.26.2018.09.17.08.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 08:11:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2018, #03; Fri, 14)
References: <xmqqy3c3agkr.fsf@gitster-ct.c.googlers.com>
        <20180916120114.GV432229@genre.crustytoothpaste.net>
Date:   Mon, 17 Sep 2018 08:10:59 -0700
In-Reply-To: <20180916120114.GV432229@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 16 Sep 2018 12:01:14 +0000")
Message-ID: <xmqq4leo9n24.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Fri, Sep 14, 2018 at 02:56:36PM -0700, Junio C Hamano wrote:
>> * bc/hash-independent-tests (2018-09-13) 12 commits
>>  - t5318: use test_oid for HASH_LEN
>>  - t1407: make hash size independent
>>  - t1406: make hash-size independent
>>  - t1405: make hash size independent
>>  - t1400: switch hard-coded object ID to variable
>>  - t1006: make hash size independent
>>  - t0064: make hash size independent
>>  - t0027: make hash size independent
>
> Could you drop this particular patch (the t0027 fix)?  I found an issue
> with it that I'd like to address, and it would be easier for me to just
> send a completely fixed version in the future since it doesn't have any
> dependencies with the rest of the series.

Thanks, will do.
