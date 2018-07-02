Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82E091F516
	for <e@80x24.org>; Mon,  2 Jul 2018 10:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030193AbeGBKgb (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 06:36:31 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39795 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965277AbeGBKga (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 06:36:30 -0400
Received: by mail-wr0-f193.google.com with SMTP id b8-v6so14998325wro.6
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 03:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s7cth09/oWTdr14tW+pKUKf2uwbpXMi8Ebs7iknTQZ8=;
        b=bKp9zeBje/qlJgDvJO9SvSrv8cslkslcXXQXsSqg9Spgf95SERcXvrFoK1ONiMBHU8
         4+0YY/mZcb0mNfQejhf+AKibFWqG6y/NgXswk43IBUOL2mSNrHxocV9cJ6F2J6WVXNwG
         s+ZJ8lclnZUgLWFOi+l0bKPkZ29iE7XVbSHrimfMEqlLQg5AN2zrFX7iTVwm5otXx4tj
         ZikflQOlohTJQ+tg3AOopehHzpZzMmaqdQyD4f0LGH7yD8QenwVfFiORJCGVZ5VVoDGN
         mNX1DQmjEchf8YRXIhdUv+0wQlavZWOw6ccmKvgys0px8xoxWkPtjPRnQBDzSnSwLw25
         wU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s7cth09/oWTdr14tW+pKUKf2uwbpXMi8Ebs7iknTQZ8=;
        b=T+af7pjILm3BhDPWbNEOkqf7LQvJj0PEx7ZZSA6PcTNWkjPQ9ihErZzREG5ccZjOCP
         MczUiZb7UUBNT5Zf+urxexI6SsQFe+byiJ2b9lrrXRpNwhGxVumiqXNaTuXZh0JUXu/Y
         dFStCVujjLgJ5aFSCVJ2SCvYvN9Yf9mdW8ZdsnhzY/CPVNZYDMIG+PmoU+A6bd17+PQe
         2kjZJ+y0TI6DIqwCiSdx8qSsf/hx2x/EbUVeb/q3lwZTY7HCLog8QUv81AUbgBVy7kr0
         qTgTwbCt0oQ6bQ7juuXDOCepe21IIt3SM1Gtmod4LRnVFc93x/UP1kETenc5wl59Ynxk
         /FYw==
X-Gm-Message-State: APt69E3/ikBTTrisorbbyiJ0yXvzbKXSTQ/c15o22iJs+VU3S6O8cYvb
        Nc8QgAxj8sdVTLEq5pfrFoe1hxLg
X-Google-Smtp-Source: AAOMgpcaBi/W+xUfzrMNwLB0GJgbi1io0KifSQy8tGEDhuxjDvU1bqwUeWYZWZissGaq2t+FEthJCg==
X-Received: by 2002:adf:c00b:: with SMTP id z11-v6mr18467788wre.268.1530527789042;
        Mon, 02 Jul 2018 03:36:29 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-72-143.w92-156.abo.wanadoo.fr. [92.156.124.143])
        by smtp.gmail.com with ESMTPSA id e17-v6sm20373934wrr.85.2018.07.02.03.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 03:36:27 -0700 (PDT)
Subject: Re: [GSoC][PATCH v5 0/3] rebase -i: rewrite reflog operations in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
References: <20180625134419.18435-1-alban.gruin@gmail.com>
 <20180629151435.31868-1-alban.gruin@gmail.com>
 <xmqqr2kpv8ft.fsf@gitster-ct.c.googlers.com>
 <xmqqzhzdtpt4.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <e703f571-4966-f3aa-da81-fae1962c8906@gmail.com>
Date:   Mon, 2 Jul 2018 12:36:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqzhzdtpt4.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 29/06/2018 à 20:23, Junio C Hamano a écrit :
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Let's aggregate these topics into a single topic, and perhaps call
>> it ag/rebase-i-in-c or something like that.  Pretending as if they
>> are separately replaceable does not make much sense, as you are not
>> rerolling the earlier one and keep going forward with producing more
>> parts that depends on the parts that have been submitted earlier.
> 
> So here is what I tentatively did.
> 
>     $ git log --oneline --reverse master..ag/rebase-i-in-c
>     4d303fb608 rebase--interactive: rewrite append_todo_help() in C
>     b4ffe143a9 editor: add a function to launch the sequence editor
>     4ebe39cef9 rebase--interactive: rewrite the edit-todo functionality in C
>     0ff6bf7646 sequencer: add a new function to silence a command, except if it fails.
>     36784b351f rebase -i: rewrite setup_reflog_action() in C
>     415cac57ee rebase -i: rewrite checkout_onto() in C
> 
> In several hours please fetch from me and look for "Merge branch
> 'ag/rebase-i-in-c' to pu" to see how they exactly look like; some of
> the patches might not be the latest ones, in which case you may need
> to prod me to get them replaced (resending them as a whole with
> incremented v$n header is probably the easiest if we need to do so).
> 
> Thanks.
> 

The patches about append_todo_help() and edit-todo are not up to date,
so I’ll resend them in a few minutes.  Otherwise, this looks good to me.

Cheers,
Alban

