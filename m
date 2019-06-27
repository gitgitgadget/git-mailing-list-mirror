Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B53591F461
	for <e@80x24.org>; Thu, 27 Jun 2019 20:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfF0Uyq (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 16:54:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39925 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfF0Uyq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 16:54:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id 196so1552677pgc.6
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 13:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s9xM9KZBEH0/nGPS70prmKf444Q7R0rbvnmgrosbxqU=;
        b=piZ3DTR5Cn7ArSN0lIn8tArpxjLk4in81hU/bttR7MPDkWwQiDq+uTbG8z371KxIUk
         YiwJgz+nKkJBHXF6Z5ONXd9xrGrgyN44pNexd5/E3E/8qFtjs4HyiC1oH1fZBRNpohSL
         mOjJnt11MFrBj6pUyPsMdeE+t2UOTZ7HeV3BvRc9cI35BXVpRZRbMY+gSAL8kyPA12+Y
         yzRKYSJKcBtEvclcYmKYz5/joLLn40ROtb0N1RANGdxOfQZqGuEEqLKU7LC9oiBd5R3y
         qofMe57ldUw8UIQKmqYwkfATe6tUD4TWl8uC4stS8267lHwtuNnLmoqlspYCZKLa/+eg
         7Mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s9xM9KZBEH0/nGPS70prmKf444Q7R0rbvnmgrosbxqU=;
        b=Bz6e8SCYoem4CAM89AUx6upMpFI6AXAPi+9EOc4HLS1flV/3qqTu0i4uuMYV/U2FtY
         wKlIeqGYL3AetaO8xhkmiy8H5xBIHuZpXm+K+b3BnnCWKoOtP7vOKqsAh26VJz9ntRDs
         jhYj3E2m6uarZvFLi3cuJp3JsoApabX5H79QVffqXazt4qYHVBXYX6V4inVhD2ix8xmr
         4g+r6qqwY4HMjkpYN/xhqLqQW0AnSi110ADtD5fmLkknrLukAqXnFWLbwJbR2UpxDeUT
         s8z02kKhSfEQofe6pToEcAUd1qGn/jH/EEgXKa+oJK1JB4WRg2wh2x1VUHa+4N38LPGe
         wmVA==
X-Gm-Message-State: APjAAAU1yIQWuFbp253Q3t4Y9P9xC6a53CI2iYoieUzpyV1Ay0kbzB8j
        IZzxsHGOZrk3sopekx+xr4DBjz00eY8=
X-Google-Smtp-Source: APXvYqwiCdetYwzXbiQ/lj40I2d4MYtcaDk+bm6OvKVFjQd9Ip5shmJq45TBCE7JnqqTHYrbWmI2Yw==
X-Received: by 2002:a63:e001:: with SMTP id e1mr5721104pgh.306.1561668884706;
        Thu, 27 Jun 2019 13:54:44 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id n1sm53184pgv.15.2019.06.27.13.54.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 13:54:44 -0700 (PDT)
Date:   Thu, 27 Jun 2019 13:54:39 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [RFC PATCH v2 06/13] walken: perform our basic revision walk
Message-ID: <20190627205439.GD245941@google.com>
References: <20190626235032.177551-1-emilyshaffer@google.com>
 <20190626235032.177551-7-emilyshaffer@google.com>
 <CAPig+cQAf6ds6Fobcf+mux-93D09WQJACUXSvwgdyoOznNjsUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQAf6ds6Fobcf+mux-93D09WQJACUXSvwgdyoOznNjsUg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 01:16:58AM -0400, Eric Sunshine wrote:
> On Wed, Jun 26, 2019 at 7:51 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> > Add the final steps needed and implement the walk loop itself. We add a
> > method walken_commit_walk() which performs the final setup to revision.c
> > and then iterates over commits from get_revision().
> > [...]
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> > diff --git a/builtin/walken.c b/builtin/walken.c
> > +/*
> > + * walken_commit_walk() is invoked by cmd_walken() after initialization. It
> > + * does the commit walk only.
> > + */
> 
> "only" as opposed to what? Maybe just say:
> 
>     ... after initialization. It performs the actual commit walk.

Done.

> 
> > +static void walken_commit_walk(struct rev_info *rev)
> > +{
> > +       struct commit *commit;
> > +       struct strbuf prettybuf = STRBUF_INIT;
> > +
> > +       /*
> > +         * prepare_revision_walk() gets the final steps ready for a revision
> > +        * walk. We check the return value for errors.
> > +         */
> 
> You have some funky mix of spaces and tabs indenting the comment
> lines. Same for the next comment block.

Done.

> 
> > +       if (prepare_revision_walk(rev)) {
> > +               die(_("revision walk setup failed"));
> > +       }
> > +
> > +       /*
> > +         * Now we can start the real commit walk. get_revision grabs the next
> > +        * revision based on the contents of rev.
> > +        */
> 
> s/get_revision/&()/

Done.

> 
> > +       rev->diffopt.close_file = 0;
> 
> Why this? And, why isn't it set up where other 'rev' options are initialized?

Removed. Artifact of closely mirroring log.

> 
> > +       while ((commit = get_revision(rev))) {
> > +               if (!commit)
> > +                       continue;
> 
> If get_revision() returns NULL, then the while-loop exits, which means
> that the "if (!commit)" condition will never be satisfied, thus is
> unnecessary code.

Yep, removed.

> 
> > +               strbuf_reset(&prettybuf);
> > +               pp_commit_easy(CMIT_FMT_ONELINE, commit, &prettybuf);
> > +               /*
> > +                * We expect this part of the output to be machine-parseable -
> > +                * one commit message per line - so we must not localize it.
> > +                */
> > +               puts(prettybuf.buf);
> 
> Meh, but there isn't any literal text here to localize anyway, so the
> comment talking about not localizing it is just confusing.

Yeah, you're right. I'll change to "so we send it to stdout", which is
less obvious from puts().

> 
> > +       }
> 
> Leaking 'prettybuf'. Add here:
> 
>     strbuf_release(&prettybuf);

Thanks, done.
