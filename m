Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C9C01FD4F
	for <e@80x24.org>; Wed, 30 May 2018 01:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968172AbeE3BFk (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 21:05:40 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:45742 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966885AbeE3BFj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 21:05:39 -0400
Received: by mail-qk0-f172.google.com with SMTP id c198-v6so13094246qkg.12
        for <git@vger.kernel.org>; Tue, 29 May 2018 18:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=pfxVgYwD9GIUZ4d+yU38Y++dJn2+Gcalo2fcqwVKa3w=;
        b=sn6VZz27jAMgFtVqqz7oofjvFdvD/8Fq5lU7V3JEV/nOhIiutRqVLQa8m1FlkTGs3I
         MJI5mbTlTV3OnEd9O0uC/V4Mv/f/wNJtqVxI8iy4+D+bgp/GLi1dU3qO5aTvdG+1QjmO
         rSCiN2AbUzkynm67eabWZEBz2z5LzpyN+3GwSL4Nv+4gvd6a/XuXWFb4t5ldXMUe0kJ3
         WNI2qSrFr/2UrjfK482IWR0I1EnUKYxj2G/BTQLgo6SGEX2X1SPGw2v9v16JVLzshdFp
         kp5TvN/wOb6wJBVhBTGKPaAvehl2DdeoaQs5Qjxnm/Ku7rzrgG7UImy5lVnc7ylHdYkH
         g9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pfxVgYwD9GIUZ4d+yU38Y++dJn2+Gcalo2fcqwVKa3w=;
        b=d5v3q2xN4b7/XHQCRlbvhPy3OdzohJMgL6qMcXR3SLCspNBdE3KebyFUPDXJyvxWpV
         tVUm+qAaDQXLGxNxyykoF8SU8nM1dSdoHethnfzqvtsTdIljipY4rpPckx7TvhAjN7uW
         iercgFK2TVCz/ADshlCxRnKrab2E1NT5lJxr0KyijGta0mgCnnWo+PVXvIW0h9+Wuo5q
         DJOquf3LYm8oCrPIziVPlET20a3TaiPXtZYRm6P+jtV4TTQecMhwLXq0VRe49L/GFA6G
         R+8a4ZBPRsM9QufOV30Qf6HNKs+PvfTEbTHOJn5+xOsjl7/RZynbk12DzYlX69L/eW3R
         EpPw==
X-Gm-Message-State: APt69E21mGpz/kxQSL9I2BzwlZpVaEclzTrI31NbcN0mboYOF17lU3bi
        D3NZhyx/6xcleBaJtw+91PomG7NqP0Q=
X-Google-Smtp-Source: ADUXVKIAYIeP7PzubMjF+ET0CUt2as92e/XuswmWijIIEXWjd3KuKRv09tKmUKSoo7jc9vLNQvvtnw==
X-Received: by 2002:a37:4c4a:: with SMTP id z71-v6mr638319qka.44.1527642338452;
        Tue, 29 May 2018 18:05:38 -0700 (PDT)
Received: from [10.0.1.20] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id d200-v6sm10654893qkg.18.2018.05.29.18.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 May 2018 18:05:37 -0700 (PDT)
Subject: Re: [RFC PATCH 00/35] object-store: lookup_commit
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20180530004810.30076-1-sbeller@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <627c65a9-d807-8912-b96d-ef7feecb9ea4@gmail.com>
Date:   Tue, 29 May 2018 21:05:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/29/2018 8:47 PM, Stefan Beller wrote:
> This applies on the merge of nd/commit-util-to-slab and sb/object-store-grafts,
> and is available at http://github.com/stefanbeller/ as branch object-store-lookup-commit
> as the merge has some merge conflicts as well as syntactical conflicts (upload-pack.c
> and fetch-pack.c introduce new calls of functions that would want to take a repository struct
> in the object-store-grafts series)
>
> As layed out in https://public-inbox.org/git/20180517225154.9200-1-sbeller@google.com/
> this is getting close to finishing the set of object store series though the last
> unfinished part of this RFC hints at new work on the plate:
> * To give this series a nice polish, we'd want to convert parse_commit, too.
>    But that requires the conversion of the new commit graph. Maybe we need
>    to split this series into 2.

I'll take a look at this series tomorrow. I've been working in 
ds/commit-graph-fsck to make many of the methods take a 'struct 
commit_graph *' parameter, which could easily be 'r->commit_graph' for a 
'struct the_repository *r' instead of the global 'commit_graph'. Those 
graph-local methods will make the transformation to be repo-local a lot 
easier. (There still may be some need to insert a repository, though.)

Since you are working on the commit-slab stuff in this patch, I'll 
(continue to) delay my patch series on using the commit-slab for 
generation numbers to avoid collisions with your work.

Thanks,

-Stolee

