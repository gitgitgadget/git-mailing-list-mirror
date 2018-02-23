Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E328A1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 20:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755141AbeBWUCD (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 15:02:03 -0500
Received: from mail-yb0-f173.google.com ([209.85.213.173]:46494 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754609AbeBWUCB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 15:02:01 -0500
Received: by mail-yb0-f173.google.com with SMTP id e142-v6so1121647ybc.13
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 12:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RXwoH9+j5UXHaQyzDWbYVYmZhsnxJvHz5kE2uXblBmk=;
        b=tHCWBHTurCY+Jc6NexhB9i8EZuf29lF/2EYmBjD98mTNh9iNu83g4QrQwZDIFVz+Fu
         3wNkIXX9mZd8HQj2bPG8dgVO6e9ItdJGSKklmy3ba/bhV24yLrZr/wAgnUcXfQgk9Am2
         hQ+7w6j5ArRMdnjq3na/2jMGrxAKE48UOysr05rWM/OYxhVdRyoc55/f2hL80W/IAX5w
         jxCH3KUhwt2olMxgOWI9sKpCcxlptbsGzOMiOKHBx06k8RQaWwoZOM/NWtcClNz/5I/c
         wOi9wYNhEQMn0uaAC3fE4VvA3YNDrSOkosweg6hLx0yt6zUPjA0lSSns6GaiuvUHpMu1
         pkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RXwoH9+j5UXHaQyzDWbYVYmZhsnxJvHz5kE2uXblBmk=;
        b=hGq4jplek7ca2kOm8UZZGReGGD7Mra/y7NSXllKARUSFED6ECXg1Ee6WHGL0EhucuU
         N3OdUQI6gfbF66LbITQ4RTkBc9h+s/ilIYhfiJdTksxtIp6EaUq/oZGL3OkDtSHA+M3O
         vP/wEWhVODBYvHbv8QRo9MxdZl5C/kJ33l6/dvMhAq7tNEYnP/zKhEYTs/oIJPXu+oeE
         kY36mB9XT/dU6/arc8caEiXxIcG+d4VEJJ+Ffm+DTrDhSN+g4bbQtHow82SMl0IVwCJd
         Xq/gDfvKhxpHFzyfmLrBK7CovpoHzf3FNSan7IbzpBU/A27HBtxDScZYZgnfCvMaMhfB
         Qpjw==
X-Gm-Message-State: APf1xPBrteD8RdjadaoGLn0LpwwLhwd36JbN+k95K9evTdVe918VtFpQ
        M7SBmZZ/4AoXJTIYCtRh1Wff1fMqHVSjdvypXycriw==
X-Google-Smtp-Source: AG47ELtniSF7H3zmNbUxl/Pq3rf4L8fP3xieLBvSLhO+aqSRSgwKA6Jm1FC6J//g4CPzlUD/e7kUs72iV+DznpJS3AI=
X-Received: by 2002:a25:7d42:: with SMTP id y63-v6mr2040422ybc.307.1519416119834;
 Fri, 23 Feb 2018 12:01:59 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Fri, 23 Feb 2018 12:01:59
 -0800 (PST)
In-Reply-To: <xmqqy3jmxb8s.fsf@gitster-ct.c.googlers.com>
References: <20180216174626.24677-1-sbeller@google.com> <20180221015430.96054-1-sbeller@google.com>
 <20180221015430.96054-6-sbeller@google.com> <xmqqy3jmxb8s.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 23 Feb 2018 12:01:59 -0800
Message-ID: <CAGZ79kZjOz0RcBHZDrT3g3Rjkx=Q94aj81Y+PGmjcB11oAn16w@mail.gmail.com>
Subject: Re: [PATCH 05/27] object-store: move packed_git and packed_git_mru to
 object store
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 21, 2018 at 1:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +
>> +/*
>> + * The mru list_head is supposed to be initialized using
>> + * the LIST_HEAD macro, assigning prev/next to itself.
>> + * However this doesn't work in this case as some compilers dislike
>> + * that macro on member variables. Use NULL instead as that is defined
>> + * and accepted, deferring the real init to prepare_packed_git_mru(). */
>> +#define __MRU_INIT { NULL, NULL }
>> +#define RAW_OBJECT_STORE_INIT { NULL, NULL, __MRU_INIT, NULL, NULL }
>
> I do not think it has to be this way to abuse two NULLs, if you
> faithfully mimicked how LIST_HEAD() macro is constructed.  The
> reason why it does not try to introduce
>
>         struct list_head x = LIST_HEAD_INIT;
>
> and instead, uses
>
>         LIST_HEAD(x);
>
> is because of the need for self referral.  If we learn from it, we
> can do the same, i.e. instead of doing
>
>         struct raw_object_store x = RAW_OBJECT_STORE_INIT;
>
> we can do
>
>         RAW_OBJECT_STORE(x);
>
> that expands to
>
>         struct raw_object_store x = {
>                 ...
>                 { &x.packed_git_mru, &x.packed_git_mru },
>                 ...
>         };
>
> no?  Then we do not need such a lengthy comment that reads only like
> an excuse ;-)

We cannot do this, because the object store is directly
embedded into the the_repository (not as a pointer),
which is a global on its own. So we'd have to do this
at the repository level, which I would not want.
I'd want to have the #defines where the structs are declared.

Any guidance on how to do that correctly with self referential
definitions without making the object store a pointer then?
