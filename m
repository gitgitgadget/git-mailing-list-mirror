Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 117841F597
	for <e@80x24.org>; Mon, 30 Jul 2018 20:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbeG3Vwq (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 17:52:46 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33002 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbeG3Vwp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 17:52:45 -0400
Received: by mail-qk0-f194.google.com with SMTP id 27-v6so8725040qkv.0
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 13:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0ShDFDLAuPyhdkl7fhri8Uac+0weAIFNkXS4C2ydmzI=;
        b=l7pQHsUemjTmv+yentqSsji5s1zEw0FK8GKqXPteXP76gZgoyWwcN/BfvwWw1CYkFU
         YUySn6LK9y7KxQFffO8Pqd6McI5+awKL6Gy0Mml1dySybhTuQh0/nO+6OZgw1vocP1d7
         gEZEjjjDlvigKOXusXBPWpOSuMjog+Us4yjJmrfblHzkDxIjdlm6iVm33AD7ZAMJHVM5
         dtEGdg4TqFkvUKW8zvNiipDJ4sSCGA/hYlP6d+JhiqXL+lfOvKfN7D1ec/PVNZjruJwT
         ZOZrWT0gtfeG/1nNYowlRi/FOWhv2fQc2BUdraSrcPmVIuX4juWPToztIvOUBbCzyGz2
         IQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0ShDFDLAuPyhdkl7fhri8Uac+0weAIFNkXS4C2ydmzI=;
        b=WOwEXaDQoAkNU9FmB1lr9BqhnhjCb/P8F5P8BqThNeJpEzQY7eBguVf9QVNMvw1XTA
         kocPMw/9r5vvoQd3eUChDUkTLzLSGQer4bZ6NgNIviXM+BeNArJXoPXj4bzsxEstO7nb
         tWMHMptDLWkJs1FkqA2QkJhzREBk0V4zhW1rcP65ESneAoqF4oC/+omw+H4CPtiVva9/
         zKlK0qWBQHQzuzKO+L839fOVUlBaHjSa5USMOlc3MzD4VJYxN6QcL8rugWuK4Otcco+0
         uMeaf8yF5oh8157qCYhZTnBQcuBIc4zGmUuqv9VLnwF23cxgbnY3mCizaczZvnz/E9iZ
         DVfA==
X-Gm-Message-State: AOUpUlGsBjdcDiIcgCivFz7u+FkwJucr6FwmEKPoVinQkiTWDK5hS0HP
        BAWypECkLJVyL2Kxlm44hxkDKZSr
X-Google-Smtp-Source: AAOMgpe4Pp48VVVR8K6HNK3IsF+u/kGTNUD9AijCmoG0li/ZVSVNaxM1PvyXePZxZ8h44Uh1YglB9Q==
X-Received: by 2002:a37:2b89:: with SMTP id r9-v6mr17151307qkr.389.1532981766043;
        Mon, 30 Jul 2018 13:16:06 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id w13-v6sm9248555qtc.88.2018.07.30.13.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 13:16:04 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] unpack-trees.c: add performance tracing
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        peff@peff.net
References: <20180727154241.GA21288@duynguyen.home>
 <20180729103306.16403-1-pclouds@gmail.com>
 <20180729103306.16403-2-pclouds@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <cae996fc-38d7-a691-3b66-b0b504513f75@gmail.com>
Date:   Mon, 30 Jul 2018 16:16:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180729103306.16403-2-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/29/2018 6:33 AM, Nguyễn Thái Ngọc Duy wrote:
> We're going to optimize unpack_trees() a bit in the following
> patches. Let's add some tracing to measure how long it takes before
> and after. This is the baseline ("git checkout -" on gcc.git, 80k
> files on worktree)
> 
>      0.018239226 s: read cache .git/index
>      0.052541655 s: preload index
>      0.001537598 s: refresh index
>      0.168167768 s: unpack trees
>      0.002897186 s: update worktree after a merge
>      0.131661745 s: repair cache-tree
>      0.075389117 s: write index, changed mask = 2a
>      0.111702023 s: unpack trees
>      0.000023245 s: update worktree after a merge
>      0.111793866 s: diff-index
>      0.587933288 s: git command: /home/pclouds/w/git/git checkout -
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

I've reviewed this patch and it looks good to me.  Nice to see the 
additional breakdown on where time is being spent.

