Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 342191F954
	for <e@80x24.org>; Mon, 20 Aug 2018 23:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbeHUC4o (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 22:56:44 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:45100 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeHUC4o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 22:56:44 -0400
Received: by mail-pf1-f173.google.com with SMTP id i26-v6so7539192pfo.12
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 16:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ILlezAosY5YwsuHc4D37fbGJ93BwzDDHwlz2wTJ8w5Y=;
        b=mfCyLJF89e0MBXHL5mqVFY6XVdfu4Q6P9Ho3PKaln5/7rAO28o7c3XW/dN+RmtXvGa
         TbPo9yjjHHIiBFdjiUccbSyRoehdS0G17Z6DnIdiCcX5n1V/EIe6elTchcmZlyneIXYz
         PhxePZV6kEilEmWQspAMf3HY8kw9afNfiEhYoWO/AfbXfTwVmtkGfGuOdGIi69mweWax
         anPfYLljdchZQk7ovfn59nLvMTUbYrppwk2rdw1lsEQnusxnTlAGAd/i/v9cG9FxFroi
         Hd34UJPK8VkEjLnl0mAoSfbQXZIpMs9BJgOSLuv8OlAzzCk/ahSnZpnDOt/04FrVf66+
         uBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ILlezAosY5YwsuHc4D37fbGJ93BwzDDHwlz2wTJ8w5Y=;
        b=Q9bp7nJlXbSV70EQ+d9fD0eYQ+QD4oYgWqFc9Csnr685wPiJsOjTM5pz60XHIkkXCF
         mIdOrPc++0B0U6Crl83t7M6M/ewkG9Z7Gm/YuChLPS7vsSua4rFtUXXckurtAycZeBUe
         +e7D39KOVcBX9tkkzoRRosuSL9IO1R4IDNdy/HRhgpjncw/bOdzzcAHKfRjGp5qBXVCQ
         yOpKTbl/81cK8BIXanOaBKOvsczDzbaCsQL3E9BguepEsFHN7Tk2aLvtOEP4w9h2bxH+
         nBv/IBI1ndgojur8BncK1K2cJFKlLeuhe6e0qM4L1y2yTWXiJITfPBc0VrPNq+23Nq3f
         1EsQ==
X-Gm-Message-State: AOUpUlEdGrpJLy8/V/HzsAztJ5SkOtTcXhIg31DZwtspNoJl+DwKqtnV
        PbWUWnE9yd66qGMK1ouTD1Zd9Osb
X-Google-Smtp-Source: AA+uWPwKlCm8QFBy5PLLjfZFnuLjsXodr0GxX7t5adfBosbAGhv1MYpQXATRQ+cl1GN5xTxw7j6OfA==
X-Received: by 2002:a63:e40d:: with SMTP id a13-v6mr44630995pgi.289.1534808343658;
        Mon, 20 Aug 2018 16:39:03 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id o34-v6sm9648254pgm.44.2018.08.20.16.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 16:39:02 -0700 (PDT)
Date:   Mon, 20 Aug 2018 16:39:01 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180820233901.GC31020@aiede.svl.corp.google.com>
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kbrv62ttBYt7nwO7E4S7wTVWZGceqE6hPjAbhPPWfRkEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbrv62ttBYt7nwO7E4S7wTVWZGceqE6hPjAbhPPWfRkEQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(-cc: other lists)
Stefan Beller wrote:
> Junio C Hamano wrote:

>>  * "git submodule" did not correctly adjust core.worktree setting that
>>    indicates whether/where a submodule repository has its associated
>>    working tree across various state transitions, which has been
>>    corrected.
>>    (merge 984cd77ddb sb/submodule-core-worktree later to maint).
>
> Personally I do not view this as a bug fix but a feature
> (but then again my thinking might be tainted of too much
> submodule work) hence I would not merge it down.

Can you elaborate?

The symptom that this series fixes was pretty bad, so I'm pretty glad
you wrote it.

Thanks,
Jonathan
