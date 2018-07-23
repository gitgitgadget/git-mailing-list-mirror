Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF4661F597
	for <e@80x24.org>; Mon, 23 Jul 2018 16:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388744AbeGWR7c (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 13:59:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33449 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388236AbeGWR7c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 13:59:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id b17-v6so210599pfi.0
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 09:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NwGoIz2cSDcnYAAPj9loM6/tO1lCeZHY8qvDyIoDA4k=;
        b=WR9ffq9Alk583HyX6oSuU8i2WoaTZVXg/gz161dg/4u5MHm6HI07hRu/pOhRY2TgA2
         LQD90gRHZ9JZFJBg1QTO59QFKeViDbwhgX2DsEWeGB9fTEFD12jP4ZRJiSqO+BrDDpdp
         tn/C9wISbIGicqRUqMY5TxvWNEzPXIDUEA9dhVsoM611zkA3zlYSrJkferUdtDNgishq
         KB3XkDB5RU9fGC0lqACZ9fuaEGqvdkEW2fRm3zA8y7zCX/GE0YPeYiFgiObC7tzf+4Lq
         mihQw5Gl3bbIzzgtXT0khRz4pkS1RqlwMmU1qiChrbPyX8yf9fjgGe09HAjqsiDAMY7t
         Li/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NwGoIz2cSDcnYAAPj9loM6/tO1lCeZHY8qvDyIoDA4k=;
        b=EDyLyLhMyBaBeGVS3V38+sc8Y9oA+6MQxlyuVGQEg8j3LL/CfRnEKA3dodSFV1Njoe
         +/aO5iQgNGPjhypys83WkIwR9fGytgF8ROjqWGoaDYCl4noN3g/FDOvTDftY+oWsSXLZ
         KbIqjIpYORy8Hnfustiv0q0CL0Y2W6oygRnDR8qObD5TgJC7qodAG4CUOK4LMa6tUdzO
         GAthznYSqYrdKIkD9XTlJI9crVPBs6v1dGnfR7VQfx7k2ULwyuwiIOORDMNj8HOBSHjU
         Wu7Ydv8wrqIxdaoZdZCROEyiAjkOjvvHon43eyStWacJNn17vNZMxJ/YhT5zDhdeRRea
         0Kbg==
X-Gm-Message-State: AOUpUlFaKGpqz93H17XAUKL7x+lWvrszQ+HY1h8o60PHkY8o7iY5xfkQ
        Xq4EeWYWAcNHpplEoKqpoNDpnJBB
X-Google-Smtp-Source: AAOMgpfej8sHMa6R9DhgWBEud8I25AI/bDE1dqtwiO5UOI4rjvomr2N63QHVPtITEcGG8EdwWjfztw==
X-Received: by 2002:aa7:82c3:: with SMTP id f3-v6mr13959647pfn.136.1532365045720;
        Mon, 23 Jul 2018 09:57:25 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id e8-v6sm13280891pgi.24.2018.07.23.09.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 09:57:25 -0700 (PDT)
Date:   Mon, 23 Jul 2018 09:57:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/9] contrib: add a script to initialize VS Code
 configuration
Message-ID: <20180723165719.GA16420@aiede.svl.corp.google.com>
References: <pull.2.git.gitgitgadget@gmail.com>
 <e2e449a00385531d326d6811a871dde59624b818.1532353966.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2e449a00385531d326d6811a871dde59624b818.1532353966.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks for working on this.

Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> VS Code is a lightweight but powerful source code editor which runs on
> your desktop and is available for Windows, macOS and Linux. Among other
> languages, it has support for C/C++ via an extension.

This doesn't really seem relevant to the change.  The relevant bits
are that (1) VS Code is a popular source code editor, and that (2)
it's one worth recommending to newcomers.

> To start developing Git with VS Code, simply run the Unix shell script
> contrib/vscode/init.sh, which creates the configuration files in
> .vscode/ that VS Code consumes.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

This doesn't tell me what the patch will actually do.

VSCode is an editor.  Is the idea that this will help configure the
editor to do the right thing with whitespace or something?  Or does it
configure IDE features to build git?

Thanks,
Jonathan
