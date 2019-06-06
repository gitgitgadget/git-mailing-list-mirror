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
	by dcvr.yhbt.net (Postfix) with ESMTP id 27D1A1F462
	for <e@80x24.org>; Thu,  6 Jun 2019 17:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfFFRJP (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 13:09:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39298 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfFFRJO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 13:09:14 -0400
Received: by mail-qt1-f195.google.com with SMTP id i34so3526112qta.6
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 10:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EjtiNn0zompadvSYc23kgoxqsu+6ovVW7qilFhN7zFI=;
        b=q+LpEiBuLsArHJg70UsapQ9YXsGPpkv3m0GCiiIPp7puKVFH93LeWoGkvAt8M29to0
         4s6Pp6yx25gUROFaiIGyLeuU9eiQ2FeSg0tr5lgMixUZj5VnsnEq5aucUvc6ENv6nZTC
         oYkxYDnp2fymRGJLOFTy7NXx22z/DG6ytKxi74sA2DCawCPJP7rxyXtUrpt+ZBwCpFrR
         rz53dwgESnftHMoOrf/BHu4i4Yx4OaaKW5wtGw+1VrlxLwfUtTHpsVA8AZhwoi2oVNOX
         LYeZ8t3zzP2oJ0WacUvfqbdqg04D3DcfpAPZamtDa0f0O6LYa58hLHjaUf9q+4t6Z2A2
         n7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EjtiNn0zompadvSYc23kgoxqsu+6ovVW7qilFhN7zFI=;
        b=EIXF5ueSOw/Mo3hacBw/oc7DXBAFrXzk3tN7OfGMfy2a04UZ4Tp8sE9nSvtUZ9MspA
         qaJnRWpS/b0REd4zFkep4dsgFeGGaxoZzkD+VhkUo0Zg3qs2EQR2Bq8npCR8tAQd3Pio
         64g+tsHYaJ4zk9uxiWO+Tl+JrJM14/qJ6mFiyOYuMS5jcRbtjYbh6Xt0CV8olx7EF5iS
         Gl5arV3uktwVb31a/hSEF/A41dqEgzMlaOSH45IS9w1kR1HtSw+vX3M5IK9quG8fQ7nn
         X5huuL8KEpno/1akNxtvdj4OIpUMse31dsMWMUmTjmR1jdQ1eRL4zG/10XwbutmRs2SL
         /2yQ==
X-Gm-Message-State: APjAAAWmpsEC+kjEUe7ZbOUdKY+6895wno5uyirHQwaDxHalchRe+Fne
        Nupv7PYcifUenM5TT+NH6e0=
X-Google-Smtp-Source: APXvYqwTSVaBEAQWWLsrNCYKpobLMvh2T/bwxAQoVAcdhS0sPFcG9miwHG2hRnmEnkixn9u9YA6i5g==
X-Received: by 2002:ac8:3281:: with SMTP id z1mr41579294qta.130.1559840953940;
        Thu, 06 Jun 2019 10:09:13 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4daa:35d6:a381:1849? ([2001:4898:a800:1010:fedf:35d6:a381:1849])
        by smtp.gmail.com with ESMTPSA id z1sm1515093qth.7.2019.06.06.10.09.12
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 10:09:13 -0700 (PDT)
Subject: Re: [PATCH v3 01/14] commit-graph: document commit-graph chains
To:     Philip Oakley <philipoakley@iee.org>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.184.v2.git.gitgitgadget@gmail.com>
 <pull.184.v3.git.gitgitgadget@gmail.com>
 <b184919255bfc9e0d57e1a5ca12fb76957879c61.1559577826.git.gitgitgadget@gmail.com>
 <6a6a0b72-e503-1fdd-e67e-2a84d825f89b@iee.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <909f355c-4c44-1556-71c7-168b28abddfc@gmail.com>
Date:   Thu, 6 Jun 2019 13:09:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <6a6a0b72-e503-1fdd-e67e-2a84d825f89b@iee.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/6/2019 8:10 AM, Philip Oakley wrote:
> Hi Derrick ,
> 
> On 03/06/2019 17:03, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Add a basic description of commit-graph chains.
> Not really your problem, but I did notice that we don't actually explain what we mean here by a commit graph (before we start chaining them), and the distinction between the generic concept and the specific implementation.
> 
> If I understand it correctly, the regular DAG (directed acyclic graph) already inherently contains the commit graph, showing the parent(s) of each commit. Hence, why do we need another? (which then needs explaining the what/why/how)
> 
> So, in one sense, another commit chain is potentially duplicated redundant data. What hasn't been surfaced (for the reader coming later) is probably that accessing the DAG commit graph can be (a) slow, (b) one way (no child relationships), and (c) accesses large amounts of other data that isn't relevant to the task at hand.
> 
> So the commit graph (implementation) is [I think] a fast, compact, sorted(?), list of commit oids that provides two way linkage through the commit graph (?) to allow fast queries within the Git codebase.
> 
> The commit graph is normally considered immutable,

_Commits_ are immutable. The graph grows as commits are added.

This may be the crux of your confusion, since the commit-graph
file can become stale as commits are added by 'git commit' or
'git fetch'. The point of the incremental file format is to
update the commit-graph data without rewriting the entire thing
every time.

Does this help clarify what's going on?

> however the DAG commit graph can be extended by new commits, trimmed by branch deletion, rebasing, forced push, etc, or even reorganised via 'replace' or grafts commits, which must then be reflected in the commit graph (implementation).

These things create new commit objects, which would not be in
the commit-graph file until it is rewritten.

> It just felt that there is a gap between the high level DAG, explained in the glossary, and the commit-graph That perhaps the technical/commit-graph.txt ought to summarise.

I do think that technical/commit-graph.txt does summarize a lot
about the commit-graph _file_ and how that accelerates walks on
the high-level DAG. The added content in this patch does assume
a full understanding of the previous contents of that file.

Thanks,
-Stolee

