Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5C3C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 14:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbiCCOHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 09:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiCCOHD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 09:07:03 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B6418C7A9
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 06:06:17 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u10so6387784wra.9
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 06:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/pGrWGRywQxWXcIhjj7Fb50tXHVtCSiuE6OXRhMnosc=;
        b=J3cUeZgEWKjZ1O8pv8StX+fqHhoo7RUcAXI/9bPEZydwD6YXWYDdsALpPOsUxgx1PF
         Iazj6JDgOlcNVvQuWgyB+rUN/MXEmqHfy4J+R5smze9gyG4GBWrDAOZyVm6b2FQ9IS0R
         7UCODpjJl3hG7erYEH4uQRI7g7RQUDfyIrR/koE5I4ZV72VS9rpeJELF1WWIOQ4az1Cq
         DbORJoUKU2XDjr6jgslayl0CDgse0iOD+LW46paGOSN4iqezBewaQdw39q6W56LLmR2Q
         /J972P9XsoW0FNcxItYP7ylDPVX3Pc6ceFL6BJ68qobRaR7mqx8FNY5uYakoveU1fwU1
         uodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/pGrWGRywQxWXcIhjj7Fb50tXHVtCSiuE6OXRhMnosc=;
        b=woNzZrE6dDFEJDJdo4wz7vbxcMB8PMm63tSV/8AOtfMVJw+toYVU57Pozoil395MKP
         F5zvDITwpupbfrxAb1c6J5eGRfozbxgRJvvkAlkpS13omJSuQ8HNnvQSAdE+hQijQNpp
         tGL8vb4uOTqLr6QSrKyLWf+VRQ15cyqkLs+20CR1s0+5cOIEvZTJjpVBN7F/i8rSpWF/
         uZbWccFeiS+dBBwrDQHRI/GcgG0AcN4vRU5RzjA8IedWYDkFQXG3kOUWPKD0Pt4E6cSH
         CxSYD7h1p9fFqYpniYI0Kg/CPgF2aL2uhhVJSBbTsbEeX8xdEjn84KcbYQ/mx3KrgQgH
         LXFg==
X-Gm-Message-State: AOAM5308BNlUzXSzhnGd2nDI6/n0cAgKbmP9PT4oDqKUSeT5SzzLOzqM
        DyWqc6eJsD/JzGhlxT/jdDIfiQSNRqU=
X-Google-Smtp-Source: ABdhPJzA+AuG2vdhKNj0uQJgrLL4A09uRo6oVJlcc73q9RRIqgydH57pQhV8ClOpv5Ja/YyKWwpOgA==
X-Received: by 2002:adf:dfc2:0:b0:1f0:262a:d831 with SMTP id q2-20020adfdfc2000000b001f0262ad831mr6004308wrn.589.1646316376233;
        Thu, 03 Mar 2022 06:06:16 -0800 (PST)
Received: from [192.168.1.201] (230.2.7.51.dyn.plus.net. [51.7.2.230])
        by smtp.googlemail.com with ESMTPSA id o12-20020a5d62cc000000b001f048bc25dfsm2080296wrv.67.2022.03.03.06.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 06:06:15 -0800 (PST)
Message-ID: <e3090436-4479-bbc2-3b62-00473f6f530e@gmail.com>
Date:   Thu, 3 Mar 2022 14:06:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 00/15] tests: don't ignore "git" exit codes
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
 <76a1ff22-3eb0-08fb-5aa9-e612ee5b522f@github.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <76a1ff22-3eb0-08fb-5aa9-e612ee5b522f@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03/2022 02:02, Derrick Stolee wrote:
> On 3/2/2022 12:27 PM, Ævar Arnfjörð Bjarmason wrote:
>> As an aside we still have various potential issues with hidden
>> segfaults etc. in the test suite after this that are tricked to solve,
>> because:
>>
>>   * Our tests will (mostly) catch segfaults and abort(), but if we
>>     invoke a command that invokes another command it needs to ferry the
>>     exit code up to us.
>>
>>   * run-command.c notably does not do that, so for e.g. "git push"

I'm not sure what you mean by this, the return value of run_command() 
already indicates which signal if any killed the child see for example 
run_specified_editor() which re-raises SIGINT and SIGQUIT if the editor 
is killed by those signals.

>>     tests where we expect a failure and an underlying "git" command
>>     fails we won't ferry up the segfault or abort exit code.
 >
> Perhaps run-command.c could auto-exit for certain well-known error
> codes that could only happen on certain kinds of failures (segfault,
> for example). A simple die() might be something that is expected to
> be handled by the top-level command in some cases.

I think we need to be careful that run_command() does not re-raise a 
signal before the caller has a chance to do any cleanup. A caller to 
run_command() can already check the return value and choose to die based 
on that after doing any cleanup. If run_command() starts dying we'll end 
up adding more unsafe signal handlers to do the cleanup.

Best Wishes

Phillip

>>   * We have gitweb.perl and some other perl code ignoring return values
>>     from close(), i.e. ignoring exit codes from "git rev-parse" et al.
>>
>>   * We have in-tree shellscripts like "git-merge-one-file.sh" invoking
>>     git commands, and if they fail returning "1", not ferrying up the
>>     segfault or abort() exit code.
> 
> These are more involved and harder to evaluate. Add them to the pile
> of projects for new contributors?
> 
> Thanks,
> -Stolee

