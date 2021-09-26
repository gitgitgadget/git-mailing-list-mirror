Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB3BC433F5
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 16:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C716D61041
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 16:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhIZQBt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 12:01:49 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:26306 "EHLO
        ext-mx-out003.mykolab.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231178AbhIZQBs (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Sep 2021 12:01:48 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 8C66840B2A;
        Sun, 26 Sep 2021 18:00:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1632672010; x=1634486411; bh=8NqOqNaa+0+RPNnzC4J
        iM7gqui4yXyZJepGMOeDSYBk=; b=iHD5dbJF4D5AQIjKOwE8eZsenSCTUH68+gL
        tni0SlIu+yt2gc7F7dKo2nQUF/SvkbXhvB2HY2dtiV7OpGezyg9BwGMr8C77p04+
        8sKNYvRkP8ngnHjOUkdmjhWAdSLnz6FhNDLXNmRbma3K2p/8bSRq7sjDOjTICMVo
        9Z8rUCG0xtksPUsWLwtOT5z+wQyMKKJ4ii8j9RAdVFVMZJQSpivNcflOpq7a/Pmx
        1HDKBgwxKPCgrUunHimzs2A6N1ECyji2B+Ue/P93UnhTBxto4u3QY5q2gii0z/f6
        82pei7A1h+rRFppF1isOESHigFTjwVuaPG4R15oLUsa0X3kjYiilCAr+EBJ7YhwX
        JuU7QyZuJzz8m6Kbgmm+CUp3WjsF7BG+y4bZJLx5qAMXtL9xRjUkZiDecP0Gph93
        PamPdcPbF2dWRpu8FUgDk5K5QQGegigb5Hp5OBvdt+RHWtQ+EGphbiNdQEu+qdKp
        D756hqly1jznzUIK3pilNiajgTiSEf9VjHBDGTKHIh/eIsFO4AohxkBNXh9MXlvK
        gtzJDY10vqHQeZp6rA0qkz8aGsAUz3uJNPItuFZNxVo3HH1B3EWtauazJuVZd5+v
        PLDiwJOMzQTi2vcfJKeci6aBCufgKEFq7a5dsKwR78eD+iAQX0QH9MkIxAn/VBSI
        H4aqfC5I=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from ext-mx-out003.mykolab.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o8VoyWk74pKI; Sun, 26 Sep 2021 18:00:10 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 0E7CC4047F;
        Sun, 26 Sep 2021 18:00:10 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 5EE5F50B;
        Sun, 26 Sep 2021 18:00:09 +0200 (CEST)
Subject: Re: What's cooking in git.git (Sep 2021, #07; Thu, 23)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqa6k2yj1j.fsf@gitster.g>
From:   Andrzej Hunt <andrzej@ahunt.org>
Cc:     Jeff King <peff@peff.net>
Message-ID: <95edb81b-f440-50eb-77e6-282de1a452d6@ahunt.org>
Date:   Sun, 26 Sep 2021 18:00:06 +0200
MIME-Version: 1.0
In-Reply-To: <xmqqa6k2yj1j.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/09/2021 01:22, Junio C Hamano wrote:
> * ah/connect-parse-feature-v0-fix (2021-09-23) 1 commit
>   - connect: also update offset for features without values
> 
>   Protocol v0 clients can get stuck parsing a malformed feature line.
> 
>   Will merge to 'next'.
> 

I hope it's not too late - I ended up sending out a V2 at:
https://public-inbox.org/git/e1395ff2-e697-83b2-082b-d5468b7a11ac@ahunt.org/T/#md3a45bb0fdf9cfd49e0fabdb1b21cd045df523c5

The differences are:
- Peff's test (and most importantly: test stability) improvements - 
which you might already have incorporated - from 
https://public-inbox.org/git/e1395ff2-e697-83b2-082b-d5468b7a11ac@ahunt.org/T/#m5cac36b2e4aa03d452a391a3c9d2495c3a423810
- An attempt at improving the commit message, which isn't crucial.

ATB,

     Andrzej

