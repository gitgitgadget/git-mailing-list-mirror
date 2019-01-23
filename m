Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9AC41F453
	for <e@80x24.org>; Wed, 23 Jan 2019 20:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfAWUWB (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 15:22:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37424 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfAWUWB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 15:22:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id s12so4025952wrt.4
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 12:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7c+2vtMNY1ZrX5jbg21x62YY3gfkmc6s70DOMVyhd74=;
        b=iloi7qcbHW8gifCYKQuWuNDA+LbAWQ5RJyUq8J8IJfnobgo6kPL6p7WBlt0VagWeal
         +vwD8FtbO78fr1DeBY0061dYgt4H0uLbNa8KN7WaK7a9JZGhz5g8B4xifm2qfUz5ZGsc
         +5EjyVfmRNeXXP8BRLBUGoDIfupvlSuh3NuZvOTn/qL74U2Q2YpCGXMoMjOEjCQPsJ5C
         m2k8ZYPMMb2DJoEqOgCsX+xoz1EUzlj5Nj+Pw2WySiN90Sgt0Vf4fejbeM6qoseXgjlr
         Yc1Q/VTfIprETwVXg9j5Byd61fYw3zmnkFMx1F7GTWaPjdpAqq1vCh9iWhuhGs1ltF0A
         JpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7c+2vtMNY1ZrX5jbg21x62YY3gfkmc6s70DOMVyhd74=;
        b=Ud7XWJQujxzQVqSnYinE3N94T4GEsd61OXYP+81WONAharf7gzws6Cw3lZG0/I6roP
         958LvOTqkf6XSfKDYCKhYtsgEILWyAQwT9ckx24HE0rsi04wltJqTS3a22c2xVISzo3W
         MIBKxCm8jHmC53kCocJ3xn9suNkoDfuwFcMGjoX0HHBZVLYWWCEAUFz7kFUaBxm3H4T7
         C5m/B9B+DyOw5qkU3KHKgAs7FqK+/iYZaQLQHKztwQW1QL5m1Y35Vct2Ek4ecZiy4e5D
         xcr41w2vcWTMWaiTo1rK54M4Z7MSAk/BkuX8GABvDfcEXAp6iXc/6VsWHStLdnWUaKVX
         HHHQ==
X-Gm-Message-State: AJcUukdqkiO1RLSr8kfZLTj/wGnfOf8gd1G1l/uVcDTgZNxt6sAOGNRE
        SaBuh0+3T/KZ/vROrPYNyvw=
X-Google-Smtp-Source: ALg8bN7dZ5T9wU8alqORW2aaxoBgqCyjD6OIcdN+ocRdx6OdAZc9f5HS1QHZb3SM1goE18sKxxXRBA==
X-Received: by 2002:adf:fe11:: with SMTP id n17mr4127859wrr.329.1548274919325;
        Wed, 23 Jan 2019 12:21:59 -0800 (PST)
Received: from localhost ([2.24.105.63])
        by smtp.gmail.com with ESMTPSA id g67sm121124151wmd.38.2019.01.23.12.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 12:21:57 -0800 (PST)
Date:   Wed, 23 Jan 2019 20:21:56 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 7/8] checkout: introduce --{,no-}overlay option
Message-ID: <20190123202156.GA11293@hank.intra.tgummerer.com>
References: <20181220134820.21810-1-t.gummerer@gmail.com>
 <20190108215225.3077-1-t.gummerer@gmail.com>
 <20190108215225.3077-8-t.gummerer@gmail.com>
 <20190122235313.GA199923@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122235313.GA199923@google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/22, Jonathan Nieder wrote:
> Hi,
> 
> Thomas Gummerer wrote:
> 
> > Currently 'git checkout' is defined as an overlay operation, which
> > means that if in 'git checkout <tree-ish> -- [<pathspec>]' we have an
> > entry in the index that matches <pathspec>, but that doesn't exist in
> > <tree-ish>, that entry will not be removed from the index or the
> > working tree.
> >
> > Introduce a new --{,no-}overlay option, which allows using 'git
> > checkout' in non-overlay mode, thus removing files from the working
> > tree if they do not exist in <tree-ish> but match <pathspec>.
> 
> This patch just hit my workstation.  Some initial thoughts:
> 
> I had no idea what --overlay would mean and am still not clear on it.
> Is this analogous to "git add --ignore-removal"?  If so, can we just
> call it --ignore-removal?

Yes, it seems like they are very similar.  I'm happy to rename the
option.  The topic seems to have made it to 'next' already, so I'll
submit the patches on top, unless reverting the topic out of next and
replacing it is preferred?

> Thank you thank you thank you for working on this.  I run into this
> all the time and am super excited about the "default to
> --no-ignore-removal" future.

:)

> I'm nervous about the config with no associated warning or plan for
> phasing it out.  It means that scripts using "git checkout" don't
> get a consistent behavior unless they explicitly pass this option,
> which didn't exist in older versions of Git --- in other words,
> scripts have no real good option.  Can we plan a transition to
> making --no-ignore-removal the default, in multiple steps?  For
> example:

As Junio mentioned, the plan was to just have this mode default when
we introduce the new checkout-paths command.

As checkout is a porcelain command, I had hoped it would be okay to
also have this as a configuration option, for the time before
'checkout-paths' exists and while I'm getting used to actually typing
'checkout-paths' instead of 'checkout'.  However I get that there may
be scripts that are using git checkout, and expect the previous
behaviour, so I'm also okay with dropping the config option for now.

If we still want to make this the default even after 'checkout-paths'
exists, the plan you outline below sounds good to me, though maybe we
can make the "flip the default" step once we decide to release git
3.0.

>  1. First introduce the commandline option, as in this series
> 
>  2. Next, change the default to warn whenever the difference would
>     matter, printing a hint about how to configure to explicitly
>     request the old or new behavior.
> 
>  3. After a release or two has passed so people get a chance
>     to update their scripts, flip the default.
> 
>  4. Finally, remove the warning.
> 
>  5. Warn whenver the difference would matter when a user has
>     requested the old behavior through config, in preparation
>     for removing the config.
> 
>  6. Remove the config.
> 
> Steps 5 and 6 are optional but might be nice.
> 
> What do you think?
> 
> Thanks,
> Jonathan
