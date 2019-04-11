Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A01C20248
	for <e@80x24.org>; Thu, 11 Apr 2019 22:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfDKWFh (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 18:05:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37204 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKWFh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 18:05:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so8488781wmf.2
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 15:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DfWrhjRVVhPTQWkHRobO4p4PrlgbZidW9TLd5VHJBMw=;
        b=V8o2VzbquYtyrNvAaMTZknGRJukLHxq1pcS8Y0KgKGZCKp2y0LMw78ZCFDQvwWk66V
         ilJ/b1f4vh/nH3jns4oXVlBz54qjJ/UA414oomIRRJayUx7cuODzlT7+LoW/njwCOYe1
         KKMN9mI0XU3+MEltHbhPdUC+WezNwi4vo40KPl/yZj6L7t2ihw/zFpStSssO4clqc667
         N+dMrZpJ2HPiUA349reXIX7YOpe7uogNUa6c+aKfr9/a9Y1+871lKOoKFVvOqNsHSJcp
         yF/1H6T9iYeqgE6+bU+PlUEGH02g4pVIsBLwuAUG1YkAPv5sKA4bOmZ0wqeqNp4N/S2I
         1Lxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DfWrhjRVVhPTQWkHRobO4p4PrlgbZidW9TLd5VHJBMw=;
        b=awDqLCzUH5/RrSDxZ3uFVarRP9xAWTucMHQUJSoDuSU6JYRiUYwDd1k8SavXszspKV
         UvfFccrFG1JuFQv8a4Rktl4UhJOAznfFCaOPSPRk/3UChwa5qfjVB/opjyEx1Jvel/Ts
         JX7N5j5WF9w2Ir4+AV51BrN2VdA+o9vzyoTr5GB4xEITqNlwqj1/T/vVjXX3hjPNpOIK
         OsPwLxYYr2ln2nih/xkg6SgycRTuWmJvzsPRez+uZf5p0+V9uhHHIJLSX+9kRaMvDmYl
         Dkp1d25fbnY0Tn94Gp1rap/6iPFLWXJz3ofZNSKVQvTXQ0X7NCmoxWpmzUTIqt+55vM3
         hhzw==
X-Gm-Message-State: APjAAAUYmVw5vJZs2nLAYKmQzHtpRHNDr7OEj/cNZnO1DRxBn5S/zgPu
        GB5XfZCRbenYbjXNTi5Bg+U=
X-Google-Smtp-Source: APXvYqxRaNmcevAi8IJrWTrr1w3ohjnGgicNoHzf5urED9r6v3ZNSgg7Fzulqtj1gHHCLs81eiV1uw==
X-Received: by 2002:a7b:cf2c:: with SMTP id m12mr8484013wmg.21.1555020335378;
        Thu, 11 Apr 2019 15:05:35 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id 10sm5561437wmd.23.2019.04.11.15.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 15:05:33 -0700 (PDT)
Date:   Thu, 11 Apr 2019 23:05:32 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: incorrect range-diff output?
Message-ID: <20190411220532.GG32487@hank.intra.tgummerer.com>
References: <20190411111729.GB5620@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411111729.GB5620@ash>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/11, Duy Nguyen wrote:
> Try
> 
>     git range-diff from...to
> 
> with those two branches from https://gitlab.com/pclouds/git.git. The
> interesting part is this
> 
>       diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
>       --- a/Documentation/gitcli.txt
>     @@ -120,10 +111,11 @@
>         * linkgit:git-commit[1] to advance the current branch.
>       
>      -  * linkgit:git-reset[1] and linkgit:git-checkout[1] (with
>     -+  * linkgit:git-reset[1] and linkgit:git-restore[1] (with
>     -     pathname parameters) to undo changes.
>     +-    pathname parameters) to undo changes.
>     ++  * linkgit:git-restore[1] to undo changes.
>       
>         * linkgit:git-merge[1] to merge between local branches.
>     + 
> 
> This particular hunk comes from giteveryday.txt, not gitcli.txt. And
> the b/Documentation/gitcli.txt line is also missing.

I think the output here is technically correct, even though it is very
misleading.  range-diff doesn't currently show the filenames of the
diff that changed, which makes this a bit hard to read.  To understand
what's happening here, let's have a look at the parts of the commits
where this happens:

In 66370c3f63 we have:

    diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
    index 837707a8fd..c38bc54439 100644
    --- a/Documentation/git-revert.txt
    +++ b/Documentation/git-revert.txt
    @@ -26,8 +26,8 @@ effect of some earlier commits (often only a faulty one).  If you want to
     throw away all uncommitted changes in your working directory, you
     should see linkgit:git-reset[1], particularly the `--hard` option.  If
     you want to extract specific files as they were in another commit, you
    -should see linkgit:git-checkout[1], specifically the `git checkout
    -<commit> -- <filename>` syntax.  Take care with these alternatives as
    +should see linkgit:git-restore[1], specifically the `--source`
    +option  Take care with these alternatives as
     both will discard uncommitted changes in your working directory.
 
     OPTIONS
    diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
    index 592e06d839..e2a9674297 100644
    --- a/Documentation/gitcli.txt
    +++ b/Documentation/gitcli.txt

While in 183c6c9390 we have:

    diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
    index 018ecf49d3..9aadc36881 100644
    --- a/Documentation/git-revert.txt
    +++ b/Documentation/git-revert.txt
    @@ -26,8 +26,8 @@ effect of some earlier commits (often only a faulty one).  If you want to
     throw away all uncommitted changes in your working directory, you
     should see linkgit:git-reset[1], particularly the `--hard` option.  If
     you want to extract specific files as they were in another commit, you
    -should see linkgit:git-checkout[1], specifically the `git checkout
    -<commit> -- <filename>` syntax.  Take care with these alternatives as
    +should see linkgit:git-restore[1], specifically the `--source`
    +option. Take care with these alternatives as
     both will discard uncommitted changes in your working directory.
     
     See "Reset, restore and revert" in linkgit:git[1] for the differences
    diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
    index 592e06d839..e2a9674297 100644
    --- a/Documentation/gitcli.txt
    +++ b/Documentation/gitcli.txt


So adding a bit more context to the bits you posted above we see:

    @@ -92,10 +83,10 @@
     -should see linkgit:git-checkout[1], specifically the `git checkout
     -<commit> -- <filename>` syntax.  Take care with these alternatives as
     +should see linkgit:git-restore[1], specifically the `--source`
    -+option  Take care with these alternatives as
    ++option. Take care with these alternatives as
      both will discard uncommitted changes in your working directory.
      
    - OPTIONS
    + See "Reset, restore and revert" in linkgit:git[1] for the differences
     
      diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
      --- a/Documentation/gitcli.txt
    @@ -120,10 +111,11 @@
        * linkgit:git-commit[1] to advance the current branch.
      
     -  * linkgit:git-reset[1] and linkgit:git-checkout[1] (with
    -+  * linkgit:git-reset[1] and linkgit:git-restore[1] (with
    -     pathname parameters) to undo changes.
    +-    pathname parameters) to undo changes.
    ++  * linkgit:git-restore[1] to undo changes.
      
        * linkgit:git-merge[1] to merge between local branches.
    + 
     @@
      ------------
      $ git switch -c alsa-audio <1>

So the Documentation/gitcli.txt bit is actually context on the first
diff, and everything after '@@ -120,10 +111,11 @@' is completely
unrelated to that.

I'm not sure what the right solution for this is.  I think one thing
I'd like range-diff to do is to add the filename, or some context
(e.g. is this part of the commit message etc.) to the @@ line (not
sure what that is called?).

Another thing that would help in this case would be to just remove the
diff header if it is only in the context of a diff, but not actually
changed.  We can't just remove it outright, as it could be useful in
some cases, e.g. when a file has just been re-named.

So all that said, while this is technically correct, I think it's
misleading enough that we should try to fix it.  Maybe I can find some
time over the weekend to tackle this, if nobody else gets to it first.

> I'm in the middle of some other things (and don't know range-diff that
> well) so I'm just dropping a bug report here.
> 
> I've tried all 'master', 'next' and 'pu'. Same result. Tried
> --no-pager too in case the pager ate something up.
> --
> Duy
