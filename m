Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF2711F404
	for <e@80x24.org>; Tue,  3 Apr 2018 21:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753577AbeDCVik (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 17:38:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52669 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752813AbeDCVii (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 17:38:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id g8so12588668wmd.2
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 14:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9r4PMig0GKVCbpEAPGjZKVL9Dqok4ZUzrKj0jourV38=;
        b=FHEEWgWErYW/tv5G6CkDnkmsb1W+R47qbqbIDDyDfrGLcpJ3Cdqjc7pAqquBIs60jU
         KDHzgQMqUhPQ3/g+BkhhJ5zWpFXCjf6UktYXo5bmVjWfW5xYvz/cOjc20R6UcCBpEPkQ
         Ba8hjiqjp0ri8fi9ISRNXFKmFV3WPNLXugYuHHQwYuSusd/eLlr/VVb7YVeZ7HuV3H0N
         9Gg/ZVTMGraCPxs90GzYFPKfGIQKojRONSMB9IXisyTXb2frCwBKy72i2G61z0idF+z5
         +KAW4rZ0myCcHsaydVqXqyawURgBvRXc7YIT+8QlKmYj6ucOWBCzrgWLW0w1mMV9IviM
         4ILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9r4PMig0GKVCbpEAPGjZKVL9Dqok4ZUzrKj0jourV38=;
        b=n0gmGDz1Ooka89IpjH/RnolKlxLrAWIQ05aTM8E3NVdFBS2vwXBYmj/GUEvrGU4aV9
         tCzvFS3f9ra3UZNH+67CtCR9qNgYh2+qnzlvEhI4n56d7zEaLE9R7firvVey1Mz5m8eT
         Js8TJfoGIJk405IhYkYJ2wvmv2wSqAJGv+uVRgUeKdkVD7DVPnlCKAAPgsLW3XP87s3n
         rjGwzo3XbhozgimMHC5RrEXuYOvdNPN3auh6f3XpdaqeJz5ucm8sd3v9A1LoTvJHULCJ
         fs4Dv+IqW5JQWdSMk2cr+MD1O/DVnqq6tLH9z65I/iNIYgL/jhcrGSYv5Fr3KnGLe9Ny
         HmSg==
X-Gm-Message-State: AElRT7GgQCPE7hcazHf1XmVIZRfXwKReSdizmFtZTgst53U7cUcStEli
        kEgPk40/+/xKHmMKZlGdbm9KeuWh
X-Google-Smtp-Source: AIpwx48bSlscADppIopwrsqEqeG5U2eKAjrpLlTPEBO5AK4MiRU123uwnWe9HgRt1ORkgzfEt2X7eg==
X-Received: by 10.28.132.7 with SMTP id g7mr5112635wmd.109.1522791517489;
        Tue, 03 Apr 2018 14:38:37 -0700 (PDT)
Received: from [192.168.0.103] ([92.55.154.10])
        by smtp.gmail.com with ESMTPSA id u110sm5393642wrc.72.2018.04.03.14.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Apr 2018 14:38:36 -0700 (PDT)
Subject: Re: [RFC][PATCH] git-stash: convert git stash list to C builtin
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <20180324182313.13705-1-ungureanupaulsebastian@gmail.com>
 <CAPig+cS9QwCOG7BA7O5Nu_zsh-xTbDFy2vTWpAXxBuKTY-uzUw@mail.gmail.com>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <63772b7d-7b1e-2a3a-b12c-2dae9e254b68@gmail.com>
Date:   Wed, 4 Apr 2018 00:38:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cS9QwCOG7BA7O5Nu_zsh-xTbDFy2vTWpAXxBuKTY-uzUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 25.03.2018 10:08, Eric Sunshine wrote:
> On Sat, Mar 24, 2018 at 2:23 PM, Paul-Sebastian Ungureanu
> <ungureanupaulsebastian@gmail.com> wrote:
>> Currently, because git stash is not fully converted to C, I
>> introduced a new helper that will hold the converted commands.
>> ---
>> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
>> @@ -0,0 +1,52 @@
>> +int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>> +{
>> +       int cmdmode = 0;
>> +
>> +       struct option options[] = {
>> +               OPT_CMDMODE(0, "list", &cmdmode,
>> +                        N_("list stash entries"), LIST_STASH),
>> +               OPT_END()
>> +       };
> 
> Is the intention that once git-stash--helper implements all 'stash'
> functionality, you will simply rename git-stash--helper to git-stash?
> If so, then I'd think that you'd want it to accept subcommand
> arguments as bare words ("apply", "drop") in order to be consistent
> with the existing git-stash command set, not in dashed form
> ("--apply", "--drop"). In that case, OPT_CMDMODE doesn't seem
> appropriate. Instead, you should be consulting argv[] directly (as in
> [1]) after parse_options().
> 
> [1]: https://public-inbox.org/git/20180324173707.17699-2-joel@teichroeb.net/

It makes sense. In the end, when all stash is converted, it would just 
require an additional pointless effort to bring (back) from dashed form 
to bare word form.

>> +       argc = parse_options(argc, argv, prefix, options,
>> +                            git_stash__helper_usage, PARSE_OPT_KEEP_UNKNOWN);
>> +
>> +       if (!cmdmode)
>> +               usage_with_options(git_stash__helper_usage, options);
>> +
>> +       switch (cmdmode) {
>> +               case LIST_STASH:
>> +                       return list_stash(argc, argv, prefix);
>> +       }
>> +       return 0;
>> +}
>> diff --git a/git.c b/git.c
>> @@ -466,6 +466,7 @@ static struct cmd_struct commands[] = {
>>          { "show-branch", cmd_show_branch, RUN_SETUP },
>>          { "show-ref", cmd_show_ref, RUN_SETUP },
>>          { "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
>> +       { "stash--helper", cmd_stash__helper, RUN_SETUP },
> 
> You don't require a working tree? Seems odd for git-stash.
> 
>>          { "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
>>          { "stripspace", cmd_stripspace },
>>          { "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX},

For now, I do not think that it is necessary (for stash list), but I am 
pretty sure that it will be required in the future when porting other 
commands.

Thanks for advice!
