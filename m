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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C90A1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 18:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfHTSpW (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 14:45:22 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41091 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730006AbfHTSpW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 14:45:22 -0400
Received: by mail-qk1-f195.google.com with SMTP id g17so5373687qkk.8
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 11:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oqG6gQeyogrHa40e2mUugplA0UFFjk4BFxn8l2aMPh4=;
        b=JuA4+I4Bo5PNIg1wojj61prljO4s1T2Fjp3Z4ZiSNSOcmXxRf6ivFGjJ0ZP4OcPZNS
         ErxrnPye6SpPaI4AgeXlXM7TICHdcft1A7b1KO9NHRtw62K+i5LRAfBpFlUpVz0Nq26W
         6AcRxQOdlAt4k/O/pS8c6FkWBLKl4Y299zH2N5wFbD+dUDqYpdkHL4mvRidUeC3UEqTy
         mGQIxTVwcZsnGPwmTWIIKNJPznfZS4M5lfM9PqEVACBYgi7XwrQURBHjoGOlGext8c4A
         3PKvin3QnJa9lzvikNH6+smZD5IusFDoM4zgs6stLUwLis1WLz09MGfM6Gk5yxByZJ0R
         FLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oqG6gQeyogrHa40e2mUugplA0UFFjk4BFxn8l2aMPh4=;
        b=SK9QZ1tASPlklAtqH3+ErShKen51kuI3vj1FveCl1p66E4KZifMNMAtJrPsCaJlQRf
         LoejpYPBYdIt2F+Xrh7M+lRe0H7UrE5YFLg4Fana3bMFJu9x+MFRiVis7A+IntuIeMwk
         pcwYEK6mQ4GvKx79hvExJq0d3tNR8gTycIfJkSKoscQ3FGNZRUBlHh0CjZbTTWWLgIsg
         jRCcuOfSYxvDCbaYo/7dUF6oQjIAhxI3VirIGrPzaLutlaao0wQ9bIGoLKU5ep/HIjgz
         mXcol5WJCnhHI6ZrenWTzLFPOEVbtktzoOSogr5gdcJGcyY2IkB2St5uHzL/GGM3ZU0v
         M5dg==
X-Gm-Message-State: APjAAAUX61s4+rYuJ49XO3lcwbhXzox9SNok58VZya7yTGeVbmHJ9JS1
        VjHiVC+JttmuiApmvRi2rXs=
X-Google-Smtp-Source: APXvYqyagugrIxz+jqDXa1DrWe9UTjIx7F891dKZi/ZPZTlQcMyf4mYQW0Ch6XWhx5YoUjyI815jUA==
X-Received: by 2002:a37:717:: with SMTP id 23mr27052795qkh.267.1566326721000;
        Tue, 20 Aug 2019 11:45:21 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:5ff:3a8e:8e40:6517? ([2001:4898:a800:1010:b734:3a8e:8e40:6517])
        by smtp.gmail.com with ESMTPSA id j78sm8777222qke.102.2019.08.20.11.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 11:45:20 -0700 (PDT)
Subject: Re: [PATCH 0/1] commit-graph: add --[no-]progress to write and verify
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        garimasigit@gmail.com
References: <pull.315.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <502f808c-d8fe-81d3-d15b-6f92916035ba@gmail.com>
Date:   Tue, 20 Aug 2019 14:45:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <pull.315.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/20/2019 2:37 PM, Garima Singh via GitGitGadget wrote:
> Hey Git contributors! 
> 
> My name is Garima Singh and I work at Microsoft. I recently started working
> closely with the Microsoft team contributing to the git client ecosystem. I
> am very glad to have the opportunity to work with this community. I am new
> to the world of git client development but I did work on the Git service
> offering of Azure Developer Services for a few years. I am sure I will get
> to learn a lot from all of you. 

I just wanted to chime in and introduce Garima a bit myself. Garima and  I
were both on the Git Server team for Azure Repos and left that team around
the same time. She went and did things in Azure Pipelines before leaving to
pursue more education and returning to our current team working on the Git
ecosystem. Garima will be focused mostly on core Git, so get used to seeing
her on the list!

She's starting with a couple smaller series to get her feet wet, but then
is working on some deep dives into performance features. Look forward to
those!

> CC: stolee@gmail.com, avarab@gmail.com, garimasigit@gmail.com

GitGitGadget is picky about the casing of "Cc:" so I have CC'd these people.

Thanks,
-Stolee
