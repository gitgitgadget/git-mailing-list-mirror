Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34FF31F406
	for <e@80x24.org>; Mon, 14 May 2018 13:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753476AbeENNoI (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 09:44:08 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:45762 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752677AbeENNoG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 09:44:06 -0400
Received: by mail-qk0-f169.google.com with SMTP id c64-v6so9962443qkf.12
        for <git@vger.kernel.org>; Mon, 14 May 2018 06:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5hdWW9K8RgzMYtozabbfyPnjEu4YWUL9icR88HOeuXc=;
        b=hQZVmP80+FsyRbHgqcJd/a9SP1zgIL23ecmUou6YK9yb4mTQBeJf0/WMcR7G2Do1Oc
         T2/USCy9C6M3l2t+EsTq8ijMyYnd2oguBBC/Bvi5fuHJP6s+GHq1W5rYo9U7lzkhVZ2s
         nxTW63g+mCP0Z9FulkSiE4VA5EUf53K1rzWdDdxN+/Y8+Cqf3GqvRURsMuSsCkqV5qY8
         uG7b6+kJxnSeLuzhieqX5p4CK6UV/Dq45+TnZTIaRpAPVwk62Y0s1LbYc2ZSqF827zp1
         RMuXPW8ywFDnBZ6GQb5abag5xaLb3VnzBYyq3DXwVzjB23J0+PQCst1Us/Ati3DEnzeF
         dpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5hdWW9K8RgzMYtozabbfyPnjEu4YWUL9icR88HOeuXc=;
        b=ZhfpdCJ2D9tb1QbeDSbMj01Mq87TsiUJhT6ob6nwKVWgUGHknGjiPuIPL2YKNWkCwt
         j/DPSVTQBythdHOB6AXWjyGNb64NLw9pX5RCRWJGfx0M7wyk+zMgthTkE1BIT1vCvms1
         v1HgwM3tw5Ylkhm+BScTcwldsV/SgMFwm1a02nHrqT927gj1+070xO1QEywyeov67s0v
         hbxDo6uG8UyQL8pLUmK263fFu9tujQypP5uc3yJWIz3RoYHR2uyLbBePI5kIzmpCQ2zk
         j/B312fJPUiEyGDtCvOktjsccNNssi9gUgLWcb9H2/1lzuqlbEurEwImzepY1rRhH3Qp
         3GhA==
X-Gm-Message-State: ALKqPwdd37AnrgWaP2HrksOpjD7C7AVEpIA/Z7oFyyCL6V+mWAiHUksC
        gdHIBbaRM1dZkLMu8yMYpas=
X-Google-Smtp-Source: AB8JxZrgeH6+jJydcMd0douW4j6r9DUl6niuO2FzoZOaVsNez9nEdz311mkVK+kaTWYNV9aOWM1jQw==
X-Received: by 2002:a37:2655:: with SMTP id y82-v6mr6348292qkg.18.1526305445881;
        Mon, 14 May 2018 06:44:05 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id v57-v6sm7733318qtj.47.2018.05.14.06.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 May 2018 06:44:04 -0700 (PDT)
Subject: Re: [PATCH v2 08/12] commit-graph: verify commit contents against odb
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20180510173345.40577-1-dstolee@microsoft.com>
 <20180511211504.79877-1-dstolee@microsoft.com>
 <20180511211504.79877-9-dstolee@microsoft.com>
 <CAN0heSo2sTgVSoxUiugSaEjev+0eyzCRA5ZmQVr6FRtKkyGJsQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a7637e48-b7a7-54fe-a085-b98f84df106e@gmail.com>
Date:   Mon, 14 May 2018 09:44:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSo2sTgVSoxUiugSaEjev+0eyzCRA5ZmQVr6FRtKkyGJsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/12/2018 5:17 PM, Martin Ågren wrote:
> On 11 May 2018 at 23:15, Derrick Stolee <dstolee@microsoft.com> wrote:
>> When running 'git commit-graph verify', compare the contents of the
>> commits that are loaded from the commit-graph file with commits that are
>> loaded directly from the object database. This includes checking the
>> root tree object ID, commit date, and parents.
>>
>> Parse the commit from the graph during the initial loop through the
>> object IDs to guarantee we parse from the commit-graph file.
>>
>> In addition, verify the generation number calculation is correct for all
>> commits in the commit-graph file.
>>
>> While testing, we discovered that mutating the integer value for a
>> parent to be outside the accepted range causes a segmentation fault. Add
>> a new check in insert_parent_or_die() that prevents this fault. Check
>> for that error during the test, both in the typical parents and in the
>> list of parents for octopus merges.
> This paragraph and the corresponding fix and test feel like a separate
> patch to me. (The commit message of it could be "To test the next patch,
> we threw invalid data at `git commit-graph verify, and it crashed in
> pre-existing code, so let's fix that first" -- there is definitely a
> connection.) Is this important enough to fast-track to master in time
> for 2.18? My guess would be no.
>
>> +
>> +       if (pos >= g->num_commits)
>> +               die("invalide parent position %"PRIu64, pos);
> s/invalide/invalid/
>
>> @@ -875,6 +879,8 @@ int verify_commit_graph(struct commit_graph *g)
>>                  return 1;
>>
>>          for (i = 0; i < g->num_commits; i++) {
>> +               struct commit *graph_commit;
>> +
>>                  hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
>>
>>                  if (i && oidcmp(&prev_oid, &cur_oid) >= 0)
>> @@ -892,6 +898,10 @@ int verify_commit_graph(struct commit_graph *g)
>>
>>                          cur_fanout_pos++;
>>                  }
>> +
>> +               graph_commit = lookup_commit(&cur_oid);
>> +               if (!parse_commit_in_graph_one(g, graph_commit))
>> +                       graph_report("failed to parse %s from commit-graph", oid_to_hex(&cur_oid));
>>          }
> Could this end up giving ridiculous amounts of output? It would depend
> on the input, I guess.
>
>>          while (cur_fanout_pos < 256) {
>> @@ -904,5 +914,95 @@ int verify_commit_graph(struct commit_graph *g)
>>                  cur_fanout_pos++;
>>          }
>>
>> +       if (verify_commit_graph_error)
>> +               return 1;
> Well, here we give up before running into *too* much problem.
>
>> +       for (i = 0; i < g->num_commits; i++) {
>> +               struct commit *graph_commit, *odb_commit;
>> +               struct commit_list *graph_parents, *odb_parents;
>> +               int num_parents = 0;
>> +
>> +               hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
>> +
>> +               graph_commit = lookup_commit(&cur_oid);
>> +               odb_commit = (struct commit *)create_object(cur_oid.hash, alloc_commit_node());
>> +               if (parse_commit_internal(odb_commit, 0, 0)) {
>> +                       graph_report("failed to parse %s from object database", oid_to_hex(&cur_oid));
>> +                       continue;
>> +               }
>> +
>> +               if (oidcmp(&get_commit_tree_in_graph_one(g, graph_commit)->object.oid,
>> +                          get_commit_tree_oid(odb_commit)))
>> +                       graph_report("root tree object ID for commit %s in commit-graph is %s != %s",
>> +                                    oid_to_hex(&cur_oid),
>> +                                    oid_to_hex(get_commit_tree_oid(graph_commit)),
>> +                                    oid_to_hex(get_commit_tree_oid(odb_commit)));
>> +
>> +               if (graph_commit->date != odb_commit->date)
>> +                       graph_report("commit date for commit %s in commit-graph is %"PRItime" != %"PRItime"",
>> +                                    oid_to_hex(&cur_oid),
>> +                                    graph_commit->date,
>> +                                    odb_commit->date);
>> +
>> +
>> +               graph_parents = graph_commit->parents;
>> +               odb_parents = odb_commit->parents;
>> +
>> +               while (graph_parents) {
>> +                       num_parents++;
>> +
>> +                       if (odb_parents == NULL)
>> +                               graph_report("commit-graph parent list for commit %s is too long (%d)",
>> +                                            oid_to_hex(&cur_oid),
>> +                                            num_parents);
>> +
>> +                       if (oidcmp(&graph_parents->item->object.oid, &odb_parents->item->object.oid))
>> +                               graph_report("commit-graph parent for %s is %s != %s",
>> +                                            oid_to_hex(&cur_oid),
>> +                                            oid_to_hex(&graph_parents->item->object.oid),
>> +                                            oid_to_hex(&odb_parents->item->object.oid));
>> +
>> +                       graph_parents = graph_parents->next;
>> +                       odb_parents = odb_parents->next;
>> +               }
>> +
>> +               if (odb_parents != NULL)
>> +                       graph_report("commit-graph parent list for commit %s terminates early",
>> +                                    oid_to_hex(&cur_oid));
>> +
>> +               if (graph_commit->generation) {
>> +                       uint32_t max_generation = 0;
>> +                       graph_parents = graph_commit->parents;
>> +
>> +                       while (graph_parents) {
>> +                               if (graph_parents->item->generation == GENERATION_NUMBER_ZERO ||
>> +                                   graph_parents->item->generation == GENERATION_NUMBER_INFINITY)
>> +                                       graph_report("commit-graph has valid generation for %s but not its parent, %s",
>> +                                                    oid_to_hex(&cur_oid),
>> +                                                    oid_to_hex(&graph_parents->item->object.oid));
>> +                               if (graph_parents->item->generation > max_generation)
>> +                                       max_generation = graph_parents->item->generation;
>> +                               graph_parents = graph_parents->next;
>> +                       }
>> +
>> +                       if (max_generation == GENERATION_NUMBER_MAX)
>> +                               max_generation--;
> I'm not too familiar with these concepts. Is this a trick in preparation
> for this:
>
>> +
>> +                       if (graph_commit->generation != max_generation + 1)
> Any way that could give a false negative? (I'm not sure it would matter
> much.) Maybe "if (!MAX && generation != max + 1)".

You're right that this is confusing. Seems worth a comment.

When we have a commit-graph with computed generation numbers, the 
generation number for a commit is exactly one more than the maximum 
generation number of its parents EXCEPT in the case that we would have a 
generation number too large to store in the commit-graph. In this case 
(that is not currently possible with any repo in existence) we "squash" 
the generation number at GENERATION_NUMBER_MAX, so we have equality 
between the generation at the commit and the generation of a parent.

>
>> +                               graph_report("commit-graph has incorrect generation for %s",
>> +                                            oid_to_hex(&cur_oid));
>> +               } else {
>> +                       graph_parents = graph_commit->parents;
>> +
>> +                       while (graph_parents) {
>> +                               if (graph_parents->item->generation)
>> +                                       graph_report("commit-graph has generation ZERO for %s but not its parent, %s",
>> +                                                    oid_to_hex(&cur_oid),
>> +                                                    oid_to_hex(&graph_parents->item->object.oid));
>> +                               graph_parents = graph_parents->next;
>> +                       }
>> +               }
>> +       }
>> +
>>          return verify_commit_graph_error;
>>   }
> At this point, I should admit that I went through the above thinking
> "right, makes sense, ok, sure". I was not really going "hmm, I wonder
> ..." This looks like the real meat of "verify", and I'll try to look it
> over with a fresh pair of eyes tomorrow.

I appreciate the level of inspection you are giving this series!

>
>> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>> +       corrupt_data $objdir/info/commit-graph 1134 "\01" &&
>> +       corrupt_data $objdir/info/commit-graph 1312 "\01" &&
>> +       corrupt_data $objdir/info/commit-graph 1332 "\01" &&
>> +       corrupt_data $objdir/info/commit-graph 1712 "\01" &&
>> +       corrupt_data $objdir/info/commit-graph 1340 "\01" &&
>> +       corrupt_data $objdir/info/commit-graph 1344 "\01" &&
> Could you document these numbers somehow? (Maybe even calculate them
> from constant inputs, although that might be a form of premature
> optimization.) When some poor soul has to derive the corresponding
> numbers for a commit-graph with NewHash, they will thank you.

Yeah, this is a bit of a mess. The arithmetic to get these numbers is 
not hard, so I could do that math in the script (at run time instead of 
at dev time).

I also realize that the way I write the commit-graph to be "fixed" 
before these tests is not so fixed: if a new ref is added, then the 
tests break. I'll update the commit-graph to be reachable from commits/8 
so we have a more concrete example:

git rev-parse commits/8 | git commit-graph write --stdin-commits

(This already changes the written commit-graph because of the 'git pull' 
test, so it will "help" me be sure my math is correct when recomputing 
the new offsets for the corruption tests.)

Thanks,
-Stolee
