Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 090661F453
	for <e@80x24.org>; Fri, 15 Feb 2019 00:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbfBOAOk (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 19:14:40 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42211 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfBOAOk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 19:14:40 -0500
Received: by mail-qk1-f193.google.com with SMTP id y140so4733197qkb.9
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 16:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e40PeY2ls8jlvU36bsmnIMUDTBsRGjhXkY8LzjyToh8=;
        b=egbSRBpRl+2YjPVc9iaILcFzRftwlyQYOYWuO3PSa1db3Wn/JMVI/v5WF8usO4UuLU
         Y7UVoibxF8946RIMjd/SMzdS2gTOOfjgNSzspSMjQoqLznE43QLEK4igHGkyRFCPQa1r
         FFvEJ0oQjrNl7bw1bWC3hSpxYfzkQAc4MzvqIY7+6a/guake6ErRcDrFjkoxYELELZNE
         Adv9v+iO5Zxt3RGAwnff03sRRUkj5iBQh2Xpbml56iPvLjWe/HlV/g8bbl1FLH0XOTj9
         1DeAVt6G0J8/x1IFv5YVGa6xgcHGlsIT3aXlhuxqikkZq8cYlxwR1N+nDpY4HMhg9NEc
         k9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e40PeY2ls8jlvU36bsmnIMUDTBsRGjhXkY8LzjyToh8=;
        b=N17skBqGGXxCvnfU6qzIu6OF9CVcskjn+HCgo+RfCw9F1G3JofMqqG+XTuAPnrW6rj
         4aVEUOUvVKgLOQO3uiZVHc2dwS5AO1Q0u+NBD18IyDkXs49qcDbg+gOvZpOprMitlcPA
         nPh1IUqxAlMl+VpJZKngyYCPPMPY8crLnFh/dfIPYCzitp2ByS3Kwnrvle5MuFyEJDLQ
         FBUwM2n5px9piNckRC198lViSyjRrYssfnmed2NuwcyFoYIsP6QVNwlcSR0HkMyZkWG2
         BTIqnbN8o/Q7jp5bpFTWknUTT+mwqVUUR2ML3P1s//ETxViRZr+klhL4Iz1m6QWvRZMB
         Ud3A==
X-Gm-Message-State: AHQUAubl+3xTZYf5HlsJgl0lrTLws2ACrsfNipozOpIV3gNQSLNrI7eZ
        P/ctqM/knMBcLhCrM1RaWI8=
X-Google-Smtp-Source: AHgI3Ibhq1srsVgXQ68pziSbBZVP9Op3i7G3J9RarxRLj8dl9Rzt+a8FGFx1Y2viWp2n1Rg+wO0o6w==
X-Received: by 2002:a37:884:: with SMTP id 126mr5138006qki.56.1550189679305;
        Thu, 14 Feb 2019 16:14:39 -0800 (PST)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id o5sm1951612qkb.66.2019.02.14.16.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 16:14:38 -0800 (PST)
Subject: Re: [PATCH v2] read-cache: add post-indexchanged hook
To:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, kewillf@microsoft.com,
        sandals@crustytoothpaste.net
References: <20190208195115.12156-1-peartben@gmail.com>
 <20190214144241.11240-1-peartben@gmail.com>
 <2f08ee3b-4511-2838-4c70-640d01fe1658@ramsayjones.plus.com>
 <xmqqa7iy860g.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <dc851640-ac3b-74a1-a753-7ff2a43a4a5b@gmail.com>
Date:   Thu, 14 Feb 2019 19:14:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqa7iy860g.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/14/2019 3:33 PM, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> On 14/02/2019 14:42, Ben Peart wrote:
>>> From: Ben Peart <benpeart@microsoft.com>
>>>
>>> Add a post-indexchanged hook that is invoked after the index is written in
>>
>> s/post-indexchanged/post-index-changed/
> 
> Good.  I wasn't paying close attention to the previous round, but is
> that the only name-related bikeshedding?  I somehow feel that
> without s/changed/change/ the name does not roll well on my tongue
> and does not sit well together with existing ones like post-receive
> (which is not post-received).  I dunno.
> 
> Will queue.  Thanks.

Would you like me to submit another version with the above spelling 
corrections in the commit message or is it easier to fix it up yourself?

> 
>>> do_write_locked_index().
>>>
>>> This hook is meant primarily for notification, and cannot affect
>>> the outcome of git commands that trigger the index write.
>>>
>>> The hook is passed a flag to indicate whether the working directory was
>>> updated or not and a flag indicating if a skip-worktree bit could have
>>> changed.  These flags enable the hook to optmize its response to the
>>
>> s/optmize/optimize/
>>
>> ATB,
>> Ramsay Jones
