Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07CAE1F404
	for <e@80x24.org>; Sun,  9 Sep 2018 11:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbeIIQDs (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 12:03:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42778 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbeIIQDs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 12:03:48 -0400
Received: by mail-ed1-f68.google.com with SMTP id l5so14451151edw.9
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 04:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=6VMICMfj4eSRbSRVg1JZ6u+8oqPcCMZcHwbm5l/Y4Bk=;
        b=mgUiT6rm5yxM4l0qBTDg+LB9ExSsOJ7JHlQJ9XXWRZfsEjitEmZKyWrciwRPp9hNPs
         5VF6S7CvIHumFamHUylTd3DLtdBmdYi+qMYc+QklGgPuSbC95l0DkZSz+tv2B8HqJEK1
         K/r0uxtugei57C4+Q6qJ97gxEVz0pUVb7duyeV+PlSt8Q8CuJ7ZaE/327pDniJtBJYwA
         m5oaQOGXUCSv8FtQwUdAyvFUUI8onMjgg5HG02UvuX4msgHvhZgpSgGYhIR+BMiC3+AD
         YXL+htexW8jezcYESKn69u/I5GaizfnK6u9mkg/bnfNpmsau479v5ClFOc437IOmQzQv
         Z0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=6VMICMfj4eSRbSRVg1JZ6u+8oqPcCMZcHwbm5l/Y4Bk=;
        b=NSgTVPrkSFBG9ag7xxcPxWzDVsxi4ONAlkhEDCjbburNuzgUSnKS+JZjseyDBicmZp
         uC004s1opRvHAIuaC7JdNZr3tsj+gy/nsTLM3i7fkF/A6Zg55nJq61dWvcPRLeEvN/dr
         jOJBhFs1GxXitDsQaH5GCpLkG+5C1h0ET1132Wpbqlrg2ljBJz5l4HuKWTGGPlNSEfWh
         xhiq0RZbmTFBq5QmodM4B0t4v3Hln5ZQC0RGkxAI2iZ4c0T0LVsaK+GEoPtQAW0YcmDO
         7HV8mYNzvBExrBYTLcWz36uW8tmjE9SNEoGKNtI19AiQC5RE8VJpLap4hvJyakbGG01+
         GzTQ==
X-Gm-Message-State: APzg51DtdAbJV6QtKvPpIiE83TRw7kVDVWayfjhg1xujlL/TGpkMBkFJ
        D8bmM/yrqiU6muz57HvVB21947os
X-Google-Smtp-Source: ANB0VdahA5eBFaFWQ2GshcPTsiVBKPyRk491z6JXM7AMc255rYWyaEKV2r+qC3s8K75hY8cDTwcQCg==
X-Received: by 2002:a50:8b25:: with SMTP id l34-v6mr17668054edl.265.1536491666241;
        Sun, 09 Sep 2018 04:14:26 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id z19-v6sm10900691edd.77.2018.09.09.04.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Sep 2018 04:14:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 17/21] range-diff: populate the man page
References: <pull.1.v5.git.gitgitgadget@gmail.com> <pull.1.v6.git.gitgitgadget@gmail.com> <8c5543a0667fffe0cb0684427f726fdfb75b28d0.1534159977.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <8c5543a0667fffe0cb0684427f726fdfb75b28d0.1534159977.git.gitgitgadget@gmail.com>
Date:   Sun, 09 Sep 2018 13:14:25 +0200
Message-ID: <87lg8a7wj2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 13 2018, Johannes Schindelin via GitGitGadget wrote:

I realize this topic has long since landed, just seemed like a good
thing to reply to to ask this question:

> [...]
> +	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
> [...]
> +<range1> <range2>::
> +	Compare the commits specified by the two ranges, where
> +	`<range1>` is considered an older version of `<range2>`.
> +
> +<rev1>...<rev2>::
> +	Equivalent to passing `<rev2>..<rev1>` and `<rev1>..<rev2>`.
> +
> +<base> <rev1> <rev2>::
> +	Equivalent to passing `<base>..<rev1>` and `<base>..<rev2>`.
> +	Note that `<base>` does not need to be the exact branch point
> +	of the branches. Example: after rebasing a branch `my-topic`,
> +	`git range-diff my-topic@{u} my-topic@{1} my-topic` would
> +	show the differences introduced by the rebase.

I find myself using range-diff often by watching forced pushes to public
repos to see what others are doing, e.g. just now:

     + 38b5f0fe72...718fbdedbc split-index-racy       -> szeder/split-index-racy  (forced update)

And then I turn that into:

    # @{u} because I happen to be on 'master' and it's shorter to type
    # than origin/master...
    git range-diff @{u} 38b5f0fe72...718fbdedbc

Only to get an error because it doesn't support that, but just:

    git range-diff @{u} 38b5f0fe72 718fbdedbc

I think it would be convenient given that "fetch" produces this output
to support this sort of invocation as synonymous with the three-arg
form. Then you can directly copy/paste that from terminals that have a
convenient feature to highlight a continuous \S+ reason to copy/paste
it.

I can patch it in, but maybe there's UI reasons not to do this that I'm
missing, e.g. confusion with the existing <rev1>...<rev2> syntax. What
do you think?
