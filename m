Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81B371FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 19:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757512AbdJKTLW (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 15:11:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33471 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752123AbdJKTLV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 15:11:21 -0400
Received: by mail-wm0-f66.google.com with SMTP id u138so2791384wmu.0
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 12:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZQ1wi9MJKKuR9XZTlCCEZulqvXX6SLZAQZU53+Lx0pY=;
        b=QOlpewBDm2Ayrkwy4XXk0OwKlVWMXhLWDANuaE0GRgVbDedlzgSoaL/03+bpSViwka
         Ya8/xsTsZN1MbFAE3eC0A7PUHaCUsUg4XYhQx6JA+/QRCFPMxaGVIUxwZaVJjT+IU6o6
         4b6ZUePz63KUrnMr5OBdho3AvSwLi+bwoCIIcOg30ePGGANjAzG9rhT4bfvOd8ziy/eq
         /Swls95+z+vAE5XtAcqakK9q/4eYYZRzKXCiW3Wd04FkkBe4NyG9EIUcWno7X/G3XMYj
         RwxS0MRHWN6p339fYf4wC4fKYHjU3bTUDxaxvSghHE01B4/V2+/rF7toPZYD53KVPDrJ
         Wtww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZQ1wi9MJKKuR9XZTlCCEZulqvXX6SLZAQZU53+Lx0pY=;
        b=UvLGbf/4zLRucjx2j6OQAuc/2e8GjvTsFENcfJSrqPY/WkVrEGMSF6+lewIGEDqLu2
         HcTcFFz0i1XzM8EgzROih2y9/cZSDP9rqqpJ8dau6jhW7kHKWzO0uEqsj9LV8oq6WrUJ
         pzhwCVKmghYYwJhyuX2MBTB2tsrnf3RD/OtR6AicvZFGeEXOsoTkbBidfzOOj9Oz0gnt
         gvoBMnLF5VTIeezPd85pSYNsAPSEDoRhdu2D5qfdEhzu46ucTrhCbsh8OIeP/X10fIj+
         HHFGtckjEE5f1WsDHdWVy4FYDal5rozogUva793E4l+gG8+JDI7qd8r+eGqMPWW7JJaL
         dHQg==
X-Gm-Message-State: AMCzsaVGJQkmZxALIqEqKZOVdeOIz43QunWj+npUYecEsL8wVQDeJkJX
        HZpGYtJ0G1ReX3io2zOkjzs=
X-Google-Smtp-Source: AOwi7QBmwB3GRMJ9q/VhZ3BpOcUpmRZq5buk7BvPdwfT7EB0zzjTJLhVwbto7+qxoGubFwzLJXGqdw==
X-Received: by 10.223.157.136 with SMTP id p8mr42668wre.28.1507749079922;
        Wed, 11 Oct 2017 12:11:19 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id r44sm21796928wrb.37.2017.10.11.12.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Oct 2017 12:11:19 -0700 (PDT)
Date:   Wed, 11 Oct 2017 20:12:14 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Takahito Ogawa <aiueogawa217@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] git-stash.txt: correct "git stash" behavior with no
 arguments
Message-ID: <20171011191214.GB15399@hank>
References: <n>
 <20171011183718.2404-1-aiueogawa217@gmail.com>
 <20171011190935.GA15399@hank>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171011190935.GA15399@hank>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/11, Thomas Gummerer wrote:
> On 10/12, Takahito Ogawa wrote:
> > "git stash" behavior without any arguments was changed in
> > 1ada5020b ("stash: use stash_push for no verb form", 2017-02-28).
> > This is equivalent to "git stash push" but documents says
> > "git stash save".
> > 
> > Correct it.
> 
> Thanks for fixing this!  I recently sent a patch that would advertise
> git stash push more in general, which would also fix this occurrence [1], 
> but it didn't seem like it got much interest.  However this is
> obviously correct, and should definitely be fixed, while the other
> places can still mention 'git stash save'.
> 
> For what it's worth this is
> 
> Reviewed-by: Thomas Gummerer <t.gummerer@gmail.com>

And I forgot to include the link, sorry.  Here it is:

[1]: https://public-inbox.org/git/20171005200049.GF30301@hank/

> 
> > Signed-off-by: Takahito Ogawa <aiueogawa217@gmail.com>
> > ---
> >  Documentation/git-stash.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> > index 00f95fee1..63642c145 100644
> > --- a/Documentation/git-stash.txt
> > +++ b/Documentation/git-stash.txt
> > @@ -33,7 +33,7 @@ and reverts the working directory to match the `HEAD` commit.
> >  The modifications stashed away by this command can be listed with
> >  `git stash list`, inspected with `git stash show`, and restored
> >  (potentially on top of a different commit) with `git stash apply`.
> > -Calling `git stash` without any arguments is equivalent to `git stash save`.
> > +Calling `git stash` without any arguments is equivalent to `git stash push`.
> >  A stash is by default listed as "WIP on 'branchname' ...", but
> >  you can give a more descriptive message on the command line when
> >  you create one.
> > -- 
> > 2.13.1
> > 
