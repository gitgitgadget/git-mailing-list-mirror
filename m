Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 594251F516
	for <e@80x24.org>; Tue, 26 Jun 2018 16:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeFZQqC (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 12:46:02 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43558 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751924AbeFZQqB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 12:46:01 -0400
Received: by mail-wr0-f196.google.com with SMTP id c5-v6so6780905wrs.10
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 09:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MXLbn5s6o0jHFn93KGbfEU5UFjc9+fKM4lAwC60tOEs=;
        b=jfR7km1M/gWej566r+as72k9tCHfXwcOS7bwZqhnJVUwRsq+R4wORHYYsScCBOpyTK
         O9Nzw5kzLmQ9ISJnXjt2zo72Mbk7XmRHLCg1fRd+QoRnyac3ZewYF+PALmJaCv7SqQ0g
         Yz+fskI1HW9JIu8dmEVYmOpn1MyrBut8xhsQRstconUNnudXhM1MQQ+v+A2xD9qhKf7h
         MWSo/eHA/zQ6jJnCkCPKsxLa1A/Y3WfZSwiTkT9EBBbVRVY1r6+1lhQ8g/X7Fu5kKIsm
         McJOriMgsYz6fcbsEm1w3F/ihf4JuHM8aFHYbpFbNi4K9we4YkGmTu0tfOHmhsgsHtPR
         gK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MXLbn5s6o0jHFn93KGbfEU5UFjc9+fKM4lAwC60tOEs=;
        b=VxxqiKkHbSP+CwPhOZW/V+lDM9SmpNy9IHmjMv71yciazUalkrh0smB407Wfp23U2t
         4mfT4XVSoCePjqqLfS59M+82d/N8KBvebm/qYbW6EPlT6h38Qq/9UqEvJUEuIWxcZx1o
         2VVVcPdAb8myYq4KPNRaEFh4xebQpNs/OIiaK7v3soYDb9DjXHCZ+QeRqOHpGdi6EnBp
         oP9EJfBPOV0Z8Xf6MrU9u7lbCVoFLyrpQXtoMvguFHRGr3HOJBNjxoH3T2/SW8dsvjjx
         wkotqF/vQrN4l1NvEjaegfrumBZy/UxkM/h53+647GzOQXrTJkLSdZK5XXfzt2vk/BXj
         R8Ug==
X-Gm-Message-State: APt69E04dWY7w+QQFQwHOgrRA8uj9J2kHi58lJ3b+oDqdcFHC7CBuUu6
        BKSuc/qVctG+RPhSEtRqd2U=
X-Google-Smtp-Source: AAOMgpeJyDxM+SsumBu6YHiux41mBkjMpSy1c03N04ABvDnMjhBWg6r5N61699Lxj54MNdNr02r2qQ==
X-Received: by 2002:adf:8806:: with SMTP id d6-v6mr2087064wrd.41.1530031560020;
        Tue, 26 Jun 2018 09:46:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g125-v6sm2656498wmf.16.2018.06.26.09.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 09:45:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH v3 0/7] grep.c: teach --column to 'git-grep(1)'
References: <cover.1529365072.git.me@ttaylorr.com>
        <cover.1529682173.git.me@ttaylorr.com>
        <20180625184350.GA26688@sigill.intra.peff.net>
        <20180625184729.GA12140@syl.local>
Date:   Tue, 26 Jun 2018 09:45:58 -0700
In-Reply-To: <20180625184729.GA12140@syl.local> (Taylor Blau's message of
        "Mon, 25 Jun 2018 13:47:29 -0500")
Message-ID: <xmqqa7rhmr7d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Jun 25, 2018 at 02:43:50PM -0400, Jeff King wrote:
>> On Fri, Jun 22, 2018 at 10:49:26AM -0500, Taylor Blau wrote:
>> > Since the last time, only a couple of things have changed at Peff's
>> > suggestions in [1]. The changes are summarized here, and an inter-diff
>> > is available below:
>> >
>> >   - Change "%zu" to PRIuMAX (and an appropriate cast into uintmax_t). I
>> >     plan to send a follow-up patch to convert this back to "%zu" to see
>> >     how people feel about it, but I wanted to keep that out of the
>> >     present series in order to not hold things up.
>> ...
>> Jinxes aside, this interdiff looks good to me.
>
> Thanks; I hope that I haven't jinxed anything :-).
>
> I'm going to avoid sending the PRIuMAX -> "%zu" patch, since dscho
> points out that it's not available on Windows [1].

OK, so what I queued on 'pu' seems to be ready to advance, which is
good.  Keeping topics in flight on 'pu', unable to convince myself
that they are ready to advance to 'next', makes me feel uneasy and
unhappy, and having to worry about one less such topic is a good
news ;-)

