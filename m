Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CB31207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 18:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933619AbcI2SoK (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 14:44:10 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34991 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932431AbcI2SoI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 14:44:08 -0400
Received: by mail-pf0-f174.google.com with SMTP id s13so31616292pfd.2
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Qaon7WWs1WtYYkSwsO+c+8MS63iEc6raOSvSOK+Deo=;
        b=oiLiR6Tht641OQ3EX7NdsjgrLk8Nuoqhe7xHev3Ku1dIGWTSV0kgJ313DSiJkZSXsv
         Sdb0X9ZX+LUwNvA1zk9B83PwxC1rjPRyfMqZx5i8YjC+VcGl54MTTaot3rECZHvyU/PQ
         ElgkkZLKMkd4iuz3x5fAVl3CC605qR4J3vCWm2c+oP9LXqU6otF70Fss4KF9AJf2MiWu
         z78q78zQogKMwqXEcAarzWjPZhqS16lcBLOhI4DP5dm1S57U+0gnkvlL6hHAMOx1sylN
         P8WI3vIPZcwqVGzLbYZzfdDKla8xAPykzba4Qhc/rhcjtHur2bMcf+hrzw8feg0G3aEY
         RvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Qaon7WWs1WtYYkSwsO+c+8MS63iEc6raOSvSOK+Deo=;
        b=JYfLPKNLwPFYeC00XvTulkIcDpnBuxDxzHrVat3dq0UhUTLgGgeMrKyczwO+sclazj
         Js8a3J9q3lya5SYc91/53xOfToj3Yoq8LJgKzKWDi+L3MIUCseza1b9oYRyWZw+sKpVK
         b4l5X8oc9Z5aVva0zq5YM0I/kg+iKFSE+HBOOn3XHk8gE0Pg3yUsH/+/VPpFwJT1zLFY
         xBSQjRHGSQPPZmySfaXmYlI5GxauveFMQjYf4al9cS1bjPnYFK+l9MFNdIAgKVk7/anH
         LkjVBm6O7U2Wz8Jw4F+TwB2VzoIlqgKZdu4/fY9dgRh/hs6Pr5qyYZmnuFNsvQf+vS/A
         hVWA==
X-Gm-Message-State: AA6/9Rn1CiSjIstMEo0DplDQTI8TNEpqHYTDClBJhArIHb7RzjGm37GvQZqjW0iSRq37CpSf
X-Received: by 10.98.147.195 with SMTP id r64mr4842413pfk.32.1475174648072;
        Thu, 29 Sep 2016 11:44:08 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:1997:1181:a6c1:f03b])
        by smtp.gmail.com with ESMTPSA id d190sm21987052pfd.59.2016.09.29.11.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Sep 2016 11:44:07 -0700 (PDT)
Date:   Thu, 29 Sep 2016 11:44:05 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com
Subject: Re: [PATCH v5 1/4] git: make super-prefix option
Message-ID: <20160929184405.GA5500@google.com>
References: <1474930003-83750-1-git-send-email-bmwill@google.com>
 <1475099443-145608-1-git-send-email-bmwill@google.com>
 <1475099443-145608-2-git-send-email-bmwill@google.com>
 <20160929183940.vgac7by74gmglaf2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160929183940.vgac7by74gmglaf2@sigill.intra.peff.net>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/29, Jeff King wrote:
> On Wed, Sep 28, 2016 at 02:50:40PM -0700, Brandon Williams wrote:
> 
> > Add a super-prefix environment variable 'GIT_INTERNAL_SUPER_PREFIX'
> > which can be used to specify a path from above a repository down to its
> > root.  The immediate use of this option is by commands which have a
> > --recurse-submodule option in order to give context to submodules about
> > how they were invoked.  This option is currently only allowed for
> > builtins which support a super-prefix.
> 
> What about non-builtins?
> 
> E.g., what should
> 
>   git --super-prefix=foo bar
> 
> do? Should the externals and scripts check the presence of
> GIT_INTERNAL_SUPER_PREFIX and barf if it is set? Most scripts would
> probably notice eventually when calling some other builtin that doesn't
> support SUPER_PREFIX, but it seems hacky to count on that.
> 
> There's also the question of 3rd-party programs. If we want to be
> conservative, I think you'd want to just always bail in
> execv_dashed_external() if --super-prefix is in use. That doesn't give
> an option for scripts to say "hey, I support this", but we can perhaps
> worry about loosening later.
> 
> -Peff

That makes sense.

-- 
Brandon Williams
