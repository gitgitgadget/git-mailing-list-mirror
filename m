Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7564207D6
	for <e@80x24.org>; Tue,  2 May 2017 00:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750835AbdEBA0O (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 20:26:14 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36674 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750712AbdEBA0N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 20:26:13 -0400
Received: by mail-pg0-f47.google.com with SMTP id t7so51846999pgt.3
        for <git@vger.kernel.org>; Mon, 01 May 2017 17:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1s3HIgfJlZ7UR8+9gMQXXCLpd0E8mmhEXJcdVA3PwLc=;
        b=f1GyMudBWWRzaEcoyoflnS0lae4Pwc1CVlA7aAQC/gKza7KRZ0fAGBzV+y6U33j5ko
         GX9e3Wr51ao2TsVM6i0IteQcId+kCzhatd5H+RQF47A6B2ZGK3Aa8JtFhqO9DJeCHsPl
         7pH7hEbZAL7mAIWbr77CffIyLnIufWylA24W9/dBOCYYVMxazyRltnA877jHbzRy84eX
         f4WfVerXi2u/o+o/nrCn6opHUHHYiaB4znjD3Ioroch9oysXYXHa7Xul3JUPoimc5/6x
         +44sIstEJcRfwsmBRyIli7KeQvqCtCmxrA3NOnP0qQsFEYR3EJ9sJYsTl0Yqqvz6G7nF
         cq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1s3HIgfJlZ7UR8+9gMQXXCLpd0E8mmhEXJcdVA3PwLc=;
        b=mhuknOwxvxRRSJPTXpa5JTc3u1+vuvmZjhbQBZahDdRSNC3jq4L9RMO0UbAA648REm
         n2ltbnE7OtKJjd/iJQAPeUxewJeLjvDS1hTDXiUG12XL/Z4tqiomKHsd7bgxVVU4H1+g
         Y5+D958EvWd3SKivrW6Ii7jUbn064lyJ2ksCUxAH8SUHgiU0roxgN5KmPasiZSBGsidC
         aYwtGiGJo9DvMXDDee+V2mv+n96EtCLm59D2hPrFCV5C0sLPBbcqygWOoQbThjrubHGy
         HOUC8FbLACf6jrAVvsNO8U9kZjcGnyDnRD4uObOrQ9mHjSlGetvGQRQccUVbI99KwZfn
         CdNw==
X-Gm-Message-State: AN3rC/6SG1hzPBhcDvh6WawPqgND0TPRvhhl/b94KTAACiwhFc31yc25
        6ViYPpt0te3+CsQ3
X-Received: by 10.99.117.26 with SMTP id q26mr1904305pgc.21.1493684772762;
        Mon, 01 May 2017 17:26:12 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:61ee:b5d7:71fe:5285])
        by smtp.gmail.com with ESMTPSA id z5sm26702366pff.73.2017.05.01.17.26.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 17:26:11 -0700 (PDT)
Date:   Mon, 1 May 2017 17:26:10 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] credential doc: make multiple-helper behavior more
 prominent (Re: [PATCH] clone: handle empty config values in -c)
Message-ID: <20170502002610.GA154031@google.com>
References: <20170502000515.GU28740@aiede.svl.corp.google.com>
 <20170502000856.GI39135@google.com>
 <20170502002114.GV28740@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170502002114.GV28740@aiede.svl.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/01, Jonathan Nieder wrote:
> Subject: credential doc: make multiple-helper behavior more prominent
> 
> Git's configuration system works by reading multiple configuration
> files in order, from general to specific:
> 
>  - first, the system configuration /etc/gitconfig
>  - then the user's configuration (~/.gitconfig or ~/.config/git/config)
>  - then the repository configuration (.git/config)
> 
> For single-valued configuration items, the latest value wins.  For
> multi-valued configuration items, values accumulate in that order.
> 
> For example, this allows setting a credential helper globally in
> ~/.gitconfig that git will try to use in all repositories, regardless
> of whether they additionally provide another helper.  This is usually
> a nice thing --- e.g. I can install helpers to use my OS keychain and
> to cache credentials for a short period of time globally.
> 
> Sometimes people want to be able to override an inherited setting.
> For the credential.helper setting, this is done by setting the
> configuration item to empty before giving it a new value.  This is
> already documented by the documentation is hard to find ---
> git-config(1) says to look at gitcredentials(7) and the config
> reference in gitcredentials(7) doesn't mention this issue.
> 
> Move the documentation to the config reference to make it easier to
> find.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Brandon Williams wrote:
> 
> >> Noticed while trying to set credential.helper during a clone to use a
> >> specific helper without inheriting from ~/.gitconfig and
> >> /etc/gitconfig.  That is, I ran
> >>
> >> 	git clone -c credential.helper= \
> >> 		-c credential.helper=myhelper \
> >> 		https://example.com/repo
> >>
> >> intending to produce the configuration
> >>
> >> 	[credential]
> >> 		helper =
> >> 		helper = myhelper
> >>
> >> Without this patch, the 'helper =' line is not included and the
> >> credential helper from /etc/gitconfig gets used.
> >>
> >> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> >> ---
> >> Thoughts?
> >
> > After reading this I'm still a little fuzzy on why the empty helper line
> > is needed to avoid using the credential helper from /etc/gitconfig.
> 
> See "git help credentials":
> 
>        If there are multiple instances of the credential.helper configuration
>        variable, each helper will be tried in turn, and may provide a
>        username, password, or nothing. Once Git has acquired both a username
>        and a password, no more helpers will be tried.
> 
>        If credential.helper is configured to the empty string, this resets the
>        helper list to empty (so you may override a helper set by a
>        lower-priority config file by configuring the empty-string helper,
>        followed by whatever set of helpers you would like).
> 
> That's a bit obscure, though --- I didn't find it when I looked in "git
> help config".  How about this patch?
> 
> Tested using 'make -C Documentation gitcredentials.7'.
> 
>  Documentation/gitcredentials.txt | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
> index f3a75d1ce1..f970196bc1 100644
> --- a/Documentation/gitcredentials.txt
> +++ b/Documentation/gitcredentials.txt
> @@ -101,16 +101,6 @@ $ git help credential-foo
>  $ git config --global credential.helper foo
>  -------------------------------------------
>  
> -If there are multiple instances of the `credential.helper` configuration
> -variable, each helper will be tried in turn, and may provide a username,
> -password, or nothing. Once Git has acquired both a username and a
> -password, no more helpers will be tried.
> -
> -If `credential.helper` is configured to the empty string, this resets
> -the helper list to empty (so you may override a helper set by a
> -lower-priority config file by configuring the empty-string helper,
> -followed by whatever set of helpers you would like).
> -
>  
>  CREDENTIAL CONTEXTS
>  -------------------
> @@ -162,6 +152,16 @@ helper::
>  	shell (so, for example, setting this to `foo --option=bar` will execute
>  	`git credential-foo --option=bar` via the shell. See the manual of
>  	specific helpers for examples of their use.
> ++
> +If there are multiple instances of the `credential.helper` configuration
> +variable, each helper will be tried in turn, and may provide a username,
> +password, or nothing. Once Git has acquired both a username and a
> +password, no more helpers will be tried.
> ++
> +If `credential.helper` is configured to the empty string, this resets
> +the helper list to empty (so you may override a helper set by a
> +lower-priority config file by configuring the empty-string helper,
> +followed by whatever set of helpers you would like).

Thanks, this clears up the confusion.

>  
>  username::
>  
> -- 
> 2.13.0.rc1.294.g07d810a77f
> 

-- 
Brandon Williams
