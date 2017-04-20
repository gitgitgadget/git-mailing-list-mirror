Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC8EE207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 22:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033134AbdDTWUv (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 18:20:51 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:34460 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032424AbdDTWUu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 18:20:50 -0400
Received: by mail-io0-f179.google.com with SMTP id a103so90552346ioj.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 15:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D72TRfWwAoxkCPBZfApxLomgPHMKO1nlniASH/jk1IU=;
        b=rmUY1Lm67vatHTgALE9fqUrZkEPTHuOx4Sn7j/lUU41qiVDalapgG7D/NzrtYnd6bS
         KEdxPyaPsfrchKfvHm1c6+8p8zI6nnce8mjY0B6tsvEldSqUbJxtgjsbViT4Td2pUbXH
         DkGYQByeIkqeUhYq83wqBdnJFZxMiagJmq3KEonBG+d4Z8sjAjpjOaN6qjnwuQux3heV
         gsTqtNMvgG/r5blM90I8jNDqzmb2IZBlUcHMK1eWwWKtpe2KG5k3pNt6ISNgrDvrOI1T
         R/jv0qHATyPZazCXiNGeaw9Y/LND2dENHgRNHd54fAsFNupViaeEZKZ82MWCGIRTZaKn
         pqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D72TRfWwAoxkCPBZfApxLomgPHMKO1nlniASH/jk1IU=;
        b=NT+FMty3fjEgP91NXu68oPT3mPxfUtO377kJQ4xRTPr9e0PDwBDpRl1kLroNpF73oj
         3pjmO5Tcl1jvsPL2iiNkvoF7WI1RzVzAhPk/iPV/ya5Nnb9XoedrWCCjl+PZ2RuCpROQ
         8H7iMYPTyqg1XXndcZDhY3nYol1DUFsnkjBJral0d2xFrJqZghrC3TvtPzjNILkw4HT2
         CRNQk+51hGR5zHw5TcQU8GROyiRVo7NmA1ZfOwq+vh/x22xQenQFr4tvTGHCIj3fVegi
         Pvn4HXJo3d/uLfvg97/5MHhofFBqhiooY18Ta8xqAetoQmrpFFJHvbi1F08EsPHubM/z
         4HNQ==
X-Gm-Message-State: AN3rC/7s3iKe4cAbVSeWXt7X76bEVG5jzuxGsW3t+mQL52jRZ5XbWB34
        e+C9ulSSX7W3gTurzWqRxpz05wTPXg7l
X-Received: by 10.84.231.136 with SMTP id g8mr4592255plk.12.1492726848784;
 Thu, 20 Apr 2017 15:20:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Thu, 20 Apr 2017 15:20:48 -0700 (PDT)
In-Reply-To: <20170420220736.GH142567@google.com>
References: <20170411194616.4963-1-sbeller@google.com> <20170411194616.4963-2-sbeller@google.com>
 <20170420220736.GH142567@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 20 Apr 2017 15:20:48 -0700
Message-ID: <CAGZ79kZeJp3nvjSJGy7P_dojjNbFtx3N11AOkGc-fdKkBOPFUg@mail.gmail.com>
Subject: Re: [PATCH 1/2] submodule.c: add has_submodules to check if we have
 any submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     Maxime Viargues <maxime.viargues@serato.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 3:07 PM, Brandon Williams <bmwill@google.com> wrote:
> On 04/11, Stefan Beller wrote:
>> +int has_submodules(unsigned what_to_check)
>> +{
>> +     if (what_to_check & SUBMODULE_CHECK_ANY_CONFIG) {
>> +             if (submodule_config_reading == SUBMODULE_CONFIG_NOT_READ)
>> +                     load_submodule_config();
>> +             if (submodule_config_reading == SUBMODULE_CONFIG_EXISTS)
>> +                     return 1;
>> +     }
>> +
>> +     if ((what_to_check & SUBMODULE_CHECK_ABSORBED_GIT_DIRS) &&
>> +         file_exists(git_path("modules")))
>> +             return 1;
>> +
>> +     if ((what_to_check & SUBMODULE_CHECK_GITMODULES_IN_WT) &&
>> +         (!is_bare_repository() && file_exists(".gitmodules")))
>> +             return 1;
>> +
>> +     if (what_to_check & SUBMODULE_CHECK_GITLINKS_IN_TREE) {
>> +             int i;
>> +
>> +             if (read_cache() < 0)
>> +                     die(_("index file corrupt"));
>> +
>> +             for (i = 0; i < active_nr; i++)
>> +                     if (S_ISGITLINK(active_cache[i]->ce_mode))
>> +                             return 1;
>> +     }
>> +
>> +     return 0;
>> +}
>
> It may be a good idea to rearrange these by order to correctness.

I arranged by estimated speed, i.e. from fastest to slowest:
* The first check just returns a value from memory in the standard case
  Though the first one may take a hit in performance for the very first time
  as it may need to load the config.
* The next two are an actual stat system call, each having a different
  'defect'. (We may have non-absorbed submodules or non-bare repos)
  -> We could have a check for in-tree as well, not sure if that is desired.

> Correctness may not be the best way to describe it, but which is the
> strongest indicator that there is a submodule or that a repo 'has a
> submodule'.

These indicators differ in strength for different scenarios IMO.
(Just after clone: check for a .gitmodules file instead of a config;
later: rather check for a config as it is fastest and actually catches
active submodules; maybe we do not care about inactive submodules)

>  That way in the future we could have a #define that is
> SUBMODULE_CHECK_ANY or ALL or something....Now that I'm thinking harder
> about that we may not want that, and just require explicitly stating
> which check you want done.
>
> Anyways good looking patch, and I like the idea of consolidating the
> checks into a single function.

Thanks,
Stefan
