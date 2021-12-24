Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB35C433F5
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 18:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353434AbhLXSap (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 13:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343993AbhLXSap (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 13:30:45 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C64C061401
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 10:30:45 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id a11-20020a17090a854b00b001b11aae38d6so8979218pjw.2
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 10:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LNGed+3dYuIHSWdK2PSRzE18TNGHtBrvBVjzLRZ4wv8=;
        b=hjRwGK0gl6UK6ua8NbCVjBb+frOAu66LLLbjdFjRDuSS+5KEhpEgITIrG1tLlL+Tgm
         /kj4WFsHe+X45dQuXFdpePLiRnZZ/7ZTxldLWx+SCjqo9BAzS3g4XvfovsHERnCGtPBm
         WFlGt/0XMgeRO7IuJhoMOwp63bO3PFpWbZCVSFeuU1VO3FlwDcFYych+a9E2PDxKtrdK
         N0sS94PuCmwspZ2+QO/9LEumTM8hqhpFcbO0sG6Y1eXgtqn8+ZukEW3sGOLq4ET/MviD
         A9UPayMqxPsbZMHPdGHufdSoVsMQpnduilu8evglIyNLATNWT74h2+TKK/xxwty+IItv
         qaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LNGed+3dYuIHSWdK2PSRzE18TNGHtBrvBVjzLRZ4wv8=;
        b=GG15YZFARbimDKSoARtTyx9C71TNezQv+0b1SgJRjvrKQVNc2nM/Ukpi740oIAr9Dc
         ETbjrmru9DH9zD92tXrljfJWl0L5gS2vUjwGII3Ci4sF4C76iRAssj1NGe2qYOH8TdtH
         rD/A88Vqmtp3IeOmEb9ss6pOhudx6OCOGVI0ug89bvPuwt2ocrcg6RF/R3XWWTG1lS/E
         TpOYEOHrViJAPzzsn1TyNg9Ozr/rrjIR3nnETHzv+EvxyWnvP+JCrUjU6LL2QdCV3Oio
         rHX3kYllwNUF/L9ax+hFlotB9w6xuhVvJNPKR6sZ1cvZMYfKj8jYZwmzY0EmbcXi6034
         dK1A==
X-Gm-Message-State: AOAM531NBeH+2GbbRC0ounVYBMs3rBRdjmwqM6OVZDoigyeMHbM0fAtZ
        vJvB7JCD+iigAIhBCW22PXaBxh+D5bKxlg==
X-Google-Smtp-Source: ABdhPJyBJFYI4L6e/6OFvXNaW5hQJxby+qN6bXdgXXpE+zYpEzn3IoKbREHI4zFWF4sMvx0v0VYD5A==
X-Received: by 2002:a17:90a:1050:: with SMTP id y16mr9279484pjd.41.1640370644394;
        Fri, 24 Dec 2021 10:30:44 -0800 (PST)
Received: from [192.168.18.18] ([103.252.33.202])
        by smtp.gmail.com with ESMTPSA id b65sm9523414pfg.209.2021.12.24.10.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Dec 2021 10:30:44 -0800 (PST)
Subject: Re: Git internal command line parser
To:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org
References: <0347f273-f9e9-3ce6-2a95-f1ce71285c09@gmail.com>
 <e2726eaa-ba73-4141-bf61-89d5a7e9a9c2@iee.email>
From:   Lemuria <nekadek457@gmail.com>
Message-ID: <0e0f78e9-2cde-a20e-cd47-8542bc7bd314@gmail.com>
Date:   Sat, 25 Dec 2021 02:30:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e2726eaa-ba73-4141-bf61-89d5a7e9a9c2@iee.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 25/12/2021 2:13 am, Philip Oakley wrote:
> On 24/12/2021 14:38, Lemuria wrote:
>> #=< TLDR: Where's the code for git's internal command line parser? >===#
>>
>> I'm interested in the internals of git, more specifically it's command
>> line parser.
> 
> One place to start is https://github.com/git/git/blob/master/git.c
>

Wait, is all of Git just one big executable or are there many 
executables and `git` is just the front-end for accessing the
separate git executables, such as say, the one for processing
commits?

>>
>> Does Git use a library like getopt for it's command line handling, or
>> does it use a custom parser?
>>
>> If possible, I would appreciate being redirected to the source code
>> files that handle this.
>>
>> Sincerely,
>> Lemuria
> 
> Philip
> 
