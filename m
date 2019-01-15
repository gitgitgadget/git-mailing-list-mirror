Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70D7B1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 15:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfAOPG4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 10:06:56 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33624 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfAOPG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 10:06:56 -0500
Received: by mail-qt1-f196.google.com with SMTP id l11so3323961qtp.0
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 07:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1TOgT8WNSEbRsehZ5a6zZgBXLOh4BZTGipxumg7BtmI=;
        b=aDGs1C5alcve/oc620ovKIsJnlIIYoiclK9u1/HWSfVYL7sEGehIRArYLkMboUfm0+
         6QPbNZD0v0eGpGFMUNgcIWwom5dGPJjUNXeKYSBtbNQ6zJcGKvAGmh5e0mfl8b/DLlc1
         304DGpim5tb2y1Gds7OhyQRQgpwJX2egA96ogGYmSLwxcscO+pWWhQNK6YWC9zwDJn2Y
         2ss//u5/c8YrPmfeqhua2gli+3n62T/FSLR7sd3a2/s8pTif5XpOedsRKV9vkpjnI1CB
         h6/2UBMNipAqDDdk/PgHsQXLoLgG+4GQwUIa4Xrx9W9RUsEuzWXw48BZKhPzl8BRueZr
         36cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1TOgT8WNSEbRsehZ5a6zZgBXLOh4BZTGipxumg7BtmI=;
        b=Cz/zXALbVZXCnKxBofvpE2MeAfjV1ZR5t4o/kRjCSM9nBryzeVx0pNViS7msUWwL3D
         itD9kETFYBtrCibZzAfwBPvGO+MRZVDumPTqBhswiRxxweRsjJ+WSADcrEvCP8SgS+5I
         DWhKIO6LFezzG5vNvPDGPvPrg6jF3TvGQqvwCKtacAstKaYZzPkVVQM8t7iVQrn2XJxe
         ZB5oNjHBmkjx3rUmPy2vndw6k2thzNcDaeayTs2var50pFJ8REvcBA6H5IfuQtUtyxDp
         mAUTrFzxdPeu9uzz+TdsFzwsq5XD6j8201yFkYy/z7N7Vh4mmTUo1nhZEjvBRNv8JxSq
         GLgA==
X-Gm-Message-State: AJcUukdTal/zxQQXYrNuq27GTejI9sfGgolXlBST3z6xOzsZRNFMtiWz
        iu0ZBdYGUBKqFfa3WrQVcoE=
X-Google-Smtp-Source: ALg8bN7WSTEBSavf3Vm8eoC9KBdCRrQEkrDaePU7IYFxX0I+NE6Nd7nYS1dnnAehp0wQfS8h1IKH5w==
X-Received: by 2002:a0c:9489:: with SMTP id j9mr3299051qvj.116.1547564814562;
        Tue, 15 Jan 2019 07:06:54 -0800 (PST)
Received: from [10.0.1.15] ([98.122.160.2])
        by smtp.gmail.com with ESMTPSA id l73sm59842719qkl.16.2019.01.15.07.06.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 07:06:54 -0800 (PST)
Subject: Re: [PATCH v4 3/6] pack-objects: add --sparse option
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.89.v3.git.gitgitgadget@gmail.com>
 <pull.89.v4.git.gitgitgadget@gmail.com>
 <ab733daff5398fd07ff051c323f51b70efbc2e57.1544822533.git.gitgitgadget@gmail.com>
 <xmqqmuo6yghg.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8c50e066-b132-cf6e-ed0f-ce843cf3a634@gmail.com>
Date:   Tue, 15 Jan 2019 10:06:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <xmqqmuo6yghg.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/11/2019 5:30 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Add a '--sparse' option flag to the pack-objects builtin. This
>> allows the user to specify that they want to use the new logic
>> for walking trees. This logic currently does not differ from the
>> existing output, but will in a later change.
>>
>> Create a new test script, t5322-pack-objects-sparse.sh, to ensure
>> the object list that is selected matches what we expect. When we
>> update the logic to walk in a sparse fashion, the final test will
>> be updated to show the extra objects that are added.
> Somehow checking the "these are exactly what we expect" feels
> brittle.  In a history with three relevant commits A---B---C,
> packing B..C could omit trees and blobs in C that appear in A but
> not in B, but traditionally, because we stop traversal at B and do
> not even look at A, we do not notice that such objects that need to
> complete C's tree are already available in a repository that has B.
> The approach of test in this patch feels similar to saying "we must
> send these duplicates because we must stay dumb", even though with a
> perfect knowledge about the history, e.g. bitmap, we would be able
> to omit these objects in A that appear in C but not in B.
My intention with this test was to show that the existing algorithm also 
sends "extra" objects in certain situations, which is later contrasted 
by a test where the new algorithm sends objects the old algorithm did not.

Instead of "we must stay dumb" I wanted to say "we are not dumber (in 
this case)".

I understand your brittle feeling. If the logic changed in either to be 
smarter, then we would need to change the test. In some sense, that does 
mean we have extra coverage of "this is how it works now" so we would 
understand the behavior change of that hypothetical future change.

> I think we want to test test both "are we sending enough, even
> though we might be wasting some bandwidth by not noticing the other
> side already have some?" and "are we still avoiding from becoming
> overly stupid, even though we may be cheating to save traversal cost
> and risking to redundantly send some objects?"
>
> IOW, a set of tests to make sure that truly new objects are all sent
> by seeing what is sent is a strict superset of what we expect.  And
> another set of tests to make sure that objects that are so obviously
> (this criterion may be highly subjective) be present in the
> receiving repository (e.g. the tree object of commit B and what it
> contains when seinding B..C) are never sent, even when using an
> algorithm that are tuned for traversal cost over bandwidth
> consumption.

To properly test "these objects are included," do we have an established 
pattern for saying "this file is a subset of that file"? Or, should I 
use something like `comm expected actual >common && test_cmp expected 
common`?

> The code change in this step looks all trivially good, and it may
> want to be squashed into the previous step to become a single patch.
> Otherwise, [2/6] would be adding a dead code that nobody exercises
> until this step.

Will squash.

Thanks,
-Stolee
