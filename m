Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0BFC1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 03:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfBLDKk (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 22:10:40 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:36924 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfBLDKk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 22:10:40 -0500
Received: by mail-wr1-f46.google.com with SMTP id c8so1020664wrs.4
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 19:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Nmih1p3Ll09V8Iaxlx8IqwxdcNmTiCOmG/FfAqCnRcU=;
        b=c4QGzTgLXs79fxym21N5Y07YDW5nBFLIa02C1wuV//SYgFse70mBFvpuMSdxM6rtHF
         h+5EAn5D9jPJmDkRMhGWOpQ6iTQ8WjZAh4sNDNsXXVAaphpfKYsjuiM98mkxqzuXoBZc
         kkdGHvPBPy2wYEwTKvWukIL8c3ygX7aN3VRRG/CzJKuk7oCRDNHU1m0o8LTZa3CwGcom
         BuiQfCzWBU5RUbzxxzaICi4LChQ+7AtoJ1IW1jJYwS27t9yBUe6pVdbd2Exorj/ue9M2
         xnpezTc6gASy82Ew+SSaUebrnYCFDeEbCAW4Ub4EzwULsVqHP9ZKOWrSp0nMHng618rg
         rC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Nmih1p3Ll09V8Iaxlx8IqwxdcNmTiCOmG/FfAqCnRcU=;
        b=JbSOTzK3VpEm2v7ywdlTPWowp3vtQLUh8LePn6mONynSXhDvcH12j5chpsY1YRWeub
         2s6S4WXdmOaXsZyoIN2C1eKX3B3lSu2o9XJSarx1E9hNBHLITGr6NQ4JD+PK+/WZ5Y/P
         I/rAzHNHG+VkPeMMMMVbZ90wiZNoQw/5lEQbOR4uF0J4YrFECygZVQJCb/z+1ZDaDBqk
         jpCQUIaw5mQtK7oQwEyo0H1aD0Lnz7Q2ZcOvLDORpmJMSgI+RwiO4b8vuUy53V1BlcXs
         OQLNy9sUygCUiiQMpAzLterJPLzLcAeFTlsSHgVnypjhjhvZ3gTbHpmnw5nGtAf5MOea
         rRbQ==
X-Gm-Message-State: AHQUAubkA0OQ1QY3wy5u4ExuJwXaIXQnTKtPisH29LN4bgXqiTPOWVTD
        SVsEBgT48zrJmhKDV/fJClE=
X-Google-Smtp-Source: AHgI3IYurrDqmOCTjTKYdwoqkVVjdDmWvHYyT0/9oUhTNBTkFsu1l+vv6zbz+VeETYlspa+b+kxK4w==
X-Received: by 2002:adf:e8cf:: with SMTP id k15mr924507wrn.193.1549941038185;
        Mon, 11 Feb 2019 19:10:38 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y145sm1035956wmd.30.2019.02.11.19.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 19:10:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Daniels Umanovskis <daniels@umanovskis.se>,
        Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Feb 2019, #02; Wed, 6)
References: <xmqqimxwqcqw.fsf@gitster-ct.c.googlers.com>
        <CACUQV58vvDzhqRrtutZMDV_Kkz137oP6rLUODaniMekfGa5gyQ@mail.gmail.com>
Date:   Mon, 11 Feb 2019 19:10:36 -0800
In-Reply-To: <CACUQV58vvDzhqRrtutZMDV_Kkz137oP6rLUODaniMekfGa5gyQ@mail.gmail.com>
        ("Rafael =?utf-8?Q?Ascens=C3=A3o=22's?= message of "Mon, 11 Feb 2019
 23:40:08 +0000")
Message-ID: <xmqq8sylg0r7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Ascensão <rafa.almas@gmail.com> writes:

> On Thu, Feb 7, 2019 at 7:28 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * du/branch-show-current (2018-10-26) 1 commit - branch: introduce
>> --show-current display option
>>
>>  "git branch" learned a new subcommand "--show-current".
>>
>>  Will merge to 'next'.
>>
>
> Did something change? I may have missed it. Until last what's cooking, this was

Nothing.  I just do not care about this Meh? topic too strongly
either way.

> marked with:
>
> On Tue, Feb 5, 2019 at 11:56 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>>  I am personally not yet quite convinced if this is worth pursuing.
>>
>
> I also suggested a different implementation which simplifies it and should
> remove some unreachable checks that can be seen in "Git Test Coverage Report
> (Wednesday, Feb. 6)"
> https://public-inbox.org/git/20181107225619.6683-1-rafa.almas@gmail.com/
>
> I was expecting Daniels to squash these changes into his patch or for it to be
> dropped in favor of something else. For example adding `--list-head` instead,
> as discussed in early versions of this patch.
> https://public-inbox.org/git/20181011223457.GB7131@rigel/

Good.  Then I'll freeze that topic and expect you help Daniels to
improve the patch further ;-)

Thanks.
