Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9938B1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 18:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387407AbfA3S7r (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 13:59:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41394 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbfA3S7r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 13:59:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so641605wrs.8
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 10:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=sLDfwBmDwuC2WQbSlt6bCDkgX2b9ihHKLeTpGlzOs5o=;
        b=EiSiLelMpthq8U/fKKUEUhTdG3M8kmMOH1YN0ZIn1kURvRbWOi0aRKrbihZL6CWpsh
         gq3MceW3TjB3R5GC+kE+YDTudP3XvcqaaO3NNeRjv5Hk/FKz94tO77qvXx5WBjJQRmHp
         8xuZNpbxucynGrW4E/VYsmsL+6gs+zRKrBPfoT4tOxL1S1ZhDpFz5lyh1FoZnBQlNjQ6
         Zq1LlR9ZFJlYtes0K6ISxCAN+KEyguvzC5DJYOzcFnrvpnq0d2km1RljiFcSZbOAO2nz
         cL5SWACM5CUc9QKYX99N8VGWvD6mqVutsx3Ie3DjsWmAXkJcba3DWpUXEcP+y1a8THhz
         UVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=sLDfwBmDwuC2WQbSlt6bCDkgX2b9ihHKLeTpGlzOs5o=;
        b=QWyJ+SlR+MbTyzni72ntX5e8eTuKMdBi/tGWW4fSaSn7hbuvSJKDvPyznPa7FXH6Z3
         NRMGdx1oR2s915SzpYQiryMM5kvkJKk41Ubtl5Yz2a/qZDy+eN+Ht5pPaOYFI7KMQSHc
         69ysBITtNQgZfaeo1kPc+l0By5w6Axzd6eVF45nd+W3tAXZvZLvxnRy7TTZfnwlsLrne
         ifwDE3TNHaFERPCqAJzmLaQkNCWZAtyT1zjlTaxwBwIrLjFAIFastDfl8tBC4FXxImHS
         +uWYbtZ9QScU2RTFGTT/V4ufTRxvTyXKGedP99dhcFeYy13rAsulV33no4Z4trb528AO
         4FFA==
X-Gm-Message-State: AJcUukdWi6/kRePTixiUfbAop1Fyj+h4Po638SGB0okAk779u4llT6ey
        06N+Eyu5qTgcJJJgzzHQ3sM=
X-Google-Smtp-Source: ALg8bN5NzFyYEuvFFAJXNBIHzFnoys4V/1mkHXk/rfaIQiqOCy5Gu9h+MiSt/15x/28fHPJfHCH9nA==
X-Received: by 2002:adf:f211:: with SMTP id p17mr30969598wro.293.1548874784940;
        Wed, 30 Jan 2019 10:59:44 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b12sm2040704wrt.17.2019.01.30.10.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 10:59:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeremy Sequoia <jeremyhu@apple.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH (Apple Git) 02/13] test-lib: Export PERL5LIB for testing git-svn
References: <20190129193818.8645-1-jeremyhu@apple.com>
        <20190129193818.8645-3-jeremyhu@apple.com>
        <xmqq1s4v6pzm.fsf@gitster-ct.c.googlers.com>
        <09281A61-1EDA-4226-AD59-6A97EDF1B1DB@apple.com>
        <20190129235947.GG13764@szeder.dev>
        <20C7B5F4-58DA-43E4-9332-B206C0D070F0@apple.com>
Date:   Wed, 30 Jan 2019 10:59:43 -0800
In-Reply-To: <20C7B5F4-58DA-43E4-9332-B206C0D070F0@apple.com> (Jeremy
        Sequoia's message of "Tue, 29 Jan 2019 16:01:23 -0800")
Message-ID: <xmqqmuni3ra8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeremy Sequoia <jeremyhu@apple.com> writes:

>> On Jan 29, 2019, at 15:59, SZEDER Gábor <szeder.dev@gmail.com> wrote:
>> 
>>> On Tue, Jan 29, 2019 at 03:46:07PM -0800, Jeremy Huddleston Sequoia wrote:
>>> 
>>> 
>>>> On Jan 29, 2019, at 2:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> 
>>>> This obviously won't be acceptable as-is to my tree.  Shouldn't this
>>>> be something to be dealt with in config.mak.uname or something that
>>>> is meant to define platform-specific customization?
>>> 
>>> The issue here is that we're not locating relocatable perl modules
>>> during testing.  This is a general problem with testing
>>> RUNTIME_PREFIX configurations, and a more general solution to this
>>> sledgehammer would be appropriate.  I don't think config.mak.uname
>>> really makes sense since it's a general RUNTIME_PREFIX issue and not
>>> specifically a darwin issue.
>> 
>> But this patch is very darwin-specific ...
>>  ...
>
> Yes.  This is one of the patches that I said in the 00 message
> would certainly not be upstreamable but for which we should find a
> general solution to the problem if one is available.

Yes, I do appreciate seeing these non-upstreamable ones, as they
serve to illustrate issues that may want to be helped with a bit
more customizability in our tree.  I suspect some of them may
already have enough solution on our side without any need for
further patching (e.g. the "version" one Dscho mentioned for the
06/13), though.

BTW, I'll be mostly offline today, so I'll return to the discussion
tomorrow.

