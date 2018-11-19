Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 856851F97E
	for <e@80x24.org>; Mon, 19 Nov 2018 21:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbeKTH2h (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 02:28:37 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45473 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730755AbeKTH2h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 02:28:37 -0500
Received: by mail-ed1-f65.google.com with SMTP id d39so58101edb.12
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 13:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=L56G8rhb7og7tMgn2tbU1MHFA2mAaJrD/ptgBQ6q4I0=;
        b=YI6l78FITOvq69ZeYnRGFPO8ZAH9xBXZCgHqtQcT/QtjncP+AZbDeZ1KkXzphHvJCV
         ywah9tBJOpuOco7bpmPesx+gfNacBG+iwr6P9Lcyvbj65c7cae7uHHu15ovwaWMkNqcN
         K8pk+1ECEOYtKBgIAgBoyBhC6G8S6zauWBK4l6F56tP1AwkI2Z0p6c5Y/R/+betXZdHH
         Fnv/xfxTM9KcpvfM7lUkfqHysHfW609YtkdyK6lsQmqV8E+5QrNVJpjsgYtcBZOmTtFH
         2hsnrI9g81OpkIchOl9XwFcEhzhu/xwf0aIlI+LpQbt9nNbBTUpleK4kMYzKqBADiGQI
         x+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=L56G8rhb7og7tMgn2tbU1MHFA2mAaJrD/ptgBQ6q4I0=;
        b=BFLTDzk2zsICicaSjFdgupShd2Gl8Qh95NjffamdpG4r8xeT59+Z8b3fyt/LrNbbts
         e3RRcWx/ZQMLakJQHCmhjUS8BTNu0zNZ0s5d/39FfrexMWH8WKyDBz3vxRWGlQbqezn7
         YFwrRCkLgxdfS4LowiOfi1oJb0/J9EK8QCbzQ4KLCk6Q3bAMbZsSuZEdvf0dWpXbxOtV
         yJebvCCdlIslWNRYQYGvrIAstTrOlU0i3eoo15f9b2AVIhEYvfgiLJXbaguYlt6iyxfl
         ORsWSXvZrWDiETnQAhPejLwEAiJcwDEaZFz7Pd5+sy6mQVP2xECW0nX79EipXhoMXGgP
         vPGA==
X-Gm-Message-State: AGRZ1gL5dLri09c+T5e4nuRFss/Vlovuj7y49SbqWfxXsurOBvbUHzV5
        ySBTPicKpQUfFNq1XLEUGPdk0gKBauk=
X-Google-Smtp-Source: AFSGD/UVObXD6ZvPEHP5sbemaheWB6ycSXHvealm8aL2/qaI84KuhKo4tFM+cgGl31U7zZpGs2R8+w==
X-Received: by 2002:a17:906:f84:: with SMTP id q4-v6mr8093727ejj.52.1542661388973;
        Mon, 19 Nov 2018 13:03:08 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id s19-v6sm877119ejz.2.2018.11.19.13.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 13:03:08 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] tests: add a special setup where rebase.useBuiltin is off (Re: Git Test Coverage Report (v2.20.0-rc0))
References: <9e293b1b-1845-1772-409b-031c0bf4d17b@gmail.com> <871s7g29zy.fsf@evledraar.gmail.com> <20181119185109.GA47930@google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181119185109.GA47930@google.com>
Date:   Mon, 19 Nov 2018 22:03:06 +0100
Message-ID: <87wop8zsol.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 19 2018, Jonathan Nieder wrote:

> Ævar Arnfjörð Bjarmason wrote:
>> On Mon, Nov 19 2018, Derrick Stolee wrote:
>
>>> [...]
>>> builtin/rebase.c
>>> 62c23938fa 55) return env;
>>> [...]
>>> Ævar Arnfjörð Bjarmason 62c23938f: tests: add a special setup
>>> where rebase.useBuiltin is off
>>
>> This one would be covered with
>> GIT_TEST_REBASE_USE_BUILTIN=false. Obviously trivial, but I wonder if
>> the rest of the coverage would look different when passed through the various GIT_TEST_* options.
>
> I wonder if we can do better for this kind of thing.
>
> When I do routine development, I am not running tests with any
> non-default flags.  So why should tests run with non-default flags
> count toward coverage?  Is there a way to make the default test
> settings dip their feet into some non-default configurations, without
> running the full battery of tests and slowing tests down accordingly?
> E.g. is there some kind of smoke test that rebase with
> useBuiltin=false works at all that could run, even if I am not running
> the full battery of rebase tests?

Yeah, definitely. Just pointing out that it would smoke out coverage we
don't have at all v.s. cases where we just don't have coverage with the
default tests without any special modes.

Derrick: I think it would be useful to produce some delta report showing
covered lines without any GIT_TEST_* variables v.s. when they're set. As
Jonathan points out those should ideally be tested with the normal test
suite, leaving GIT_TEST_* just for stress testing to find new bugs.

> That's a bit of a non sequitor for this example, which is actual code
> to handle GIT_TEST_REBASE_USE_BUILTIN, though.  For it, I wonder why
> we need rebase.c to understand the envvar --- couldn't test-lib.sh
> take care of setting rebase.useBuiltin to false when it's set?

I guess the test-lib.sh could pass down things like
"GIT_CONFIG_PARAMETERS='x.y=z'". Maybe that's a better way to do it.
