Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33566C433EF
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 13:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbiF2NDx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 09:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbiF2NDv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 09:03:51 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F15828703
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 06:03:49 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 59so24637530qvb.3
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 06:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lFI1nwjuQZ6G3s+nLhl24sQCFqL8NbzRi33/2wp2IFE=;
        b=Y2i4aJLh8E6yqGGsuo43sWuc7lljjRncoX38mL9y6WC7ExQGDDeNs950gPL3bXrIW5
         Ybshb8a27GevVKNBqwF8JyOi4N4cK0m9tHvpUbN1fJ0I31n5C0EtreSD8AhegkjTJ71l
         R4Y/eXfohzGpV5A3G5JZfrhjWygZ0++97u7Ega8sQbUF+S0Oc5+Djv56hCj9U17f48YK
         HYkIzpc9LmxpMMoiGXeAIfv8pCwkSi6WtKLtTuvnSljUdQMpTbWFYGi1CRsHHHRYT6M1
         wtY59f1jWdeO5UHEElDwO6p6xnwVXB8EhHYbJLI8GhaQKRN2FMFFtQBY72mcauEOk2Gq
         9SBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lFI1nwjuQZ6G3s+nLhl24sQCFqL8NbzRi33/2wp2IFE=;
        b=WneCRElgm3986icyxo/BEGvveNvFPw+60xtYVarjTI762liIcnkSM0BU3b0Sr5VJsr
         q9kM8JK5DmDrY0l1C2TnPmq0zEr9VSxQlVo0rMHpLHJsztHRJaA/IUmuN2V/kBW7eU1A
         wGeX8wwajECQ/bRQV8oFo4MRcanw6yc/tz1SiBwaBtctaDcGs204HRXHNQXBEbezBS/A
         dh3p/68o3dGgoVc8TStWVA6p7h/t9Ma99AIdfO0fI15y5wn6c2KGmBObWNgRVFDD/ZFk
         QSxkXexh//e3Z9R7RKowQsrsFBGIn8RNJdL1slEid2RUZOhe+Wetg1kKKIVgAqiaqI6Z
         zwvw==
X-Gm-Message-State: AJIora9Yx1UivrymJ9t0YFR7vHNtoOLk+v0Fr45MABTwUzmQw1kt4qD8
        Rwpyy2iG/gTyP5uK79ls3nns
X-Google-Smtp-Source: AGRyM1swN4/NYESRXPycXZfuaUSLHdL5W10n5MZ6t985DQdQhSo25aFjwTiyP96RCdDjLKLbIE3+4A==
X-Received: by 2002:ac8:594a:0:b0:31d:2871:55e9 with SMTP id 10-20020ac8594a000000b0031d287155e9mr1013442qtz.149.1656507828369;
        Wed, 29 Jun 2022 06:03:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d803:95aa:58b0:8205? ([2600:1700:e72:80a0:d803:95aa:58b0:8205])
        by smtp.gmail.com with ESMTPSA id y9-20020a05620a25c900b006a370031c3esm13472418qko.106.2022.06.29.06.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 06:03:48 -0700 (PDT)
Message-ID: <8e55693e-dedf-fb42-d31a-33ebbdd6abd6@github.com>
Date:   Wed, 29 Jun 2022 09:03:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v3 6/8] rebase: add --update-refs option
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <918b398d6a2264a99acadd319f780c796bbafc18.1656422759.git.gitgitgadget@gmail.com>
 <xmqqbkucijg3.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqbkucijg3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/22 5:09 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
...
>> This change update the documentation and builtin to accept the
>> --update-refs option as well as updating the todo file with the
>> 'update-ref' commands. Tests are added to ensure that these todo
>> commands are added in the correct locations.
> 
> OK, so command line option is `--update-refs` because the range
> being rebased could contain more than one branch tips, and the
> option causes one `update-ref` insn per such ref left in the todo
> list?  I had to read the above twice to remind me what was going on.
> 
> The design looks OK here but has "rebase-merge/update-refs" already
> came into the picture, or will it be in future steps?  I lost track.

Sorry, we have the ability to read the file (and tests that read an
artificial version of the file for the branch_checked_out() logic) but
have not written it from within Git yet.

I can make it clearer what is _not_ in this patch and coming in a
future change.

Thanks,
-Stolee
