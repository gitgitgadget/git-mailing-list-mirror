Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1959620A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 13:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbeLGNt0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 08:49:26 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41115 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeLGNt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 08:49:26 -0500
Received: by mail-qt1-f194.google.com with SMTP id d18so4455317qto.8
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 05:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8oe3S9vWUwAchDT99zOYwuS9t6cXc40ewys2xA+u39E=;
        b=tE6KnXhaRivx1Lu8843Eld9ZtsFLXYc9nt/KCcA4G7ig3cwdhTJNqbdCrTCHpdCQ9f
         UfwAoQEbYD7YJBUpELWWm1/oZ2YnV8ge+S63pJvYRTWP/48Delac1zaW3TcRSD5T7GEE
         Kh7nWvvj7QJYEhKeVv5w+f+RwgZ+HENWpTxeqwrFTHP0mgN/1ipeRLpCItwdCsNWqYd1
         2WkyY4wupolgzPzBTdvOUd17etipVY1ADPa2pMa/JLXtu4KOIO/LrM5348G4BnQ2cDn7
         +5i8QEcYlpv43zmWJmdm4ehJI7N/d+W9o6+5prKjqP6QLHKRzKi2MhEgyOTCJQbpm7Ro
         cqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8oe3S9vWUwAchDT99zOYwuS9t6cXc40ewys2xA+u39E=;
        b=tkxYGAzjSrgXLi9B8UEr8FTV4VDasAUjRZ0T7DExJOYTbEdMhB/vjW/wMRzsiAcxe9
         j4pzECF36KwmK+fSVo9eGgL+0s9TKdabBa13vU+/de4vXVddTfLb4kHlS1vgoC6iRT1Q
         BNj/RLLgwgPj/oS1eFY54rh7p8BctQ7kfkTe1QphRZ7HhDfpafLI0DimGo+mijkmiX63
         CqfReuIF8s2Zj2MYg1PKMR8PmjVKKtJnxh6XkRVehW4Pix0Qi7pNTp0/PO1Xl6D8828N
         AB2sANoLmC2YkPTMPbFpH5XweIhLie9wJAGd/lc5LNrMcOgTcwgQFuNJJiNOg61fT++9
         LL+w==
X-Gm-Message-State: AA+aEWbj9S6gRHrv7uBoihMbcjpKmQcteC8cF77Q5wo67XMDL1D4WZtr
        J3u/c4ZNeAPYTTPe0rBskTu7e+lU
X-Google-Smtp-Source: AFSGD/VRGTJ7aDFHRKycWZsgZoVwrVUGHbc8xkKrWIt+v7GuRFkwV4iLKYEIpTFN2XYkJCSVSQaktg==
X-Received: by 2002:aed:22ba:: with SMTP id p55mr2015834qtc.137.1544190564570;
        Fri, 07 Dec 2018 05:49:24 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:84f0:5a6c:bde1:b2f7? ([2001:4898:8010:0:6e26:5a6c:bde1:b2f7])
        by smtp.gmail.com with ESMTPSA id n26sm1503835qkg.74.2018.12.07.05.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 05:49:23 -0800 (PST)
Subject: Re: [PATCH on sb/more-repo-in-api] revision: use commit graph in
 get_reference()
To:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com
Cc:     git@vger.kernel.org
References: <CAGZ79kYOOk2ODYgRcSZgDUqBfx2HeywnEGpbJB9BrrVzEUi_JA@mail.gmail.com>
 <20181206233626.144072-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <aa0cd481-c135-47aa-2a69-e3dc71661caa@gmail.com>
Date:   Fri, 7 Dec 2018 08:49:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181206233626.144072-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/6/2018 6:36 PM, Jonathan Tan wrote:
>> AFAICT oid_object_info doesn't take advantage of the commit graph,
>> but just looks up the object header, which is still less than completely
>> parsing it. Then lookup_commit is overly strict, as it may return
>> NULL as when there still is a type mismatch (I don't think a mismatch
>> could happen here, as both rely on just the object store, and not the
>> commit graph.), so this would be just defensive programming for
>> the sake of it. I dunno.
>>
>>      struct commit *c;
>>
>>      if (oid_object_info(revs->repo, oid, NULL) == OBJ_COMMIT &&
>>          (c = lookup_commit(revs->repo, oid)) &&
>>          !repo_parse_commit(revs->repo, c))
>>              object = (struct object *) c;
>>      else
>>          object = parse_object(revs->repo, oid);
> I like this way better - I'll do it in the next version.

If we do _not_ have a commit-graph or if the commit-graph does not have
that commit, this will have the same performance problem, right?

Should we instead create a direct dependence on the commit-graph, and try
to parse the oid from the graph directly? If it succeeds, then we learn
that the object is a commit, in addition to all of the parsing work. This
means we could avoid oid_object_info() loading data if we succeed. We
would fall back to parse_object() if it fails.

I was thinking this should be a simple API call to parse_commit_in_graph(),
but that requires a struct commit filled with an oid, which is not the
best idea if we don't actually know it is a commit yet.

The approach I recommend would then be more detailed:

1. Modify find_commit_in_graph() to take a struct object_id instead of a
    struct commit. This helps find the integer position in the graph. That
    position can be used in fill_commit_in_graph() to load the commit
    contents. Keep find_commit_in_graph() static as it should not be a
    public function.

2. Create a public function with prototype

struct commit *try_parse_commit_from_graph(struct repository *r, struct 
object_id *oid)

    that returns a commit struct fully parsed if and only if the repository
    has that oid. It can call find_commit_in_graph(), then 
lookup_commit() and
    fill_commit_in_graph() to create the commit and parse the data.

3. In replace of the snippet above, do:

     struct commit *c;

     if ((c = try_parse_commit_from_graph(revs->repo, oid))
         object = (struct object *)c;
     else
         object = parse_object(revs->repo, oid);

A similar pattern _could_ be used in parse_object(), but I don't recommend
doing this pattern unless we have a reasonable suspicion that we are going
to parse commits more often than other objects. (It adds an O(log(# 
commits))
binary search to each object.)

A final thought: consider making this "try the commit graph first, but fall
back to parse_object()" a library function with a name like

     struct object *parse_probably_commit(struct repository *r, struct 
object_id *oid)

so other paths that are parsing a lot of commits (but also maybe tags) could
use the logic.

Thanks!
-Stolee
