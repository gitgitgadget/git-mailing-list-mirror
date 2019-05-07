Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BF131F45F
	for <e@80x24.org>; Tue,  7 May 2019 02:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfEGCVf (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 22:21:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35322 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEGCVf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 22:21:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id t87so7202468pfa.2
        for <git@vger.kernel.org>; Mon, 06 May 2019 19:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nvePcLGd4fDMwa4Ko6MzJ0GJHUP+4VKHnN9wn4NTPx8=;
        b=S6h9aErNrcdfo9v4weQmLoB9Sv6NKdHC1GOjJ5BRJcvxwsOOtNL2i12w0mVfJHyLjD
         3Wo7d3quz1xP8H3ys+j4y2Oi3HmxioqKeJlQgT8gDwm5x6LJUka7Doa7NtzU5Jc7xX52
         MKHrxrWlsSXKhNP5979jQaj3pEPhRSdWReJ6DJ5Ku2EmT/dnKAqKxixqBD8y0ABSTOxt
         bFhSPatfGQeRhA8abJvuv1M3jSL2zqkneg8gofB67cq75m0+rLE9FHue47ZhKYCDGKFr
         bZjcHVccNFkmTQ93Os3qBPzsEwIJdWSIOGFbyIZB6gfFOZmt+/dBSezqp8nbszp2yJVn
         C7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nvePcLGd4fDMwa4Ko6MzJ0GJHUP+4VKHnN9wn4NTPx8=;
        b=bl85d8KKpxHsZeXBlcXd/1YcJFM4Lknc78IElPnWNtHuYHnyYt8D4ALNqjSZ3fNBws
         60sE789FcAb+czfyh4RYfWfPu6uZ9gUtcY3EsC0aXsRcfSOFN1IxeNAgjDkO08dwGwTG
         tiFU6lpBMVLMBzioiUq/+7rJtfy9Mwvcr3YdJN5vnfsofW5xMiOdwoLK8/aixmqgK7Kh
         aSr0uiBJNVTyb5ewCNsOnlitqqXtc0MDVGCFTCNwSbfGDuCS5uxCzCRnRRys7RwUVNRj
         UHnetKNF6ZNi9tNT810RcFYEFA7dIHYKqEcugF2hMHwW9ctc5LZSHK0XOjDg9JX6p/Qh
         9gdg==
X-Gm-Message-State: APjAAAWTDSks5we/lMX5u5Dm1QFxErHQ04+lZb1TIILJP9N7qxvqnaJx
        d1u8CtVKOPnoHcfoyY7L9fKvcg==
X-Google-Smtp-Source: APXvYqwaMVQXAbXcZhlMyqgBw4VM9Xh4n4v06Z1SBnLp/Ivmxc5B6X/BTdXodVwANH8tDj+AHNVXrA==
X-Received: by 2002:a63:5c24:: with SMTP id q36mr36496270pgb.314.1557195693329;
        Mon, 06 May 2019 19:21:33 -0700 (PDT)
Received: from google.com ([2620:0:100e:903:92a9:af1c:1897:8241])
        by smtp.gmail.com with ESMTPSA id z7sm13966379pgh.81.2019.05.06.19.21.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 19:21:32 -0700 (PDT)
Date:   Mon, 6 May 2019 19:21:27 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        jacob.keller@gmail.com, newren@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v3 00/16] Add new command 'restore'
Message-ID: <20190507022127.GA220818@google.com>
References: <20190411131218.19195-1-pclouds@gmail.com>
 <20190425094600.15673-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190425094600.15673-1-pclouds@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hiya,

On Thu, Apr 25, 2019 at 04:45:44PM +0700, Nguyễn Thái Ngọc Duy wrote:
> v3 changes are really small
> 
> - gitcli.txt is updated to mention the --staged/--worktree pair, in
>   comparison to --cached/--index which is also mention there.
> 
> - The patch 'rm --staged' is dropped. It could come back. But if it
>   does, it should be in a series where commands that take
>   --cached/--index will now take both --staged/--worktree. Those are
>   'rm', 'apply', 'check-attr', 'grep', 'diff' and maybe 'ls-files'.
>   
>   In other words we support --staged/--worktree everywhere while
>   --cached/--index still remains because of muscle memory. This is
>   of course only a good move if --staged/--worktree is much better
>   than --cached/--index.
> 
> - Since there's a chance this series may end up in 'master' and get
>   released, and I'm still worried that I screwed up somewhere, the last
>   patch declares the two commands experimental for maybe one or two
>   release cycles.
>   
>   If the reception is good, we revert that patch. If something
>   horrible is found, we can still change the default behavior without
>   anybody yelling at us. Or worst case scenario, we remove both
>   commands and declare a failed experiment.
> 
> PS. the intent-to-add support is still not in. But it should be in
> before the experimental status is removed.

I've got a usability comment, as we're giving restore a try within
Google for now. I found myself in a situation where I had accidentally
staged all my changes to tracked files (I think resulting from a stash
pop which generated a merge conflict?) and didn't see a good way to
unstage everything using restore.

I tried out `git restore --staged *` and it tried to restore every build
artifact in my working tree, all of which should be ignored, made a lot of
noisy errors, and left me with my changes still staged.

Then, figuring that I only had a few files, I thought I'd type them
each, with the exception of a .c/.h pair:

g restore --staged builtin/log.c builtin/walken.c revision.*

Because I had build artifacts present, this vomited while trying to
unstage revision.o, and again left me with all my changes still staged.
revision.o is validly ignored:

$ g check-ignore revision.o                               
revision.o

Finally explicitly naming each file which I needed to restore worked,
but I have very little interest in doing this for more than a handful of
files, especially since the output of `git status` is not easy to paste
into the command line (due to the "modified:" etc marker).

I was definitely still able to make it do what I wanted with `git reset
HEAD` but thought you may be interested. It'd be cool to have a hint
which advises how you can unstage everything, or else to pay attention
to the gitignore and not try to unstage those files, or else to have a
command to unstage everything. (I looked for one by trying `git restore
--staged -a` but that doesn't exist :) )

Thanks!
Emily
