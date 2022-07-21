Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95AEC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 12:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiGUMNI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 08:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbiGUMND (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 08:13:03 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9EE863D4
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 05:13:00 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id h22so1076962qta.3
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 05:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jom5B3gExGF3rI0GsPRKbWO5U3R0kKoxfnsEAesLnA8=;
        b=BdDtVItqBx2tvTF6DXe9cXG/YdUXper9+kKBOUmBYMbodnHhg1Kj71/QkkDs6Vlw9a
         ulDesMaREDRsL5Zs4S+RlhsnZyKedfvpTrHJJ21l+OXUIBcAb3PnEcdWgaon+YIIrNpL
         OB51XWR6qQASSDR59uxnn1BAMKStvS/2W94Dd35WfL8y0Km18eV1y96Sov7gdBaUqu3G
         aQr7motO1ROdbMjX6c2akQMYRG5+nwFxT4YWtDryXuN7irXd00xhF/miOT3ZHrWkblUx
         5r4Q2RbZPNrLtTf3tmD6k6IrnMv85OdFk5gm1ofxFz6n/nPg9pPfOQ9rJ5l8GJxJ/32v
         vTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jom5B3gExGF3rI0GsPRKbWO5U3R0kKoxfnsEAesLnA8=;
        b=O5OSuYbn/P9XFJ0UHzedysSV3Kvo2j3X9Omv5Cmi3gfPhMUTSWF5cKsPXWnYvFMjbr
         DSwHkLCJvKn/T1xmuObGCekLX+VoUZQxGaPavNYPDex8ZPPaUDw39PMtbFPjoAu0s9PX
         ZdRGeSsaXpa91a19zhBiIqOGIQh4SEJPNWo3yW+wZlmRBAC9THyVMGfQ1vD0DILmXH+s
         j1W+CvGo5OXen5IfIzXe8oZklFNj+Ajh9ANpfKNbyo7qymZvA5PxQUlxQmETBHibpXen
         UEOxjbvecfJnsfeKtljZI6+PuvbLqiq7nacoUgg2IgigHGjXxkco9aRIC+bjETjzLvoN
         ct+A==
X-Gm-Message-State: AJIora+BRRtLUyqQqzXpsSHi+ZeVpHK2zwL7q4Nr6NEcgjEU78JkFUIP
        QPNNKpBUT9h5b4sI61yyO01P
X-Google-Smtp-Source: AGRyM1vhh+X3G6csVYn5Mbg2xfIUaIq0lC2Vk6qmq5ay2mgQ+vfQZXdacl/D0HuaOUA3SuLycnq35A==
X-Received: by 2002:a05:622a:204:b0:31f:3bb:3294 with SMTP id b4-20020a05622a020400b0031f03bb3294mr8727247qtx.436.1658405580036;
        Thu, 21 Jul 2022 05:13:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8099:5229:7961:505e? ([2600:1700:e72:80a0:8099:5229:7961:505e])
        by smtp.gmail.com with ESMTPSA id w12-20020a05620a444c00b006a981a2c483sm1438118qkp.39.2022.07.21.05.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 05:12:59 -0700 (PDT)
Message-ID: <f0f94d74-b49b-e26a-d38c-77687bbbb153@github.com>
Date:   Thu, 21 Jul 2022 08:12:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 00/12] rebase: update branches in multi-part topic
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
 <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
 <CABPp-BGKzcVatwoLhzXiJ3jkKXgWne+=5xNj+VmNO=pL5Kr1Og@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BGKzcVatwoLhzXiJ3jkKXgWne+=5xNj+VmNO=pL5Kr1Og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/21/2022 12:35 AM, Elijah Newren wrote:
> On Tue, Jul 19, 2022 at 11:33 AM Derrick Stolee via GitGitGadget

>> During review, we have identified some areas that would be good for
>> #leftoverbits:
>>
>>  * Warn the user when they add an 'update-ref ' command but is checked out
>>    in another worktree.
>>  * The checks in patch 9 are quadratic. They could be sped up using
>>    hashtables.
>>  * Consider whether we should include an 'update-ref ' command for the HEAD
>>    ref, so that all refs are updated in the same way. This might help
>>    confused users.
> 
> Not necessarily so they are updated in the same way; the behind the
> scenes mechanism could perhaps still be different.  Just so that if
> the user looks for the "list of things being updated" they don't get
> surprised that HEAD is missing.

Noted.
 
>>  * The error message for failed ref updates could include information on the
>>    commit IDs that would have been used. This can help the user fix the
>>    situation by updating the refs manually.
>>  * Modify the --update-refs option from a boolean to an
>>    optionally-string-parameter that specifies refspecs for the 'update-ref'
>>    commands.
> 
> refspecs?  Is that the term you really mean here?

Probably "ref namespaces" or "ref prefixes" would be better.

>> Updates in v5
>> =============
>>
>>  * Rename 'wt_dir' to 'wt_git_dir' for clarity.
>>  * The documented behavior around 'fixup!' and 'squash!' commits was
>>    incorrect, so update the commit message, documentation, and test to
>>    demonstrate the actual behavior.
>>  * Use CALLOC_ARRAY() to be more idiomatic.
>>  * Be much more careful about propagating errors.
>>  * Commit message typo: "We an" to "We can"
>>  * Remove unnecessary null OID check when writing refs, since those would
>>    already be removed by a previous step.
> 
> Thanks, I've read over the range-diff and these changes look good to
> me.  One thing I'm curious about (sorry to bring this up so late):
> "pick" commands come with the old commit hash.  Perhaps the update-ref
> commands should too?  (e.g. "update-ref refs/heads/topic from
> <OLDHASH>")

I don't personally see the value here other than to make it harder
for someone to add new commands (and confusing when wanting to
create a brand new ref). We could consider adding a comment in the
future without any backwards compatibility issues:

	update-ref refs/heads/my-ref # was 0123dead

Thanks,
-Stolee
