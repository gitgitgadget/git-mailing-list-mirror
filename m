Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E97C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 12:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbiGNMMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 08:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238801AbiGNMLv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 08:11:51 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03ED14D0D
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 05:11:41 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id ck6so1211534qtb.7
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 05:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=eS7/exNIdBm6f5R3ByUQ3lXJLHcApje6xPTAndwWfNw=;
        b=gCFNhglt276/4oYxyZeBKSbfMuODIC6gw6jevBSstdIg2p0RLiYdoBU5Er3pHoMrLX
         CgSerwp9cvr0Vt2mmS1HAx35Ewvk/5huwJQmNj14zsdpaZWNN2vYfE7YdrpKDVFr6l8/
         nKu8xdQFk6by7I7RUnmiBwgqWmF3kupmicsAfb7uBJPANImfk+ZEF6lprv97q/cxcfZv
         ZyQsT8qKEge+NrZ4o/PXgIq7E17Z9lV582kVOMG8NInOgdwzl+lGP2YpRY3vco5T96Sn
         eKf8SJ1I1vrYcDot82U5rmmCeVVwEWqAR+eqwL5eDqdLcVdPwEwFI8t/pInDf1ylyrAb
         jgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eS7/exNIdBm6f5R3ByUQ3lXJLHcApje6xPTAndwWfNw=;
        b=g4+c6/AygykciOTn9IPFHRWI24YTM/a/YIgcwLYzEpcU9msDzBP9XHVzLSl5Z6sLnE
         T65gC7TUfSS4peIgNm2TfngAt7OeyhIDIa4pHRV6Q9uoY/C6LPGdNNDkLeCc5pKHelEd
         JvJSqUMrZbwj6UIncD+lQItL1X52z86YvluvxEINo0oR4yj/YHydQgxFUK8BUX60Hi15
         SuDAFhldCabSs+8T9kBDeiNoKtgKuZmDBdgBFH8rbqfZgLEOTrRHdB/XirLS8nJgnCXB
         z/GUpA9jXxcgr2W4b5wrx1hw0Yg3rjteDTTpT7raHpmN7F1U1n6yrbI1jazXf5mCFrZ7
         P72A==
X-Gm-Message-State: AJIora9qP+Uh+hpvjKYLJySk2AQECmxvUeASMOO1DOtEHtOVDMkLW6Ew
        Ufweh2RiXW0GLoWjJmfMNweA
X-Google-Smtp-Source: AGRyM1tqimRt1jvZvqm03vQxIIS3V4PTI24n2VQYl3BmIdeN0/Le00cOtIt07BC46cOPwkMlG76tYg==
X-Received: by 2002:ac8:5781:0:b0:31e:b8ff:a75e with SMTP id v1-20020ac85781000000b0031eb8ffa75emr7550385qta.299.1657800700682;
        Thu, 14 Jul 2022 05:11:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b902:f215:a426:27bb? ([2600:1700:e72:80a0:b902:f215:a426:27bb])
        by smtp.gmail.com with ESMTPSA id c8-20020ac86608000000b0031eb6b42b26sm1246364qtp.73.2022.07.14.05.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 05:11:40 -0700 (PDT)
Message-ID: <c77648aa-b74b-008b-0bc0-bd6f95eedf2f@github.com>
Date:   Thu, 14 Jul 2022 08:11:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: ds/rebase-update-ref (was Re: What's cooking in git.git (Jul 2022,
 #04; Wed, 13))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq7d4g8onl.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq7d4g8onl.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/13/22 9:32 PM, Junio C Hamano wrote:

> * ds/rebase-update-ref (2022-07-12) 13 commits
>  - sequencer: notify user of --update-refs activity
>  - sequencer: ignore HEAD ref under --update-refs
>  - rebase: add rebase.updateRefs config option
>  - sequencer: rewrite update-refs as user edits todo list
>  - rebase: update refs from 'update-ref' commands
>  - rebase: add --update-refs option
>  - sequencer: add update-ref command
>  - sequencer: define array with enum values
>  - rebase-interactive: update 'merge' description
>  - branch: consider refs under 'update-refs'
>  - t2407: test branches currently using apply backend
>  - t2407: test bisect and rebase as black-boxes
>  - Merge branch 'ds/branch-checked-out' into ds/rebase-update-ref
> 
>  "git rebase -i" learns to update branches whose tip appear in the
>  rebased range.
> 
>  Expecting a reroll.
>  cf. <15631ea2-6722-fd24-c8a6-0cee638b0602@github.com>
>  source: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>

It looks like you've picked up the latest re-roll (v4), so this
status is a little stale.

Thanks,
-Stolee
