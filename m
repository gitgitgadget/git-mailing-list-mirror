Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3E221F404
	for <e@80x24.org>; Tue, 11 Sep 2018 11:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbeIKQSq (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 12:18:46 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:34414 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeIKQSq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 12:18:46 -0400
Received: by mail-qt0-f182.google.com with SMTP id m13-v6so27818071qth.1
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 04:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UuRMaaccof878m40ABJrbmsExyeInGce6e2VDoNiB/s=;
        b=a0kW02tKinsj0UA/9u+o/W/oei4n20KBj8NsoLhdgY01y3e/NwRePA2LJXDX2d4nzD
         et8Z0U//Oz/UX+OHv0iJsziU+hJ6yo/7CTer76AS+sadYlTVlnQVl4j2Uh7sA16RdD7t
         6b7GT7+kOSSej4rq+67gMx33WnztJwYCikuPBLs1Dv0ox9DhIKhxr5il1uC84CBPLHXQ
         as4b0BFhfsNZEig0u53XjRBgRfVzh9SSWFCKJuTPn7p3PBYCR7UHFZZrX0t4oEKSgkOC
         LqjDjFzCkQIty1UVWh9baLPWtniuPc6udHfxrJ1xmGQqfjx2t3EoURBDVqay0Wfcb3th
         ueLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UuRMaaccof878m40ABJrbmsExyeInGce6e2VDoNiB/s=;
        b=D+g0MnhyPQpev3VE20uuzWxuuzF2/I14fWrxq3zSFsNXaA/7O3y7p5LfKgmX90zKTW
         B93FBJ0Zdp2AXQhY56ejtU2WdXHh7DkNRjACQzObyds7CeoFfrBN0ahMPReiIlIoIu3p
         lRMrsB0z5DtQcymrn2vH8j0IbxnqKeoJnDOZnmGjegOmmkEhCwd3tcv9qcY/h4B5e+vG
         DYesLT/XJLwlqirFJJLobMtvY0BoxBGle7QabwlW+JxLepZWrAYp7es9IH3Y40RD+zC3
         2DtApSk+DJEjE46yEBlRIfRk/iEac9PiSUZ44rEMLYEqmS5Affs45GArTGV82q+QwTRC
         S2+w==
X-Gm-Message-State: APzg51B5LdlD9ukIYdgtzrq1buyAx3YXo2lStSImFwI34gzqVa7fgHEM
        T2NPHHud1dyBAKeSYmQ1f8g=
X-Google-Smtp-Source: ANB0VdbQFjm7bH9/rDDcBueaW9EQmGtRs6t/R6wYILFuQYAyEriZ26eKDRUZP7zUfqtKTrf8delzhw==
X-Received: by 2002:a0c:d0e3:: with SMTP id b32-v6mr17549233qvh.236.1536664792847;
        Tue, 11 Sep 2018 04:19:52 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id g14-v6sm12778815qtc.66.2018.09.11.04.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 04:19:51 -0700 (PDT)
Subject: Re: [PATCH v7 20/22] commit-graph: add '--reachable' option
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jakub Narebski <jnareb@gmail.com>, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
 <20180627132447.142473-21-dstolee@microsoft.com>
 <CAP8UFD3kzZo8qQqj=8T-TXbvb9b-KD=Ok7TgdV--Cb8MT4NCiA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <69879118-2753-971e-9818-3ebd4a927ffc@gmail.com>
Date:   Tue, 11 Sep 2018 07:19:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD3kzZo8qQqj=8T-TXbvb9b-KD=Ok7TgdV--Cb8MT4NCiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/11/2018 1:22 AM, Christian Couder wrote:
> On Wed, Jun 27, 2018 at 3:24 PM, Derrick Stolee <stolee@gmail.com> wrote:
>> When writing commit-graph files, it can be convenient to ask for all
>> reachable commits (starting at the ref set) in the resulting file. This
>> is particularly helpful when writing to stdin is complicated, such as a
>> future integration with 'git gc'.
> It would be nice if the "Future Work" section of
> Documentation/technical/commit-graph.txt had something about
> integration with 'git gc'.

Hi Christian,

I'm a bit confused about this statement, because at the point in time of 
this patch we had a spot in the "Future Work" section about 
automatically updating the graph _somewhere_. The "future integration 
with 'git gc'" I refer to in this patch is implemented in PATCH 21/22. 
In PATCH 22/22 we removed this section from the technical doc:

-
-- The current design uses the 'commit-graph' subcommand to generate the graph.
-  When this feature stabilizes enough to recommend to most users, we should
-  add automatic graph writes to common operations that create many commits.
-  For example, one could compute a graph on 'clone', 'fetch', or 'repack'
-  commands.
-

Now that this feature is shipped in Git 2.19.0, this no longer belongs 
in "Future Work".

>>   With the `--stdin-commits` option, generate the new commit graph by
>>   walking commits starting at the commits specified in stdin as a list
>>   of OIDs in hex, one OID per line. (Cannot be combined with
>> ---stdin-packs.)
>> +`--stdin-packs` or `--reachable`.)
>> ++
>> +With the `--reachable` option, generate the new commit graph by walking
>> +commits starting at all refs. (Cannot be combined with `--stdin-commits`
>> +or `--stdin-packs`.)
>>   +
>>   With the `--append` option, include all commits that are present in the
>>   existing commit-graph file.
> The "EXAMPLES" section still contains:
>
> * Write a graph file containing all reachable commits.
> +
> ------------------------------------------------
> $ git show-ref -s | git commit-graph write --stdin-commits
> ------------------------------------------------
>
> I wonder if this should have been changed to use `--reachable`.
>
> Thanks!
This is a good idea. I can work on that.

Thanks,
-Stolee
