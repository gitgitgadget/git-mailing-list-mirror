Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3451C1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 22:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935849AbeF1WdB (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 18:33:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39159 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932522AbeF1WdA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 18:33:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id p11-v6so122721wmc.4
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 15:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x1jn5KnX1KIyQP9xQqWegTeBze1sUcN802BPmE2S2sk=;
        b=pj6LcAhIdZt3O68CT/3s/oOovp7svNeCKFYXcukxQwahJOLAw4pbYddcboxakvP0ld
         7r1E6Oux6rMpHuYZo6y8XaOY5EN5pGBz8f+uu+z9IJfNSq0ClUbxnD8z85L3BLjZczJV
         vD5Apnezv3sNvKCeGVy2DvBvlq5uJ7D1X8WK1egfpWnvLWXjzbevwPcGMxJl16vn3XJL
         EIz1sSyczbiiWNDtDgrwpU5h6pY1ZY9yJ2jNXPQZyyUl5F/kC4gRGzHPxQxq6hRVNNMI
         bTo8gm/VRTrgbeyXwC0C7TGPRJUxngP+rByXqukAU935432MVCQ1sFwGcX5gmra9xbhM
         RZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x1jn5KnX1KIyQP9xQqWegTeBze1sUcN802BPmE2S2sk=;
        b=K2f3M8HIJU19LhQHsuyPKUICMLTpRFOBLLTAsWnj3iS3gp0PGnFLnqy+xuMsqy61eC
         FrvfdipstnSR1iAMRYtzDICUObdEZxyDQMjCkyKBbI/E51S3A+l6MPe6gBUfUiGvVrkD
         WjNvfZEF9H3hE9fA6WfGRGSPDWB5dqlGbgWEkYBct8q8/uSIQY5SCtV03HMQsr341I3Y
         ZnEZWUmw/Fkysyfqkj4X/N/UbVvkDvSG/AdM16yO/slq/E9rVq8WC5qWELArTd/3luV0
         u7n4ucNPMCV1ZFVJ1i/Dfm/JUaJbvzVHCdSFRlHQ4K06ylKomhKGISqeHVmmtn+oKlKt
         7NZg==
X-Gm-Message-State: APt69E3k0FEcG5ujIMpl6tGglNfK8pk/GFJjJwdHISi7uYJjYs1Drt/m
        DKQqjY+v2gwVNNtMa/J+Z90=
X-Google-Smtp-Source: AAOMgpdOa7Doy+u6f1epWgwpoVOlmkr5yNyuHqlL7kOfgDIbA9BngJzcyN/XzAPRKiQ4dr4vO1Xylg==
X-Received: by 2002:a1c:3e94:: with SMTP id l142-v6mr9701714wma.120.1530225178977;
        Thu, 28 Jun 2018 15:32:58 -0700 (PDT)
Received: from [192.168.0.137] (5-13-221-130.residential.rdsnet.ro. [5.13.221.130])
        by smtp.gmail.com with ESMTPSA id j7-v6sm2981978wrn.96.2018.06.28.15.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 15:32:58 -0700 (PDT)
Subject: Re: [PATCH v6 0/4] stash: add new tests and introduce a new helper
 function
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, joel@teichroeb.net
References: <20180405022810.15796-1-joel@teichroeb.net>
 <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
 <nycvar.QRO.7.76.6.1806262357400.21419@tvgsbejvaqbjf.bet>
 <xmqqbmbwf4mf.fsf@gitster-ct.c.googlers.com>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <41665162-3020-be5c-1040-fd3ced67436a@gmail.com>
Date:   Fri, 29 Jun 2018 01:32:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmbwf4mf.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

> Heh, what is more useful than apology is to tell us which order
> these three (apparent) series build on top of each other ;-)
> 
> The answer, IIUC, is that
> 
>   * oidf+tests come first, then
>   * apply/drop/branch/pop (as these rely on oidf) on top, and finally
>   * list (as it wants to add to stash--helper that is a new file in the middle)
> 
> When there is clear dependency like that, I agree that it would help
> readers to emphasize that these cannot be applied in an arbitrary
> order.  It is especially true as the second part of the above _will_
> apply more-or-less cleanly without the first one, and then fail to
> compile due to lack of oidf.
> 
> Thanks.
> 

I would actually say that it was 100% my fault (I could have tested 
before sending patches or ask if I was not completely sure) and I would 
like to apologize for this.

The order of the commits is actually good. The only thing that is not 
right are the cover letters, which are missing. Every 1/N marks the 
beginning of a series of patches. Just to be more clear, this is the 
right order:

First patch:
sha1-name.c: added 'get_oidf', which acts like 'get_oid'
stash: improve option parsing test coverage
stash: update test cases conform to coding guidelines
stash: renamed test cases to be more descriptive

Second patch:
stash: convert apply to builtin
stash: convert drop and clear to builtin
stash: convert branch to builtin
stash: convert pop to builtin

Third patch:
stash: implement the "list" command in the builtin
stash: convert show to builtin
stash: change `git stash show` usage text and documentation
stash: refactor `show_stash()` to use the diff API
stash: update `git stash show` documentation
stash: convert store to builtin

The only thing which was in the cover letters and might be worth 
mentioning here is related to `git stash show`. Although it might not be 
efficient, a 1:1 conversion is more easily to follow and review. Because 
of that, the first commit related to `git stash show` approaches a 1:1 
conversion to C. There is a subsequent patch (`refactor ....`) which 
makes the `show` subcommand use the existent API. Any change of behavior 
is noted in the commit message which introduces that change.

Best,
Paul
