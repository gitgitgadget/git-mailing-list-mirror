Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDECC4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 20:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJMUtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 16:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJMUtr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 16:49:47 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7552DB841
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 13:49:45 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j16so4671274wrh.5
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 13:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p+go/1ImkWcy4AGkBBDOVWfIIUIbR85gpYtIKzvZdsc=;
        b=Wp3sJivE9QVPzxhu5HdYWnU7xaRUsMCcfP31UMCIIIa/h7+az3QYdjMHrbSm62FmCU
         gJcugmKm2iQc5kc98YgB+7nicgMkZtlcVA4omOrq1fC5UQXOYBqTEPfPUO1eia941GBI
         RC+/cDTV/8309noNBw8YvM06NUWz7FjAquFc3dkOchkJJv1eaz9ADyqpWlZ7KD/nOht4
         d1OVRs8wpMZA8nRE97vqqmmIDCsD1WJll8Cb7yGkGbLr9JFv2npncRgYB1ePl3O5j+LD
         HjVCCPgqYt54e+Nv7EGVM5P3n1dygTmF6VZO+GEXawIujyphSHlywtR+ahhqwgitq+Gi
         BmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+go/1ImkWcy4AGkBBDOVWfIIUIbR85gpYtIKzvZdsc=;
        b=kNaG59VJnhvCVvgvYSWiQHC2etjRfMqN++SmyEKOzGZPrbqtbJBXL0K30FYD1FK9HV
         C2tUAoM0t2TXoPYpcGakP7hozI/IJEbREvHKTUv9WAHdR0ECJ/hfUf8xYcVa3lf9N2yP
         0990E6GAgT7I1wuI5+um+ZTaVJJvAgJqpe6xuDRrsOJITUAKjzJe7Ixt80t5cEqfBfN6
         a9BCnWmpe1zbBHJnGtKLEetR3sBYxfsDlrTX8423Y5sdaShZW7R9adJffUeeSDmxy6xl
         u7c4inY52lLombgpR1RGL4SgmfJ0JOGP6J7VxcB6BL8RHD0V8fYUx8w8Mv/dkHNVSowO
         Jigg==
X-Gm-Message-State: ACrzQf1aqeMr9kWNs0Tvw8Ec/jkUFjDIPsGMYm1r4wlIZzatSlrnOfkx
        Xq7ff4XjuVvuA9cTN5f95FI=
X-Google-Smtp-Source: AMsMyM7oPb6p/ndNW1J7FbZJhUUX4YMUtYwzGh6BOVs2FcsI9det7ZRNr1MV1eYtIZzOBJRSphjZPQ==
X-Received: by 2002:a5d:5a0e:0:b0:22f:ca69:2d4e with SMTP id bq14-20020a5d5a0e000000b0022fca692d4emr1194182wrb.1.1665694183832;
        Thu, 13 Oct 2022 13:49:43 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id g33-20020a05600c4ca100b003bfaba19a8fsm376026wmp.35.2022.10.13.13.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 13:49:43 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <3a234ed2-5540-2109-80d7-dd48fc420841@dunelm.org.uk>
Date:   Thu, 13 Oct 2022 21:49:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/8] rebase: store orig_head as a commit
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
 <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
 <dc056b13ed5c62729f97bd2cedbe769c531f4bc4.1665650564.git.gitgitgadget@gmail.com>
 <xmqqilknhed6.fsf@gitster.g>
In-Reply-To: <xmqqilknhed6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 13/10/2022 17:34, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> To avoid changing the behavior of "git rebase <upstream> <branch>" we
>> keep the existing call to read_ref() and use lookup_commit_reference()
>> on the oid returned by that rather than calling
>> lookup_commit_reference_by_name() which applies the ref dwim rules to
>> its argument.
> 
> I agree with the above in that _by_name was an overly broad and
> wrong function to call.  But ...
> 
>> lookup_commit_reference() will dereference tag objects
>> but we do not expect the branch being rebased to be pointing to a tag
>> object.
> 
> ... if we do not expect to see a tag object, why call _reference()
> in the first place?  Does lookup_commit() not work for the purpose
> of this code?

I was wasn't convinced that the tag dereferencing was the only 
difference between lookup_commit_reference() and lookup_commit(). 
lookup_commit() calls lookup_object() and if the object is not in the 
parsed objects hash table it creates a new commit object with the given 
oid without checking if the object exists. lookup_commit_reference() 
calls parse_object() which handles replacement objects and checks the 
object actually exists.

Best Wishes

Phillip

