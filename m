Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D37B01F609
	for <e@80x24.org>; Wed, 19 Jun 2019 11:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfFSL6U (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 07:58:20 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38915 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfFSL6U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 07:58:20 -0400
Received: by mail-yw1-f68.google.com with SMTP id u134so8166229ywf.6
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 04:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=N0ktz8kayEve2dvv2BmXtwD37qZADLcw/7DRJcRwc18=;
        b=OENuisNDRXnkQhDwaZceYlRGmBI7krjfKHqfzeC7n4mZFxgK8v7W2iIIdTwX1bJUh8
         WaiGXy4jeUEL93ze8B6OXCsgMr984CgHAKFTqwWfkMrhhUpkqZiYdOvDYQkWr51Nbn5+
         A+ojMFMqSEeexJkI/qVQf3iZSSMAXzKnO7MDJQE/cz1Rf2qcultT7t+jAR6TVgoCcmO8
         z/DCLmfnxbjv0grW6jqW2cWiCm2LOSHiBja2rOeiesC9oqq+GZJohp8C6RDUQWOiu45i
         w7nFucTvJDjEH/rEMH1NA+oGV7OhXphHj/S1DM8bEdzT2OcuybIk+oUImoouw7/dDrUs
         5RAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N0ktz8kayEve2dvv2BmXtwD37qZADLcw/7DRJcRwc18=;
        b=kVMQieD7Ynf66BD3++eQ4QQdMimqUnJ1y596uZRVM2FpOw7WCCr28WzopoJpIGANBu
         Cb3hW7XtcHMW1qXEB2P7ESTfXsEvJhJy2w81fZGmwH5pkzk1U75LSF9g8KWrXzJxWEi7
         sNpNtQUwKzhTKFPgG6PlEr+Rurn3g2HtE0FjEq9qS8rky9jsNLej5ncKJlRzAvaxm259
         SsNv+1iW7dsRmGNXjabKbTx60vAWwsolAYy9AmQKN4PSLHvoLUWm0/pr4JSSC1c6f1tb
         JV3pdH+aplFaf55bySErH+R1gMC4+071eIdJh+bGUthj7D539y3N+trTY89oDwd1zs/h
         /lHA==
X-Gm-Message-State: APjAAAXtu3ljXtCfjri+9Cb51y4tyTpZXhw+sl3oV22NHXMVL9+LIso0
        p0FQTYklr25ZKXkjaiEY8IM=
X-Google-Smtp-Source: APXvYqyhj1d+K/lNS8W3peaEQK4E7IsyNWuJ2pVJuYSWqnNHci6DEOTrQngqKJdFg7jPHVjVTh51aA==
X-Received: by 2002:a81:88c2:: with SMTP id y185mr48360707ywf.177.1560945499634;
        Wed, 19 Jun 2019 04:58:19 -0700 (PDT)
Received: from [192.168.1.16] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id k6sm4517450ywf.22.2019.06.19.04.58.18
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 04:58:18 -0700 (PDT)
Subject: Re: [PATCH 0/8] Add 'ls-files --json' to dump the index in json
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org, kewillf@microsoft.com
References: <20190619095858.30124-1-pclouds@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a5d2d2e9-a22f-9ab8-f88f-9c8c8520735d@gmail.com>
Date:   Wed, 19 Jun 2019 07:58:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190619095858.30124-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/19/2019 5:58 AM, Nguyễn Thái Ngọc Duy wrote:
> This is probably just my itch. Every time I have to do something with
> the index, I need to add a little bit code here, a little bit there to
> get a better "view" of the index.
> 
> This solves it for me. It allows me to see pretty much everything in the
> index (except really low detail stuff like pathname compression). It's
> readable by human, but also easy to parse if you need to do statistics
> and stuff. You could even do a "diff" between two indexes.
> 
> I'm not really sure if anybody else finds this useful. Because if not,
> I guess there's not much point trying to merge it to git.git just for a
> single user. Maintaining off tree is still a pain for me, but I think
> I can manage it.

I think we (Microsoft/VFS for Git engineers) would use this tool, as we
frequently need to diagnose something that went wrong in a user's index.
Kevin Willford built a tool to search the index and figure out what's
going on, but I'm not sure it parses all of the new extensions or was
updated to parse the v5 index.

Having a translation from the internal index format to an easier-to-parse
format is valuable.

Thanks,
-Stolee
