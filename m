Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FD8F201A7
	for <e@80x24.org>; Mon, 15 May 2017 16:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757171AbdEOQ0k (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 12:26:40 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34089 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755119AbdEOQ0j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 12:26:39 -0400
Received: by mail-pg0-f68.google.com with SMTP id u187so17523573pgb.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 09:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ISMVvM08BztprUYh2M8mCo9NbYO8k7LYnNl0xRT2L7w=;
        b=Qyfd93u7QefNyGpDJJ4zuJj8Zo/dBUMvlAka4fdmlhhAujkxs1KCLQWk5Vtt8Irlst
         9+dJQoT8696MLg6PEffpEnbxblOv8podIA80z3G1ZhO8rMCfNkoHKjMXDjSP/cLWnGSb
         /ilorUZXP+Zeqx9WJieZAsD9MIj42nY1DLOw+NqtbnB7eL+KvwtWlXBAVmzNpI3BzUcb
         Q9oEde2FWhwyV3JCKrxPYOXDVflsac8FZvm4f9TNJSKVk5+kZXF9SUzYLQluyH8LSl89
         pU2S/QOPSkbcfZf7822TRAqEB6iTzzbYywPt0h3QUUTDsX6wj96PqlvMUh5l9rE3d/kx
         GWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ISMVvM08BztprUYh2M8mCo9NbYO8k7LYnNl0xRT2L7w=;
        b=RxYD3j5Jda1okeJ+l6nZk6a0LZ9bfShuz/vKaZdqahL5FLVUXdwpRXxSlovENy2DX1
         WvSsJVRQqTQmdF0BwU7xZ9Vuuh/qi6Jjp+RVCTSh/yOsXt0YeP9XQoVZK3t6GHKMW92b
         RjV4yXi644xxocBCHueL+iDPfl6c8odjxQf2hZKEXF7qVmodkAoL1KTd80kErSUQ2d8n
         SJ6tzAlZIBh+wKJk/AvvbQwCN3tOPklsRKHbG76wcrpWBHMN1x+TCmWrw763q3nVeweD
         GQkpCIxU6jOH8xw0halhdcCK3I3jb0ySLexIQCgt9pQQn56Df9dyPhJcOW8ezMf3Qv6u
         IMHw==
X-Gm-Message-State: AODbwcASW5CkCwP0l31/tXuqPuBdlsudKRLzh38jl63LD0vYJ1ARfREr
        RlBIBPqmFienHw==
X-Received: by 10.84.254.2 with SMTP id b2mr9725668plm.185.1494865598279;
        Mon, 15 May 2017 09:26:38 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:c572:fcdf:cbc0:6043])
        by smtp.gmail.com with ESMTPSA id 3sm4633289pgb.22.2017.05.15.09.26.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 09:26:37 -0700 (PDT)
Date:   Mon, 15 May 2017 09:26:35 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH v3] builtin/log: honor log.decorate
Message-ID: <20170515162635.GI27400@aiede.svl.corp.google.com>
References: <20170512221221.406645-1-sandals@crustytoothpaste.net>
 <20170514180058.842315-1-sandals@crustytoothpaste.net>
 <xmqqy3tyx2x5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy3tyx2x5.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> The recent change that introduced autodecorating of refs accidentally
>> broke the ability of users to set log.decorate = false to override it.
>> When the git_log_config was traversed a second time with an option other
>> than log.decorate, the decoration style would be set to the automatic
>> style, even if the user had already overridden it.  Instead of setting
>> the option in config parsing, set it in init_log_defaults instead.
>>
>> Add a test for this case.  The actual additional config option doesn't
>> matter, but it needs to be something not already set in the
>> configuration file.
>>
>> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>> ---
>> Changes from v2:
>> * Add a test.  I tested that the config parsing both works with
>>   additional options and also can be overridden from the command line.
>
> Thanks, all.
>
> Will queue with Acked-by by Alex and Reviewed-by by Jonathan.

For completeness: yeah, this version is Reviewed-by: me.  Thanks, all.
