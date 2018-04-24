Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3BA11F424
	for <e@80x24.org>; Tue, 24 Apr 2018 05:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755584AbeDXFBc (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 01:01:32 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46063 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752045AbeDXFBb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 01:01:31 -0400
Received: by mail-wr0-f196.google.com with SMTP id p5-v6so19072111wre.12
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 22:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2OgKgIXwFYoQHLNh0MLhJaR3RIkOpWNlwAosFaNk+aw=;
        b=upQF5CqmEPZGUvBmt3NU+yo7fQyz/GcdMAAHwVjOnBWOTGpOp45GS/8r1F6TWOmTQz
         SnC+bmWzprBPE2hMEr1G9FtbtcfZhMcuRLJTo8TEb9y0BF/NckmzKDq2lssXkOLQkbs2
         YAaRz5dTnmUNMqdjo+5AWQX2TpCNznvNjWCWPmlydUCHUbbSnshIXFE/A4hsspxELOnX
         BNa7TFshz8BXjFI1bC6AeF0ijXbNwqvA8sgi3ahzZ0OgzLylw7Z553PNEdpd7SBDdsh8
         m81GuI7+2yiKp3Oth8lpFk8Lj3RXt+38fRtlCi13ubVLdor5dbkKk2RUy3ym7DZoNn4S
         5COw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2OgKgIXwFYoQHLNh0MLhJaR3RIkOpWNlwAosFaNk+aw=;
        b=JVgOmGV17l5LeesEXVXeqZXO0jYJ43I6C1YswcDuf0Mzneno2K5xIYKijvYbVo1zQa
         uky2HZNOtGGHiI3XpcFHjwlTTBfKiGlC5l1ZyIvk9mwL1ebkLB8iSPB/voDLDNBmgjKj
         LyJTJAcwBdBZKUy3wpi3MhTMQhu+8sv9ZDyfJB293nEQhGL5wat9lYSPSlNRIkEBYDn/
         mNFqKq0YKSkiDXcqju1dEMlVJmBC1Je0b75s2Ghun0k0h64xQRnHXFugstdk+AJGP7lr
         UsL/RrmfuQz/TPx37sooiehiPErrBheh9zTa0gCZaMnQaBQphvqcft3taf+d1k0Hm01Z
         BbAA==
X-Gm-Message-State: ALQs6tCbTIYzt9lOYdil/z1u5KxEhdgHDTIkgYqNKn3Gxf6sTp/yYuGc
        wZZQW/GAvi8HVEcgT4P72ww=
X-Google-Smtp-Source: AIpwx48XoFhp9r5FFKZDkcfOXCnUVDjCr4lpbjaU179SFXz2KWIsV3LY3lj74vGhTkS/plMlHQTaMQ==
X-Received: by 2002:adf:e249:: with SMTP id n9-v6mr13283953wri.270.1524546090051;
        Mon, 23 Apr 2018 22:01:30 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k30-v6sm35483904wrf.1.2018.04.23.22.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 22:01:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        "Git List" <git@vger.kernel.org>,
        "Jacob Keller" <jacob.keller@gmail.com>,
        "Stefan Beller" <sbeller@google.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Phillip Wood" <phillip.wood@dunelm.org.uk>,
        "Igor Djordjevic" <igor.d.djordjevic@gmail.com>,
        "Johannes Sixt" <j6t@kdbg.org>,
        "Sergey Organov" <sorganov@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v8 09/16] rebase: introduce the --rebase-merges option
References: <cover.1524139900.git.johannes.schindelin@gmx.de>
        <cover.1524306546.git.johannes.schindelin@gmx.de>
        <0c92bdd1829328544269722cbbd3edcd169bb148.1524306547.git.johannes.schindelin@gmx.de>
        <E8BADD438B3F4D20B33BCC2CD92BC004@PhilipOakley>
Date:   Tue, 24 Apr 2018 14:01:28 +0900
In-Reply-To: <E8BADD438B3F4D20B33BCC2CD92BC004@PhilipOakley> (Philip Oakley's
        message of "Sun, 22 Apr 2018 15:15:27 +0100")
Message-ID: <xmqq1sf56vvb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

>> +-r::
>> +--rebase-merges::
>> + By default, a rebase will simply drop merge commits and only rebase
>> + the non-merge commits. With this option, it will try to preserve
>> + the branching structure within the commits that are to be rebased,
>> + by recreating the merge commits. If a merge commit resolved any merge
>> + or contained manual amendments, then they will have to be re-applied
>> + manually.
>> ++
>> +This mode is similar in spirit to `--preserve-merges`, but in contrast to
>> +that option works well in interactive rebases: commits can be reordered,
>> +inserted and dropped at will.
>> ++
>> +It is currently only possible to recreate the merge commits using the
>> +`recursive` merge strategy; Different merge strategies can be used only
>> via
>> +explicit `exec git merge -s <strategy> [...]` commands.
>> +
>> -p::
>> --preserve-merges::
>>  Recreate merge commits instead of flattening the history by replaying
>
> Flatten is here in the context lines but its just a blunt statement that 'it
> is what it is'...

The first paragraph that explains --rebase-merges talks about what
happens when the option is not given, and says "drop merge commits
and only rebase the non-merge commits", which is not incorrect
per-se but does not make it explicit how the resulting topology
looks like.  I think it is easier to understand if it mentioned
"flattening" as well.  If flatten is not the word you want, perhaps
"make it linear" or something like that?
