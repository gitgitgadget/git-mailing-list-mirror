Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D4E11F954
	for <e@80x24.org>; Mon, 20 Aug 2018 19:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbeHTXLZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 19:11:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40850 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTXLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 19:11:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id z25-v6so2597357pgu.7
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 12:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rxVanMejSFKhBT62gAehkarPPZK255C86baL4EVUdtw=;
        b=eNvA9YvMv5xC+lvCg1lE1WwPij28jbcujBND74Lmwe5r27K4pB0ROgjqiSToENwvPx
         vtX5Je1M8r/Zyogz8Mip6h+KQN12d02usTFOv/k8OCv9xn//InnWBMfFe+lWS8EM3Yya
         LOcCmCla5Bds0es8XLQsXHHm6KmhbXHmMtRlAjouCes73+h2Q1Gueli1deRBZ0rkm/JB
         qKrENr1Yr2YQwEjLqNK2lEoVmtRXYySrOJQ2jdK6K7iNlfjVrQ6wfjE9vt6H2cSRx2F5
         jAEspm7yXA+XLKCm5JGq4frjoje57QkAFFzfd5Gls1brbqsrXWaE2DmnxZJCMZ941rr4
         D+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rxVanMejSFKhBT62gAehkarPPZK255C86baL4EVUdtw=;
        b=sMNetFeDsduFDSMeDrJ484f9rcIzJrXHJFrHMfice933XTRGTgl4sIfL+BISYVbQte
         9o9PilEJXs+IXtYdqV+JPAmDY07xW6EtZ7lK8Uq8Ns1uzDsjpdnqNgLYuuxsSH0++yVs
         ibHSUSztzi2s1byujRfzjxROf75y1RvsprEDxAOgSKKfyiu022hLMZCGyDaKDkEjYJ3u
         nHcquyHqNxmlo+a3YVPWqcMv1brK42EV43e9V2zuTsGhLytuBUFGZebG0qIJ+2UcpL/H
         58E1xB9yFCNUYQJvbD7qt1C9mPDJGxCGFGmDsnF4T1OkZ6hfHDcoECrWVY1H5p2BQ5Lv
         BZYw==
X-Gm-Message-State: AOUpUlGxPsBIPPsmcnGLSAjoxxG6EXMrwIhvYwuby33LND6h4qT5Hhtu
        WacKI9LMUThYyDsQJoWcCg4=
X-Google-Smtp-Source: AA+uWPz9FSrifoRR1MSkbaZoJvDMWkx48XeyNZNvMQTo+uMt33QVGS5Yu9FG8DFKR/G7YhsTz6nA2A==
X-Received: by 2002:a62:cac5:: with SMTP id y66-v6mr49477456pfk.187.1534794868094;
        Mon, 20 Aug 2018 12:54:28 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:b885:8a8f:31f:ed4e? ([2001:4898:e008:1:41c2:8a8f:31f:ed4e])
        by smtp.gmail.com with ESMTPSA id r22-v6sm16984174pfl.112.2018.08.20.12.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 12:54:27 -0700 (PDT)
Subject: Re: [PATCH v2 0/8] Clarify commit-graph and grafts/replace/shallow
 incompatibilities
To:     Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
References: <pull.11.git.gitgitgadget@gmail.com>
 <20180820182359.165929-1-dstolee@microsoft.com>
 <CAGZ79ka6=Zw8pFhwVysoE3Wa+mpUm4E83cf7TCKmYZ7XC0ZL2A@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d13e2b64-e078-e409-8b39-01a23385e3c9@gmail.com>
Date:   Mon, 20 Aug 2018 15:54:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79ka6=Zw8pFhwVysoE3Wa+mpUm4E83cf7TCKmYZ7XC0ZL2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/20/2018 3:37 PM, Stefan Beller wrote:
> On Mon, Aug 20, 2018 at 11:24 AM Derrick Stolee <dstolee@microsoft.com> wrote:
>> One unresolved issue with the commit-graph feature is that it can cause
>> issues when combined with replace objects, commit grafts, or shallow
>> clones. These are not 100% incompatible, as one could be reasonably
>> successful writing a commit-graph after replacing some objects and not
>> have issues. The problems happen when commits that are already in the
>> commit-graph file are replaced, or when git is run with the
>> `--no-replace-objects` option; this can cause incorrect parents or
>> incorrect generation numbers. Similar things occur with commit grafts
>> and shallow clones, especially when running `git fetch --unshallow` in a
>> shallow repo.
>>
>> Instead of trying (and probably failing) to make these features work
>> together, default to making the commit-graph feature unavailable in these
>> situations. Create a new method 'commit_graph_compatible(r)' that checks
>> if the repository 'r' has any of these features enabled.
>>
>> CHANGES IN V2:
>>
>> * The first two commits regarding the ref iterators are unchanged, despite
>>    a lot of discussion on the subject [1].
>>
>> * I included Peff's changes in jk/core-use-replace-refs, changing the base
>>    commit for the series to 1689c22c1c328e9135ed51458e9f9a5d224c5057 (the merge
>>    that brought that topic into 'msater').
>>
>> * I fixed the tests for the interactions with the graft feature.
>>
>> Because of the change of base, it is hard to provide a side-by-side diff
>> from v1.
>>
>> Thanks,
>> -Stolee
>>
>> [1] https://public-inbox.org/git/CAGZ79kZ3PzqpGzXWcmxjzi98gA+LT2MBOf8KaA89hOa-Qig=Og@mail.gmail.com/
>>      Stefan's response recommending we keep the first two commits.
>>
> After reviewing my own patches, I flipped again (Sorry!) and would
> rather not see my patches be merged, but the very original solution
> by you, that you proposed at [1]. That said, I will not insist on it, and
> if this is merged as is, we can fix it up later.
>
> With that said, I just read through the remaining patches, I think
> they are a valuable addition to Git and could be merged as-is.
>
> [1] https://github.com/gitgitgadget/git/pull/11/commits/300db80140dacc927db0d46c804ca0ef4dcc1be1
>
> Thanks,
> Stefan

Just to keep things on-list as possible, here is the patch for the 
commit linked above. It would replace patches 1 & 2 from this series.

Junio: I can send a v3 that includes this commit if you need it, or if 
there are other edits to be made in this series.

commit 300db80140dacc927db0d46c804ca0ef4dcc1be1
Author: Derrick Stolee <dstolee@microsoft.com>
Date:   Fri Jul 20 15:39:06 2018 -0400

     replace-objects: use arbitrary repositories

     This is the smallest possible change that makes prepare_replace_objects
     work properly with arbitrary repositories. By supplying the repository
     as the cb_data, we do not need to modify any code in the ref iterator
     logic. We will likely want to do a full replacement of the ref iterator
     logic to provide a repository struct as a concrete parameter.

     Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

diff --git a/replace-object.c b/replace-object.c
index 801b5c1678..e99fcd1ff6 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -14,6 +14,7 @@ static int register_replace_ref(const char *refname,
         const char *slash = strrchr(refname, '/');
         const char *hash = slash ? slash + 1 : refname;
         struct replace_object *repl_obj = xmalloc(sizeof(*repl_obj));
+       struct repository *r = (struct repository *)cb_data;

         if (get_oid_hex(hash, &repl_obj->original.oid)) {
                 free(repl_obj);
@@ -25,7 +26,7 @@ static int register_replace_ref(const char *refname,
         oidcpy(&repl_obj->replacement, oid);

         /* Register new object */
-       if (oidmap_put(the_repository->objects->replace_map, repl_obj))
+       if (oidmap_put(r->objects->replace_map, repl_obj))
                 die("duplicate replace ref: %s", refname);

         return 0;
@@ -40,7 +41,7 @@ static void prepare_replace_object(struct repository *r)
                 xmalloc(sizeof(*r->objects->replace_map));
         oidmap_init(r->objects->replace_map, 0);

-       for_each_replace_ref(r, register_replace_ref, NULL);
+       for_each_replace_ref(r, register_replace_ref, r);
  }

  /* We allow "recursive" replacement. Only within reason, though */

