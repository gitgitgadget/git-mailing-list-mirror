Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DBBC433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 05:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiBRFUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 00:20:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiBRFUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 00:20:09 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1986B2409D
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 21:19:52 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m3so7487127eda.10
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 21:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q3BLldAZZ1qrGhvSfuzbiCn+c+9eU5nAWVzxc3H/nzU=;
        b=Z7pX4Qs9zT/ouDnL3kg0/A1AlgMvAocV1M91HjkXP3BdH5vmoRLMGv1BeEAyO9K7Kj
         Xg082kBRxU2yyaBSCQ0pxoVtnIhpameA7KZKpcwki0vFUXKNnNNJ/jFdR3XrSG2UZPf+
         CQZbO30V2eYfBn8pJDSbeHjhuLG8KWYQjknK4m1GuRDAkQiu14u+b+5DJnnLKfSwgd+1
         9mG4iNHnk9IqKLOqnKGUFTFUecaoJuaN1K4vJZDpMcVEBJDcniTd2KAGnH51nv0wjphU
         BnvCc11+qpY9a4hemaIzmSAWVQKbo7nQXRFJ+B1GAgC2o6W2+NxZZWK25Mi3UR1qN9Fb
         K3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q3BLldAZZ1qrGhvSfuzbiCn+c+9eU5nAWVzxc3H/nzU=;
        b=yEju76hqTZcP+70QmoIYMvhARNa90eeMH811viFlPQE6tMqALeouJzqCnZRUrtzTm/
         7y+DafQxt8PafTGoTziiRiQuSdSi+KbFn43HybNkdwtdYXX4fiVRwhmqKQLxNaZ0LkzG
         y3vUO3n6p1M7hjPdLwSFUFYEQBSucsKSYJxavK58mSEXsXhhjetfSqwDk/OiXCtEOdZJ
         aDfXFyjDZOIbOCLkaQBx2G3c1q5ApdBWcjkQn3xG+30n1iDcaN9mLoWpDVFPx2dMC0Ga
         48deeoeWBVlmPyhlf2WMy/aGvwzco5EBuOLQrQnSSmylzuBe+xheVKdjxybAHIqCgU89
         dhzA==
X-Gm-Message-State: AOAM532bGxekqC0UAymql05dFck9mA8lYFXyF4JpvUMV8qhAR/m2etP2
        49x6A5a3sedc/gMVUDDMBOqeFh/IgEEEQX/OkxQtye9Es5Q=
X-Google-Smtp-Source: ABdhPJz4GpgUJcoX7foIpWsD57aajizthyeWdscryPHl+bMC8QsX4XKZc6l4YhysdZm6ndWubKmRRMT4OFSJw9YfZ6s=
X-Received: by 2002:a50:9ea2:0:b0:409:5438:debf with SMTP id
 a31-20020a509ea2000000b004095438debfmr6255519edf.126.1645161591306; Thu, 17
 Feb 2022 21:19:51 -0800 (PST)
MIME-Version: 1.0
References: <xmqqley93rkw.fsf@gitster.g>
In-Reply-To: <xmqqley93rkw.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 17 Feb 2022 21:19:40 -0800
Message-ID: <CABPp-BEcUt-q4vXok=FqZSswPbdUT38=X3kUocbBKO5ydDPrQg@mail.gmail.com>
Subject: ds/core-untrac[k]ed-cache-config (Was: Re: What's cooking in git.git
 (Feb 2022, #05; Thu, 17))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 17, 2022 at 5:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * ds/core-untraced-cache-config (2022-02-17) 1 commit
>  - dir: force untracked cache with core.untrackedCache
>
>  Setting core.untrackedCache to true failed to add the untracked
>  cache extension to the index.
>
>  Will merge to 'next'.
>  source: <pull.1058.v2.git.1645131630140.gitgitgadget@gmail.com>

Any chance we could first rename the branch to insert a missing 'k'?
'untraced' and 'untracked' may only differ by a character, but their
meaning differs a bit more...
