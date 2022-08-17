Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A912C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 13:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbiHQNlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 09:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbiHQNlO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 09:41:14 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF8365554
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 06:41:13 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id o14so6914099ilt.2
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 06:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=J8sZZcCWxirgywGqv4Ft126LLIwio6rIgHi9zMvzDZw=;
        b=jMUYk+444+UFIpeKZ5TTwW3m0O995C4n3xik8lV3VawaGkaEaay0/heugKsuP+DMdp
         SNVoJZcqskDbqFpwi4Bky57d+PFUuvpSmKZYzQf8p/GeKix10I3UxnhfUQiq+ZuQc4sK
         gF1fkpVasW5+3nzGoa+P+NclAvN5XqoPg4PSCTu1PLUh26Pd3hS9YESGxsON12/0GzYE
         shcWeCsKrfvAmqgOl7p433+xLDV03XaMqXIgwnOxWDzNIy82RIVtXk1xaV1zQVckItcu
         0h1PVF9xkbCijZdgCL2CwJLmTtFpUom5IkcKGOJQUQ1pSdGjZxhjJZ5CtApbG71QSHyB
         Qh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=J8sZZcCWxirgywGqv4Ft126LLIwio6rIgHi9zMvzDZw=;
        b=Gwx4ONo+e5jfc09n4B8ckJFQnNu3HMiBm0VizTnIArXAFWuMzQh+BVjKqdyTT7ewyu
         kJbrc9Dg/025woffa5hvcpRPkudglKhJ+cyHHCbj9GWVXKaWdKOCecjSvD7iEswdR/m1
         lsdoGUtpaTPteZ5onT1yuNYCF1mTJCDeF4ypYcs7rfidrxDWOfNjObsB+HRrDGyUn577
         h8VD6i9UgitdSom1hCrOVmdZT51VzFW1D6tvUBkFXjB5leKGyPUrx/4F6gJB5I84zuc0
         4JP6ppF4EO0YtdR2KWDde4UedDmCBhKd4vI1NzOZNFpU6yOnhu9f9ty9hCA9SIhlbjRl
         9nXA==
X-Gm-Message-State: ACgBeo0oS527QTyDSX61/iL12VXglyP0F8IcuY+Uaf07H1F6PEGBeqBU
        rJMyDENW45NzqS4maJl8F1i9
X-Google-Smtp-Source: AA6agR5C3zjWFtw7pCOmPDt2/o4LZtbnnA/4Ap7NTo1wR6TXaRTtFuAo5o6QbOLIUutme8bNHfCkvw==
X-Received: by 2002:a05:6e02:1708:b0:2e7:1664:92c0 with SMTP id u8-20020a056e02170800b002e7166492c0mr2937945ill.103.1660743673200;
        Wed, 17 Aug 2022 06:41:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f8cc:7049:fd75:5ebd? ([2600:1700:e72:80a0:f8cc:7049:fd75:5ebd])
        by smtp.gmail.com with ESMTPSA id z10-20020a92da0a000000b002ddf58d8828sm5994827ilm.19.2022.08.17.06.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 06:41:12 -0700 (PDT)
Message-ID: <fc71e91b-7a66-5653-d723-e4df17bf2a9c@github.com>
Date:   Wed, 17 Aug 2022 09:41:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [External Mail]Re: Partial-clone cause big performance impact on
 server
Content-Language: en-US
To:     =?UTF-8?B?56iL5rSL?= <chengyang@xiaomi.com>,
        Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        =?UTF-8?B?WGluNyBNYSDpqazpkas=?= <maxin7@xiaomi.com>,
        =?UTF-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?UTF-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?UTF-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
References: <bfa3de4485614badb4a27d8cfba99968@xiaomi.com>
 <YviaoXRctE9fg/mB@coredump.intra.peff.net>
 <85e6fd08-c741-26d4-1393-4b115133e687@github.com>
 <11d7fc5721c541d6bc44bf635517497b@xiaomi.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <11d7fc5721c541d6bc44bf635517497b@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/17/2022 6:22 AM, 程洋 wrote:
> But I still think the protocol still should tell the server which ref
> the blob is reachable.
> Because it would be really hard to implement any kind of ACL

I think this idea has merit on its face, but it wouldn't really solve the
problem since the reachability query would still need to be done, just
from a smaller set of references at first. If we were able to say "this
blob can be found at path X at commit Y" then the server could do a
commit-reachability query and a path traversal, which should be a lot
faster.

However, it would be extremely difficult to plumb into the partial clone
machinery. At the point where Git realizes it is missing a promisor
object, that code is very generic and removed from any kind of walk from a
reference. That is further complicated by the fact that the walk is
probably from a local reference, which can be entirely different from the
remote reference.

> But git is surely designed for open sources community. It makes senses
> this request will be rejected.

We try to keep all kinds of users in mind, so the fact that this applies
to not-completely-open repositories is not a blocker.

One possible hurdle is the fact that this branch-level security is a
feature of Gerrit, not a feature of Git itself. Optimizing Git to that
special case that Git does not itself support is less valuable to the Git
project itself.

My personal take is that the technical complexity required to make this
faster paired with the limited scope means that this feature would have a
difficult time getting accepted into the Git project. Perhaps a motivated
contributor will find ways to overcome these obstacles and find other
interesting applications that benefit a larger portion of Git users.

That's just my expectation. I'd be happy to read any patches that try to
solve this problem.

Thanks,
-Stolee
