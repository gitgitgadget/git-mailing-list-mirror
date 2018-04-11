Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D39231F404
	for <e@80x24.org>; Wed, 11 Apr 2018 19:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753696AbeDKT0K (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 15:26:10 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:46180 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752410AbeDKT0I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 15:26:08 -0400
Received: by mail-qt0-f170.google.com with SMTP id h4so3266987qtn.13
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 12:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xPIiCPUnT0WP0ggCKiBkvy58Mv6ymFVMh5UORwR1iig=;
        b=Cr+BOAhDRmqypqQFvT/2GHJdyaVzy2kv21UxmwkS4Zgiataw7bf4RSN2+Q62Sgvknd
         gcT4+Soqc+JSryOYF/u10YFERseAYBroNjiKu2wdemX2XIJRnviObUXB6GBcCmYT6jEW
         jA1kkTa0QTEYK2e0HhBGEDQZLDfZLOLdMtfZR55IGFo6Iyb0P/RfYbr0Jrt1N8wudyBB
         Kb02C/z5Pwzg+eiR7urvygRnDMmwwiVn+Jn7ry0kjgCKY8CdnyKVMxDzMNoscaMDuIuG
         xufTd1CFJ54hMy4U+n6GoD07Xysx1mJ2pjW7cq/bo5rlMqwaTDR38GXVMJLHumad0JLh
         sSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xPIiCPUnT0WP0ggCKiBkvy58Mv6ymFVMh5UORwR1iig=;
        b=V+kDDMNuU6ISCT3iwdQOdOA7FC1z4VsI/pk0tvx4PxlyMg5/ZlNsQe6spZoqpEwvnc
         n3VPR7ILqmZTrYvdFNeQ6iNmcdZW1Ctxc0JaeqEvs0jLuP6w6WrO/VVt6OuZ5fIR6yFD
         hssN7LCrzxf21hj7rajGuEZmrBMWKyPSczgujc4/6fEyMlUrG84elU6xByr2QuA6vKaL
         x/TwDAovOFuyjuN8MFIrqFf2rYkqdxRGKQaAPbZQfUR93TH+RCcnC4ffxY0mnGEAm7Uy
         WVdQtZIgXqTv4w1baH/sf1SwOJ4x9l8JQfMdateSfg2HAqNzO7YGGtFnv82hC91y3pdG
         JPMQ==
X-Gm-Message-State: ALQs6tDERLAe0/dgn0dHVps3kwlU9R6x2Bh22eRYOYQPXXNNDjsd4YGA
        rAY8I4nGgSauXBLkIV1BedwoQcIJNNbtJc6fOeo=
X-Google-Smtp-Source: AIpwx49R0Ka/7qP+S252AvpKH5y6RjFWftqYrLXplwfzPkXKZTGsu339vsgCdxv8yh+ctJh9OsOdOeMQhPpx3mZ9K50=
X-Received: by 10.200.42.37 with SMTP id k34mr9552099qtk.101.1523474767454;
 Wed, 11 Apr 2018 12:26:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Wed, 11 Apr 2018 12:26:07 -0700 (PDT)
In-Reply-To: <9ba7d27f-ce65-7f2c-601a-1bea3274104e@gmail.com>
References: <20180403165143.80661-1-dstolee@microsoft.com> <20180409164131.37312-1-dstolee@microsoft.com>
 <20180409164131.37312-5-dstolee@microsoft.com> <xmqqa7uazc9e.fsf@gitster-ct.c.googlers.com>
 <9ba7d27f-ce65-7f2c-601a-1bea3274104e@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 11 Apr 2018 15:26:07 -0400
X-Google-Sender-Auth: ity74voob0AVhIq1dCAWRpTTe84
Message-ID: <CAPig+cRHV0+iWS_+QdbJyuWpoXxknVbwngOS-BV4XFcyGRWGaw@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] commit-graph: compute generation numbers
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 11, 2018 at 9:02 AM, Derrick Stolee <stolee@gmail.com> wrote:
> On 4/10/2018 10:51 PM, Junio C Hamano wrote:
>> In case we want to do the "we know this is very large, but we do not
>> know the exact value", we may actually want a mode where we can
>> pretend that GENERATION_NUMBER_MAX is set to quite low (say 256) and
>> make sure that the code to handle overflow behaves sensibly.
>
> I agree. I wonder how we can effectively expose this value into a test. It's
> probably not sufficient to manually test using compiler flags ("-D
> GENERATION_NUMBER_MAX=8").

A few similar cases of tests needing to tweak some behavior do so by
environment variable. See, for instance, GIT_GETTEXT_POISON and
GIT_FSMONITOR_TEST.
