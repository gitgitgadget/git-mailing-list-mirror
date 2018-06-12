Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0432A1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 12:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932565AbeFLMdI (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 08:33:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38276 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932543AbeFLMdH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 08:33:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so22954638wmf.3
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 05:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QqW008WRvcZ6UKzBt+dsXNj47es/ctV49I6V8QdqWKc=;
        b=cVmNWjr+2XxAHbPSP8upzahGcrcOxkd2RJWyK0v4hhw/GfVpIZAqOg5BDi6gyewVtz
         Wv8W48BJu4ge+p+0W+V+oF9KlSJK4ZWhPN/KpwxUcP69mj0JhZUTkLsgGSy4ZramC5KR
         /akKW9u3lEaGfA8bZfLzz3yk81tvBo8PY0nUnmZ+shFwrwZOj6jK7KA9m9iX6XNr8EMN
         5A56rZcOByY1LaY9vpbZyvnDTvwizIlXDEcOkuWAMPsqcjKGIYdDj7Rj0rBfbRy4oxfp
         jBzONuPUZIWIymEBdZPdHxloCIbKKptblptsXfIdN4vIVMXW3Va7a4bMIojpDgnhjD8o
         MNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QqW008WRvcZ6UKzBt+dsXNj47es/ctV49I6V8QdqWKc=;
        b=YkN1imm7XNdZFqnK3F8KVujuTWtaXpRuxxvMJKvhIAyqb8PpBvTlLR+sPQ3CsHEnTV
         KX+GcgTdXok50YOYS/m/n400ogZoMhCH95JJLDk1cYoKq4PNmKGL2b8mC9lTSzMnA/H1
         /FPNkjjdx/8Ig1sJ6Rk9VTCUxgXBAnKRPjAV3Vq3yRNsBW/a/RqZXObLJIX3378GY88T
         xpF2Dx+Cb3dTVaCBYeV6ts+CWOQj5JOSu5UHW72doAb57sL3ZmII4RqvKvEGoYL5/de0
         4JrF3JqgYhkmouDomqHf6LvowfrgyITW2oIMqwkrA5VSIMoXZWRLVD4kWm6XLSXXrw1b
         P5Ig==
X-Gm-Message-State: APt69E2YH9695ISYPiF5yF4mtEY1hFferpQWYyR8sLaSc+I0sN38gelj
        fbbej6MuSsxud/xFaKnvHbc=
X-Google-Smtp-Source: ADUXVKJ290dhAcBjpDYl3SAAp3H1sRAeVb3cL7K1KUVaGUKrIN3xhpkG2iKOzZbe+JGiK7qDdZ/waw==
X-Received: by 2002:a1c:5b4e:: with SMTP id p75-v6mr144144wmb.3.1528806786454;
        Tue, 12 Jun 2018 05:33:06 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-25-147.w86-222.abo.wanadoo.fr. [86.222.24.147])
        by smtp.gmail.com with ESMTPSA id 72-v6sm79242wrb.22.2018.06.12.05.33.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 05:33:05 -0700 (PDT)
Subject: Re: [GSoC][PATCH 1/1] rebase--interactive: rewrite the edit-todo
 functionality in C
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
References: <20180611135714.29378-1-alban.gruin@gmail.com>
 <20180611135714.29378-2-alban.gruin@gmail.com>
 <3bfd3470-4482-fe6a-2cd9-08311a0bbaac@talktalk.net>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <801da146-6905-5f7b-12c0-7239108b6207@gmail.com>
Date:   Tue, 12 Jun 2018 14:33:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <3bfd3470-4482-fe6a-2cd9-08311a0bbaac@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Le 11/06/2018 à 17:32, Phillip Wood a écrit :
>> +    if (launch_editor(todo_file, NULL, NULL))
> 
> I'm not sure that this will respect GIT_SEQUENCE_EDITOR, it would be
> nice to have a launch_sequence_editor() function that shared as much
> code as possible with launch_editor()
> 

It could be done by making launch_editor() and launch_sequence_editor()
some kind of wrapper around a function like launch_specified_editor()
(or something like that), that would take the editor as a parameter, in
addition to the path, the buffer and environment variables.  It would be
also very trivial to implement your first point above on top of that.

>>   int append_todo_help(unsigned edit_todo, unsigned keep_empty);
> 
> Can this declaration be removed now?

No, it’s still used in rebase--helper.c for now.

> 
>> +int edit_todo_list(unsigned flags);
>>   int skip_unnecessary_picks(void);
>>   int rearrange_squash(void);
> 
> Best Wishes
> 
> Phillip
> 

Cheers,
Alban

