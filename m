Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08795C4332F
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E62C0611C6
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbhJFUme (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 16:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239569AbhJFUmd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 16:42:33 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B898C061755
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 13:40:41 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id jo30so2795983qvb.3
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 13:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sCAYaffdN1EJfz166vHKrpknooesS+vxdx670FIl2QI=;
        b=IUHzrZCalDyCDoQz46v8G6gQokZ4zoQBC+Qq6QKJW9wJ/UVgIfgaSI9CrzHJCoaKoM
         +O9h/U1/uOfEgINVPJYl9LlJYLiZaiNP5U0lJcXit66we+SA4Hhv3unDpDTKLtTE/PK5
         xoC6SexF2qb1yd35GI59Wop+Z75DXEu8SMyACZrmvB9c/x2H4XV5vjDl+VSryPi2bosM
         GGjr9hyxNkTCn8ZF/hHbkKafmWb1bcbrG6WsiOkv/4sAl4+dNx9qbXUG/K5lu6RBlquh
         TvxnkhQMR3+ePpYLyOANu9ZfYXpjzM9wHbwFnLrcV6G7N9OSIEjtv9T8CtREf/2uXON4
         cXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sCAYaffdN1EJfz166vHKrpknooesS+vxdx670FIl2QI=;
        b=d94FvE5dDTVTX+GNcBfGwOzZeQzUJBKRoHV2loqMTQhVn5xfOFRyRyZeq4Zf+TF0mL
         hvlwBk+YJiNjSNOcnRGGqYrYyJj3FONBC4VgoIvmf/K8fRa+7ajbpAA84mvbjgXSQioa
         0RAvqVB6DW+SLGhjbqTVoSEF5cmI03GrcHj9Hu+1OKGvdFHOi7m0mza86I0RbXFRjCu3
         zGAhSUYAQ/TJOv8ZLTh9idmjt5D4oNkkGvh20SJ8PmZqlEcddmN6L/VOcLFnBoFySsOI
         cWZz/Tv89LurjwAbWrPEefKbq4OvsVtRaMLRcVnUgEySYFGVjdec29am1YWu1QfItbr2
         9+MQ==
X-Gm-Message-State: AOAM532DRPDfeU1ZrtnR4vFSAMbgP8XwuYZc8ltLWRyTB5FBNttWPP2P
        3qnbOy4hrggBqvExNnaJQcaxL/yCSHNI
X-Google-Smtp-Source: ABdhPJzC7WRDLTpFYDWlZk4WC6BH0z9kzXImnr862D32Af95a8ZNZysDsxhQkVHRBStX8q68ObwHzg==
X-Received: by 2002:a0c:e147:: with SMTP id c7mr173362qvl.35.1633552840211;
        Wed, 06 Oct 2021 13:40:40 -0700 (PDT)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id bk20sm13313189qkb.13.2021.10.06.13.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 13:40:39 -0700 (PDT)
Message-ID: <3cfa0810-4449-1170-1f7b-cd029e5ce434@github.com>
Date:   Wed, 6 Oct 2021 16:40:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH v2 2/7] update-index: add --force-full-index option for
 expand/collapse test
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
 <f7cb9013d46731855c3ed42add62b021c0ad0c73.1633440057.git.gitgitgadget@gmail.com>
 <CABPp-BHD3khX+q7crk4JnNbGd9fN-vJW0L1x=5JdzkFL6X1BBg@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CABPp-BHD3khX+q7crk4JnNbGd9fN-vJW0L1x=5JdzkFL6X1BBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Tue, Oct 5, 2021 at 6:20 AM Victoria Dye via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Victoria Dye <vdye@github.com>
>>
>> Add a new `--force-full-index` option to `git update-index`, which skips
>> explicitly setting `command_requires_full_index`. This lets `git
>> update-index --force-full-index` run as a command without sparse index
>> compatibility implemented, even after it receives sparse index compatibility
>> updates.
>>
>> By using `git update-index --force-full-index` in the `t1092` test
>> `sparse-index is expanded and converted back`, commands can continue to
>> integrate with the sparse index without the need to keep modifying the
>> command used in the test.
> 
> So...we're adding a permanent user-facing command line flag, whose
> purpose is just to help us with the transition work of implementing
> sparse indexes everywhere?  Am I reading that right, or is that just
> the reason for t1092 and there are more reasons for it elsewhere?
> 
> Also, I'm curious if update-index is the right place to add this.  If
> you don't want a sparse index anymore, wouldn't a user want to run
>    git sparse-checkout disable
> ?  Or is the point that you do want to keep the sparse checkout, but
> you just don't want the index to also be sparse?  Still, even in that
> case, it seems like adding a subcommand or flag to an existing
> sparse-checkout subcommand would feel more natural, since
> sparse-checkout is the command the user uses to request to get into a
> sparse-checkout and sparse index.
> 

This came out of a conversation [1] on an earlier version of this patch.
Because the `t1092 - sparse-index is expanded and converted back` test
verifies sparse index compatibility (i.e., expand the index when reading,
collapse back to sparse when writing) on commands that don't have any sparse
index integration, it needed to be changed from `git reset` to something
else. However, as we keep integrating commands with sparse index we'd need
to keep changing the command in the test, creating a bunch of patches doing
effectively the same thing for no long-term benefit. 

The `--force-full-index` flag isn't meant to be used externally or modify
the index in any "new" way - it's really just a "test" version of `git
update-index` that we guarantee will accurately represent a command using
the default settings. Right now, it does exactly what `git update-index`
(without the flag) does, and will only behave differently once `git
update-index` is integrated with sparse index. Using `--force-full-index`,
the test won't need to be regularly updated and will continue to catch
errors like:

1. Changing the default value of `command_requires_full_index` to 0
2. Not expanding a sparse index to full when `command_requires_full_index`
   is 1
3. Not collapsing the index back to sparse if sparse index is enabled

I see the issue of introducing a test-only option (when sparse index is
integrated everywhere, shouldn't it be deprecated?). If there's a way to
make this more obviously internal/temporary, I'm happy to modify it. Or, if
semi-frequent updates of the command in the test aren't a huge issue, I can
revert to V1.

[1] https://lore.kernel.org/git/xmqqr1d58v9x.fsf@gitster.g/
