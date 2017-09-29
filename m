Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3485120A2A
	for <e@80x24.org>; Fri, 29 Sep 2017 17:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbdI2R1g (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 13:27:36 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:57193 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752006AbdI2R1g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 13:27:36 -0400
Received: by mail-qk0-f172.google.com with SMTP id g128so293809qke.13
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 10:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vJ0PHSRCN5Ms2vPj00PJEUob/CnW14DXsa2xBdPXTJo=;
        b=BHraMi7eWFj+ggGdRXKVfhstkfkHl+k6RUeGUGiY7JblHUFhH3eUe0BJELWK7bVcXH
         Z65WxUbPup01ypbEnooq6trwgl0uHA8aIa+kNBSgVH9oFh6v6iCMrbKZkqxtAACiL7o8
         4M7iuahzQ5vVfLQeohgZni08ApZ9qOyGZDDmo3XhudfOnlcqCamlnqhLPv9HFJG5fXQN
         IOZXBQFlRjtGAD2XAEVcx0MboEylhqf1576CoXhbRsP1/mj0y6MlkbIJTaAE6ujaDSRH
         7CYPN8xVJZd+AiLvtiAaZUHNgPRhcDXf3iwf07ZEfimqrKQEctXRFB4zchJd8+STWuIO
         R8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vJ0PHSRCN5Ms2vPj00PJEUob/CnW14DXsa2xBdPXTJo=;
        b=lJ9IKl+FIyz4wjgVQsqhPsYV/N7R+6K/EX/DwJkCO9mRdrxzdmzvoObILu+Z3NTgag
         JRA4xBdYfSWBn2+pGXiaADrZpJ8VpzCZZpfESD36F4L6PZqm4k4TwBS0+YF3LtFA7RCa
         BMHJlA34gN66hFvdn6vHmY/ZRRH/Wmra+4Mo8mP/KpwAnS2LIpu0ozkfXYg468fT8yPS
         TL6egNweaIuZx9piWuUcazdk4vjPTMfdYuTFIrJWC9y+vhsF3eFU1sIxLovNH9xaH4f/
         1KeAjrWPPsRJBOcmzlAu+H1bCdpsqavW1y8dUbTkqqbkbH4Ex5iCfD4g7h1KQryQ2bJz
         SBnw==
X-Gm-Message-State: AMCzsaVaPjqGNGpYYMbOGrtNWiASTDPG13GnPPWHzeze08qe8ILsibIY
        8WeOFiC6aJ8tRim7gqhXwqBkJVBYzmSJhUuN8FBr0w==
X-Google-Smtp-Source: AOwi7QA89Rz8sTSFhnoDTSQdHaJ4o2Gq83KtRC6zrThcmvq0oqteq2Ljlg0ETgfuoUMrZdRKjN6Ngndu4OXpdFSA34g=
X-Received: by 10.55.52.135 with SMTP id b129mr4403768qka.308.1506706055154;
 Fri, 29 Sep 2017 10:27:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Fri, 29 Sep 2017 10:27:33 -0700 (PDT)
In-Reply-To: <5f7dbd81-ae27-c3a2-a14d-2832f71db1e9@gmail.com>
References: <xmqqlgkyxgvq.fsf@gitster.mtv.corp.google.com> <5f7dbd81-ae27-c3a2-a14d-2832f71db1e9@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 29 Sep 2017 10:27:33 -0700
Message-ID: <CAGZ79kbh1kELT5nOJHAg8yZ-zp7vcxnxAGzXZ1nSPSX0qJoOrA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2017, #06; Fri, 29)
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 29, 2017 at 6:08 AM, Derrick Stolee <stolee@gmail.com> wrote:
> Hi Junio,
>
> On 9/29/2017 12:34 AM, Junio C Hamano wrote:
>>
>> * ds/find-unique-abbrev-optim (2017-09-19) 4 commits
>>   - SQUASH???
>>   - sha1_name: parse less while finding common prefix
>>   - sha1_name: unroll len loop in find_unique_abbrev_r()
>>   - sha1_name: create perf test for find_unique_abbrev()
>
>
> I'll re-roll my patch on Monday if reviews have stabilized. I think I
> understand your comments this time (especially around 32-bit ints).
> Since I'm new to the list, I'm not sure what the change in messages
> means here.
>
> What does "SQUASH???" mean? Is that why there are three meaningful commits
> in this note, despite my five-commit patch? Would you like me to squash the
> commits in v3?

If you fetch from github/gitster/git, there is a branch
'ds/find-unique-abbrev-optim'
containing four commits; three by you, one by Junio. This one commit
is titled 'SQUASH???' as Junio did not want to write out what the
commit is doing
(e.g. fixing a typo, a memleak, or indentation or other small detail
that he observed)

You want to take the content of the commit and add it to one of yours,
where appropriate.

>
> Thanks,
> -Stolee
