Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8320620248
	for <e@80x24.org>; Tue, 19 Mar 2019 00:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfCSA4t (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 20:56:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34040 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfCSA4s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 20:56:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id o10so15513490wmc.1
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 17:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=uY1disP/T4qVmo3th3ZttH/3IzsfvdL8TuocC66SldM=;
        b=Us2tYpdfDZpcAYLwMUyV5SKDjTtC2OQC8hQjAJOcH4DCzRbSafr7gA1w4h8Nhc18NV
         j1Z1ZzTU39PAB2WLM9BO2TwUYSnKL9TsxTzoUwJ4te/7jLkydujo+aHKqUWbh8RI8htL
         6gvRtHFIpna6fgQNLJ3/VCcPgHS4hE8rtji0pVFs+RYAHhQK1F6GeibWi9m91SWCFwwz
         WN/eAg5MUrFw02GMx0xLYIE5SLV9dw/vLhHJiF4SxB/fCbHyaAPVN9EoGCw8lJu640K6
         0l7J+LY5ZxAiVTLDmtYFK8jFaF4DIx4p1H54pFRONEbDPYvjdpNibi8ELT+o9VYxrJnG
         4hIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=uY1disP/T4qVmo3th3ZttH/3IzsfvdL8TuocC66SldM=;
        b=d5Upq8Vdsgy5xlpQS0C0I3r398qWvZ6IE0/XyzO9mRdRQGyby0lshDipWh3gq5QkOB
         rGZWHa8JOnWge3Job+h4Z7bb/e+rMDa6vaEM+gZeVfeETzNC/wro1PSibJwqf+RQHyCP
         3et765wuYP0I+MiBw8l2z6yeg5NPzgBGcs4hsgpp6CtZDAXU8GW/csdrPS7UZnPASs3Q
         gjZwOZbqHTPFtKlp5CPOb6mdHwUU8q/uQ80g8LHXKPL56JW+f2fBaxnxiBlFBPS1neX/
         VG1VV6cVf5+LsIOO9B463vIkdl9kpZqCs4nNJPgxwFdt6omBiRL7uHb2hS9ddJVGXQPV
         rqbA==
X-Gm-Message-State: APjAAAXOEfZSaZdaBmrHSfEQBHAdhoBL18wLXc5S3oghzJdKWofyicZf
        6JUPCw/QU6N/YtRJH3F6ZtI=
X-Google-Smtp-Source: APXvYqxeeOOTM7MmsSrbdesIX9c5UV4DJ0XJRrJwm0IeAUWbwjegMvXfghJucxZRCH15g+CX6wrp2A==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr1227903wmd.126.1552957006468;
        Mon, 18 Mar 2019 17:56:46 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id o8sm900575wma.1.2019.03.18.17.56.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 17:56:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] git-diff.txt: prefer not using <commit>..<commit>
References: <bc7c3f9d769b2d5a108ff4cdc3c7277e112fdb56.1552820745.git.liu.denton@gmail.com>
        <87multaaac.fsf@evledraar.gmail.com>
        <CABPp-BGijBpyV9n4VxNi3QCddO-_4B-E1TUTi8wiqjQmqpU+Nw@mail.gmail.com>
        <87mulsdmsi.fsf@evledraar.gmail.com>
Date:   Tue, 19 Mar 2019 09:56:44 +0900
In-Reply-To: <87mulsdmsi.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 18 Mar 2019 20:07:09 +0100")
Message-ID: <xmqqy35by94j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Some of this thread's confusing, and on re-reading I see my reply hasn't
> helped much.
>
> To clarify. There's at least these things to consider:
>
> 1. What should the semantics of .. or ... be?
> 2. What semantics (regardless of syntax) should we recommend for common cases?
> 3. Depending on #1 and #2, can we make our docs less confusing?

Nice way to summarise.

> My opinion:
>
> 1. I'd ideally like to switch the semantics of ".." and "...". I don't
>    think anyone argues that it would be a bad thing in theory if we'd
>    started out that way, Whether it's worth switching now is another
>    matter.
>
>    Junio chimed in in <xmqqmum0h88n.fsf@gitster-ct.c.googlers.com>
>    saying he's not for it, so I'm assuming it's out for now.

I do agree with the "in the ideal world, where we didn't have any
existing users and had perfect foresight back when invention of
three-dot form for 'log' was even a few months away down the road,
we would have used diff A...B for the two-endpoints", and I also
agree with "that is 10 years or more too late now---don't waste time
even pondering about it".
>
> 2. I agree that we should generally recommend what's now "..." instead
>    of "..", whatever the syntax is to invoke that.

I do not agree with this at all.  When I want to compare what is in
devel and what is in master, I may be interested in two completely
different things depending on why I am doing the comparison.

 - I may want to know "what is in the development track that is yet
   to be merged to 'master'".

 - Or I may be looking for "what is the difference between the master
   branch and the development branch."

The latter should match the former if 'devel' and 'master' means
what we generally think they are, and by looking at the latter, I
can find what would be missed if I wholesale replace 'master' with
'devel' before merging 'master' backwards into 'devel' to make the
latter catch up.  So even in that context, I would prefer to see the
latter (needless to say, the start-up cost is far less for the
latter than for the former).

When we discuss a more generic "two endpoints comparison" whose
relationship between the two endpoints is not as well-defined as
'devel' and 'master' (i.e. what does it mean to compare v1.2.1 and
v1.3.4?), I can phrase in human-understandable terms what ".." does,
but not what "..." does.  I have no idea how you or anybody can say
that "we should generally recommend" that the former is the norm and
two-endpoint comparison is an exception.
