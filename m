Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AEE220323
	for <e@80x24.org>; Thu, 16 Mar 2017 22:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbdCPWxl (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:53:41 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33266 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752558AbdCPWxk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:53:40 -0400
Received: by mail-pf0-f196.google.com with SMTP id p189so1624308pfp.0
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 15:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ho9gCiOClJvgaTcoE+9qRx6y6c7/2BTz66QjyKXba5Q=;
        b=I2c11D480PcVa3MfParNFPe/ZaAZnhwvReg/MB4liLIwWXhXNadczUEpNyBDlJFOLx
         aULpHrMFe0nGh67cOEhVX2+9SyFp1SkuBFdjuT1O7/oIfT7c+UNtiblqtTezYI7QGBAP
         L7kv+QZCHXEgpJqPRMjsUsiVkzJFDf2rpBQ/wK+DjSaV6Mb950aHfctmcZGCc5qRJW8h
         MlwgLeFnHjKIrKwi0sMj2S39p50TRt0Ba0swmqHdozdMkhl6en+QCzmcu8besqC1suW2
         wS+wm1Ce02Wa+P0zXuaOeIZJQ6inE2ksIAsxlvegb8YRNdprRSllGvW+AEIr33K/TeM2
         4YoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ho9gCiOClJvgaTcoE+9qRx6y6c7/2BTz66QjyKXba5Q=;
        b=Vxjs47KSRLFYV66LHQv4yCAXFM2+O+SbUgpHOSjMQ1bB06j+AdWx1rQK7VrKs9QtH3
         ikwr3nYw9VSWD/d4QQkp/hvhu0ml4AR3Hk7VkSrGNd6rLDkWvx4AFQYZN1o5k2DIgIb0
         XxGwJZSk+Z+N9U1uxz2L8eloCQ/z3sxPhbyABXoHJd6NYQJ4QnxFDpdhVEssdjzTI7qU
         DvUmm1ohlG0n447HHkWkZDF1XGIX3XeC8cJGf7tqcikEbCmO2sUxx6LPqVgAiaSWpIGt
         Bl7cmh05LBvL5YMEceuPxLu8j6wBgFNRQkZ0GmIBy4w8btS7cO+wA0TTDXBCd93bU5GK
         pORQ==
X-Gm-Message-State: AFeK/H3JvVk2BJW7kCV0Zwjkc486C1cAvRCUbBR5+UilAtFVge6u48fN5khdQXCxQ2zMgw==
X-Received: by 10.99.155.18 with SMTP id r18mr12395722pgd.193.1489704789851;
        Thu, 16 Mar 2017 15:53:09 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:61c9:f866:d5e4:4761])
        by smtp.gmail.com with ESMTPSA id v86sm10637905pfa.86.2017.03.16.15.53.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Mar 2017 15:53:09 -0700 (PDT)
Date:   Thu, 16 Mar 2017 15:53:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2] short status: improve reporting for submodule changes
Message-ID: <20170316225307.GC9135@aiede.mtv.corp.google.com>
References: <CAGZ79kZ7rWw=q6a2AomTw20DsU1h+7ou4i8A14a2bcg+asRwLA@mail.gmail.com>
 <20170316204644.11616-1-sbeller@google.com>
 <20170316221907.GA9135@aiede.mtv.corp.google.com>
 <CAGZ79kagA38GjXcRp1XBXhjR6OLgk-zrVC5MC2eo+nZziBETLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kagA38GjXcRp1XBXhjR6OLgk-zrVC5MC2eo+nZziBETLg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:
> Jonathan Nieder wrote:

>> Is it important to avoid clutter by showing the submodule only once?
>> What would you think of showing whatever subset of those three
>> statuses apply to a given submodule as separate lines instead, to
>> match the information that long-form "git status" shows?
>
> I considered it, but it would break the visual appeal of git status --short ?

I could go either way.  As long as you've thought about it, I'm happy.

>> How should a new untracked file in a submodule of a submodule be
>> shown?
>
> The same way " ?" indicates that (1) there is an untracked file due to
> the question mark and (2) that you need to recurse because it differs from
> "??" for regular untracked files.
>
> The problem here is that we do not know about these nested untracked files,
> because we use --porcelain instead of --short for submodules in
> submodule.c#is_submodule_modified(). I am rewriting that function anyway
> for the "git-describe --dirty" bug, so maybe it's time to switch to porcelain=2
> internally there, which can surface untracked files in nested subs.

Punting to a TODO / separate patch sounds reasonable.  Tests in this
patch describing either the current behavior or the desired behavior
would be helpful, though.

Thanks,
Jonathan
