Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056AAC00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 17:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243671AbiHHRvZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243532AbiHHRvX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 13:51:23 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1189A60C2
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 10:51:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q9-20020a17090a2dc900b001f58bcaca95so8495514pjm.3
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 10:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=c1E+w4xEGDwmmOBAsIJQ1GN8kG5at4YEC7Ntz+PqnZI=;
        b=JPtNY28xOeXerwg65rMPkwZFFkPNLksLaTuezXJ188Xc25XxKqektkU2LfP7jrqCgZ
         TDiMqLeQB+0DIQfOqWVLTRJTwB5UUbHro8ym/ncAA0Xkr1LpPNJMjsgDbXspRrO2Z8iP
         Soh3Svn+GJ5gTNf4hAHPx8URVMl9y5ZYd5+Jr7D0+ciVVw5ZxnFkak6ZQi+IfDE+53M8
         DpMH3nfmuzdzg0fziXiMb8gE298SXCmVZZb7FSBvgdkqV9jHp+bodCJ4V3t8s0XCho9f
         FNF4Zy7y3a9OMueVcjaiudon/rwlmktrNy2NJ0nEecJfR9dk5GH+h5wEzsY1VK8MhKoJ
         KPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=c1E+w4xEGDwmmOBAsIJQ1GN8kG5at4YEC7Ntz+PqnZI=;
        b=wRqBEg+m+BdXI4aK/ccMQij2CSSaBpCNF87vb8Ud7RoNjPAqKd3P88peZQG+Aux7BM
         t4QJluil9vC3s9cd2l2VfJa+eiz8W0iThcfLUp6pi073VcTTdPG0Suud1NtDGwGSp53y
         grbzIWNeVjAxUi7D7Cis0lMvHbVouLSbVhu1ww3r0y1qnelf5jWdPq+aSTL/TmdQaeCu
         Y3kELhFrZrsUmc2uwludSHH3Ox/cQDJLIsPFC6HsOF0fM0xgFrxfPEz3JyBaR4UWnp5g
         yztDBulAHZKyW+7XvNERC47T5ikfPyDmPNsJ62NPP/cyCta6NFoZi2HHMjI5Gci6Ntml
         d8FA==
X-Gm-Message-State: ACgBeo0p9MIi+YKT9RxIg0Rd8jqIKDSL/niUyxVCS3Ab/L80V7+Srczo
        +ePtAvo+GP816KKqre8o51mYkGMk9eYe
X-Google-Smtp-Source: AA6agR79VUy2QOzTup8bzOgSIEvYMdDZsgJqxG6WzhjMQR7OaJQTQZC2AC80K5e/2akJHre/vMiFaA==
X-Received: by 2002:a17:90a:17e1:b0:1f2:2ff2:6cae with SMTP id q88-20020a17090a17e100b001f22ff26caemr30159919pja.196.1659981082573;
        Mon, 08 Aug 2022 10:51:22 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id r27-20020a635d1b000000b0041ae78c3493sm6523351pgb.52.2022.08.08.10.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 10:51:22 -0700 (PDT)
Message-ID: <9ae61888-f7eb-0b36-8ed6-cf72104efb9d@github.com>
Date:   Mon, 8 Aug 2022 10:51:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2 0/4] rm: integrate with sparse-index
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
 <20220807041335.1790658-1-shaoxuan.yuan02@gmail.com>
 <xmqqmtcesl6e.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqmtcesl6e.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:
> 
>> Turn on sparse-index feature within `git-rm` command.
> 
> That is a clearly written single-line summary.
> 
>> Add necessary modifications and test them.
> 
> This states an obvious without adding any useful information.  What
> modifications were necessary and why they were necessary, what old
> behaviour was undesirable and added tests prevent them to appear
> again?  These details are better left to the proposed log message of
> individual patches.
> 
> This series, when queued on top of 'master' without anything else,
> seems to pass its own tests, but when combined with the "reset and
> checkout fixes" <pull.1312.v2.git.1659841030.gitgitgadget@gmail.com>
> by Victoria, the last one t1092 fails.
> 
> ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- 
> expecting success of 1092.27 'reset hard with removed sparse dir':
>         init_repos &&
> 
>         test_all_match git rm -r --sparse folder1 &&
>         test_all_match git status --porcelain=v2 &&
> 
>         test_all_match git reset --hard &&
>         test_all_match git status --porcelain=v2 &&
> 
>         cat >expect <<-\EOF &&
>         folder1/
>         EOF
> 
>         git -C sparse-index ls-files --sparse folder1 >out &&
>         test_cmp expect out
> 
> HEAD is now at 703fd3e initial commit
> HEAD is now at 703fd3e initial commit
> HEAD is now at 703fd3e initial commit
> --- full-checkout-out   2022-08-08 17:19:19.820840016 +0000
> +++ sparse-index-out    2022-08-08 17:19:19.836841239 +0000
> @@ -1,3 +1 @@
> -rm 'folder1/0/0/0'
> -rm 'folder1/0/1'
> -rm 'folder1/a'
> +rm 'folder1/'
> not ok 27 - reset hard with removed sparse dir
> #
> #               init_repos &&
> #
> #               test_all_match git rm -r --sparse folder1 &&
> #               test_all_match git status --porcelain=v2 &&
> #
> #               test_all_match git reset --hard &&
> #               test_all_match git status --porcelain=v2 &&
> #
> #               cat >expect <<-\EOF &&
> #               folder1/
> #               EOF
> #
> #               git -C sparse-index ls-files --sparse folder1 >out &&
> #               test_cmp expect out
> #
> ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- 
> 
> When we have the index (incorrectly) fully expanded, and may have
> (incorrectly) working tree files outside of our sparse-cone of
> interest, we may have paths under the 'folder1/' that we may need to
> remove (and report as removed), but after the bug that causes us to
> "incorrectly check out" gets fixed, perhaps the 'folder1/' is the
> only thing that needs removed if it is outside our sparse-cone of
> interest?  IOW, is the test hardcoding the behaviour of a bug that
> was fixed?  I dunno.
> 

This test failure is a result of a behavior change in the logging of 'git
rm' in this series when removing a sparse directory. Patch 4 talks about it
in more detail [1]; I failed to account for it in my series.

I'll re-roll my series and replace the 'test_all_match' on that line to
'run_on_all' to avoid the failure. This isn't the first conflict my series
has caused with this one, so I'll make sure everything builds and tests pass
with the changes from both series before resubmitting.

Thanks for catching this, and sorry for the inconvenience.

[1] https://lore.kernel.org/git/20220807041335.1790658-5-shaoxuan.yuan02@gmail.com/
