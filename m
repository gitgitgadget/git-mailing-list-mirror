Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFDC321847
	for <e@80x24.org>; Wed,  2 May 2018 01:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750859AbeEBBgf (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 21:36:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38744 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeEBBge (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 21:36:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id i3so21399360wmf.3
        for <git@vger.kernel.org>; Tue, 01 May 2018 18:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=hq2SmlQijnpc/8grBN18J5CDLDIrsByC3LH/jMzIMjs=;
        b=m0PD7Z3KPfPVHQyC2kPUF3b/Dp1rHlmtBqXBJK/aJFLSIlzXPlQ+65pmxISPILS2B9
         S174UParddOkl1fgH/HFiF1IEuWUfX00dHnEuI9fj7uYbpn60DI1M5B0yNLWAxmpVP7g
         rHYAbbvgaShgHOjd0iNbHUNHLXXnG660Fc+CIqtPLD3odRB756IUHfhLKJm/1SA3nabv
         39ho6nheKplbljsTrGGxX5NLtXYH9fzG2xjIyHClmfVVWQeZ64pImygRvPu3aJdNBA3i
         sxv6eJElZdTBytHZWgQfIM9AnQvHKSI+jNlaSBz+SmUjgR3K1JP0/sdcl686iKDTpGp+
         OL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=hq2SmlQijnpc/8grBN18J5CDLDIrsByC3LH/jMzIMjs=;
        b=Y83IeJUH4QdoCOUJZuRg/q1dwUY+vJ5gM22/ycof+kyPPW+XlreMlMiQPPcigAx18N
         eoZpsp5Ah5Cz+1HIZ09eyDOaPaC2wszPkpANTSXqpuh6FwRJ2laRvD6WzOaaTHl0FvBQ
         baZVNBnCuEiWHPmCfJsFhGWWAz5YLGUl22eQJbBqTPrIRNbKdYbT1rwsRtckOkauEYMC
         ZQQi7+dmPbmk6/IP+C7zv5wOIHs+9zGTwBDE+l//Xhng3a4Zx+mPoxmHw4nKx4LLIXMI
         7dT2HS7oWocbK+oz630lHCrXQE/Gn+aKcXjZdRaEkrNL3DiwY4BhYXKqyCW0E9UEn18/
         9zNg==
X-Gm-Message-State: ALQs6tA1rJZw42/C+v/n4DYWY5g4mhxIKKxhkcUvLt1a13i8aWkXtMVZ
        IRmbeNUZnO1YsZ+9317vgao=
X-Google-Smtp-Source: AB8JxZpOa8MEtZNgoOMi5imehO+evfJxLcNTzam9+bNadZ8Asj0lQdHJCoiV5XO9//6eiLC1KGCcIA==
X-Received: by 10.28.18.71 with SMTP id 68mr10141758wms.74.1525224993112;
        Tue, 01 May 2018 18:36:33 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d9sm20474656wmh.38.2018.05.01.18.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 18:36:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2018, #04; Mon, 30)
References: <xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com>
        <CAM0VKjmkn7eyooKheOEQnS=6HMZSTbhejoxQdKB7W+n=7D5KuQ@mail.gmail.com>
Date:   Wed, 02 May 2018 10:36:30 +0900
In-Reply-To: <CAM0VKjmkn7eyooKheOEQnS=6HMZSTbhejoxQdKB7W+n=7D5KuQ@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Mon, 30 Apr 2018 15:33:55
 +0000")
Message-ID: <xmqq8t92yh29.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Mon, Apr 30, 2018 at 5:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * js/rebase-i-clean-msg-after-fixup-continue (2018-04-30) 4 commits
>>   - rebase --skip: clean up commit message after a failed fixup/squash
>>   - sequencer: always commit without editing when asked for
>>   - rebase -i: Handle "combination of <n> commits" with GETTEXT_POISON
>>   - rebase -i: demonstrate bugs with fixup!/squash! commit messages
>
>>   "git rebase -i" sometimes left intermediate "# This is a
>>   combination of N commits" message meant for the human consumption
>>   inside an editor in the final result in certain corner cases, which
>>   has been fixed.
>
>>   Will merge to 'next'.
>
> This topic branches off from v2.16.3.  However, its last patch uses
> the sequencer's parse_head() function, which was only added in
> v2.17.0-rc0~110^2~6 (sequencer: try to commit without forking 'git
> commit', 2017-11-24), in topic 'pw/sequencer-in-process-commit',
> leading to compilation errors.

For a low-impact and ralatively old issue like this, it is OK for a
fix to use supporting code that only exists in more recent codebase
and become unmergeable to anything older than the concurrent 'maint'
track as of the time when the fix is written.  Even though it is
sometimes nicer if the fix were written to be mergeable to codebase
near the point where the issue originates, it is often not worth
doing so if it requires bending backwards to refrain from using a
newer and more convenient facility.

Thanks for catching my wishful thinking and carelessness before it
propagated to 'next'.  I try to check tips of individual topic
branches and also the integratoin result, but sometimes I get
trusting too much and get sloppy when dealing with too many topics
in flight.
