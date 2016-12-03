Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 826D51FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 06:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751211AbcLCGN4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Dec 2016 01:13:56 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33153 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750900AbcLCGNz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2016 01:13:55 -0500
Received: by mail-pg0-f68.google.com with SMTP id 3so10001111pgd.0
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 22:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:reply-to:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=j+aj3nNQ1usTi13dLmd6srh4wM+bfkgKMb9Vo7x3Z+Q=;
        b=UvZHvNaWTlGE/f7DCbgUe/gDdAwQ++Br9yCwoV7Oi4H0obbrPlOi0KJ7GiDyVH17QY
         AieNtmDJcgjfmh8UrTrfYy4l8rrPfiYmxv/igyqBQjL+IlpVSZtoy1f+Zs1F/Hj0aiug
         1xxetxfRUxGoxHEmwpscDAt8q9tglMNN6BPlQqQoTehL5YrC2cTJE1IR+gfFfgo07slQ
         rV60vJscJE7tdAKZ/HfBdeJFz7pRjLSxJFOyn90z2ACKTTwJoyAQz/qiehvKMqP/Sw0v
         7S8liZBsJTaxkyzQ0vqiyTPdbotMgp4vUoj5OCbYulnkNGXg5WtndiC/8O7NejoibfHd
         5PDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:reply-to
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=j+aj3nNQ1usTi13dLmd6srh4wM+bfkgKMb9Vo7x3Z+Q=;
        b=kwNey32u7SOYClRkhXYGjNi8fmcZpIjl58sTxRfn0ITroCk6Y02DE+V5tsqaKa2TpT
         aAW4qrJy/LUcxXqcjA7y/xmtJfaZZxRJ2E20RJY/+T1n9Xyid7EYvzuiUDuhJRH2vwri
         D/LrWPJ+0x+xvlRuWb+pMJBWrocY25rO1kWAQKyL29J7m+2zkMsVQ3B82JkTD8fGNShy
         gbLUy6CscwtMLRy4kw0pZKZxZ0BwihIR6hq2KJHy4UpH89tzhrquoEuNkiAUrPThC6R/
         GVN4kCEJLBZZOMhkU4cMOXSNi2wHSSj/WMFIpN8/PRLUg3D5W6n/TpbplPB2JsjrKCvf
         IenA==
X-Gm-Message-State: AKaTC01j5Hx/v8jE/bDWoMFJoKp7sz/VM88z2GHCT1QDPt6CaCg84cOirrbojqCsVre8xw==
X-Received: by 10.84.151.9 with SMTP id i9mr61528609pli.67.1480745634498;
        Fri, 02 Dec 2016 22:13:54 -0800 (PST)
Received: from [192.168.1.152] ([64.106.62.45])
        by smtp.googlemail.com with ESMTPSA id f14sm11896315pfk.5.2016.12.02.22.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Dec 2016 22:13:53 -0800 (PST)
Subject: Re: [RFC PATCH 00/16] Checkout aware of Submodules!
To:     Stefan Beller <sbeller@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        jrnieder@gmail.com, mogulguy10@gmail.com, David.Turner@twosigma.com
From:   Xiaodong Qi <e2000s@gmail.com>
Reply-To: 20161115230651.23953-1-sbeller@google.com
Message-ID: <1df79f7b-83c5-91f3-7bd4-92eef200a682@gmail.com>
Date:   Fri, 2 Dec 2016 23:13:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161115230651.23953-1-sbeller@google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I found this patch on Reddit and personally support this idea to
simplify the submodule update and checkout process. I don't know how
other users handle the submodule update process, I do sometimes forget
to checkout in superprojects with submodules and get a lot of trouble in
using the submodule function. The patch seems aims to making the process
easier than before, although I am not qualified to review the code in
detail. I suggest experts in this area to review the code promptly and
work out the nuts and bolts toward the goal of this patch. Thank you for
listening.

Regards,
Xiaodong Qi

On 11/15/2016 04:06 PM, Stefan Beller wrote:
> When working with submodules, nearly anytime after checking out 
> a different state of the projects, that has submodules changed
> you'd run "git submodule update" with a current version of Git.
> 
> There are two problems with this approach:
> 
> * The "submodule update" command is dangerous as it
>   doesn't check for work that may be lost in the submodule
>   (e.g. a dangling commit).
> * you may forget to run the command as checkout is supposed
>   to do all the work for you.
> 
> Integrate updating the submodules into git checkout, with the same
> safety promises that git-checkout has, i.e. not throw away data unless
> asked to. This is done by first checking if the submodule is at the same
> sha1 as it is recorded in the superproject. If there are changes we stop
> proceeding the checkout just like it is when checking out a file that
> has local changes.
> 
> The integration happens in the code that is also used in other commands
> such that it will be easier in the future to make other commands aware
> of submodule.
> 
> This also solves d/f conflicts in case you replace a file/directory
> with a submodule or vice versa.
> 
> The patches are still a bit rough, but the overall series seems
> promising enough to me that I want to put it out here.
> 
> Any review, specifically on the design level welcome!
> 
> Thanks,
> Stefan
> 
> Stefan Beller (16):
>   submodule.h: add extern keyword to functions, break line before 80
>   submodule: modernize ok_to_remove_submodule to use argv_array
>   submodule: use absolute path for computing relative path connecting
>   update submodules: add is_submodule_populated
>   update submodules: add submodule config parsing
>   update submodules: add a config option to determine if submodules are
>     updated
>   update submodules: introduce submodule_is_interesting
>   update submodules: add depopulate_submodule
>   update submodules: add scheduling to update submodules
>   update submodules: is_submodule_checkout_safe
>   teach unpack_trees() to remove submodule contents
>   entry: write_entry to write populate submodules
>   submodule: teach unpack_trees() to update submodules
>   checkout: recurse into submodules if asked to
>   completion: add '--recurse-submodules' to checkout
>   checkout: add config option to recurse into submodules by default
> 
>  Documentation/config.txt               |   6 +
>  Documentation/git-checkout.txt         |   8 +
>  builtin/checkout.c                     |  31 ++-
>  cache.h                                |   2 +
>  contrib/completion/git-completion.bash |   2 +-
>  entry.c                                |  17 +-
>  submodule-config.c                     |  22 +++
>  submodule-config.h                     |  17 +-
>  submodule.c                            | 246 +++++++++++++++++++++--
>  submodule.h                            |  77 +++++---
>  t/lib-submodule-update.sh              |  10 +-
>  t/t2013-checkout-submodule.sh          | 344 ++++++++++++++++++++++++++++++++-
>  t/t9902-completion.sh                  |   1 +
>  unpack-trees.c                         | 103 ++++++++--
>  unpack-trees.h                         |   1 +
>  wrapper.c                              |   4 +
>  16 files changed, 806 insertions(+), 85 deletions(-)
> 
