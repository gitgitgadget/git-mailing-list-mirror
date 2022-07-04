Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E46AC43334
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 13:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbiGDNP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 09:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiGDNPS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 09:15:18 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DDFB48D
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 06:15:10 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id k15so8614208iok.5
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 06:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=3H5VzW+QCbTCIuO0cVn7gNQOCEqC0N3xpp3M04V60lc=;
        b=Kr/9T1ozKKq5B9iZZXPY12MhwuYRz8K1NJm4y8gamImm4Y6DLpbgdpA6j/r5YPwVxR
         nhXLb1ap2A4gjLjcT2rm6p+2aCE88G86VEeIJB6jvI8hk4Mgg4VfbnkpcaS5cTws/0rT
         g62Y50lMO2KmkuWh7oLpgQBgGqg8U5Q+8iX18hL5G9Fr446H3iZFSnPq8e0EhxqdOSUC
         DzbOrLOjQTTUrpi40U25r/Wf7nXf37VIBbZC9C9kL2WAqLZ9PXJHyMksUllHns13UHQW
         Q8+tzIn/Hm/TM3UMt4v9RTdW3FeAYc5X/M8wfGK36koUWpHiMOvxsEkkqXpBBN2NTQ8X
         KkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3H5VzW+QCbTCIuO0cVn7gNQOCEqC0N3xpp3M04V60lc=;
        b=59ImMaHH5Ak6sD6vIPBbONvk7Wnb7zFucxdqiMjx/YLeFFd4hA5KDbzuQKPNPKHZSV
         rDuSv9wpQSjDnfKrxDM6ApvwbjUAi7ZsgOEktHGblMxP5TrI0jdXx1ep1VjOx66/ZcV1
         pcy54+dIiv6/p3Xe76epEYqaNrJhdDj9lDdc6roK4ywZWO9yfOj2Dfz+oPWZXNI+WsMI
         yF0w1lfVPrPnYRab/mwuD30H8VK7g1Wa5XXYPCun97TnaTxfu5cvo/2Sh70OcH8Cbg+U
         4bAPMAKnHZi/uJRaDs7Z/ZUGjh8YbDnoRjQeeOTsjSm3OQbuObRrozfusjrAzPEDN5CJ
         xVWQ==
X-Gm-Message-State: AJIora/oqWVUhso5yPFfn+9bO5VjrsNa2q95HLsk3+PDl3ehv0csr8kw
        TMwQ1/3YNtpOT4Su9ItXawlF
X-Google-Smtp-Source: AGRyM1t+ZpjPu4uevakRae8IHUS/FbQsaHe0hxyZeywOZKXkQsMBSElbmhHX5PP++R1DECkflDciQQ==
X-Received: by 2002:a05:6602:2d4b:b0:678:7c5b:c051 with SMTP id d11-20020a0566022d4b00b006787c5bc051mr3689191iow.188.1656940509431;
        Mon, 04 Jul 2022 06:15:09 -0700 (PDT)
Received: from [192.168.103.184] ([4.1.157.141])
        by smtp.gmail.com with ESMTPSA id r128-20020a6b8f86000000b006695b8bb8d3sm14186775iod.12.2022.07.04.06.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 06:15:09 -0700 (PDT)
Message-ID: <15631ea2-6722-fd24-c8a6-0cee638b0602@github.com>
Date:   Mon, 4 Jul 2022 07:15:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: ds/rebase-update-re (was Re: What's cooking in git.git (Jul 2022,
 #01; Fri, 1))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqo7y85t44.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqo7y85t44.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/1/22 5:08 PM, Junio C Hamano wrote:

> * ds/rebase-update-ref (2022-06-28) 8 commits
>  - rebase: add rebase.updateRefs config option
>  - rebase: update refs from 'update-ref' commands
>  - rebase: add --update-refs option
>  - sequencer: add update-ref command
>  - sequencer: define array with enum values
>  - rebase-interactive: update 'merge' description
>  - branch: consider refs under 'update-refs'
>  - t2407: test branches currently using apply backend
>  (this branch uses ds/branch-checked-out.)
> 
>  "git rebase -i" learns to update branches whose tip appear in the
>  rebased range.
> 
>  Will merge to 'next'?
>  source: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>

Please expect at least one more re-roll. Here are the things I
intend to fix in the next re-roll, which should arrive sometime
this week.

* Some commit message tweaks.
* Actually interrupt 'git bisect' and 'git rebase' in the tests.
* Be careful to update the update-refs file when the user edits
  the todo file.
* Consider storing the "before" values in the update-refs file
  and removing refs whose update-ref steps were removed by the
  user.
* Elijah had a question about focusing on "pick" actions, not
  "fixup" or "squash" steps. This might be worth marking the
  option as experimental so we have flexibility in changing the
  behavior as new workflows are tested against this option.
* Elijah also had some optimization ideas, but I'm not sure if
  we should prioritize them here or have them as future
  improvements after the feature is stable.

Thanks,
-Stolee

