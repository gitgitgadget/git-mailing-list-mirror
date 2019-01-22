Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2A0A1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 22:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfAVWfA (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 17:35:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53537 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfAVWfA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 17:35:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so168975wmb.3
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 14:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AZHJwRyg2B0Fn2aRRcBKVJl1IL/x/LpQXvy4rUjWgw4=;
        b=Jtv8qkgEzE9zKUwqMOMRRLgeOIV35Xj0vT2FpSLcI65APUN3RQmhYBCt/Z+vV/pYpY
         8VAa9PWit6jlyYXz0ncXkdgRfL6SBHCYs5eL8U0xA6OW64534zRB+02eKwn20jxaHGnr
         /nchbzv4HGo4qJamwSDCZjsn1VmwbDwfqWlLtEbc3Q1s1M9zm4220ipu0oZp3oZdIuBV
         Tl8uHv/NyyekCvo5FIdA0NTU4AnRiPZmnxbD9Cbzsev3rOIH4sXbKnRM4CHa67ckPMWl
         yuwYdNgbDzYt33Oc2/GFFZE0GDIrhMABU3gj6zcHu4nD5qMccNjWvXlMXtXwru/gRNah
         0bTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AZHJwRyg2B0Fn2aRRcBKVJl1IL/x/LpQXvy4rUjWgw4=;
        b=MhDHiRmKYFzW1e6neulYK3ZK0v0qX2ncsHKOIMkSlGK47uG59JT1ZpxMK6726JuhAD
         gexoYIxF7LhP4bH0ohN2mhnXDD3s76wwUhty7gx1/a4EAqQvylfQcyI2duAA/o2R3XOq
         4i0AE5H75+RIcbYQyu01xb7uCSkGSLudogIAFhV6tHuZl9s/9yGzAzDf/WqudYU4Jn7r
         EY8KP3lUlvYlBtYtzOwUmtWODfyaDDdoFEUQ0wwpV8f+wzGuIgd0xEMxQiUOcCdkoALc
         2c1FPn+XsCfdt3JtEIyYVBVMygeaStd7flDhyQJMzeV57fqFFCLkhYGfHrmv3XSkUq4S
         IJMw==
X-Gm-Message-State: AJcUukcJjCewhxcEBnSlrb1SJAujAWx1Ph9N68ZmYhC4qknkVx7Ebl1Z
        CzJf3siqMYPlFWx+Hk3HZqo=
X-Google-Smtp-Source: ALg8bN7gVCzCrixWVxfhCGc9e0J0QG1YDKpYX5eSFOvv9C8ikwL23F62E7CBtULKfuHn1caXSb7HCg==
X-Received: by 2002:a1c:e345:: with SMTP id a66mr298816wmh.12.1548196498270;
        Tue, 22 Jan 2019 14:34:58 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o9sm35116893wmh.3.2019.01.22.14.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 14:34:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 4/5] Add `human` format to test-tool
References: <20190118061805.19086-1-ischis2@cox.net>
        <20190121053112.4736-1-ischis2@cox.net>
        <20190121053112.4736-5-ischis2@cox.net>
Date:   Tue, 22 Jan 2019 14:34:56 -0800
In-Reply-To: <20190121053112.4736-5-ischis2@cox.net> (Stephen P. Smith's
        message of "Sun, 20 Jan 2019 22:31:11 -0700")
Message-ID: <xmqq5zuge2y7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Stephen P. Smith" <ischis2@cox.net> writes:

> Add the human format support to the test tool so that TEST_DATE_NOW
> can be used to specify the current time.

This sounds sensible, but let's do s/TEST_DATE_NOW/GIT_&/ to make
sure that we will not pick up somebody else's random environment
variable in production Git binary.  

The name of the original environment variable was OK as it was very
much limited to t/helper/test-date.c, but a name that we'll pay
attention to in production binary is a different matter.

> All calls to gettimeofday() were replaced by calls to get_time().

Yup, good.

The next to go would be the getenv(TEST_DATE_NOW) at the beginning
of cmd__date(), which probably would lead to simplification to
functions it calls by losing &now parameter.  But that is a separate
clean-up.


