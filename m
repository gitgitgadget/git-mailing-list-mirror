Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48FEF1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeHKAei (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:34:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36209 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeHKAei (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:34:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id h12-v6so4986119pgs.3
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zr68NBYbieAROlYw56GgAH2bMlzozFuAyQe/APSTqrA=;
        b=AMWEFF3VKgKs3CadT+FHwpLvG/KlghG2W/yI6UV62GMToQh82t4JMjlPa4QwE1yUhp
         p6py+WvaShFGGy/YJLke95bsQAf2e0BAeKEtxSno+a4YpE+cT4IlZy4B+CXfrpqO8A8Y
         4D7V7Khv7NheQRj3ZtysUWHWpfxVHO/9W7QR6Uwjk/dK4F5AqlEjxkw0TGIDwkAvrevc
         S2aHWi3SrBUd7ou15E3s4tnH6sGi0OVVUcOXJFAQDDxE/rrzhHISt8HZe6BUPUVqRmad
         WYoEVeAE7O8kr7Wgw2yJHxIyLnCKIjNVaThhdDILs8G6kYU6vr7MJhm83n2ynEJAJdkN
         fehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zr68NBYbieAROlYw56GgAH2bMlzozFuAyQe/APSTqrA=;
        b=SJp9Qrs+JKHfkt4Rmdk2TpIELZ+aAuBOFQQPSOUTb6xC5S+Fghw0lITTzzi85kAUOO
         ltWEEig1W5oug6vhU3VA0m2HOcfovydUkABTjUP9H1ZEd04iorAfv5djEHbIcuEaNi9u
         w9i4NSTNs2xq//fe22hBiGbBex39XID6gy1JyNAI7VK2Z4tqT9TXgAjUj0Dg+ruoKjnP
         yP1B0Ov/uZgjd/japbw4IWGaOTaMbVS48CfV6P45W+Y2ybT6agq1iajfxanagK8+4gRv
         VXN5IVr8SoPZV8hDtUpB9xGLXoThP2i+9PADEacDRryNGq0vaczm89zf6sOJvdrxPVuj
         Nrzw==
X-Gm-Message-State: AOUpUlGK2xuhZ0W1pDy/eVumRCZS/m0i2t4f4EqFyBNS6GevKHo7JFDa
        eRXbZgtIGpEE3MfXPVrzwVV+mzvPkII=
X-Google-Smtp-Source: AA+uWPxAZecq75rmQg8m8kZSrlEeprI5bLJc26k4pJVHUmaB3ruR/dMhizlYPsGz4p8Y+e0Hs6nE8A==
X-Received: by 2002:a63:ef10:: with SMTP id u16-v6mr8162353pgh.269.1533938573260;
        Fri, 10 Aug 2018 15:02:53 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id t15-v6sm18876577pfa.158.2018.08.10.15.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 15:02:52 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:02:51 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] submodule--helper: replace
 connect-gitdir-workingtree by ensure-core-worktree
Message-ID: <20180810220251.GC211322@google.com>
References: <20180803222322.261813-1-sbeller@google.com>
 <20180803222322.261813-7-sbeller@google.com>
 <20180810214703.GB211322@google.com>
 <CAGZ79kb+QyCuBw+e8ShU3Ts9GL+bhzb=i2F+5B0jb9eWk5Sj1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kb+QyCuBw+e8ShU3Ts9GL+bhzb=i2F+5B0jb9eWk5Sj1w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/10, Stefan Beller wrote:
> > > +             cfg_file = xstrfmt("%s/config", subrepo.gitdir);
> >
> > As I mentioned here:
> > https://public-inbox.org/git/20180807230637.247200-1-bmwill@google.com/T/#t
> >
> > This lines should probably be more like:
> >
> >   cfg_file = repo_git_path(&subrepo, "config");
> >
> 
> Why? You did not mention the benefits for writing it this way
> here or on the reference. Care to elaborate?

Its more future proof especially because we have the difference bettwen
commondir and gitdir for worktrees.  Using the "repo_git_path" function
handles path rewritting when using worktrees.  Here (when working with
worktrees) "subrepo.gitdir" refers to the worktree specific gitdir while
"subrepo.commondir" refers to the global common gitdir where the
repository config actually lives.

-- 
Brandon Williams
