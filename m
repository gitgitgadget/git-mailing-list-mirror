Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5158320188
	for <e@80x24.org>; Mon,  8 May 2017 03:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752061AbdEHDSy (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 23:18:54 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34286 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbdEHDSx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 23:18:53 -0400
Received: by mail-pg0-f68.google.com with SMTP id u187so8621200pgb.1
        for <git@vger.kernel.org>; Sun, 07 May 2017 20:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BHVZuajqpcL3bTRawioSHx+pzUu0s0TYM+ngFk5pqLQ=;
        b=bfw1D03YZZoPZbkgZK7tp+ttswx5DaWa9oNrngMGc1j4UKdBduNInvGNaDAkjTBamj
         ly7/w6xtogWJ+C9QgKYDd9uMQq8Y00BMe9P4D3+loMuJ5XdfF32X48W42dAC4egYjYKv
         n7jzZoAe+08Rt50n4YVZfK0TlowNLzxEDB3f2m2abswxhqy7Dwzyd5xuXDG9dRw8g1ms
         BHK4iOt52B1PEQD8JOWfvStmRBCPMxoMLB5jONrBv3kiJ215S7jxnPkevw43KOjueQsi
         uh7FtO+YOaOj0RSMwTO1VIFM13q4sTOFp3r+ERQSrWwPYVZmjECdakBgRN0k+TC993dr
         bknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BHVZuajqpcL3bTRawioSHx+pzUu0s0TYM+ngFk5pqLQ=;
        b=LmHsnXjhgG4L4WhVfmeoqqrgfpg39B6OYw4B7xsw9FksGDwUSonA9tixPXmwvz4E8c
         NAFrFh/P/W9FIk5Enuoyl0Xh3wbo3V+szKkBUJ1qDEPpaiLJjVv5Alk09L4+DxijvAkH
         47F4LkaZd3QiLJpOC/2Ng6OTkx8HfCigSfCE+01/99xxIe6Ag3lCa5gWZ4Hphd9G+Y1g
         obWvwXAHpi+OUGib72LFwVbpywdZSoJd4jzUQVVducK0SggO/VbNUzBEWR2eICEe2RmK
         fPlf11R5Lz341Y1biWzNHy5iwu0CYyO9j1hWqPBP6VApa4TFOO6GqginquFd6RaXfR4P
         qs/g==
X-Gm-Message-State: AN3rC/7TjqtxxWR+J7KfRWaDJWBK+h3Gbo7wJcU1w1/gOkwSUbCrUz1z
        E46eVZEFkndYTOKt
X-Received: by 10.98.214.90 with SMTP id r87mr18145150pfg.204.1494213532601;
        Sun, 07 May 2017 20:18:52 -0700 (PDT)
Received: from HP ([116.56.129.184])
        by smtp.gmail.com with ESMTPSA id d1sm19584107pfa.56.2017.05.07.20.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 May 2017 20:18:51 -0700 (PDT)
Date:   Mon, 8 May 2017 19:18:39 +0800
From:   Yubin Ruan <ablacktshirt@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] Add warning when git discard changes on another branch?
Message-ID: <20170508111836.GB3014@HP>
References: <20170507233512.GA9332@HP>
 <xmqqzieo9hfo.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzieo9hfo.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2017 at 12:05:31PM +0900, Junio C Hamano wrote:
> Yubin Ruan <ablacktshirt@gmail.com> writes:
> 
> > I think it would be better if git can warn use if we switch to another branch
> > without committing the modification. Git will warn if the modification is based
> > on a commit different from where the checkout happened.
> >
> > For example, say I am now on branch 'master' and all files *clean*. Now if I do:
> >     $ git checkout -b issue
> > and make some changes to a file:
> >     $ echo "modification on branch issue" >> lala.txt
> > and then switch back to branch 'master':
> >     $ git checkout master
> > and git can see the changes:
> >     $ git status
> >       On branch master
> >       Changes not staged for commit:
> >         (use "git add <file>..." to update what will be committed)
> >         (use "git checkout -- <file>..." to discard changes in working directory)
> >       
> >       	modified:   lala.txt
> >       
> >       no changes added to commit (use "git add" and/or "git commit -a")
> >       
> > Now, if I do "git checkout -- lala.txt", then I will lose that change on branch
> > 'issue' too!!! 
> 
> There may be a fundamental misunderstanding here.  In Git, changes
> you make in the working tree do *not* belong to any branch.  The
> request "git checkout -- lala.txt" you made in this step does *not*
> say "Hey, Git, these changes to lala.txt are not necessary in the
> 'master' branch".  It says "I started editing lala.txt, but it turns
> out that I do not need that change at all, anywhere, please remove
> it."

I understand this. I just suggest that git add some warning in case some users
are not aware of this, as it does when , on branch 'issue', changes to 'lala.txt'
are based on a commit different from where the checkout happened, i.e.
      
     on branch 'master'
         |
         |  <-- git checkout -b issue
          \
           \  <-- modification to git happened on a commit different from where
                  the checkout happened
 
in this situation, git would warn us something like this:
 
     error: Your local changes to the following files would be overwritten by checkout:
     	lala.txt
     Please, commit your changes or stash them before you can switch branches.
     Aborting

> If you meant the changes while you were on "issues" branch were not
> yet ready to be committed, but now you want to work on "master"
> branch without having to worry about these changes, "git stash" may
> be a useful tool.  Alternatively, you can just create a temporary
> commit while on "issues" branch before checking out "master" branch
> to work on something else, and when you are ready to continue
> working on the "issues" branch, check out "issues" branch and either
> (1) start with "reset HEAD^" or (2) just continue working on it and
> conclude with "commit --amend".
 
Nice suggestion though.

---
Yubin
