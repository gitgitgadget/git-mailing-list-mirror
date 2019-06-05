Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65ED21F462
	for <e@80x24.org>; Wed,  5 Jun 2019 18:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfFESJv (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 14:09:51 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40822 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfFESJv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 14:09:51 -0400
Received: by mail-qt1-f195.google.com with SMTP id a15so4583796qtn.7
        for <git@vger.kernel.org>; Wed, 05 Jun 2019 11:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gjdR4oYTSls3ovWEuE+x/BeYXo/Q4cxKAU3riHNLPqw=;
        b=vBcQ8nrO+UluYa3hiwWwZLKR3umhV5o+5soAY2TmfgL0NPILVDKnoQ+bMra4ZGNwn3
         fIKvtjdwnlOcMFabrbsPSXOh6ypEDdenXpLtsRqfjAcugQdDX76fTnKr0JLpU/RsMe/z
         uVIAZ+fcLBZTu3W06tzrVEK+qkPttSD2tLcaJ3/PwUtmqVumy+P4UHSiu0mxrb5XfubP
         Dt1w1bAmHWmw8IHxN5RtSzbYC9gRFj7IwFJ0VLjsJX45lp4ugZNi7Sf0h2l68b8AhM28
         iWOb3fAQd3iagGmt0yUcRi84WBcLnmLg/sXHhpwkC68QQamcTt7H+/q65eN1Pj7Hs6KP
         fSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gjdR4oYTSls3ovWEuE+x/BeYXo/Q4cxKAU3riHNLPqw=;
        b=V+7/Qc3pvTgDlZxc40WZXEZqAUX/A4rspsyU0Alx4ykAE92Tb1CmEmLbZfvKVdIFPO
         iUwotxVF2pCewM1GIL3c3+YyO35oI4MQV/3YCxdaN4k9gIvbr/P1N0uxwp49DbZ29KwE
         MB4ecH1EtLc3s66W1i7OmrZjXC/V007MCl2vZdnyKfc9vudcMCHvo6mILyyC7bLVzaqu
         L9wE1fvitINaWPf2GAxO2CveUkGgXLs6iE7Gss/Kzl1ok/WjONcMVDKtkpuIiHQjtTpl
         aba02eQuv/NFntlsIgLSgnR0SQs6GvlhETel22j3Mx1PstC7gpI1KmeczE4SPbYUCHcH
         awug==
X-Gm-Message-State: APjAAAXpaL5pvac2Xy2NR+N2ydjAowX2vFNdJx0zXVEM6rzIqRZVuoTn
        E0jk20zWU8cJ46tK9sOIkb3BOhqhAU1b2w==
X-Google-Smtp-Source: APXvYqw8ws+/O5mHu8Tq5BxqU2Hnfng/A45HttL1iOZXQKlst7IT8RVKWjwioQXcX7Ti6yLct4fWqA==
X-Received: by 2002:ac8:1a8d:: with SMTP id x13mr36303020qtj.114.1559758189748;
        Wed, 05 Jun 2019 11:09:49 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f8bc:cb1d:88e9:2127? ([2001:4898:a800:1012:a9f0:cb1d:88e9:2127])
        by smtp.gmail.com with ESMTPSA id a16sm7581816qtj.9.2019.06.05.11.09.48
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 11:09:49 -0700 (PDT)
Subject: Re: [PATCH v3 01/14] commit-graph: document commit-graph chains
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        git@jeffhostetler.com, jrnieder@google.com, steadmon@google.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.184.v2.git.gitgitgadget@gmail.com>
 <pull.184.v3.git.gitgitgadget@gmail.com>
 <b184919255bfc9e0d57e1a5ca12fb76957879c61.1559577826.git.gitgitgadget@gmail.com>
 <xmqqmuiwrlpz.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <62612a31-7649-5410-3732-ff9b6b61da31@gmail.com>
Date:   Wed, 5 Jun 2019 14:09:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <xmqqmuiwrlpz.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/5/2019 1:22 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Add a basic description of commit-graph chains. More details about the
>> feature will be added as we add functionality. This introduction gives a
>> high-level overview to the goals of the feature and the basic layout of
>> commit-graph chains.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  Documentation/technical/commit-graph.txt | 59 ++++++++++++++++++++++++
>>  1 file changed, 59 insertions(+)
>>
>> diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
>> index fb53341d5e..1dca3bd8fe 100644
>> --- a/Documentation/technical/commit-graph.txt
>> +++ b/Documentation/technical/commit-graph.txt
>> @@ -127,6 +127,65 @@ Design Details
>>    helpful for these clones, anyway. The commit-graph will not be read or
>>    written when shallow commits are present.
>>  
>> +Commit Graphs Chains
>> +--------------------
>> +
>> +Typically, repos grow with near-constant velocity (commits per day). Over time,
>> +the number of commits added by a fetch operation is much smaller than the
>> +number of commits in the full history. By creating a "chain" of commit-graphs,
>> +we enable fast writes of new commit data without rewriting the entire commit
>> +history -- at least, most of the time.
>> +
>> +## File Layout
>> +
>> +A commit-graph chain uses multiple files, and we use a fixed naming convention
>> +to organize these files. Each commit-graph file has a name
>> +`$OBJDIR/info/commit-graphs/graph-{hash}.graph` where `{hash}` is the hex-
>> +valued hash stored in the footer of that file (which is a hash of the file's
>> +contents before that hash). For a chain of commit-graph files, a plain-text
>> +file at `$OBJDIR/info/commit-graphs/commit-graph-chain` contains the
>> +hashes for the files in order from "lowest" to "highest".
>> +
>> +For example, if the `commit-graph-chain` file contains the lines
>> +
>> +```
>> +	{hash0}
>> +	{hash1}
>> +	{hash2}
>> +```
>> +
>> +then the commit-graph chain looks like the following diagram:
>> +
>> + +-----------------------+
>> + |  graph-{hash2}.graph  |
>> + +-----------------------+
>> +	  |
>> + +-----------------------+
>> + |                       |
>> + |  graph-{hash1}.graph  |
>> + |                       |
>> + +-----------------------+
>> +	  |
>> + +-----------------------+
>> + |                       |
>> + |                       |
>> + |                       |
>> + |  graph-{hash0}.graph  |
>> + |                       |
>> + |                       |
>> + |                       |
>> + +-----------------------+
>> +
>> +Let X0 be the number of commits in `graph-{hash0}.graph`, X1 be the number of
>> +commits in `graph-{hash1}.graph`, and X2 be the number of commits in
>> +`graph-{hash2}.graph`. If a commit appears in position i in `graph-{hash2}.graph`,
>> +then we interpret this as being the commit in position (X0 + X1 + i), and that
>> +will be used as its "graph position". The commits in `graph-{hash2}.graph` use these
>> +positions to refer to their parents, which may be in `graph-{hash1}.graph` or
>> +`graph-{hash0}.graph`. We can navigate to an arbitrary commit in position j by checking
>> +its containment in the intervals [0, X0), [X0, X0 + X1), [X0 + X1, X0 + X1 +
>> +X2).
> 
> One thing that I fail to read from the above is what it means for
> graphs to be inside a single chain.  What is the significance for a
> graph file graph-{hash1}.graph to be between graph-{hash0}.graph and
> graph-{hash2}.graph?   For example, is any of the following true?
> 
>  - For a commit in graph-{hash1}.graph file, if graph->{hash0}.graph
>    or any other graph files lower in the position in the chain were
>    unavailable, information on some ancestor of that commit may not
>    be available.

Not only that, but if graph-{hash0}.graph is unavailable, then the
graph-{hash1}.graph file is _unusable_. For example, we don't track
the number of commits in the base graph, so we could not accurately
find the commit-parent links even within graph-{hash1}.graph.

>  - Even if graph-{hash2}.graph or any other graph files higher in
>    the position in the chain gets lost, information on a commit in
>    graph-{hash1}.graph file or any of its ancestors is not affected.

This is correct. As we "build from the bottom" we can stop if we fail
to find a file, and all the data we already accessed is still valid.

> Another thing I've assumed to be true but cannot read from the above
> description is that the hashes in `commit-graph-chain` file, other
> than the newest one, are merely redundant information, and each
> graph file records the hash of its "previous" graph file (i.e. the
> one that used to be the youngest before it got created).

If the entire chain is available, then we only really need the tip hash.
However, having the entire chain in this file allows the "building from
the bottom" pattern so we can get some value even if the tip was removed
from under us. Since we expect the base file to change infrequently, this
should cover a large number of commits.

I can try to make this pattern more clear in a future revision, assuming
we stick with the pattern. It remains unclear if this strategy as a whole
has been accepted as a good direction.

Thanks,
-Stolee
