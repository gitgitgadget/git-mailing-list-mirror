Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AEDF1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 20:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755937AbeAHUgD (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 15:36:03 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:41977 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754909AbeAHUgC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 15:36:02 -0500
Received: by mail-qk0-f194.google.com with SMTP id a8so15834924qkb.8
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 12:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QhDzvUjwtGx1zypEENVZvE37ZZ18MdFUtpPSC1em5A0=;
        b=oKeJA4LppUKU9tCGBgBSwninhZU68O92qf4t02cFQorobvNq8AoojBfyqDy+mxtp+q
         AWJeixfMPc5GT2kzVG+8DOcnL2DW2+CywTXtF7eusCGJO9+iYtBH3uEEb5QhWSA7jBFg
         k8idCswlXc0B89nWcR/o8biXqK+BvL9e/CAELw5OkF4Zf7ZAJhmvI86f4WZhJmgqwL2F
         /BFKdkx6VBxpvESmKGdF3jzCI99UAwTea7sUoQzjHLHGVRY41ii9jdVbYXSHMhHaeAr7
         SPrmrwNVy9hOwEm+xiuNfr2fK24YGj+a+oqRmVlP+glrHSgyQjmnNT2y4pL5rscGlNpO
         sc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QhDzvUjwtGx1zypEENVZvE37ZZ18MdFUtpPSC1em5A0=;
        b=IRCZIbaqeAokIDeLVEJmD37TBhsCFFlnLTm9BUKyev9HSDYC8JN/rWu/FLf7GuOJL9
         CvMp6BwSLJHYhEHPXUXDynz5JQNmdfBTR5qA53HDoGAqKbYJo4BH1wavORcbP5TRW8vo
         GPO53PhWOtHDmjkJqYHRXXsE9FNIqgnLuoVfCxJwMf0i+HiGX6mktP/nkvk+4Q+T8XoT
         YkpNrGH3bwC736H2RSH2Jw3+IGqCCzd/iPPfm3VJp7fXyiK0ZkkUfhEuoSONFbfGwEp6
         dhu7lPtUtEKH67F1BNalCWC3bxMHPoiB4KJpeS5MjdyEx3NRnE7OPgcVRkIYdKP+0q5L
         2E4Q==
X-Gm-Message-State: AKwxytcAJ+rNyi3ZTVr6yPFgrGZKv5o0qU+sI/Wn8YtmFUheWEuoutjk
        RMA1Y9R+YOYckw1PeIh1sfU=
X-Google-Smtp-Source: ACJfBovR/eDul36dzi3T8L2sDR5/My6DdLSp7nQGSisz7ogkfvG+6vOGcoqT2026LgJMme4QlTWhhw==
X-Received: by 10.55.41.20 with SMTP id p20mr17184846qkh.5.1515443761041;
        Mon, 08 Jan 2018 12:36:01 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id q52sm8176020qtc.16.2018.01.08.12.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jan 2018 12:36:00 -0800 (PST)
Subject: Re: [RFC PATCH 01/18] docs: Multi-Pack Index (MIDX) Design Notes
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
References: <20180107181459.222909-1-dstolee@microsoft.com>
 <20180107181459.222909-2-dstolee@microsoft.com>
 <20180108113226.da265814e5c1deea1f8c404d@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4d7a1fb2-84ca-6bf9-811c-29ad21b4c5a6@gmail.com>
Date:   Mon, 8 Jan 2018 15:35:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180108113226.da265814e5c1deea1f8c404d@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/8/2018 2:32 PM, Jonathan Tan wrote:
> On Sun,  7 Jan 2018 13:14:42 -0500
> Derrick Stolee <stolee@gmail.com> wrote:
>
>> +Design Details
>> +--------------
>> +
>> +- The MIDX file refers only to packfiles in the same directory
>> +  as the MIDX file.
>> +
>> +- A special file, 'midx-head', stores the hash of the latest
>> +  MIDX file so we can load the file without performing a dirstat.
>> +  This file is especially important with incremental MIDX files,
>> +  pointing to the newest file.
> I presume that the actual MIDX files are named by hash? (You might have
> written this somewhere that I somehow missed.)
>
> Also, I notice that in the "Future Work" section, the possibility of
> multiple MIDX files is raised. Could this 'midx-head' file be allowed to
> store multiple such files? That way, we avoid a bit of file format
> churn (in that we won't need to define a new "chunk" in the future).

I hadn't considered this idea, and I like it. I'm not sure this is a 
robust solution, since isolated MIDX files don't contain information 
that they could use other MIDX files, or what order they should be in. I 
think the "order" of incremental MIDX files is important in a few ways 
(such as the "stable object order" idea).

I will revisit this idea when I come back with the incremental MIDX 
feature. For now, the only reference to "number of base MIDX files" is 
in one byte of the MIDX header. We should consider changing that byte 
for this patch.

>> +- If a packfile exists in the pack directory but is not referenced
>> +  by the MIDX file, then the packfile is loaded into the packed_git
>> +  list and Git can access the objects as usual. This behavior is
>> +  necessary since other tools could add packfiles to the pack
>> +  directory without notifying Git.
>> +
>> +- The MIDX file should be only a supplemental structure. If a
>> +  user downgrades or disables the `core.midx` config setting,
>> +  then the existing .idx and .pack files should be sufficient
>> +  to operate correctly.
> Let me try to summarize: so, at this point, there are no
> backwards-incompatible changes to the repo disk format. Unupdated code
> paths (and old versions of Git) can just read the .idx and .pack files,
> as always. Updated code paths will look at the .midx and .idx files, and
> will sort them as follows:
>   - .midx files go into a data structure
>   - .idx files not referenced by any .midx files go into the
>     existing packed_git data structure
>
> A writer can either merely write a new packfile (like old versions of
> Git) or write a packfile and update the .midx file, and everything above
> will still work. In the event that a writer deletes an existing packfile
> referenced by a .midx (for example, old versions of Git during a
> repack), we will lose the advantages of the .midx file - we will detect
> that the .midx no longer works when attempting to read an object given
> its information, but in this case, we can recover by dropping the .midx
> file and loading all the .idx files it references that still exist.
>
> As a reviewer, I think this is a very good approach, and this does make
> things easier to review (as opposed to, say, an approach where a lot of
> the code must be aware of .midx files).

Thanks! That is certainly the idea. If you know about MIDX, then you can 
benefit from it. If you do not, then you have all the same data 
available to you do to your work. Having a MIDX file will not break 
other tools (libgit2, JGit, etc.).

One thing I'd like to determine before this patch goes to v1 is how much 
we should make the other packfile-aware commands also midx-aware. My gut 
reaction right now is to have git-repack call 'git midx --clear' if 
core.midx=true and a packfile was deleted. However, this could easily be 
changed with 'git midx --clear' followed by 'git midx --write 
--update-head' if midx-head exists.

Thanks,
-Stolee
