Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 082D81F51C
	for <e@80x24.org>; Sun, 27 May 2018 10:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032668AbeE0KY0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 06:24:26 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:40808 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032657AbeE0KYW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 06:24:22 -0400
Received: by mail-wr0-f180.google.com with SMTP id l41-v6so15826405wre.7
        for <git@vger.kernel.org>; Sun, 27 May 2018 03:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ruknopEvC5gEDkf8HSPA25/r3Re4+DMSeHeTvw0EbLs=;
        b=VjDnAwdqTDZmafcrvZlpKNdsVM6yq8p11NrQ4m4OUhnvh8jwBIJ95qu0nxqzoHZPnB
         bdWEaeB+5hJoGAMGj5kCNeeL+RsGAN15XaJF31QWNNRN0RmW9i0kDAow55FbQHdsA8B+
         S8wmGqj0nfPTm/wQ51Bjra9i5DxWZlBDwJd5Aespebx2GggawtCJUbvEV5aLbET5BMSD
         NjKwCMvEi0UNMSupSKa7C/IRucsaO4dgDtvSaJ+s8LhGvbja7G9cpPgHm82lNY4EnXWd
         BpZgDgDlZM94k2TITOqqby7WeJg1HkxO6bjwU7P+cV3gkTZE3ACtPp0K6SK4SC6KCqi7
         VO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ruknopEvC5gEDkf8HSPA25/r3Re4+DMSeHeTvw0EbLs=;
        b=brjM5MK62SgflYfT9LpKAMNXnDCL0SKv3oRO469U5K/S/a/7mAzWF+kh79GT6QJYau
         Ql2uMFW/3klRbST2bSFVlxIDOkFwhEIfiluIvtQvqGxFWX4SthDia6h3fk/s6ij6RVEy
         XrgTzkWl5wyTYm/3GmUOlq4WhHmzwitqOs+QgHkkYR7AJoC2PKcYeYICfVWJryldE93L
         cQ+I1Jf3AFyuvQZa6EiLcFOPfUNXSBY0GLis2GRTgNctIhp+LOIYqfaht+LU4OvZcUSM
         8It8u5xzLfK0E7Jk7c6oeMmp7fVs/f6UGSVLeJCnm8O+noZdBVjKoXJ2LpVa5xbS3W7D
         E+JQ==
X-Gm-Message-State: ALKqPweXLd0L+GOnX4frew5iBilA5ViBnv/oCW5+Rz2lSI/Y3XmZcWmy
        zlBE67LOqXHyULdQqbq1FtE=
X-Google-Smtp-Source: AB8JxZpjHeWd0TEKVBniYZUfaLk0WDA+J0qxFOpcHPNdwsE+j9LpG41A0kiMM+BGx/we27ZK3i1sFg==
X-Received: by 2002:adf:8607:: with SMTP id 7-v6mr7019135wrv.255.1527416661295;
        Sun, 27 May 2018 03:24:21 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id m134-v6sm11313541wmg.13.2018.05.27.03.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 May 2018 03:24:19 -0700 (PDT)
Date:   Sun, 27 May 2018 11:24:52 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: why do "git log -h" and "git show -h" print the same thing?
Message-ID: <20180527102452.GA8868@hank.intra.tgummerer.com>
References: <alpine.LFD.2.21.1805240934010.12018@localhost.localdomain>
 <CAGZ79kY8CjLsTqY2YXJ8hPA41XrbYZrtK7yO59vrbA5M_vorVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kY8CjLsTqY2YXJ8hPA41XrbYZrtK7yO59vrbA5M_vorVg@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/24, Stefan Beller wrote:
> On Thu, May 24, 2018 at 6:37 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >
> >   maybe this is deliberate, but it's confusing that, with git 2.17.0,
> > the output of both "git log -h" and "git show -h" is exactly the same:
> >
> > $ git log -h
> > usage: git log [<options>] [<revision-range>] [[--] <path>...]
> >    or: git show [<options>] <object>...
> >
> >     -q, --quiet           suppress diff output
> >     --source              show source
> >     --use-mailmap         Use mail map file
> >     --decorate-refs <pattern>
> >                           only decorate refs that match <pattern>
> >     --decorate-refs-exclude <pattern>
> >                           do not decorate refs that match <pattern>
> >     --decorate[=...]      decorate options
> >     -L <n,m:file>         Process line range n,m in file, counting from 1
> > $
> >
> > is that what's *supposed* to happen?
> 
> I would think so, show is just "log -p" with the range clamped
> down to <object>^..<object>.

Hmm, that's not true though if the object is not a commit, from my
understanding?  While 'git show' does share some of its code with 'git
log', what you get as output may be quite different from what you'd
get with 'git log'.  So I feel like we're leaking an implementation
detail to the user here, and I can see how it is confusing especially
for new users.

So I do feel like there's some room for improvement here, by only
showing the help for the command that was actually used.  I would
welcome a patch to that extend, but obviously I'm not the authority
here :)

> It's been in the code like that for a couple years by now,
> e.g. see
> e66dc0cc4b1a6 log.c: fix translation markings, 2015-01-06
