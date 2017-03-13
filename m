Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59D741FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 18:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751651AbdCMSa3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 14:30:29 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33988 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbdCMSa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 14:30:28 -0400
Received: by mail-pg0-f45.google.com with SMTP id 77so66850322pgc.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 11:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GbbbtgtwdLT4EXUogkKqWi+ytJJalPW2VlvhZZDpUNo=;
        b=KhXXmFT7bl2zUhecnvdQ+SzzNaFJCXO29ASdQpE9/g8Q09e0X65GTdengZizPGMTBi
         T3Z1hhvBqGLpgJyz5BewAQ9nS5Kob1Ub4T8rhQeZVNDnixo75KUwETHcpReYRxPSYF2M
         cMCjumz8I8HKGC2+vL8MWKT5b3Dp2MaYX1ghjl4ghQyEBk1fmkhtj8HSS+ZJZzDAHkoc
         GgFUVYpoqnXAXLXT2CmD5CqkX/spUv6yNSVEcgjH+qmgUAUvz0Y7t0Jb8vuN6H0kYl7U
         lGqRdFqlVQVXfQW88dg83NvwG1wXzBdQpLv1Yw1mYAAe+beahNSR20UjLlEgJV+xQvzz
         RDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GbbbtgtwdLT4EXUogkKqWi+ytJJalPW2VlvhZZDpUNo=;
        b=gZOXOBlvDM3qxEnXMKiJa2SBtwoYo1ueJI2cil1v9FiG80yip1PPZELtGN/CUYLZOI
         LQlQY42aMTrKhinBDgQqKeY6H9UbfluWKi4p0Yb+zJwACtyzRpUhGQvKTalUJpCjbMk4
         tqkFhod7OHzB41OX1KaJfFCjqTJyaMA+eeFsxBreWdF4eG8PXFqyx69PkNkHBaGIxjsd
         QuqoAIF/xt4EOrLulH9BogqVo8Os3qquHcc4rY/jnvDyVt/XVYNCd25mvlhWj/L9bwbW
         2EWd22qyDeF3Hqrx9g81hSe3cekmSrXdGFPhUtANezZIHSuP3ntUb3+IpzD7FAQjtzEk
         q/pw==
X-Gm-Message-State: AMke39kP6+sTapNYjlsn5WjAOyTjnMaxpDmI6v2daeQJekk6T0IZ1XA/34zrx16EVEKBATVS8mvDjlkT6EkmFH5B
X-Received: by 10.99.178.9 with SMTP id x9mr37657633pge.48.1489429826690; Mon,
 13 Mar 2017 11:30:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Mon, 13 Mar 2017 11:30:26 -0700 (PDT)
In-Reply-To: <xmqqo9x5uc9u.fsf@gitster.mtv.corp.google.com>
References: <20170309210756.105566-1-bmwill@google.com> <20170309210756.105566-2-bmwill@google.com>
 <xmqqo9x5uc9u.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Mar 2017 11:30:26 -0700
Message-ID: <CAGZ79kYbkpjxJihZMh8W1sutjP1WtSE4FjXU3v-eFPYx0Pu_-g@mail.gmail.com>
Subject: Re: [PATCH 1/2] pathspec: allow querying for attributes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> +test_expect_success 'fail if attr magic is used places not implemented' '
>> +     # The main purpose of this test is to check that we actually fail
>> +     # when you attempt to use attr magic in commands that do not implement
>> +     # attr magic. This test does not advocate git-add to stay that way,
>> +     # though, but git-add is convenient as it has its own internal pathspec
>> +     # parsing.
>
> That's thought-provoking ;-) Would it help to add a test-pathspec
> helper, similar to test-config helper, that serves as a vehicle to
> test this?

I think that is a very good idea; looking through files mentioned by
"ls t/ |grep pathspec" most of the tests for pathspecs are done with
git-log currently, which also helps with DWIM checking, e.g. if the
pathspec part can be interpreted as a ref instead.

So I wonder if such a test-pathspec helper would first only cover this
test case of not supporting pathspecs, which sounds a bit counter intuitive.

Thanks,
Stefan
