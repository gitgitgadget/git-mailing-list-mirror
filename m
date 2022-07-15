Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF6AC433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 16:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbiGOQ7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 12:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbiGOQ7O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 12:59:14 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066602CCB7
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 09:59:14 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id q14so4299492iod.3
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 09:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kGtAn3jIAIsrQHRLIb+nJ2ELEmdKnMtRNl2igk9/03k=;
        b=v3flV6pHDgsIxSxl8bvG+wH3wK0oTazV8z8fukaJHJzx35RA2PmLfXGUPAWFQmht76
         5Vxj9kGjzK1uZk+diQEA8y3KmpPh9qo2itFXh2w5GRZlbZI9SN/WC02JmIDW5XV4ouDW
         xYB4n19YbmsJ6lKx5BLoUz97a1nQybhbX/rc+SyAkIX2G3lvzu9B49EBxCDPG8SLhDz5
         4QYXPQ5sW2s4LCLTj+WoUE5axfl/atJMtlG9FrAz9VUJsee9aMgyN8tptTw6eDBS2kSt
         JP0QAHbOack+xh0f739lASRuTH1cG7jUq9UzIZIwWxgj2OvDgaQDrG2CI6VyZIXENtyZ
         gzCg==
X-Gm-Message-State: AJIora/LBRIYyltCKQPirLX6tnZ7TXP0sGo4tPrdF3vUuK+M1JDj35pd
        0Q0QgXThxoQcB0F538D5w9c=
X-Google-Smtp-Source: AGRyM1vuh7IqjmGWaBwVtNSvJkEt+2/pyNbT2UOigg2SEGhXsAw32QPMcKibGgEvh0v1zdLfsVzgKA==
X-Received: by 2002:a05:6602:340b:b0:67b:8189:23c5 with SMTP id n11-20020a056602340b00b0067b818923c5mr7433315ioz.52.1657904348429;
        Fri, 15 Jul 2022 09:59:08 -0700 (PDT)
Received: from [10.0.0.141] (c-174-62-43-211.hsd1.nm.comcast.net. [174.62.43.211])
        by smtp.gmail.com with ESMTPSA id g26-20020a05663810fa00b00339d244c4a6sm2172924jae.23.2022.07.15.09.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 09:59:07 -0700 (PDT)
Message-ID: <337199fe-4e5a-3f07-7ae6-2867e5cc3410@kinzelman.com>
Date:   Fri, 15 Jul 2022 10:59:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: paul@kinzelman.com
Subject: Re: moving a repository question
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <2e592944-edb8-2d49-981a-8ad220f97e82@kinzelman.com>
 <xmqqilnz2tck.fsf@gitster.g>
From:   Paul Kinzelman <paul@kinzelman.com>
In-Reply-To: <xmqqilnz2tck.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Part of my question is just understanding git, it's different from another
source control tool I've used.

The other part is if I'm having trouble networking computers together,
I'm wondering if I could copy everything under .git to a flash drive,
then write the tree to another PC, and expect everything to work? And when
they are able to network with each other, they should be in sync
(assuming vanilla, no changes, no uncommitted files, etc.), and
I could modify a file on one machine and expect that the other
copied tree would be able to fetch it?

Note, I'm talking a very vanilla case here, no complexity like you were
mentioning, no branches, no uncommitted files, no multiple worktrees,
no changes in files, no nothing. Just a straight simple single project.

On 7/14/2022 4:59 PM, Junio C Hamano wrote:
> Paul Kinzelman <paul@kinzelman.com> writes:
>
>> I barely qualify as a novice on git, so my apologies in advance if this is a
>> stupid question.
>>
>> Is everything that git needs stored in the .git tree?
> Depends on what you want to do with "Git".
>
> If you only copy .git/ and no file from the working tree, your "git
> status" in the new location will report "you removed all the files
> and you have nothing", for example.  If you are willing to do "git
> reset --hard" after making such a copy of ".git/", it may be OK.  If
> you had local changes in the working tree before taking a copy of
> .git/, doing "git reset --hard" in the new location may not recover
> the local changes in the original, so it may not be good and you may
> have to copy the working tree files as well.
>
> If you are using multiple worktrees linked to the repository,
> copying .git/ is an absolute no-no.  Locations of secondary
> worktrees are recorded in .git/ somewhere and copying them literally
> would mean the new copy would mistakenly think that these secondary
> worktrees linked to the original repository are linked to the new
> copy instead.  There may be other things that will cause confusions
> when copied.
>
> "git clone" will of course sidestep all of these problems.

