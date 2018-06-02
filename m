Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA4C61F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 20:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750964AbeFBUqP (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 16:46:15 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:51890 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeFBUqO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 16:46:14 -0400
Received: by mail-wm0-f50.google.com with SMTP id r15-v6so8722553wmc.1
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 13:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+Jmm0tuj+ocHLCbuHIm5vdTurdAkA2Ue8iSxsScf/b0=;
        b=kPiKRx/5vhR1bcDmAxJy8zUafnyZi9mQJOP3P2ePpuIGQbEYjp//tnP0jgFzGEbB1y
         D07FCJmXlCJWECtkAornt0Qa/DsKXEzSSxZIoRbK3kwlEh/P2MEQiZ3A4b4d2eCr62nG
         6BG0p9SxDrJhgXGyziR64UcjZGIgufTcLuP1k5L35ia0LV4KmqwHgy7RulLktLassRiR
         j5S5eJ498BWzwDDaB4mk/Ga4LQqsxVS8fq9VQjqRjxzmxggIVJumElYrd9YxhKKMxGtb
         oa5qqazj3u1YxOLXMcN6wjOvnvFbonMfKhXIEEX7OGrjhA3fW/BXFeoQc2Pe2JoncWE4
         RN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+Jmm0tuj+ocHLCbuHIm5vdTurdAkA2Ue8iSxsScf/b0=;
        b=PEc3430mFqo5sgWxIRdR6tg3SmTgG9HN1mlJoBeMBqjCnFgncnl7J5efLkpiP/6f9k
         1okT4EtQBM3SeZ/42H+Mw6bETGSL7P5rSgiItl302aDEcEHRPryBHTNYbLTqOUarV85f
         AEz7bgwlWqv5mu3cBajhndE9z4qfMUT7Fhvt5UGK/DtXuCZWN2VfNbgyUwiMeLFZ9ns3
         /hpX/CKWgGIls0IWftAfgZipJ+CS1/VDTac6m9gD+DvuWIqgEF/Z7rrexIu+OaUJ6MsR
         ieouWq9yF2H3NYpqR6M9zuBqPxOJr5ipdjtmFcRu8UXwValHhVaMhbXJIbYJllcbIwwL
         77FA==
X-Gm-Message-State: APt69E1O8nIyj9S+PYijRCW/0VbmV3Cg6QF0j16HVaFIZxVqK27oqqaT
        o2HTFHqQCjG/eZyGur/Cvzn+KyeB
X-Google-Smtp-Source: ADUXVKLChvsrntluw2ZR+q+T8Qrof3Afg3ugrMtmajoKlNVe42N09lVKmUBBzQDLJPGzulCJWtTWQA==
X-Received: by 2002:a1c:3710:: with SMTP id e16-v6mr1678034wma.58.1527972373577;
        Sat, 02 Jun 2018 13:46:13 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id f133-v6sm5197148wme.42.2018.06.02.13.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Jun 2018 13:46:12 -0700 (PDT)
Date:   Sat, 2 Jun 2018 21:46:50 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: does a stash *need* any reference to the branch on which it was
 created?
Message-ID: <20180602204650.GE26159@hank.intra.tgummerer.com>
References: <alpine.LFD.2.21.1806021525120.19865@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LFD.2.21.1806021525120.19865@localhost.localdomain>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/02, Robert P. J. Day wrote:
> 
>   i realize that, when you "git stash push", stash graciously saves
> the branch you were on as part of the commit message, but does any
> subsequent stash operation technically *need* that branch name?

    $ git stash list
    stash@{0}: WIP on master: 4e5a9c0166 checkout & worktree: introduce checkout.defaultRemote
                      ^^^^^^

Do you mean this branch name?  If so, no, afaik nothing in git stash
needs that.  It's merely a convenience for the user so they know which
branch the stash was based on.

>   it doesn't seem like it -- even "git stash branch" really only needs
> the commit that was the basis of that stash to create the new branch.

Correct, and it knows that by checking the parents of the stash (note
that a stash is represented internally as just a commit):

    $ git cat-file commit stash@{0}                                                                                                                                                                          ∞
    tree 9fc2608506404bebdeb0aea54e8c76944ae88a1a
    parent 4e5a9c01669919bcc2452e8e2491ee31dbf647fc
    parent 9e457faad129f832ce0070dcfd1f4cfd3f322df3
    author Thomas Gummerer <t.gummerer@gmail.com> 1527971565 +0100
    committer Thomas Gummerer <t.gummerer@gmail.com> 1527971565 +0100

    WIP on master: 4e5a9c0166 checkout & worktree: introduce checkout.defaultRemote

The first parent here is the commit the stash is based on, so that's
what 'git stash branch' is using to base the new branch on.

>   so, does any stash operation actually need the originating branch
> name? (i'm guessing no, but i've been wrong before.)
> 
> rday
> 
> -- 
> 
> ========================================================================
> Robert P. J. Day                                 Ottawa, Ontario, CANADA
>                   http://crashcourse.ca/dokuwiki
> 
> Twitter:                                       http://twitter.com/rpjday
> LinkedIn:                               http://ca.linkedin.com/in/rpjday
> ========================================================================
