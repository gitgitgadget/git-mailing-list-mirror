Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351ABC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 03:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343948AbiBPDBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 22:01:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240388AbiBPDBs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 22:01:48 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8416F28988
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 19:01:36 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id f11-20020a4abb0b000000b002e9abf6bcbcso1051660oop.0
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 19:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OAfpUlTzy0qMDOl/3Q9/sM7eV4T88P5FTVmRL+Ovnug=;
        b=bN1GWcmr8uMM+LY1MCsZj3cvoW9MosZooCInh9uX0XPpxNpdvX2PVDMaKfQGosk5If
         6wpGCz244ujfFKusiEclYgg4ij+uKHvI8GsHDDNQzvwS6lKD2PE7c56WV3kE+3ITgGAw
         3cFClzGcVESEjcHyTHnm3DnxWe0n/4LCaspgQozGMyyP15cWyjcrLMeSB2yI5PUD463f
         EX3gQS90EqThuD38+7gprySskTVYfykbnbk3xq19goOFicjGyjy1L6Z2gj3dNNJgDjlM
         8W78KLGx8AEXQKVITJ67H6btA+qMLWPTevjNs9OYw5y26FDJ7xa8JuuoEWAqhZCNal2u
         cuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OAfpUlTzy0qMDOl/3Q9/sM7eV4T88P5FTVmRL+Ovnug=;
        b=279n2ChSSP+4TVK6bZIMQWbJmjU78fqw3S7jY3NGltzkBEb4NbBXuMyRu1MQXxUoFf
         IyEpoHT0JehpJffJFtsH6cYjQnJMSOESb+mY3LsTTtPzjB13AOHDGolUs/7zuyLZhpKO
         nmJXz/hgjofUdbrmOYN3qdG2KQIacO9Y4iP5bST5g4GDpG7VvHDrxBTnQu0Kn/EyFUtC
         c4epq2oJyLc1VQMXk+xTQaz/XWfQ7D8mui93bOUiSmeyZUZgYfRULKQWhtji92xjsNHp
         C/soY2gW3iBwyBS0j3qlsFZB7w7Py8slQxoJ4IhRoHKQPF3RePmhPmnpegrU6idZIMQv
         dgfQ==
X-Gm-Message-State: AOAM533zPla5YKcJ5dXXpBOqS6zDxcQvWzHgzLAJ6foxuCmO2tTCOEOn
        tpWQok0j3joChR8EysL/845JilbShbNThwOO9lk=
X-Google-Smtp-Source: ABdhPJzm3tSpOQgF8/58LxvRLqiuhnN+KT1sumSCLaJ8Y+FRUbYK+EdKEyuExNxf7nHhEZ01dMSZ5hUg2J/4JXBkwAE=
X-Received: by 2002:a05:6870:210a:b0:ce:c0c9:709 with SMTP id
 f10-20020a056870210a00b000cec0c90709mr2552820oae.347.1644980495900; Tue, 15
 Feb 2022 19:01:35 -0800 (PST)
MIME-Version: 1.0
References: <CAJyCBOTuNn24_WvHv-xQsCdtr9-4_fdrMrOC7ZApg1xFp4RNWQ@mail.gmail.com>
 <d6286f84-642d-7448-0d2e-dd4c20bdb289@gmail.com> <e81f044d-8c3a-90df-ff9e-719b613807d6@gmail.com>
In-Reply-To: <e81f044d-8c3a-90df-ff9e-719b613807d6@gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Wed, 16 Feb 2022 11:01:24 +0800
Message-ID: <CAJyCBOSPqP4Rh5ZQhj-DexXXtkwCJTT3tL7DToREfsRR6Hozxg@mail.gmail.com>
Subject: Re: [GSoC] Interest in "More Sparse Index Integrations" project idea
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, vdye@github.com,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 15, 2022 at 2:45 AM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
> Or even better (you do not have to guess the number of commits in
> each series):
>
> git log --oneline --graph 3c0e4178277^-
>
> (see [1]). Why that syntax seems to completely ignore '--graph',
> though is beyond me!

I read the [1] and this "<rev>^-" syntax seems to exclude the first
parent of <rev>.
In another word, it only gets the part of history within the checked-out
new branch, i.e. "This is typically useful for merge commits where you
can just pass <commit>^- to get all the commits in the branch that was
merged in merge commit <commit> (including <commit> itself)."

It seems that the checked-out branch has a linear clean history,
and that's why it looks like "completely ignore '--graph'". Actually, it does
not ignore "--graph", e.g.

with "--graph":

* 3c0e417827 Merge branch 'ds/fetch-pull-with-sparse-index'
* 408c51f0b4 test-read-cache: remove --table, --expand options
* c2a2940510 t1091/t3705: remove 'test-tool read-cache --table'
* 3a9a6ac5d9 t1092: replace 'read-cache --table' with 'ls-files --sparse'
* 78087097b8 ls-files: add --sparse option
* 5a4e0547e2 fetch/pull: use the sparse index

w/out "--graph":

3c0e417827 Merge branch 'ds/fetch-pull-with-sparse-index'
408c51f0b4 test-read-cache: remove --table, --expand options
c2a2940510 t1091/t3705: remove 'test-tool read-cache --table'
3a9a6ac5d9 t1092: replace 'read-cache --table' with 'ls-files --sparse'
78087097b8 ls-files: add --sparse option
5a4e0547e2 fetch/pull: use the sparse index

Look at the asterisks prefixing every commit in the with "--graph" part.
If you init a new repo and add a few commits to form a linear history,
you will get a similar result by "git log --oneline --graph".

> [1] https://git-scm.com/docs/gitrevisions#Documentation/gitrevisions.txt-emltrevgt-ltngtemegemHEAD-HEAD-2em

-- 
Thanks & Regards,
Shaoxuan
