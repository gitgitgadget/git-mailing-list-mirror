Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 591CF1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 19:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeIEAC6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 20:02:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37141 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeIEAC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 20:02:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so5159050wrr.4
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 12:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VHpEvWYImZzMNMjYVbZYF78p5oWUgxS0ntbIK60el5g=;
        b=bS+nDqimcNqKN3eoUyA9LRrtvsf4fvQ1yZctvnYyH/j30jKvn7sHkEIg6uMLix08Rj
         jxJPj9TUqQGfPyfkS1/VsY+u45Tr2bwypiPGpdnzIc7Pi1NSmRuOAEU35qdln5AevkIH
         qCY2Onb7FLBCk+vQ5jAk31Hi5dyah4WCAY4p7U91vGEBxecfabuJypcBPWbA2aSbLCpF
         7TZzrihZFTOZa4dpCJFayXHtQm+2rrdBQzY0EYwUCY1QrBeYCsOgOoB80zG7IQ749TcM
         V7W6cEy9znVCxdQPQfnzRc2xFZKgS2A4+qNuOZGfyXoczS1+S3FTw7ZmbR1GgUGmV9Vt
         n2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VHpEvWYImZzMNMjYVbZYF78p5oWUgxS0ntbIK60el5g=;
        b=nflEiXgqqKAffGJMmrS5UxOCdjTab0g2fBf9UZGOfUkhnVwM34iP38qq7hzFVsTytQ
         eA4Zu8tO06Ae04gx8MtUurcOfkQh87aeGlHZ2JxQRAajpm8eRMDQhAGcpxiE1tWnQPtX
         8f0ZSxFjEkA8esEhovw2BAuG1Z+yUg3tq4wY22tRZRuPvFpHtlV/GC5v/zjPJs+Ya6Ad
         DGw5nKqjz3jiNEiM/LmOs919JMPiwU8laEihjlBDIhi/0piknYPiz1N2y4ONxgaoVPes
         JLQqdXsyqLaXKM9b71y2GV4f+uryJ2FGCNkoDQxGKXFiH98rSItwT2iRMJnqDOXxYVTI
         /iZg==
X-Gm-Message-State: APzg51CbHsJ6+HuMLBh7Dmxe/+H/rJtFc8TkIH+uoJvfwsmGMm7gMH5M
        1LgIVUmU8wFb6vSeWoZ+UUk=
X-Google-Smtp-Source: ANB0VdaGA1tPf2YS3yshglNh0tE1pG72LAmFCuObEKccPPVERYnqPLisOuTLgQggGF5PhyWEm8y/fw==
X-Received: by 2002:adf:d20a:: with SMTP id g10-v6mr25380178wri.66.1536089782746;
        Tue, 04 Sep 2018 12:36:22 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t9-v6sm15445376wmf.1.2018.09.04.12.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 12:36:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 00/12] Hash-independent tests (part 3)
References: <20180903232515.336397-1-sandals@crustytoothpaste.net>
        <CACsJy8Ak3Gba-z09Gz8iFrRyXoLbR+jW0tGuPnwCLpxVZWfMtw@mail.gmail.com>
Date:   Tue, 04 Sep 2018 12:36:21 -0700
In-Reply-To: <CACsJy8Ak3Gba-z09Gz8iFrRyXoLbR+jW0tGuPnwCLpxVZWfMtw@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 4 Sep 2018 18:22:58 +0200")
Message-ID: <xmqqmusx837u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Sep 4, 2018 at 1:26 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>>
>> This is the next in the series of improvements to make tests
>> hash-independent.
>
> If it helps, I looked over the series and didn't find anything questionable.

Thanks.  I'll tick the message I am resopnding to in my Inbox so
that I know I can come back to it later after the final release.
