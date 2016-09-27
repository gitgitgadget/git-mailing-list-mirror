Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F343420986
	for <e@80x24.org>; Tue, 27 Sep 2016 20:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755693AbcI0U7V (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 16:59:21 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:38139 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752586AbcI0U7U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 16:59:20 -0400
Received: by mail-it0-f52.google.com with SMTP id n143so26465434ita.1
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 13:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i5gyGx2CqyhgZWmlXtXy0IvPT/X5U+LwL+AbPx0heEg=;
        b=gCB69HSXvpfT+H5IS0SSefSjGkH2nG8NbXetLcw1L52qQNzxnHYuN4UNWyMTvQcmKv
         rSwo2QEOXyIN2gOayutvmaq3fYvdWo725RCejC1HMCNjPyxvDtUapf6kAGmWqM/r2wAv
         nJDfdlgUmxsPJB1NFNCJRV5hy+PGtjtIAmOPk5p9fhl0JR23+0Cs4cMKiPEu1C6qFspX
         lubaRruc18BafX1Hxe1bKQpoJ7L3GI//pissCCMDvtTcUjs37IJ/quuUWyEOXeL7ngSK
         gDaqreVU39vh+VhpZNRCdYPG9tyX3aGOUmBozi09L5aFhZiTXrK/hjeehi95geSTkTY5
         S06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i5gyGx2CqyhgZWmlXtXy0IvPT/X5U+LwL+AbPx0heEg=;
        b=N66LDFezh3GmqxmDjNiAx8AVItfNr0HvjcWtCF4UW6fZ0MlP23MBfgnjF3ViyZj1al
         VS6bTUVDsdoiEtUUySfzNu9N7EC3sv6JdgEsDlZ++PTc5GmkSirfWbSocuGhvTOju/WK
         h7txwvnnU8kPaDPz3YF2HBt2pKYWP2Y/5zhbJiNuRgsxajV+ar9fHURloa3vqi1G7Iby
         wuMdOkNWV1QYiXGhYo8c/uoy+SPdY8l24HwhIbMMHGhPhba7A1tKWThNZrru0N3xvE6H
         Cbf0+o0rRDZMsa1dhfxbJTzWTtKThpC/20veXUig2TdvzVKtyht6Q6qV9Y9crykaKSGL
         IWCg==
X-Gm-Message-State: AA6/9Rln9XFtt1Oiigrq/Qc2epuaZupkcM20h0TEryEtnINKr4peCPOxKzVrmXRCpLpVLUrr4NBYtJqohyA0N63E
X-Received: by 10.36.92.196 with SMTP id q187mr6801638itb.33.1475009959367;
 Tue, 27 Sep 2016 13:59:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Tue, 27 Sep 2016 13:59:18 -0700 (PDT)
In-Reply-To: <20160927205202.GG32565@google.com>
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
 <1474930003-83750-1-git-send-email-bmwill@google.com> <1474930003-83750-4-git-send-email-bmwill@google.com>
 <xmqqh991nq34.fsf@gitster.mtv.corp.google.com> <xmqqwphxm7av.fsf@gitster.mtv.corp.google.com>
 <20160927205202.GG32565@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Sep 2016 13:59:18 -0700
Message-ID: <CAGZ79kZgchm1usviUWvLqrBC133mDuQwOMcay6k3L6Vsv-CPzA@mail.gmail.com>
Subject: Re: [PATCH 3/4 v4] ls-files: pass through safe options for --recurse-submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2016 at 1:52 PM, Brandon Williams <bmwill@google.com> wrote:
> On 09/27, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> > In nul_to_q and q_to_nul implementations (t/test-lib-functions.sh)
>> > we seem to avoid using "tr", even though q_to_cr and others do use
>> > it.  I wonder if we had some portability issues with passing NUL
>> > through tr or something?
>> >
>> >     ... digs and finds e85fe4d8 ("more tr portability test script
>> >     fixes", 2008-03-12)
>> >
>> > So use something like
>> >
>> >     perl -pe 'y/\012/\000/' <<\-EOF
>> >         ...
>> >         EOF
>> >
>> > instead, perhaps?
>>
>> I actually think it would make more sense to add
>>
>>     lf_to_nul () {
>>             perl -pe 'y/\012/\000/'
>>     }
>>
>> to t/test-lib-functions.sh somewhere near q_to_nul if we were to go
>> this route.
>
> my mind is drawing a blank, what does the 'lf' in 'lf_to_nul' stand for?
> line feed?
>

Yes, line feed. (Note that Git has to deal with this cross platform new lines
e.g. CRLF is common on Windows, CR was common on MAC, and LF is
Windows, so naming the new line as they are, makes sense here.)
