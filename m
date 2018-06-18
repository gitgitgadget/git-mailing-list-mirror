Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 207F41F403
	for <e@80x24.org>; Mon, 18 Jun 2018 18:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935782AbeFRSMT (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 14:12:19 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:42688 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935533AbeFRSMS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 14:12:18 -0400
Received: by mail-pf0-f176.google.com with SMTP id w7-v6so8566671pfn.9
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 11:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VITL06KiAHy7/gZTKobo0qmHEpwvMisZN1UIM1iZg6Q=;
        b=YUuCgpv+pKqOsvrsrjzEyklNwQMoEuIDQep0/avq9heMyNKbXIhlv20wCKvR5QxI90
         wkJWSJw4jInzgYwaYCzD9tgoIU84IM9d7Cs6FUBRmHRK59YIBHG0YDKEDN/z9EsLi0kp
         AJ+bXF/BBHmAEbRQLEgQS9M7zjuXLt8mx3SK28189lsTNErZ5VkkkKoWCWEcVo+dksha
         /Twb6w6ZynUlhhlZeaGG9DmNsd0br0UtdLtxWzFAVfH3pXDYQQeZUOtSa73cclwec60C
         NdJ6uvT8QVOPki6HWgPYjQFaUZmsq7/nDtlphCWIQfV8E1FCVckHSLDpGKZAX+H8eq/i
         yvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VITL06KiAHy7/gZTKobo0qmHEpwvMisZN1UIM1iZg6Q=;
        b=K5GiVeW3o/idm52UycjkS7FpzYu75RbHxTqJAAs493rS0AoPFABCZCYB1M7cjamXdM
         Xrhu+vw4RuoQZWSCHtp7R3TPKXi/0e9HE1GFHrp2lj5fqAMQ3tob7fbQc4RT5jGKFeMw
         Y3LGPCLgJhexneaRx7ob0FaSsr9y1qV3odCnRAXSLn6QoOwejjsF1Xva8e0FTouU4qJg
         Wy0NjEFD4K2EsT2sBc40AkkSZtcNYLhRmIDc7mJjXBSkZ1rPK35KnmYYFnFoR0ZPYvmz
         VIMmwfRgtiVBUIpwVUelCaH3su3iLpG+8i2HA9iFe9gtzT85gydUPhcNW9GBboYLAhGs
         IN/Q==
X-Gm-Message-State: APt69E0I7iRwObVksb+7T9433+EWiXzEuBBP3XLq7DKeFiAIRc2mKMzm
        /fFAKJ3N7K0ryVgoDCmwkIjDQQ==
X-Google-Smtp-Source: ADUXVKKkXMRobGVIlV3ejt0sDjThxAqhIHxe6fWgkqqmbaTqMGYlxB/6EAhS2hErUOfXIgOgNN5w6A==
X-Received: by 2002:a63:2a11:: with SMTP id q17-v6mr11954186pgq.60.1529345537377;
        Mon, 18 Jun 2018 11:12:17 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id e17-v6sm33256201pfd.15.2018.06.18.11.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 11:12:16 -0700 (PDT)
Date:   Mon, 18 Jun 2018 11:12:15 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: Adding nested repository with slash adds files instead of gitlink
Message-ID: <20180618181215.GB73085@google.com>
References: <20180618111919.GA10085@book.hvoigt.net>
 <CACsJy8CJGditaq4CZfJctVAe9QCdapWQW=W--AumH-4RWWd=vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8CJGditaq4CZfJctVAe9QCdapWQW=W--AumH-4RWWd=vA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/18, Duy Nguyen wrote:
> On Mon, Jun 18, 2018 at 1:23 PM Heiko Voigt <hvoigt@hvoigt.net> wrote:
> >
> > Hi,
> >
> > I just discovered that when you have a slash at the end of a nested
> > repository, the files contained in the repository get added instead of
> > the gitlink.
> >
> > I found this when I was adding a submodule and wanted to commit a small
> > change before that. You get the slash by using tab autocompletion.
> >
> > Here is a recipe to reproduce:
> >
> > mkdir test
> > cd test; git init
> > touch a; git add a; git commit -m a
> > mkdir ../test.git; (cd ../test.git; git init --bare)
> > git remote add origin ../test.git
> > git push origin master
> > git submodule add ../test.git submodule
> > git reset
> > git add submodule/
> >
> > Now instead of just submodule gitlink there is an entry for submodule/a
> > in the index.
> >
> > I just thought I put this out there. Will have a look if I find the time
> > to cook up a proper testcase and investigate.
> 
> This sounds like the submodule specific code in pathspec.c, which has
> been replaced with something else in bw/pathspec-sans-the-index. If
> you have time, try a version without those changes (e.g. v2.13 or
> before) to see if it's a possible culprit.

I just tested this with v2.13 and saw the same issue.  I don't actually
think this ever worked in the way you want it to Heiko.  Maybe git add
needs to be taught to be more intelligent when trying to add a submodule
which doesn't exist in the index.

-- 
Brandon Williams
