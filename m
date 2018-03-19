Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13F1D1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 21:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934614AbeCSVsh (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 17:48:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50256 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933105AbeCSVse (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 17:48:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id f19so5273767wmc.0
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 14:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dL1BkEZ3GWlo1id+iB1vPlAW01v7ssgKDnNtrU/UEOg=;
        b=R/1wrCxi5O1LOyZpylcQ3RkqalbKZ1b1aTIw2JrlKf7w9l++9x3kOmp1GaW11MLmvc
         h8K7CgCeXtX+RsqWhlRpOOMwRkfovmwzNKQ9z09ckAbRlJhnZ/BXYnbCRKMUt5izq6FJ
         tbhjdgfBN2b8ZkoNXmbv7g8TqTA09m/sBx/YIBFIF7NQ3wpww4JOxXsxV/K5fpXseLpk
         r63G+gBINeoZaR1ZMhbe5XBsgQ3OlbCgYa07ogwujLhvdsnC7InTaydjs82K9UK5cypU
         gV3alPi8vViJk+8739HeHJOqCIsSQlwAZH5EL8TIbsWye1zH5jwm1/mcNFn3RnCEFy+6
         wljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dL1BkEZ3GWlo1id+iB1vPlAW01v7ssgKDnNtrU/UEOg=;
        b=LYISfCY1CnLE1nVCF2YT4AenUPA/eb5plC+XobLjSAlpA2I1ytbfeBQthJDAlKl2Q/
         T/kV0l0GrLtmoCMht+ealH17S3Lgn1r9kL7tSnM0SaHmyIquPuGSKBA+JHeBbeI7MXXp
         2ccwx4JGyAzEwXs2XsX3K+9LxErTHz7yU5KjtxSYJypH9KFf2IUaKmxIgObLuKxRkc3j
         fz0ex8dmp1vfvXiwHjQhB6Inp7E44aS4etht7NMVjgcqo3iiW9Kpy7hK8NsZzydB7V5p
         BwuizvL3fR2feKrL9W2tVrbqVAQBX30V+RYUmPIcKJmaLD72mhSmP0gFLZD+AB69/Ehw
         o7pQ==
X-Gm-Message-State: AElRT7E5o68qhPQWsBRjNo4TdIvrQxGtlV9fjHGgeLZo415UosROhs2L
        sVXCL6oVJV0zPOfQl1NaQfs=
X-Google-Smtp-Source: AG47ELtFhxv2nJXxb4hrPIE4y45u7OJhDqhNhu7rPXP35RjRom/7FOMR5ytBX/cCgJWX+37Hu8elFw==
X-Received: by 10.28.163.5 with SMTP id m5mr222547wme.33.1521496113174;
        Mon, 19 Mar 2018 14:48:33 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 59sm212129wro.35.2018.03.19.14.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 14:48:31 -0700 (PDT)
Date:   Mon, 19 Mar 2018 21:51:50 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Marc Strapetz <marc.strapetz@syntevo.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] stash push -u -- <pathspec> fixes
Message-ID: <20180319215150.GF2224@hank>
References: <20180314214642.22185-1-t.gummerer@gmail.com>
 <20180316204306.862-1-t.gummerer@gmail.com>
 <bc69c1f4-7098-1bbf-e69b-97808c4d8779@syntevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc69c1f4-7098-1bbf-e69b-97808c4d8779@syntevo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/19, Marc Strapetz wrote:
> On 16.03.2018 21:43, Thomas Gummerer wrote:
> >Thanks Marc for catching the regression I almost introduced and Junio
> >for the review of the second patch.  Here's a re-roll that should fix
> >the issues of v2.
> 
> Thanks, existing issues are fixed, but cleanup of the stashed files seems to
> not work properly when stashing a mixture of tracked and untracked files:

Thanks for the continued testing, and sorry I just can't seem to get
this right :/  The problem here was that I misunderstood what 'git
ls-files --error-unmatch' does without testing it myself.  I'll send
v5 in a bit, which will hopefully finally fix all the cases.

> $ git init
> $ touch file1
> $ touch file2
> $ git add file1 file2
> $ git commit -m "initial import"
> $ echo "a" > file1
> $ echo "b" > file2
> $ touch file3
> $ git status --porcelain
>  M file1
>  M file2
> ?? file3
> $ git stash push -u -- file1 file3
> Saved working directory and index state WIP on master: 48fb140 initial
> import
> $ git status --porcelain
>  M file1
>  M file2
> 
> file1 and file3 are properly stashed, but file1 still remains modified in
> the working tree. When instead stashing file1 and file2, results are fine:
> 
> $ git stash push -u -- file1 file2
> Saved working directory and index state WIP on master: 48fb140 initial
> import
> $ git status
> On branch master
> nothing to commit, working tree clean
> 
> -Marc
> 
> 
