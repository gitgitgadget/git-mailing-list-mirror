Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67C811F404
	for <e@80x24.org>; Fri, 16 Mar 2018 20:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752787AbeCPUJl (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 16:09:41 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34528 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751944AbeCPUJj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 16:09:39 -0400
Received: by mail-wm0-f67.google.com with SMTP id a20so4183711wmd.1
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 13:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O69L7zWUQ5PSrpyNvcMWy3umFoWV3KznmJkTVMgjvRk=;
        b=bLpVyrcXbY+2r/j/HrnftMdThI+FoDsZaC1io0CCuyOM4GvBihagFRcm7dI86AVUV2
         5zweBPUiU5A49hcK1QTQFrzlpHuBMwbsni6FBTG+EScHuUBZNb0eAni8UTEsFXkWUEhP
         dxzl67S4okDr7qWUok4k/JR/3lpTO/yibbO9/aX0xJmFGAQ4i+9eIvtWEn9B/RJqVgYn
         oiS4Yv3CF1RYF/o9QnnmpYQl54HBugTjTkXIIxa8qGavneXWO9kSfVVEs/I1rqYSZGFv
         xW7aGlkLE6hHh/aN4UNWeFRHZRclWoVYidNqTulee0LWmkNPRvB5t3TiGOsdce/Q0zP1
         f0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O69L7zWUQ5PSrpyNvcMWy3umFoWV3KznmJkTVMgjvRk=;
        b=pBFRMCGto/ux/LH4GmL3/mChvZJl5YeU5n5q8hQsbBwdPQjRAHm6Uzuvr5FK4Sg+kS
         tnyBwUo6CR5Cr3WINlQzXudErOFftoWHfAC5BsbnXqadg8QCo8hhdoBSg0EMRjpDATes
         P3DyNd8faVIIWJ71ikTuJqmZzrwL+DnU3EcWONKLXHUlzwJQTMX3TE40AZwE+jO3Wvlv
         0QSuIMni0/xOZIrgR8AkZVJEucB0Q4Lh1qudxzGNvELDpBYmOkGiexwpAd3UmazLK9F1
         hicxYsds8lYurFtkNwDL3hcZoOfoDCIgok5zY6RmXl/EuDhL/6E9GloVp22FYKlRVik+
         DJBQ==
X-Gm-Message-State: AElRT7Hh7Aj+F/ZmzGxjfbbOWQNv6o0L8tU5t7wx5T4jF0lKuA+PN+Hb
        o3AH4Sb8eWwYJvFJm6sOcxk=
X-Google-Smtp-Source: AG47ELsW9W+4Y71QsqhimRA3CL0SAZlzKtrcxQmcRWlH4QI+jnV7dtpwujnlv9hM4h2lbAwlknD5ug==
X-Received: by 10.28.18.2 with SMTP id 2mr2612108wms.108.1521230978776;
        Fri, 16 Mar 2018 13:09:38 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id i12sm8225992wrc.28.2018.03.16.13.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 13:09:37 -0700 (PDT)
Date:   Fri, 16 Mar 2018 20:12:54 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Marc Strapetz <marc.strapetz@syntevo.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] stash push: avoid printing errors
Message-ID: <20180316201254.GB2224@hank>
References: <20180310111215.GA14732@hank>
 <20180314214642.22185-1-t.gummerer@gmail.com>
 <d9588594-10fd-1080-abda-aeeb12948b2c@syntevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9588594-10fd-1080-abda-aeeb12948b2c@syntevo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/15, Marc Strapetz wrote:
> On 14.03.2018 22:46, Thomas Gummerer wrote:
> >Currently 'git stash push -u -- <pathspec>' prints the following errors
> >if <pathspec> only matches untracked files:
> >
> >     fatal: pathspec 'untracked' did not match any files
> >     error: unrecognized input
> >
> >This is because we first clean up the untracked files using 'git clean
> ><pathspec>', and then use a command chain involving 'git add -u
> ><pathspec>' and 'git apply' to clear the changes to files that are in
> >the index and were stashed.
> >
> >As the <pathspec> only includes untracked files that were already
> >removed by 'git clean', the 'git add' call will barf, and so will 'git
> >apply', as there are no changes that need to be applied.
> >
> >Fix this by making sure to only call this command chain if there are
> >still files that match <pathspec> after the call to 'git clean'.
> >
> >Reported-by: Marc Strapetz <marc.strapetz@syntevo.com>
> >Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> >---
> >
> >>Either way I'll try to address this as soon as I can get some
> >>time to look at it.
> >
> >I finally got around to do this.  The fix (in the second patch) turns
> >out to be fairly simple, I just forgot to pass the pathspec along to
> >one function whene originally introducing the pathspec feature in git
> >stash push (more explanation in the commit message for the patch
> >itself).  Thanks Marc for reporting the two breakages!
> 
> Thanks, I confirm that both issues are resolved. There is another issue now
> which seems to be a regression. When *successfully* stashing an untracked
> file, local modifications of other files are cleared, too.
> 
> $ git init
> $ touch file1
> $ git add file1
> $ git commit -m "initial import"
> $ echo "a" > file1
> $ touch file2
> $ git status --porcelain
>  M file1
> ?? file2
> $ git stash push -u -- file2
> Saved working directory and index state WIP on master: 25352d7 initial
> import
> $ git status
> On branch master
> nothing to commit, working tree clean
> 
> Hence, by stashing just "file2" the local modification of "file1" became
> reset.

Ah yes, this is indeed a regression, thanks for catching it.  I'll fix
it in the re-roll and add another test for this case.  Sorry about the
false starts here :/

> -Marc
> 
> 
> 
> 
