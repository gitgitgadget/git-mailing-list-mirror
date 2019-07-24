Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E9611F461
	for <e@80x24.org>; Wed, 24 Jul 2019 10:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfGXKlS (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 06:41:18 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37026 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfGXKlS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 06:41:18 -0400
Received: by mail-yb1-f196.google.com with SMTP id i1so9823542ybo.4
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 03:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N2+6gCN87VDHn8+X64mz1BK78xpLsnuCZQppp2xzTgQ=;
        b=dZ7QXhiZNFQKI1CJA3pmqSBFDl1uLZ/wXc81BJXpn129mn435E71tacpsxRcWuz803
         yXeHCOTUr6Mq+wivdBJah2Ug59sEOYrr9xWZ8rK2xjD/VGbSuWOWqRYOR5xkDwgvxDKx
         2/Jn/vlW260+IKk64DVmCtng7zt5EaqwWOYJMyhQOj4syq1tbc8hVvH6JUmuGNUqWNvg
         LvvF+YRB3/OyJALYujCVRCGavAdpdt11Gw6VUGI2wQLn85TqUhksAhOgwa9DCNXmBFK/
         OkYpHIKUOrDeW1A4Vi9e5OzKI9IEZkP108Z37pPoB10b6dt8fzUDsWN17jgK0h95rCmX
         j0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N2+6gCN87VDHn8+X64mz1BK78xpLsnuCZQppp2xzTgQ=;
        b=GdELJ/1ptvsH4wjHTzkoO81+ag9Y/wcHJGAqLL8iLVmDILVAEvXvM8zZYNeLn4k6IC
         2RX+KkOzbjmw5SmFoeyjEUIoTBStFkkms7VPTlh9RWtMqgOemdqtbwrnziJCzObec/iW
         xt3Jtd/5eH8hTAtpnihF/8qD5uPvlK3p7f/v6T95ZMl3YFAaL8wIxg7eKq+SNP5d4p8J
         JLpFeiKTanY9GY3sLnTUOcYYbyHZ41X6e96xy+INlOjeuT7bzjzhbyIFXTnpixPD9WaE
         dCN8X95f62PXXYE2+FzRh6zDPoizit6Q2bbyjQFcmQzTgljGHK94e2RTXYdy+7I5bffj
         NzSw==
X-Gm-Message-State: APjAAAWz5Zu1U/geelCwdlWxF2M4CU5T0kfHLI0vdcvNox9/D+F/umL6
        WpoHdR+e93PlHGjUKm9jdrQ=
X-Google-Smtp-Source: APXvYqw/A30UN2QAi5gTQkNTUyXLznZX5lOaX64Kw7iGwyvL5K9Yu+AOfH/YbtBtU/79MgQPXaGdtA==
X-Received: by 2002:a25:1c04:: with SMTP id c4mr47216263ybc.216.1563964877254;
        Wed, 24 Jul 2019 03:41:17 -0700 (PDT)
Received: from [192.168.1.12] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id y3sm10819607ywa.47.2019.07.24.03.41.16
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 03:41:16 -0700 (PDT)
Subject: Re: [PATCH 2/5] repo-settings: add feature.manyCommits setting
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jnareb@gmail.com,
        pclouds@gmail.com, carenas@gmail.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.292.git.gitgitgadget@gmail.com>
 <e00a1be75b410694374b0d9bd60ab16d67ef6d20.1563818059.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1907231544200.21907@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bd96b1f1-3369-e130-dbed-8634589cd8e3@gmail.com>
Date:   Wed, 24 Jul 2019 06:41:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1907231544200.21907@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/2019 10:53 AM, Johannes Schindelin wrote:
> Hi Stolee,
> 
> On Mon, 22 Jul 2019, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> When a repo has many commits, it is helpful to write and read the
>> commit-graph file. Future changes to Git may include new config
>> settings that are benefitial in this scenario.
> 
> s/benefitial/beneficial/
> 
>>
>> Create the 'feature.manyCommits' config setting that changes the
>> default values of 'core.commitGraph' and 'gc.writeCommitGraph' to
>> true.
> 
> Great!
> 
>> diff --git a/repo-settings.c b/repo-settings.c
>> index 13a9128f62..f328602fd7 100644
>> --- a/repo-settings.c
>> +++ b/repo-settings.c
>> @@ -3,10 +3,17 @@
>>  #include "config.h"
>>  #include "repo-settings.h"
>>
>> +#define UPDATE_DEFAULT(s,v) do { if (s == -1) { s = v; } } while(0)
>> +
>>  static int git_repo_config(const char *key, const char *value, void *cb)
>>  {
>>  	struct repo_settings *rs = (struct repo_settings *)cb;
>>
>> +	if (!strcmp(key, "feature.manycommits")) {
>> +		UPDATE_DEFAULT(rs->core_commit_graph, 1);
>> +		UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
>> +		return 0;
>> +	}
>>  	if (!strcmp(key, "core.commitgraph")) {
>>  		rs->core_commit_graph = git_config_bool(key, value);
>>  		return 0;
> 
> Okay, this one is tricky. The behavior I would want is for
> `feature.manycommits` to override the _default_. And if I set
> `feature.manycommits = false` (e.g. via `git -c
> feature.manycommits=false ...`), I would want the default to "go back".
> 
> So I'd really rather see this as
> 
> 	if (!repo_config_get_bool(r, "feature.manycommits", &b) && b) {
> 		rs->core_commit_graph = 1;
> 		rs->gc_write_commit_graph = 1;
> 	}
> 
> 	[...]
> 
> 	repo_config_get_bool(r, "core.commitgraph", &rs->core_commit_graph);
> 
> I.e. override the default only if `feature.manyCommits` was true *in the
> end*.
> 
> In any case, we really need to make sure to handle the `= false` case
> correctly here. We might want to override the setting from the
> command-line, or it might be set in `~/.gitconfig` and need to be
> overridden in a local repository. We need to handle it.

I had forgotten about this interaction. Thanks for finding it!

The way I would fix it is to add an "int feature_many_commits" to
the repo_settings struct, then check its value at the very end of
prepare_repo_settings() and then UPDATE_DEFAULT() for the settings
we want.

Thanks!
-Stolee
