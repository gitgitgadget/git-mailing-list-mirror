Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D83D1FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 15:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965441AbdDSP5E (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 11:57:04 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:36013 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937866AbdDSP5D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 11:57:03 -0400
Received: by mail-io0-f182.google.com with SMTP id o22so26910823iod.3
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 08:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fpCv3iTlO2934wJM61HP9uRJPvXAEfQ/Bg94V+tQL8M=;
        b=GedYAHM8FKUbBp2EZ2f8Fxxysi/mVvXKPRx/Fv+dfTtGC7OYT1MEU4eUUW6OdyziZ5
         0/rDQVF5ad2u55Z6YN2Y1Xzok/9fPWXCnu35KYOjdSJOgkABdmO4WbW4emxpmj88dHes
         j/WIQRMiWrXv3FTDi7vJdFHaEY+pGtEBALz4jrV0nEdacQgWWHN45CVcRE4JEW1+sV6J
         ohqVE0Rg8ve7/8/yOiAFA/7C2WK2Edy4wfbREjzt3fLCmYN7LRo+fhFhg7yT5EY5sC49
         SPsOStKeSduiJhSZ8zlwmuqhMjucqUTkl9E+S/etu8UwmlIEJgDICz5vDfXGwy9H8sfS
         2v5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fpCv3iTlO2934wJM61HP9uRJPvXAEfQ/Bg94V+tQL8M=;
        b=mUOGtrLfzP98HeijyAfS/ejZUC7SeBYPp62k3tpnhP1xcI5E8wZ0stocgyqKRAAzCg
         QjSxTnzl2ccY8WMNr3SXhS+nitepYlwiGyHo7rSFJ7H1zZksyEnPIVxtES1S4ESBDI2L
         ybfQ+t1ierjAthrXCOR9AumRMxnrRtFGYYb5TlbdROxHorEVy7caDcoE9yI9kXb+4FMB
         DtzTPQkXePnsy9KbAvDA8HkKMeUTwAhiQNGI0ER/EGgnkqL2zh4fNxAZFUaEV40xUF/1
         bVoaYR8/J8fy9Sr5ViZQxHuHS2KxXE+LV3CBV8Towzlwk5/QUznRn3s4j0Gd0Vg3eMlU
         z8SA==
X-Gm-Message-State: AN3rC/6bn8f0b6uVqIcla01KH7gKxQQwf5ursNeUdbMBA1s3EPBbTYij
        8zkJ+1Kl2XY4ijt0
X-Received: by 10.98.202.80 with SMTP id n77mr3856101pfg.158.1492617422063;
        Wed, 19 Apr 2017 08:57:02 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c085:9655:b875:4bbf])
        by smtp.gmail.com with ESMTPSA id s21sm5456227pgg.65.2017.04.19.08.57.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 19 Apr 2017 08:57:00 -0700 (PDT)
Date:   Wed, 19 Apr 2017 08:56:59 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, e@80x24.org, jrnieder@gmail.com
Subject: Re: [PATCH v5 02/11] t0061: run_command executes scripts without a
 #! line
Message-ID: <20170419155659.GA132229@google.com>
References: <20170417220818.44917-1-bmwill@google.com>
 <20170418231805.61835-1-bmwill@google.com>
 <20170418231805.61835-3-bmwill@google.com>
 <12add885-b56d-4707-57c1-1073fbb7786c@kdbg.org>
 <9c562827-78f5-ab8f-bf04-5f403672a32d@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c562827-78f5-ab8f-bf04-5f403672a32d@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/19, Johannes Sixt wrote:
> Am 19.04.2017 um 07:43 schrieb Johannes Sixt:
> >Am 19.04.2017 um 01:17 schrieb Brandon Williams:
> >>Add a test to 't0061-run-command.sh' to ensure that run_command can
> >>continue to execute scripts which don't include a '#!' line.
> >
> >Why is this necessary? I am pretty certain that our emulation layer on
> >Windows can only run scripts with a shbang line.

Out of curiosity how did you have t5550 passing on windows then?  Since
the first patch in this series fixes a that test which doesn't have a
'#!' line.

> 
> Nevermind. It is a compatibility feature: People may have written
> their hooks and scripts without #!, and these must continue to work
> where they worked before.
> 
> Please protect the new test with !MINGW.

Will do.

> 
> Thanks,
> -- Hannes
> 

-- 
Brandon Williams
