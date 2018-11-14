Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 801621F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 18:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeKOEX6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 23:23:58 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42825 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbeKOEX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 23:23:58 -0500
Received: by mail-qk1-f196.google.com with SMTP id m5so27498132qka.9
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 10:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VYUU9KqBEri7rucRA6W/CTtZiO71W/L9w6ur1j5ULBI=;
        b=Wdll+oVPIyP+/KNrZav3g/mYtJRwFHTG82R6bhIT0j700oCxZf/Rtt2s7mAppEaH8s
         6F8Wo7u+gqq+xF2nnN1DWM2msni/vAcYPCTrP11GMcTQayd+PVsf5q5Ah7jlc1JaTJPO
         2WFVXOYc+9PR0UhSUlx/Sy7k++Kc2lUIGpXCgqDeJUEoYr9d22rhketA3xNsf/Z1f0qz
         g3ghwbWWQMPdzx/hr/bW06ppK5Ty1Ir9BXsNPczBQaG3X3Kom8P/SEXMat4Ax9HHDJrq
         u6k+3SSeUQbirKldkV7VGDtqJNGLpu9k/Y76b7oHXZVJCPvPJTGZfxEXjq1AwEauSQnA
         WoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VYUU9KqBEri7rucRA6W/CTtZiO71W/L9w6ur1j5ULBI=;
        b=qBBmCEl0kuVHmxWm1oYi6KsVNEMFx2UqcGZkS23tdTIT4eSIZrguq5+wzx9G6iUgFb
         up98oXPtvjhBHLr6m9I5asqNQUyUe709cQXkkOeMJq/QSP2p5AEXf+YVGPOXgLqOncWq
         91K6lKXtzQmBVjAXpmRyYjo+tnVHW7e+cRcIxI8P+tr6nKhRcR+td2+oLln+qisZwH/a
         xxCGYAXzYIvy9k1B3LkemuOp5WApfDx3Q/A0GDpp8nUpU4hsUWgSXryoiNZSk6jNYnDM
         btEEhnOyIP2Vl090x9bcRRl6yQ4jzre9IpDZEJCUPvEsKuIvknvk44cU/3pfh/VdEuH3
         HK5A==
X-Gm-Message-State: AGRZ1gJzubVBCZLKfkfn+6BYARL3mRTV5+RzhCXFCrWYQf9++tJC8pyJ
        qyVeSl8TDBOSQ7CooDEPxXc=
X-Google-Smtp-Source: AJdET5e2mTd9QkWU6o7nlSfnyfpZ25K3K1+z1jUAseszIgfao3wfVWyqADPOkt6O2dhqDs4NeLRjTQ==
X-Received: by 2002:aed:26a3:: with SMTP id q32mr2902560qtd.106.1542219580660;
        Wed, 14 Nov 2018 10:19:40 -0800 (PST)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id w12sm2175365qkb.3.2018.11.14.10.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 10:19:39 -0800 (PST)
Subject: Re: [PATCH 3/3] index: do not warn about unrecognized extensions
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com> <20181113004019.GD170017@google.com>
 <xmqqh8gkqr2l.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <70f48153-fedf-4b82-780b-eca08981a8eb@gmail.com>
Date:   Wed, 14 Nov 2018 13:19:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqh8gkqr2l.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/13/2018 10:24 PM, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>> We cannot change the past, but for index extensions of the future,
>> there is a straightforward improvement: silence that message except
>> when tracing.  This way, the message is still available when
>> debugging, but in everyday use it does not show up so (once most Git
>> users have this patch) we can turn on new optional extensions right
>> away without alarming people.
> 
> That argument ignores the "let the users know they are using a stale
> version when they did use (either by accident or deliberately) a
> more recent one" value, though.
> 
> Even if we consider that this is only for debugging, I am not sure
> if tracing is the right place to add.  As long as the "optional
> extensions can be ignored without affecting the correctness" rule
> holds, there is nothing gained by letting these messages shown for
> debugging purposes

Having recently written a couple of patches that utilize an optional 
extension - I actually found the warning to be a helpful debugging tool 
and would like to see them enabled via tracing.  It would also be 
helpful to see the opposite - I'm looking for an optional extension but 
it is missing.

The most common scenario was when I'd be testing my changes in different 
repos and forget that I needed to force an updated index to be written 
that contained the extension I was trying to test.  The "silently ignore 
the optional extension" behavior is good for end users but as a 
developer, I'd like to be able to have it yell at me via tracing. :-)

IMHO - if an end user has to turn on tracing, I view that as a failure 
on our part.  No end user should have to understand the inner workings 
of git to be able to use it effectively.

and if there is such a bug (e.g. we introduced
> an optional extension but the code that wrote an index with an
> optional extension wrote the non-optional part in such a way that it
> cannot be correctly handled without the extension that is supposed
> to be optional) we'd probably want to let users notice without
> having to explicitly go into a debugging session.  If Googling for
> "ignoring FNCY ext" gives "discard your index with 'reset HEAD',
> because an index file with FNCY ext cannot be read without
> understanding it", that may prevent damages from happening in the
> first place.  On the other hand, hiding it behind tracing would mean
> the user first need to exprience an unknown breakage first and then
> has to enable tracing among other 47 different things to diagnose
> and drill down to the root cause.
> 
> 
