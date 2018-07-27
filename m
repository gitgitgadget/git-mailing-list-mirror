Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A45EB1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 22:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388871AbeG0Xnf (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 19:43:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36623 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388563AbeG0Xnf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 19:43:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9-v6so6466891wro.3
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 15:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=5CpcB/u8Bm1eSHM/i8pzCPVzgl2l6oXI0x2j2vb9CPs=;
        b=kOOOqRFCOIul/Fy/Ev26+kzu3exuAjumiyyaBpMOGZmKcwMkWbAAwy74vuPB2ZbeOD
         9zDN/cU0rS3zUFlIuFdnDqoeAjT+ApcjKor4aFn1T0SOPrPQrsWHDHA6FAG7ytByFGOz
         60H3BEkJ9iyueiOMlTXk6y0qrEHL7fveum+kfoRvXUW2gbP4CXq4po/0zML70LFramYz
         GUE1cPUOBVlpXBDKqqeXFd5hjNR8RFUW7xFNwBdz186Ywa/TtxvPmANXKZ1cuAi7Zt1/
         mnkH6RTrdm4Lw7ScaZtzLL+jWItJciO+S3lHxknXixj0bF6XqJ8hPL0IcW/c5mq6/0IE
         ePTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=5CpcB/u8Bm1eSHM/i8pzCPVzgl2l6oXI0x2j2vb9CPs=;
        b=OTKZY8xSCnsJhkk5vepvvOuXNiX871yXMANsfAfi2krhcf+wcbj6S176UAqHYusCLg
         qG1NDwQtUK3y45e8f0dCdOVlxhkRz7iwrDuLsuQ2/EPyUKG95WhG0UcAL099H2ugFPRj
         D9wl9ejkCQeobHEtZn7ZrV6v71YI2P6Zz+rlC0eJKJDAti+FsHa1X3y63ybSIkZCVCXN
         Hju1Fh223NuiiozIdn6pvKFLupBZ4xk78J2uE90ZhVfJo56Pf6OMornFvOJZi5ZFeLgT
         GKj0wyEZtuvisw8Vc1B1EWsUJByaHJWReJEkFB7OXvLPJpOEBnXG3yu6KYuSls/yWvYQ
         T7XQ==
X-Gm-Message-State: AOUpUlFJlpOi27wyQ8KK6Dxx0/0BKk7T98X33GuyfWwvegpAL3Hka8TN
        V2RoAVylhs+F4zaKdJLKt8M=
X-Google-Smtp-Source: AAOMgpeEJdovIjMEWB3Q282s/0yM2bGu6hxAIDuXYF+3f4spMAT5QavBrWrelM9CgPYSjRXMH/iyvA==
X-Received: by 2002:adf:c44c:: with SMTP id a12-v6mr6766421wrg.20.1532729977522;
        Fri, 27 Jul 2018 15:19:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h7-v6sm4138613wmb.48.2018.07.27.15.19.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 15:19:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 01/10] receive.fsck.<msg-id> tests: remove dead code
References: <20180525192811.25680-1-avarab@gmail.com>
        <20180727143720.14948-2-avarab@gmail.com>
        <xmqqva90mr2l.fsf@gitster-ct.c.googlers.com>
        <87d0v85uoy.fsf@evledraar.gmail.com>
Date:   Fri, 27 Jul 2018 15:19:36 -0700
In-Reply-To: <87d0v85uoy.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 27 Jul 2018 21:45:33 +0200")
Message-ID: <xmqqy3dwjp8n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>>
>>     author Bugs Bunny 1234567890 +0000
>>     committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
>
> This is covered by the "missingEmail" part of the test, but there's
> nothing wrong with the timestamp itself.

I think you didn't get what I meant.  

What makes you think "1234567890 +0000" on the first line is a
timestamp in the first place?  The parser could be updated and split
that malformed string (as it lacks <...> thing we expect, which is
what missing Email is about) differently from what you are
expecting, causing the line to be broken in two ways, i.e. missing
email and badly formatted timestamp.

But we know for certain that the line is wrong not to have email in
either parser (the current one, or a possibly updated one).  So it
is defensive to doubt your preconception that there is nothing wrong
with the timestamp, and demote possible timestamp errors to warning,
as that is not what we are interested in here.

> I still think it makes sense to remove this particular thing. Let's add
> exhaustive tests for all this fsck.* stuff in another series, but no
> point in testing for arbitrary fsck errors that aren't going to be
> triggered in unrelated tests.

That is exactly what I am saying with "being defensive".  Your
change starts testing for arbitrary errors that are not relevant.
