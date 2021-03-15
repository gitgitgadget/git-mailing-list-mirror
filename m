Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E24C433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 16:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 811A364F18
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 16:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhCOQVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 12:21:23 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:31672 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231626AbhCOQU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 12:20:58 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 682E7103E;
        Mon, 15 Mar 2021 17:20:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1615825255; x=1617639656; bh=f/vjXDKYBK8NAVz5rSe
        SOFvHfRDTw6NCk2M7aUOloUM=; b=xVxhabs+0cEy/VoUG4PuCfXs30+ivqux4x3
        gGrd3usXyyVS6iIyMDEUoREDjLE3Ed0suqedkW/YWazDG6QvIbRDdm9k7kBDqa3D
        KCg4Ef9FLNXhmBoYcQBnPoYvHY+tPWcdB1NVvSs/Ky34qwjI/PmDbY6V+cV1D4bA
        pfqB+96bIIZvywgkb7kzb4ITFG7q/uKJRWbFEZOGxwuokyqFL2DY0E4FWBRXwj0/
        9SlcmEKPu+7FJFF44C9N8P2TYw7knBK/0teYVP6OjjnrD+Q7Zcr5EsoogsQesG8l
        /o+o9mw1SxzwRGMaRA53Ds2j4Ni+qSxcQBuGv2Fb9roaFlt2dU/PUDR0VRLrr4F9
        /1/oMxKVHdQaa8nmGClaIFpLAugAhCtnJXUYplhYOx3UjicEzPTK01qct7UYy99N
        HsUKeDvmS6vl6vuI7IP6j6Du3A1F2Tw197BobGMDU5SLZZKZjyDZJy7Q6sRczcdH
        cBYtNi4TBmrpRST+HrL9amf1fHxbD4celJ43XvtBtaKms30TeTB9IDSLiKBknTCF
        TM0IYwk1kp4Pg/hQqDjQIvE9STFkq6s1HHsqPJUFeDkR5BiWij1kYZIG4wxnbjMl
        UBEK8CAmVXf0KhCNo4BPWPWPAPrO0xasIHN3nQ8vVX5XBjAv+VrGLhbMYVhOYUPn
        FrcF8E30=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Wy-9SlX7Kafx; Mon, 15 Mar 2021 17:20:55 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id E512BDF1;
        Mon, 15 Mar 2021 17:20:54 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id A027E2459;
        Mon, 15 Mar 2021 17:20:52 +0100 (CET)
Subject: Re: [PATCH v2 8/9] parse-options: don't leak alias help messages
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Andrzej Hunt <ajrhunt@google.com>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
 <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
 <4397c1fd80205d142fbd184c6d13fd07c4dbfa21.1615747662.git.gitgitgadget@gmail.com>
 <CAPig+cQe8hgz-3D6oN-YoG2KB8F=R0q-eJTdCjOFZo74XnsiOQ@mail.gmail.com>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <b7a5824c-d597-dc55-2001-b7487ad2c4bf@ahunt.org>
Date:   Mon, 15 Mar 2021 17:20:50 +0100
MIME-Version: 1.0
In-Reply-To: <CAPig+cQe8hgz-3D6oN-YoG2KB8F=R0q-eJTdCjOFZo74XnsiOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 14/03/2021 20:48, Eric Sunshine wrote:
> On Sun, Mar 14, 2021 at 2:49 PM Andrzej Hunt via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> preprocess_options() allocates new strings for help messages for
>> OPTION_ALIAS. Therefore we also need to clean those help messages up
>> when freeing the returned options.
>> [...]
>> Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
>>
>> fold
>> ---
> 
> Unwanted "fold".
> 

Thank you for catching this - I'll remove it!
