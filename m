Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98A831F424
	for <e@80x24.org>; Thu, 10 May 2018 04:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753517AbeEJEZ0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 00:25:26 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41945 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbeEJEZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 00:25:25 -0400
Received: by mail-wr0-f194.google.com with SMTP id g21-v6so597358wrb.8
        for <git@vger.kernel.org>; Wed, 09 May 2018 21:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Q7LW/NYkuLkiN/HpIqpE9q9+rOUzCODTKU7+oSKbTok=;
        b=dvI8nyNimLZY1icLWFBkw/jltObhjpo0zbH/lpsu+sy1odtcsQsHLXCeKpwR4Evcys
         09XhEXh810BTKiajyOJlzJrIDcwCQx8+zKHRnNO3JgxAzdwdKR+e7/txkkGMpmBawxGS
         zil9LM+Dkm138j2u/J/Uk8t13RV1qRzvPaI/BL8qb6WN3ojS8kdIpgRdc5gE6RzBox+O
         R1Q/JBgB9LVNOhH0z3r02Xl6fGKXvQW31Hq6J+XiT5gnQ3BPxKsuptQI33Lp5OQOFZov
         rFl1rSjhwr8RrBZ9k6qkFkj2IH2A3w1iFrCbOYVaaleMK3AqcieCTI+mwG1LXv3/TUXm
         sssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Q7LW/NYkuLkiN/HpIqpE9q9+rOUzCODTKU7+oSKbTok=;
        b=kGa4xfRMked1y7T2L/+6x9qsbantOTLqBZJ1CTRbfUjER8HFluQ/g7I5vxOPLz94q6
         jwdG+ix2qnv+gz28pRYppkDx+v/Z47sYNMXrCcPj7EZfZ2SiDwI0OyU4EUsak343MmOG
         pDCgJDFobrrVkV9ve6cLzKitzqRgtObZAS9SPZKaF+/gY/Q2K4idMCfR+hR9XbSFybEj
         jbGmS4UIdQg/mr6ZeyY6FY7no/QYnPvbHogNmvAZZrmGtGsSjOCkKtl8oXhlYDKhtVVT
         yi3yUFdFEiKvWZ8njai9Kvdj+rSoUSV61TmDTGre2lNR6UCte4KDpUv9dis39z3nUqDh
         mreQ==
X-Gm-Message-State: ALQs6tAn3cFkwsHkewHh6+evxfNbH6+WuV1mMeM6rGqB9D70bFDb1EX4
        WglpwzWVD84M34lNPej0/IM=
X-Google-Smtp-Source: AB8JxZo1z9XFIrcUzjYx6j7RiZcKo6/5+aZKxVrdAEuogAgvBj/oi5xgcHY0LzteFC8W4GFDchyL0A==
X-Received: by 2002:adf:968b:: with SMTP id u11-v6mr39673351wrb.184.1525926324326;
        Wed, 09 May 2018 21:25:24 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 75-v6sm116096wmw.37.2018.05.09.21.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 21:25:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2018, #01; Mon, 7)
References: <xmqqa7tbpl5q.fsf@gitster-ct.c.googlers.com>
        <b58358de-3590-64b2-1db8-9cee9de92ed3@gmail.com>
Date:   Thu, 10 May 2018 13:25:23 +0900
In-Reply-To: <b58358de-3590-64b2-1db8-9cee9de92ed3@gmail.com> (Ben Peart's
        message of "Tue, 8 May 2018 13:05:32 -0400")
Message-ID: <xmqq603wkuh8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> On 5/7/2018 10:58 AM, Junio C Hamano wrote:
>
>> * bp/merge-rename-config (2018-05-04) 3 commits
>>   - merge: pass aggressive when rename detection is turned off
>>   - merge: add merge.renames config setting
>>   - merge: update documentation for {merge,diff}.renameLimit
>>   (this branch uses en/rename-directory-detection-reboot.)
>>
>
> It isn't specifically called out here but is it safe to assume this is
> also headed to next behind en/rename-directory-detection-reboot?

Not really.  A blank "what Junio will do to this topic?" verdict in
any of these topic descriptions simply means I haven't made up my
mind (spanning from "I merely queued it without reading it fully,
only so that I won't lose it" to "I think it is OK but I haven't
understood the implications of the change to the entire system").

