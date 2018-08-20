Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84C481F954
	for <e@80x24.org>; Mon, 20 Aug 2018 14:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbeHTRhy (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 13:37:54 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:39940 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeHTRhx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 13:37:53 -0400
Received: by mail-wr1-f45.google.com with SMTP id n2-v6so2677197wrw.7
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 07:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=okClTCWIGWvwNCS7q3QUIxUXFaHorI52wg7f6ZFAzBM=;
        b=crJQAOntx8splkLOYHEbHmhF1sUExFkvUE+zzbf42xm2Vy0H9aCi4aV6/6mq3XkPZJ
         Uo9MQXISqJHlwQpwQpqFoa3rusQVuVO1cSc0A3TI6zMnaeRJjc5M3RPiKuRgch5A1n+a
         12m98S9HwomYxg+Zf+eVjPXSkDuyEda6Qic9ScrQMDTK372B2Z8ZyHf6MofrgIPt0e/+
         Awvy9whA2q9mqp3yHKlalMEmjEEFrWAV9R1fkIIWkDn+YINE39iPPH1rDT7x8u3oiPmZ
         YSuwXq05/HTJicEFCYJ4wbXJi0oFI7LN3ZET5LLe4PDvrjQmCzktgqmUg6dLeeThPLU5
         9nzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=okClTCWIGWvwNCS7q3QUIxUXFaHorI52wg7f6ZFAzBM=;
        b=B43PCibFvDDYzotGchGCoW7FmV+gCTPzrSZhMuNHvxfgR4hCk+E6BHtcc23/0368dD
         uwmyhxiGRZMaOowesOdtR38jeAZtVVWohaYUb3g3XIpOBwp42fSsmzTXQiZoGj2lsM2W
         W1byC0kmrMIifQXKu+iJFOWFa0rsnW9e9R1UmhBMW7P1S8i68f+crwbIx9oQ3P1SB2aI
         dCgBcZkHIvmH7LyryYvt4WoD+xSX77MeYUMck5Xpas+WUTKcgVziwoXvk4mwcKnDL6R9
         8wWMXu/8hQTKsrVumzEkoIzz72vKoykvr1dCEXrZvO6d3LMuEGYSXIL1eY/dtLQbeHPi
         vX4A==
X-Gm-Message-State: APzg51BMvv62a4VJt3GVmM0smFZJwYr8lkfwvMDssBNQF0xcBnYoCX6F
        nMihynmsu3RSffch7nxMzLM=
X-Google-Smtp-Source: ANB0VdY18iadIHSDzZCxDA5wQVs4eKCtT46Tfwh78r9+FJtD3Yta+2QlKgqDMpRmTYINsz4FL8LSRg==
X-Received: by 2002:adf:ad34:: with SMTP id p49-v6mr8838049wrc.10.1534774917818;
        Mon, 20 Aug 2018 07:21:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t69-v6sm17264356wmt.40.2018.08.20.07.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 07:21:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>, sunshine@sunshineco.com,
        git@vger.kernel.org
Subject: Re: Re* [PATCH v7 1/1] sideband: highlight keywords in remote sideband output
References: <20180807125108.104293-1-hanwen@google.com>
        <20180807125108.104293-2-hanwen@google.com>
        <xmqqd0ugc07x.fsf@gitster-ct.c.googlers.com>
        <xmqq8t54bzo4.fsf_-_@gitster-ct.c.googlers.com>
        <20180818060911.GC241538@aiede.svl.corp.google.com>
        <xmqqmutjagc7.fsf@gitster-ct.c.googlers.com>
        <xmqqin47acir.fsf@gitster-ct.c.googlers.com>
        <xmqqa7pjabvn.fsf@gitster-ct.c.googlers.com>
        <20180818232220.GA24533@sigill.intra.peff.net>
Date:   Mon, 20 Aug 2018 07:21:54 -0700
In-Reply-To: <20180818232220.GA24533@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 18 Aug 2018 19:22:21 -0400")
Message-ID: <xmqqa7phce4d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> In the longer term we may want to accept size_t as parameter for
>> clarity (even though we know that a sideband message we are painting
>> typically would fit on a line on a terminal and int is sufficient).
>> Write it down as a NEEDSWORK comment.
>
> This "typically" made me nervous about what happens in the non-typical
> case, but I think we can say something even stronger: the length comes
> from a pktline, so the maximum is less than 16 bits. I wondered if we
> might ever call this on the accumulated string from multiple sidebands,
> but it doesn't look like it.

I think a sideband packet may be split on one but not the other
codepath to result in multiple calls, but I do not think we coalesce
them together, so I agree that int is sufficient.
