Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B2681F453
	for <e@80x24.org>; Fri,  5 Oct 2018 12:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeJETEZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 15:04:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35769 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbeJETEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 15:04:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id v19-v6so13475181qtg.2
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 05:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iXLi30PyoW7CKafwVAfNRl45pbPg7sSq2uW56n80arw=;
        b=ZBk5zTqSRtF4z+tsv0uCfezeqxN7pMnswstlUf6aZKIW/7/8CZcv1svj8L0e3eLlJI
         sCPMHdRHQTHye7fWlWcEj6P1QWbuXQzJgB2xnefnWm9x+dQ/z/MRTJy64Wa1bArZ7BTq
         Wy+vSVzwbrK+023vkrKuAqAS/kta4Mqr17dAp0fzsYb32wfGRIrgHA4kDAis7JGMkcoy
         0VRSHRt7nfi9JgTiQRGScLYBsxn0T5DMUuT+FAqh9T0zQYh9EVkWbBR6wqglYb/6rVcJ
         7gviWlleD0L6qK9y9+DDfy0JhEM6p4iH8pxjZ3zVC2pShNgTYhJgj88KXGRSW/Iu054M
         uNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iXLi30PyoW7CKafwVAfNRl45pbPg7sSq2uW56n80arw=;
        b=VD7FpohEsIo6n5ETo4Q4c9l2qHAr1SxL9gjYhjq6v3xeTAYkp8wuY11noSVSo3Z1A5
         Mo6rGnDPoVilztcUnw57AUWx8r0+m4b+YuXgcTtwv8SJGkNOdQj9UTRHCIi5mTyST9b/
         /1qy2MHFL923/J4Cx7qUBgJT8zt1OcYPfyMkD+S+m/+OtZur2jUEAJull75AEuAz4k/E
         ibjpJYnwLjy8cjZWSBDoxIkt5fciWhYJGWb+6H8Xyy/DrU9NLjzv7i1Yjko9xb+B0/CC
         Rj1aik7DWx3cPo36USLZpBOwmhm8WJrAYJqBzz8F6vo1yF2DAPtEQrMPqlwlw60oPWGt
         DhtA==
X-Gm-Message-State: ABuFfoh6VTl0+Gh4F79Pg8yXENT6AsmbcnCGiMnhtt9SyoSvIEnDm6Nt
        VE/W2Zu3icHkwObHbxwIh0Q=
X-Google-Smtp-Source: ACcGV600WI4v2XAjgFPwcosPS6XK2jZck7kuBZCI0U2Z9FU5mDTrwG0lPFUEwpbXnwD8hzpjBQDbuw==
X-Received: by 2002:ac8:2278:: with SMTP id p53-v6mr8547836qtp.200.1538741157493;
        Fri, 05 Oct 2018 05:05:57 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id u18-v6sm4364291qtb.63.2018.10.05.05.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 05:05:56 -0700 (PDT)
Subject: Re: [RFC PATCH] We should add a "git gc --auto" after "git clone" due
 to commit graph
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
References: <87tvm3go42.fsf@evledraar.gmail.com>
 <87in2hgzin.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <dcb8f115-ce3c-64fa-50cc-dd03569c0164@gmail.com>
Date:   Fri, 5 Oct 2018 08:05:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87in2hgzin.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/4/2018 5:42 PM, Ævar Arnfjörð Bjarmason wrote:
> I don't have time to polish this up for submission now, but here's a WIP
> patch that implements this, highlights:
>
>   * There's a gc.clone.autoDetach=false default setting which overrides
>     gc.autoDetach if 'git gc --auto' is run via git-clone (we just pass a
>     --cloning option to indicate this).

I'll repeat that it could make sense to do the same thing on clone _and_ 
fetch. Perhaps a "--post-fetch" flag would be good here to communicate 
that we just downloaded a pack from a remote.

>   * A clone of say git.git with gc.writeCommitGraph=true looks like:
>
>     [...]
>     Receiving objects: 100% (255262/255262), 100.49 MiB | 17.78 MiB/s, done.
>     Resolving deltas: 100% (188947/188947), done.
>     Computing commit graph generation numbers: 100% (55210/55210), done.

This looks like good UX. Thanks for the progress here!

>   * The 'git gc --auto' command also knows to (only) run the commit-graph
>     (and space is left for future optimization steps) if general GC isn't
>     needed, but we need "optimization":
>
>     $ rm .git/objects/info/commit-graph; ~/g/git/git --exec-path=$PWD -c gc.writeCommitGraph=true -c gc.autoDetach=false gc --auto;
>     Annotating commits in commit graph: 341229, done.
>     Computing commit graph generation numbers: 100% (165969/165969), done.
>     $

Will this also trigger a full commit-graph rewrite on every 'git commit' 
command? Or is there some way we can compute the staleness of the 
commit-graph in order to only update if we get too far ahead? 
Previously, this was solved by relying on the auto-GC threshold.

>   * The patch to gc.c looks less scary with -w, most of it is indenting
>     the existing pack-refs etc. with a "!auto_gc || should_gc" condition.
>
>   * I added a commit_graph_exists() exists function and only care if I
>     get ENOENT for the purposes of this gc mode. This would need to be
>     tweaked for the incremental mode Derrick talks about, but if we just
>     set "should_optimize" that'll also work as far as gc --auto is
>     concerned (e.g. on fetch, am etc.)

The incremental mode would operate the same as split-index, which means 
we will still look for .git/objects/info/commit-graph. That file may 
point us to more files.

> +int commit_graph_exists(const char *graph_file)
> +{
> +	struct stat st;
> +	if (stat(graph_file, &st)) {
> +		if (errno == ENOENT)
> +			return 0;
> +		else
> +			return -1;
> +	}
> +	return 1;
> +}
> +

This method serves a very similar purpose to 
generation_numbers_enabled(), except your method only cares about the 
file existing. It ignores information like `core.commitGraph`, which 
should keep us from doing anything with the commit-graph file if false.

Nothing about your method is specific to the commit-graph file, since 
you provide a filename as a parameter. It could easily be "int 
file_exists(const char *filename)".

Thanks,

-Stolee


