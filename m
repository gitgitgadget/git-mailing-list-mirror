Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39AA1209FD
	for <e@80x24.org>; Sat,  3 Jun 2017 16:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751163AbdFCQYh (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Jun 2017 12:24:37 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:38001 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdFCQYg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2017 12:24:36 -0400
Received: by mail-it0-f49.google.com with SMTP id r63so44321997itc.1
        for <git@vger.kernel.org>; Sat, 03 Jun 2017 09:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rzPzcTWgYl2k664SRfLWM6p9CBZxLgflDSCI3gHrtQE=;
        b=JdOKWd5gOF6h2XzKOZ27fnVQ0FRn1B48OETw7ZP0Q+YMn+o7z5b+gYfWqq45WSmpyT
         tsWgjhj3CYHDspAm44O20C3NQQHwryR7fX/6lLJMH1j7NTZ7yRCdVvQiE613PrjrdXU6
         TguNZq5DfgErc/yzo6yI9ahSlLvkJ4jRiRld5U+IFbUZ+l+G3c9orhL65yaZSG96YJK3
         XGeGJvbnpe8SsjFxG1TCUslFxiJU1g8Ze+3J9LYBCpTgLlwRp5TsqHw/TeN/BzpJ8wZo
         KMZ6oLBQQY+kUZy1CwkGewPZyCBCbST5UBxZwgSn8AxIjTGKG7fyQRRq7YsTg6YfCc3z
         1JUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rzPzcTWgYl2k664SRfLWM6p9CBZxLgflDSCI3gHrtQE=;
        b=CLISeshU+90GeF3C4YUQDKoWeKthFwhF2tudqMcNo8OxYkU8EeGKXO7n4Qx8XOx1cv
         YVsZANDF7U3z5u1gGmcCD/sEZXa7A+KmHuCB2jtduB6R9TS4GL3Y70/uWJPkF4PDrzNh
         x4t9AsrUvMSyXMfdW/H90a15HsZy5SFAHSrlUbrbEeuPutsfjib2OwmPnsyYgVZCBWV9
         HN0znscDDU4W1xgp+4OKh/KldXHhb5ErOP7VA8w9Aidv5FHgXs34rJTW9CpTWqO2Cd7R
         7uHrp6wtp6YCkU7kNsH5VtExZKaFbklMrQlKo6xHtdOw6HZQ02zdhFFxOYVRQHFKV4Od
         kMvQ==
X-Gm-Message-State: AODbwcBjvo3s7W4G2r3KuAuQiOAEsEblvIM0QptbDzJ5oqY5jM5U6nS0
        xGkKLo+tqwbe/6sNQK0BJpf3/Ab1ng==
X-Received: by 10.107.178.215 with SMTP id b206mr9298894iof.50.1496507075454;
 Sat, 03 Jun 2017 09:24:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Sat, 3 Jun 2017 09:24:14 -0700 (PDT)
In-Reply-To: <xmqqd1amx80f.fsf@gitster.mtv.corp.google.com>
References: <20170602103330.25663-1-avarab@gmail.com> <20170602184506.x2inwswmcwafyvfy@sigill.intra.peff.net>
 <xmqqd1amx80f.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 3 Jun 2017 18:24:14 +0200
Message-ID: <CACBZZX52O9Pf=5Xtq1Lg1=ZU26tm7pupvubk1ZjNJZp7kR450g@mail.gmail.com>
Subject: Re: [PATCH] perf: work around the tested repo having an index.lock
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 3, 2017 at 1:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> But I think a more compelling case is that there may be an ongoing
>> operation in the original repo (e.g., say you are in the middle of
>> writing a commit message) when we do a blind copy of the filesystem
>> contents. You might racily pick up a lockfile.
>>
>> Should we find and delete all *.lock files in the copied directory? That
>> would get ref locks, etc. Half-formed object files are OK. Technically
>> if you want to get an uncorrupted repository you'd also want to copy
>> refs before objects (in case somebody makes a new object and updates a
>> ref while you're copying).
>>
>> I don't know how careful it's worth being. I don't really _object_ to
>> this patch exactly, but it does seem like it's picking up one random
>> case (that presumably you hit) and ignoring all of the related cases.
>
> My feeling exactly.  Diagnosing and failing upfront saying "well you
> made a copy but it is not suitable for testing" sounds more sensible
> at lesat to me.

This change makes the repo suitable for testing when it wasn't before.

Yes, there are cases where there are other issues than index.lock
preventing testing the repo, but I don't see why there shouldn't be a
partial solution that solves a very common case in lieu of a perfect
solution.
