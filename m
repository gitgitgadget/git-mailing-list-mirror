Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61FDB20951
	for <e@80x24.org>; Fri, 17 Mar 2017 19:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbdCQTSU (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 15:18:20 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35746 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbdCQTSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 15:18:16 -0400
Received: by mail-pf0-f170.google.com with SMTP id x63so35982097pfx.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 12:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RS6mknEQTv0B+SDtC7l0sxVbFfuhQYY4PR8F206MJTQ=;
        b=DZ9nmnTEIxeH/xeXrOxcvIInu58HPKQENvvreqQptP20USe9BQbdIvu+IfWVzlIXpx
         2tR8LO+9mRQJOhmk0PN/h9nFYCOnWOqZRGi+AiNj2W6C05diJgzG/XzmtTG+DP/h+IiJ
         DFrUngMsu/R23aQ2n5j8Vw8OGel/hSxkl5o7ehMWp3b47K3MxFzvSHDLmG6zAxD+LxU7
         bHQRelArxBC352H+mz+h4Ps8k63WDU3+9t8oH84Yg7CzH0l4cVPxHuBd3PdTtJworaPQ
         oYNyh+mZAAbHvDOriUrob0PbOeeMj4LXXaiQhbq1UkzW4FRAEsgpyKDRFr20SmA//QvS
         Zh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RS6mknEQTv0B+SDtC7l0sxVbFfuhQYY4PR8F206MJTQ=;
        b=VUeClkMNrY2pQC4uEwd4U4WxW5zA26Q5ULjv3Xq6yEPX7YwSKVRarLM7dhD68siLmF
         j8wbvPUydnCQvVUs0YRZ08yPDBjfbyqtmZBwVihmsOumeMAV1qhHEIGwgU29XWijpzxZ
         Nnuwk6X6SATLhEBgu2YMrKWKjbD+6vO2ANtYkvdQ5D0D0+EzVbNRJFkC1S2FQII9ePPn
         wrdXicOLK8bjWKrYCdf92TTBADIY2otQVP49je67h79ZIca3dS+iXPq4fBpbZtEv0NDr
         xjhXKbM/TqML2VcuybNDJOpyTYnHqjGZ5PB0fJNOIvlaOP7YYadVoqfKlQWklO8Nkc5d
         fS3w==
X-Gm-Message-State: AFeK/H301xgn12Mmbit4K3zWuzF28GZtKImK9HqX0ayvn2L6Lakrj0f8HUGxhSaFPFvwcxlP
X-Received: by 10.99.122.22 with SMTP id v22mr10422709pgc.226.1489777738866;
        Fri, 17 Mar 2017 12:08:58 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:c001:d329:ba91:25ca])
        by smtp.gmail.com with ESMTPSA id i127sm18256415pfe.15.2017.03.17.12.08.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 12:08:57 -0700 (PDT)
Date:   Fri, 17 Mar 2017 12:08:56 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 2/5] setup: allow for prefix to be passed to git
 commands
Message-ID: <20170317190856.GC110341@google.com>
References: <20170314221100.24856-1-bmwill@google.com>
 <20170317172257.4690-1-bmwill@google.com>
 <20170317172257.4690-3-bmwill@google.com>
 <CAGZ79kZAZeb5rsL80dty_tRM5SDCAXVq_yATpDQREq_vV4Yj+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZAZeb5rsL80dty_tRM5SDCAXVq_yATpDQREq_vV4Yj+Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/17, Stefan Beller wrote:
> >         prefix = setup_git_directory_gently_1(nongit_ok);
> > +       env_prefix = getenv(GIT_TOPLEVEL_PREFIX_ENVIRONMENT);
> > +
> > +       if (env_prefix)
> > +               prefix = env_prefix;
> > +
> >         if (prefix)
> >                 setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
> 
> so we load that GIT_TOPLEVEL_PREFIX_ENVIRONMENT prefix
> first, such that we essentially copy it into GIT_PREFIX_ENVIRONMENT,
> such that e.g. aliased commands will know about the superprefix, too.

I don't follow, this doesn't have anything to do with super-prefix.

> 
> ok, sounds reasonable to me; though I do not use this feature,
> so my judgement is not as good.
> 
> Do we need a test for this behavior?
> 
> Thanks,
> Stefan

-- 
Brandon Williams
