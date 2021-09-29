Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EFDC433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 09:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF89460F58
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 09:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245015AbhI2JRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 05:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239961AbhI2JRi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 05:17:38 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F70AC06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 02:15:58 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r2so2029361pgl.10
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 02:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gbTnr52fUzXU4QhLPQOH/wN/1vq3a3VC7/HCKBUy5lY=;
        b=Qu+nIOb3rNf03kCLr0N/6DsbUyd4DHI4EroDJrWnDpobvNm7VkPkF+o5aqcBRGRDdq
         rgsZg4hXnLNPe7wvFr+qWE43CTZQPlHaHy+XksjbgZBblulZS5Lcpd6IKkbC1kExuNn0
         inSRQfPTPv5c8ASfhwEbsRyFSyxp/TTrlzc6ZAzTrB970gJcWo7EECZEB/4yhf27H00P
         KiLgPwQT9v3JQ91UTFnzW18RXhhWVgTuAQsKsa8dD8HyP9zsbFTuXLy0AfuSzFBEi91T
         f7jCWBoNRhRtAT7sBXlYbum0y/P4cgNBqfER6NQ/GhUzGlZMdahQqOo10+5rHKhUr+hh
         fjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gbTnr52fUzXU4QhLPQOH/wN/1vq3a3VC7/HCKBUy5lY=;
        b=YsnkQ7ReN7Lla+0VbsPy3mvMuw3AiBhnTf4zixaWnNMPC2LideRJTioUZa2wIJwOcq
         ufR+vDazkI7+cGK3nP67ObsC158mg9aON3bgrg7eifJaywsPDOGwffi0MYN3SgA92jdi
         W9gAltghzKegq5sEYKX8xRs8JpP8X1Z58Puh8YgMM9G06HqgHJlXGsYxzZFDzqD553qV
         /j1TQvpur5IwmVMm/uzXCH1MeT7gsUyQbOJpo0CJEa9lKil4H1Y/JF/f2cK8kLqNDVr1
         FA7TWlrQZdQiqkx83TRYt0RpxtQ+Dmy06G714ViPUXee62GFVaLVUPgVyx75g1e/teCo
         0T8Q==
X-Gm-Message-State: AOAM530lH3NNNJXmLGjW8rGlsY+DX8CaIwyM1vkaN9zeMoOxdE2YBOkp
        ZHHbXQC7rAB0LdKaSdXDCL0=
X-Google-Smtp-Source: ABdhPJy+1SyANnCq8RIMLklSBXhXz3Cr0E54cOQ0/XH3kg8Ii3++Cpv24o/He2vtBBPZ8BJcIA/S1Q==
X-Received: by 2002:a63:1d25:: with SMTP id d37mr8694127pgd.52.1632906957807;
        Wed, 29 Sep 2021 02:15:57 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-59.three.co.id. [116.206.28.59])
        by smtp.gmail.com with ESMTPSA id u4sm1727984pfn.190.2021.09.29.02.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 02:15:57 -0700 (PDT)
Subject: Re: [PATCH] blame: document --color-* options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Dr. Matthias St. Pierre" <Matthias.St.Pierre@ncp-e.com>,
        git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>
References: <d918fe0de6b04d8d848050d4aedbe060@ncp-e.com>
 <20210925121817.1089897-1-bagasdotme@gmail.com> <xmqq5yulregh.fsf@gitster.g>
 <fe78329d-07a7-bdf3-2bda-13def35f3de3@gmail.com> <xmqq4ka4n00h.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <7745e157-7df9-2da7-f391-8c5bae16f005@gmail.com>
Date:   Wed, 29 Sep 2021 16:15:55 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq4ka4n00h.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/09/21 23.22, Junio C Hamano wrote:
> Sorry for skipping a level of logical progression in the suggestion.
> 
> While I do not think we want to add another section for the default
> format, if we were to add such a section, the new description should
> use phrases that would have been used, and such a section would not
> use a new and unclear "metadata" in the description.  Instead it
> would use phrases that the users can look for elsewhere in the same
> documentation.
> 
> What is colored is the summary of the commit the line came from
> (abbreviated commit object name, plus the author name and time by
> default) plus the line number, I think.
> 
> Thanks.
> 

Stefan mentioned "metadata" term to describe the line annotation, from 
commit cdc2d5f11f1a:

>     When using git-blame lots of lines contain redundant information, for
>     example in hunks that consist of multiple lines, the metadata (commit
>     name, author, date) are repeated. A reader may not be interested in those,
>     so offer an option to color the information that is repeated from the
>     previous line differently. Traditionally, we use CYAN for lines that
>     are less interesting than others (e.g. hunk header), so go with that.


-- 
An old man doll... just what I always wanted! - Clara
