Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6E5B1F454
	for <e@80x24.org>; Wed,  3 Oct 2018 06:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeJCNMT (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 09:12:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37807 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbeJCNMT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 09:12:19 -0400
Received: by mail-lf1-f66.google.com with SMTP id a82-v6so3260528lfa.4
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 23:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GXy/3YOLORPFcdeXgOu2AYbxLV0SMwEpwucYopziSqg=;
        b=cfUmUDirl4d8xMHZFKBvgAz8UPIbJnL7UDOT1bsljb68jCy967Lhe19avrYBLxmhsQ
         pADMLQBE+a8N9iV5K1ocDRAzGhCRMm/xurqOjeFNJqXzvqdftIQZlOXCPkfXeegjBLgJ
         2Du93ipbYmCIVfGi5LQKL7n1KmqxfeUwA3ABQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GXy/3YOLORPFcdeXgOu2AYbxLV0SMwEpwucYopziSqg=;
        b=uYFjZSfM7l7YZ2FaydlM6+vLYkyPY/7LFFmcD2yydEQ0oeFr7+eXf+SxDIR91hh0F6
         zmz9wK8WMmf9LB+f9RABibstBOLQPTlKvaq8yWdB0zZomjCrNFHd7jMOHd1yVE6Ea/bd
         dO/9zjePQy6pgm9HXkVzCodxZ86Sn/578lY6Nw/DVHxB0dAdvSbxq+6LAcRFqtEpyMWM
         s2KvAGqLihzZWY2fSV1ML+qdhD4ov+UoA+Fsp/T2kTKy5WgoQgvpvBLWz2kEuY1ugJIb
         toNnQgVUEMeKvGg3kn7WUYGZVWbip2gSbta+e1pUMq69sEvtFlISh+CiX290US5CiRo6
         V1/A==
X-Gm-Message-State: ABuFfoiy+uJdpBFns/9ppdZ1OXff8WBjrnyynE55nfbHBkW9QrbYJ2Is
        kce0SIRHqmpjfHGJNucu2790dw==
X-Google-Smtp-Source: ACcGV63yV+dF4rosZlPCRiKoYYKhigCjQXJXnSDqfapKMESNKEdFCQFFUIkzJKccXZ3mO7EY75lYKQ==
X-Received: by 2002:a19:8c1a:: with SMTP id o26-v6mr16456lfd.90.1538547922125;
        Tue, 02 Oct 2018 23:25:22 -0700 (PDT)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 9-v6sm27220lju.61.2018.10.02.23.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 23:25:21 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] git-help.txt: document "git help cmd" vs "git cmd
 --help" for aliases
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
 <20181001112107.28956-1-rv@rasmusvillemoes.dk>
 <20181001112107.28956-3-rv@rasmusvillemoes.dk>
 <20181003021816.GC20553@sigill.intra.peff.net>
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
Message-ID: <b5d0e881-d4b5-16e8-13df-46f9cb81f9c4@rasmusvillemoes.dk>
Date:   Wed, 3 Oct 2018 08:25:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181003021816.GC20553@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-10-03 04:18, Jeff King wrote:
> On Mon, Oct 01, 2018 at 01:21:07PM +0200, Rasmus Villemoes wrote:
> 
>>  
>> +If an alias is given, git prints a note explaining what it is an alias
>> +for on standard output. To get the manual page for the aliased
>> +command, use `git COMMAND --help`.
> 
> Funny English: "what it is an...". Maybe:
> 
>   If an alias is given, git shows the definition of the alias on
>   standard output. To get the manual page...

Much better, thanks.

Rasmus
