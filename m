Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01527208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 15:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387750AbeHGSLP (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 14:11:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44264 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeHGSLP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 14:11:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so16232361wrt.11
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 08:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BxTbKjAO/W/YhygggMqsVr1MX66XEN0XGkSvwYwzKAc=;
        b=Qgkyc8NX2QWY2hfESQCxGyZjxgo/myVPukTCZsI7PLJPJD7cGvIMz8Jzn4oZhTnHob
         8t2Cnm3Sruwez+S5yGbVp8R4SVbltS6sl7haU8B9wfq/D64NMTSV7BjLfv+Bi14nTZ4a
         D3fm9Nmp9tU+yxmBxOXuJswANXQEIR26UXQ6UJXrVv3ovYNuNNwhwsYiE3wsqeNSC6jP
         ozxjhOYug18s4okhE5lrxlGAPjevpZ6J6gWA0A3wmCAJotWHc0u2a1DcqO/HlrXHo46w
         ZxbF+oSgUrnWKIKdELZvAk6eisoLPzS5I3/5I4tpLzsBTJHoTsxeJekw6VgMUD1dQbNy
         6IFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BxTbKjAO/W/YhygggMqsVr1MX66XEN0XGkSvwYwzKAc=;
        b=SiQd6YL3eVYOtrQX/DBxLUEJ6YKjU/HxfQOf+aBlTKTriVKoDjDuI7IyrQaz3KRl9x
         VUS4J8HBngijd9KsyTic0Qo4IWp4c1yEXegOlWrsZ5NjqQ9M1zivuJ34r7TXKyjywcFB
         tn2rPDpF1Te+MiNWPiM+S4TG1pREmZmpGvRqrIq3SW56YnIt+cwe0S2l+1nt+4BwVR2S
         vDDOdvfM6+JzmDLVj67F/SjMfNncW9fnuRu23e1YSaHLSrk1Pd41qwTcHs+QVqSKv6R6
         6/lRm8h6+Gm1yEc33OVl1NLQ3LWmPeo+dtnx0QQ9kgC1RMLRUgtTBsef+CRRHaQDE/+5
         gt8A==
X-Gm-Message-State: AOUpUlH/CkX4+N78hcHsvUY5dTaFDfMCXaG12d0hZ2EUAyOSDDQBqxAc
        8miiA4xSUf0KK3mpW+3FpYzEArM3
X-Google-Smtp-Source: AAOMgpcfjBLwQeo247pxjwjDUmHsfLlr79/NttnuZHq70zQ9uozpQhiHySfuw3PRTEJ9cpGllwa9mQ==
X-Received: by 2002:adf:9a55:: with SMTP id z79-v6mr12040782wrb.153.1533657377404;
        Tue, 07 Aug 2018 08:56:17 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q16-v6sm1910202wmq.25.2018.08.07.08.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 08:56:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] Documentation/diff-options: explain different diff algorithms
References: <20180724044051.GA208393@aiede.svl.corp.google.com>
        <20180806222551.132628-1-sbeller@google.com>
        <20180806231843.GA4117@aiede.svl.corp.google.com>
Date:   Tue, 07 Aug 2018 08:56:16 -0700
In-Reply-To: <20180806231843.GA4117@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Mon, 6 Aug 2018 16:18:43 -0700")
Message-ID: <xmqq600mmaqn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Both don't seem quite right, since they have an extra space before the
> period.  The git-diff(1) seems especially not quite right --- does it
> intend to say something like "See the DIFF ALGORITHMS section for more
> discussion"?

Good suggestion and doing so would nicely allow side-stepping the
space before the dot issue, i.e. "See the DIFF ALGO section (in
git-diff(1)) for more discussion".   I like it.

> [...]
>> --- a/Documentation/git-diff.txt
>> +++ b/Documentation/git-diff.txt
>> @@ -119,6 +119,40 @@ include::diff-options.txt[]
>>  
>>  include::diff-format.txt[]
>>  
>> +DIFF ALGORITHMS
>> +---------------
>
> Please add some introductory words about what the headings refer to.
>
>> +`Myers`
>> +
>> +A diff as produced by the basic greedy algorithm described in
>> +link:http://www.xmailserver.org/diff2.pdf[An O(ND) Difference Algorithm and its Variations].
>> +...
>> +
>> +`Patience`
>> +
>> +This algorithm by Bram Cohen matches the longest common subsequence
>> +...
> [...]
>> +`Histogram`
>> +
>> +This algorithm finds the longest common substring and recursively
>> +diffs the content before and after the longest common substring.

As a first-time reader, I felt that it is a bit uneven that there is
no attribution for only this item, unlike the description for Myers
and Patience.
