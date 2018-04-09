Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BE2E1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 22:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751650AbeDIWI6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 18:08:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36433 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeDIWI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 18:08:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id x82so19523214wmg.1
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 15:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZvcSsW95FNpTntuTEshAWSNJrLx/BlIdNVR1XeSKeoQ=;
        b=cv9VfAMSrMBRltIyWRRafEbfNPlRMrqn80b4tuDnkJurq3wbagRH37zpaq7KX/Cj8I
         Zd04MrUKric6bB+pxSh8MWwDakgJ94FaDpSAEgf4ekH/TRRI3QpH+bMG/DiOz0edIcbb
         e62tsYSw+Qbc/xqXAkLICyu0i28vyAAlJl2TMYe4I0DTg5XMD9oH+I8Zo56ABKfaPzWs
         haO/MdySv1jp++LpzQ8/29p0vPh6P15vAHKaTWfwpGPloaXO8V4FC3jXeJWWpShssRNU
         RviBmLvDAONMv6AF6MgVVNtdBkvE+aToTjTQ7CgCNBXgsUBUC4cqYDUTdLUGK4Et83+H
         9lLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZvcSsW95FNpTntuTEshAWSNJrLx/BlIdNVR1XeSKeoQ=;
        b=KHO7tdCA7V+zdDYzCNOR9qWUbUCLyZ1EuvgxjqLfVR+jgNvXvAICoN77g4YZFo+4Ce
         PQBOj9dputENtx5klvbItTDNGJY6wiv5qJU12ffrVsGHn2Qe503dFka4Ym3ZtACMafim
         506vFN0GtjDtyFVxc4KS5QedmQiQ9qI2pCz01Uc9F3kpG0AL1vgu8DJ6CJGLnrENVtrO
         7NHw8x34Rk4poNtBavxNw+9R6aRR4MnK6DV02cE0X3xwBRTDZVVffMiTSIcHE1M5Hows
         +f65sAj9m/iiNIjKwDtjomyAi+BuQXKY6KKsAfHtcOB60CmMJsY+sp2EifNAtwiaBh14
         3vcg==
X-Gm-Message-State: ALQs6tADL7j3jspOpFPpR1RRgnSuhrdjmriaqbFTy6iLYzhLdP0a/Yt3
        gqNWAg6Xql+4ef0Malk0VNk=
X-Google-Smtp-Source: AIpwx48dX7xnTegHKwOtbgth3oAyJl+UoTylnaA4NPuKUJFVvkU2s2xbzhTTCjdvPnL+KX9wVW/ZSQ==
X-Received: by 10.28.238.141 with SMTP id j13mr10156wmi.50.1523311736107;
        Mon, 09 Apr 2018 15:08:56 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 95sm1558250wrb.47.2018.04.09.15.08.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 15:08:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2018, #01; Mon, 9)
References: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com>
        <98394864-ece6-5112-0274-b2399087f207@gmail.com>
        <bba6e3ba-ab28-8cda-eab3-91ec3591bcb5@ramsayjones.plus.com>
Date:   Tue, 10 Apr 2018 07:08:55 +0900
In-Reply-To: <bba6e3ba-ab28-8cda-eab3-91ec3591bcb5@ramsayjones.plus.com>
        (Ramsay Jones's message of "Mon, 9 Apr 2018 17:49:35 +0100")
Message-ID: <xmqq4lkk58y0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 09/04/18 14:37, Derrick Stolee wrote:
>> On 4/9/2018 6:21 AM, Junio C Hamano wrote:
>>> * ds/commit-graph (2018-04-02) 16 commits
>>>   - commit-graph: implement "--additive" option
>>> ...
>>>   Ready???
>>>   It seems that this topic is getting there.
>> 
>> I think this patch is ready to go, barring ...
>
> Also, it seems that the 'static' keyword has been dropped from the
> declaration of 'commit_graph' (commit-graph.c #183) again:
>
>   $ diff nsp-out psp-out
>   18a19
>   >     SP chdir-notify.c
>   23a25,26
>   >     SP commit-graph.c
>   > commit-graph.c:183:21: warning: symbol 'commit_graph' was not declared. Should it be static?
>   66a70
>   >     SP json-writer.c
>   209a214,215
>   >     SP builtin/commit-graph.c
>   > builtin/commit-graph.c:34:38: warning: Using plain integer as NULL pointer
>   299d304
>   < fast-import.c:303:40: warning: Using plain integer as NULL pointer
>   312a318
>   >     SP t/helper/test-json-writer.c
>   315a322
>   >     SP t/helper/test-print-larger-than-ssize.c
>   $ 

I guess we'd want a final cleaned-up round after all ;-)  Thanks.
