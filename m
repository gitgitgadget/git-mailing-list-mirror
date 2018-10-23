Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5E581F453
	for <e@80x24.org>; Tue, 23 Oct 2018 17:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeJXB4V (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 21:56:21 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44162 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbeJXB4V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 21:56:21 -0400
Received: by mail-ua1-f66.google.com with SMTP id i30so814954uae.11
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/l4bLq897mUWfXr/hH4WUzTeq300bXtDyckdon0duKk=;
        b=g+0jcnWsNOto/zb8HLF72sZhZT7rQpiOr9mqvkJ/ewyI3ov8nwcSdsYGPfAOc6oJdM
         F3iHVO46mIjUpvKpGM8UAJ14hEnOzI6ypp/XBh6L8dQOGfujI5MU2ZGYTmsx1gbCSuXV
         KKgZIYeE5ni+UFSjM39Gvb60PHmASeKMz03mfKJXZHwPcefBv82prfnIYMOVehPYo1y8
         bwdQjiS5BKvXR9C8a77JFMS6ith8IgSfVGvyxyKEkLpAf3g5wnfiCHgWpsVt8FigV5Ne
         8nW/HchimACotI4luM8v11pCY0ISY4Wn3YQ8oFC8ZQirtu3Hh81JevkphCwweyr2786f
         wtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/l4bLq897mUWfXr/hH4WUzTeq300bXtDyckdon0duKk=;
        b=LJlfcPpHd3gdeoLVrfrGGMUb4Azbu8Xd37eF/nsoOgyaqlSZWBhGU3EHg9ypw8Fips
         n4ldFc3RkjFeN3dn02IMNm9HAVoY8TGMqEYtEnU/U8ZYvdSOMyJvT5/qHZOuAjDOXAIE
         EVx6fPQMiGfDdQehLPZMFBOJ7erwMRp3CHM7MA6s2/fBoTrsMpWujrwNe4frqG5jNZuv
         Jiy5qpFYsBoSC5ez1824XQdh3GHSBFrIL7O2rkO6yjgLczAeFryWX4lV417pI5cp7zQE
         RT2R4/NB8/pappSGuDOrOa25KgPYD/8oJcqjxgnRrK3BE0gwEC5+gVzrVZ6TujUX2ylt
         qQ9A==
X-Gm-Message-State: ABuFfogiHsxooFqCZGW/nrh7ltpErmKhsMaW8wnPtrSPc/uS/PfzKsPF
        vePlFidLpHvjWeNTWPHhYWE=
X-Google-Smtp-Source: ACcGV63pJUE/cy3h2FIPwAilKi4ubHb009WwRmZ/wDMPBLB3Ho9C01/i9uukRXJs8drDw1MxIOSo6A==
X-Received: by 2002:a9f:3d8f:: with SMTP id c15mr14662317uai.17.1540315920487;
        Tue, 23 Oct 2018 10:32:00 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id q196sm434218vkf.30.2018.10.23.10.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 10:31:59 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] reset: add new reset.quiet config setting
To:     Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        sunshine@sunshineco.com
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181022131828.21348-1-peartben@gmail.com>
 <20181022131828.21348-3-peartben@gmail.com>
 <045b78ce-230e-86fe-6e5a-684bf9e93fbc@ramsayjones.plus.com>
 <20181022200601.GC9917@sigill.intra.peff.net>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <6feb67a1-17fa-4280-9e31-963b619fa051@gmail.com>
Date:   Tue, 23 Oct 2018 13:31:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181022200601.GC9917@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/22/2018 4:06 PM, Jeff King wrote:
> On Mon, Oct 22, 2018 at 08:13:32PM +0100, Ramsay Jones wrote:
> 
>>>   -q::
>>>   --quiet::
>>> -	Be quiet, only report errors.
>>> +--no-quiet::
>>> +	Be quiet, only report errors. The default behavior respects the
>>> +	`reset.quiet` config option, or `--no-quiet` if that is not set.
>>
>> Sorry, I can't quite parse this; -q,--quiet and --no-quiet on the
>> command line (should) trump whatever rest.quiet is set to in the
>> configuration. Is that not the case?
> 
> That is the case, and what was meant by "the default behavior" (i.e.,
> the behavior when none of these is used). Maybe there's a more clear way
> of saying that.
> 
> -Peff
> 

Is this more clear?

-q::
--quiet::
--no-quiet::
	Be quiet, only report errors. The default behavior is set by the
	`reset.quiet` config option. `--quiet` and `--no-quiet` will
	overwrite the default behavior.
