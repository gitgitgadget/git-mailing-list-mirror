Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45C7A1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 05:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeHRIca (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 04:32:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40169 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbeHRIca (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 04:32:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id e13-v6so4353087pff.7
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 22:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oka3LdxOP+90B7wBHM208JOlOHJouXfE3fx3/mKqPh4=;
        b=XetC79LerGeSoEL1q3ZJyjrBvk5aCBVhRS8aW1J7+aMO2qnBMpYCywCLdqH5XvefCC
         pZdadJw7m7Yx9PGPN1LqcKFXJW9bZZnd/cG5009D9vlczekBKl3mQ1jhj6cDJEgPNz2w
         UMBr0DyD3kGLuMm1/cJpxQhPTVM4B0EqwGdtbL5w3cILjyn69sS+n8JQZ5Pb84l+A79G
         vj8nQvffvKWES3KMCZkFia4L1dyuk5jNACnUr2eoat0ktn0iEN7v4LAynmZVTZMIdyco
         cuwkQfv/GTAG4xz/eMF9ldYHqHLJHSwWAzowtxmgTr4S9eEROoeEaZDKebZC8sHcstlo
         XvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oka3LdxOP+90B7wBHM208JOlOHJouXfE3fx3/mKqPh4=;
        b=WjZls0f5NBy/mkeZTfNnm1K3NyCwlYepUhWxVZY4QQeAisVZJBmTpIF86+kVX7zmJ9
         UkDkYzk5Cv+aNgnTFVRMUTF4JwqSZAfAoDo8Bw+sbPTZFPsQALWXxc/29SZ7O/bY9DcU
         teo6MfMHY7ycT+SeuOarkYfgyoqR6+tS3vDJGewTX28crpBkta0sNOkHCcwh2OEHnaJa
         evIx6yd4+NsWI03yQQbWF4BtILew6ULDB2On41YChbWxGLMgUMu0he6IL0Hi4qB8j2tG
         lrpidMLVfsBm1BR01qoeZi26k0sIOXMDFIIqF8FF9nfKrA8LkmUQWbofjD8F3ei4hman
         qiFA==
X-Gm-Message-State: AOUpUlFyICC+ctbkx1RWQiKI7dCbXt1VjMI7dfCtGRAdl7yjRNuzLXjo
        aOUFq9OhLCgvDEmwO6jVanMBQ5IK
X-Google-Smtp-Source: AA+uWPzlojPSHx1zxWp9plMoz7Pygt96DeUkcRLza7kuSodkcDps6vR8beiBTaCeeM7Kp67UOLzrZA==
X-Received: by 2002:a63:b349:: with SMTP id x9-v6mr35464203pgt.337.1534569968430;
        Fri, 17 Aug 2018 22:26:08 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a77-v6sm7726453pfj.38.2018.08.17.22.26.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 22:26:07 -0700 (PDT)
Date:   Fri, 17 Aug 2018 22:26:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] drop vcs-svn experiment
Message-ID: <20180818052605.GA241538@aiede.svl.corp.google.com>
References: <20180817190310.GA5360@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817190310.GA5360@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:

> The code in vcs-svn was started in 2010 as an attempt to
> build a remote-helper for interacting with svn repositories
> (as opposed to git-svn). However, we never got as far as
> shipping a mature remote helper, and the last substantive
> commit was e99d012a6bc in 2012.

I do use svn-fe occasionally, and have done so in the past few years.
That said, it's probably not worth keeping this in tree just for me.

> We do have a git-remote-testsvn, and it is even installed as
> part of "make install".

At a minimum, we should stop doing that.

[...]
> We also ship contrib/svn-fe, which builds on the vcs-svn
> work. However, it does not seem to build out of the box for
> me, as the link step misses some required libraries for
> using libgit.a.

What libraries do you mean?  It builds and runs fine for me with

 $ git diff
 diff --git i/contrib/svn-fe/Makefile w/contrib/svn-fe/Makefile
 index e8651aaf4b5..bd709f8d83b 100644
 --- i/contrib/svn-fe/Makefile
 +++ w/contrib/svn-fe/Makefile
 @@ -4,7 +4,7 @@ CC = cc
  RM = rm -f
  MV = mv
 
 -CFLAGS = -g -O2 -Wall
 +CFLAGS = -g -O2 -Wall -pthread
  LDFLAGS =
  EXTLIBS = -lz

which appears to be platform related, not due to some internal change
in Git.

[...]
> Of course, I could be completely wrong about people using this. Maybe
> svn-fe builds are just completely broken on my system, and maybe people
> really do use testsvn::. But if so, they certainly aren't talking about
> it on the mailing list. :)

My take:

 - svn-fe works fine and has been useful to me, though its Makefile
   could likely be simplified and made more user-friendly

 - I've benefited from the test coverage of having this in-tree

 - testsvn:: is a demo and at a minimum we ought not to install it
   with "make install"

 - keeping this in-tree for the benefit of just one user is excessive,
   so removing it is probably the right thing

 - it would be nice if the commit removing this code from Git includes
   a note to help people find its new home

Would you mind holding off until I'm able to arrange that last bit?

Thanks,
Jonathan
