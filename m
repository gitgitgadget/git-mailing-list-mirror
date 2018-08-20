Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6B591F954
	for <e@80x24.org>; Mon, 20 Aug 2018 21:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbeHUAbv (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 20:31:51 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35728 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbeHUAbv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 20:31:51 -0400
Received: by mail-yw1-f68.google.com with SMTP id s68-v6so7376434ywg.2
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 14:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CXAnl6xqB9aI47VvMrfhrp5yrsk55q3QL5QWBdV/Vk4=;
        b=UvGh/U5yHZ8SVBormZk7jO6NNdZMNB6MMCuOveUjAqRnMAz4mykTCckyMx14FBr7JB
         h8U+/Yak/MOKP1ujWHhph7xMwhUD2kgEYHiSjUdPTfikd7QwseK3MZY+7RYq4GSOtToq
         ceqasz9NrXXEv/yB83Mym+OlQ0fE17VKsaoyTl9efG8C6Km5ON86POdp58lVYlf/izZO
         JgKtzJl4leJpet+Wbl7BA/YcIMO6GtRlXUdgFbu4ZQ7nCH9M8lKi0f/ljCyRxTVqsSa5
         6X3zEpSCpurs1wFRiSnOFJ9+2IH6WXr4zng7IzOQ2+zQtzBsODUm8VCR6tABQXxBTMnF
         f3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CXAnl6xqB9aI47VvMrfhrp5yrsk55q3QL5QWBdV/Vk4=;
        b=SX20f/Kz6MR+/C1cWAs53dVFkJmi7whLSt4N+t54BwKJY2h2b2eEqAFpr8BH1r9rpT
         GTGf5QYSxptih7GpxJsxKMewiIpYTHBb5BZ8M6pmAa5lg5k7NiDJiGof3Bi4iFhU+45e
         K94MtpQ62GRUKbVXsddPoUtFNQKjFxK5Q6OXxx6exxNAnPZLJD2rnm9dihem71axi/fl
         hwJccyszpsJ7AlY5/HwOEm3reUEQ8QqzOJrPfTua3eW2NyGMO2FRuZoKmyuelYT1o6IX
         DioQ/AC6hyHAqGSW1XWJAIbKm0swkeTyuT7rSYOAIcQhArwYAwejBVgZwRKbn6l50OJE
         QEKA==
X-Gm-Message-State: AOUpUlFyihVfMu60lTjCXZYV0J+V4MI//6Wp4aI3d2wKxVXrIYGHgXGF
        kuAFerar2wJOxUasOLfOLzK5f0+Epeo1p0uZ9vRoqQ==
X-Google-Smtp-Source: ANB0VdYqZxVwt41+sOjO2nxlF+PVvVe5kjajGP6S8Mxkp7+tVQby9hBL1RgbY7ewabpaSn+lXOlkK13QU4lFSSpc974=
X-Received: by 2002:a81:ae06:: with SMTP id m6-v6mr2564056ywh.119.1534799678165;
 Mon, 20 Aug 2018 14:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180820165124.152146-1-dstolee@microsoft.com> <20180820165124.152146-3-dstolee@microsoft.com>
In-Reply-To: <20180820165124.152146-3-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Aug 2018 14:14:27 -0700
Message-ID: <CAGZ79kZJJk5DSu+kNBZgxMvy36Fq9tYcBG-BLmpJ6LOKPRtGVg@mail.gmail.com>
Subject: Re: [PATCH 2/9] multi-pack-index: store local property
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 20, 2018 at 9:52 AM Derrick Stolee <dstolee@microsoft.com> wrote:
>
> A pack-file is 'local' if it is stored within the usual object
> directory. If it is stored in an alternate, it is non-local.
>
> Pack-files are stored using a 'pack_local' member in the packed_git
> struct. Add a similar 'local' member to the multi_pack_index struct
> and 'local' parameters to the methods that load and prepare multi-
> pack-indexes.

Going by that example, maybe we'd want to have it be the first bit
of a bitfield, c.f.

    unsigned pack_local:1,
        pack_keep:1,
        pack_keep_in_core:1,
        freshened:1,
        do_not_close:1,
        pack_promisor:1;

in the definition of packed_git.

Is there value in documenting both packfiles as well as midx variables?
(When going with the bitfield example, it may be a bit more worthwhile,
as the commit message is harder to find, as it will need repeated
blaming in the future, if there is a commit on top that adds another
bit to the field; I am unsure, but I would lean towards documentation
as it becomes a bit unclear: Is the local flag for the midx file that
is read, or rather for the underlying packs? What exactly is local? )

AFAICT this patch alone doesn't have any effect, yet, as it only pipes
the flag thru, is that worth mentioning or is that obvious?

Thanks,
Stefan
