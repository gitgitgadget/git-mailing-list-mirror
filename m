Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F5402018D
	for <e@80x24.org>; Tue,  9 May 2017 22:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751035AbdEIWwf (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 18:52:35 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36543 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751016AbdEIWwf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 18:52:35 -0400
Received: by mail-pg0-f54.google.com with SMTP id 64so6729733pgb.3
        for <git@vger.kernel.org>; Tue, 09 May 2017 15:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=D5S0Fhp7Nv5cZom1HShB1BIO3INhcJ0jnAORc89BMmI=;
        b=euNqg6U11hS/5FmMGBYhojpKMnS857tAXEixV6psA3Y49bf/XYKLqIECSY/XfdX2ir
         kQRnpDSLGb00cwrxRJ2lyzSb4W4kWLejM1VoKvlAOkIh2x3Rv9LWZ50WO7tHxZjWHzS4
         /j8XEo74zApSc6g0VP5sTZcSWL/zsYB9h/PtM872ij1LitBGvE8jcYAucuTrGA66ulwh
         qI7+ipFH7lTkZfxwrp9UOQjmGBn9oaQxCClKHq0/id0lVm48M33BOUD7o4jumzivnKZM
         oSe1Y57C0gkbBQC0FVEl7hpUCmrG2NatDYWwFSduGj+HEmc3nzpSw90o33BM43xRnr6X
         S0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=D5S0Fhp7Nv5cZom1HShB1BIO3INhcJ0jnAORc89BMmI=;
        b=lCCPvAyDM+pD/e6gR2q062NuwMAWLRqt7D/F1ijLGiO8UyGIGZaPIFJGfJQiqRHF0q
         p191zhlHf1DRWAR44hjH5wSqVIMTBJPJcGl2GQgzHBKfqho9/aN/A1EcSXHyIWHEwyhy
         BQBIzTXFPleVIGXmK3Zx7PnNAV2i7GehT9doXUrMyQvpoQ5+06vF6g6ju+cx4kGWLleI
         UBS2OvbjYl9u7Pb8ozSTmZ+LiTero+v7oKKembcsbSsR/IsZzy7gj67A7zofPSvr8eOd
         AI2TGO7sMrj9+aWRsm1wucWbZejQpzOC4x6QN/Qj4qSZqmi/N7mRb5Wkv6fba47TWxv2
         XQvg==
X-Gm-Message-State: AODbwcA9nx7VeDVrmbsQZa1nASq9d15ZhQ1MRWK47xZaHGfn3/hjIHt/
        GPexgUy/9GOkgA==
X-Received: by 10.98.87.203 with SMTP id i72mr2618776pfj.151.1494370354357;
        Tue, 09 May 2017 15:52:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9133:cf19:b689:27d6])
        by smtp.gmail.com with ESMTPSA id u19sm1656722pfd.63.2017.05.09.15.52.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 May 2017 15:52:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 00/21]
References: <20170420112609.26089-1-pclouds@gmail.com>
        <20170503101706.9223-1-pclouds@gmail.com>
        <xmqqd1bp9nvj.fsf@gitster.mtv.corp.google.com>
        <CAPc5daVwnsC2iqrX4PYL9LJyfD76dA1TS3xCNM7qHtmfHd0aWg@mail.gmail.com>
        <CACsJy8DyAV4y_-gsjk1QSGkcq+-jGX6y-ymuHvUEMfV3gxJa_g@mail.gmail.com>
Date:   Wed, 10 May 2017 07:52:33 +0900
In-Reply-To: <CACsJy8DyAV4y_-gsjk1QSGkcq+-jGX6y-ymuHvUEMfV3gxJa_g@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 9 May 2017 17:22:45 +0700")
Message-ID: <xmqqzielzlqm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, May 7, 2017 at 11:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> On Thu, May 4, 2017 at 2:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>>>
>>> > Changes since v1:
>>> >
>>> >  - fopen_or_warn() and warn_on_fopen_errors() are introduced. The
>>> >    latter's name is probably not great...
>>> >  - A new patch (first one) to convert a bunch to using xfopen()
>>> >  - Fix test failure on Windows, found by Johannes Sixt
>>> >  - Fix the memory leak in log.c, found by Jeff
>>> >
>>> > There are still a couple of fopen() remained, but I'm getting slow
>>> > again so let's get these in first and worry about the rest when
>>> > somebody has time.
>>
>> Hmm, is this topic responsible for recent breakage Travis claims on MacOS X?
>>
>> https://travis-ci.org/git/git/jobs/229585098#L3091
>>
>> seems to expect an error when test-config is fed a-directory but we are
>> not getting the expected warning and error?
>
> Sounds about right. Let me see if defining FREAD_READS_DIRECTORIES on
> MacOS X makes travis happy.

Thanks.  I should have suspected that myself to save a round-trip.
