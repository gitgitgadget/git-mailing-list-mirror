Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ABCB1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 23:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbcHIXP3 (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 19:15:29 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:35596 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932521AbcHIXP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 19:15:28 -0400
Received: by mail-io0-f170.google.com with SMTP id m101so26198953ioi.2
        for <git@vger.kernel.org>; Tue, 09 Aug 2016 16:15:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lPPg3HuJRrekViuSo6HbvsSM9vCyVY0YlJFMHBfw0eQ=;
        b=d9izWVUYYwusvOlASmaPcC18LZBzSJdKCU8czRSLdAw6Ptp5xR8B0qJmW9DAnZSo26
         LDa9dhk0rsI9TtZJV1fzpmPSxp6Qy6VsNk0JCMlggyEjpN9cntDGVbsqXO2Q6W6t4DRG
         2iBTBf/d6K6sOoslVWPHDDyohJsXAvDRaCDhr2Lpf/FuuSQqG9p7MwFizhx3cQjKfED6
         vBw1BCiYb2sO7TbHrwIoxQ+P5Yjcyq0uQTYjDcDaxA+6DnqjapXsYCQ1Uw8b7nX/HPtp
         2ivptdydc8RoOgUZmuVCHIRsin3JHhQBYpL6YVRRGEd7ObajhVQYOLjqbwomC6pESvMF
         l6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lPPg3HuJRrekViuSo6HbvsSM9vCyVY0YlJFMHBfw0eQ=;
        b=CQKnfy8FaEuTDvsWBa4p5/o3P5GZCHE6m7l+3VGzokxt/0pGNcEoBZsKgdmznqFFx5
         uYKumodVUE4bv1gthlQIu2ISh81lzZ9M1eRkv/nE28qGZZPQvbl6gnaqPGP+eQFDws2v
         fuK/z5C5SkwJ+hQlbwSPQ1KFcpAWAU8fwlI1E6XxHKxgvzJOWuil3yin/PqFr6d9tZgD
         n3nEf/xrYI1YCJrNvppRRVbcWSVp6siVN8HlV9lKWhwLMbzLsabG22SZqY80Ezkc7e/l
         4Gf8FG2PX548jw6E6Kc7+E5owAijL+Bl1j3MRLzBi/bLbWoNbQOO7S0utddedvvHaOCH
         ok7A==
X-Gm-Message-State: AEkoouv7R6eaOH7jbU9zi0kob5WNv6thkcDwkgxQNucMAsLi3aDPx6LDnypTiW6P5BOQzQAF8SPBgnyEsaa0vHXa
X-Received: by 10.107.144.10 with SMTP id s10mr1734488iod.165.1470784527634;
 Tue, 09 Aug 2016 16:15:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 9 Aug 2016 16:15:27 -0700 (PDT)
In-Reply-To: <CAGZ79kZbHAsxf9G-8=nz3o_zOMNFPa=kSphdo=4zLq97jycbYg@mail.gmail.com>
References: <20160809223219.17982-1-jacob.e.keller@intel.com>
 <CAGZ79kbzDhpsfpY8s=7O86_dNLA=VRkyC=8eiCqMambKvUnXmw@mail.gmail.com>
 <CA+P7+xqnALzwkgLXrP57BUtFGaxGudAEG7cmGTakP47ofFEjHQ@mail.gmail.com> <CAGZ79kZbHAsxf9G-8=nz3o_zOMNFPa=kSphdo=4zLq97jycbYg@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 9 Aug 2016 16:15:27 -0700
Message-ID: <CAGZ79kYkA=jJPHy+jqe5zVz0kM+95hxFUZPTNCKMJzbmJ7gaew@mail.gmail.com>
Subject: Re: [PATCH RFC] diff: add SUBMODULE_DIFF format to display submodule diff
To:	Jacob Keller <jacob.keller@gmail.com>
Cc:	Jacob Keller <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 4:10 PM, Stefan Beller <sbeller@google.com> wrote:

> xread does use a poll() for you so it is not active polling,
> but only reading when data is available.

s/active polling/ spinning/

>
>
>>>
>>> When not checked out, we can invoke the diff command
>>> in .git/modules/<name> as that is the git dir of the submodule,
>>> i.e. operating diff with a bare repo?
>>
>> We can actually do this every time. How would you pass that in a
>> child_process? I don't think it's "dir" but instead passing
>> "--git-dir" somehow?

I think it doesn't matter. You can still use .dir.
(That would be equivalent to `cd $GIT_DIR && git diff sha1..sha1`
which works just as well, even in the submodule case)
Alternatively you could do
    argv_array_pushf(cp.env_array, "GIT_DIR=%s", ...)

So I would drop the -C here and just use the .dir attribute.

> git -C $GIT_DIR diff --relative ${superprojects ce->name}
